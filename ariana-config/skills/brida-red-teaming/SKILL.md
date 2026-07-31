---
name: "brida-red-teaming"
description: "Skill integral de Red Teaming para BRIDA IT Services. Cubre compromiso de alcance completo (full-scope), ataques a Active Directory, simulaciones de phishing, movimiento lateral, infraestructura C2 (Command & Control), y ejercicios Purple Team. Mapea hallazgos a MITRE ATT&CK, NIST CSF y D3FEND."
triggers:
  - "red team"
  - "red teaming"
  - "evaluación de seguridad ofensiva"
  - "compromiso de alcance completo"
  - "full-scope engagement"
  - "ataque a Active Directory"
  - "AD attack"
  - "phishing simulation"
  - "simulación de phishing"
  - "movimiento lateral"
  - "lateral movement"
  - "C2 infrastructure"
  - "command and control"
  - "purple team"
  - "ejercicio purple team"
  - "emulación de adversario"
  - "adversary emulation"
  - "BRIDA red team"
  - "pentest avanzado"
  - "evaluación de intrusión"
category: "offensive-security"
---

# brida-red-teaming

## Descripción General

Este skill proporciona la metodología, herramientas y flujos de trabajo para ejecutar evaluaciones de Red Teaming de alcance completo para BRIDA IT Services. Está diseñado para simular adversarios realistas contra la infraestructura del cliente, cubriendo desde el acceso inicial hasta la consecución de objetivos (objectives), con mapeo completo a **MITRE ATT&CK**, **NIST CSF** y **D3FEND**.

---

## Fases de un Engagement Red Team

### 1. Definición de Alcance y Reglas de Engagement (ROE)

Antes de iniciar cualquier actividad:

- **Objetivos del engagement**: Definir los activos críticos (crown jewels) que el equipo debe comprometer o intentar acceder.
- **Alcance**: Redes, dominios, aplicaciones, sistemas cloud, usuarios, endpoints.
- **Reglas de Engagement (ROE)**:
  - Horarios permitidos para ataques
  - Técnicas prohibidas (ej. denegación de servicio, destrucción de datos)
  - Puntos de contacto para escalamiento
  - Procedimientos de emergencia si se detecta un incidente real
- **Nivel de emulación**: Seleccionar el perfil de adversario (APT29, FIN7, ransomware operator, insider threat, etc.)

**Mapeo NIST CSF**: `ID.RA` (Risk Assessment), `PR.IP` (Security Configuration Management)

---

### 2. Reconocimiento y OSINT

#### 2.1 Reconocimiento Pasivo

| Actividad | Herramientas | Técnica MITRE |
|-----------|-------------|---------------|
| Enumeración de dominios y subdominios | `amass`, `subfinder`, `crt.sh`, `dnsdumpster` | T1590 (Gather Victim Network Information) |
| OSINT en empleados | `theHarvester`, `LinkedIn`, `Hunter.io`, `emailrep.io` | T1589 (Gather Victim Identity Information) |
| Búsqueda de credenciales filtradas | `dehashed`, `Have I Been Pwned`, `scylla` | T1589.001 (Credentials) |
| Análisis de metadatos | `FOCA`, `Metagoofil`, `exiftool` | T1590.002 (DNS) |
| Enumeración de tecnologías | `Wappalyzer`, `BuiltWith`, `Shodan`, `Censys` | T1590.005 (IP Addresses) |
| Google Dorking | Operadores avanzados de búsqueda | T1593 (Search Open Websites/Domains) |

#### 2.2 Reconocimiento Activo

| Actividad | Herramientas | Técnica MITRE |
|-----------|-------------|---------------|
| Escaneo de puertos | `nmap`, `masscan`, `rustscan` | T1046 (Network Service Discovery) |
| Enumeración de servicios | `enum4linux`, `smbclient`, `ldapsearch`, `rpcclient` | T1018 (Remote System Discovery) |
| Enumeración web | `gobuster`, `ffuf`, `dirsearch`, `nikto` | T1083 (File and Directory Discovery) |
| Fingerprinting de SO | `nmap -O`, `p0f` | T1082 (System Information Discovery) |

