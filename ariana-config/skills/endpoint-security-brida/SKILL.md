---
name: endpoint-security-brida
description: 'Endpoint security assessment and EDR operations for BRIDA IT Services clients. Covers EDR deployment (CrowdStrike/Trellix), fileless malware detection, LOLBin analysis, persistence hunting, and endpoint hardening. Activates for: endpoint security, EDR, fileless malware, LOLBin, persistence, endpoint hardening, CrowdStrike, Trellix.'
domain: cybersecurity
subdomain: endpoint-security
tags:
- endpoint-security
- EDR
- fileless-malware
- LOLBin
- persistence
- endpoint-hardening
- CrowdStrike
- Trellix
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- PR.PT-03
- DE.CM-01
- DE.AE-02
- RS.AN-03
mitre_attack:
- T1027
- T1055
- T1140
- T1547
- T1574
---

# Endpoint Security — BRIDA IT Services

## Descripción
Evaluación de seguridad de endpoints y operaciones EDR para clientes de BRIDA IT Services. Cubre despliegue de EDR (CrowdStrike/Trellix), detección de malware fileless, análisis de LOLBin, caza de persistencia y hardening de endpoints.

## Cuándo Usar
- Despliegue de EDR en endpoints corporativos
- Investigación de incidentes en endpoints
- Caza de amenazas (threat hunting) en endpoints
- Evaluación de configuraciones de seguridad de endpoints
- Respuesta a incidentes de malware/ransomware

## Stack EDR BRIDA

### CrowdStrike Falcon
```
Componentes:
- Falcon Sensor (agente ligero)
- Falcon Prevent (antivirus next-gen)
- Falcon Insight (EDR)
- Falcon OverWatch (managed threat hunting)
- Falcon Discover (IT hygiene)
- Falcon Identity (identity protection)

Despliegue:
1. Instalar Falcon Sensor en endpoints
2. Configurar políticas de prevención
3. Configurar detección de IOAs (Indicators of Attack)
4. Configurar alertas y notificaciones
5. Integrar con SIEM

Comandos útiles:
# Verificar estado del sensor
sc query csagent

# Sensor ID
reg query "HKLM\SYSTEM\CurrentControlSet\Services\CSAgent\Sim" /v AgentId
```

### Trellix (McAfee) ePO + Endpoint Security
```
Componentes:
- Trellix ePO (ePolicy Orchestrator) — Consola central
- Trellix Endpoint Security (ENS) — Agente
- Trellix MVISION Cloud — CASB
- Trellix Threat Intelligence — Feeds

Despliegue:
1. Instalar ePO Server
2. Desplegar agente ENS via ePO
3. Configurar políticas de Threat Prevention
4. Configurar Access Protection rules
5. Configurar Web Control
6. Integrar con SIEM
```

## Fileless Malware Detection

### Técnicas Fileless Comunes
```
1. PowerShell malicioso
   - Invoke-Expression, DownloadString, -enc (base64)
   - AMSI bypass attempts
   - Reflection assembly loading

2. WMI persistence
   - Event subscriptions
   - CommandLineEventConsumer

3. .NET reflection
   - Assembly.Load() desde memoria
   - CSharp compilation en runtime

4. LOLBin abuse
   - certutil.exe (download)
   - mshta.exe (execute scripts)
   - regsvr32.exe (execute COM scripts)
   - rundll32.exe (execute DLLs)
   - wmic.exe (execute commands)

5. Process injection
   - Process hollowing
   - DLL injection
   - APC injection
   - Thread execution hijacking
```

### Detección de PowerShell Malicioso
```powershell
# Habilitar Script Block Logging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Value 1

# Habilitar Module Logging
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" -Name "EnableModuleLogging" -Value 1

# Buscar comandos sospechosos en logs
Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" | 
  Where-Object {$_.Message -match "Invoke-|DownloadString|-enc |IEX"} |
  Select-Object TimeCreated, Message
```

