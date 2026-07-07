#!/bin/bash
# check-tool-versions.sh
# Compara versiones locales de herramientas de pentesting vs latest release en GitHub
# Creado para Hermes Weekly Health Check - Julio 2026
# Autor: Ariana (Hermes Agent) para Roger Torres

set -euo pipefail

# Colores/badges
OK="✅"
WARN="⚠️"
ERR="❌"
INFO="ℹ️"

RESULTS_FILE=$(mktemp)
HAS_UPDATES=0

echo "📦 PENTEST TOOL VERSION CHECK vs GITHUB LATEST" >> "$RESULTS_FILE"
echo "   Fecha: $(date '+%Y-%m-%d %H:%M:%S')" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"

# Function: get latest release tag from GitHub API
get_github_latest_release() {
    local repo="$1"
    local tag=""
    
    tag=$(curl -s --max-time 10 \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/${repo}/releases/latest" 2>/dev/null \
        | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tag_name',''))" 2>/dev/null)
    
    if [ -z "$tag" ] || [ "$tag" = "None" ]; then
        tag=$(curl -s --max-time 10 \
            -H "Accept: application/vnd.github+json" \
            "https://api.github.com/repos/${repo}/tags" 2>/dev/null \
            | python3 -c "import sys,json; d=json.load(sys.stdin); print(d[0]['name'] if d else '')" 2>/dev/null)
    fi
    
    echo "$tag"
}

# Function: normalize version string
normalize_version() {
    local v="$1"
    v=$(echo "$v" | sed 's/^[vV]//')
    v=$(echo "$v" | xargs)
    echo "$v"
}

# Function: compare a tool
# Args: tool_name  local_version_cmd  github_repo
check_tool() {
    local tool_name="$1"
    local local_cmd="$2"
    local github_repo="$3"
    
    echo "   Checking $tool_name..." >&2
    
    local local_ver=""
    local_ver=$(eval "$local_cmd" 2>/dev/null | head -1) || local_ver=""
    
    if [ -z "$local_ver" ]; then
        echo "$WARN $tool_name: NO INSTALADO o no se pudo obtener versión local" >> "$RESULTS_FILE"
        echo "      Repo: https://github.com/$github_repo" >> "$RESULTS_FILE"
        HAS_UPDATES=1
        return
    fi
    
    local local_ver_clean
    local_ver_clean=$(echo "$local_ver" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)
    if [ -z "$local_ver_clean" ]; then
        local_ver_clean=$(echo "$local_ver" | xargs)
    fi
    
    local github_ver=""
    github_ver=$(get_github_latest_release "$github_repo")
    
    if [ -z "$github_ver" ] || [ "$github_ver" = "None" ]; then
        echo "$INFO $tool_name: local=$local_ver_clean | GitHub API sin respuesta o rate-limited" >> "$RESULTS_FILE"
        echo "      Repo: https://github.com/$github_repo" >> "$RESULTS_FILE"
        return
    fi
    
    local github_ver_clean
    github_ver_clean=$(normalize_version "$github_ver")
    
    if [ "$local_ver_clean" = "$github_ver_clean" ]; then
        echo "$OK $tool_name: $local_ver_clean (al día)" >> "$RESULTS_FILE"
    else
        echo "$WARN $tool_name: ACTUALIZACIÓN DISPONIBLE" >> "$RESULTS_FILE"
        echo "      Local:     $local_ver_clean" >> "$RESULTS_FILE"
        echo "      GitHub:    $github_ver_clean" >> "$RESULTS_FILE"
        echo "      Repo:      https://github.com/$github_repo/releases" >> "$RESULTS_FILE"
        HAS_UPDATES=1
    fi
}

# ═══════════════════════════════════════════════════════════════
# HERRAMIENTAS CRÍTICAS DE PENTESTING
# Formato: nombre@@@comando_versión_local@@@owner/repo
# Usamos @@@ como separador para evitar conflictos con pipes en comandos
# ═══════════════════════════════════════════════════════════════

TOOLS=(
    "nuclei@@@nuclei -version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@projectdiscovery/nuclei"
    "sqlmap@@@sqlmap --version 2>&1 | head -1@@@sqlmapproject/sqlmap"
    "nmap@@@nmap --version 2>&1 | grep 'Nmap version' | grep -oE '[0-9]+\.[0-9]+' | head -1@@@nmap/nmap"
    "nikto@@@nikto -Version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@sullo/nikto"
    "whatweb@@@whatweb --version 2>&1 | grep -oE 'WhatWeb version [0-9]+\.[0-9]+' | grep -oE '[0-9]+\.[0-9]+'@@@urbanadventurer/WhatWeb"
    "testssl@@@testssl.sh --version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+' | head -1@@@drwetter/testssl.sh"
    "hydra@@@hydra -h 2>&1 | head -1 | grep -oE 'v[0-9]+\.[0-9]+'@@@vanhauser-thc/thc-hydra"
    "gobuster@@@gobuster version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'@@@OJ/gobuster"
    "ffuf@@@ffuf -V 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1@@@ffuf/ffuf"
    "wpscan@@@wpscan --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@wpscanteam/wpscan"
    "httpx@@@httpx -version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@projectdiscovery/httpx"
    "subfinder@@@subfinder -version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@projectdiscovery/subfinder"
    "amass@@@amass -version 2>&1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1@@@owasp-amass/amass"
    "waybackurls@@@waybackurls -version 2>&1 | head -1@@@tomnomnom/waybackurls"
    "assetfinder@@@assetfinder -version 2>&1 | head -1@@@tomnomnom/assetfinder"
)

echo "Verificando ${#TOOLS[@]} herramientas críticas..." >&2
echo "" >> "$RESULTS_FILE"

for tool_entry in "${TOOLS[@]}"; do
    IFS='@@@' read -r name cmd repo <<< "$tool_entry"
    check_tool "$name" "$cmd" "$repo"
done

echo "" >> "$RESULTS_FILE"

if [ $HAS_UPDATES -eq 0 ]; then
    echo "$OK Todas las herramientas están al día con latest release en GitHub" >> "$RESULTS_FILE"
else
    echo "$WARN Se encontraron actualizaciones disponibles o herramientas faltantes" >> "$RESULTS_FILE"
    echo "   Revisar entradas marcadas arriba" >> "$RESULTS_FILE"
fi

cat "$RESULTS_FILE"
rm -f "$RESULTS_FILE"
exit $HAS_UPDATES