**Mapeo D3FEND**: `Network Traffic Analysis`, `Credential Compromise Scope Analysis`

---

### 3. Acceso Initial (Initial Access)

#### 3.1 Phishing Simulations

Las simulaciones de phishing son el vector de acceso inicial más común y efectivo.

**Metodología:**

1. **Recolección de inteligencia**: Identificar objetivos, plantillas de correo internas, estilo de comunicación.
2. **Diseño del payload**:
   - Correos con adjuntos maliciosos (`.docm`, `.xlsm`, `.iso`, `.lnk`, `.html`)
   - Enlaces a páginas de credenciales clonadas (credential harvesting)
   - QR codes (quishing)
   - Vishing (phishing telefónico)
3. **Infraestructura de phishing**:
   - Registro de dominios lookalike (typosquatting)
   - Configuración de SPF/DKIM/DMARC para evadir filtros
   - Uso de GoPhish, Evilginx2, o King Phisher
4. **Ejecución y monitoreo**:
   - Tasa de apertura, tasa de clics, tasa de envío de credenciales
   - Detección por parte del SOC del cliente

**Herramientas:**
- `GoPhish` — Framework de phishing completo
- `Evilginx2` — MitM para bypass de MFA
- `King Phisher` — Phishing campaign management
- `SET (Social Engineering Toolkit)` — Payloads y plantillas
- `Phishing Frenzy` — Gestión de campañas

**Mapeo MITRE ATT&CK:**
- T1566.001 (Spearphishing Attachment)
- T1566.002 (Spearphishing Link)
- T1566.004 (Spearphishing Voice / Vishing)
- T1204.001 (User Execution: Malicious Link)
- T1204.002 (User Execution: Malicious File)

**Mapeo NIST CSF**: `PR.AT` (Security Awareness Training), `DE.CM` (Security Continuous Monitoring)

**Mapeo D3FEND**: `Email Filtering`, `URL Analysis`, `User Behavior Analysis`

#### 3.2 Otros Vectores de Acceso Inicial

| Vector | Técnica MITRE | Herramientas |
|--------|---------------|-------------|
| Explotación de servicios expuestos | T1190 (Exploit Public-Facing Application) | `Metasploit`, `nuclei`, `CVE search` |
| External Remote Services | T1133 (External Remote Services) | VPN brute force, RDP exposure |
| Supply Chain Compromise | T1195 (Supply Chain Compromise) | Análisis de dependencias, paquetes comprometidos |
| Valid Accounts | T1078 (Valid Accounts) | Credenciales filtradas, password spraying |
| Trusted Relationship | T1199 (Trusted Relationship) | Compromiso de partner/proveedor |

---

### 4. Active Directory Attacks

Active Directory es el principal objetivo en entornos corporativos Windows. Esta sección cubre las técnicas más relevantes.

#### 4.1 Enumeración de AD

| Actividad | Herramientas | Técnica MITRE |
|-----------|-------------|---------------|
| Enumeración de usuarios, grupos, GPOs | `BloodHound`, `ADRecon`, `ldapdomaindump`, `PowerView` | T1087.002 (Domain Account) |
| Mapeo de relaciones de confianza | `BloodHound`, `nltest`, `Get-ADTrust` | T1482 (Domain Trust Discovery) |
| Enumeración de SPNs (Kerberoasting) | `GetUserSPNs.py`, `BloodHound` | T1558.003 (Kerberoasting) |
| Búsqueda de sesiones activas | `BloodHound`, `NetSessionEnum`, `CrackMapExec` | T1046 (Network Service Discovery) |
| Enumeración de ACLs | `BloodHound`, `ADACLScanner`, `PowerView` | T1069.002 (Domain Groups) |
| Enumeración de certificados AD CS | `Certify`, `Certipy`, `PSPKIAudit` | T1649 (Steal Enterprise Certificates) |

#### 4.2 Ataques de Credenciales

