---
name: endpoint-security-brida
description: "Endpoint Security skill for BRIDA IT Services: EDR deployment (CrowdStrike Falcon / Trellix Endpoint Security), fileless malware detection, LOLBin analysis, persistence hunting, and endpoint hardening for mid-market Mexican enterprises. Incluye mapeo MITRE ATT&CK, NIST CSF y D3FEND."
version: 1.0.0
author: BRIDA IT Services
license: Proprietary
category: cybersecurity
platforms: [linux, windows, macos]
triggers:
  - "EDR"
  - "endpoint security"
  - "CrowdStrike"
  - "Trellix"
  - "fileless malware"
  - "LOLBin"
  - "LOLBins"
  - "persistence hunting"
  - "endpoint hardening"
  - "malware detection"
  - "threat hunting"
  - "MITRE ATT&CK"
  - "NIST CSF"
  - "D3FEND"
  - "seguridad de endpoints"
  - "detección de malware"
  - "análisis de LOLBins"
  - "caza de persistencia"
  - "hardening de endpoints"
  - "BRIDA"
  - "CrowdStrike Falcon"
  - "Trellix Endpoint Security"
  - "McAfee"
  - "HIPS"
  - "host-based"
  - "endpoint detection and response"
metadata:
  hermes:
    tags: [security, edr, endpoint, crowdstrike, trellix, fileless-malware, lolbin, persistence, hardening, threat-hunting, mitre-attack, nist-csf, d3fend, brida, mexico, cybersecurity, endpoint-security, malware-detection]
    language: "es-MX"
    compliance: [NIST-CSF, ISO-27001, PCI-DSS, LFPDPPP]
---

# Endpoint Security — BRIDA IT Services

> **Seguridad de Endpoints** — Guía integral para la protección de endpoints en empresas del mercado medio mexicano.

Este skill cubre la seguridad de endpoints de forma integral: desde la implementación de EDR (CrowdStrike Falcon y Trellix Endpoint Security), detección de fileless malware, análisis de LOLBins, caza de persistencia (persistence hunting), hasta el hardening de sistemas operativos. Todo alineado con marcos **MITRE ATT&CK**, **NIST CSF** y **D3FEND**.

---

## Tabla de Contenido

