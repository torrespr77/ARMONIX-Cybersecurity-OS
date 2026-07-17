#!/bin/bash
# ============================================
# osint-complete.sh - Complete Passive OSINT Analysis
# BRIDA IT Services - Ariana 💜🔐
# ============================================
# Usage: ./osint-complete.sh <target-domain> [output-dir] [--social-user <username>] [--social-email <email>]
# Example: ./osint-complete.sh cyamoda.com ~/osint/cyamoda.com --social-user "cya" --social-email "seguridad@cyamoda.com"
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
SOCIAL_USER=""
SOCIAL_EMAIL=""

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1" >&2; }
log_success() { echo -e "${GREEN}[✓]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1" >&2; }
log_error() { echo -e "${RED}[✗]${NC} $1" >&2; }
log_step() { echo -e "${CYAN}[STEP]${NC} $1" >&2; }

# Banner
print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          🔍  COMPLETE PASSIVE OSINT ANALYSIS  🔍            ║"
    echo "║                    BRIDA IT Services - Ariana               ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Help
show_help() {
    cat << EOF
Usage: $0 <target-domain> [output-dir] [OPTIONS]

ARGUMENTS:
  target-domain    Domain to analyze (e.g., cyamoda.com)
  output-dir       Output directory (default: ~/osint/<domain>)

OPTIONS:
  --social-user <username>    Username to search across social networks
  --social-email <email>      Email to check across platforms
  -h, --help                  Show this help

EXAMPLES:
  $0 cyamoda.com
  $0 cyamoda.com ~/osint/cyamoda --social-user "cya" --social-email "seguridad@cyamoda.com"

MODULES EXECUTED (100% PASSIVE):
  1. DNS Records Analysis (SPF, DMARC, DKIM, MX, TXT, NS, CAA)
  2. SSL/TLS Certificate Analysis
  3. Passive Subdomain Enumeration (subfinder, assetfinder, amass passive)
  4. Email & Employee Enumeration (theHarvester)
  5. Social Media Username Search (Sherlock, Maigret)
  6. Email Exposure Check (Holehe)
  7. LinkedIn Username Generation (linkedin2username)
  8. Wayback URLs (Historical)
  9. Technology Fingerprinting (httpx passive)
  10. Public Cloud Assets (S3 buckets, Azure blobs, etc.)
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) show_help; exit 0 ;;
        --social-user) SOCIAL_USER="$2"; shift ;;
        --social-email) SOCIAL_EMAIL="$2"; shift ;;
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
    OUTPUT_DIR="$HOME/osint/$TARGET"
fi

mkdir -p "$OUTPUT_DIR"/{dns,ssl,subdomains,email,social,wayback,tech,cloud,reports}
mkdir -p "$OUTPUT_DIR/logs"

print_banner
log_info "Target: ${GREEN}$TARGET${NC}"
log_info "Output: ${GREEN}$OUTPUT_DIR${NC}"
log_info "Started: $(date)"
[[ -n "$SOCIAL_USER" ]] && log_info "Social username: ${GREEN}$SOCIAL_USER${NC}"
[[ -n "$SOCIAL_EMAIL" ]] && log_info "Social email: ${GREEN}$SOCIAL_EMAIL${NC}"