### Detección de LOLBin Abuse
```yaml
# Sigma rule: LOLBin Execution
title: Suspicious LOLBin Execution
logsource:
  product: windows
  service: sysmon
detection:
  selection:
    EventID: 1
    CommandLine|contains:
      - 'certutil.exe -urlcache'
      - 'certutil.exe -decode'
      - 'mshta.exe http'
      - 'regsvr32.exe /i'
      - 'rundll32.exe javascript'
      - 'wmic.exe process call create'
  condition: selection
```

## Persistence Hunting

### Ubicaciones de Persistencia Comunes
```
Registry Run Keys:
- HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
- HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
- HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
- HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run

Scheduled Tasks:
- Revisar tareas con "schtasks /query /fo LIST /v"
- Buscar tareas ocultas o con nombres sospechosos

Services:
- sc query type= service state= all
- Buscar servicios con rutas inusuales

WMI Event Subscriptions:
- Get-WmiObject -Class __EventFilter -Namespace root\subscription
- Get-WmiObject -Class __FilterToConsumerBinding -Namespace root\subscription

Startup Folders:
- C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
- C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

DLL Hijacking:
- Buscar DLLs en directorios escribibles
- Revisar DLLs sin firma digital
```

### Comandos de Hunting
```powershell
# Buscar persistencia en registry
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
Get-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

# Buscar scheduled tasks sospechosas
schtasks /query /fo LIST /v | findstr /i "powershell|cmd|wscript|cscript|mshta"

# Buscar WMI persistence
Get-WmiObject -Class __EventFilter -Namespace root\subscription
Get-WmiObject -Class CommandLineEventConsumer -Namespace root\subscription

# Buscar servicios con rutas inusuales
Get-WmiObject Win32_Service | Where-Object {$_.PathName -notmatch "Windows|Program Files"} | Select Name, PathName, State
```

## Endpoint Hardening Checklist

### Windows Endpoints
```
[ ] Habilitar Windows Defender ATP (si no hay EDR de terceros)
[ ] Configurar Attack Surface Reduction (ASR) rules
[ ] Habilitar Credential Guard
[ ] Habilitar BitLocker
[ ] Configurar AppLocker / Windows Defender Application Control
[ ] Deshabilitar SMBv1
[ ] Deshabilitar LLMNR y NBT-NS
[ ] Configurar PowerShell Constrained Language Mode
[ ] Habilitar PowerShell Script Block Logging
[ ] Configurar Windows Event Forwarding al SIEM
[ ] Deshabilitar macros en Office (o habilitar solo firmadas)
[ ] Configurar Windows Update for Business
[ ] Habilitar Exploit Protection (EMET successor)
[ ] Configurar Windows Firewall (deny by default)
[ ] Deshabilitar RDP si no es necesario
[ ] Configurar LAPS (Local Admin Password Solution)
```

### Políticas de Grupo (GPO) Recomendadas
```
Computer Configuration > Policies > Windows Settings > Security Settings:
- Account Policies: Password policy, lockout policy
- Local Policies: Audit policy, user rights assignment
- Windows Firewall: Domain profile (block inbound)
- Security Options:
  - Interactive logon: Do not display last username
  - Microsoft network client: Digitally sign communications
  - Network access: Do not allow anonymous enumeration of SAM accounts
  
Administrative Templates > Windows Components:
- Windows Defender Antivirus: Real-time protection ON
- Windows Update: Configure Automatic Updates
- PowerShell: Turn on Script Block Logging
```

## Métricas de Seguridad de Endpoints
| KPI | Meta | Descripción |
|---|---|---|
| EDR Coverage | > 95% | % de endpoints con agente EDR |
| Patch Compliance | > 90% | % de endpoints parcheados |
| Mean Time to Detect | < 1 hora | Tiempo promedio de detección |
| Mean Time to Respond | < 4 horas | Tiempo promedio de respuesta |
| False Positive Rate | < 15% | Tasa de falsos positivos |
| Endpoint Isolation Time | < 15 min | Tiempo para aislar un endpoint |
