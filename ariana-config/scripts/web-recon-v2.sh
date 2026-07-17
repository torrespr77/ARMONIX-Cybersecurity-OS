#!/bin/bash
# ============================================
# web-recon-v2.sh - Automated Web Reconnaissance + SOCMINT
# BRIDA IT Services - Ariana 💜🔐
# ============================================
# Usage: ./web-recon-v2.sh <target-domain> [output-dir] [options]
# Example: ./web-recon-v2.sh example.com ~/recon/example.com --full --social "ceo_username" --social-email "ceo@company.com"
# ============================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Global variables
TARGET=""
OUTPUT_DIR=""
FULL=false
SUBS_ONLY=false
HTTP_ONLY=false
NUCLEI_ONLY=false
DIRS_ONLY=false
WAYBACK=false
NO_NUCLEI=false
NO_DIRS=false
SOCIAL_ONLY=false
SOCIAL_USERNAME=""
SOCIAL_EMAIL=""
STEALTH=false
THREADS=50
RATE=150
WAF_DETECTED=false

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1" >&2; }
log_success() { echo -e "${GREEN}[✓]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1" >&2; }
log_error() { echo -e "${RED}[✗]${NC} $1" >&2; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1" >&2; }
log_debug() { [[ "${DEBUG:-false}" == "true" ]] && echo -e "${PURPLE}[DEBUG]${NC} $1" >&2; }

# Banner
print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          🕷️  WEB RECON v2.0 + SOCMINT - BRIDA IT  🕷️        ║"
    echo "║                    Ariana - 2026                            ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Help
show_help() {
    cat << EOF
Usage: $0 <target-domain> [output-dir] [OPTIONS]

ARGUMENTS:
  target-domain    Domain to recon (e.g., example.com)
  output-dir       Output directory (default: ~/recon/<domain>)

RECON MODES:
  --full           Run all modules (subs, httpx, nuclei, dirs, wayback, social)
  --subs-only      Only subdomain enumeration (passive OSINT)
  --http-only      Only HTTP probing (requires existing subdomains.txt)
  --nuclei-only    Only Nuclei scanning (requires existing live.txt)
  --dirs-only      Only directory brute-force (requires existing live.txt)
  --wayback        Include Wayback URLs gathering
  --social-only    Only social media OSINT (requires --social or --social-email)
  --social <username>    Username to search across social networks
  --social-email <email> Email to check across platforms (Holehe)

MODIFIERS:
  --no-nuclei      Skip Nuclei scanning
  --no-dirs        Skip directory brute-force
  --stealth        Stealth mode: random delays, UA rotation, packet fragmentation
  --threads N      Threads for ffuf/gobuster/nuclei (default: 50)
  --rate N         Rate limit for httpx/nuclei (default: 150)

EXAMPLES:
  $0 example.com                           # Basic: subs + httpx + nuclei + dirs
  $0 example.com --full --wayback          # Full recon + historical URLs
  $0 example.com --social "john_doe"       # Social media username search
  $0 example.com --social-email "john@company.com"  # Email exposure check
  $0 example.com --full --social "ceo" --social-email "ceo@company.com"  # Complete
  $0 example.com --subs-only --stealth     # Passive only, stealthy
  $0 example.com ~/myrecon --full --stealth --threads 30 --rate 50

TOOLS REQUIRED:
  Core: subfinder, assetfinder, amass, httpx, nuclei, ffuf/gobuster, waybackurls, naabu
  Social: theharvester, sherlock, holehe, maigret, linkedin2username
  Wordlists: SecLists (auto-downloaded if missing)
EOF
}

# Check required tools
check_tools() {
    local required=("subfinder" "assetfinder" "amass" "httpx" "nuclei" "naabu")
    local missing=()
    
    for tool in "${required[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            missing+=("$tool")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_warn "Missing core tools: ${missing[*]}"
        log_warn "Install with:"
        for tool in "${missing[@]}"; do
            case $tool in
                subfinder) echo "  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest" ;;
                assetfinder) echo "  go install github.com/tomnomnom/assetfinder@latest" ;;
                amass) echo "  go install -v github.com/owasp-amass/amass/v4/...@latest" ;;
                httpx) echo "  go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest" ;;
                nuclei) echo "  go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest" ;;
                naabu) echo "  go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest" ;;
            esac
        done
    fi
    
    # Check dir tools
    if ! command -v ffuf &>/dev/null && ! command -v gobuster &>/dev/null; then
        log_warn "Neither ffuf nor gobuster found - directory brute-force will be skipped"
    fi
    
    if ! command -v waybackurls &>/dev/null; then
        log_info "waybackurls not found - install with: go install github.com/tomnomnom/waybackurls@latest"
    fi
    
    # Check social tools
    local social_tools=("theharvester" "sherlock" "holehe" "maigret")
    local missing_social=()
    for tool in "${social_tools[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            missing_social+=("$tool")
        fi
    done
    if [[ ${#missing_social[@]} -gt 0 ]]; then
        log_warn "Missing social tools: ${missing_social[*]}"
        log_warn "Install: pipx install sherlock-project holehe maigret && uv pip install theharvester"
    fi
    
    # Check wordlists
    ensure_wordlists
}

# Ensure wordlists exist
ensure_wordlists() {
    local wordlist_dir="$HOME/tools/wordlists"
    mkdir -p "$wordlist_dir"
    
    # SecLists
    if [[ ! -d "$wordlist_dir/SecLists" ]]; then
        log_info "Downloading SecLists..."
        git clone --depth 1 https://github.com/danielmiessler/SecLists.git "$wordlist_dir/SecLists" 2>/dev/null || log_warn "SecLists clone failed"
    fi
    
    # raft
    if [[ ! -d "$wordlist_dir/raft" ]]; then
        log_info "Downloading raft wordlists..."
        git clone --depth 1 https://github.com/danielmiessler/raft.git "$wordlist_dir/raft" 2>/dev/null || log_warn "raft clone failed"
    fi
    
    # fuzzdb
    if [[ ! -d "$wordlist_dir/fuzzdb" ]]; then
        log_info "Downloading fuzzdb..."
        git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb.git "$wordlist_dir/fuzzdb" 2>/dev/null || log_warn "fuzzdb clone failed"
    fi
}

# WAF detection
detect_waf() {
    local url="$1"
    log_info "Detecting WAF on $url..."
    
    # Quick WAF detection with wafw00f if available
    if command -v wafw00f &>/dev/null; then
        wafw00f "$url" -a 2>/dev/null | grep -q "WAF" && WAF_DETECTED=true
    fi
    
    # Fallback: check headers for common WAF signatures
    if [[ "$WAF_DETECTED" == "false" ]]; then
        local headers=$(curl -sI "$url" 2>/dev/null | tr '[:upper:]' '[:lower:]')
        if echo "$headers" | grep -qE "cloudflare|akamai|incapsula|sucuri|f5|barracuda|fortiweb|imperva|mod_security|aws|shield"; then
            WAF_DETECTED=true
            log_warn "WAF detected via headers"
        fi
    fi
    
    if [[ "$WAF_DETECTED" == "true" ]]; then
        log_warn "WAF detected - enabling adaptive rate limiting"
        RATE=$((RATE / 3))
        THREADS=$((THREADS / 2))
        log_info "Adjusted rate: $RATE, threads: $THREADS"
    fi
}

# Stealth delay
stealth_delay() {
    if [[ "$STEALTH" == "true" ]]; then
        local delay=$((RANDOM % 3 + 1))
        sleep "$delay"
    fi
}

# Rotate user agent
get_random_ua() {
    local uas=(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/115.0"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/115.0"
    )
    echo "${uas[$RANDOM % ${#uas[@]}]}"
}

# ============================================
# MODULE 1: SUBDOMAIN ENUMERATION (PASSIVE)
# ============================================
run_subdomain_enum() {
    log_step "1/7 - Subdomain Enumeration (Passive OSINT)"
    
    local subs_file="$OUTPUT_DIR/subdomains/all-subdomains.txt"
    local tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" RETURN
    
    log_info "Running subfinder..."
    subfinder -d "$TARGET" -silent -o "$tmp_dir/subfinder.txt" 2>>"$OUTPUT_DIR/logs/subfinder.log" || true
    log_success "subfinder: $(wc -l < "$tmp_dir/subfinder.txt" 2>/dev/null || echo 0) subdomains"
    stealth_delay
    
    log_info "Running assetfinder..."
    assetfinder --subs-only "$TARGET" > "$tmp_dir/assetfinder.txt" 2>>"$OUTPUT_DIR/logs/assetfinder.log" || true
    log_success "assetfinder: $(wc -l < "$tmp_dir/assetfinder.txt" 2>/dev/null || echo 0) subdomains"
    stealth_delay
    
    log_info "Running amass (passive, 5min timeout)..."
    timeout 300 amass enum -passive -d "$TARGET" -dir "$tmp_dir" -silent 2>>"$OUTPUT_DIR/logs/amass.log" || true
    # Amass outputs to subdomains.txt in the dir
    if [[ -f "$tmp_dir/subdomains.txt" ]]; then
        cp "$tmp_dir/subdomains.txt" "$tmp_dir/amass.txt"
    else
        touch "$tmp_dir/amass.txt"
    fi
    log_success "amass: $(wc -l < "$tmp_dir/amass.txt" 2>/dev/null || echo 0) subdomains"
    stealth_delay
    
    # Combine and deduplicate
    # Ensure subdomains directory exists
    mkdir -p "$OUTPUT_DIR/subdomains"
    # Only concatenate the tool output files (not log files)
    cat "$tmp_dir"/subfinder.txt "$tmp_dir"/assetfinder.txt "$tmp_dir"/amass.txt 2>/dev/null | sort -u | grep -E "^[a-zA-Z0-9.-]+\\.$TARGET$" > "$subs_file" || true
    
    local total=$(wc -l < "$subs_file" 2>/dev/null || echo 0)
    log_success "Total unique subdomains: ${GREEN}$total${NC}"
    
    if [[ $total -eq 0 ]]; then
        log_error "No subdomains found. Exiting."
        exit 1
    fi
    
    # Return the known file path (no command substitution needed)
    printf "%s\n" "$subs_file"
}

# ============================================
# MODULE 2: PORT SCANNING (naabu)
# ============================================
run_port_scan() {
    log_step "2/7 - Port Scanning (naabu)"
    
    local subs_file="$1"
    local ports_file="$OUTPUT_DIR/network/open-ports.txt"
    local json_file="$OUTPUT_DIR/network/open-ports.json"
    
    log_info "Running naabu on subdomains (top 100 ports)..."
    naabu -list "$subs_file" -top-ports 100 -silent -json -o "$json_file" 2>>"$OUTPUT_DIR/logs/naabu.log" || true
    
    # Extract host:port for httpx
    if [[ -f "$json_file" && -s "$json_file" ]]; then
        jq -r '.host + ":" + (.port | tostring)' "$json_file" 2>/dev/null | sort -u > "$ports_file" || true
        # Also create host-only for httpx
        cut -d: -f1 "$ports_file" | sort -u > "$OUTPUT_DIR/network/live-hosts.txt"
    else
        # Fallback: use subdomains directly
        cp "$subs_file" "$OUTPUT_DIR/network/live-hosts.txt"
    fi
    
    # Ensure live-hosts.txt exists and has content
    if [[ ! -f "$OUTPUT_DIR/network/live-hosts.txt" || ! -s "$OUTPUT_DIR/network/live-hosts.txt" ]]; then
        cp "$subs_file" "$OUTPUT_DIR/network/live-hosts.txt"
    fi
    
    local count=$(wc -l < "$ports_file" 2>/dev/null || echo 0)
    log_success "Open ports found: ${GREEN}$count${NC}"
    stealth_delay
    
    echo "$OUTPUT_DIR/network/live-hosts.txt"
}

# ============================================
# MODULE 3: HTTP PROBING
# ============================================
run_http_probe() {
    local hosts_file="$1"
    log_step "3/7 - HTTP Probing (httpx)"
    
    local live_file="$OUTPUT_DIR/http/live.txt"
    local json_file="$OUTPUT_DIR/http/live.json"
    
    # Detect WAF on first host
    local first_host=$(head -1 "$hosts_file")
    if [[ -n "$first_host" ]]; then
        detect_waf "https://$first_host"
    fi
    
    local ua=$(get_random_ua)
        httpx -l "$hosts_file" \
            -silent \
            -status-code \
            -title \
            -tech-detect \
            -cdn \
            -ip \
            -server \
            -content-length \
            -o "$live_file" \
            -rate-limit "$RATE" \
            -threads "$THREADS" \
            -timeout 10 \
            -retries 2 \
            -H "User-Agent: $ua" \
            2>>"$OUTPUT_DIR/logs/httpx.log" || true

        # JSON output
        httpx -l "$hosts_file" \
            -silent \
            -status-code \
            -title \
            -tech-detect \
            -cdn \
            -ip \
            -server \
            -content-length \
            -json \
            -o "$json_file" \
            -rate-limit "$RATE" \
            -threads "$THREADS" \
            -timeout 10 \
            -retries 2 \
            -H "User-Agent: $ua" \
            2>>"$OUTPUT_DIR/logs/httpx.log" || true
    
    local live_count=$(wc -l < "$live_file" 2>/dev/null || echo 0)
    log_success "Live hosts: ${GREEN}$live_count${NC}"
    
    # Extract URLs for next steps
    cut -d' ' -f1 "$live_file" | sort -u > "$OUTPUT_DIR/http/urls.txt" 2>/dev/null || true
    stealth_delay
    
    echo "$OUTPUT_DIR/http/urls.txt"
}

# ============================================
# MODULE 4: NUCLEI VULNERABILITY SCANNING
# ============================================
run_nuclei_scan() {
    local urls_file="$1"
    
    if [[ "$NO_NUCLEI" == true ]]; then
        log_warn "Skipping Nuclei (--no-nuclei)"
        return
    fi
    
    log_step "4/7 - Nuclei Vulnerability Scanning"
    
    local out_dir="$OUTPUT_DIR/nuclei"
    
    log_info "Updating Nuclei templates..."
    nuclei -update-templates -silent 2>>"$OUTPUT_DIR/logs/nuclei-update.log" || true
    
    local total=0
    for severity in critical high medium low info; do
        log_info "Scanning $severity severity..."
        nuclei -l "$urls_file" \
            -severity "$severity" \
            -silent \
            -rate-limit "$RATE" \
            -concurrency "$THREADS" \
            -timeout 10 \
            -retries 1 \
            -o "$out_dir/nuclei-$severity.txt" \
            -json-export "$out_dir/nuclei-$severity.json" \
            2>>"$OUTPUT_DIR/logs/nuclei-$severity.log" || true
        
        local count=$(wc -l < "$out_dir/nuclei-$severity.txt" 2>/dev/null || echo 0)
        total=$((total + count))
        
        if [[ $count -gt 0 ]]; then
            log_warn "$severity findings: ${RED}$count${NC}"
        else
            log_success "$severity: clean"
        fi
        stealth_delay
    done
    
    log_success "Total Nuclei findings: ${GREEN}$total${NC}"
}

# ============================================
# MODULE 5: DIRECTORY BRUTE-FORCE
# ============================================
run_dir_bruteforce() {
    local urls_file="$1"
    
    if [[ "$NO_DIRS" == true ]]; then
        log_warn "Skipping directory brute-force (--no-dirs)"
        return
    fi
    
    log_step "5/7 - Directory Brute-Force"
    
    local out_dir="$OUTPUT_DIR/dirs"
    local wordlist="/usr/share/wordlists/SecLists/Discovery/Web-Content/raft-medium-directories.txt"
    
    # Fallback wordlists
    [[ ! -f "$wordlist" ]] && wordlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
    [[ ! -f "$wordlist" ]] && wordlist="/usr/share/wordlists/dirb/common.txt"
    [[ ! -f "$wordlist" ]] && wordlist="/usr/share/wordlists/raft-medium-directories.txt"
    
    log_info "Using wordlist: $wordlist"
    
    local count=0
    while IFS= read -r url; do
        [[ -z "$url" ]] && continue
        count=$((count + 1))
        local host=$(echo "$url" | sed -E 's|^https?://||' | sed 's|/.*||')
        local outfile="$out_dir/${host//./_}.txt"
        
        log_info "[$count] Scanning: $url"
        
        local ua=$(get_random_ua)
        if command -v ffuf &>/dev/null; then
            ffuf -u "$url/FUZZ" \
                -w "$wordlist" \
                -mc 200,204,301,302,307,401,403,405,500 \
                -t "$THREADS" \
                -timeout 10 \
                -silent \
                -o "$outfile" \
                -of csv \
                -H "User-Agent: $ua" \
                2>>"$OUTPUT_DIR/logs/ffuf-$host.log" || true
        elif command -v gobuster &>/dev/null; then
            gobuster dir -u "$url" \
                -w "$wordlist" \
                -t "$THREADS" \
                -timeout 10s \
                -q \
                -o "$outfile" \
                -H "User-Agent: $ua" \
                2>>"$OUTPUT_DIR/logs/gobuster-$host.log" || true
        fi
        
        local found=$(wc -l < "$outfile" 2>/dev/null || echo 0)
        [[ $found -gt 0 ]] && log_warn "  Found: $found paths" || log_success "  No interesting paths"
        stealth_delay
    done < "$urls_file"
    
    log_success "Directory brute-force completed"
}

# ============================================
# MODULE 6: WAYBACK URLS
# ============================================
run_wayback() {
    if [[ "$WAYBACK" != true ]]; then
        return
    fi
    
    log_step "6/7 - Wayback URL Gathering"
    
    local out_file="$OUTPUT_DIR/wayback/wayback-urls.txt"
    
    log_info "Fetching Wayback URLs for $TARGET..."
    waybackurls "$TARGET" | sort -u > "$out_file" 2>>"$OUTPUT_DIR/logs/wayback.log" || true
    
    local count=$(wc -l < "$out_file" 2>/dev/null || echo 0)
    log_success "Wayback URLs: ${GREEN}$count${NC}"
    
    # Subdomain wayback
    if [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]]; then
        log_info "Fetching Wayback URLs for subdomains..."
        cat "$OUTPUT_DIR/subdomains/all-subdomains.txt" | waybackurls | sort -u > "$OUTPUT_DIR/wayback/subdomain-urls.txt" 2>>"$OUTPUT_DIR/logs/wayback-subs.log" || true
        local sub_count=$(wc -l < "$OUTPUT_DIR/wayback/subdomain-urls.txt" 2>/dev/null || echo 0)
        log_success "Subdomain Wayback URLs: ${GREEN}$sub_count${NC}"
    fi
    stealth_delay
}

# ============================================
# MODULE 7: SOCIAL MEDIA OSINT (SOCMINT)
# ============================================
run_social_osint() {
    if [[ "$SOCIAL_ONLY" != true && -z "$SOCIAL_USERNAME" && -z "$SOCIAL_EMAIL" ]]; then
        return
    fi
    
    log_step "7/7 - Social Media OSINT (SOCMINT)"
    
    local social_dir="$OUTPUT_DIR/social"
    mkdir -p "$social_dir"
    
    # theHarvester - emails, hosts, employees
    if command -v theharvester &>/dev/null && [[ -n "$TARGET" ]]; then
        log_info "Running theHarvester (emails, hosts, employees)..."
        theharvester -d "$TARGET" -b all -l 500 -f "$social_dir/theharvester" 2>>"$OUTPUT_DIR/logs/theharvester.log" || true
        log_success "theHarvester completed (JSON + XML outputs)"
        stealth_delay
    fi
    
    # Sherlock - username search
    if [[ -n "$SOCIAL_USERNAME" ]] && command -v sherlock &>/dev/null; then
        log_info "Running Sherlock for username: $SOCIAL_USERNAME"
        sherlock "$SOCIAL_USERNAME" \
            --output "$social_dir/sherlock-$SOCIAL_USERNAME.txt" \
            --csv \
            --xlsx \
            --json "$social_dir/sherlock-$SOCIAL_USERNAME.json" \
            --timeout 15 \
            --print-found \
            2>>"$OUTPUT_DIR/logs/sherlock.log" || true
        log_success "Sherlock completed"
        stealth_delay
    fi
    
    # Holehe - email search
    if [[ -n "$SOCIAL_EMAIL" ]] && command -v holehe &>/dev/null; then
        log_info "Running Holehe for email: $SOCIAL_EMAIL"
        holehe "$SOCIAL_EMAIL" \
            --json "$social_dir/holehe-$(echo $SOCIAL_EMAIL | sed 's/@/_at_/').json" \
            --only-used \
            2>>"$OUTPUT_DIR/logs/holehe.log" || true
        log_success "Holehe completed"
        stealth_delay
    fi
    
    # Maigret - username search (comprehensive)
    if [[ -n "$SOCIAL_USERNAME" ]] && command -v maigret &>/dev/null; then
        log_info "Running Maigret for username: $SOCIAL_USERNAME"
        maigret "$SOCIAL_USERNAME" \
            --json "$social_dir/maigret-$SOCIAL_USERNAME.json" \
            --csv "$social_dir/maigret-$SOCIAL_USERNAME.csv" \
            --timeout 10 \
            --top-sites 500 \
            2>>"$OUTPUT_DIR/logs/maigret.log" || true
        log_success "Maigret completed"
        stealth_delay
    fi
    
    # LinkedIn2username - generate usernames from company
    if command -v linkedin2username &>/dev/null && [[ -n "$TARGET" ]]; then
        log_info "Running LinkedIn2username for company: $TARGET"
        # Extract company name from domain
        local company=$(echo "$TARGET" | cut -d'.' -f1)
        python3 -m linkedin2username -c "$company" -o "$social_dir/linkedin2username-$company.txt" 2>>"$OUTPUT_DIR/logs/linkedin2username.log" || true
        log_success "LinkedIn2username completed"
        stealth_delay
    fi
    
    # Summary
    log_info "Social OSINT outputs in: $social_dir/"
    ls -la "$social_dir/" 2>/dev/null || true
}

# ============================================
# UNIFIED JSON PARSER
# ============================================
generate_unified_report() {
    log_step "Generating unified JSON report..."
    
    local report_file="$OUTPUT_DIR/recon-report.json"
    local start_time="$1"
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # Count findings
    local sub_count=$(wc -l < "$OUTPUT_DIR/subdomains/all-subdomains.txt" 2>/dev/null || echo 0)
    local live_count=$(wc -l < "$OUTPUT_DIR/http/live.txt" 2>/dev/null || echo 0)
    local nuclei_total=0
    for f in "$OUTPUT_DIR/nuclei"/nuclei-*.txt; do
        [[ -f "$f" ]] && nuclei_total=$((nuclei_total + $(wc -l < "$f" 2>/dev/null || echo 0)))
    done
    local dir_total=0
    for f in "$OUTPUT_DIR/dirs"/*.txt; do
        [[ -f "$f" ]] && dir_total=$((dir_total + $(wc -l < "$f" 2>/dev/null || echo 0)))
    done
    local wayback_count=$(wc -l < "$OUTPUT_DIR/wayback/wayback-urls.txt" 2>/dev/null || echo 0)
    
    cat > "$report_file" << EOF
{
  "metadata": {
    "target": "$TARGET",
    "tool": "web-recon-v2.sh",
    "version": "2.0",
    "author": "BRIDA IT Services - Ariana",
    "timestamp": "$(date -Iseconds)",
    "duration_seconds": $duration,
    "duration_formatted": "$(printf '%dm %ds' $((duration/60)) $((duration%60)))",
    "stealth_mode": $STEALTH,
    "waf_detected": $WAF_DETECTED
  },
  "summary": {
    "subdomains_found": $sub_count,
    "live_hosts": $live_count,
    "nuclei_findings": $nuclei_total,
    "directory_findings": $dir_total,
    "wayback_urls": $wayback_count,
    "social_osint": $([ -n "$SOCIAL_USERNAME" ] || [ -n "$SOCIAL_EMAIL" ] && echo "true" || echo "false")
  },
  "modules_executed": {
    "subdomain_enum": true,
    "port_scan": $([ -f "$OUTPUT_DIR/network/open-ports.txt" ] && echo "true" || echo "false"),
    "http_probe": $([ -f "$OUTPUT_DIR/http/live.txt" ] && echo "true" || echo "false"),
    "nuclei_scan": $([ "$NO_NUCLEI" == "false" ] && echo "true" || echo "false"),
    "dir_bruteforce": $([ "$NO_DIRS" == "false" ] && echo "true" || echo "false"),
    "wayback": $([ "$WAYBACK" == "true" ] && echo "true" || echo "false"),
    "social_osint": $([ -n "$SOCIAL_USERNAME" ] || [ -n "$SOCIAL_EMAIL" ] && echo "true" || echo "false")
  },
  "files": {
    "subdomains": "$OUTPUT_DIR/subdomains/all-subdomains.txt",
    "live_hosts": "$OUTPUT_DIR/http/live.txt",
    "live_hosts_json": "$OUTPUT_DIR/http/live.json",
    "urls": "$OUTPUT_DIR/http/urls.txt",
    "nuclei_dir": "$OUTPUT_DIR/nuclei/",
    "dirs_dir": "$OUTPUT_DIR/dirs/",
    "wayback_dir": "$OUTPUT_DIR/wayback/",
    "social_dir": "$OUTPUT_DIR/social/",
    "logs_dir": "$OUTPUT_DIR/logs/"
  }
}
EOF
    
    log_success "Unified report: $report_file"
}

# ============================================
# MAIN
# ============================================
main() {
    local start_time=$(date +%s)
    
    print_banner
    
    log_info "Target: ${GREEN}$TARGET${NC}"
    log_info "Output: ${GREEN}$OUTPUT_DIR${NC}"
    log_info "Started: $(date)"
    [[ "$STEALTH" == "true" ]] && log_warn "STEALTH MODE ENABLED"
    
    check_tools
    
    # Create directory structure
    mkdir -p "$OUTPUT_DIR"/{subdomains,network,http,nuclei,dirs,wayback,social,logs}
    
    # Determine what to run
    local run_subs=true
    local run_ports=true
    local run_http=true
    local run_nuclei=true
    local run_dirs=true
    local run_wayback=false
    local run_social=false
    
    if [[ "$SUBS_ONLY" == true ]]; then
        run_ports=false; run_http=false; run_nuclei=false; run_dirs=false
    elif [[ "$HTTP_ONLY" == true ]]; then
        run_subs=false; run_ports=false; run_nuclei=false; run_dirs=false
    elif [[ "$NUCLEI_ONLY" == true ]]; then
        run_subs=false; run_ports=false; run_http=false; run_dirs=false
    elif [[ "$DIRS_ONLY" == true ]]; then
        run_subs=false; run_ports=false; run_http=false; run_nuclei=false
    elif [[ "$SOCIAL_ONLY" == true ]]; then
        run_subs=false; run_ports=false; run_http=false; run_nuclei=false; run_dirs=false
        run_social=true
    fi
    
    if [[ "$WAYBACK" == true ]]; then
        run_wayback=true
    fi
    
    if [[ -n "$SOCIAL_USERNAME" || -n "$SOCIAL_EMAIL" ]]; then
        run_social=true
    fi
    
    if [[ "$FULL" == true ]]; then
        run_subs=true; run_ports=true; run_http=true; run_nuclei=true; run_dirs=true; run_wayback=true; run_social=true
    fi
    
    # Execute modules
    local subs_file="$OUTPUT_DIR/subdomains/all-subdomains.txt"
    local hosts_file="$OUTPUT_DIR/network/live-hosts.txt"
    local urls_file="$OUTPUT_DIR/http/urls.txt"
    
    if [[ "$run_subs" == true ]]; then
        run_subdomain_enum
    else
        [[ ! -f "$subs_file" ]] && { log_error "Subdomains file not found: $subs_file"; exit 1; }
    fi
    
    if [[ "$run_ports" == true ]]; then
        run_port_scan "$subs_file"
    else
        [[ ! -f "$hosts_file" ]] && hosts_file="$subs_file"
    fi
    
    if [[ "$run_http" == true ]]; then
        run_http_probe "$hosts_file"
    else
        [[ ! -f "$urls_file" ]] && { log_error "URLs file not found: $urls_file"; exit 1; }
    fi
    
    if [[ "$run_nuclei" == true ]]; then
        run_nuclei_scan "$urls_file"
    fi
    
    if [[ "$run_dirs" == true ]]; then
        run_dir_bruteforce "$urls_file"
    fi
    
    if [[ "$run_wayback" == true ]]; then
        run_wayback
    fi
    
    if [[ "$run_social" == true ]]; then
        run_social_osint
    fi
    
    generate_unified_report "$start_time"
    
    # Final summary
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local mins=$((duration / 60))
    local secs=$((duration % 60))
    
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║                    RECON COMPLETE 🎉                         ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "Target:        ${GREEN}$TARGET${NC}"
    echo -e "Output:        ${GREEN}$OUTPUT_DIR${NC}"
    echo -e "Duration:      ${GREEN}${mins}m ${secs}s${NC}"
    echo -e "Finished:      ${GREEN}$(date)${NC}"
    echo
    echo -e "${CYAN}Key Files:${NC}"
    [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]] && echo -e "  Subdomains:  $OUTPUT_DIR/subdomains/all-subdomains.txt"
    [[ -f "$OUTPUT_DIR/http/live.txt" ]] && echo -e "  Live hosts:  $OUTPUT_DIR/http/live.txt"
    [[ -f "$OUTPUT_DIR/http/urls.txt" ]] && echo -e "  URLs:        $OUTPUT_DIR/http/urls.txt"
    [[ -d "$OUTPUT_DIR/nuclei" ]] && echo -e "  Nuclei:      $OUTPUT_DIR/nuclei/"
    [[ -d "$OUTPUT_DIR/dirs" ]] && echo -e "  Dirs:        $OUTPUT_DIR/dirs/"
    [[ -d "$OUTPUT_DIR/wayback" ]] && echo -e "  Wayback:     $OUTPUT_DIR/wayback/"
    [[ -d "$OUTPUT_DIR/social" ]] && echo -e "  Social:      $OUTPUT_DIR/social/"
    echo -e "  Report:      $OUTPUT_DIR/recon-report.json"
    echo -e "  Logs:        $OUTPUT_DIR/logs/"
    echo
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help; exit 0 ;;
        --full) FULL=true ;;
        --subs-only) SUBS_ONLY=true ;;
        --http-only) HTTP_ONLY=true ;;
        --nuclei-only) NUCLEI_ONLY=true ;;
        --dirs-only) DIRS_ONLY=true ;;
        --wayback) WAYBACK=true ;;
        --social-only) SOCIAL_ONLY=true ;;
        --social) SOCIAL_USERNAME="$2"; shift ;;
        --social-email) SOCIAL_EMAIL="$2"; shift ;;
        --no-nuclei) NO_NUCLEI=true ;;
        --no-dirs) NO_DIRS=true ;;
        --stealth) STEALTH=true ;;
        --threads) THREADS="$2"; shift ;;
        --rate) RATE="$2"; shift ;;
        *)
            if [[ -z "$TARGET" ]]; then
                TARGET="$1"
            elif [[ -z "$OUTPUT_DIR" ]]; then
                OUTPUT_DIR="$1"
            else
                log_error "Unknown argument: $1"
                show_help
                exit 1
            fi
            ;;
    esac
    shift
done

# Validate target
if [[ -z "$TARGET" ]]; then
    log_error "Target domain required"
    show_help
    exit 1
fi

if ! [[ "$TARGET" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    log_error "Invalid domain format: $TARGET"
    exit 1
fi

# Set output directory
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$HOME/recon/$TARGET"
fi

# Run main
main "$@"