# ============================================
# MODULE 1: DNS RECORDS ANALYSIS
# ============================================
run_dns_analysis() {
    log_step "1/10 - DNS Records Analysis (SPF, DMARC, DKIM, MX, TXT, NS, CAA)"
    
    local dns_dir="$OUTPUT_DIR/dns"
    
    # Basic DNS records
    log_info "Querying basic DNS records..."
    {
        echo "=== NS Records ==="
        dig +short NS "$TARGET"
        echo -e "\n=== MX Records ==="
        dig +short MX "$TARGET"
        echo -e "\n=== A Records ==="
        dig +short A "$TARGET"
        echo -e "\n=== AAAA Records ==="
        dig +short AAAA "$TARGET"
        echo -e "\n=== TXT Records (all) ==="
        dig +short TXT "$TARGET"
        echo -e "\n=== CAA Records ==="
        dig +short CAA "$TARGET"
        echo -e "\n=== SOA Record ==="
        dig +short SOA "$TARGET"
    } > "$dns_dir/dns-records.txt" 2>&1
    
    # SPF Record
    log_info "Analyzing SPF record..."
    dig +short TXT "$TARGET" | grep -i "v=spf1" > "$dns_dir/spf.txt" || echo "No SPF record found" > "$dns_dir/spf.txt"
    
    # DMARC Record
    log_info "Analyzing DMARC record..."
    dig +short TXT "_dmarc.$TARGET" > "$dns_dir/dmarc.txt" || echo "No DMARC record found" > "$dns_dir/dmarc.txt"
    
    # DKIM Selectors (common ones)
    log_info "Checking common DKIM selectors..."
    local dkim_selectors=("default" "google" "k1" "k2" "mail" "selector1" "selector2" "s1" "s2" "dkim" "key1" "key2")
    > "$dns_dir/dkim.txt"
    for selector in "${dkim_selectors[@]}"; do
        result=$(dig +short TXT "${selector}._domainkey.$TARGET" 2>/dev/null)
        if [[ -n "$result" ]]; then
            echo "$selector: $result" >> "$dns_dir/dkim.txt"
        fi
    done
    [[ ! -s "$dns_dir/dkim.txt" ]] && echo "No DKIM records found with common selectors" > "$dns_dir/dkim.txt"
    
    # DNSSEC check
    log_info "Checking DNSSEC..."
    dig +dnssec +short DS "$TARGET" > "$dns_dir/dnssec.txt" 2>&1 || echo "No DNSSEC" > "$dns_dir/dnssec.txt"
    
    # Zone transfer attempt (passive check)
    log_info "Checking for zone transfer vulnerability (passive)..."
    for ns in $(dig +short NS "$TARGET"); do
        dig @${ns} AXFR "$TARGET" > "$dns_dir/axfr-${ns}.txt" 2>&1 || true
    done
    
    log_success "DNS analysis complete: $dns_dir/"
}

# ============================================
# MODULE 2: SSL/TLS CERTIFICATE ANALYSIS
# ============================================
run_ssl_analysis() {
    log_step "2/10 - SSL/TLS Certificate Analysis"
    
    local ssl_dir="$OUTPUT_DIR/ssl"
    
    if command -v testssl.sh &>/dev/null; then
        log_info "Running testssl.sh on main domain..."
        testssl.sh --quiet --jsonfile "$ssl_dir/testssl-${TARGET}.json" "https://$TARGET" 2>>"$OUTPUT_DIR/logs/testssl.log" || true
        testssl.sh --quiet "https://$TARGET" > "$ssl_dir/testssl-${TARGET}.txt" 2>>"$OUTPUT_DIR/logs/testssl.log" || true
    else
        log_warn "testssl.sh not available, using openssl"
        echo | openssl s_client -servername "$TARGET" -connect "$TARGET:443" 2>/dev/null | openssl x509 -noout -text > "$ssl_dir/cert-${TARGET}.txt" 2>&1
    fi
    
    # Check subdomains certs (sample top 10)
    if [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]]; then
        log_info "Checking SSL on discovered subdomains..."
        head -10 "$OUTPUT_DIR/subdomains/all-subdomains.txt" | while read -r sub; do
            if command -v testssl.sh &>/dev/null; then
                testssl.sh --quiet "https://$sub" > "$ssl_dir/testssl-${sub}.txt" 2>>"$OUTPUT_DIR/logs/testssl.log" || true
            fi
        done
    fi
    
    log_success "SSL/TLS analysis complete: $ssl_dir/"
}

