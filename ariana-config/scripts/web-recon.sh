#!/bin/bash
# ============================================
# web-recon.sh - Automated Web Reconnaissance
# BRIDA IT Services - Ariana 💜🔐
# ============================================
# Usage: ./web-recon.sh <target-domain> [output-dir] [options]
# Example: ./web-recon.sh example.com ~/recon/example.com --full
# ============================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          🕷️  WEB RECON AUTOMATION - BRIDA IT  🕷️           ║"
    echo "║                    Ariana v1.0 - 2026                       ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1"; }

# Help
show_help() {
    cat << EOF
Usage: $0 <target-domain> [output-dir] [OPTIONS]

ARGUMENTS:
  target-domain    Domain to recon (e.g., example.com)
  output-dir       Output directory (default: ~/recon/<domain>)

OPTIONS:
  --full           Run all modules (subdomains, httpx, nuclei, dirs, wayback)
  --subs-only      Only subdomain enumeration
  --http-only      Only HTTP probing (requires existing subdomains.txt)
  --nuclei-only    Only Nuclei scanning (requires existing live.txt)
  --dirs-only      Only directory brute-force (requires existing live.txt)
  --wayback        Include Wayback URLs gathering
  --no-nuclei      Skip Nuclei scanning
  --no-dirs        Skip directory brute-force
  --threads N      Threads for ffuf/gobuster (default: 50)
  --rate N         Rate limit for httpx (default: 150)
  -h, --help       Show this help

EXAMPLES:
  $0 example.com                    # Basic: subs + httpx + nuclei + dirs
  $0 example.com --full --wayback   # Full recon with Wayback
  $0 example.com ~/myrecon --full   # Custom output dir
  $0 example.com --subs-only        # Only subdomain enum

TOOLS REQUIRED:
  - subfinder, assetfinder, amass (subdomains)
  - httpx (HTTP probing)
  - nuclei (vuln scanning)
  - ffuf OR gobuster (dir brute-force)
  - waybackurls (optional, for --wayback)

EOF
}

# Check required tools
check_tools() {
    local required=("subfinder" "assetfinder" "amass" "httpx" "nuclei")
    local missing=()
    
    for tool in "${required[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            missing+=("$tool")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_warn "Missing tools: ${missing[*]}"
        log_warn "Some modules may fail. Install with:"
        for tool in "${missing[@]}"; do
            case $tool in
                subfinder) echo "  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest" ;;
                assetfinder) echo "  go install github.com/tomnomnom/assetfinder@latest" ;;
                amass) echo "  go install -v github.com/owasp-amass/amass/v4/...@latest" ;;
                httpx) echo "  go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest" ;;
                nuclei) echo "  go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest" ;;
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
}

# Parse arguments
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
THREADS=50
RATE=150

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help; exit 0 ;;
        --full) FULL=true ;;
        --subs-only) SUBS_ONLY=true ;;
        --http-only) HTTP_ONLY=true ;;
        --nuclei-only) NUCLEI_ONLY=true ;;
        --dirs-only) DIRS_ONLY=true ;;
        --wayback) WAYBACK=true ;;
        --no-nuclei) NO_NUCLEI=true ;;
        --no-dirs) NO_DIRS=true ;;
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

