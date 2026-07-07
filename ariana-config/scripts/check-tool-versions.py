#!/usr/bin/env python3
"""
check-tool-versions.py
Compara versiones locales de herramientas de pentesting vs latest release en GitHub.
Creado para Hermes Weekly Health Check - Julio 2026
Autor: Ariana (Hermes Agent) para Roger Torres
"""

import subprocess
import json
import urllib.request
import urllib.error
import re
import sys
from datetime import datetime

# Herramientas críticas: (nombre, comando_local, github_repo)
TOOLS = [
    ("nuclei",      "nuclei -version 2>&1",                                              "projectdiscovery/nuclei"),
    ("sqlmap",      "sqlmap --version 2>&1",                                             "sqlmapproject/sqlmap"),
    ("nmap",        "nmap --version 2>&1",                                               "nmap/nmap"),
    ("nikto",       "nikto -Version 2>&1",                                               "sullo/nikto"),
    ("whatweb",     "whatweb --version 2>&1",                                            "urbanadventurer/WhatWeb"),
    ("testssl",     "$HOME/tools/testssl.sh/testssl.sh --version 2>&1 || testssl.sh --version 2>&1", "drwetter/testssl.sh"),
    ("hydra",       "hydra -h 2>&1",                                                     "vanhauser-thc/thc-hydra"),
    ("gobuster",    "gobuster --version 2>&1 || gobuster version 2>&1",                  "OJ/gobuster"),
    ("ffuf",        "ffuf -V 2>&1",                                                      "ffuf/ffuf"),
    ("wpscan",      "wpscan --version 2>&1 | grep -iE '[0-9]+\\.[0-9]+\\.[0-9]+'",      "wpscanteam/wpscan"),
    ("httpx",       "$HOME/.local/bin/httpx -version 2>&1 | grep -oE 'v[0-9]+\\.[0-9]+\\.[0-9]+' || echo 'unknown'", "projectdiscovery/httpx"),
    ("subfinder",   "subfinder -version 2>&1",                                           "projectdiscovery/subfinder"),
    ("amass",       "amass -version 2>&1",                                               "owasp-amass/amass"),
    ("waybackurls", "which waybackurls 2>&1 && echo 'version-unknown'",                   "tomnomnom/waybackurls"),
    ("assetfinder", "which assetfinder 2>&1 && echo 'version-unknown'",                   "tomnomnom/assetfinder"),
]

GITHUB_API = "https://api.github.com/repos/{}/releases/latest"
GITHUB_TAGS = "https://api.github.com/repos/{}/tags"
TIMEOUT = 10


def get_github_latest(repo: str) -> str:
    """Get latest release tag from GitHub API. Falls back to tags."""
    headers = {"Accept": "application/vnd.github+json", "User-Agent": "Hermes-HealthCheck"}
    
    # Try releases/latest first
    try:
        req = urllib.request.Request(GITHUB_API.format(repo), headers=headers)
        with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
            data = json.loads(resp.read())
            tag = data.get("tag_name", "")
            if tag:
                return tag
    except (urllib.error.URLError, urllib.error.HTTPError, json.JSONDecodeError, KeyError):
        pass
    
    # Fallback: try tags
    try:
        req = urllib.request.Request(GITHUB_TAGS.format(repo), headers=headers)
        with urllib.request.urlopen(req, timeout=TIMEOUT) as resp:
            data = json.loads(resp.read())
            if data and isinstance(data, list):
                return data[0].get("name", "")
    except (urllib.error.URLError, urllib.error.HTTPError, json.JSONDecodeError, KeyError, IndexError):
        pass
    
    return ""


def get_local_version(cmd: str) -> str:
    """Run local command and return its output (first line)."""
    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, timeout=15
        )
        output = (result.stdout + result.stderr).strip()
        if output:
            return output.split("\n")[0]
    except (subprocess.TimeoutExpired, FileNotFoundError, Exception):
        pass
    return ""


def extract_version(raw: str, tool_name: str = "") -> str:
    """Extract a clean version number from raw command output."""
    # Try to find version patterns like v3.4.6, 1.10.6, 2.6.0
    match = re.search(r'[vV]?(\d+\.\d+(?:\.\d+)?)', raw)
    if match:
        return match.group(1)
    return raw.strip()


def normalize_version(v: str) -> str:
    """Normalize version string for comparison."""
    v = v.strip()
    if v.startswith('v') or v.startswith('V'):
        v = v[1:]
    return v


def main():
    results = []
    has_updates = 0
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    results.append("📦 PENTEST TOOL VERSION CHECK vs GITHUB LATEST")
    results.append(f"   Fecha: {timestamp}")
    results.append("")
    results.append(f"Verificando {len(TOOLS)} herramientas críticas...")
    results.append("")
    
    for name, cmd, repo in TOOLS:
        print(f"   Checking {name}...", file=sys.stderr)
        
        # Get local version
        local_raw = get_local_version(cmd)
        
        if not local_raw:
            results.append(f"⚠️  {name}: NO INSTALADO o no se pudo obtener versión local")
            results.append(f"      Repo: https://github.com/{repo}")
            has_updates = 1
            continue
        
        local_ver = extract_version(local_raw, name)
        
        # Get GitHub latest
        github_raw = get_github_latest(repo)
        
        if not github_raw:
            results.append(f"ℹ️  {name}: local={local_ver} | GitHub API sin respuesta o rate-limited")
            results.append(f"      Repo: https://github.com/{repo}")
            continue
        
        github_ver = normalize_version(github_raw)
        
        # Compare
        if local_ver == github_ver:
            results.append(f"✅ {name}: {local_ver} (al día)")
        else:
            results.append(f"⚠️  {name}: ACTUALIZACIÓN DISPONIBLE")
            results.append(f"      Local:     {local_ver}")
            results.append(f"      GitHub:    {github_ver}")
            results.append(f"      Repo:      https://github.com/{repo}/releases")
            has_updates = 1
    
    results.append("")
    
    if has_updates == 0:
        results.append("✅ Todas las herramientas están al día con latest release en GitHub")
    else:
        results.append("⚠️  Se encontraron actualizaciones disponibles o herramientas faltantes")
        results.append("   Revisar entradas marcadas arriba")
    
    # Print results to stdout
    print("\n".join(results))
    
    sys.exit(has_updates)


if __name__ == "__main__":
    main()