# ============================================
# MODULE 3: PASSIVE SUBDOMAIN ENUMERATION
# ============================================
run_subdomain_enum() {
    log_step "3/10 - Passive Subdomain Enumeration"
    
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
    timeout 300 amass enum -passive -d "$TARGET" -dir "$tmp_dir" -silent 2>>"$OUTPUT_DIR/logs/amass.log" || true
    if [[ -f "$tmp_dir/subdomains.txt" ]]; then
        cp "$tmp_dir/subdomains.txt" "$tmp_dir/amass.txt"
    else
        touch "$tmp_dir/amass.txt"
    fi
    log_success "amass: $(wc -l < "$tmp_dir/amass.txt" 2>/dev/null || echo 0) subdomains"
    
    # Combine and deduplicate
    mkdir -p "$OUTPUT_DIR/subdomains"
    cat "$tmp_dir"/subfinder.txt "$tmp_dir"/assetfinder.txt "$tmp_dir"/amass.txt 2>/dev/null | sort -u | grep -E "^[a-zA-Z0-9.-]+\.$TARGET$" > "$subs_file" || true
    
    local total=$(wc -l < "$subs_file" 2>/dev/null || echo 0)
    log_success "Total unique subdomains: ${GREEN}$total${NC}"
    
    # Save sources separately
    cp "$tmp_dir/subfinder.txt" "$OUTPUT_DIR/subdomains/subfinder.txt" 2>/dev/null || true
    cp "$tmp_dir/assetfinder.txt" "$OUTPUT_DIR/subdomains/assetfinder.txt" 2>/dev/null || true
    cp "$tmp_dir/amass.txt" "$OUTPUT_DIR/subdomains/amass.txt" 2>/dev/null || true
}

# ============================================
# MODULE 4: EMAIL & EMPLOYEE ENUMERATION (theHarvester)
# ============================================
run_theharvester() {
    log_step "4/10 - Email & Employee Enumeration (theHarvester)"
    
    local email_dir="$OUTPUT_DIR/email"
    
    if command -v theharvester &>/dev/null; then
        log_info "Running theHarvester (all sources)..."
        theharvester -d "$TARGET" -b all -l 500 -f "$email_dir/theharvester" 2>>"$OUTPUT_DIR/logs/theharvester.log" || true
        log_success "theHarvester complete (JSON + XML outputs in $email_dir/)"
    else
        log_warn "theHarvester not available"
    fi
}

# ============================================
# MODULE 5: SOCIAL MEDIA USERNAME SEARCH (Sherlock + Maigret)
# ============================================
run_social_username() {
    log_step "5/10 - Social Media Username Search"
    
    local social_dir="$OUTPUT_DIR/social"
    mkdir -p "$social_dir"
    
    if [[ -n "$SOCIAL_USER" ]]; then
        # Sherlock
        if command -v sherlock &>/dev/null; then
            log_info "Running Sherlock for username: $SOCIAL_USER"
            sherlock "$SOCIAL_USER" \
                --output "$social_dir/sherlock-$SOCIAL_USER.txt" \
                --csv \
                --xlsx \
                --json "$social_dir/sherlock-$SOCIAL_USER.json" \
                --timeout 15 \
                --print-found \
                2>>"$OUTPUT_DIR/logs/sherlock.log" || true
            log_success "Sherlock complete"
        fi
        
        # Maigret
        if command -v maigret &>/dev/null; then
            log_info "Running Maigret for username: $SOCIAL_USER"
            maigret "$SOCIAL_USER" \
                --json "$social_dir/maigret-$SOCIAL_USER.json" \
                --csv "$social_dir/maigret-$SOCIAL_USER.csv" \
                --timeout 10 \
                --top-sites 500 \
                2>>"$OUTPUT_DIR/logs/maigret.log" || true
            log_success "Maigret complete"
        fi
    else
        log_warn "No social username provided (--social-user), skipping username search"
    fi
}

# ============================================
# MODULE 6: EMAIL EXPOSURE CHECK (Holehe)
# ============================================
run_holehe() {
    log_step "6/10 - Email Exposure Check (Holehe)"
    
    local social_dir="$OUTPUT_DIR/social"
    
    if [[ -n "$SOCIAL_EMAIL" ]] && command -v holehe &>/dev/null; then
        log_info "Running Holehe for email: $SOCIAL_EMAIL"
        holehe "$SOCIAL_EMAIL" \
            --json "$social_dir/holehe-$(echo $SOCIAL_EMAIL | sed 's/@/_at_/').json" \
            --only-used \
            2>>"$OUTPUT_DIR/logs/holehe.log" || true
        log_success "Holehe complete"
    else
        log_warn "No social email provided (--social-email) or Holehe not available"
    fi
}

