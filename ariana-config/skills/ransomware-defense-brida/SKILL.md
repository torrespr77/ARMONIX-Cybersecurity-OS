---
name: ransomware-defense-brida
description: 'Defensa integral contra ransomware para clientes de BRIDA IT Services.
  Cubre prevención, detección, respuesta a incidentes, recuperación y hardening post-incidente.
  Incluye CISA Ransomware Guide, estrategia de backups 3-2-1, segmentación de red,
  detección EDR (CrowdStrike/Trellix), playbook de respuesta, consideraciones de negociación,
  procedimientos de recuperación y mapeo a MITRE ATT&CK, NIST CSF y D3FEND. Activado
  por: ransomware, ransom, encryption, data lock, CISA, backup strategy, ransomware
  response, ransomware recovery, incident response, ransomware playbook, negociación
  ransomware, decryptor, ransomware family.

  '
domain: cybersecurity
subdomain: ransomware-defense
category: cybersecurity
triggers:
- ransomware
- ransom
- encryption
- data lock
- CISA
- backup strategy
- ransomware response
- ransomware recovery
- incident response
- ransomware playbook
- negociación ransomware
- decryptor
- ransomware family
- 3-2-1
- network segmentation
- EDR detection
- post-incident
- hardening
- negotiation
- recovery procedures
tags:
- ransomware
- cisa
- backup
- incident-response
- encryption
- recovery
- nist-csf
- mitre-attack
- d3fend
- crowdstrike
- trellix
- fortigate
- segmentation
- negotiation
- hardening
mitre_attack:
- T1486
- T1490
- T1496
- T1059
- T1021
- T1082
- T1083
- T1114
- T1489
- T1562
- T1498
- T1071
- T1003
- T1547
- T1136
nist_csf:
- PR.DS-11
- RS.MA-01
- RC.RP-01
- PR.IR-01
- ID.RA-01
- DE.CM-01
- DE.CM-09
- PR.AC-04
- PR.IP-04
- RS.AN-03
- RC.CO-03
d3fend:
- D3-BCR
- D3-NS
- D3-EDR
- D3-PAN
- D3-FS
- D3-CA
- D3-PH
- D3-RA
- D3-DI
- D3-NTA
- D3-PSA
- D3-SA
- D3-CE
- D3-DCE
version: '2.0'
author: BRIDA IT Services
license: Apache-2.0
last_updated: '2026-06-16'
---

# 🛡️ Ransomware Defense — BRIDA IT Services

## Stack de Seguridad BRIDA

| Capa | Herramienta | Rol Anti-Ransomware |
|---|---|---|
| **EDR/XDR** | CrowdStrike Falcon (Insight/OverWatch) | Detección comportamental, threat hunting |
| **Endpoint AV** | Trellix ePO | Protección signature-based, policy enforcement |
| **NGFW** | FortiGate (IPS/AV/SSL Inspection) | Bloqueo C2, segmentación, filtrado |
| **Email** | Google Workspace + SPF/DKIM/DMARC | Bloqueo de vectores de entrada (phishing) |
| **Backup** | Veeam / Acronis / Cloud | Recuperación 3-2-1 con inmutabilidad |
| **Network** | VLANs + FortiGate | Contención de propagación |
| **Identity** | Active Directory + LAPS | Prevención de movimiento lateral |
| **Vulnerability Mgmt** | Qualys | Identificación de vectores de entrada |

---

## Cuándo Usar Este Skill

- Diseño de estrategia anti-ransomware (proactivo)
- Respuesta a un ataque de ransomware **activo**
- Evaluación de preparación contra ransomware (assessment)
- Implementación de backups y plan de recuperación
- Solicitud del cliente: *"¿qué pasa si nos infectan con ransomware?"*
- Ejercicio de simulación (tabletop exercise)
- Post-incidente: hardening y lecciones aprendidas

---

## ⚠️ Riesgo para Clientes sin Protección (Ej. Grupo Pepe)

**NIVEL DE RIESGO: 🔴 CRÍTICO**

| Factor | Estado | Impacto |
|---|---|---|
| EDR corporativo | ❌ No instalado | Sin detección de ransomware |
| Segmentación de red | ❌ No implementada | Propagación total garantizada |
| Backups verificados | ❌ No existen | Sin capacidad de recuperación |
| Active Directory hardening | ❌ No implementado | Movimiento lateral sin resistencia |
| Antivirus | ❌ Sin licencia | Sin protección en endpoints |
| Madurez de seguridad | 🔴 MUY BAJA | Presa fácil para ransomware |

> **⚠️ NOTA CRÍTICA:** Clientes como Grupo Pepe, sin EDR, sin backups verificados y sin segmentación, son objetivos de alto valor para operadores de ransomware. Un ataque exitoso podría significar **pérdida total de datos** y **parálisis operativa indefinida**.

---

## Fase 1: Prevención

### 1.1. Marco de Referencia CISA — StopRansomware.gov

La CISA (Cybersecurity and Infrastructure Security Agency) publica la guía oficial **"StopRansomware Guide"** que establece las siguientes prioridades:

#### Controles Prioritarios CISA

1. **Mantener backups offline e inmutables** — El control #1 más importante
2. **Aplicar parches rápidamente** — Especialmente para vulnerabilidades explotadas (KEVs)
3. **Configurar EDR/XDR** — Detección comportamental en todos los endpoints
4. **Segmentar redes** — Limitar el movimiento lateral
5. **Implementar MFA** — En todos los accesos remotos y cuentas privilegiadas
6. **Filtrar email** — Bloquear attachments maliciosos y enlaces
7. **Restringir RDP** — Deshabilitar o proteger con VPN + MFA
8. **Entrenar usuarios** — Concientización sobre phishing