# Validate domain format
if ! [[ "$TARGET" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    log_error "Invalid domain format: $TARGET"
    exit 1
fi

# Set output directory
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="$HOME/recon/$TARGET"
fi

# Create directory structure
mkdir -p "$OUTPUT_DIR"/{subdomains,http,nuclei,dirs,wayback,logs}

print_banner
log_info "Target: ${GREEN}$TARGET${NC}"
log_info "Output: ${GREEN}$OUTPUT_DIR${NC}"
log_info "Started: $(date)"

check_tools

# ============================================
# MODULE 1: SUBDOMAIN ENUMERATION
# ============================================
run_subdomain_enum() {
    log_step "1/5 - Subdomain Enumeration"
    
    local subs_file="$OUTPUT_DIR/subdomains/all-subdomains.txt"
    local tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" RETURN
    
    log_info "Running subfinder..."
    subfinder -d "$TARGET" -silent -o "$tmp_dir/subfinder.txt" 2>>"$OUTPUT_DIR/logs/subfinder.log" || true
    log_success "subfinder: $(wc -l < "$tmp_dir/subfinder.txt" 2>/dev/null || echo 0) subdomains"
    
    log_info "Running assetfinder..."
    assetfinder --subs-only "$TARGET" > "$tmp_dir/assetfinder.txt" 2>>"$OUTPUT_DIR/logs/assetfinder.log" || true
    log_success "assetfinder: $(wc -l < "$tmp_dir/assetfinder.txt" 2>/dev/null || echo 0) subdomains"
    
    log_info "Running amass (passive)..."
    timeout 300 amass enum -passive -d "$TARGET" -o "$tmp_dir/amass.txt" 2>>"$OUTPUT_DIR/logs/amass.log" || true
    log_success "amass: $(wc -l < "$tmp_dir/amass.txt" 2>/dev/null || echo 0) subdomains"
    
    # Combine and deduplicate
    cat "$tmp_dir"/*.txt 2>/dev/null | sort -u | grep -E "^[a-zA-Z0-9.-]+\.$TARGET$" > "$subs_file" || true
    
    local total=$(wc -l < "$subs_file" 2>/dev/null || echo 0)
    log_success "Total unique subdomains: ${GREEN}$total${NC}"
    
    if [[ $total -eq 0 ]]; then
        log_error "No subdomains found. Exiting."
        exit 1
    fi
    
    echo "$subs_file"
}

# ============================================
# MODULE 2: HTTP PROBING
# ============================================
run_http_probe() {
    local subs_file="$1"
    log_step "2/5 - HTTP Probing (httpx)"
    
    local live_file="$OUTPUT_DIR/http/live.txt"
    local json_file="$OUTPUT_DIR/http/live.json"
    
    httpx -l "$subs_file" \
        -silent \
        -status-code \
        -title \
        -tech-detect \
        -cdn \
        -ip \
        -server \
        -content-length \
        -json \
        -o "$live_file" \
        -json-output "$json_file" \
        -rate-limit "$RATE" \
        -threads "$THREADS" \
        -timeout 10 \
        -retries 2 \
        2>>"$OUTPUT_DIR/logs/httpx.log" || true
    
    local live_count=$(wc -l < "$live_file" 2>/dev/null || echo 0)
    log_success "Live hosts: ${GREEN}$live_count${NC}"
    
    # Extract just URLs for next steps
    cut -d' ' -f1 "$live_file" | sort -u > "$OUTPUT_DIR/http/urls.txt" 2>/dev/null || true
    
    echo "$OUTPUT_DIR/http/urls.txt"
}

# ============================================
# MODULE 3: NUCLEI SCANNING
# ============================================
run_nuclei_scan() {
    local urls_file="$1"
    
    if [[ "$NO_NUCLEI" == true ]]; then
        log_warn "Skipping Nuclei (--no-nuclei)"
        return
    fi
    
    log_step "3/5 - Nuclei Vulnerability Scanning"
    
    local out_dir="$OUTPUT_DIR/nuclei"
    
    # Update templates
    log_info "Updating Nuclei templates..."
    nuclei -update-templates -silent 2>>"$OUTPUT_DIR/logs/nuclei-update.log" || true
    
    # Run nuclei with severity levels
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
        if [[ $count -gt 0 ]]; then
            log_warn "$severity findings: ${RED}$count${NC}"
        else
            log_success "$severity: clean"
        fi
    done
    
    # Summary
    local total=0
    for f in "$out_dir"/nuclei-*.txt; do
        [[ -f "$f" ]] && total=$((total + $(wc -l < "$f" 2>/dev/null || echo 0)))
    done
    log_success "Total Nuclei findings: ${GREEN}$total${NC}"
}

# ============================================
# MODULE 4: DIRECTORY BRUTE-FORCE
# ============================================
run_dir_bruteforce() {
    local urls_file="$1"
    
    if [[ "$NO_DIRS" == true ]]; then
        log_warn "Skipping directory brute-force (--no-dirs)"
        return
    fi
    
    log_step "4/5 - Directory Brute-Force"
    
    local out_dir="$OUTPUT_DIR/dirs"
    local wordlist="/usr/share/wordlists/dirb/common.txt"
    
    # Try to find better wordlists
    for wl in \
        "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt" \
        "/usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt" \
        "/usr/share/wordlists/dirb/common.txt"; do
        if [[ -f "$wl" ]]; then
            wordlist="$wl"
            break
        fi
    done
    
    log_info "Using wordlist: $wordlist"
    
    # Read URLs and process each
    local count=0
    while IFS= read -r url; do
        [[ -z "$url" ]] && continue
        count=$((count + 1))
        local host=$(echo "$url" | sed -E 's|^https?://||' | sed 's|/.*||')
        local outfile="$out_dir/${host//./_}.txt"
        
        log_info "[$count] Scanning: $url"
        
        if command -v ffuf &>/dev/null; then
            ffuf -u "$url/FUZZ" \
                -w "$wordlist" \
                -mc 200,204,301,302,307,401,403,405,500 \
                -t "$THREADS" \
                -timeout 10 \
                -silent \
                -o "$outfile" \
                -of csv \
                2>>"$OUTPUT_DIR/logs/ffuf-$host.log" || true
        elif command -v gobuster &>/dev/null; then
            gobuster dir -u "$url" \
                -w "$wordlist" \
                -t "$THREADS" \
                -timeout 10s \
                -q \
                -o "$outfile" \
                2>>"$OUTPUT_DIR/logs/gobuster-$host.log" || true
        fi
        
        local found=$(wc -l < "$outfile" 2>/dev/null || echo 0)
        [[ $found -gt 0 ]] && log_warn "  Found: $found paths" || log_success "  No interesting paths"
        
    done < "$urls_file"
    
    log_success "Directory brute-force completed"
}

# ============================================
# MODULE 5: WAYBACK URLS
# ============================================
run_wayback() {
    if [[ "$WAYBACK" != true ]]; then
        return
    fi
    
    log_step "5/5 - Wayback URL Gathering"
    
    local out_file="$OUTPUT_DIR/wayback/wayback-urls.txt"
    
    log_info "Fetching Wayback URLs for $TARGET..."
    waybackurls "$TARGET" | sort -u > "$out_file" 2>>"$OUTPUT_DIR/logs/wayback.log" || true
    
    local count=$(wc -l < "$out_file" 2>/dev/null || echo 0)
    log_success "Wayback URLs: ${GREEN}$count${NC}"
    
    # Also get subdomain wayback if we have subs
    if [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]]; then
        log_info "Fetching Wayback URLs for subdomains..."
        cat "$OUTPUT_DIR/subdomains/all-subdomains.txt" | waybackurls | sort -u > "$OUTPUT_DIR/wayback/subdomain-urls.txt" 2>>"$OUTPUT_DIR/logs/wayback-subs.log" || true
        local sub_count=$(wc -l < "$OUTPUT_DIR/wayback/subdomain-urls.txt" 2>/dev/null || echo 0)
        log_success "Subdomain Wayback URLs: ${GREEN}$sub_count${NC}"
    fi
}

# ============================================
# MAIN EXECUTION FLOW
# ============================================
main() {
    local start_time=$(date +%s)
    
    # Determine what to run
    local run_subs=true
    local run_http=true
    local run_nuclei=true
    local run_dirs=true
    
    if [[ "$SUBS_ONLY" == true ]]; then
        run_http=false; run_nuclei=false; run_dirs=false
    elif [[ "$HTTP_ONLY" == true ]]; then
        run_subs=false; run_nuclei=false; run_dirs=false
    elif [[ "$NUCLEI_ONLY" == true ]]; then
        run_subs=false; run_http=false; run_dirs=false
    elif [[ "$DIRS_ONLY" == true ]]; then
        run_subs=false; run_http=false; run_nuclei=false
    fi
    
    # Execute modules
    local subs_file=""
    local urls_file=""
    
    if [[ "$run_subs" == true ]]; then
        subs_file=$(run_subdomain_enum)
    else
        subs_file="$OUTPUT_DIR/subdomains/all-subdomains.txt"
        [[ ! -f "$subs_file" ]] && { log_error "Subdomains file not found: $subs_file"; exit 1; }
    fi
    
    if [[ "$run_http" == true ]]; then
        urls_file=$(run_http_probe "$subs_file")
    else
        urls_file="$OUTPUT_DIR/http/urls.txt"
        [[ ! -f "$urls_file" ]] && { log_error "URLs file not found: $urls_file"; exit 1; }
    fi
    
    if [[ "$run_nuclei" == true ]]; then
        run_nuclei_scan "$urls_file"
    fi
    
    if [[ "$run_dirs" == true ]]; then
        run_dir_bruteforce "$urls_file"
    fi
    
    run_wayback
    
    # Summary
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
    echo -e "  Logs:        $OUTPUT_DIR/logs/"
    echo
}

# Run
main "$@"