| Ataque | Técnica MITRE | Herramientas |
|--------|---------------|-------------|
| Kerberoasting | T1558.003 | `impacket-GetUserSPNs`, `Rubeus`, `hashcat` |
| AS-REP Roasting | T1558.004 | `impacket-GetNPUsers`, `Rubeus` |
| DCSync | T1003.006 (DCSync) | `impacket-secretsdump`, `mimikatz` |
| LLMNR/NBT-NS Poisoning | T1557.001 (LLMNR/NBT-NS Poisoning) | `Responder`, `mitm6` |
| NTLM Relay | T1557.001 | `ntlmrelayx.py`, `Responder` |
| Password Spraying | T1110.003 (Password Spraying) | `CrackMapExec`, `MailSniper`, `Spray` |
| Credential Dumping (SAM, LSASS) | T1003.001, T1003.002 | `mimikatz`, `ProcDump`, `PPLdump`, `nanodump` |
| LSA Secrets & DPAPI | T1003.004, T1555.004 | `mimikatz`, `dpapi.py`, `pypykatz` |
| Golden Ticket | T1558.001 | `mimikatz`, `Rubeus`, `impacket-ticketer` |
| Silver Ticket | T1558.002 | `mimikatz`, `Rubeus` |
| Pass-the-Hash (PtH) | T1550.002 (Pass the Hash) | `CrackMapExec`, `impacket-psexec`, `mimikatz` |
| Pass-the-Ticket (PtT) | T1550.003 (Pass the Ticket) | `Rubeus`, `mimikatz`, `impacket` |
| Overpass-the-Hash (Pass-the-Key) | T1550.002 | `Rubeus`, `mimikatz` |

#### 4.3 Ataques a AD CS (Active Directory Certificate Services)

| Ataque | Técnica MITRE | Herramientas |
|--------|---------------|-------------|
| ESC1 — Vulnerable Certificate Template | T1649 | `Certify`, `Certipy` |
| ESC2 — Vulnerable Certificate Template | T1649 | `Certify`, `Certipy` |
| ESC3 — Vulnerable Certificate Request Agent | T1649 | `Certify`, `Certipy` |
| ESC4 — Vulnerable ACLs on Certificate Template | T1649 | `Certify`, `Certipy` |
| ESC8 — NTLM Relay to AD CS HTTP Endpoint | T1557.001 | `ntlmrelayx.py`, `certipy` |
| Shadow Credentials (Key Credential Link) | T1649 | `Certipy`, `Whisker` |
| Subordinate CA Abuse | T1649 | `Certify` |

#### 4.4 Privilegios y Escalación en AD

| Ataque | Técnica MITRE | Herramientas |
|--------|---------------|-------------|
| Abuso de GPO | T1484.001 (Group Policy Modification) | `GPO-at-scale`, `PowerView` |
| Abuso de ACLs (GenericAll, WriteDacl, etc.) | T1098 (Account Manipulation) | `BloodHound`, `PowerView`, `dacledit` |
| DNSAdmins Privilege Escalation | T1098 | `dnscmd`, `PowerView` |
| Unconstrained Delegation | T1550.003 | `Rubeus`, `PowerView`, `BloodHound` |
| Constrained Delegation Abuse | T1550.003 | `Rubeus`, `impacket-getST` |
| Resource-Based Constrained Delegation (RBCD) | T1550.003 | `impacket-addcomputer`, `Rubeus`, `PowerView` |
| Local Privilege Escalation | T1068 (Exploitation for Privilege Escalation) | `WinPEAS`, `PowerUp`, `Sherlock` |

**Mapeo NIST CSF**: `PR.AC` (Identity Management and Access Control), `PR.PT` (Protective Technology)
**Mapeo D3FEND**: `Credential Hardening`, `Authentication Strength`, `Access Control Configuration`

---

### 5. Movimiento Lateral (Lateral Movement)

#### 5.1 Técnicas de Movimiento Lateral