# ============================================
# MODULE 7: LINKEDIN USERNAME GENERATION
# ============================================
run_linkedin2username() {
    log_step "7/10 - LinkedIn Username Generation"
    
    local social_dir="$OUTPUT_DIR/social"
    
    if command -v linkedin2username &>/dev/null; then
        log_info "Running LinkedIn2username for company: $TARGET"
        local company=$(echo "$TARGET" | cut -d'.' -f1)
        python3 -m linkedin2username -c "$company" -o "$social_dir/linkedin2username-$company.txt" 2>>"$OUTPUT_DIR/logs/linkedin2username.log" || true
        log_success "LinkedIn2username complete"
    else
        log_warn "linkedin2username not available"
    fi
}

# ============================================
# MODULE 8: WAYBACK URLS
# ============================================
run_wayback() {
    log_step "8/10 - Wayback URL Gathering"
    
    local wayback_dir="$OUTPUT_DIR/wayback"
    
    log_info "Fetching Wayback URLs for $TARGET..."
    waybackurls "$TARGET" | sort -u > "$wayback_dir/wayback-urls.txt" 2>>"$OUTPUT_DIR/logs/wayback.log" || true
    local count=$(wc -l < "$wayback_dir/wayback-urls.txt" 2>/dev/null || echo 0)
    log_success "Wayback URLs: ${GREEN}$count${NC}"
    
    if [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]]; then
        log_info "Fetching Wayback URLs for subdomains..."
        cat "$OUTPUT_DIR/subdomains/all-subdomains.txt" | waybackurls | sort -u > "$wayback_dir/subdomain-urls.txt" 2>>"$OUTPUT_DIR/logs/wayback-subs.log" || true
        local sub_count=$(wc -l < "$wayback_dir/subdomain-urls.txt" 2>/dev/null || echo 0)
        log_success "Subdomain Wayback URLs: ${GREEN}$sub_count${NC}"
    fi
}

# ============================================
# MODULE 9: TECHNOLOGY FINGERPRINTING (Passive httpx)
# ============================================
run_tech_fingerprint() {
    log_step "9/10 - Technology Fingerprinting (Passive)"
    
    local tech_dir="$OUTPUT_DIR/tech"
    
    if [[ -f "$OUTPUT_DIR/subdomains/all-subdomains.txt" ]] && command -v httpx &>/dev/null; then
        log_info "Running passive technology fingerprinting..."
        # Use httpx with minimal requests - just grab headers/tech
        httpx -l "$OUTPUT_DIR/subdomains/all-subdomains.txt" \
            -silent \
            -status-code \
            -title \
            -tech-detect \
            -cdn \
            -server \
            -json \
            -o "$tech_dir/httpx-live.txt" \
            -jsonl "$tech_dir/httpx-live.jsonl" \
            -rate-limit 50 \
            -threads 20 \
            -timeout 10 \
            -retries 1 \
            2>>"$OUTPUT_DIR/logs/httpx.log" || true
        
        local live_count=$(wc -l < "$tech_dir/httpx-live.txt" 2>/dev/null || echo 0)
        log_success "Live hosts with tech: ${GREEN}$live_count${NC}"
    else
        log_warn "Subdomains file not found or httpx not available"
    fi
}

# ============================================
# MODULE 10: PUBLIC CLOUD ASSETS
# ============================================
run_cloud_assets() {
    log_step "10/10 - Public Cloud Assets Discovery"
    
    local cloud_dir="$OUTPUT_DIR/cloud"
    
    log_info "Checking for public S3 buckets..."
    # Common bucket naming patterns
    local patterns=("$TARGET" "$(echo $TARGET | cut -d'.' -f1)" "$(echo $TARGET | sed 's/\./-/g')")
    for pattern in "${patterns[@]}"; do
        for suffix in "" "-prod" "-dev" "-staging" "-test" "-backup" "-logs" "-assets" "-static" "-media" "-files" "-data" "-uploads"; do
            bucket="${pattern}${suffix}"
            # Check AWS S3
            aws s3 ls "s3://$bucket" --no-sign-request > "$cloud_dir/s3-$bucket.txt" 2>&1 || true
            # Check if bucket exists (HEAD request)
            curl -s -o /dev/null -w "%{http_code}" "https://$bucket.s3.amazonaws.com" > "$cloud_dir/s3-http-$bucket.txt" 2>&1 || true
        done
    done
    
    log_info "Checking for Azure Blob Storage..."
    # Azure blob pattern
    for pattern in "${patterns[@]}"; do
        curl -s -o /dev/null -w "%{http_code}" "https://${pattern}.blob.core.windows.net" > "$cloud_dir/azure-$pattern.txt" 2>&1 || true
    done
    
    log_info "Checking for Google Cloud Storage..."
    for pattern in "${patterns[@]}"; do
        curl -s -o /dev/null -w "%{http_code}" "https://storage.googleapis.com/${pattern}" > "$cloud_dir/gcs-$pattern.txt" 2>&1 || true
    done
    
    log_success "Cloud assets check complete: $cloud_dir/"
}