#### Recursos CISA
- **StopRansomware.gov:** https://www.stopransomware.gov/
- **CISA KEV Catalog:** https://www.cisa.gov/known-exploited-vulnerabilities-catalog
- **CISA Alerts:** https://www.cisa.gov/news-events/cybersecurity-advisories
- **No More Ransom Project:** https://www.nomoreransom.org/

### 1.2. Estrategia de Backups — Regla 3-2-1-1-0

La estrategia de backups es la **última línea de defensa** contra ransomware. Sin backups verificados, la recuperación es imposible sin pagar el rescate.

#### Regla 3-2-1-1-0 (Evolución de la regla 3-2-1)

| Regla | Descripción | Implementación BRIDA |
|---|---|---|
| **3** | Mantener **3 copias** de los datos | 1 primaria + 2 backups |
| **2** | Usar **2 medios/tecnologías** diferentes | Disco local + Cloud (o cinta) |
| **1** | **1 copia offsite** (fuera de la red) | Cloud (AWS S3 / Azure Blob) o sitio remoto |
| **1** | **1 copia inmutable/air-gapped** | WORM storage, S3 Object Lock, tape offline |
| **0** | **0 errores** en verificación de restauración | Pruebas de restore mensuales automatizadas |

#### Configuración Recomendada para Clientes BRIDA

```
Frecuencia de Backups:
├── Datos críticos (BD, ERP): Cada 1-4 horas (incremental)
├── Servidores de archivos: Diario (incremental) + Semanal (full)
├── Estaciones de trabajo: Diario (incremental)
└── Configuraciones de red: Semanal + tras cada cambio

Retención:
├── Diarios: 30 días
├── Semanos: 12 semanas
├── Mensuales: 12 meses
└── Anuales: 3-7 años (según requisitos legales)

Inmutabilidad:
├── S3 Object Lock (Compliance mode): 30 días mínimo
├── Veeam Hardened Repository: Linux-based, immutability flag
└── Tape offline: Almacenamiento físico seguro
```

#### Verificación de Backups (CRÍTICO)

> **Un backup sin prueba de restauración NO es un backup.**

- **Frecuencia:** Prueba de restauración **mínimo mensual**
- **Alcance:** Restaurar archivos individuales, bases de datos completas y sistemas enteros
- **Documentación:** Registrar RTO (Recovery Time Objective) y RPO (Recovery Point Objective) reales
- **Automatización:** Veeam SureBackup / Acronis Verification

### 1.3. Segmentación de Red

La segmentación es el control más efectivo para **contener la propagación** de ransomware.

#### Arquitectura de Segmentación Recomendada

```
[Internet]
     │
  [FortiGate NGFW] ← IPS/AV/SSL Inspection habilitado
     │
  ┌──┴──────────────────────────────────────────┐
  │              DMZ                              │
  │  Servidores públicos (web, email, DNS)       │
  └──────────────────────────────────────────────┘
     │
  ┌──┴──────────────────────────────────────────┐
  │         Red Corporativa (VLAN 10)            │
  │  Estaciones de trabajo, impresoras           │
  │  Políticas: Sin acceso directo a servidores  │
  └──────────────────────────────────────────────┘
     │
  ┌──┴──────────────────────────────────────────┐
  │         Red de Servidores (VLAN 20)          │
  │  BD, ERP, archivos, aplicaciones             │
  │  Políticas: Solo tráfico necesario           │
  └──────────────────────────────────────────────┘
     │
  ┌──┴──────────────────────────────────────────┐
  │         Red de Gestión (VLAN 30)             │
  │  AD, EDR console, backup, monitoreo          │
  │  Políticas: Solo admins, MFA obligatorio     │
  └──────────────────────────────────────────────┘
     │
  ┌──┴──────────────────────────────────────────┐
  │         Red de Backup (VLAN 40)              │
  │  Servidores de backup, tape library          │
  │  Políticas: Aislada, sin acceso desde VLAN 10│
  └──────────────────────────────────────────────┘
```

#### Reglas FortiGate Anti-Ransomware

```bash
# Bloquear tráfico SMB (445) entre VLANs (excepto servidores)
config firewall policy
  edit <id>
    set srcintf "VLAN10"
    set dstintf "VLAN20"
    set service "SMB"
    set action deny
    set logtraffic all
  next
end

# Habilitar IPS con firmas de ransomware
config ips sensor
  edit "anti-ransomware"
    config entries
      edit 1
        set rule 60000-61000  # Ransomware signatures
        set status enable
        set action block
      next
    end
  next
end

# Habilitar SSL Inspection (el ransomware usa HTTPS para C2)
config firewall ssl-ssh-profile
  edit "deep-inspection"
    set ssl-exemptions-log enable
    config https
      set ports 443
      set status deep-inspection
    end
  next
end

# Bloquear conexiones a C2 conocidos (threat intelligence)
config webfilter profile
  edit "anti-c2"
    config ftgd-wf
      config filters
        edit 1
          set category 178  # Malicious Websites
          set action block
        next
      end
    end
  next
end
```

### 1.4. Detección EDR — CrowdStrike Falcon + Trellix ePO

#### CrowdStrike Falcon — Configuración Anti-Ransomware