| Técnica | MITRE | Herramientas |
|---------|-------|-------------|
| PsExec / SMB | T1021.002 (SMB/Windows Admin Shares) | `impacket-psexec`, `CrackMapExec`, `PsExec` |
| WMI | T1047 (Windows Management Instrumentation) | `impacket-wmiexec`, `wmiexec.py`, `PowerShell` |
| WinRM | T1021.006 (Windows Remote Management) | `evil-winrm`, `CrackMapExec`, `PowerShell Remoting` |
| RDP | T1021.001 (Remote Desktop Protocol) | `xfreerdp`, `rdesktop`, `SharpRDP` |
| DCOM | T1021.003 (Distributed Component Object Model) | `PowerShell`, `SharpCOM` |
| SSH Hijacking | T1021.004 (SSH) | `ssh`, `sshuttle` |
| Remote Services | T1021 (Remote Services) | Varios |
| Tainted Shared Content | T1080 (Taint Shared Content) | Archivos compartidos, shortcuts |
| Application Deployment Software | T1017 (Application Deployment Software) | SCCM, Intune abuse |

#### 5.2 Técnicas de Evasión durante Movimiento Lateral

| Técnica | MITRE | Herramientas |
|---------|-------|-------------|
| Living off the Land (LotL) | T1218 (System Binary Proxy Execution) | `certutil`, `mshta`, `regsvr32`, `rundll32`, `wmic` |
| Process Injection | T1055 (Process Injection) | `Reflective DLL Injection`, `Process Hollowing` |
| Obfuscation | T1027 (Obfuscated Files or Information) | `Invoke-Obfuscation`, `ConfuserEx` |
| AMSI Bypass | T1562.001 (Impair Defenses: Disable or Modify Tools) | Técnicas de bypass de AMSI |
| ETW Bypass | T1562.006 (Impair Defenses: Indicator Blocking) | `Patch ETW`, `SilentMoonwalk` |
| Log Clearing | T1070.004 (Indicator Removal: File Deletion) | `wevtutil`, `Clear-EventLog` |

**Mapeo NIST CSF**: `PR.AC` (Access Control), `DE.AE` (Anomalies and Events), `DE.CM` (Security Continuous Monitoring)
**Mapeo D3FEND**: `Process Analysis`, `File Analysis`, `Network Traffic Analysis`

---

### 6. Infraestructura C2 (Command & Control)

#### 6.1 Frameworks C2

| Framework | Tipo | Características |
|-----------|------|-----------------|
| **Cobalt Strike** | Comercial | Beacon, malleable C2, team server, covert |
| **Sliver** | Open Source | Multi-protocol, implantes dinámicos, operator |
| **Mythic** | Open Source | Modular, multi-agent, API-driven |
| **Havoc** | Open Source | Moderno, GUI, malleable |
| **Brute Ratel C4 (BRc4)** | Comercial | Evasión avanzada, syscall, indirect syscalls |
| **NimPlant** | Open Source | Escrito en Nim, bajo footprint |
| **C2concealer** | Open Source | Generador de infraestructura C2 |
| **Merlin** | Open Source | HTTP/1.1, HTTP/2, HTTP/3 |

#### 6.2 Protocolos y Canales C2

| Protocolo | MITRE | Uso |
|-----------|-------|-----|
| HTTP/HTTPS | T1071.001 (Application Layer Protocol: Web Protocols) | C2 encubierto en tráfico web legítimo |
| DNS | T1071.004 (Application Layer Protocol: DNS) | DNS tunneling, DNS-over-HTTPS |
| SMB | T1071.002 (Application Layer Protocol: File Transfer Protocols) | Named pipes |
| ICMP | T1095 (Non-Application Layer Protocol) | ICMP tunneling |
| WebSocket | T1573 (Encrypted Channel) | C2 bidireccional en tiempo real |
| TCP/UDP Custom | T1572 (Protocol Tunneling) | Túneles personalizados |
| Cloud Services | T1102 (Web Service) | C2 via Slack, Discord, Google Drive, GitHub |
| Domain Fronting | T1090.004 (Proxy: Domain Fronting) | Ofuscación detrás de CDN |

#### 6.3 Técnicas de Evasión C2

