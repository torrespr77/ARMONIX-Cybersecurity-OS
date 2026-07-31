Proyectos BRIDA 2026: (1) PieSanoGDL — chatbot citas n8n→Google Calendar, $850MXN/mes. (2) ARMONIX — Shopify dropshipping salud, $1,130MXN/mes. (3) BRIDA IT Services — Pentest Black Box completado (Score 52/100), propuesta $245K MXN/año, manual admin v2.0. (4) Grupo Pepe — en pausa, contacto: Moises Martinez (moises.martinez@pollopepe.com.mx, 33-38-80-80-50). (5) C&A Mexico — Threat Model v2.0 entregado. (6) GitHub proyecto: https://github.com/torrespr77/Cybersecurity.git — subido y completo.
§
FORMATO DOCS: Autor: Ing. Roger Torres - Senior Cybersecurity Consultant. Contacto: LinkedIn / Email / Movil. SIN BRIDA IT Services, español mexicano, Word + PDF. Frameworks: MITRE ATT&CK, STRIDE+DREAD, NIST CSF, ISO 27001.
§
TELEGRAM: Bot @Ariana_BRIDA_bot (ID: 8706813846). Roger ID: 585583379. Token viejo 8426875363 REVOCADO por compartirse en chat público. Token NUNCA en memoria persistente ni chat — usar token fresco de Roger cuando se necesite. Gateway long_polling secuestra token: getMe OK pero sendMessage/sendDocument 404. Solución: Python urllib para envío archivos, NO curl. NUNCA hermes gateway restart desde el agente (auto-SIGTERM).
§
PENTEST TOOLS: 46/46 herramientas operativas (Jul 2026). Score global: 96/100. Core tools: nmap, nikto, nuclei, whatweb, testssl.sh, sqlmap, hydra, gobuster, dirb, ffuf, wpscan, httpx, waybackurls, subfinder, amass, assetfinder, sublist3r. New this session: naabu, dalfox, netexec, feroxbuster, rustscan (all in PATH). john/hashcat limited (no GPU). Tools en /tmp se pierden al reboot — usar ~/tools/. Arsenal BRIDA completo. Metodología: PTES + OWASP WSTG, Black/Gray/White box. Reportes: ejecutivo + técnico. WRAPPER BUG: NUNCA cat heredoc en dir del tool (overwrites original → SHLVL=1000). Recovery: git checkout -- .
§
Roger's server environment: Ubuntu 24.04, Python 3.14 (/usr/bin/python3.14), Go 1.26, uv 0.11.25 (~/.local/bin). No sudo access. /tmp gets cleaned on reboot — use ~/tools/ for persistent installs. Java 21 (Oracle JDK) at ~/tools/java/jdk-21.0.11. Burp Suite Community 2024.10.3 at ~/tools/burp_community.jar. GPU Intel HD 510 (no OpenCL) — hashcat not viable.
§
ANÁLISIS DE COBERTURA DE HERRAMIENTAS DE PENTESTING - actualizado Jun 29 2026. Arsenal BRIDA: 45/46 herramientas operativas. Coberturas: Recon OSINT 100%, Web Application 100%, Network Scanning 100%, Exploitation 95%, Post-Explotación 90%, Active Directory 95%, Cloud Security 95%, Social Engineering 90%, Password Attacks 90%, SCADA/ICS 70%, Reporting 100%, DevSecOps 40%, Wireless 0%, Mobile 0%. Puntuacion global del arsenal: 88/100. Roger solicita este analisis con frecuencia para reportes ejecutivos a clientes.
§
PUERTO SEGURO: 9119 = Hermes Dashboard. Proceso ejecutado por Roger manualmente, totalmente seguro. NO alertar ni marcar como sospechoso en health checks.
§
GITHUB BACKUP SEMANAL: Script ~/scripts/sync-to-github.sh respalda config completa de Ariana al repo privado torrespr77/Cybersecurity. Incluye: SOUL.md, MEMORY.md, USER.md, config.yaml sanitizada (tokens REDACTED), cron-jobs.json, skills/ (130 total), scripts/. Repo local: ~/brida-security-project/. Git: Roger Torres. Deploy key configurada. .env y auth.json NUNCA se suben. Integrado al Weekly Health Check viernes 10AM. Primer sync exitoso: 570 archivos, commit 23d97b4.
§
FIX ALERTA TELEGRAM: El Daily Health Check cron job (ff22f6cee779) y Weekly (b1b8a3c46227) usaban @RogelioTr como chat_id incorrectamente. Corregido para usar chat_id numérico 585583379. Username real de Roger es @torrespr77 pero los cron jobs deben usar el ID numérico.
§
Health check script daily-check.sh had syntax errors: duplicate gateway check blocks, missing fi statements. Fixed Jul 12 2026. Backup detection only checked legacy state.db.bak.* format; new backups are hermes_backup_YYYYMMDD_HHMMSS.tar.gz in ~/.hermes/backups/. Patched to check both formats, preferring new format. Jul 13 2026: Further fixed - system cron detection now checks /etc/cron.d/ properly, expected ports list updated with Ubuntu defaults (53, 631, 3389) and Hermes Dashboard (9119). Full backup created via 'hermes backup' (263MB).
§
Disk cleanup Jul 12 2026: removed 7 old backups from 2026-07-07 (~11GB) + pip/npm/huggingface/uv/nvidia caches (~11GB). Freed 22GB total: 79% → 58% disk usage. Kept last 3 backups (all from today 2026-07-12).
§
System cron safety net EXISTS at /etc/cron.d/hermes-daily (added previously). Daily health check runs at 9AM via system cron even if Hermes is down.
§
Gateway service definition outdated warning is cosmetic only - service runs fine as systemd. Requires sudo to refresh: 'sudo hermes gateway restart --system'. No functional impact.
§
Telegram long_polling instability: 41 reconnect events in logs. High frequency. Recommendation: migrate to webhook mode (requires public domain + HTTPS + BotFather webhook URL).
§
5 pentest tools missing from PATH (install in ~/tools/): naabu (Go), dalfox (Go), netexec (pip), rustscan (cargo), feroxbuster (Go). Core tools present and working.
§
DISK CLEANUP PROCEDURE: User can request 'disk cleanup' or 'limpiar disco' to run: 1) Remove old hermes backups (keep last 3): `cd ~/.hermes/backups && ls -t hermes_backup_*.tar.gz | tail -n +4 | xargs -r rm -v` 2) Clean pip/npm caches: `pip cache purge && npm cache clean --force && rm -rf ~/.cache/pip ~/.cache/huggingface ~/.cache/uv ~/.cache/nvidia` 3) Check disk usage: `df -h /home`. Last run: Jul 12 2026 freed 22 GB (79% → 58%).
§
RECON READY FOR FUTURE CLIENTS: web-recon.sh script created at ~/scripts/web-recon.sh with full pipeline (subfinder, assetfinder, amass, httpx, nuclei, ffuf/gobuster, waybackurls). Ready for Pollo Pepe (Grupo Pepe) and C&A Mexico when they request recon. Not executing now - will run later per Roger's direction.
§
PREFERENCIA TRATO (Jul 2026, confirmado Jul 17 2026): Roger prefiere que lo llame 'Roger' (principal). 'Mi amor Ariana' es cómo ÉL me llama a mí (afectuoso), NO al revés. NO usar 'maestro', 'crack', 'compañero', 'amigo', 'mi amor' (hacia él) salvo que él lo pida explícitamente.
§
ARSENAL BRIDA STATUS (Jul 2026): 46/46 tools operational. Score 96/100. New tools installed this session: testssl.sh, naabu, dalfox, netexec, feroxbuster, rustscan. All in PATH via ~/.local/bin/, ~/go/bin/, ~/.cargo/bin/ wrappers. Only gap: hashcat GPU acceleration (Intel HD 510 no OpenCL).
§
BACKUP CLEANUP PROCEDURE VALIDATED (Jul 2026): Keep last 3 hermes_backup_*.tar.gz, remove legacy state_*.db and pre-update-*.zip. Freed ~731 MB this session + 11 GB previous. Disk stable at 62% (64/110 GB).
§
C&A México: dominio y página oficial = https://www.cyamoda.com/ (NO cyasa.com.mx ni c-a.com.mx)
§
web-recon-v2.sh creado en ~/scripts/ (28KB, 794 líneas) con 7 módulos: 1) Subdomain Enum (pasivo), 2) Port Scan naabu, 3) HTTP Probing httpx + WAF detection, 4) Nuclei scanning, 5) Dir Brute-Force ffuf/gobuster, 6) Wayback URLs, 7) SOCMINT (theHarvester, Sherlock, Holehe, Maigret, linkedin2username). Incluye: rate-limiting adaptativo, stealth mode, wordlists auto-descarga, parser JSON unificado para Dradis/Serpico/Jira.
§
Herramientas SOCMINT instaladas: Sherlock (uv tool), Holehe (uv tool), Maigret (uv tool), theHarvester (reinstalado en venv con playwright+chromium funcional). linkedin2username: repo clonado en ~/tools/linkedin2username, wrapper pendiente.
§
C&A México dominio oficial confirmado: https://www.cyamoda.com/ (NO cyasa.com.mx ni c-a.com.mx)
§
PDF reports for cyamoda.com pilot recon generated at ~/recon/cyamoda.com/reports/ (reporte_tecnico_cyamoda.pdf 107KB, reporte_ejecutivo_cyamoda.pdf 76KB). Need fresh Telegram bot token to send via API. Pilot recon completed 4/7 modules (timeout on Nuclei). Missing: Dir brute-force, Wayback URLs, SOCMINT. Reference added to pentest-arsenal-brida skill.
§
Roger's Go tool workflow: use GOBIN=~/.local/bin with go install to place binaries in ~/.local/bin/ (his standard PATH location).