```bash
# Políticas de Prevención (Prevention Policy)
# Configurar en Falcon Console → Configuration → Prevention Policy

Configuraciones recomendadas:
├── Prevention Settings:
│   ├── Sensor Detection: HIGH
│   ├── Cloud Detection: HIGH
│   ├── Detection Visibility: HIGH
│   ├── Quarantine: ENABLED
│   └── Executable File Blocking: ENABLED
│
├── Machine Learning:
│   ├── Sensor-based ML: ENABLED (Block)
│   ├── Cloud-based ML: ENABLED (Block)
│   ├── Unknown Detection: ENABLED (Block)
│   └── Suspicious Files: ENABLED (Alert)
│
├── Attack Surface Reduction:
│   ├── Block all macro execution: ENABLED
│   ├── Block credential stealing: ENABLED
│   ├── Block process injection: ENABLED
│   └── Block encrypted payloads: ENABLED
│
├── Ransomware Prevention:
│   ├── Ransomware Protection: ENABLED
│   ├── File Encryption Protection: ENABLED
│   ├── Shadow Copy Protection: ENABLED
│   └── Backup Tampering Protection: ENABLED
│
└── Indicators of Attack (IOAs):
    ├── Ransomware behavior: BLOCK
    ├── Mass file modification: BLOCK
    ├── Suspicious encryption: BLOCK
    └── VSS manipulation: BLOCK
```

#### CrowdStrike Custom Detection Rules (IOA)

```yaml
# Regla personalizada: Detección de cifrado masivo
name: "BRIDA - Ransomware Mass Encryption"
description: "Detecta modificación masiva de archivos (posible cifrado)"
pattern:
  - event_type: "FileRename"
    file_extension_changed: true
    count_threshold: 50
    time_window: 60s
  - event_type: "FileWrite"
    entropy_increase: true
    count_threshold: 100
    time_window: 60s
action: "Block"
severity: "Critical"
```

#### Trellix ePO — Configuración Anti-Ransomware

```bash
# ePO Policy Configuration
# ePO Console → Policy → Product: Endpoint Security

Configuraciones:
├── Access Protection:
│   ├── Block processes from Temp folders: ENABLED
│   ├── Block execution from USB: ENABLED
│   ├── Block PowerShell scripts: ENABLED (o restringir)
│   └── Block modification of protected files: ENABLED
│
├── On-Access Scan:
│   ├── Scan on read/write: ENABLED
│   ├── Scan network drives: ENABLED
│   ├── Detect ransomware behavior: ENABLED
│   └── Heuristic analysis: AGGRESSIVE
│
├── Threat Prevention:
│   ├── Anti-malware signatures: AUTO-UPDATE
│   ├── Artemis (cloud reputation): ENABLED
│   └── Real-time behavioral analysis: ENABLED
│
└── Adaptive Threat Protection:
    ├── Dynamic analysis: ENABLED
    ├── Cloud sandboxing: ENABLED
    └── Ransomware rollback: ENABLED
```

### 1.5. Hardening de Endpoints

#### Windows Hardening (GPO)

```powershell
# Deshabilitar macros en Office (GPO)
# Computer Config → Admin Templates → Microsoft Office
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Word\Security" -Name "VBAWarnings" -Value 4
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\Excel\Security" -Name "VBAWarnings" -Value 4

# Deshabilitar PowerShell para usuarios no técnicos
# GPO: Computer Config → Admin Templates → Windows Components → Windows PowerShell
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell" -Name "EnableScripts" -Value 0

# Deshabilitar RDP (si no es necesario)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1

# Habilitar Windows Defender Attack Surface Reduction (ASR)
# Bloquear aplicaciones Office de crear procesos hijo
Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A -AttackSurfaceReductionRules_Actions Enabled

# Bloquear contenido ejecutable de email
Add-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550 -AttackSurfaceReductionRules_Actions Enabled

# Bloquear robos de credenciales de LSASS
Add-MpPreference -AttackSurfaceReductionRules_Ids 9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2 -AttackSurfaceReductionRules_Actions Enabled

# Proteger contra ransomware: Bloquear procesos P2P
Add-MpPreference -AttackSurfaceReductionRules_Ids D1E49AAC-8F56-4280-B9BA-993A6D77406C -AttackSurfaceReductionRules_Actions Enabled

# Habilitar Controlled Folder Access (protección contra cifrado)
Set-MpPreference -EnableControlledFolderAccess Enabled

# Configurar carpetas protegidas
Add-MpPreference -ControlledFolderAccessProtectedFolders "C:\Datos"
Add-MpPreference -ControlledFolderAccessProtectedFolders "D:\Archivos"

# Deshabilitar SMBv1 (vector de WannaCry, etc.)
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart

# Eliminar shadow copies (vector de ransomware)
# PROTEGER: Bloquear vssadmin.exe para usuarios no admin
```

#### Linux Hardening

```bash
# Deshabilitar servicios innecesarios
systemctl disable --now telnet
systemctl disable --now rsh
systemctl disable --now rlogin

# Configurar firewall local
iptables -A INPUT -p tcp --dport 445 -j DROP  # SMB
iptables -A INPUT -p tcp --dport 139 -j DROP  # NetBIOS

# Instalar y configurar AIDE (file integrity monitoring)
apt install aide -y
aide --update
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Configurar inmutabilidad en crontab
chattr +i /etc/crontab
chattr +i /etc/passwd
chattr +i /etc/shadow
```

### 1.6. Active Directory Hardening

> **AD es el objetivo #1 del ransomware.** Comprometer AD = control total de la organización.

#### Tiered Administration Model

```
Tier 0 (Máxima Seguridad):
├── Domain Controllers
├── Enterprise Admins
├── Domain Admins
├── AD FS servers
└── PAM/PIM systems
    └── Acceso: Solo desde estaciones de administración dedicadas (PAW)

Tier 1 (Servidores):
├── Server Admins
├── SQL Admins
├── Application Admins
└── Backup Admins
    └── Acceso: Solo desde estaciones de trabajo administrativas

Tier 2 (Estaciones):
├── Help Desk
├── Desktop Support
└── Workstation Admins
    └── Acceso: Desde estaciones de trabajo estándar
```

#### Controles AD Esenciales