| Técnica | MITRE | Descripción |
|---------|-------|-------------|
| Malleable C2 Profiles | T1001 (Data Obfuscation) | Perfiles que mimetizan tráfico legítimo |
| Jitter | T1001 | Variación aleatoria en intervalos de beacon |
| Sleep Mask | T1055.011 (Process Injection: Thread Execution Hacking) | Ofuscación de memoria del implante |
| Syscalls Directas | T1106 (Native API) | Evadir hooks de EDR |
| Indirect Syscalls | T1106 | Syscalls desde ntdll sin hook |
| Hardware Breakpoints | T1622 (Debugger Evasion) | Detección y evasión de debuggers |
| Call Stack Spoofing | T1036 (Masquerading) | Falsificación de call stack |
| Module Stomping | T1055.001 (Process Injection: DLL Injection) | Sobrescribir DLLs legítimas |
| Process Doppelgänging | T1055.013 | Transacciones NTFS para inyección |

#### 6.4 Infraestructura de Red C2

```
[C2 Server] ←→ [Redirectores] ←→ [Firewall] ←→ [Internet] ←→ [Target Network]
     ↑              ↑
[Team Server]   [VPS/CDN]      [Implante/Beacon en host comprometido]
```

**Componentes:**
- **Team Server**: Servidor central de gestión
- **Redirectores**: Capa intermedia para ofuscar el C2 real (Apache/Nginx reverse proxy, socat)
- **Dominios de cobertura**: Dominios legítimos con certificados válidos
- **CDN/Domain Fronting**: Cloudflare, Fastly para ocultar origen
- **Dead Drops**: Servicios cloud como intermediarios