1. [Arquitectura de Seguridad de Endpoints](#1-arquitectura-de-seguridad-de-endpoints)
2. [EDR — Implementación y Operación](#2-edr--implementación-y-operación)
   - 2.1 [CrowdStrike Falcon](#21-crowdstrike-falcon)
   - 2.2 [Trellix Endpoint Security (McAfee)](#22-trellix-endpoint-security-mcafee)
   - 2.3 [Comparativa: CrowdStrike vs. Trellix](#23-comparativa-crowdstrike-vs-trellix)
3. [Detección de Fileless Malware](#3-detección-de-fileless-malware)
4. [Análisis de LOLBins](#4-análisis-de-lolbins)
5. [Persistence Hunting](#5-persistence-hunting)
6. [Endpoint Hardening](#6-endpoint-hardening)
   - 6.1 [Windows Hardening](#61-windows-hardening)
   - 6.2 [Linux Hardening](#62-linux-hardening)
   - 6.3 [macOS Hardening](#63-macos-hardening)
7. [Mapeo MITRE ATT&CK](#7-mapeo-mitre-attck)
8. [Mapeo NIST CSF](#8-mapeo-nist-csf)
9. [Mapeo D3FEND](#9-mapeo-d3fend)
10. [Playbooks de Respuesta](#10-playbooks-de-respuesta)
11. [Métricas y KPIs](#11-métricas-y-kpis)
12. [Herramientas Recomendadas](#12-herramientas-recomendadas)
13. [Plantillas y Quick References](#13-plantillas-y-quick-references)

---

## 1. Arquitectura de Seguridad de Endpoints

### 1.1 Modelo de Defensa en Profundidad para Endpoints

```
┌─────────────────────────────────────────────────────────────────┐
│              ARQUITECTURA DE SEGURIDAD DE ENDPOINTS              │
│                         BRIDA IT Services                        │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    CAPA 1: PREVENCIÓN                     │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │   │
│  │  │ Antimal- │ │ Hardened │ │ App      │ │ Patch      │  │   │
│  │  │ ware     │ │ Config   │ │ Control  │ │ Management │  │   │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                          │                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    CAPA 2: DETECCIÓN                      │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │   │
│  │  │ EDR      │ │ Behavior │ │ Memory   │ │ Threat     │  │   │
│  │  │ Agent    │ │ Analysis │ │ Scanning │ │ Intel      │  │   │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                          │                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    CAPA 3: RESPUESTA                      │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │   │
│  │  │ Auto     │ │ Host     │ │ Forensic │ │ Incident   │  │   │
│  │  │ Response │ │ Isolate  │ │ Capture  │ │ Playbook   │  │   │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                          │                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    CAPA 4: CAZA PROACTIVA                 │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │   │
│  │  │ Threat   │ │ IOC      │ │ Anomaly  │ │ Hunt       │  │   │
│  │  │ Hunting  │ │ Sweep    │ │ Detection│ │ Hypothesis │  │   │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 Inventario de Endpoints — Clasificación por Criticidad

| Criticidad | Tipo de Endpoint | Ejemplos | Nivel de Protección |
|-----------|-----------------|---------|-------------------|
| **Crítica** | Controladores de dominio, servidores de base de datos, servidores de correo | DC01, SQL-PROD, EXCHANGE01 | EDR + HIPS + Application Control + Full Monitoring |
| **Alta** | Servidores de aplicaciones, servidores web, estaciones de trabajo de administradores | APP01, WEB01, WK-ADMIN-01 | EDR + HIPS + Standard Monitoring |
| **Media** | Estaciones de trabajo de usuarios regulares, laptops | WK-USER-001, LAPTOP-VENTAS-03 | EDR + Basic Monitoring |
| **Baja** | Dispositivos de impresión con red, IoT, kioscos | PRINTER-FL2, TERM-KIOSK-01 | Network Segmentation + Minimal Agent |

### 1.3 Requisitos Previos a la Implementación

1. **Inventario completo de activos:** Documentar todos los endpoints con: hostname, OS, versión, propietario, ubicación, criticidad
2. **Línea base de rendimiento:** Medir CPU, memoria y disco antes de la instalación del agente
3. **Excepciones documentadas:** Identificar aplicaciones legítimas que puedan generar falsos positivos
4. **Plan de rollback:** Procedimiento para desinstalar/revertir en caso de problemas
5. **Comunicación a usuarios:** Notificar sobre la instalación, impacto esperado y contacto de soporte
6. **Ventana de mantenimiento:** Definir horarios de instalación por zona geográfica

---

## 2. EDR — Implementación y Operación

### 2.1 CrowdStrike Falcon

#### 2.1.1 Arquitectura de Falcon

```
┌─────────────────────────────────────────────────────────────┐
│                    CROWDSTRIKE FALCON CLOUD                  │
│                                                              │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────┐    │
│  │ Falcon     │  │ Threat     │  │ OverWatch           │    │
│  │ Prevent    │  │ Graph      │  │ (Managed Hunting)   │    │
│  │ (NGAV)     │  │            │  │                     │    │
│  └────────────┘  └────────────┘  └────────────────────┘    │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────┐    │
│  │ Falcon     │  │ Falcon     │  │ Falcon Discover     │    │
│  │ Insight    │  │ Complete   │  │ (IT Hygiene)        │    │
│  │ (EDR)      │  │ (MDR)      │  │                     │    │
│  └────────────┘  └────────────┘  └────────────────────┘    │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              Falcon Data Replicator (FDR)             │   │
│  │              (Integración SIEM)                       │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
          │                    │                    │
          ▼                    ▼                    ▼
   ┌──────────┐        ┌──────────┐        ┌──────────┐
   │ Windows  │        │  Linux   │        │  macOS   │
   │ Sensor   │        │  Sensor  │        │  Sensor  │
   └──────────┘        └──────────┘        └──────────┘
```

#### 2.1.2 Módulos Recomendados para Mid-Market

| Módulo | Función | Recomendación |
|--------|---------|---------------|
| **Falcon Prevent** | Next-Gen Antivirus (NGAV) — prevención basada en indicadores y comportamiento | **Obligatorio** — Base de protección |
| **Falcon Insight** | EDR — detección, investigación y respuesta | **Obligatorio** — Visibilidad y forense |
| **Falcon OverWatch** | Managed Threat Hunting 24/7 por CrowdStrike | **Altamente recomendado** — Compensa falta de L3 interno |
| **Falcon Discover** | IT Hygiene — inventario de software y vulnerabilidades | **Recomendado** — Visibilidad de activos |
| **Falcon Device Control** | Control de dispositivos USB | **Recomendado** — Prevención de exfiltración |
| **Falcon Firewall Management** | Gestión centralizada de firewall host | **Opcional** — Si no se tiene solución dedicada |

#### 2.1.3 Instalación del Sensor

**Windows (Silent Install):**
```powershell
# Instalación silenciosa del Falcon Sensor
# Obtener CID (Customer ID) desde la consola de Falcon

# Método 1: Instalación directa
WindowsSensor.exe /install /quiet /norestart CID=<YOUR-CID>

# Método 2: Con token de instalación (recomendado para despliegue masivo)
WindowsSensor.exe /install /quiet /norestart CID=<YOUR-CID> "GROUPING_TAGS=produccion,servidores"

# Método 3: Via SCCM/Intune
# Crear paquete MSI con los parámetros anteriores
# Distribuir vía Software Center o política de grupo

# Verificar instalación
& "C:\Program Files\CrowdStrike\CSFalconContainer.exe" --status
# Verificar en consola de Falcon que el host aparece como "Online"
```

**Linux:**
```bash
# Ubuntu/Debian
sudo dpkg -i falcon-sensor_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=<YOUR-CID>
sudo systemctl start falcon-sensor
sudo systemctl enable falcon-sensor

# RHEL/CentOS
sudo rpm -ivh falcon-sensor.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=<YOUR-CID>
sudo systemctl start falcon-sensor
sudo systemctl enable falcon-sensor

# Verificar estado
sudo /opt/CrowdStrike/falconctl -g --cid
sudo systemctl status falcon-sensor

# Con tags de agrupamiento
sudo /opt/CrowdStrike/falconctl -s --cid=<YOUR-CID> --tags="produccion,linux,servidores"
```

**macOS:**
```bash
# Instalación del sensor
sudo installer -pkg FalconSensorMacOS.pkg -target /

# Configurar CID
sudo /Applications/Falcon.app/Contents/Resources/falconctl license <YOUR-CID>

# Verificar
sudo /Applications/Falcon.app/Contents/Resources/falconctl stats
```

#### 2.1.4 Configuración de Políticas de Prevención

```yaml
# Política de Prevención — BRIDA IT Services
# Nombre: "BRIDA-Prevention-Policy-Critical"

policy:
  name: "BRIDA-Prevention-Policy-Critical"
  description: "Política de prevención para endpoints críticos"
  platform: "windows"
  
  # Configuración de detección
  detection_settings:
    sensor_visibility: "ALL"  # Detectar todo, no solo bloquear
    cloud_machine_learning: "AGGRESSIVE"
    on_sense_machine_learning: "AGGRESSIVE"
    detection_reporting: "DETECTED"  # Log de detecciones
    
  # Acciones automátas
  prevention:
    block_unknown_executables: true
    block_unknown_execution_paths: true
    block_unknown_powershell_scripts: true
    block_file_cryptors: true
    block_script_based_execution: true
    block_process_hollowing: true
    block_reflective_dll_loading: true
    block_credential_dumping: true
    
  # Protección de ransomware
  ransomware_protection:
    enabled: true
    action: "BLOCK"
    protect_user_files: true
    protect_system_files: true
    
  # Protección de exploits
  exploit_prevention:
    enabled: true
    prevent_browser_exploits: true
    prevent_office_exploits: true
    prevent_pdf_exploits: true
    prevent_java_exploits: true
    
  # Control de scripts
  script_control:
    enabled: true
    block_obfuscated_scripts: true
    block_scripts_downloading_payloads: true
    allowed_publishers: ["Microsoft", "Adobe", "BRIDA-Signing-CA"]
    
  # Indicadores de compromiso (IOCs)
  custom_iocs:
    enabled: true
    action: "BLOCK"
    severity: "HIGH"
```

#### 2.1.5 Queries Falcon Spotlight (Vulnerability Management)

```sql
# Vulnerabilidades críticas sin parchear por más de 30 días
# Falcon Spotlight Query

SELECT 
    hostname,
    os_version,
    cve_id,
    cvss_score,
    severity,
    days_since_publish,
    solution
FROM spotlight_vulnerabilities
WHERE severity = 'CRITICAL'
  AND days_since_publish > 30
  AND status = 'OPEN'
ORDER BY cvss_score DESC, days_since_publish DESC;

# Software vulnerable instalado en endpoints críticos
SELECT 
    hostname,
    software_name,
    software_version,
    cve_count,
    max_cvss_score
FROM spotlight_software
WHERE max_cvss_score >= 9.0
  AND hostname IN (SELECT hostname FROM hosts WHERE grouping_tags LIKE '%critico%')
ORDER BY max_cvss_score DESC;
```

#### 2.1.6 Queries Falcon Real Time Response (RTR)

```bash
# Investigación remota via RTR

# Obtener procesos en ejecución
ps

# Verificar conexiones de red activas
netstat -nao

# Buscar archivos sospechosos en temp
ls -la C:\Users\*\AppData\Local\Temp\

# Verificar tareas programadas
schtasks /query /fo LIST /v

# Verificar servicios
sc query type= service state= all

# Buscar persistencia en registro
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run

# Capturar memoria (forense)
memdump --pid <PID> --dest C:\CrowdStrike\forensic\

# Ejecutar script de remediación
runscript -CloudFile="BRIDA-Remediation-Script" -CommandLine=""
```

### 2.2 Trellix Endpoint Security (McAfee)

#### 2.2.1 Arquitectura de Trellix

```
┌─────────────────────────────────────────────────────────────┐
│                    TRELLIX ePO CLOUD / ON-PREMISE            │
│                                                              │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────┐    │
│  │ Endpoint   │  │ Threat     │  │ Data Exchange      │    │
│  │ Security   │  │ Prevention │  │ Layer (DXL)        │    │
│  │ (ENS)      │  │            │  │                    │    │
│  └────────────┘  └────────────┘  └────────────────────┘    │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────┐    │
│  │ Threat     │  │ Web        │  │ MVISION            │    │
│  │ Prevention │  │ Control    │  │ (Cloud Platform)   │    │
│  │            │  │            │  │                    │    │
│  └────────────┘  └────────────┘  └────────────────────┘    │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────┐    │
│  │ Host       │  │ Application │  │ Endpoint Detection │    │
│  │ Intrusion  │  │ Control    │  │ & Response (EDR)   │    │
│  │ Prevention │  │            │  │                    │    │
│  └────────────┘  └────────────┘  └────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
          │                    │                    │
          ▼                    ▼                    ▼
   ┌──────────┐        ┌──────────┐        ┌──────────┐
   │ Windows  │        │  Linux   │        │  macOS   │
   │ Agent    │        │  Agent   │        │  Agent   │
   └──────────┘        └──────────┘        └──────────┘
```

#### 2.2.2 Módulos Recomendados

| Módulo | Función | Recomendación |
|--------|---------|---------------|
| **Endpoint Security (ENS) Threat Protection** | Antimalware en tiempo real y bajo demanda | **Obligatorio** |
| **ENS Exploit Prevention** | Protección contra exploits de aplicaciones | **Obligatorio** |
| **ENS Firewall** | Firewall host con reglas granulares | **Recomendado** |
| **ENS Web Control** | Filtrado web y protección de navegación | **Recomendado** |
| **Host Intrusion Prevention (HIPS)** | Detección basada en comportamiento del host | **Obligatorio** |
| **Application Control** | Whitelisting de aplicaciones | **Recomendado para servidores** |
| **Trellix Endpoint Detection and Response (EDR)** | Investigación y respuesta a amenazas | **Obligatorio** |
| **MVISION Insights** | Visibilidad de amenazas en la nube | **Recomendado** |

#### 2.2.3 Instalación del Agente

**Windows (via ePO):**
```powershell
# Instalación del agente Trellix (McAfee Agent)
# Descargar FramePkg.exe desde la consola ePO

# Instalación silenciosa
FramePkg.exe /INSTALL=AGENT /SILENT

# Con servidor ePO específico
FramePkg.exe /INSTALL=AGENT /SILENT /SERVER_NAME=epo-server.empresa.local

# Verificar instalación
# El agente se registra automáticamente en ePO
# Verificar en ePO Console → System Tree

# Forzar actualización de políticas desde el agente
"C:\Program Files\McAfee\Agent\cmdagent.exe" /p  # Recuperar políticas
"C:\Program Files\McAfee\Agent\cmdagent.exe" /c  # Enviar propiedades
"C:\Program Files\McAfee\Agent\cmdagent.exe" /e  # Enforce policies
```

**Linux:**
```bash
# Instalación del agente Trellix para Linux
# Descargar el paquete desde ePO

# Instalación
sudo ./install.sh -i  # Interactiva
sudo ./install.sh -s  # Silenciosa

# Verificar estado
sudo /opt/McAfee/agent/bin/cmdagent.sh -p  # Recuperar políticas
sudo /opt/McAfee/agent/bin/cmdagent.sh -i  # Información del agente

# Instalación de ENS para Linux
sudo rpm -ivh McAfeeEndpointSecurity_linux.x86_64.rpm
# o
sudo dpkg -i McAfeeEndpointSecurity_linux.amd64.deb
```

#### 2.2.4 Configuración de Políticas en ePO

```yaml
# Política ENS — BRIDA IT Services
# Nombre: "BRIDA-ENS-Policy-Critical"

policy:
  name: "BRIDA-ENS-Policy-Critical"
  product: "Endpoint Security Threat Protection"
  
  # Access Protection Rules
  access_protection:
    block_port_scanning: true
    block_network_sniffing: true
    block_process_termination: false
    block_suspicious_dll_injection: true
    block_process_hollowing: true
    block_credential_access: true
    
  # On-Access Scan Settings
  on_access_scan:
    scan_on_read: true
    scan_on_write: true
    scan_files: "ALL_FILES"
    scan_archives: true
    scan_max_archive_depth: 3
    scan_network_drives: true
    action_first: "CLEAN"
    second_action: "DELETE"
    action_timeout: "DENY_ACCESS"
    
  # Exploit Prevention
  exploit_prevention:
    enabled: true
    rules:
      - "Adobe Reader Exploit Prevention"
      - "Browser Exploit Prevention"
      - "Java Exploit Prevention"
      - "Microsoft Office Exploit Prevention"
      - "Script Exploit Prevention"
      - "OS Exploit Prevention"
    action: "BLOCK_AND_REPORT"
    
  # Threat Prevention (AM)
  threat_pretection:
    Artemis_enabled: true
    Artemis_sensitivity: "HIGH"
    Artemis_local_detection: "ENABLED"
    GTI_enabled: true
    GTI_cloud_lookup: true
    
  # Host Intrusion Prevention
  hips:
    enabled: true
    ruleset: "BRIDA-Custom-Ruleset"
    block_suspicious_registry: true
    block_suspicious_scheduled_tasks: true
    block_suspicious_services: true
    block_suspicious_startup_items: true
```

#### 2.2.5 Queries Trellix EDR

```sql
# Consultas Trellix EDR — Threat Hunting

# Procesos sospechosos con conexión de red
SELECT 
    hostname,
    process_name,
    process_path,
    parent_process,
    command_line,
    network_connections,
    start_time
FROM edr_processes
WHERE process_name IN (
    'powershell.exe', 'cmd.exe', 'mshta.exe', 'certutil.exe',
    'bitsadmin.exe', 'regsvr32.exe', 'rundll32.exe', 'wscript.exe',
    'cscript.exe', 'msiexec.exe', 'cmstp.exe'
)
AND network_connections IS NOT NULL
ORDER BY start_time DESC;

# Modificaciones de registro sospechosas
SELECT 
    hostname,
    registry_key,
    registry_value,
    process_name,
    timestamp
FROM edr_registry_events
WHERE registry_key LIKE '%\\CurrentVersion\\Run%'
   OR registry_key LIKE '%\\Winlogon\\Shell%'
   OR registry_key LIKE '%\\Winlogon\\Userinit%'
   OR registry_key LIKE '%\\Windows\\CurrentVersion\\Explorer\\Shell Folders%'
ORDER BY timestamp DESC;

# Servicios instalados recientemente
SELECT 
    hostname,
    service_name,
    service_path,
    service_start_type,
    install_process,
    install_time
FROM edr_services
WHERE install_time > NOW() - INTERVAL '7 days'
ORDER BY install_time DESC;
```

### 2.3 Comparativa: CrowdStrike vs. Trellix

| Criterio | CrowdStrike Falcon | Trellix Endpoint Security |
|----------|-------------------|--------------------------|
| **Arquitectura** | 100% cloud-native (sensor ligero) | Híbrido (ePO on-premise o cloud) |
| **Peso del agente** | ~50MB RAM, <1% CPU | ~100-150MB RAM, 1-3% CPU |
| **Detección NGAV** | ML on-sensor + cloud | GTI cloud + Artemis local |
| **EDR nativo** | Falcon Insight (incluido) | Trellix EDR (módulo separado) |
| **Managed Hunting** | OverWatch (incluido en Complete) | Trellix Threat Intelligence |
| **Application Control** | Falcon Discover + Device Control | Application Control (módulo dedicado) |
| **Integración SIEM** | FDR (Falcon Data Replicator) | DXL + Syslog |
| **Facilidad de despliegue** | ★★★★★ (muy simple) | ★★★ (requiere ePO) |
| **Personalización** | ★★★★ | ★★★★★ (muy granular) |
| **Soporte para Linux** | ★★★★★ | ★★★ |
| **Soporte para macOS** | ★★★★★ | ★★★ |
| **Costo relativo** | $$$$ | $$$ |
| **Ideal para** | Equipos pequeños, multi-OS | Entornos Windows-heavy, compliance |
| **MITRE ATT&CK evaluación** | Consistentemente top-ranked | Buena cobertura |

**Recomendación BRIDA:**
- **CrowdStrike Falcon** para organizaciones con equipos de TI pequeños, entornos multi-OS, y necesidad de MDR (Managed Detection and Response)
- **Trellix ENS** para organizaciones con infraestructura McAfee existente, entornos Windows-dominantes, y requerimientos de application control granular

---

## 3. Detección de Fileless Malware

### 3.1 ¿Qué es Fileless Malware?

El fileless malware (malware sin archivos) no escribe archivos ejecutables en disco. Opera principalmente en memoria, aprovechando herramientas legítimas del sistema (LOLBins) y técnicas de inyección de procesos. Es extremadamente difícil de detectar con antivirus tradicionales.

### 3.2 Técnicas de Fileless Malware

| Técnica | Descripción | MITRE ATT&CK | Detección |
|---------|-------------|--------------|-----------|
| **PowerShell Empire** | Ejecución de payloads en memoria vía PowerShell | T1059.001, T1059.003 | Script Block Logging, AMSI |
| **Reflective DLL Injection** | Carga de DLL sin pasar por LoadLibrary | T1055.001, T1620 | Memory scanning, EDR |
| **Process Hollowing** | Creación de proceso suspendido, reemplazo de memoria | T1055.012 | EDR behavior analysis |
| **Process Doppelgänging** | Manipulación de transacciones NTFS | T1055.013 | EDR + kernel callbacks |
| **Atom Bombing** | Inyección vía atom tables de Windows | T1055.004 | Memory forensics |
| **Living-off-the-Land** | Uso de herramientas nativas del sistema | T1218, T1059 | Command-line monitoring |
| **WMI Persistence** | Suscripciones a eventos WMI | T1546.003 | WMI logging, EDR |
| **COM Hijacking** | Manipulación de objetos COM | T1546.015 | Registry monitoring |
| **Registry-based Payloads** | Código malicioso en valores de registro | T1112, T1547.001 | Registry monitoring |
| **.NET In-Memory** | Compilación y ejecución de .NET en memoria | T1620, T1059.001 | CLR ETW, EDR |

### 3.3 Estrategia de Detección

```
┌─────────────────────────────────────────────────────────────────┐
│              DETECCIÓN DE FILELESS MALWARE                       │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  CAPA 1: PREVENCIÓN                                      │   │
│  │  • AMSI (Antimalware Scan Interface) habilitado          │   │
│  │  • PowerShell Constrained Language Mode                  │   │
│  │  • Attack Surface Reduction (ASR) Rules                  │   │
│  │  • WDAC/AppLocker (Application Control)                  │   │
│  │  • Deshabilitar macros en Office                         │   │
│  └──────────────────────────────────────────────────────────┘   │
│                          │                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  CAPA 2: MONITOREO EN TIEMPO REAL                        │   │
│  │  • Script Block Logging (PowerShell)                     │   │
│  │  • Module Logging (PowerShell)                           │   │
│  │  • Transcription Logging (PowerShell)                    │   │
│  │  • Sysmon (Event IDs 1, 7, 8, 10, 12, 13, 15)          │   │
│  │  • ETW (Event Tracing for Windows)                       │   │
│  │  • EDR behavior-based detection                          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                          │                                       │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │  CAPA 3: ANÁLISIS FORENSE                                │   │
│  │  • Memory dump analysis (Volatility)                     │   │
│  │  • YARA rules en memoria                                 │   │
│  │  • Network traffic analysis                              │   │
│  │  • Timeline analysis                                     │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
```

### 3.4 Configuración de Detección en Windows

#### PowerShell Logging (Obligatorio)

```powershell
# Habilitar Script Block Logging
# Via Group Policy: Computer Configuration → Administrative Templates → 
#   Windows Components → Windows PowerShell

# Via Registry:
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" `
    -Name "EnableScriptBlockLogging" -Value 1 -PropertyType DWord -Force

# Habilitar Module Logging
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" `
    -Name "EnableModuleLogging" -Value 1 -PropertyType DWord -Force

# Especificar módulos a loguear (todos)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames" `
    -Name "*" -Value "*" -PropertyType String -Force

# Habilitar Transcription
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" `
    -Name "EnableTranscripting" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" `
    -Name "OutputDirectory" -Value "C:\PSTranscripts" -PropertyType String -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" `
    -Name "EnableInvocationHeader" -Value 1 -PropertyType DWord -Force
```

#### Sysmon Config (Recomendado — SwiftOnSecurity)

```xml
<!-- sysmon-config.xml — BRIDA IT Services -->
<!-- Basado en SwiftOnSecurity con personalización BRIDA -->

<Sysmon schemaversion="4.90">
  <HashAlgorithms>SHA256,IMPHASH</HashAlgorithms>
  <CheckRevocation/>
  <DnsLookup>Enable</DnsLookup>
  
  <EventFiltering>
    <!-- Event ID 1: Process Create -->
    <RuleGroup name="ProcessCreate" groupRelation="or">
      <ProcessCreate onmatch="include">
        <ParentImage condition="contains any">powershell;pwsh;cmd;wscript;cscript;mshta</ParentImage>
        <Image condition="contains any">powershell;pwsh;cmd;wscript;cscript;mshta;certutil;bitsadmin;regsvr32;rundll32</Image>
        <CommandLine condition="contains any">-enc;-encodedcommand;-nop;-noni;-w hidden;-windowstyle hidden;downloadstring;downloadfile;invoke-expression;iex;invoke-webrequest;net.webclient;frombase64string;reflection.assembly;loadbyte;loadfile</CommandLine>
        <CommandLine condition="contains any">\\192.168;\\10.;\\172.16;\\172.17;\\172.18;\\172.19;\\172.20;\\172.21;\\172.22;\\172.23;\\172.24;\\172.25;\\172.26;\\172.27;\\172.28;\\172.29;\\172.30;\\172.31</CommandLine>
      </ProcessCreate>
    </RuleGroup>
    
    <!-- Event ID 7: Image Loaded -->
    <RuleGroup name="ImageLoad" groupRelation="or">
      <ImageLoad onmatch="include">
        <ImageLoaded condition="contains any">System.Management.Automation.dll;Microsoft.PowerShell</ImageLoaded>
        <ImageLoaded condition="end with">clr.dll</ImageLoaded>
        <ImageLoaded condition="end with">mscoree.dll</ImageLoaded>
      </ImageLoad>
    </RuleGroup>
    
    <!-- Event ID 8: CreateRemoteThread -->
    <RuleGroup name="CreateRemoteThread" groupRelation="or">
      <CreateRemoteThread onmatch="include">
        <TargetImage condition="contains any">lsass.exe;svchost.exe;explorer.exe;services.exe;winlogon.exe;csrss.exe</TargetImage>
        <StartFunction condition="contains">LoadLibrary</StartFunction>
      </CreateRemoteThread>
    </RuleGroup>
    
    <!-- Event ID 10: ProcessAccess -->
    <RuleGroup name="ProcessAccess" groupRelation="or">
      <ProcessAccess onmatch="include">
        <TargetImage condition="is">C:\Windows\system32\lsass.exe</TargetImage>
        <GrantedAccess condition="contains any">0x1010;0x1410;0x143A;0x1438;0x1000;0x100000</GrantedAccess>
      </ProcessAccess>
    </RuleGroup>
    
    <!-- Event ID 12, 13, 14: Registry Events -->
    <RuleGroup name="RegistryEvent" groupRelation="or">
      <RegistryEvent onmatch="include">
        <TargetObject condition="contains">\CurrentVersion\Run</TargetObject>
        <TargetObject condition="contains">\CurrentVersion\RunOnce</TargetObject>
        <TargetObject condition="contains">\Winlogon\Shell</TargetObject>
        <TargetObject condition="contains">\Winlogon\Userinit</TargetObject>
        <TargetObject condition="contains">\Windows\CurrentVersion\Explorer\Shell Folders</TargetObject>
        <TargetObject condition="contains">Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run</TargetObject>
        <TargetObject condition="contains">\CurrentVersion\Image File Execution Options</TargetObject>
        <TargetObject condition="contains">\CurrentVersion\Explorer\Browser Helper Objects</TargetObject>
      </RegistryEvent>
    </RuleGroup>
  </EventFiltering>
</Sysmon>
```

#### Attack Surface Reduction (ASR) Rules

```powershell
# Habilitar ASR Rules en modo bloqueo
# Requiere Windows 10/11 Enterprise o Education + Defender ATP

# Reglas ASR recomendadas para BRIDA:

# Bloquear aplicaciones Office de crear procesos hijo
Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear aplicaciones Office de crear contenido ejecutable
Add-MpPreference -AttackSurfaceReductionRules_Ids 3B576869-A4EC-4529-8536-B80A7769E899 `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear aplicaciones Office de inyectar código en otros procesos
Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear JavaScript/VBScript de lanzar contenido descargado
Add-MpPreference -AttackSurfaceReductionRules_Ids D3E037E1-3EB8-44C8-A917-57927947596D `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear ejecución de scripts ofuscados
Add-MpPreference -AttackSurfaceReductionRules_Ids 5BEB7EFE-FD9A-4556-801D-275E5FFC04CC `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear que procesos PSExec y WMI creen contenido ejecutable
Add-MpPreference -AttackSurfaceReductionRules_Ids D1E49AAC-8F56-4280-B9BA-993A6D77406C `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear procesos robados de USB
Add-MpPreference -AttackSurfaceReductionRules_Ids B2B3F03D-6A65-4F7B-A9C7-1C7EF74A9BA4 `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear comunicación de red desde Office
Add-MpPreference -AttackSurfaceReductionRules_Ids 26190899-1602-49E8-8B27-EB1D0A1CE869 `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear creación de procesos desde PSExec y WMI
Add-MpPreference -AttackSurfaceReductionRules_Ids D1E49AAC-8F56-4280-B9BA-993A6D77406C `
    -AttackSurfaceReductionRules_Actions Enabled

# Bloquear ejecución de contenido ejecutable a menos que cumpla criterios
Add-MpPreference -AttackSurfaceReductionRules_Ids 01443614-CD74-433A-B99E-2ECDC07BFC25 `
    -AttackSurfaceReductionRules_Actions Enabled

# Verificar estado de reglas ASR
Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Ids
Get-MpPreference | Select-Object -ExpandProperty AttackSurfaceReductionRules_Actions
```

### 3.5 Detección de Fileless Malware — Queries SIEM

#### Splunk SPL

```spl
# PowerShell con comandos ofuscados
index=windows EventCode=4104 
| search ScriptBlockText="*-enc*" OR ScriptBlockText="*-encodedcommand*" 
    OR ScriptBlockText="*downloadstring*" OR ScriptBlockText="*invoke-expression*"
    OR ScriptBlockText="*iex*" OR ScriptBlockText="*frombase64string*"
    OR ScriptBlockText="*reflection.assembly*" OR ScriptBlockText="*net.webclient*"
| stats count by host, user, ScriptBlockText, _time
| sort -count

# Inyección de procesos (CreateRemoteThread)
index=sysmon EventCode=8 
| search TargetImage="*lsass.exe" OR TargetImage="*svchost.exe" 
    OR TargetImage="*explorer.exe"
| stats count by SourceImage, TargetImage, StartFunction, host
| sort -count

# Acceso a LSASS (credential dumping)
index=sysmon EventCode=10 
| search TargetImage="*lsass.exe" 
    AND (GrantedAccess="0x1010" OR GrantedAccess="0x1410" 
    OR GrantedAccess="0x143A" OR GrantedAccess="0x100000")
| stats count by SourceImage, GrantedAccess, host
| sort -count

# Procesos LOLBin con conexiones de red
index=sysmon EventCode=3 
| search Image="*powershell.exe" OR Image="*mshta.exe" 
    OR Image="*certutil.exe" OR Image="*bitsadmin.exe"
    OR Image="*regsvr32.exe" OR Image="*rundll32.exe"
| stats count by Image, DestinationIp, DestinationPort, host
| sort -count

# Modificaciones de registro de persistencia
index=sysmon EventCode=13 
| search TargetObject="*\\CurrentVersion\\Run*" 
    OR TargetObject="*\\Winlogon\\Shell*" 
    OR TargetObject="*\\Winlogon\\Userinit*"
| stats count by Image, TargetObject, Details, host
| sort -count
```

#### CrowdStrike Falcon Query Language (FQL)

```fql
# PowerShell ejecutando desde Office
event_simpleName=ProcessRollup2 
| in(ImageFileName, ["winword.exe", "excel.exe", "powerpnt.exe"])
| in(ParentImageFileName, ["powershell.exe", "cmd.exe", "mshta.exe"])
| groupBy([ComputerName, UserName, CommandLine], function=count())

# Certutil descargando archivos
event_simpleName=ProcessRollup2 
| ImageFileName=certutil.exe
| CommandLine=*http*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# MSHTA ejecutando scripts remotos
event_simpleName=ProcessRollup2 
| ImageFileName=mshta.exe
| CommandLine=*http*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# Procesos accediendo a LSASS
event_simpleName=ProcessAccessEvent
| TargetFileName=lsass.exe
| groupBy([SourceFileName, SourceProcessId, ComputerName], function=count())

# Reflective DLL loading
event_simpleName=PeFileWrittenEvent
| IsOnDisk=false
| groupBy([ComputerName, TargetFileName, SHA256HashData], function=count())
```

### 3.6 YARA Rules para Fileless Malware

```yara
// BRIDA IT Services — YARA Rules para Fileless Malware
// Estas reglas pueden usarse con EDR para escaneo en memoria

rule Fileless_PowerShell_Empire {
    meta:
        description = "Detecta indicadores de PowerShell Empire en memoria"
        author = "BRIDA IT Services"
        mitre = "T1059.001, T1027"
    strings:
        $s1 = "Invoke-Empire" ascii
        $s2 = "System.Management.Automation.AmsiUtils" ascii
        $s3 = "amsiInitFailed" ascii
        $s4 = "Invoke-Mimikatz" ascii
        $s5 = "Invoke-ReflectivePEInjection" ascii
        $s6 = "Invoke-Shellcode" ascii
        $s7 = "Invoke-DllInjection" ascii
        $s8 = "Invoke-WMICommand" ascii
    condition:
        any of them
}

rule Fileless_Reflective_DLL {
    meta:
        description = "Detecta patrones de reflective DLL injection"
        author = "BRIDA IT Services"
        mitre = "T1055.001"
    strings:
        $mz = { 4D 5A }  // MZ header
        $reflective1 = "ReflectiveLoader" ascii
        $reflective2 = "ReflectiveDllMain" ascii
        $reflective3 = "ReflectiveCreateProcess" ascii
    condition:
        $mz at 0 and any of ($reflective*)
}

rule Fileless_CobaltStrike_Beacon {
    meta:
        description = "Detecta indicadores de Cobalt Strike Beacon"
        author = "BRIDA IT Services"
        mitre = "T1059, T1572"
    strings:
        $s1 = "beacon.dll" ascii
        $s2 = "cobaltstrike" ascii nocase
        $s3 = "ReflectiveLoader" ascii
        $pipe1 = "\\\\.\\pipe\\msagent_" ascii
        $pipe2 = "\\\\.\\pipe\\status_" ascii
        $config = { 00 01 00 01 00 02 ?? ?? 00 02 00 01 00 02 }
    condition:
        2 of them
}

rule Fileless_Process_Hollowing {
    meta:
        description = "Detecta indicadores de process hollowing"
        author = "BRIDA IT Services"
        mitre = "T1055.012"
    strings:
        $api1 = "NtUnmapViewOfSection" ascii
        $api2 = "VirtualAllocEx" ascii
        $api3 = "WriteProcessMemory" ascii
        $api4 = "SetThreadContext" ascii
        $api5 = "ResumeThread" ascii
        $api6 = "ZwUnmapViewOfSection" ascii
    condition:
        4 of them
}

rule Fileless_Encoded_Payload {
    meta:
        description = "Detecta payloads codificados en Base64 en scripts"
        author = "BRIDA IT Services"
        mitre = "T1027, T1140"
    strings:
        $b64_1 = /[A-Za-z0-9+\/]{100,}={0,2}/
        $cmd1 = "-enc" ascii
        $cmd2 = "-encodedcommand" ascii
        $cmd3 = "FromBase64String" ascii
        $cmd4 = "base64" ascii
    condition:
        $b64_1 and any of ($cmd*)
}
```

---

## 4. Análisis de LOLBins

### 4.1 ¿Qué son los LOLBins?

**LOLBins** (Living Off The Land Binaries) son binarios legítimos del sistema operativo que los atacantes aprovechan para ejecutar acciones maliciosas sin necesidad de instalar herramientas adicionales. El término fue popularizado por la [LOLBAS Project](https://lolbas-project.github.io/).

### 4.2 LOLBins Críticos — Windows

| LOLBin | Uso Legítimo | Uso Malicioso | MITRE ATT&CK | Detección |
|--------|-------------|---------------|--------------|-----------|
| **PowerShell.exe** | Administración de sistemas | Ejecución de payloads, descarga de malware, movimiento lateral | T1059.001 | Script Block Logging, AMSI, Module Logging |
| **MSHTA.exe** | Aplicaciones HTML | Ejecución de scripts VBScript/JScript maliciosos | T1218.005 | Command-line monitoring, EDR |
| **CertUtil.exe** | Gestión de certificados | Descarga de archivos, decodificación Base64 | T1140, T1105 | Command-line monitoring, network monitoring |
| **BitsAdmin.exe** | Transferencia de archivos en segundo plano | Descarga de malware, exfiltración | T1197, T1059.001 | Command-line monitoring |
| **RegSvr32.exe** | Registro de componentes COM | Ejecución de scripts maliciosos (Squiblydoo) | T1218.010 | Command-line monitoring, EDR |
| **Rundll32.exe** | Ejecución de DLLs | Ejecución de código malicioso, proxy execution | T1218.011 | Command-line monitoring, EDR |
| **CMSTP.exe** | Conexiones VPN | Ejecución de scripts INF maliciosos | T1218.003 | Command-line monitoring |
| **WScript/CScript.exe** | Scripts de Windows | Ejecución de scripts maliciosos | T1059.005, T1059.007 | Script logging, EDR |
| **MSIExec.exe** | Instalación de paquetes MSI | Instalación de malware, bypass de application control | T1218.007 | Command-line monitoring |
| **Wmic.exe** | Consultas WMI | Ejecución de código, persistencia, descubrimiento | T1047, T1059.001 | Command-line monitoring |
| **Netsh.exe** | Configuración de red | Configuración de port forwarding, firewall bypass | T1599, T1059.001 | Command-line monitoring |
| **InstallUtil.exe** | Instalación de componentes .NET | Ejecución de código .NET malicioso | T1218.004 | Command-line monitoring |
| **MSBuild.exe** | Compilación de proyectos | Ejecución de código C# malicioso embebido | T1127.001 | Command-line monitoring |
| **Forfiles.exe** | Procesamiento de archivos | Ejecución de comandos arbitrarios | T1059.001 | Command-line monitoring |
| **IEExec.exe** | Ejecución de aplicaciones .NET | Ejecución de código malicioso | T1218.001 | Command-line monitoring |

### 4.3 Análisis de LOLBins — Queries de Detección

#### CrowdStrike Falcon

```fql
# PowerShell con descarga de archivos
event_simpleName=ProcessRollup2
| ImageFileName=powershell.exe
| CommandLine=*http* OR CommandLine=*download* OR CommandLine=*Net.WebClient*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# Certutil descargando archivos
event_simpleName=ProcessRollup2
| ImageFileName=certutil.exe
| CommandLine=*urlcache* OR CommandLine=*split* OR CommandLine=*http*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# MSHTA ejecutando contenido remoto
event_simpleName=ProcessRollup2
| ImageFileName=mshta.exe
| CommandLine=*http* OR CommandLine==*.hta*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# RegSvr32 ejecutando scripts
event_simpleName=ProcessRollup2
| ImageFileName=regsvr32.exe
| CommandLine=*scrobj* OR CommandLine=*http*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# Rundll32 ejecutando desde Office
event_simpleName=ProcessRollup2
| ImageFileName=rundll32.exe
| ParentImageFileName IN (winword.exe, excel.exe, powerpnt.exe)
| groupBy([ComputerName, UserName, CommandLine], function=count())

# BitsAdmin descargando archivos
event_simpleName=ProcessRollup2
| ImageFileName=bitsadmin.exe
| CommandLine=*transfer* OR CommandLine=*addfile*
| groupBy([ComputerName, UserName, CommandLine], function=count())

# MSBuild ejecutando código embebido
event_simpleName=ProcessRollup2
| ImageFileName=msbuild.exe
| CommandLine!*.*proj* AND CommandLine!*.*sln*
| groupBy([ComputerName, UserName, CommandLine], function=count())
```

#### Splunk SPL

```spl
# LOLBins ejecutados desde aplicaciones Office
index=sysmon EventCode=1
| search (ParentImage="*\\WINWORD.EXE" OR ParentImage="*\\EXCEL.EXE" 
    OR ParentImage="*\\POWERPNT.EXE" OR ParentImage="*\\OUTLOOK.EXE")
    AND (Image="*\\powershell.exe" OR Image="*\\cmd.exe" 
    OR Image="*\\mshta.exe" OR Image="*\\certutil.exe"
    OR Image="*\\regsvr32.exe" OR Image="*\\rundll32.exe"
    OR Image="*\\wscript.exe" OR Image="*\\cscript.exe"
    OR Image="*\\msiexec.exe" OR Image="*\\msbuild.exe")
| stats count by Computer, User, ParentImage, Image, CommandLine
| sort -count

# LOLBins con argumentos sospechosos
index=sysmon EventCode=1
| search (Image="*\\powershell.exe" AND CommandLine="*-enc*")
    OR (Image="*\\certutil.exe" AND CommandLine="*-urlcache*")
    OR (Image="*\\mshta.exe" AND CommandLine="*http*")
    OR (Image="*\\regsvr32.exe" AND CommandLine="*scrobj*")
    OR (Image="*\\rundll32.exe" AND CommandLine="*http*")
    OR (Image="*\\bitsadmin.exe" AND CommandLine="*transfer*")
    OR (Image="*\\msbuild.exe" AND CommandLine="*http*")
| stats count by Computer, User, Image, CommandLine
| sort -count

# LOLBins con conexiones de red
index=sysmon EventCode=3
| search Image="*\\powershell.exe" OR Image="*\\mshta.exe" 
    OR Image="*\\certutil.exe" OR Image="*\\bitsadmin.exe"
    OR Image="*\\regsvr32.exe" OR Image="*\\rundll32.exe"
| stats count by Computer, Image, DestinationIp, DestinationPort
| sort -count
```

### 4.4 Matriz de Detección de LOLBins

```
┌──────────────────────────────────────────────────────────────────────────┐
│                    MATRIZ DE DETECCIÓN DE LOLBins                        │
│                                                                          │
│  LOLBin          │ Script │ AMSI │ EDR  │ Cmd  │ Net  │ Reg  │ Proc   │
│                  │ Block  │      │ Behav│ Line │ Mon  │ Mon  │ Tree   │
│  ────────────────┼────────┼──────┼──────┼──────┼──────┼──────┼────────│
│  PowerShell      │   ✓    │  ✓   │  ✓   │  ✓   │  ✓   │  -   │  ✓     │
│  MSHTA           │   -    │  -   │  ✓   │  ✓   │  ✓   │  -   │  ✓     │
│  CertUtil        │   -    │  -   │  ✓   │  ✓   │  ✓   │  -   │  ✓     │
│  BitsAdmin       │   -    │  -   │  ✓   │  ✓   │  ✓   │  -   │  ✓     │
│  RegSvr32        │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  Rundll32        │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  CMSTP           │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  WScript/CScript │   ✓    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  MSIExec         │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  Wmic            │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  Netsh           │   -    │  -   │  ✓   │  ✓   │  ✓   │  -   │  ✓     │
│  InstallUtil     │   -    │  ✓   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  MSBuild         │   -    │  ✓   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  Forfiles        │   -    │  -   │  ✓   │  ✓   │  -   │  -   │  ✓     │
│  IEExec          │   -    │  ✓   │  ✓   │  ✓   │  -   │  -   │  ✓     │
└──────────────────────────────────────────────────────────────────────────┘
```

### 4.5 LOLBins en Linux (LOLLinux)

| Binario | Uso Legítimo | Uso Malicioso | MITRE ATT&CK |
|---------|-------------|---------------|--------------|
| **curl/wget** | Transferencia de datos | Descarga de malware, exfiltración | T1105, T1048 |
| **bash/sh** | Shell scripting | Reverse shells, ejecución de payloads | T1059.004 |
| **python/perl/ruby** | Scripting | Ejecución de payloads, reverse shells | T1059 |
| **nc (netcat)** | Networking | Reverse shells, port scanning | T1059, T1046 |
| **socat** | Socket relay | Reverse shells, pivoting | T1059, T1572 |
| **ssh** | Acceso remoto | Tunelización, movimiento lateral | T1021.004 |
| **scp/rsync** | Transferencia de archivos | Exfiltración | T1048 |
| **dd** | Copia de datos | Manipulación de disco, anti-forense | T1561 |
| **gcc/ld** | Compilación | Compilación de exploits en tiempo real | T1620 |
| **awk/sed** | Procesamiento de texto | Manipulación de datos, evasión | T1027 |

---

## 5. Persistence Hunting

### 5.1 Técnicas de Persistencia — MITRE ATT&CK

| Técnica | ID MITRE | Descripción | Dificultad Detección |
|---------|----------|-------------|---------------------|
| **Registry Run Keys** | T1547.001 | Ejecución al inicio de sesión | Baja |
| **Startup Folder** | T1547.001 | Archivos en carpeta de inicio | Baja |
| **Scheduled Tasks** | T1053.005 | Tareas programadas | Media |
| **Windows Services** | T1543.003 | Servicios maliciosos | Media |
| **WMI Event Subscription** | T1546.003 | Suscripciones WMI | Alta |
| **COM Hijacking** | T1546.015 | Manipulación de objetos COM | Alta |
| **DLL Search Order Hijacking** | T1574.001 | Secuestro de búsqueda de DLL | Alta |
| **AppInit DLLs** | T1546.010 | DLLs cargadas por User32 | Media |
| **Winlogon Helper DLL** | T1547.004 | DLLs de Winlogon | Media |
| **BITS Jobs** | T1197 | Trabajos BITS persistentes | Alta |
| **Browser Extensions** | T1176 | Extensiones maliciosas | Media |
| **Office Add-ins** | T1137 | Add-ins de Office | Media |
| **Bootkit/Rootkit** | T1542.001 | Persistencia en boot | Muy Alta |
| **Image File Execution Options** | T1546.012 | Debugger hijacking | Alta |
| **Netsh Helper DLL** | T1546.007 | Helpers de Netsh | Alta |
| **PowerShell Profile** | T1546.013 | Perfiles de PowerShell | Media |
| **Accessibility Features** | T1546.008 | Reemplazo de utilidades de accesibilidad | Media |
| **Component Object Model Hijacking** | T1546.015 | Hijacking de COM | Alta |
| **Server Software Component** | T1505 | IIS modules, SQL Server | Alta |
| **Implantación de Certificados** | T1606.002 | Certificados fraudulentos | Alta |

### 5.2 Hunting Queries — Persistencia

#### Windows Registry Run Keys

```powershell
# Verificar todas las ubicaciones de Run Keys
$runKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run"
)

foreach ($key in $runKeys) {
    Write-Host "`n=== $key ===" -ForegroundColor Cyan
    if (Test-Path $key) {
        Get-ItemProperty $key | Select-Object -Property * -ExcludeProperty PS* | Format-List
    } else {
        Write-Host "No existe"
    }
}
```

#### Scheduled Tasks Analysis

```powershell
# Listar todas las tareas programadas con detalles
Get-ScheduledTask | Where-Object {
    $_.TaskPath -eq "\" -or $_.Author -notmatch "Microsoft|$(env:COMPUTERNAME)"
} | ForEach-Object {
    $task = $_
    $taskInfo = Get-ScheduledTaskInfo $task.TaskName -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        TaskName    = $task.TaskName
        TaskPath    = $task.TaskPath
        Author      = $task.Author
        State       = $task.State
        LastRunTime = $taskInfo.LastRunTime
        LastResult  = $taskInfo.LastTaskResult
        NextRunTime = $taskInfo.NextRunTime
        Action      = ($task.Actions | ForEach-Object { $_.Execute }) -join "; "
        Arguments   = ($task.Actions | ForEach-Object { $_.Arguments }) -join "; "
    }
} | Format-Table -AutoSize -Wrap

# Buscar tareas que ejecutan scripts o LOLBins
Get-ScheduledTask | ForEach-Object {
    $actions = $_ | Get-ScheduledTaskInfo -ErrorAction SilentlyContinue
    $taskXml = [xml]$_.Xml
    $execCommands = $taskXml.Task.Actions.Exec
    foreach ($cmd in $execCommands) {
        if ($cmd.Command -match "powershell|cmd|mshta|certutil|bitsadmin|regsvr32|rundll32|wscript|cscript|msiexec|msbuild") {
            [PSCustomObject]@{
                TaskName  = $_.TaskName
                Command   = $cmd.Command
                Arguments = $cmd.Arguments
                Author    = $_.Author
            }
        }
    }
}
```

#### WMI Persistence Detection

```powershell
# Detectar suscripciones de eventos WMI (persistencia)
Write-Host "=== WMI Event Filters ===" -ForegroundColor Cyan
Get-WmiObject -Namespace root\Subscription -Class __EventFilter | 
    Select-Object Name, Query, QueryLanguage | Format-List

Write-Host "`n=== WMI Event Consumers ===" -ForegroundColor Cyan
Get-WmiObject -Namespace root\Subscription -Class __EventConsumer | 
    Select-Object Name, @{N='Type';E={$_.__CLASS}} | Format-List

Write-Host "`n=== WMI Filter-to-Consumer Bindings ===" -ForegroundColor Cyan
Get-WmiObject -Namespace root\Subscription -Class __FilterToConsumerBinding | 
    Select-Object Filter, Consumer | Format-List

# Detectar WMI persistence con WMI Explorer o PowerShell
# Buscar CommandLineEventConsumer (ejecuta comandos)
Get-WmiObject -Namespace root\Subscription -Class CommandLineEventConsumer |
    Select-Object Name, CommandLineTemplate, ExecutablePath | Format-List

# Buscar ActiveScriptEventConsumer (ejecuta scripts)
Get-WmiObject -Namespace root\Subscription -Class ActiveScriptEventConsumer |
    Select-Object Name, ScriptingEngine, ScriptText | Format-List
```

#### Service Persistence Detection

```powershell
# Detectar servicios sospechosos
Get-WmiObject Win32_Service | Where-Object {
    # Servicios con rutas ejecutables sospechosas
    $_.PathName -match "temp|appdata|programdata|users\\[^\\]+\\documents" -or
    # Servicios sin descripción
    ([string]::IsNullOrEmpty($_.Description) -and $_.Name -notmatch "CDPSvc|CDPUserSvc") -or
    # Servicios con nombres sospechosos
    $_.Name -match "^[a-z0-9]{8,}$" -or
    # Servicios que ejecutan scripts
    $_.PathName -match "powershell|cmd|wscript|cscript|mshta|msbuild"
} | Select-Object Name, DisplayName, State, StartMode, PathName, Description |
    Format-Table -AutoSize -Wrap
```

#### COM Hijacking Detection

```powershell
# Detectar COM Hijacking
# Buscar entradas de registro que redirijan CLSIDs a DLLs maliciosas

$comPaths = @(
    "HKCU:\Software\Classes\CLSID",
    "HKCU:\Software\Classes\Wow6432Node\CLSID"
)

foreach ($path in $comPaths) {
    if (Test-Path $path) {
        Get-ChildItem $path -ErrorAction SilentlyContinue | ForEach-Object {
            $inproc = Join-Path $_.PSPath "InprocServer32"
            if (Test-Path $inproc) {
                $dllPath = (Get-ItemProperty $inproc -ErrorAction SilentlyContinue).'(default)'
                if ($dllPath -and $dllPath -match "temp|appdata|programdata|users") {
                    [PSCustomObject]@{
                        CLSID = $_.PSChildName
                        DLL   = $dllPath
                        Path  = $inproc
                    }
                }
            }
        }
    }
}
```

### 5.3 Persistence Hunting — Queries SIEM

#### Splunk SPL

```spl
# Nuevas entradas en Run Keys
index=sysmon EventCode=13 
| search TargetObject="*\\CurrentVersion\\Run*" 
    OR TargetObject="*\\CurrentVersion\\RunOnce*"
| stats count by Computer, User, TargetObject, Details, _time
| sort -_time

# Nuevas tareas programadas
index=windows EventCode=4698 
| stats count by Computer, SubjectUserName, TaskName, TaskContent
| sort -count

# Nuevos servicios instalados
index=windows EventCode=7045 
| stats count by Computer, ServiceName, ServiceFileName, ServiceType
| sort -_time

# Modificaciones de servicios existentes
index=windows EventCode=7040 
| stats count by Computer, ServiceName, StartTypeOld, StartTypeNew
| sort -count

# Modificaciones de Image File Execution Options (debugger hijacking)
index=sysmon EventCode=13 
| search TargetObject="*\\Image File Execution Options\\*" 
    AND TargetObject="*Debugger*"
| stats count by Computer, TargetObject, Details
| sort -count

# Nuevos BITS Jobs
index=windows EventCode=5156 
| search Application="*bitsadmin*" OR Application="*svchost*" 
    AND Application="*BITS*"
| stats count by Computer, Application, DestinationIp, DestinationPort
| sort -count

# Modificaciones de Winlogon
index=sysmon EventCode=13 
| search TargetObject="*\\Winlogon\\Shell*" 
    OR TargetObject="*\\Winlogon\\Userinit*"
    OR TargetObject="*\\Winlogon\\Notify*"
| stats count by Computer, TargetObject, Details
| sort -count
```

#### CrowdStrike Falcon

```fql
# Nuevas entradas de registro de persistencia
event_simpleName=RegistryValuesSetEvent
| RegistryKeyPath IN (
    "\\CurrentVersion\\Run",
    "\\CurrentVersion\\RunOnce",
    "\\Winlogon",
    "\\Image File Execution Options"
)
| groupBy([ComputerName, UserName, RegistryKeyPath, RegistryValueName, RegistryValueData], function=count())

# Nuevos servicios instalados
event_simpleName=InstalledServiceEvent
| groupBy([ComputerName, ServiceName, ServicePath, ServiceType], function=count())

# Nuevas tareas programadas
event_simpleName=ScheduledTaskRegistered
| groupBy([ComputerName, TaskName, TaskAuthor, TaskCommand], function=count())

# Modificaciones de archivos de inicio
event_simpleName=FileWrittenEvent
| FilePath IN (
    "C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\*",
    "C:\\Users\\*\\AppData\\Roaming\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\*"
)
| groupBy([ComputerName, UserName, FileName, FilePath, SHA256HashData], function=count())
```

### 5.4 Herramientas de Persistence Hunting

| Herramienta | Plataforma | Función | Uso |
|-------------|-----------|---------|-----|
| **Autoruns** (Sysinternals) | Windows | Enumera todas las ubicaciones de persistencia | Auditoría manual |
| **PowerShell** | Windows | Scripts de detección de persistencia | Automatización |
| **OSQuery** | Multi-platform | Consultas SQL sobre el sistema | Hunting continuo |
| **Velociraptor** | Multi-platform | Forense y hunting a escala | Investigación |
| **KAPE** | Windows | Colección de artefactos forenses | Respuesta a incidentes |
| **YARA** | Multi-platform | Escaneo de reglas en disco/memoria | Detección de malware |
| **Volatility** | Multi-platform | Análisis de memoria forense | Investigación profunda |
| **Chainsaw** | Windows | Análisis rápido de Event Logs | Detección de TTPs |
| **LOLBAS Project** | Windows | Catálogo de LOLBins | Referencia |
| **WMI Explorer** | Windows | Exploración de WMI | Detección de persistencia WMI |

---

## 6. Endpoint Hardening

### 6.1 Windows Hardening

#### 6.1.1 Políticas de Grupo (GPO) Esenciales

```powershell
# ============================================
# WINDOWS HARDENING — BRIDA IT Services
# ============================================

# --- 1. Política de Contraseñas ---
# Computer Configuration → Windows Settings → Security Settings → Account Policies

# Longitud mínima: 14 caracteres
net accounts /minpwlen:14

# Complejidad requerida
# GPO: Computer Configuration → Windows Settings → Security Settings → 
#      Account Policies → Password Policy → "Password must meet complexity requirements" = Enabled

# Historial de contraseñas: 24
net accounts /uniquepw:24

# Edad máxima: 90 días
net accounts /maxpwage:90

# Edad mínima: 1 día
net accounts /minpwage:1

# Bloqueo de cuenta: 5 intentos fallidos
net accounts /lockoutthreshold:5
net accounts /lockoutwindow:30
net accounts /lockoutduration:30


# --- 2. Política de Auditoría ---
# GPO: Computer Configuration → Windows Settings → Security Settings → 
#      Advanced Audit Policy Configuration

# Habilitar auditoría de logon
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logoff" /success:enable
auditpol /set /subcategory:"Account Lockout" /failure:enable
auditpol /set /subcategory:"Special Logon" /success:enable

# Auditoría de procesos
auditpol /set /subcategory:"Process Creation" /success:enable
auditpol /set /subcategory:"Process Termination" /success:enable

# Auditoría de PowerShell
auditpol /set /subcategory:"PowerShell Script Block Logging" /success:enable

# Auditoría de objetos
auditpol /set /subcategory:"File System" /success:enable /failure:enable
auditpol /set /subcategory:"Registry" /success:enable /failure:enable

# Auditoría de autenticación
auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable
auditpol /set /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable

# Auditoría de cambios de política
auditpol /set /subcategory:"Audit Policy Change" /success:enable
auditpol /set /subcategory:"Authentication Policy Change" /success:enable


# --- 3. Deshabilitar Protocolos y Servicios Innecesarios ---

# Deshabilitar SMBv1 (WannaCry, EternalBlue)
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart

# Deshabilitar LLMNR (Link-Local Multicast Name Resolution)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" `
    -Name "EnableMulticast" -Value 0 -PropertyType DWord -Force

# Deshabilitar NetBIOS sobre TCP/IP
# GPO: Computer Configuration → Administrative Templates → Network → 
#      DNS Client → "Turn off multicast name resolution" = Enabled

# Deshabilitar WPAD (Web Proxy Auto-Discovery)
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" `
    -Name "WpadOverride" -Value 1 -PropertyType DWord -Force

# Deshabilitar Remote Desktop (si no se necesita)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" `
    -Name "fDenyTSConnections" -Value 1 -Force

# Deshabilitar Remote Assistance
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance" `
    -Name "fAllowToGetHelp" -Value 0 -Force


# --- 4. Configuración de Windows Defender ---

# Habilitar protección en tiempo real
Set-MpPreference -DisableRealtimeMonitoring $false

# Habilitar protección de comportamiento
Set-MpPreference -DisableBehaviorMonitoring $false

# Habilitar protección de red
Set-MpPreference -DisableNetworkProtectionAuditMode $false

# Habilitar escaneo de scripts
Set-MpPreference -DisableScriptScanning $false

# Habilitar AMSI
Set-MpPreference -DisableAntiSpyware $false

# Configurar actualizaciones automáticas de firmas
Set-MpPreference -SignatureUpdateInterval 1  # Cada hora

# Habilitar Cloud-Delivered Protection (MAPS)
Set-MpPreference -MAPSReporting Advanced
Set-MpPreference -SubmitSamplesConsent SendAllSamples

# Habilitar protección contra ransomware (Controlled Folder Access)
Set-MpPreference -EnableControlledFolderAccess Enabled

# Habilitar Network Protection
Set-MpPreference -EnableNetworkProtection Enabled

# Habilitar PUA (Potentially Unwanted Applications) protection
Set-MpPreference -PUAProtection Enabled


# --- 5. Configuración de Firewall ---

# Habilitar firewall en todos los perfiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Bloquear conexiones entrantes por defecto
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultInboundAction Block

# Permitir conexiones salientes por defecto
Set-NetFirewallProfile -Profile Domain,Public,Private -DefaultOutboundAction Allow

# Habilitar logging
Set-NetFirewallProfile -Profile Domain,Public,Private -LogAllowed True
Set-NetFirewallProfile -Profile Domain,Public,Private -LogBlocked True
Set-NetFirewallProfile -Profile Domain,Public,Private -LogFileName "%systemroot%\system32\LogFiles\Firewall\pfirewall.log"
Set-NetFirewallProfile -Profile Domain,Public,Private -LogMaxSizeKilobytes 32767


# --- 6. Configuración de PowerShell ---

# Habilitar PowerShell Constrained Language Mode
# GPO: Computer Configuration → Administrative Templates → 
#      Windows Components → Windows PowerShell
# O via registry:
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" `
    -Name "__PSLockDownPolicy" -Value "4" -PropertyType String -Force

# Habilitar Script Block Logging (ver sección 3.4)
# Habilitar Module Logging (ver sección 3.4)
# Habilitar Transcription (ver sección 3.4)

# Deshabilitar PowerShell v2
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root -NoRestart


# --- 7. Configuración de BitLocker ---

# Habilitar BitLocker en unidades del sistema
# Requiere TPM o USB key
Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector

# Habilitar BitLocker en unidades de datos
Enable-BitLocker -MountPoint "D:" -EncryptionMethod XtsAes256 -PasswordProtector

# Backup de claves de recuperación a AD
# GPO: Computer Configuration → Administrative Templates → 
#      Windows Components → BitLocker Drive Encryption


# --- 8. Configuración de UAC (User Account Control) ---

# Habilitar UAC
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "EnableLUA" -Value 1 -Force

# Solicitar credenciales en el escritorio seguro
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "PromptOnSecureDesktop" -Value 1 -Force

# Detectar instalaciones de aplicaciones y solicitar elevación
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "EnableInstallerDetection" -Value 1 -Force

# Elevar solo ejecutables firmados y validados
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
    -Name "ValidateAdminCodeSignatures" -Value 1 -Force


# --- 9. Deshabilitar Macros en Office ---

# GPO: User Configuration → Administrative Templates → Microsoft Office → 
#      Security Settings

# Deshabilitar macros en documentos Office de Internet
# GPO: "Block macros from running in Office files from the Internet" = Enabled

# Deshabilitar VBA por completo (si no se necesita)
# GPO: "VBA Macro Notification Settings" = "Disable all macros without notification"


# --- 10. Configuración de Credential Guard ---

# Habilitar Credential Guard (protege NTLM hashes, etc.)
# Requiere Windows 10/11 Enterprise
# GPO: Computer Configuration → Administrative Templates → 
#      System → Device Guard → "Turn on Virtualization Based Security" = Enabled
# Sub-option: "Credential Guard Configuration" = Enabled with UEFI lock

# Verificar estado
Get-CimInstance -ClassName Win32_DeviceGuard `
    -Namespace root\Microsoft\Windows\DeviceGuard
```

#### 6.1.2 CIS Benchmark Checklist — Windows 10/11

| Categoría | Control | Estado Requerido |
|-----------|---------|-----------------|
| **Account Policies** | Password Policy (length ≥ 14, complexity) | Obligatorio |
| **Account Policies** | Account Lockout (≤ 5 attempts, ≥ 15 min) | Obligatorio |
| **Local Policies** | Audit Policy (logon, process, object access) | Obligatorio |
| **Local Policies** | User Rights Assignment (restrict logon rights) | Obligatorio |
| **Security Options** | Interactive logon (no display last username) | Obligatorio |
| **Security Options** | UAC (enabled, secure desktop) | Obligatorio |
| **Windows Defender** | Real-time protection enabled | Obligatorio |
| **Windows Defender** | Cloud-delivered protection enabled | Obligatorio |
| **Windows Defender** | ASR rules configured | Obligatorio |
| **Firewall** | All profiles enabled, block inbound | Obligatorio |
| **Network** | SMBv1 disabled | Obligatorio |
| **Network** | LLMNR disabled | Obligatorio |
| **Network** | WPAD disabled | Obligatorio |
| **PowerShell** | Script Block Logging enabled | Obligatorio |
| **PowerShell** | Constrained Language Mode | Recomendado |
| **BitLocker** | System drive encrypted | Obligatorio |
| **BitLocker** | Recovery keys backed up to AD | Obligatorio |
| **Office** | Macros blocked from Internet | Obligatorio |
| **Credential Guard** | Enabled (Enterprise) | Recomendado |

### 6.2 Linux Hardening

#### 6.2.1 Script de Hardening Linux

```bash
#!/bin/bash
# ============================================
# LINUX HARDENING — BRIDA IT Services
# Basado en CIS Benchmark para Ubuntu/RHEL
# ============================================

set -euo pipefail

echo "=== BRIDA IT Services — Linux Hardening Script ==="
echo "Fecha: $(date)"
echo "Hostname: $(hostname)"

# --- 1. Actualización del sistema ---
echo "[1/12] Actualizando sistema..."
if command -v apt-get &> /dev/null; then
    apt-get update && apt-get upgrade -y
    apt-get install -y unattended-upgrades apt-listchanges
elif command -v yum &> /dev/null; then
    yum update -y
    yum install -y yum-cron
fi

# --- 2. Configuración de contraseñas ---
echo "[2/12] Configurando políticas de contraseñas..."
# Instalar libpam-pwquality
if command -v apt-get &> /dev/null; then
    apt-get install -y libpam-pwquality cracklib-runtime
fi

# Configurar pwquality
cat > /etc/security/pwquality.conf << 'EOF'
minlen = 14
dcredit = -1
ucredit = -1
ocredit = -1
lcredit = -1
minclass = 4
maxrepeat = 3
maxclassrepeat = 4
retry = 3
EOF

# Configurar PAM para bloqueo de cuentas
cat > /etc/pam.d/common-auth << 'EOF'
auth required pam_tally2.so deny=5 onerr=fail unlock_time=900
auth required pam_pwquality.so retry=3
auth [success=1 default=ignore] pam_unix.so nullok
auth requisite pam_deny.so
auth required pam_permit.so
EOF

# --- 3. Configuración de SSH ---
echo "[3/12] Hardening SSH..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

cat > /etc/ssh/sshd_config.d/brida-hardening.conf << 'EOF'
# BRIDA IT Services — SSH Hardening
Protocol 2
PermitRootLogin no
MaxAuthTries 4
PasswordAuthentication no
PubkeyAuthentication yes
PermitEmptyPasswords no
X11Forwarding no
AllowTcpForwarding no
AllowAgentForwarding no
ClientAliveInterval 300
ClientAliveCountMax 2
LoginGraceTime 60
MaxSessions 4
Banner /etc/ssh/banner
UsePAM yes
HostKeyAlgorithms ssh-ed25519,rsa-sha2-512,rsa-sha2-256
KexAlgorithms curve25519-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
EOF

# Banner SSH
cat > /etc/ssh/banner << 'EOF'
***************************************************************************
*                        BRIDA IT SERVICES                                 *
*  Acceso autorizado únicamente. Todas las actividades son monitoreadas.   *
*  Unauthorized access is prohibited. All activities are logged.           *
***************************************************************************
EOF

systemctl restart sshd

# --- 4. Configuración de Firewall (iptables/nftables) ---
echo "[4/12] Configurando firewall..."
if command -v ufw &> /dev/null; then
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw enable
elif command -v firewall-cmd &> /dev/null; then
    firewall-cmd --set-default-zone=drop
    firewall-cmd --zone=drop --add-service=ssh --permanent
    firewall-cmd --reload
fi

# --- 5. Deshabilitar servicios innecesarios ---
echo "[5/12] Deshabilitando servicios innecesarios..."
SERVICES_TO_DISABLE=(
    "avahi-daemon"
    "cups"
    "isc-dhcp-server"
    "slapd"
    "nfs-server"
    "rpcbind"
    "bind9"
    "vsftpd"
    "apache2"
    "dovecot"
    "smbd"
    "squid"
    "snmpd"
    "telnet"
    "rsh"
    "rlogin"
    "rexec"
    "tftp"
    "xinetd"
)

for service in "${SERVICES_TO_DISABLE[@]}"; do
    systemctl disable "$service" 2>/dev/null || true
    systemctl stop "$service" 2>/dev/null || true
done

# --- 6. Configuración de kernel parameters (sysctl) ---
echo "[6/12] Configurando parámetros de kernel..."
cat > /etc/sysctl.d/99-brida-hardening.conf << 'EOF'
# BRIDA IT Services — Kernel Hardening

# Deshabilitar IP forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Protección contra SYN flood
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.tcp_synack_retries = 2

# Deshabilitar source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0

# Deshabilitar ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

# Habilitar reverse path filtering
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Loguear paquetes sospechosos
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# Deshabilitar IPv6 si no se necesita
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1

# Protección de memoria
kernel.randomize_va_space = 2
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.yama.ptrace_scope = 2

# Deshabilitar core dumps
fs.suid_dumpable = 0

# Protección de symlinks y hardlinks
fs.protected_symlinks = 1
fs.protected_hardlinks = 1
EOF

sysctl --system

# --- 7. Configuración de auditoría (auditd) ---
echo "[7/12] Configurando auditoría..."
if command -v auditctl &> /dev/null; then
    apt-get install -y auditd audispd-plugins 2>/dev/null || yum install -y audit audispd-plugins 2>/dev/null || true
    
    cat > /etc/audit/rules.d/brida-hardening.rules << 'EOF'
# BRIDA IT Services — Audit Rules

# Eliminar reglas existentes
-D

# Configurar buffer
-b 8192

# Fallo en modo de auditoría (0=silencioso, 1=printk, 2=panic)
-f 1

# Monitorear archivos de autenticación
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/security/opasswd -p wa -k identity

# Monitorear configuración SSH
-w /etc/ssh/sshd_config -p wa -k sshd_config

# Monitorear sudoers
-w /etc/sudoers -p wa -k sudoers
-w /etc/sudoers.d/ -p wa -k sudoers

# Monitorear módulos del kernel
-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules

# Monitorear cambios de hora
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
-w /etc/localtime -p wa -k time-change

# Monitorear logins
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock/ -p wa -k logins

# Monitorear cambios de red
-w /etc/hosts -p wa -k network
-w /etc/sysconfig/network -p wa -k network
-w /etc/sysconfig/network-scripts/ -p wa -k network

# Monitorear ejecución de privilegios
-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k privilege_escalation
-a always,exit -F arch=b64 -S execve -F a0&0100 -F exe=/usr/bin/sudo -k sudo_execution

# Monitorear montaje de dispositivos
-w /sbin/mount -p x -k mount
-w /sbin/umount -p x -k mount

# Hacer la configuración inmutable (requiere reinicio para cambiar)
-e 2
EOF

    systemctl enable auditd
    systemctl restart auditd
fi

# --- 8. Configuración de permisos de archivos ---
echo "[8/12] Configurando permisos de archivos..."
chmod 644 /etc/passwd
chmod 640 /etc/shadow
chmod 644 /etc/group
chmod 640 /etc/gshadow
chmod 600 /etc/ssh/sshd_config
chmod 700 /root
chmod 750 /etc/sudoers.d

# --- 9. Configuración de logrotate y logging ---
echo "[9/12] Configurando logging..."
cat > /etc/logrotate.d/brida-security << 'EOF'
/var/log/brida-security.log {
    daily
    rotate 90
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root adm
}
EOF

# --- 10. Configuración de fail2ban ---
echo "[10/12] Instalando fail2ban..."
if command -v apt-get &> /dev/null; then
    apt-get install -y fail2ban
elif command -v yum &> /dev/null; then
    yum install -y fail2ban
fi

cat > /etc/fail2ban/jail.local << 'EOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5
banaction = ufw

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 4
bantime = 7200

[sshd-ddos]
enabled = true
port = ssh
filter = sshd-ddos
logpath = /var/log/auth.log
maxretry = 10
EOF

systemctl enable fail2ban
systemctl start fail2ban

# --- 11. Deshabilitar USB storage ---
echo "[11/12] Deshabilitando USB storage..."
echo "install usb-storage /bin/true" > /etc/modprobe.d/brida-disable-usb.conf

# --- 12. Verificación final ---
echo "[12/12] Verificación final..."
echo "=== Resumen de Hardening ==="
echo "SSH Root Login: $(grep -i 'PermitRootLogin' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null | grep -v '#')"
echo "Password Auth: $(grep -i 'PasswordAuthentication' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null | grep -v '#')"
echo "Firewall: $(ufw status 2>/dev/null || firewall-cmd --state 2>/dev/null || echo 'N/A')"
echo "Auditd: $(systemctl is-active auditd 2>/dev/null || echo 'inactive')"
echo "Fail2ban: $(systemctl is-active fail2ban 2>/dev/null || echo 'inactive')"
echo ""
echo "=== Hardening completado ==="
echo "Fecha: $(date)"
echo "Hostname: $(hostname)"
```

### 6.3 macOS Hardening

```bash
#!/bin/bash
# ============================================
# macOS HARDENING — BRIDA IT Services
# ============================================

echo "=== BRIDA IT Services — macOS Hardening ==="

# --- 1. Habilitar FileVault (cifrado de disco) ---
echo "[1/8] Habilitando FileVault..."
sudo fdesetup enable

# --- 2. Habilitar Firewall ---
echo "[2/8] Habilitando Firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setblockall on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# --- 3. Configurar Gatekeeper ---
echo "[3/8] Configurando Gatekeeper..."
sudo spctl --master-enable
sudo spctl --enable --label "Developer ID"

# --- 4. Deshabilitar servicios innecesarios ---
echo "[4/8] Deshabilitando servicios innecesarios..."
# Deshabilitar AirDrop
sudo defaults write /Library/Preferences/com.apple.NetworkBrowser DisableAirDrop -bool YES

# Deshabilitar compartir archivos
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist 2>/dev/null || true
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist 2>/dev/null || true

# Deshabilitar Remote Login (SSH) si no se necesita
sudo systemsetup -setremotelogin off 2>/dev/null || true

# Deshabilitar Remote Management
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
    -deactivate -stop 2>/dev/null || true

# --- 5. Configurar FileVault y contraseña ---
echo "[5/8] Configurando políticas de contraseña..."
# Longitud mínima 14 caracteres
pwpolicy -setglobalpolicy "minChars=14 requiresAlpha=1 requiresNumeric=1 requiresSymbol=1 maxFailedLoginAttempts=5"

# --- 6. Configurar logging ---
echo "[6/8] Configurando logging..."
# Habilitar auditoría
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist 2>/dev/null || true

# Configurar retention de logs
sudo perl -pi -e 's|./etc/security/audit_control|./etc/security/audit_control|' /etc/security/audit_control

# --- 7. Configurar actualizaciones automáticas ---
echo "[7/8] Configurando actualizaciones automáticas..."
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# --- 8. Verificación ---
echo "[8/8] Verificación..."
echo "FileVault: $(fdesetup status)"
echo "Firewall: $(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate)"
echo "Gatekeeper: $(spctl --status)"
echo "SIP: $(csrutil status)"
echo "FileVault Recovery Key: $(fdesetup list)"
```

---

## 7. Mapeo MITRE ATT&CK

### 7.1 Técnicas Cubiertas por este Skill

| Táctica MITRE | Técnica | ID | Sección del Skill |
|---------------|---------|-----|-------------------|
| **Initial Access** | Phishing: Spearphishing Attachment | T1566.001 | Sección 3 (Fileless Malware) |
| **Execution** | PowerShell | T1059.001 | Secciones 3, 4 |
| **Execution** | Windows Management Instrumentation | T1047 | Secciones 3, 5 |
| **Execution** | Command and Scripting Interpreter | T1059 | Secciones 3, 4 |
| **Execution** | Inter-Process Communication: Component Object Model | T1559.001 | Sección 5 |
| **Persistence** | Boot or Logon Autostart Execution: Registry Run Keys | T1547.001 | Sección 5 |
| **Persistence** | Boot or Logon Autostart Execution: Winlogon Helper DLL | T1547.004 | Sección 5 |
| **Persistence** | Event Triggered Execution: WMI Event Subscription | T1546.003 | Sección 5 |
| **Persistence** | Event Triggered Execution: Component Object Model Hijacking | T1546.015 | Sección 5 |
| **Persistence** | Scheduled Task/Job | T1053.005 | Sección 5 |
| **Persistence** | Server Software Component | T1505 | Sección 5 |
| **Persistence** |BITS Jobs | T1197 | Sección 5 |
| **Privilege Escalation** | Process Injection | T1055 | Sección 3 |
| **Privilege Escalation** | Valid Accounts | T1078 | Sección 6 |
| **Defense Evasion** | Obfuscated Files or Information | T1027 | Secciones 3, 4 |
| **Defense Evasion** | Masquerading | T1036 | Sección 4 |
| **Defense Evasion** | Signed Binary Proxy Execution | T1218 | Sección 4 |
| **Defense Evasion** | Template Injection | T1221 | Sección 3 |
| **Defense Evasion** | Virtualization/Sandbox Evasion | T1497 | Sección 2 |
| **Credential Access** | OS Credential Dumping: LSASS Memory | T1003.001 | Secciones 3, 5 |
| **Credential Access** | OS Credential Dumping: Security Account Manager | T1003.002 | Sección 5 |
| **Discovery** | System Information Discovery | T1082 | Sección 5 |
| **Discovery** | Network Service Scanning | T1046 | Sección 6 |
| **Lateral Movement** | Remote Services: SMB/Windows Admin Shares | T1021.002 | Sección 6 |
| **Lateral Movement** | Lateral Tool Transfer | T1570 | Sección 6 |
| **Collection** | Data from Local System | T1005 | Sección 6 |
| **Command and Control** | Application Layer Protocol | T1071 | Secciones 2, 3 |
| **Command and Control** | Encrypted Channel | T1573 | Sección 2 |
| **Command and Control** | Proxy: Multi-hop Proxy | T1090.003 | Sección 2 |
| **Impact** | Data Encrypted for Impact (Ransomware) | T1486 | Sección 2 |
| **Impact** | Service Stop | T1489 | Sección 5 |
| **Impact** | Inhibit System Recovery | T1490 | Sección 2 |

### 7.2 Mapeo de Detecciones EDR a MITRE ATT&CK

| Detección | CrowdStrike | Trellix | MITRE ATT&CK |
|-----------|-------------|---------|--------------|
| PowerShell malicioso | ML-based detection + IOA | HIPS + Script Control | T1059.001 |
| Process Hollowing | IOA: Suspicious Process Hollowing | Exploit Prevention | T1055.012 |
| Credential Dumping (LSASS) | IOA: Credential Dumping | HIPS: Credential Access | T1003.001 |
| Registry Run Key Persistence | IOA: Persistence via Run Key | HIPS: Registry Monitoring | T1547.001 |
| WMI Persistence | IOA: WMI Persistence | HIPS: WMI Monitoring | T1546.003 |
| Scheduled Task Persistence | IOA: Scheduled Task | HIPS: Task Monitoring | T1053.005 |
| Ransomware Behavior | IOA: Ransomware | Behavior Monitoring | T1486 |
| C2 Communication | Network IOA + Threat Graph | Network Threat Prevention | T1071 |
| LOLBin Execution | IOA: Suspicious LOLBin | HIPS: Script Control | T1218 |
| Fileless Malware | Memory Scanning + IOA | Exploit Prevention | T1055, T1620 |

---

## 8. Mapeo NIST CSF

### 8.1 Mapeo de Funciones NIST CSF

| Función NIST CSF | Categoría | Contenido del Skill | Sección |
|-----------------|-----------|-------------------|---------|
| **IDENTIFY (ID)** | Asset Management (ID.AM) | Inventario de endpoints, clasificación por criticidad | Sección 1.2 |
| **IDENTIFY (ID)** | Risk Assessment (ID.RA) | Evaluación de vulnerabilidades con Falcon Spotlight / Trellix | Sección 2.1.5, 2.2.5 |
| **IDENTIFY (ID)** | Improvement (ID.IM) | Métricas y KPIs de seguridad de endpoints | Sección 11 |
| **PROTECT (PR)** | Access Control (PR.AC) | Hardening de autenticación, políticas de contraseñas, UAC | Sección 6 |
| **PROTECT (PR)** | Awareness and Training (PR.AT) | Capacitación sobre amenazas de fileless malware y LOLBins | Secciones 3, 4 |
| **PROTECT (PR)** | Data Security (PR.DS) | BitLocker, FileVault, cifrado de disco | Sección 6 |
| **PROTECT (PR)** | Information Protection Processes (PR.IP) | Hardening de configuración, CIS Benchmarks | Sección 6 |
| **PROTECT (PR)** | Maintenance (PR.MA) | Patch management, actualizaciones de firmas EDR | Sección 2 |
| **PROTECT (PR)** | Protective Technology (PR.PT) | EDR deployment, ASR rules, firewall, application control | Secciones 2, 3, 6 |
| **DETECT (DE)** | Anomalies and Events (DE.AE) | Detección de anomalías con EDR, SIEM correlation | Secciones 2, 3, 4 |
| **DETECT (DE)** | Security Continuous Monitoring (DE.CM) | Monitoreo continuo con EDR, Sysmon, PowerShell logging | Secciones 2, 3, 4 |
| **DETECT (DE)** | Detection Processes (DE.DP) | Queries de detección, YARA rules, hunting hypotheses | Secciones 3, 4, 5 |
| **RESPOND (RS)** | Response Planning (RS.RP) | Playbooks de respuesta a incidentes | Sección 10 |
| **RESPOND (RS)** | Communications (RS.CO) | Flujos de escalamiento, notificación | Sección 10 |
| **RESPOND (RS)** | Analysis (RS.AN) | Análisis forense, memory dump, timeline analysis | Secciones 3, 5 |
| **RESPOND (RS)** | Mitigation (RS.MI) | Contención de hosts, aislamiento, remediación | Sección 10 |
| **RECOVER (RC)** | Recovery Planning (RC.RP) | Plan de recuperación post-incidente | Sección 10 |
| **RECOVER (RC)** | Improvements (RC.IM) | Lecciones aprendidas, mejora continua | Sección 11 |

### 8.2 Mapeo Detallado — NIST CSF Subcategorías

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    NIST CSF — MAPEO DETALLADO                           │
│                                                                          │
│  ID.AM-1: Physical devices and systems inventoried                      │
│    → Sección 1.2: Inventario de Endpoints                              │
│                                                                          │
│  ID.RA-1: Vulnerabilities identified and documented                     │
│    → Sección 2.1.5: Falcon Spotlight Vulnerability Management          │
│    → Sección 2.2.5: Trellix EDR Queries                                │
│                                                                          │
│  PR.AC-1: Identities and credentials are managed                       │
│    → Sección 6.1.1: Políticas de contraseñas, UAC, Credential Guard    │
│                                                                          │
│  PR.AC-4: Access permissions and authorizations are managed             │
│    → Sección 6.1.1: User Rights Assignment, SSH hardening              │
│                                                                          │
│  PR.DS-1: Data-at-rest is protected                                    │
│    → Sección 6.1.1: BitLocker, FileVault                               │
│                                                                          │
│  PR.IP-1: Baseline configuration is established                        │
│    → Sección 6: Endpoint Hardening (CIS Benchmarks)                    │
│                                                                          │
│  PR.PT-1: Audit/log records are determined, documented, implemented    │
│    → Sección 3.4: PowerShell Logging, Sysmon, auditd                   │
│                                                                          │
│  PR.PT-3: Least functionality is enforced                              │
│    → Sección 6: Deshabilitar servicios innecesarios                    │
│                                                                          │
│  DE.AE-2: Detected events are analyzed to understand attacks            │
│    → Secciones 3, 4: Análisis de fileless malware y LOLBins            │
│                                                                          │
│  DE.CM-1: Networks and hosts are monitored                             │
│    → Sección 2: EDR deployment y monitoreo continuo                    │
│                                                                          │
│  DE.CM-3: Personnel activity is monitored                              │
│    → Sección 3.4: PowerShell logging, command-line monitoring          │
│                                                                          │
│  DE.CM-7: Monitoring for unauthorized code                             │
│    → Sección 3: Fileless malware detection                             │
│    → Sección 4: LOLBin analysis                                        │
│                                                                          │
│  DE.DP-1: Roles and responsibilities for detection are defined         │
│    → Sección 10: Playbooks de respuesta                                │
│                                                                          │
│  DE.DP-4: Event detection information is communicated                  │
│    → Sección 2: SIEM integration (Falcon FDR, Trellix DXL)            │
│                                                                          │
│  RS.RP-1: Response plan is executed during/after an incident           │
│    → Sección 10: Playbooks de respuesta                                │
│                                                                          │
│  RS.MI-1: Incidents are contained                                      │
│    → Sección 2.1.6: Falcon RTR host isolation                         │
│    → Sección 10: Playbook de contención                                │
│                                                                          │
│  RS.MI-2: Incidents are mitigated                                      │
│    → Sección 10: Playbook de remediación                               │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 9. Mapeo D3FEND

### 9.1 Técnicas D3FEND Cubiertas

| Técnica D3FEND | ID | Descripción | Sección del Skill |
|----------------|-----|-------------|-------------------|
| **Platform Monitoring** | D3-PM | Monitoreo de plataforma mediante agentes EDR | Sección 2 |
| **Process Analysis** | D3-PAN | Análisis de procesos en ejecución | Secciones 2, 3 |
| **File Analysis** | D3-FA | Análisis de archivos (hash, signature) | Sección 2 |
| **Network Traffic Analysis** | D3-NTA | Análisis de tráfico de red | Secciones 2, 3 |
| **Authentication Event Thresholding** | D3-AET | Umbrales de eventos de autenticación | Sección 6 |
| **Credential Compromise Scope Assessment** | D3-CCSA | Evaluación de alcance de compromiso de credenciales | Sección 5 |
| **Process Isolation** | D3-PI | Aislamiento de procesos/host | Sección 2.1.6 |
| **Executable Blacklisting** | D3-EBL | Lista negra de ejecutables | Sección 2 |
| **Executable Whitelisting** | D3-EWL | Lista blanca de ejecutables (AppLocker/WDAC) | Sección 6 |
| **File Content Rules** | D3-FCR | Reglas de contenido de archivos (YARA) | Sección 3.6 |
| **File Integrity Monitoring** | D3-FIM | Monitoreo de integridad de archivos | Sección 6 |
| **Identifier Analysis** | D3-IA | Análisis de identificadores (IOCs) | Sección 2 |
| **Platform Hardening** | D3-PH | Hardening de plataforma | Sección 6 |
| **Software Update** | D3-SU | Actualización de software | Sección 2 |
| **User Behavior Analysis** | D3-UBA | Análisis de comportamiento de usuario | Sección 2 |
| **Configuration Baselines** | D3-CB | Líneas base de configuración | Sección 6 |
| **Command Execution Logging** | D3-CEL | Logging de ejecución de comandos | Sección 3.4 |
| **Process Spawn Analysis** | D3-PSA | Análisis de creación de procesos | Secciones 3, 4 |
| **Memory Boundary Tracking** | D3-MBT | Seguimiento de límites de memoria | Sección 3 |
| **Message Hardening** | D3-MH | Hardening de mensajes (email) | Sección 6 |
| **Network Session Filtering** | D3-NSF | Filtrado de sesiones de red | Sección 6 |
| **Peripheral Firmware Verification** | D3-PFV | Verificación de firmware periférico | Sección 6 |
| **Process Eviction** | D3-PE | Evicción de procesos maliciosos | Sección 2 |
| **Restore Software** | D3-RS | Restauración de software | Sección 10 |
| **System Configuration Permissions** | D3-SCP | Permisos de configuración del sistema | Sección 6 |
| **System File Analysis** | D3-SFA | Análisis de archivos del sistema | Sección 5 |
| **System Init Config Analysis** | D3-SICA | Análisis de configuración de inicio | Sección 5 |
| **System Service Permissions** | D3-SSP | Permisos de servicios del sistema | Sección 5 |

### 9.2 Mapeo D3FEND — Modelo de Defensa

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    D3FEND — MODELO DE DEFENSA                           │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                    HARDEN (Fortalecer)                            │   │
│  │  • Platform Hardening (D3-PH) → Sección 6                        │   │
│  │  • Configuration Baselines (D3-CB) → Sección 6                   │   │
│  │  • Executable Whitelisting (D3-EWL) → Sección 6                  │   │
│  │  • System Configuration Permissions (D3-SCP) → Sección 6         │   │
│  │  • Software Update (D3-SU) → Sección 2                           │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                    DETECT (Detectar)                              │   │
│  │  • Platform Monitoring (D3-PM) → Sección 2                       │   │
│  │  • Process Analysis (D3-PAN) → Secciones 2, 3                    │   │
│  │  • Process Spawn Analysis (D3-PSA) → Secciones 3, 4              │   │
│  │  • Command Execution Logging (D3-CEL) → Sección 3.4              │   │
│  │  • File Content Rules (D3-FCR) → Sección 3.6                     │   │
│  │  • User Behavior Analysis (D3-UBA) → Sección 2                   │   │
│  │  • Network Traffic Analysis (D3-NTA) → Secciones 2, 3            │   │
│  │  • Memory Boundary Tracking (D3-MBT) → Sección 3                 │   │
│  │  • Identifier Analysis (D3-IA) → Sección 2                       │   │
│  │  • System Init Config Analysis (D3-SICA) → Sección 5             │   │
│  │  • System Service Permissions (D3-SSP) → Sección 5               │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                    ISOLATE (Aislar)                               │   │
│  │  • Process Isolation (D3-PI) → Sección 2.1.6                      │   │
│  │  • Process Eviction (D3-PE) → Sección 2                           │   │
│  │  • Network Session Filtering (D3-NSF) → Sección 6                 │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                    DECEIVE (Engañar)                              │   │
│  │  • (No aplica directamente a endpoints)                          │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                    EVICTE (Evacuar/Restaurar)                     │   │
│  │  • Restore Software (D3-RS) → Sección 10                          │   │
│  │  • Credential Compromise Scope Assessment (D3-CCSA) → Sección 5   │   │
│  └──────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 10. Playbooks de Respuesta

### 10.1 Playbook: Detección de Fileless Malware

```yaml
playbook:
  name: "BRIDA-Fileless-Malware-Response"
  version: 1.0
  severity: CRITICAL
  
  triggers:
    - "EDR alert: Fileless malware detected"
    - "SIEM: PowerShell with encoded commands"
    - "SIEM: LOLBin with network connection"
    - "Memory scan: Suspicious code injection"
  
  phases:
    phase_1_triage:
      duration: "15 minutos"
      actions:
        - "Confirmar alerta: revisar detección en consola EDR"
        - "Identificar host afectado: hostname, IP, usuario"
        - "Determinar scope: ¿un host o múltiples?"
        - "Clasificar severidad: CRITICAL si hay C2 o movimiento lateral"
        - "Notificar: SOC L2/L3, CISO si es CRITICAL"
    
    phase_2_containment:
      duration: "30 minutos"
      actions:
        - "Aislar host de red (EDR network isolation)"
        - "Bloquear IOCs en firewall/proxy (IPs, dominios, hashes)"
        - "Deshabilitar cuenta de usuario comprometida (si aplica)"
        - "Preservar evidencia: memory dump, EDR telemetry"
        - "Capturar snapshot de logs relevantes (últimas 24h)"
    
    phase_3_investigation:
      duration: "4 horas"
      actions:
        - "Analizar proceso árbol completo en EDR"
        - "Revisar PowerShell logs (Script Block, Module, Transcription)"
        - "Analizar conexiones de red del host"
        - "Buscar persistencia: Run Keys, Scheduled Tasks, WMI, Services"
        - "Verificar acceso a LSASS (credential dumping)"
        - "Buscar movimiento lateral desde el host"
        - "Analizar memoria con Volatility/YARA"
        - "Correlar con threat intelligence (IOCs)"
    
    phase_4_eradication:
      duration: "2 horas"
      actions:
        - "Eliminar artefactos maliciosos identificados"
        - "Remover mecanismos de persistencia"
        - "Restaurar archivos modificados desde backup (si aplica)"
        - "Rotar credenciales potencialmente comprometidas"
        - "Aplicar parches de vulnerabilidades explotadas"
        - "Actualizar firmas EDR y reglas de detección"
    
    phase_5_recovery:
      duration: "1 hora"
      actions:
        - "Reconectar host a red (verificar limpieza completa)"
        - "Monitoreo intensivo 72 horas post-recovery"
        - "Verificar integridad de datos"
        - "Confirmar operación normal del host"
    
    phase_6_lessons_learned:
      duration: "1 semana"
      actions:
        - "Documentar incidente en sistema de ticketing"
        - "Actualizar reglas de detección basadas en hallazgos"
        - "Compartir IOCs con equipo de threat intelligence"
        - "Realizar post-mortem con stakeholders"
        - "Actualizar playbook si es necesario"
```

### 10.2 Playbook: Persistencia Detectada

```yaml
playbook:
  name: "BRIDA-Persistence-Hunting-Response"
  version: 1.0
  severity: HIGH
  
  triggers:
    - "Hunting: Nueva entrada en Run Keys"
    - "Hunting: Nuevo servicio sospechoso"
    - "Hunting: WMI event subscription detectada"
    - "Hunting: Scheduled task sospechosa"
    - "Hunting: COM hijacking detectado"
  
  phases:
    phase_1_validation:
      duration: "30 minutos"
      actions:
        - "Verificar si la persistencia es legítima (software conocido)"
        - "Comparar contra baseline de persistencia del host"
        - "Verificar firma digital del ejecutable"
        - "Buscar el hash en VirusTotal y threat intelligence"
        - "Determinar si es parte de un ataque más amplio"
    
    phase_2_analysis:
      duration: "2 horas"
      actions:
        - "Analizar el mecanismo de persistencia en detalle"
        - "Rastrear el proceso que creó la persistencia"
        - "Buscar otros indicadores de compromiso relacionados"
        - "Analizar el payload/ejecutable asociado"
        - "Determinar vector de infección inicial"
    
    phase_3_remediation:
      duration: "1 hora"
      actions:
        - "Eliminar mecanismo de persistencia"
        - "Eliminar payload malicioso"
        - "Restaurar configuración original del sistema"
        - "Bloquear IOCs relacionados"
        - "Verificar que no existan mecanismos adicionales"
```

### 10.3 Playbook: Ransomware en Endpoint

```yaml
playbook:
  name: "BRIDA-Ransomware-Endpoint-Response"
  version: 1.0
  severity: CRITICAL
  
  triggers:
    - "EDR: Ransomware behavior detected"
    - "SIEM: Mass file extension change"
    - "SIEM: Shadow copy deletion detected"
    - "User report: Ransom note displayed"
  
  phases:
    phase_1_immediate:
      duration: "5 minutos"
      actions:
        - "AISLAR HOST INMEDIATAMENTE (EDR network isolation)"
        - "NO apagar el host (preservar evidencia en memoria)"
        - "Notificar SOC L3, CISO, y gerencia"
        - "Iniciar bridge de crisis"
        - "Documentar hora de detección"
    
    phase_2_assessment:
      duration: "30 minutos"
      actions:
        - "Identificar variante de ransomware (si es posible)"
        - "Determinar scope: ¿cuántos hosts afectados?"
        - "Verificar estado de backups"
        - "Identificar datos potencialmente comprometidos"
        - "Evaluar necesidad de notificación regulatoria (LFPDPPP)"
    
    phase_3_containment:
      duration: "1 hora"
      actions:
        - "Aislar segmentos de red afectados"
        - "Bloquear IOCs de ransomware en toda la infraestructura"
        - "Deshabilitar compartidos de red (SMB)"
        - "Forzar cambio de credenciales de administrador"
        - "Bloquear comunicación C2"
    
    phase_4_eradication_recovery:
      duration: "24-72 horas"
      actions:
        - "NO pagar rescate (recomendación BRIDA)"
        - "Formatear y reconstruir hosts afectados"
        - "Restaurar desde backups limpios"
        - "Verificar integridad de datos restaurados"
        - "Aplicar hardening adicional"
        - "Monitoreo intensivo post-recovery"
```

---

## 11. Métricas y KPIs

### 11.1 Métricas de Seguridad de Endpoints

| Métrica | Descripción | Frecuencia | Meta |
|---------|-------------|-----------|------|
| **EDR Coverage** | % de endpoints con agente EDR activo | Diario | ≥ 98% |
| **EDR Health** | % de agentes reportando correctamente | Diario | ≥ 95% |
| **Mean Time to Detect (MTTD)** | Tiempo promedio de detección de amenazas | Semanal | ≤ 1 hora |
| **Mean Time to Respond (MTTR)** | Tiempo promedio de respuesta a incidentes | Semanal | ≤ 4 horas |
| **Mean Time to Contain (MTTC)** | Tiempo promedio de contención | Semanal | ≤ 30 minutos |
| **False Positive Rate** | % de alertas que son falsos positivos | Semanal | ≤ 15% |
| **Patch Compliance** | % de endpoints con parches al día | Mensual | ≥ 95% |
| **Vulnerability Remediation Time** | Tiempo promedio de remediación de vulnerabilidades | Mensual | ≤ 30 días (críticas: ≤ 7 días) |
| **Hardening Compliance** | % de endpoints que cumplen CIS Benchmark | Mensual | ≥ 90% |
| **Fileless Malware Detections** | Número de detecciones de fileless malware | Mensual | Tendencia decreciente |
| **LOLBin Alerts** | Número de alertas de LOLBins | Mensual | Tendencia decreciente |
| **Persistence Findings** | Número de mecanismos de persistencia encontrados en hunting | Mensual | Tendencia decreciente |
| **Ransomware Attempts** | Número de intentos de ransomware detectados | Mensual | Tendencia decreciente |
| **Endpoint Isolations** | Número de hosts aislados por EDR | Mensual | Tendencia estable/decreciente |
| **Credential Dumping Attempts** | Intentos de volcado de credenciales detectados | Mensual | Tendencia decreciente |

### 11.2 Dashboard de Métricas

```
┌─────────────────────────────────────────────────────────────────────────┐
│              DASHBOARD — SEGURIDAD DE ENDPOINTS BRIDA                   │
│                                                                          │
│  ┌─────────────────────┐  ┌─────────────────────┐  ┌────────────────┐  │
│  │  EDR Coverage       │  │  EDR Health         │  │  Patch         │  │
│  │  ████████████░ 97%  │  │  ████████████░ 96%  │  │  Compliance    │  │
│  │  Meta: ≥ 98%        │  │  Meta: ≥ 95%        │  │  █████████░░ 92%│  │
│  │  ⚠ Cerca de meta    │  │  ✅ En meta         │  │  Meta: ≥ 95%   │  │
│  └─────────────────────┘  └─────────────────────┘  └────────────────┘  │
│                                                                          │
│  ┌─────────────────────┐  ┌─────────────────────┐  ┌────────────────┐  │
│  │  MTTD               │  │  MTTR               │  │  False Positive│  │
│  │  45 minutos         │  │  3.2 horas          │  │  Rate          │  │
│  │  Meta: ≤ 60 min     │  │  Meta: ≤ 4 horas    │  │  12%           │  │
│  │  ✅ En meta         │  │  ✅ En meta         │  │  Meta: ≤ 15%   │  │
│  └─────────────────────┘  └─────────────────────┘  └────────────────┘  │
│                                                                          │
│  ┌─────────────────────┐  ┌─────────────────────┐  ┌────────────────┐  │
│  │  Fileless Malware   │  │  LOLBin Alerts      │  │  Persistence   │  │
│  │  Detections: 3      │  │  15                 │  │  Findings: 2   │  │
│  │  ↓ 40% vs mes ant.  │  │  ↓ 25% vs mes ant.  │  │  ↓ 60% vs ant. │  │
│  └─────────────────────┘  └─────────────────────┘  └────────────────┘  │
│                                                                          │
│  ┌─────────────────────┐  ┌─────────────────────┐  ┌────────────────┐  │
│  │  Ransomware         │  │  Credential         │  │  Hardening     │  │
│  │  Attempts: 1        │  │  Dumping: 0         │  │  Compliance    │  │
│  │  ✅ Bloqueado       │  │  ✅ Sin incidentes  │  │  █████████░░ 91%│  │
│  └─────────────────────┘  └─────────────────────┘  └────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 12. Herramientas Recomendadas

### 12.1 EDR / XDR

| Herramienta | Tipo | Plataforma | Caso de Uso | Rango Precio (MXN/año) |
|------------|------|-----------|-------------|----------------------|
| **CrowdStrike Falcon** | EDR/XDR | Win/Linux/macOS | Protección avanzada, MDR | $200K–$800K |
| **Trellix Endpoint Security** | EDR | Win/Linux/macOS | Entornos Windows-heavy | $150K–$600K |
| **Microsoft Defender for Endpoint** | EDR | Win/Linux/macOS | Entornos Microsoft | $100K–$400K |
| **SentinelOne Singularity** | EDR/XDR | Win/Linux/macOS | Automatización de respuesta | $180K–$700K |
| **Carbon Black (VMware)** | EDR | Win/Linux/macOS | Threat hunting avanzado | $200K–$750K |

### 12.2 Hardening y Compliance

| Herramienta | Tipo | Plataforma | Función |
|------------|------|-----------|---------|
| **CIS-CAT Pro** | Assessment | Multi | Evaluación CIS Benchmark |
| **Microsoft Secure Score** | Assessment | Windows | Puntuación de seguridad |
| **Lynis** | Audit | Linux | Auditoría de seguridad Linux |
| **OpenSCAP** | Compliance | Linux | Validación SCAP |
| **DISA STIG** | Benchmark | Multi | Guías de hardening militar |

### 12.3 Threat Hunting y Forense

| Herramienta | Tipo | Plataforma | Función |
|------------|------|-----------|---------|
| **Sysmon** (Sysinternals) | Monitoring | Windows | Logging avanzado de sistema |
| **Velociraptor** | Forensics | Multi | Forense y hunting a escala |
| **KAPE** | Forensics | Windows | Colección de artefactos |
| **Volatility** | Memory Forensics | Multi | Análisis de memoria |
| **YARA** | Detection | Multi | Reglas de detección |
| **OSQuery** | Monitoring | Multi | Consultas SQL sobre endpoints |
| **Chainsaw** | Log Analysis | Windows | Análisis rápido de Event Logs |
| **Autoruns** (Sysinternals) | Persistence | Windows | Enumeración de persistencia |
| **LOLBAS Project** | Reference | Windows | Catálogo de LOLBins |
| **Atomic Red Team** | Testing | Multi | Pruebas de detección |

### 12.4 SIEM y Correlación

| Herramienta | Tipo | Función |
|------------|------|---------|
| **Microsoft Sentinel** | SIEM/SOAR | Correlación y automatización |
| **Splunk Enterprise Security** | SIEM | Correlación avanzada |
| **Elastic Security** | SIEM | Open source, flexible |
| **Wazuh** | SIEM/XDR | Open source, ligero |
| **MISP** | Threat Intel | Compartición de IOCs |

---

## 13. Plantillas y Quick References

### 13.1 Quick Reference: Detección de Fileless Malware

```
┌─────────────────────────────────────────────────────────────────────────┐
│           QUICK REFERENCE — FILELESS MALWARE DETECTION                  │
│                                                                          │
│  1. HABILITAR (Prevención):                                             │
│     □ AMSI habilitado                                                    │
│     □ PowerShell Constrained Language Mode                               │
│     □ ASR Rules configuradas (ver sección 3.4)                          │
│     □ WDAC/AppLocker implementado                                        │
│     □ Macros deshabilitadas en Office                                    │
│                                                                          │
│  2. MONITOREAR (Detección):                                              │
│     □ Script Block Logging habilitado                                    │
│     □ Module Logging habilitado                                          │
│     □ Transcription Logging habilitado                                   │
│     □ Sysmon instalado y configurado                                     │
│     □ EDR con behavior detection activo                                  │
│     □ SIEM recibiendo logs de PowerShell y Sysmon                        │
│                                                                          │
│  3. BUSCAR (Hunting):                                                    │
│     □ PowerShell con -enc / -encodedcommand                              │
│     □ PowerShell con downloadstring / invoke-expression                  │
│     □ MSHTA ejecutando contenido remoto                                  │
│     □ CertUtil descargando archivos                                      │
│     □ Procesos accediendo a LSASS                                        │
│     □ CreateRemoteThread a procesos del sistema                          │
│     □ Reflective DLL loading                                             │
│                                                                          │
│  4. RESPONDER (Incident Response):                                       │
│     □ Aislar host                                                        │
│     □ Capturar memoria                                                   │
│     □ Analizar proceso árbol completo                                    │
│     □ Bloquear IOCs                                                      │
│     □ Buscar persistencia                                                │
│     □ Remediar y recuperar                                               │
└─────────────────────────────────────────────────────────────────────────┘
```

### 13.2 Quick Reference: LOLBin Detection

```
┌─────────────────────────────────────────────────────────────────────────┐
│           QUICK REFERENCE — LOLBin DETECTION                            │
│                                                                          │
│  ALERTA INMEDIATA si:                                                    │
│  • PowerShell con: -enc, -nop, -w hidden, downloadstring, iex           │
│  • MSHTA ejecutando: http://, https://, .hta remoto                     │
│  • CertUtil con: -urlcache, -split, -f + http                           │
│  • BitsAdmin con: /transfer, /addfile + URL remota                      │
│  • RegSvr32 con: /s, scrobj.dll, URL remota                            │
│  • Rundll32 ejecutando: URL, script, DLL sospechosa                    │
│  • MSBuild ejecutando: .proj/.sln desde ubicaciones inusuales          │
│  • Wmic con: process call create, shadowcopy delete                     │
│                                                                          │
│  ESCALAR si:                                                             │
│  • LOLBin ejecutado desde Office application                            │
│  • LOLBin con conexión de red a IP/dominio sospechoso                  │
│  • LOLBin ejecutado por cuenta de servicio                              │
│  • Múltiples LOLBins en secuencia (cadena de ataque)                    │
│  • LOLBin ejecutado fuera de horario laboral                            │
└─────────────────────────────────────────────────────────────────────────┘
```

### 13.3 Quick Reference: Persistence Hunting Checklist

```
┌─────────────────────────────────────────────────────────────────────────┐
│           QUICK REFERENCE — PERSISTENCE HUNTING                         │
│                                                                          │
│  REGISTRY:                                                               │
│  □ HKLM/HKCU\Software\Microsoft\Windows\CurrentVersion\Run              │
│  □ HKLM/HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce          │
│  □ HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run       │
│  □ HKLM\SYSTEM\CurrentControlSet\Services                               │
│  □ HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders│
│  □ HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon           │
│  □ HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Image File Execution Options│
│  □ HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run│
│                                                                          │
│  FILE SYSTEM:                                                            │
│  □ C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\        │
│  □ C:\Users\*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\│
│  □ C:\Windows\System32\GroupPolicy\Machine\Scripts\                     │
│  □ C:\Windows\System32\GroupPolicy\User\Scripts\                        │
│                                                                          │
│  SCHEDULED TASKS:                                                        │
│  □ Tareas con ejecutables en temp/appdata                               │
│  □ Tareas que ejecutan scripts o LOLBins                                │
│  □ Tareas creadas por usuarios no administradores                       │
│  □ Tareas con nombres aleatorios o genéricos                            │
│                                                                          │
│  SERVICES:                                                               │
│  □ Servicios con rutas en temp/appdata                                  │
│  □ Servicios sin descripción                                            │
│  □ Servicios con nombres aleatorios                                     │
│  □ Servicios que ejecutan scripts                                       │
│                                                                          │
│  WMI:                                                                    │
│  □ __EventFilter con queries sospechosas                                │
│  □ CommandLineEventConsumer                                             │
│  □ ActiveScriptEventConsumer                                            │
│  □ __FilterToConsumerBinding inusuales                                  │
│                                                                          │
│  COM:                                                                    │
│  □ CLSIDs en HKCU que redirigen a DLLs inusuales                       │
│  □ InprocServer32 apuntando a ubicaciones sospechosas                   │
│                                                                          │
│  OTHER:                                                                  │
│  □ BITS Jobs persistentes                                               │
│  □ Office Add-ins no autorizados                                        │
│  □ Browser extensions sospechosas                                       │
│  □ PowerShell profiles modificados                                      │
│  □ Accessibility feature replacements (sethc.exe, utilman.exe)          │
│  □ Netsh helper DLLs                                                    │
│  □ AppInit_DLLs                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 13.4 Quick Reference: Endpoint Hardening Checklist

```
┌─────────────────────────────────────────────────────────────────────────┐
│           QUICK REFERENCE — ENDPOINT HARDENING CHECKLIST                │
│                                                                          │
│  WINDOWS:                                                                │
│  □ Contraseñas: ≥ 14 caracteres, complejidad, historial 24             │
│  □ Bloqueo de cuenta: 5 intentos, 30 min                               │
│  □ UAC: Habilitado, solicitar en escritorio seguro                      │
│  □ Windows Defender: Protección en tiempo real activa                   │
│  □ ASR Rules: Configuradas (ver sección 3.4)                           │
│  □ Firewall: Habilitado en todos los perfiles                           │
│  □ SMBv1: Deshabilitado                                                 │
│  □ LLMNR: Deshabilitado                                                 │
│  □ WPAD: Deshabilitado                                                  │
│  □ RDP: Deshabilitado (si no se necesita)                               │
│  □ PowerShell: Script Block Logging + Module Logging + Transcription    │
│  □ PowerShell v2: Deshabilitado                                         │
│  □ BitLocker: Habilitado en todas las unidades                          │
│  □ Credential Guard: Habilitado (Enterprise)                            │
│  □ Macros Office: Bloqueadas desde Internet                             │
│  □ Sysmon: Instalado y configurado                                      │
│  □ EDR: Agente instalado y reportando                                   │
│                                                                          │
│  LINUX:                                                                  │
│  □ SSH: Root login deshabilitado, solo clave pública                    │
│  □ SSH: Algoritmos seguros (ed25519, AES-256-GCM)                      │
│  □ Firewall: Habilitado, deny incoming por defecto                      │
│  □ Servicios innecesarios: Deshabilitados                               │
│  □ Kernel: sysctl hardening aplicado                                    │
│  □ Auditd: Configurado con reglas de seguridad                          │
│  □ Fail2ban: Instalado y configurado                                    │
│  □ USB Storage: Deshabilitado                                           │
│  □ Permisos de archivos: Correctos (shadow 640, etc.)                   │
│  □ EDR: Agente instalado y reportando                                   │
│                                                                          │
│  macOS:                                                                  │
│  □ FileVault: Habilitado                                                │
│  □ Firewall: Habilitado con stealth mode                                │
│  □ Gatekeeper: Habilitado                                               │
│  □ SIP: Verificar que está habilitado                                   │
│  □ Servicios innecesarios: Deshabilitados                               │
│  □ Actualizaciones automáticas: Habilitadas                             │
│  □ EDR: Agente instalado y reportando                                   │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Notas Finales

Este skill es un documento vivo. Debe actualizarse:

1. **Mensualmente:** Revisar y actualizar queries de detección basados en nuevas amenazas
2. **Trimestralmente:** Actualizar mapeos MITRE ATT&CK, NIST CSF y D3FEND
3. **Semestralmente:** Revisar y actualizar playbooks de respuesta
4. **Anualmente:** Revisión completa del skill, actualización de herramientas y benchmarks

**Contacto BRIDA IT Services:**
- Para reportar mejoras a este skill: seguridad@brida.mx
- Para incidentes de seguridad: soc@brida.mx
- Para consultas generales: info@brida.mx

---

*© 2026 BRIDA IT Services. Todos los derechos reservados.*
*Este material es confidencial y para uso exclusivo de BRIDA IT Services y sus clientes autorizados.*