```powershell
# Instalar LAPS (Local Administrator Password Solution)
# Descargar de: https://www.microsoft.com/en-us/download/details.aspx?id=46899
Update-LapsADSchema
Set-LapsADComputerSelfPermission -Identity "OU=Workstations,DC=brida,DC=local"

# Configurar Protected Users Security Group
# (Protege contra credential caching y delegation attacks)
Add-ADGroupMember -Identity "Protected Users" -Members "admin_user1", "admin_user2"

# Deshabilitar NTLM (si es posible)
# GPO: Computer Config → Windows Settings → Security Settings → Local Policies → Security Options
# "Network security: Restrict NTLM: Outgoing NTLM traffic to remote servers" = Deny all

# Auditar uso de privilegios
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Special Logon" /success:enable
auditpol /set /subcategory:"Other Object Access Events" /success:enable

# Detectar rutas de ataque con BloodHound
# (Instalar en entorno de prueba, NO en producción directamente)
# sharphound.exe -c All --domain brida.local
```

### 1.7. Email Security (Vector de Entrada #1)

```
Configuración Anti-Phishing:
├── SPF: v=spf1 include:_spf.google.com -all
├── DKIM: Habilitar en Google Workspace Admin
├── DMARC: v=DMARC1; p=reject; rua=mailto:dmarc@cliente.com
├── Google Workspace:
│   ├── Enhanced pre-delivery protection: ENABLED
│   ├── Attachment scanning: ENABLED
│   ├── External reply warning: ENABLED
│   └── BIMI: Configurar si es posible
├── Reglas de filtrado:
│   ├── Bloquear: .exe, .js, .vbs, .ps1, .scr, .bat, .cmd, .wsf
│   ├── Bloquear archivos comprimidos con contraseña
│   ├── Bloquero macros en documentos Office
│   └── Cuarentena archivos .docm, .xlsm, .pptm
└── Concientización:
    ├── Simulaciones de phishing trimestrales
    ├── Entrenamiento de identificación de phishing
    └── Canal de reporte rápido (botón "Report Phishing")
```

---

## Fase 2: Detección

### 2.1. Indicadores de Compromiso (IOCs) de Ransomware

#### Indicadores Técnicos

| Indicador | Descripción | Severidad |
|---|---|---|
| **Cifrado masivo de archivos** | Archivos con extensión cambiada (.locked, .encrypted, .crypto) | 🔴 Crítica |
| **Notas de resciso** | README_DECRYPT.txt, HOW_TO_DECRYPT.html, etc. | 🔴 Crítica |
| **Eliminación de shadow copies** | `vssadmin delete shadows /all /quiet` | 🔴 Crítica |
| **Alto uso de CPU/disco** | Proceso desconocido con alta actividad de I/O | 🟠 Alta |
| **Tráfico C2** | Conexiones a IPs/dominios conocidos de ransomware | 🟠 Alta |
| **Deshabilitación de seguridad** | EDR/AV detenido, Windows Defender desactivado | 🔴 Crítica |
| **Movimiento lateral** | SMB/RDP anómalo entre segmentos | 🟠 Alta |
| **Dumping de credenciales** | LSASS access, NTDS.dit extraction | 🔴 Crítica |
| **Creación de cuentas** | Nuevas cuentas de administrador | 🟠 Alta |
| **Modificación de GPO** | Cambios no autorizados en Group Policy | 🟠 Alta |

#### Comandos de Detección (CrowdStrike Falcon Query Language)

```sql
-- Detectar eliminación de shadow copies
event_simpleName="ProcessRollup2" AND 
("vssadmin" AND "delete" AND "shadows") OR 
("wmic" AND "shadowcopy" AND "delete") OR 
("bcdedit" AND "recoveryenabled" AND "no")

-- Detectar cifrado masivo de archivos
event_simpleName="FileRename" | groupby(FileName, count) | sort(-count) | head(100)

-- Detectar deshabilitación de Windows Defender
event_simpleName="ProcessRollup2" AND 
("Set-MpPreference" AND "DisableRealtimeMonitoring") OR 
("sc" AND "stop" AND "WinDefend")

-- Detectar acceso a LSASS (credential dumping)
event_simpleName="ProcessRollup2" AND 
(TargetProcessName="lsass.exe" AND 
(GrantedAccess="0x1010" OR GrantedAccess="0x1FFFFF"))

-- Detectar ejecución de ransomware desde Temp
event_simpleName="ProcessRollup2" AND 
(FileName MATCHES ".*\\Temp\\.*" AND 
(FileDescription="" OR FileDescription="selfextracting archive"))
```

#### Comandos de Detección (FortiGate)

```bash
# Detectar tráfico SMB anómalo (movimiento lateral)
diagnose sniffer packet any "port 445" 4

# Ver conexiones sospechosas (C2)
diagnose sys session list | grep -E "(ESTABLISHED)" | awk '{print $5}' | sort | uniq -c | sort -rn

# Ver logs de IPS con firmas de ransomware
diagnose debug application ips -1
diagnose debug enable

# Buscar conexiones a dominios maliciosos
diagnose sniffer packet any "host <malicious_ip>" 4
```

### 2.2. Canary Files (Archivos Señuelo)

```bash
# Crear archivos canary en ubicaciones estratégicas
# El ransomware los cifrará primero, alertando tempranamente

# Crear archivos señuelo
$canaryLocations = @(
    "C:\Users\Public\Documents\clientes_importantes.xlsx",
    "C:\Datos\Facturas_Pendientes_2024.xlsx",
    "D:\Archivos\Nomina_Confidencial.xlsx",
    "C:\Shared\Contratos_Vigentes.docx"
)

foreach ($file in $canaryLocations) {
    "CANARY FILE - DO NOT MODIFY" | Out-File -FilePath $file -Force
    # Configurar auditoría
    $acl = Get-Acl $file
    $rule = New-Object System.Security.AccessControl.FileSystemAuditRule(
        "Everyone", "Modify,ChangePermissions,TakeOwnership", 
        "Success,Failure"
    )
    $acl.AddAuditRule($rule)
    Set-Acl -Path $file -AclObject $acl
}

# Monitorear acceso a canary files
# Configurar alerta en CrowdStrike/SIEM cuando se modifiquen
```