**Herramientas de infraestructura:**
- `Cobalt Strike` — Team server y malleable C2
- `Sliver` — Operator y servidores
- `Mythic` — Dashboard y agentes
- `gophish` — Para phishing campaigns
- `RedELK` — Monitoreo de infraestructura red team
- `RedELK 2.0** — Versión mejorada con más capacidades
- `Egress-Assess` — Testing de egress filtering
- `Chameleon` — Ofuscación de perfiles C2

**Mapeo NIST CSF**: `DE.CM` (Security Continuous Monitoring), `DE.DP` (Detection Processes)
**Mapeo D3FEND**: `Network Traffic Analysis`, `Protocol Analysis`, `Certificate Analysis`

---

### 7. Persistencia (Persistence)

| Técnica | MITRE | Descripción |
|---------|-------|-------------|
| Registry Run Keys | T1547.001 (Boot or Logon Autostart Execution: Registry Run Keys) | `HKCU\Software\Microsoft\Windows\CurrentVersion\Run` |
| Scheduled Tasks | T1053.005 (Scheduled Task) | `schtasks`, `New-ScheduledTask` |
| WMI Event Subscriptions | T1546.003 (Event Triggered Execution: WMI Event Subscription) | Persistencia sin archivos |
| Startup Folder | T1547.001 | `Startup` directory |
| Services | T1543.003 (Windows Service) | Creación de servicios maliciosos |
| DLL Hijacking | T1574.001 (Hijack Execution Flow: DLL Search Order Hijacking) | Orden de búsqueda de DLLs |
| Golden Ticket | T1558.001 | Persistencia a nivel de dominio |
| Shadow Credentials | T1649 | Key Credential Link en AD |
| Group Policy Objects | T1484.001 | GPOs maliciosos |
| Web Shell | T1505.003 (Software Component: Web Shell) | Shells en servidores web |
| Account Creation | T1136 (Create Account) | Cuentas de servicio o administrador |

---

### 8. Exfiltración de Datos (Exfiltration)

| Técnica | MITRE | Herramientas |
|---------|-------|-------------|
| Exfiltration over C2 Channel | T1041 (Exfiltration Over C2 Channel) | Integrado en C2 framework |
| Exfiltration over Alternative Protocol | T1048 (Exfiltration Over Alternative Protocol) | DNS, ICMP tunneling |
| Exfiltration to Cloud Service | T1567.002 (Exfiltration to Cloud Storage) | Google Drive, OneDrive, S3 |
| Exfiltration over Web Service | T1567.001 (Exfiltration to Code Repository) | GitHub, GitLab, Pastebin |
| Exfiltration over Symmetric Encrypted Non-C2 Protocol | T1048.001 | HTTPS personalizado |
| Exfiltration via USB/Removable Media | T1052.001 (Exfiltration over Physical Medium) | Dispositivos físicos |
| Scheduled Transfer | T1029 (Scheduled Transfer) | Transferencias programadas |

**Mapeo NIST CSF**: `PR.DS` (Data Security), `DE.CM` (Security Continuous Monitoring)
**Mapeo D3FEND**: `Network Traffic Analysis`, `File Integrity Monitoring`

---

### 9. Purple Team Exercises

#### 9.1 Definición y Objetivos

Los ejercicios **Purple Team** combinan las capacidades ofensivas (Red Team) con las defensivas (Blue Team) para mejorar la postura de seguridad de manera colaborativa.

**Objetivos:**
- Validar la efectividad de controles de seguridad existentes
- Mejorar la detección y respuesta del SOC
- Identificar gaps en cobertura de MITRE ATT&CK
- Fortalecer la colaboración entre equipos ofensivos y defensivos
- Generar playbooks de respuesta basados en hallazgos reales

#### 9.2 Metodología Purple Team

```
┌─────────────────────────────────────────────────────────┐
│                   PURPLE TEAM LIFECYCLE                  │
│                                                         │
│  1. Planificación                                       │
│     ├── Seleccionar técnicas MITRE ATT&CK              │
│     ├── Definir escenarios de ataque                    │
│     └── Coordinar con Blue Team                         │
│                                                         │
│  2. Ejecución                                           │
│     ├── Red Team ejecuta técnica específica             │
│     ├── Blue Team monitorea y detecta                   │
│     └── Registro detallado de resultados                │
│                                                         │
│  3. Análisis                                            │
│     ├── ¿Fue detectado? ¿En qué fase?                  │
│     ├── Tiempo de detección (MTTD)                      │
│     ├── Tiempo de respuesta (MTTR)                      │
│     └── Gaps identificados                              │
│                                                         │
│  4. Remediación                                         │
│     ├── Nuevas reglas de detección (Sigma/YARA)        │
│     ├── Ajustes de configuración                        │
│     ├── Nuevos playbooks de respuesta                   │
│     └── Mejoras en herramientas de seguridad            │
│                                                         │
│  5. Validación                                          │
│     ├── Re-ejecutar técnica para validar fix            │
│     └── Documentar mejora en cobertura                  │
└─────────────────────────────────────────────────────────┘
```

#### 9.3 Herramientas Purple Team

| Herramienta | Función |
|-------------|---------|
| **Atomic Red Team** | Ejecución de tests MITRE ATT&CK automatizados |
| **CALDERA** | Emulación de adversarios automatizada |
| **Splunk ATT&CK App** | Visualización de cobertura ATT&CK |
| **ATT&CK Navigator** | Mapeo visual de técnicas |
| **Sigma** | Reglas de detección genéricas |
| **YARA** | Detección basada en patrones |
| **Elastic Security** | SIEM con detecciones ATT&CK-mapped |
| **Purple Knight** | Herramienta de evaluación de seguridad |
| **SNAP-ATTACK** | Mapeo de logs a MITRE ATT&CK |
| **DeTT&CT** | Detección, Tácticas, Técnicas y Cobertura de Threats |
| **OpenCTI** | Plataforma de Threat Intelligence |
| **Velociraptor** | DFIR y monitoreo de endpoints |
| **HELK** (Hunting ELK) | SIEM para threat hunting |

#### 9.4 Frameworks de Emulación de Adversarios

| Framework | Grupo Simulado | Alcance |
|-----------|---------------|---------|
| **MITRE ATT&CK Evaluations** | APT29, APT3, FIN7 | Evaluaciones estándar de la industria |
| **CALDERA** | Múltiples perfiles | Emulación automatizada |
| **Network Flight Simulator** | Varios | Simulación de tráfico de red |
| **SimuLand** | Múltiples | Laboratorios de Azure AD/Entra ID |
| **Detection Lab** | Varios | Laboratorio de detección con Splunk/Elastic |
| **GOAD (Game of Active Directory)** | AD-focused | Laboratorio vulnerable de AD |
| **Vulnerable-AD** | AD-focused | Script para crear AD vulnerable |

#### 9.5 Métricas Purple Team

| Métrica | Descripción |
|---------|-------------|
| **MTTD** (Mean Time to Detect) | Tiempo promedio para detectar una técnica |
| **MTTR** (Mean Time to Respond) | Tiempo promedio para responder a un incidente |
| **Cobertura ATT&CK** | % de técnicas con detección efectiva |
| **Tasa de falsos positivos** | Reglas que generan alertas innecesarias |
| **Tasa de detección por fase** | Detección por fase de la cadena de ataque |
| **Tiempo de contención** | Tiempo para contener un compromiso |

---

### 10. Reporteo y Documentación

#### 10.1 Estructura del Reporte Final

```
1. Ejecutivo (Executive Summary)
   ├── Alcance del engagement
   ├── Hallazgos clave (riesgo alto/medio/bajo)
   ├── Resumen de la ruta de ataque
   └── Recomendaciones estratégicas