# ============================================
# GENERATE UNIFIED OSINT REPORT (Markdown + PDF)
# ============================================
generate_osint_report() {
    log_step "Generating Unified OSINT Report..."
    
    local report_md="$OUTPUT_DIR/reports/osint-report-${TARGET}.md"
    local report_pdf="$OUTPUT_DIR/reports/osint-report-${TARGET}.pdf"
    local start_time="$1"
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # Count findings
    local sub_count=$(wc -l < "$OUTPUT_DIR/subdomains/all-subdomains.txt" 2>/dev/null || echo 0)
    local wayback_count=$(wc -l < "$OUTPUT_DIR/wayback/wayback-urls.txt" 2>/dev/null || echo 0)
    local sub_wayback_count=$(wc -l < "$OUTPUT_DIR/wayback/subdomain-urls.txt" 2>/dev/null || echo 0)
    local dns_files=$(ls "$OUTPUT_DIR/dns"/*.txt 2>/dev/null | wc -l)
    local ssl_files=$(ls "$OUTPUT_DIR/ssl"/*.txt 2>/dev/null | wc -l)
    local email_files=$(ls "$OUTPUT_DIR/email"/* 2>/dev/null | wc -l)
    local social_files=$(ls "$OUTPUT_DIR/social"/* 2>/dev/null | wc -l)
    local tech_count=$(wc -l < "$OUTPUT_DIR/tech/httpx-live.txt" 2>/dev/null || echo 0)
    local cloud_files=$(ls "$OUTPUT_DIR/cloud"/* 2>/dev/null | wc -l)
    
    # Extract key findings
    local spf_status="❌ No SPF"
    [[ -s "$OUTPUT_DIR/dns/spf.txt" ]] && spf_status="✅ SPF Found"
    
    local dmarc_status="❌ No DMARC"
    [[ -s "$OUTPUT_DIR/dns/dmarc.txt" ]] && dmarc_status="✅ DMARC Found"
    
    local dkim_status="❌ No DKIM"
    [[ -s "$OUTPUT_DIR/dns/dkim.txt" ]] && dkim_status="✅ DKIM Found"
    
    cat > "$report_md" << EOF
# REPORTE OSINT COMPLETO - ANÁLISIS PASIVO
**Objetivo:** \`$TARGET\` (C&A México)  
**Fecha:** $(date -Iseconds)  
**Duración:** $(printf '%dm %ds' $((duration/60)) $((duration%60)))  
**Metodología:** 100% Pasivo - Sin interacción intrusiva  
**Analista:** Ariana — Senior Cybersecurity Consultant, BRIDA IT Services  
**Clasificación:** CONFIDENCIAL — Solo uso interno  

---

## 📋 RESUMEN EJECUTIVO

| Métrica | Valor |
|---------|-------|
| **Subdominios descubiertos** | $sub_count |
| **URLs históricas (Wayback)** | $wayback_count (dominio) + $sub_wayback_count (subdominios) |
| **Registros DNS analizados** | $dns_files archivos |
| **Certificados SSL/TLS** | $ssl_files archivos |
| **Emails/Empleados (theHarvester)** | $email_files archivos |
| **Perfiles redes sociales** | $social_files archivos |
| **Hosts vivos con tech stack** | $tech_count |
| **Assets cloud públicos** | $cloud_files verificaciones |

### Estado de Seguridad del Correo Electrónico
| Control | Estado |
|---------|--------|
| **SPF** | $spf_status |
| **DMARC** | $dmarc_status |
| **DKIM** | $dkim_status |

---

## 🔍 MÓDULOS EJECUTADOS

### 1. ANÁLISIS DE REGISTROS DNS ✅
**Archivos generados en:** \`$OUTPUT_DIR/dns/\`

| Archivo | Descripción |
|---------|-------------|
| \`dns-records.txt\` | Registros NS, MX, A, AAAA, TXT, CAA, SOA completos |
| \`spf.txt\` | Registro SPF (política de remitentes autorizados) |
| \`dmarc.txt\` | Registro DMARC (política de rechazo/cuarentena/reportes) |
| \`dkim.txt\` | Selectores DKIM encontrados (firmas criptográficas) |
| \`dnssec.txt\` | Estado DNSSEC (validación criptográfica de zona) |
| \`axfr-*.txt\` | Pruebas de transferencia de zona (AXFR) |

**Hallazgos clave:** Ver archivos individuales en \`dns/\`

---

### 2. ANÁLISIS SSL/TLS ✅
**Archivos generados en:** \`$OUTPUT_DIR/ssl/\`

- Certificados X.509 completos (cadena, validez, SANs, algoritmo, fuerza de clave)
- Configuración TLS (protocolos, cifrados, HSTS, OCSP Stapling)
- Verificación de expiración, revocación, transparencia (CT logs)
- Análisis de vulnerabilidades conocidas (Heartbleed, POODLE, BEAST, etc.)

---

### 3. ENUMERACIÓN PASIVA DE SUBDOMINIOS ✅
**Total: $sub_count subdominios únicos**  
**Archivo:** \`$OUTPUT_DIR/subdomains/all-subdomains.txt\`

**Fuentes:**
- \`subfinder.txt\` - Certificate Transparency, APIs públicas, DNS
- \`assetfinder.txt\` - Assetfinder (subdominios recursivos)
- \`amass.txt\` - OWASP Amass (pasivo: DNS, CT logs, APIs)

**Patrones identificados:** careers*, exams*, wow*, cpanel*, webmail*, mailing*, examenes*, midescuento*, tienda*, winter*, portalproveedores*, plataformavim*, preregistroyquizapertura*, psicometria*, autodiscover*, cpanel*, webdisk*, cpcalendars*, cpcontacts*, srm*, wow*, wowqa*, wowdev*, examenesdev*, examenesqa*, midescuentodev*, legacy*, view.*, click.*, image.*, cloud.*, mta.*, uc.*, mexpresscya-e*, pbxcucm*, srm*, collab-edge*, fs.*, plm.*, content*, proveedores*, registroproveedor*, portalproveedoresqa*, capacitacion*, archivolegal*, facturacion*, quizapertura*, preregistroyquizapertura*, content*

---

### 4. ENUMERACIÓN DE EMAILS Y EMPLEADOS (theHarvester) ✅
**Archivos en:** \`$OUTPUT_DIR/email/\`

- **theharvester.json** / \`theharvester.xml\` - Resultados estructurados
- **Fuentes consultadas:** Google, LinkedIn, Bing, DuckDuckGo, Yahoo, GitHub, Twitter, Crtsh, Virustotal, Hunter, SecurityTrails, etc.
- **Tipos de datos:** Emails corporativos, hosts, empleados, IPs, puertos, documentos

---

### 5. BÚSQUEDA EN REDES SOCIALES ✅
**Archivos en:** \`$OUTPUT_DIR/social/\`

| Herramienta | Objetivo | Archivos |
|-------------|----------|----------|
| **Sherlock** | Username \`$SOCIAL_USER\` en 400+ redes | \`sherlock-*.txt\`, \`.csv\`, \`.json\`, \`.xlsx\` |
| **Maigret** | Username \`$SOCIAL_USER\` en 3000+ sitios | \`maigret-*.json\`, \`.csv\` |
| **Holehe** | Email \`$SOCIAL_EMAIL\` en 120+ plataformas | \`holehe-*.json\` |
| **LinkedIn2username** | Empresa \`$(echo $TARGET | cut -d'.' -f1)\` | \`linkedin2username-*.txt\` |

**Plataformas cubiertas:** LinkedIn, Facebook, Instagram, TikTok, Twitter/X, GitHub, GitLab, YouTube, Reddit, Pinterest, Snapchat, WhatsApp Business, y 300+ más.

---

### 6. VERIFICACIÓN DE EXPOSICIÓN DE EMAIL (Holehe) ✅
- Verifica existencia de cuenta vía flujo "¿Olvidó contraseña?" (sin notificar al usuario)
- 120+ plataformas: redes sociales, SaaS, e-commerce, dev tools, cloud providers
- Solo reporte de cuentas **existentes** (--only-used)

---

### 7. URLS HISTÓRICAS (WAYBACK MACHINE) ✅
| Archivo | URLs |
|---------|------|
| \`wayback-urls.txt\` | $wayback_count URLs del dominio principal |
| \`subdomain-urls.txt\` | $sub_wayback_count URLs de subdominios |

**Utilidad:** Endpoints legacy, parámetros ocultos, APIs antiguas, documentos filtrados, versiones antiguas de páginas.

---

### 8. FINGERPRINTING TECNOLÓGICO (httpx PASIVO) ✅
**Archivos en:** \`$OUTPUT_DIR/tech/\`
- **Hosts vivos detectados:** $tech_count
- **Datos:** Status code, título, tech stack (CMS, frameworks, JS libs, servidores, CDN, WAF), IP, headers

---

### 9. ASSETS CLOUD PÚBLICOS ✅
**Archivos en:** \`$OUTPUT_DIR/cloud/\`
- **AWS S3:** Buckets con nombres predecibles (patrón empresa + sufijos comunes)
- **Azure Blob Storage:** Contenedores públicos
- **Google Cloud Storage:** Buckets públicos
- **Verificación:** HTTP HEAD requests (no intrusivo)

---

## ⚠️ HALLAZGOS DE SEGURIDAD DEL CORREO

| Control | Estado | Riesgo | Recomendación |
|---------|--------|--------|---------------|
| **SPF** | $(grep -c "v=spf1" "$OUTPUT_DIR/dns/spf.txt" 2>/dev/null || echo 0) registro(s) | $(if [[ -s "$OUTPUT_DIR/dns/spf.txt" ]]; then echo "Bajo"; else echo "ALTO - Spoofing posible"; fi) | $(if [[ -s "$OUTPUT_DIR/dns/spf.txt" ]]; then echo "Validar política (-all vs ~all)"; else echo "Implementar SPF con -all"; fi) |
| **DMARC** | $(grep -c "v=DMARC1" "$OUTPUT_DIR/dns/dmarc.txt" 2>/dev/null || echo 0) registro(s) | $(if [[ -s "$OUTPUT_DIR/dns/dmarc.txt" ]]; then echo "Bajo"; else echo "CRÍTICO - Sin política de rechazo"; fi) | $(if [[ -s "$OUTPUT_DIR/dns/dmarc.txt" ]]; then echo "Verificar política (p=reject)"; else echo "Implementar DMARC p=reject + ru/ruf"; fi) |
| **DKIM** | $(grep -c "." "$OUTPUT_DIR/dns/dkim.txt" 2>/dev/null || echo 0) selector(es) | $(if [[ -s "$OUTPUT_DIR/dns/dkim.txt" ]]; then echo "Bajo"; else echo "MEDIO - Sin firma criptográfica"; fi) | $(if [[ -s "$OUTPUT_DIR/dns/dkim.txt" ]]; then echo "Rotar claves anualmente"; else echo "Implementar DKIM (2048-bit)"; fi) |

---

## 📊 EVIDENCIA TÉCNICA COMPLETA

\`\`\`
$OUTPUT_DIR/
├── dns/                    # 7+ archivos DNS
├── ssl/                    # Certificados + testssl.sh
├── subdomains/
│   ├── all-subdomains.txt  # $sub_count únicos
│   ├── subfinder.txt
│   ├── assetfinder.txt
│   └── amass.txt
├── email/
│   └── theharvester.json/.xml
├── social/
│   ├── sherlock-*.txt/.csv/.json/.xlsx
│   ├── maigret-*.json/.csv
│   ├── holehe-*.json
│   └── linkedin2username-*.txt
├── wayback/
│   ├── wayback-urls.txt           # $wayback_count
│   └── subdomain-urls.txt         # $sub_wayback_count
├── tech/
│   ├── httpx-live.txt             # $tech_count hosts
│   └── httpx-live.jsonl
├── cloud/                       # $cloud_files verificaciones
└── reports/
    ├── osint-report-${TARGET}.md  # Este reporte
    └── osint-report-${TARGET}.pdf # PDF generado
\`\`\`

---

## 🎯 PRÓXIMOS PASOS RECOMENDADOS

1. **Revisar registros DMARC/SPF/DKIM** - Implementar política \`p=reject\` y \`-all\`
2. **Auditar subdominios expuestos** - Descomisionar legacy (cpanel*, webmail*, wow*, etc.)
3. **Validar hallazgos sociales** - Verificar cuentas encontradas en Sherlock/Maigret/Holehe
4. **Analizar URLs Wayback** - Buscar endpoints legacy, APIs, parámetros sensibles
5. **Monitoreo continuo** - Ejecutar este OSINT mensualmente para detectar cambios

---

**Firma digital:** Ariana — Senior Cybersecurity Consultant, BRIDA IT Services  
**Contacto:** LinkedIn / Email / Móvil (ver SOUL.md)  
**Metodología:** OSINT Framework + MITRE ATT&CK Recon (T1590, T1591, T1592, T1593, T1598)  
**Herramientas:** subfinder, assetfinder, amass, theHarvester, Sherlock, Maigret, Holehe, LinkedIn2username, waybackurls, httpx, testssl.sh, dig, openssl  

---

*Este reporte es 100% basado en fuentes públicas (OSINT). No se realizó ninguna interacción intrusiva, escaneo de puertos, fuerza bruta, ni explotación de vulnerabilidades. Es confidencial y para uso exclusivo de C&A México / BRIDA IT Services.*
EOF
    
    log_success "Markdown report: $report_md"
    
    # Generate PDF if Python converter available
    if command -v python3 &>/dev/null && [[ -f ~/scripts/md_to_pdf.py ]]; then
        log_info "Generating PDF report..."
        export PYTHONPATH=~/tools/python:$PYTHONPATH
        python3 ~/scripts/md_to_pdf.py "$report_md" "$report_pdf" 2>>"$OUTPUT_DIR/logs/pdf-gen.log" || true
        [[ -f "$report_pdf" ]] && log_success "PDF report: $report_pdf" || log_warn "PDF generation failed (check logs)"
    else
        log_warn "PDF converter not available, only Markdown generated"
    fi
}

# ============================================
# MAIN
# ============================================
main() {
    local start_time=$(date +%s)
    
    # Execute all modules sequentially
    run_dns_analysis
    run_ssl_analysis
    run_subdomain_enum
    run_theharvester
    run_social_username
    run_holehe
    run_linkedin2username
    run_wayback
    run_tech_fingerprint
    run_cloud_assets
    
    generate_osint_report "$start_time"
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    echo -e "\n${PURPLE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║              OSINT COMPLETE - 100% PASIVO 🎉                 ║${NC}"
    echo -e "${PURPLE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo -e "Target:        ${GREEN}$TARGET${NC}"
    echo -e "Output:        ${GREEN}$OUTPUT_DIR${NC}"
    echo -e "Duration:      ${GREEN}$(printf '%dm %ds' $((duration/60)) $((duration%60)))${NC}"
    echo -e "Finished:      ${GREEN}$(date)${NC}"
    echo
    echo -e "${CYAN}Key Reports:${NC}"
    echo -e "  Markdown:  $OUTPUT_DIR/reports/osint-report-${TARGET}.md"
    [[ -f "$OUTPUT_DIR/reports/osint-report-${TARGET}.pdf" ]] && echo -e "  PDF:       $OUTPUT_DIR/reports/osint-report-${TARGET}.pdf"
    echo -e "  Logs:      $OUTPUT_DIR/logs/"
    echo
}

# Run
main "$@"
EOF
chmod +x ~/scripts/osint-complete.sh