### 2.3. Detección por MITRE ATT&CK

| Técnica | ID | Deteción EDR | Detección Red |
|---|---|---|---|
| Data Encrypted for Impact | T1486 | CrowdStrike: Mass file modification IOA | N/A |
| Inhibit System Recovery | T1490 | Shadow copy deletion, boot config change | N/A |
| Resource Hijacking | T1496 | High CPU/GPU usage anomaly | Outbound mining pool traffic |
| Command Interpreter | T1059 | PowerShell/WMIC suspicious execution | N/A |
| Remote Services | T1021 | Lateral movement detection | SMB/RDP between segments |
| System Discovery | T1082 | System info commands | N/A |
| File Discovery | T1083 | Mass file enumeration | N/A |
| Email Collection | T1114 | Mass email access | SMTP anomalies |
| Service Stop | T1489 | Security service termination | N/A |
| Impair Defenses | T1562 | AV/EDR disable attempts | N/A |
| Network DoS | T1498 | N/A | Traffic flood detection |
| C2 Communication | T1071 | DNS anomalies, beaconing | DNS/HTTP anomalies |
| Credential Dumping | T1003 | LSASS access, SAM dump | N/A |
| Persistence | T1547 | Registry run keys, scheduled tasks | N/A |
| Account Creation | T1136 | New admin account | N/A |

---

## Fase 3: Respuesta a Incidentes — Playbook

### 3.1. Clasificación de Severidad

| Nivel | Descripción | Tiempo de Respuesta | Ejemplo |
|---|---|---|---|
| **P1 - Crítico** | Ransomware activo, propagándose | **15 minutos** | Cifrado en múltiples servidores |
| **P2 - Alto** | Ransomware detectado, contención parcial | **30 minutos** | Cifrado en un segmento |
| **P3 - Medio** | Indicadores de ransomware, sin cifrado confirmado | **1 hora** | Malware detectado por EDR |
| **P4 - Bajo** | Preparación, simulacros, hardening | **24 horas** | Tabletop exercise |

### 3.2. Playbook de Respuesta — Primeros 60 Minutos

#### ⏱️ Minuto 0-15: CONTENCIÓN INMEDIATA

```
ACCIÓN 1: NO APAGAR los sistemas infectados
├── Razón: La evidencia volátil (RAM, conexiones) se pierda
├── Excepción: Si el cifrado está activo y no se puede contener
└── Alternativa: Desconectar cable de red / deshabilitar WiFi

ACCIÓN 2: Desconectar sistemas infectados de la red
├── Desconectar cable de red físicamente
├── Deshabilitar adaptadores de red (si no se puede desconectar físicamente)
├── Bloquear IPs/mac en FortiGate
└── NO apagar (preservar evidencia volátil)

ACCIÓN 3: Aislar segmentos de red afectados
├── En FortiGate: Deshabilitar interfaces de VLAN afectadas
├── Bloquear tráfico SMB (445) entre todos los segmentos
├── Bloquear tráfico RDP (3389) entre segmentos
└── Mantener acceso de gestión para el equipo de IR

ACCIÓN 4: Activar el equipo de Incident Response
├── Notificar al líder de IR
├── Notificar al CISO / Director de IT
├── Notificar al liderazgo del cliente
└── Establecer canal de comunicación seguro (fuera de la red comprometida)

ACCIÓN 5: Documentar el estado inicial
├── Foto de pantalla con nota de rescate
├── Lista de sistemas afectados (según se conoce)
├── Hora de detección
└── Acciones tomadas hasta el momento
```

#### ⏱️ Minuto 15-30: ANÁLISIS INICIAL

```
ACCIÓN 6: Identificar la familia de ransomware
├── Subir nota de rescate a: https://id-ransomware.malwarehunterteam.com/
├── Buscar extensión de archivos cifrados en: https://www.nomoreransom.org/
├── Revisar alertas de CrowdStrike/Trellix para identificación
└── Buscar en: https://www.id-ransomware.malwarehunterteam.com/

ACCIÓN 7: Determinar el alcance (scope)
├── ¿Cuántos sistemas están afectados?
├── ¿Qué servidores están comprometidos?
├── ¿Los backups están intactos?
├── ¿Se comprometió Active Directory?
└── ¿Hay evidencia de exfiltración de datos (double extortion)?

ACCIÓN 8: Verificar integridad de backups
├── ¿Los backups están en red aislada/inmutable?
├── ¿La última copia exitosa es reciente?
├── ¿Se puede restaurar desde backups?
└── ¿Hay que verificar que los backups NO estén comprometidos?

ACCIÓN 9: Buscar decryptor disponible
├── No More Ransom: https://www.nomoreransom.org/
├── ID Ransomware: https://id-ransomware.malwarehunterteam.com/
├── Emsisoft Decryptors: https://www.emsisoft.com/ransomware-decryption-tools/
├── Avast Decryptors: https://www.avast.com/ransomware-decryption-tools
└── Kaspersky: https://noransom.kaspersky.com/
```

#### ⏱️ Minuto 30-60: CONTENCIÓN EXPANDIDA

```
ACCIÓN 10: Bloquear IOCs identificados
├── Bloquear IPs/dominios C2 en FortiGate
├── Bloquear hashes de malware en CrowdStrike/Trellix
├── Bloquear cuentas comprometidas en AD
└── Actualizar reglas de IPS/IDS

ACCIÓN 11: Preservar evidencia
├── Captura de memoria RAM (si el sistema sigue encendido)
│   └── Herramienta: WinPMEM, Magnet RAM Capture
├── Imagen forense de discos
│   └── Herramienta: FTK Imager, dd
├── Exportar logs de CrowdStrike/Trellix
├── Exportar logs de FortiGate
└── Documentar cadena de custodia

ACCIÓN 12: Evaluar opciones de recuperación
├── Opción A: Restaurar desde backups (PREFERIDA)
├── Opción B: Usar decryptor disponible
├── Opción C: Reconstruir sistemas desde cero
└── Opción D: Negociar/pagar (ÚLTIMO RECURSO)
```