2. Metodología
   ├── Fases del engagement
   ├── Herramientas utilizadas
   └── Mapeo a MITRE ATT&CK

3. Hallazgos Detallados
   ├── Por cada hallazgo:
   │   ├── Descripción
   │   ├── Evidencia (screenshots, logs)
   │   ├── Impacto
   │   ├── Técnica MITRE ATT&CK
   │   ├── Control NIST CSF afectado
   │   ├── Contramedida D3FEND recomendada
   │   └── Remediación

4. Rutas de Ataque (Attack Paths)
   ├── Diagrama de la cadena de compromiso
   ├── BloodHound attack paths
   └── Kill chain completo

5. Métricas
   ├── Tasa de detección del SOC
   ├── Tiempo de detección por fase
   ├── Cobertura ATT&CK evaluada
   └── Comparativa con industry benchmarks

6. Recomendaciones
   ├── Prioridad crítica (0-30 días)
   ├── Prioridad alta (30-90 días)
   ├── Prioridad media (90-180 días)
   └── Prioridad baja (180+ días)

7. Apéndices
   ├── Detalles técnicos completos
   ├── Output de herramientas
   └── Glosario
```

#### 10.2 Mapeo de Marcos de Referencia

**MITRE ATT&CK Navigator Layer:**
Generar un layer JSON para visualizar las técnicas utilizadas en el engagement:
```json
{
  "name": "BRIDA Red Team Engagement",
  "versions": { "attack": "15.1", "navigator": "4.9.1" },
  "techniques": [
    { "techniqueID": "T1566.001", "score": 100, "comment": "Spearphishing Attachment utilizado para acceso inicial" },
    { "techniqueID": "T1055", "score": 80, "comment": "Process Injection para evasión" },
    { "techniqueID": "T1003.006", "score": 100, "comment": "DCSync para compromiso total del dominio" }
  ]
}
```

**Mapeo NIST CSF:**

| Función | Categoría | Ejemplo de Hallazgo |
|---------|-----------|---------------------|
| **ID** (Identify) | ID.AM (Asset Management) | Activos críticos no inventariados |
| **ID** (Identify) | ID.RA (Risk Assessment) | Vulnerabilidades no evaluadas |
| **PR** (Protect) | PR.AC (Access Control) | ACLs débiles en AD |
| **PR** (Protect) | PR.DS (Data Security) | Datos sensibles sin cifrar |
| **PR** (Protect) | PR.IP (Information Protection) | GPOs mal configuradas |
| **DE** (Detect) | DE.CM (Security Monitoring) | Falta de detección de DCSync |
| **DE** (Detect) | DE.AE (Anomalies) | Sin detección de movimiento lateral |
| **RS** (Respond) | RS.MI (Mitigation) | Sin plan de respuesta para AD compromise |
| **RC** (Recover) | RC.RP (Recovery Plan) | Sin backups offline de AD |

**Mapeo D3FEND:**

| Técnica de Ataque | Contramedida D3FEND | Descripción |
|-------------------|---------------------|-------------|
| Kerberoasting (T1558.003) | `Credential Hardening` | Implementar gMSA, rotación de contraseñas de SPN |
| DCSync (T1003.006) | `Credential Compromise Scope Analysis` | Monitorear replicación de directorio |
| LLMNR Poisoning (T1557.001) | `Network Traffic Analysis` | Deshabilitar LLMNR/NBT-NS |
| Process Injection (T1055) | `Process Analysis` | EDR con detección de inyección |
| Phishing (T1566) | `Email Filtering`, `URL Analysis` | Filtros avanzados, sandboxing |
| Golden Ticket (T1558.001) | `Authentication Strength` | Rotación regular de KRBTGT |
| RBCD Abuse (T1550.003) | `Access Control Configuration` | Auditoría de delegación restringida |

---

### 11. Consideraciones Legales y Éticas

- **Autorización escrita**: Obtener siempre un documento de autorización firmado (Statement of Work / Get Out of Jail Free Card) antes de iniciar cualquier actividad.
- **Alcance estricto**: No exceder el alcance definido. Cualquier descubrimiento fuera del alcance debe reportarse pero no explotarse sin autorización.
- **Manejo de datos**: Cifrar toda la información recopilada. Destruir datos sensibles al finalizar el engagement.
- **Comunicación**: Establecer canales de comunicación claros con el cliente para reportar hallazgos críticos en tiempo real.
- **No dejar artefactos**: Limpiar scripts, backdoors y accesos persistentes al finalizar (a menos que el engagement lo requiera específicamente).
- **Compliance**: Asegurar cumplimiento con regulaciones locales (Ley de Protección de Datos, etc.).

---

### 12. Checklist Pre-Engagement

- [ ] Autorización escrita obtenida y firmada
- [ ] Alcance definido y documentado
- [ ] Reglas de Engagement (ROE) acordadas
- [ ] Perfil de adversario seleccionado
- [ ] Infraestructura C2 desplegada y probada
- [ ] Herramientas actualizadas y configuradas
- [ ] Canales de comunicación de emergencia establecidos
- [ ] Puntos de contacto del cliente identificados
- [ ] Ventanas de tiempo de ataque definidas
- [ ] Procedimiento de "lights out" documentado
- [ ] Seguro de responsabilidad civil vigente
- [ ] NDA firmado

---

### 13. Referencias y Recursos

| Recurso | URL |
|---------|-----|
| MITRE ATT&CK | https://attack.mitre.org |
| NIST CSF | https://www.nist.gov/cyberframework |
| D3FEND | https://d3fend.mitre.org |
| BloodHound | https://github.com/BloodHoundAD/BloodHound |
| Impacket | https://github.com/SecureAuthCorp/impacket |
| Cobalt Strike | https://www.cobaltstrike.com |
| Sliver | https://github.com/BishopFox/sliver |
| Mythic | https://github.com/its-a-feature/Mythic |
| Atomic Red Team | https://github.com/redcanaryco/atomic-red-team |
| CALDERA | https://github.com/mitre/caldera |
| Sigma Rules | https://github.com/SigmaHQ/sigma |
| GOAD | https://github.com/Orange-Cyberdefense/GOAD |
| HackTricks | https://book.hacktricks.xyz |
| Pentester Academy / Altered Security | https://www.alteredsecurity.com |
| Red Team Notes | https://dmcxblue.gitbook.io |
| CRTO (Certified Red Team Operator) | Zero-Point Security |
| CRTE (Certified Red Team Expert) | Altered Security |

---

*Documento mantenido por el equipo de Red Teaming de BRIDA IT Services. Última actualización: Junio 2026.*