### 3.3. Erradicación

```
PASO 1: Eliminar malware de sistemas afectados
├── Usar CrowdStrike/Trellix para eliminar amenazas detectadas
├── Verificar eliminación completa (scan completo)
└── Documentar IoCs y TTPs identificados

PASO 2: Parchear el vector de entrada
├── Identificar cómo entró el ransomware
│   ├── ¿Phishing email? → Bloquear remitente, URL, hash
│   ├── RDP expuesto? → Cerrar puerto, implementar VPN+MFA
│   ├── Vulnerabilidad? → Aplicar parche inmediatamente
│   └── Software comprometido? → Actualizar/reemplazar
└── Implementar controles para prevenir re-ocurrencia

PASO 3: Resetear TODAS las credenciales
├── Asumir compromiso total de credenciales
├── Resetear: Domain Admin, Enterprise Admin, Service Accounts
├── Resetear: Contraseñas de usuarios afectados
├── Resetear: Certificados digitales (si aplica)
├── Revocar: Tokens de acceso, API keys
└── Implementar: LAPS si no estaba implementado

PASO 4: Reimaginar sistemas infectados
├── Formateo limpio (NO restaurar desde imagen potencialmente comprometida)
├── Reinstalar desde medios limpios
├── Aplicar todos los parches antes de conectar a la red
├── Instalar EDR antes de conectar a la red
└── Verificar integridad antes de restaurar datos
```

---

## Fase 4: Recuperación

### 4.1. Procedimientos de Recuperación

```
ORDEN DE RECUPERACIÓN (Prioridad):
1. Active Directory / DNS / DHCP (infraestructura base)
2. Servidores de gestión (EDR console, backup server)
3. Bases de datos críticas (ERP, CRM)
4. Servidores de archivos
5. Servidores de aplicaciones
6. Estaciones de trabajo
7. Servicios no críticos

PROCEDIMIENTO POR SISTEMA:
1. Verificar que el sistema está limpio (sin malware)
2. Restaurar desde backup inmutable/limpio
3. Verificar integridad de datos restaurados
4. Aplicar parches de seguridad
5. Configurar monitoreo mejorado
6. Conectar a red de forma controlada
7. Monitorear por 72 horas mínimo
```

### 4.2. Verificación Post-Recuperación

```
CHECKLIST DE VERIFICACIÓN:
□ Sistema restaurado desde backup limpio
□ Antivirus/EDR instalado y actualizado
□ Parches de seguridad aplicados
□ Cuentas locales verificadas (sin cuentas no autorizadas)
□ Servicios verificados (sin servicios desconocidos)
□ Programación de tareas verificada (sin tareas sospechosas)
□ Registro de Windows verificado (sin entradas sospechosas)
□ Conexiones de red verificadas (sin C2)
□ Datos restaurados verificados (integridad)
□ Monitoreo activo configurado (alertas mejoradas)
□ Usuarios pueden acceder normalmente
□ Aplicaciones funcionan correctamente
```

### 4.3. Monitoreo Post-Incidente (72 horas mínimo)

```
MONITOREO INTENSIVO (Primeras 72 horas):
├── CrowdStrike: Alertas en tiempo real, investigar TODA alerta
├── FortiGate: Monitoreo de tráfico anómalo
├── AD: Auditoría de logons, cambios de grupo, nuevas cuentas
├── Email: Monitoreo de reglas de reenvío sospechosas
├── Backup: Verificar que los backups se ejecutan correctamente
└── Canary files: Verificar que no se han modificado

MONITOREO EXTENDIDO (30 días):
├── Revisión diaria de alertas de seguridad
├── Verificación semanal de integridad de sistemas
├── Auditoría de cuentas privilegiadas
└── Revisión de logs de acceso remoto
```

---

## Fase 5: Consideraciones de Negociación

> **⚠️ NOTA IMPORTANTE:** El pago de rescate NO es recomendado por CISA, FBI ni ninguna autoridad. Sin embargo, en situaciones donde la alternativa es la quiebra del negocio, algunos clientes consideran esta opción. BRIDA IT Services debe estar preparado para asesorar.

### 5.1. Factores a Considerar

```
ARGUMENTOS EN CONTRA DE PAGAR:
├── No garantiza la recuperación de datos
├── Financia el crimen organizado
├── Puede ser ilegal (sanciones OFAC)
├── Marca al cliente como "pagador" (más ataques futuros)
├── Los decryptors pueden dañar datos
└── No garantiza que los datos robados sean eliminados

ARGUMENTOS A FAVOR (situaciones extremas):
├── Única opción de recuperación disponible
├── Riesgo de quiebra del negocio
├── Datos críticos de salud/seguridad en riesgo
└── Tiempo de reconstrucción inaceptable
```

### 5.2. Proceso de Negociación (Si se Decide Pagar)

```
PASO 1: Contactar a autoridades ANTES de negociar
├── FBI (si aplica): https://www.ic3.gov/
├── CISA: https://www.cisa.gov/report
├── Policía Cibernética México: 088 (en caso de clientes MX)
└── Consultar con asesor legal sobre implicaciones (OFAC)

PASO 2: Contratar a un profesional de negociación
├── Empresas especializadas: Coveware, CrowdStrike Services
├── NUNCA negociar directamente sin experiencia
└── El profesional puede reducir el rescate 40-80%

PASO 3: Verificar la identidad del atacante
├── Usar el canal de comunicación proporcionado en la nota
├── Solicitar prueba de decryptor (archivo de prueba)
└── Verificar reputación del grupo (ID Ransomware)

PASO 4: Negociar términos
├── Oferta inicial del atacante: Generalmente inflada
├── Contrapropuesta: 20-40% del monto inicial
├── Solicitar: Decryptor funcional, prueba de eliminación de datos
└── Establecer: Plazo de entrega del decryptor

PASO 5: Pago y recuperación
├── Usar Bitcoin/Monero según lo solicitado
├── Probar decryptor en UN archivo primero
├── Probar decryptor en un sistema aislado
└── Recuperar gradualmente (no todo a la vez)
```

### 5.3. Implicaciones Legales

```
CONSIDERACIONES LEGALES:
├── OFAC (US): Pagar a entidades sancionadas es ILEGAL
├── GDPR (EU): Puede haber obligación de reportar la brecha
├── Ley de Protección de Datos (MX): Obligación de notificar
├── Seguro cibernético: Contactar al asegurador INMEDIATIMENTE
├── Regulación financiera: Puede requerir divulgación
└── Contratos con clientes: Puede haber obligaciones de notificación
```

---

## Fase 6: Post-Incident Hardening

### 6.1. Análisis Post-Incidente (Lessons Learned)

```
REUNIÓN POST-INCIDENTE (dentro de 2 semanas):
├── ¿Qué sucedió? (Timeline del incidente)
├── ¿Cómo entró el ransomware? (Vector de entrada)
├── ¿Qué controles fallaron?
├── ¿Qué controles funcionaron?
├── ¿Cuál fue el tiempo de detección? (MTTD)
├── ¿Cuál fue el tiempo de respuesta? (MTTR)
├── ¿Cuál fue el impacto financiero?
├── ¿Qué se puede mejorar?
└── Plan de acción con responsables y fechas

DOCUMENTACIÓN:
├── Reporte técnico del incidente
├── Reporte ejecutivo (para liderazgo)
├── Actualización de riesgos
└── Actualización del plan de IR
```

### 6.2. Hardening Post-Incendio

```
ACCIÓN INMEDIATA (0-30 días):
□ Implementar EDR en TODOS los endpoints (si no existía)
□ Implementar backups 3-2-1-1-0 (si no existía)
□ Implementar segmentación de red (si no existía)
□ Implementar MFA en todos los accesos remotos
□ Cerrar RDP expuesto a Internet
□ Aplicar parches críticos (KEV catalog)
□ Implementar LAPS
□ Configurar canary files
□ Implementar email security (SPF/DKIM/DMARC)

ACCIÓN A MEDIANO PLAZO (30-90 días):
□ Implementar SIEM con correlación de eventos
□ Implementar Zero Trust Architecture
□ Implementar PAM (Privileged Access Management)
□ Realizar tabletop exercise de ransomware
□ Implementar DLP (Data Loss Prevention)
□ Implementar network monitoring avanzado
□ Configurar threat intelligence feeds
□ Implementar application whitelisting

ACCIÓN A LARGO PLAZO (90-365 días):
□ Implementar SOC (interno o MDR)
□ Implementar microsegmentación
□ Implementar DevSecOps practices
□ Realizar penetration testing anual
□ Implementar security awareness program continuo
□ Obtener certificación ISO 27001 / SOC 2
□ Implementar cyber insurance
□ Establecer programa de bug bounty
```

### 6.3. Métricas de Mejora

```
MÉTRICAS A MONITOREAR:
├── MTTD (Mean Time to Detect): Objetivo < 1 hora
├── MTTR (Mean Time to Respond): Objetivo < 4 horas
├── MTTC (Mean Time to Contain): Objetivo < 8 horas
├── % de endpoints con EDR: Objetivo 100%
├── % de backups verificados: Objetivo 100%
├── Tiempo de restauración real vs RTO planeado
├── Número de vulnerabilidades críticas sin parchear
├── % de usuarios con MFA habilitado
├── Resultados de simulacros de phishing
└── Número de tabletop exercises realizados por año
```

---

## Mapeo a Frameworks

### MITRE ATT&CK Mapping

| Técnica | ID | Fase | Controles BRIDA |
|---|---|---|---|
| Data Encrypted for Impact | T1486 | Impact | CrowdStrike IOA, Backup 3-2-1 |
| Inhibit System Recovery | T1490 | Impact | Shadow copy protection, Backup |
| Resource Hijacking | T1496 | Impact | EDR behavioral detection |
| Command Interpreter | T1059 | Execution | ASR rules, PowerShell Constrained |
| Remote Services | T1021 | Lateral Movement | Segmentation, MFA, LAPS |
| System Discovery | T1082 | Discovery | EDR detection, honeypots |
| File Discovery | T1083 | Discovery | Canary files, file auditing |
| Email Collection | T1114 | Collection | Email DLP, access monitoring |
| Service Stop | T1489 | Impact | EDR detection, service protection |
| Impair Defenses | T1562 | Defense Evasion | EDR tamper protection |
| Network DoS | T1498 | Impact | FortiGate IPS, rate limiting |
| C2 Communication | T1071 | C2 | FortiGate IPS, DNS filtering |
| Credential Dumping | T1003 | Credential Access | LAPS, Credential Guard |
| Boot/Logon Autostart | T1547 | Persistence | EDR, autoruns monitoring |
| Create Account | T1136 | Persistence | AD auditing, alerting |

### NIST CSF Mapping

| Función | Categoría | Subcategoría | Controles BRIDA |
|---|---|---|---|
| **IDENTIFY** | Risk Assessment | ID.RA-01 | Qualys vuln scanning, risk register |
| **PROTECT** | Data Security | PR.DS-11 | Backup 3-2-1-1-0, immutability |
| **PROTECT** | Infrastructure | PR.IR-01 | Segmentation, FortiGate policies |
| **PROTECT** | Access Control | PR.AC-04 | MFA, LAPS, tiered admin |
| **PROTECT** | Information Protection | PR.IP-04 | Backup verification, testing |
| **DETECT** | Network Monitoring | DE.CM-01 | FortiGate, IDS/IPS, NetFlow |
| **DETECT** | Personnel Monitoring | DE.CM-09 | EDR, user behavior analytics |
| **RESPOND** | Incident Management | RS.MA-01 | IR playbook, SOC/MDR |
| **RESPOND** | Forensic Analysis | RS.AN-03 | Memory capture, disk imaging |
| **RECOVER** | Recovery Planning | RC.RP-01 | DR plan, tested procedures |
| **RECOVER** | Recovery Communication | RC.CO-03 | Stakeholder notification |

### D3FEND Mapping

| Técnica D3FEND | ID | Descripción | Implementación BRIDA |
|---|---|---|---|
| Backup and Crisis Recovery | D3-BCR | Backup y recuperación | Veeam/Acronis 3-2-1-1-0 |
| Network Segmentation | D3-NS | Segmentación de red | VLANs + FortiGate policies |
| Endpoint Detection | D3-EDR | Detección en endpoints | CrowdStrike Falcon, Trellix |
| Platform Anomaly Detection | D3-PAN | Anomalías en plataforma | CrowdStrike ML/AI |
| File System Analysis | D3-FS | Análisis de archivos | Canary files, FIM |
| Credential Assessment | D3-CA | Evaluación de credenciales | LAPS, BloodHound |
| Process Hollowing Detection | D3-PH | Detección de process hollowing | CrowdStrike IOA |
| Restore Access | D3-RA | Restauración de acceso | AD recovery procedures |
| Disk Imaging | D3-DI | Imagen de disco | FTK Imager, dd |
| Network Traffic Analysis | D3-NTA | Análisis de tráfico | FortiGate, NetFlow |
| Process Spawn Analysis | D3-PSA | Análisis de procesos | CrowdStrike process tree |
| System Call Analysis | D3-SA | Análisis de llamadas | EDR kernel-level monitoring |
| Configuration Enforcement | D3-CE | Aplicación de configuración | GPO, Trellix ePO policies |
| Dynamic Content Execution | D3-DCE | Ejecución de contenido dinámico | Sandboxing, ATP |

---

## Referencias y Recursos

### Frameworks y Guías
- **CISA StopRansomware Guide:** https://www.stopransomware.gov/
- **CISA KEV Catalog:** https://www.cisa.gov/known-exploited-vulnerabilities-catalog
- **NIST SP 800-61 Rev.2:** Computer Security Incident Handling Guide
- **NIST CSF 2.0:** Cybersecurity Framework
- **MITRE ATT&CK:** https://attack.mitre.org/
- **MITRE D3FEND:** https://d3fend.mitre.org/

### Herramientas de Recuperación
- **No More Ransom:** https://www.nomoreransom.org/
- **ID Ransomware:** https://id-ransomware.malwarehunterteam.com/
- **Emsisoft Decryptors:** https://www.emsisoft.com/ransomware-decryption-tools/
- **Avast Decryptors:** https://www.avast.com/ransomware-decryption-tools
- **Kaspersky NoRansom:** https://noransom.kaspersky.com/

### Reporte de Incidentes
- **FBI IC3:** https://www.ic3.gov/
- **CISA Report:** https://www.cisa.gov/report
- **Policía Cibernética México:** 088
- **ENISA:** https://www.enisa.europa.eu/

### Familias de Ransomware Activas (2024-2026)
- **LockBit 3.0/4.0:** RaaS, double extortion, el más prevalente
- **BlackCat/ALPHV:** Rust-based, triple extortion
- **Cl0p:** Exploita MOVEit, zero-day vulnerabilities
- **Royal/BlackSuit:** Targets critical infrastructure
- **Akaii:** RaaS en crecimiento
- **INC Ransomware:** Targets healthcare
- **MedusaLocker:** Phishing-based distribution

---

## Notas Específicas para Clientes BRIDA

### Grupo Pepe — Plan de Acción Prioritario

```
FASE 1 (Inmediata - Semana 1-2):
🔴 Instalar EDR (Trellix o CrowdStrike) en TODOS los endpoints
🔴 Implementar backups 3-2-1 con inmutabilidad
🔴 Cerrar RDP expuesto a Internet
🔴 Implementar MFA en cuentas administrativas

FASE 2 (Corto plazo - Mes 1-2):
🟠 Implementar segmentación de red básica (VLANs)
🟠 Implementar Active Directory con LAPS
🟠 Configurar email security (SPF/DKIM/DMARC)
🟠 Aplicar parches críticos

FASE 3 (Mediano plazo - Mes 3-6):
🟡 Implementar SIEM básico
🟡 Realizar tabletop exercise de ransomware
🟡 Implementar security awareness training
🟡 Configurar monitoreo de red

FASE 4 (Largo plazo - Mes 6-12):
🟢 Evaluar MDR (CrowdStrike Falcon Complete)
🟢 Implementar Zero Trust Architecture
🟢 Obtener cyber insurance
🟢 Realizar penetration testing
```

### Contactos de Emergencia BRIDA

```
EQUIPO DE INCIDENT RESPONSE:
├── Líder IR: [Configurar según equipo BRIDA]
├── Contacto CrowdStrike: support@crowdstrike.com / 1-888-579-2704
├── Contacto Trellix: https://www.trellix.com/support/
├── Contacto Fortinet: https://support.fortinet.com/
├── Asesor Legal: [Configurar según cliente]
└── Autoridades: Policía Cibernética (088 MX) / FBI IC3
```
