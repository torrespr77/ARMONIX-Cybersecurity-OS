---
name: security-operations-brida
description: "Security Operations (SecOps) skill for BRIDA IT Services: SIEM correlation, log analysis, alert triage, escalation workflows, playbook development, and tabletop exercises. Adapted for mid-market Mexican enterprises. Incluye mapeo MITRE ATT&CK, NIST CSF y D3FEND."
version: 1.0.0
author: BRIDA IT Services
license: Proprietary
category: cybersecurity
platforms: [linux, windows, macos]
triggers:
  - "SIEM"
  - "security operations"
  - "alert triage"
  - "log analysis"
  - "SOC"
  - "incident response"
  - "playbook"
  - "tabletop"
  - "MITRE ATT&CK"
  - "NIST CSF"
  - "D3FEND"
  - "escalation"
  - "correlación de eventos"
  - "análisis de logs"
  - "respuesta a incidentes"
  - "operaciones de seguridad"
  - "BRIDA"
metadata:
  hermes:
    tags: [security, soc, siem, incident-response, mitre-attack, nist-csf, d3fend, brida, mexico, cybersecurity, log-analysis, alert-triage, playbook, tabletop]
    language: "es-MX"
    compliance: [NIST-CSF, ISO-27001, PCI-DSS, LFPDPPP]
---

# Security Operations — BRIDA IT Services

> **Centro de Operaciones de Seguridad (SOC)** — Guía integral para operaciones de seguridad en empresas del mercado medio mexicano.

Este skill cubre la operación completa de un SOC: desde la correlación SIEM y análisis de logs hasta la respuesta a incidentes, desarrollo de playbooks y ejercicios tabletop. Todo alineado con marcos **MITRE ATT&CK**, **NIST CSF** y **D3FEND**.

---

## Tabla de Contenido

1. [Arquitectura del SOC para el Mercado Medio Mexicano](#1-arquitectura-del-soc)
2. [SIEM — Correlación y Reglas](#2-siem--correlación-y-reglas)
3. [Análisis de Logs](#3-análisis-de-logs)
4. [Alert Triage y Clasificación](#4-alert-triage-y-clasificación)
5. [Flujos de Escalamiento (Escalation Workflows)](#5-flujos-de-escalamiento)
6. [Playbooks de Respuesta a Incidentes](#6-playbooks-de-respuesta-a-incidentes)
7. [Ejercicios Tabletop](#7-ejercicios-tabletop)
8. [Mapeo MITRE ATT&CK](#8-mapeo-mitre-attck)
9. [Mapeo NIST CSF](#9-mapeo-nist-csf)
10. [Mapeo D3FEND](#10-mapeo-d3fend)
11. [Consideraciones Regulatorias Mexicanas](#11-consideraciones-regulatorias-mexicanas)
12. [Métricas y KPIs del SOC](#12-métricas-y-kpis-del-soc)
13. [Herramientas Recomendadas](#13-herramientas-recomendadas)
14. [Plantillas y Quick References](#14-plantillas-y-quick-references)

---

## 1. Arquitectura del SOC

### 1.1 Modelo Recomendado para Empresas Mid-Market en México

Para organizaciones de 200–5,000 empleados, se recomienda un **SOC híbrido**:

```
┌─────────────────────────────────────────────────────────┐
│                    SOC HÍBRIDO BRIDA                     │
│                                                         │
│  ┌──────────┐   ┌──────────────┐   ┌────────────────┐  │
│  │ Tier 1   │   │   Tier 2     │   │    Tier 3      │  │
│  │ Monitor- │──▶│  Análisis    │──▶│  Threat Hunt   │  │
│  │ eo y     │   │  Profundo    │   │  & Forense     │  │
│  │ Triage   │   │              │   │                │  │
│  └──────────┘   └──────────────┘   └────────────────┘  │
│       │               │                    │            │
│       ▼               ▼                    ▼            │
│  ┌─────────────────────────────────────────────────┐   │
│  │              SIEM Centralizado                   │   │
│  │    (Splunk / Microsoft Sentinel / Elastic)       │   │
│  └─────────────────────────────────────────────────┘   │
│       │                                                 │
│       ▼                                                 │
│  ┌─────────────────────────────────────────────────┐   │
│  │         Fuentes de Datos (Log Sources)           │   │
│  │  Firewalls │ EDR │ Active Directory │ Cloud │    │   │
│  │  Email GW  │ WAF │ VPN │ DNS │ Apps │ Database  │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

### 1.2 Roles y Responsabilidades

| Rol | Responsabilidad | Tier |
|-----|----------------|------|
| **Analista SOC L1** | Monitoreo 24/7, triage inicial, clasificación de alertas, escalamiento | 1 |
| **Analista SOC L2** | Investigación profunda, correlación de eventos, contención inicial | 2 |
| **Analista SOC L3 / Threat Hunter** | Caza de amenazas proactiva, forense digital, desarrollo de detecciones | 3 |
| **SOC Manager** | Gestión operativa, reporteo ejecutivo, mejora continua | Gestión |
| **CISO** | Estrategia, presupuesto, cumplimiento regulatorio, comunicación con directorio | Ejecutivo |

### 1.3 Horarios de Operación

Para mid-market mexicano, modelo recomendado:

- **Cobertura base:** 18×5 (6am–medianoche, lunes–viernes) con L1 in-house
- **Cobertura extendida:** 24×7 vía MSSP o SOC-as-a-Service para noches y fines de semana
- **On-call:** L2/L3 disponible para incidentes críticos fuera de horario
- **Zona horaria:** CST (UTC-6) — considerar alineación con proveedores internacionales

---

## 2. SIEM — Correlación y Reglas

### 2.1 Fuentes de Datos Críticas (Log Sources)

Priorizar la ingesta según valor de detección:

| Prioridad | Fuente de Logs | Protocolo/Formato | Retención Mínima |
|-----------|---------------|-------------------|-----------------|
| **Crítica** | Firewall (perimetral) | Syslog / CEF | 12 meses |
| **Crítica** | EDR (Endpoint) | API / JSON | 12 meses |
| **Crítica** | Active Directory / LDAP | WEF / WinEvent | 12 meses |
| **Crítica** | Email Gateway (O365/Google) | API / JSON | 6 meses |
| **Alta** | VPN Concentrator | Syslog | 6 meses |
| **Alta** | DNS Logs | Syslog / Agent | 6 meses |
| **Alta** | WAF | CEF / JSON | 6 meses |
| **Media** | Cloud (AWS/Azure/GCP) | CloudTrail / Azure Monitor | 12 meses |
| **Media** | Aplicaciones críticas | Syslog / JSON | 3 meses |
| **Baja** | Impresoras, IoT | Syslog | 1 mes |

### 2.2 Reglas de Correlación Esenciales

#### Autenticación y Acceso

```yaml
# Regla: Fuerza Bruta SSH
rule_name: "BRIDA-SSH-BRUTE-FORCE"
description: "Detecta múltiples intentos fallidos de SSH desde una misma IP"
severity: "HIGH"
mitre_mapping: ["T1110", "T1110.001"]
correlation_logic:
  event_source: "firewall OR linux_auth"
  condition: "FAILED_SSH_AUTH"
  threshold: ">= 10 intentos en 5 minutos"
  group_by: "source_ip"
response:
  - action: "alert"
  - action: "block_ip_temporarily (15 min)"
  - action: "notify_soc_l2"
```

```yaml
# Regla: Inicio de sesión fuera de horario
rule_name: "BRIDA-AFTER-HOURS-LOGIN"
description: "Detecta inicios de sesión fuera del horario laboral normal"
severity: "MEDIUM"
mitre_mapping: ["T1078"]
correlation_logic:
  event_source: "active_directory"
  condition: "SUCCESSFUL_LOGIN"
  time_window: "22:00 - 05:00 CST"
  filter: "NOT IN whitelist_after_hours_users"
response:
  - action: "alert"
  - action: "require_mfa_reverification"
  - action: "log_for_review"
```

```yaml
# Regla: Movimiento Lateral
rule_name: "BRIDA-LATERAL-MOVEMENT"
description: "Detecta patrones de movimiento lateral entre hosts internos"
severity: "CRITICAL"
mitre_mapping: ["T1021", "T1021.001", "T1021.002", "T1570"]
correlation_logic:
  event_source: "edr OR active_directory"
  condition: "MULTIPLE_HOSTS_ACCESSED_FROM_SINGLE_SOURCE"
  threshold: ">= 3 hosts diferentes en 30 minutos"
  protocols: ["SMB", "RDP", "WinRM", "SSH"]
response:
  - action: "critical_alert"
  - action: "isolate_source_host"
  - action: "notify_soc_l2_and_l3"
  - action: "initiate_ir_playbook"
```

#### Malware y Exfiltración

```yaml
# Regla: Comunicación C2 (Command & Control)
rule_name: "BRIDA-C2-COMMUNICATION"
description: "Detecta indicadores de comunicación con servidores C2"
severity: "CRITICAL"
mitre_mapping: ["T1071", "T1572", "T1059"]
correlation_logic:
  event_source: "firewall OR proxy OR dns"
  condition: "TRAFFIC_TO_KNOWN_C2_INDICATOR"
  ioc_sources:
    - "threat_intel_feed"
    - "internal_hunt_findings"
    - "misp_community"
response:
  - action: "critical_alert"
  - action: "block_destination"
  - action: "isolate_affected_host"
  - action: "notify_soc_l3_and_ciso"
  - action: "initiate_ir_playbook_c2"
```

```yaml
# Regla: Exfiltración de Datos
rule_name: "BRIDA-DATA-EXFILTRATION"
description: "Detecta transferencias de datos anómalamente grandes"
severity: "HIGH"
mitre_mapping: ["T1041", "T1048", "T1567"]
correlation_logic:
  event_source: "firewall OR proxy OR dlp"
  condition: "OUTBOUND_DATA_TRANSFER"
  threshold: "> 500MB en 1 hora a destination NOT IN whitelist"
  direction: "outbound"
response:
  - action: "alert"
  - action: "capture_traffic_sample"
  - action: "notify_soc_l2"
```

#### Ransomware (Crítico para México)

```yaml
# Regla: Indicadores de Ransomware
rule_name: "BRIDA-RANSOMWARE-INDICATORS"
description: "Detecta patrones asociados con actividad de ransomware"
severity: "CRITICAL"
mitre_mapping: ["T1486", "T1490", "T1498"]
correlation_logic:
  event_source: "edr"
  conditions:
    - "MASS_FILE_EXTENSION_CHANGE"
    - "SHADOW_COPY_DELETION (vssadmin delete shadows)"
    - "DISABLE_RECOVERY_MODE (bcdedit)"
    - "RANSOM_NOTE_CREATION (*.txt, *.html en múltiples directorios)"
  threshold: "ANY 2 conditions en 10 minutos"
response:
  - action: "critical_alert"
  - action: "IMMEDIATE_HOST_ISOLATION"
  - action: "notify_soc_l2_l3_ciso"
  - action: "initiate_ransomware_playbook"
  - action: "preserve_evidence"
```

### 2.3 Plataformas SIEM Recomendadas

| Plataforma | Caso de Uso | Rango de Precio (MXN/año) | Idoneidad Mid-Market |
|-----------|-------------|--------------------------|---------------------|
| **Microsoft Sentinel** | Entornos Microsoft/Azure | $150K–$500K | ★★★★★ |
| **Splunk Enterprise Security** | Entornos mixtos, alta personalización | $300K–$1M+ | ★★★★ |
| **Elastic Security (ELK)** | Presupuesto limitado, equipo técnico fuerte | $50K–$200K (open source base) | ★★★★ |
| **Wazuh** | Budget-constrained, open source | $0 (software) + soporte | ★★★ |
| **IBM QRadar** | Enterprise, compliance-heavy | $400K–$1.5M | ★★★ |
| **FortiSIER** | Entornos Fortinet | $100K–$400K | ★★★★ |

### 2.4 Buenas Prácticas de Correlación

1. **Tuning continuo:** Revisar y ajustar reglas semanalmente durante los primeros 3 meses, luego mensualmente
2. **False Positive Management:** Mantener tasa de falsos positivos < 15% por regla
3. **Enriquecimiento de alertas:** Agregar contexto automático (propietario del activo, criticidad, IOCs relacionados)
4. **Supresión inteligente:** No suprimir alertas, ajustar umbrales y condiciones
5. **Versionado de reglas:** Control de versiones para todas las reglas de correlación
6. **Documentación:** Cada regla debe tener: descripción, MITRE mapping, severidad justificada, y procedimiento de respuesta

---

## 3. Análisis de Logs

### 3.1 Metodología de Análisis

```
Fase 1: Recolección y Normalización
    │
    ▼
Fase 2: Enriquecimiento (Contextualización)
    │
    ▼
Fase 3: Correlación (Cross-source)
    │
    ▼
Fase 4: Análisis (Investigación)
    │
    ▼
Fase 5: Documentación y Reporteo
```

### 3.2 Framework de Análisis de Logs

#### Para cada evento de seguridad, aplicar el modelo **5W+H**:

| Pregunta | Descripción | Ejemplo |
|----------|-------------|---------|
| **What** | ¿Qué sucedió? | Intento fallido de autenticación |
| **Who** | ¿Quién lo hizo? | Usuario jdoe@empresa.mx |
| **When** | ¿Cuándo ocurrió? | 2026-01-15 03:22:14 CST |
| **Where** | ¿Dónde se originó? | IP 201.174.x.x, Host SRV-DC01 |
| **Why** | ¿Por qué es sospechoso? | Horario inusual, IP no reconocida |
| **How** | ¿Cómo se ejecutó? | RDP desde segmento no autorizado |

### 3.3 Análisis por Tipo de Log

#### Windows Event Logs

| Event ID | Descripción | Relevancia SOC |
|----------|-------------|----------------|
| **4624** | Logon exitoso | Autenticación legítima vs. sospechosa |
| **4625** | Logon fallido | Fuerza bruta, credential stuffing |
| **4648** | Logon con credenciales explícitas | Pass-the-Hash, escalamiento |
| **4672** | Privilegios especiales asignados | Escalamiento de privilegios |
| **4688** | Proceso creado | Ejecución de malware, LOLBins |
| **4697** | Servicio instalado | Persistencia |
| **4720** | Cuenta de usuario creada | Creación de cuentas no autorizadas |
| **4728** | Miembro agregado a grupo privilegiado | Escalamiento de privilegios |
| **4732** | Miembro agregado a grupo local privilegiado | Escalamiento de privilegios |
| **7045** | Nuevo servicio instalado | Persistencia, backdoor |
| **1102** | Log de auditoría borrado | Anti-forense, evasión |

#### Firewall / Network Logs

Campos clave para análisis:
- **Source/Destination IP** — Verificar contra threat intelligence
- **Port/Protocol** — Identificar servicios no estándar
- **Bytes In/Out** — Detectar exfiltración
- **Action (Allow/Deny)** — Identificar patrones de escaneo
- **GeoIP** — Tráfico hacia/desde países inusuales

#### DNS Logs

Patrones sospechosos:
- **DGA (Domain Generation Algorithms):** Dominios aleatorios (e.g., `xjk3m2b1.com`)
- **DNS Tunneling:** Queries excesivamente largas o con datos codificados en subdominios
- **Beaconing:** Intervalos regulares de consulta a dominios específicos
- **NXDOMAIN spikes:** Múltiples consultas fallidas (posible DGA o malware)

#### EDR / Endpoint Logs

Indicadores clave:
- **Process tree anomalies:** `winword.exe` → `powershell.exe` → `cmd.exe`
- **LOLBins execution:** PowerShell, MSHTA, CertUtil, BitsAdmin, CMSTP
- **Fileless malware:** Inyección de procesos, reflective DLL loading
- **Registry modifications:** Run keys, COM hijacking
- **Named pipes:** Comunicación interprocesos sospechosa

### 3.4 Queries de Análisis Comunes

#### Splunk SPL

```spl
# Detección de Pass-the-Hash
index=windows EventCode=4624 LogonType=3 
| stats count by src_ip, user, dest 
| where count > 5
| sort -count

# Procesos sospechosos (LOLBins)
index=edr process_name IN ("powershell.exe", "mshta.exe", "certutil.exe", "bitsadmin.exe", "cmstp.exe", "regsvr32.exe")
| stats count by host, process_name, parent_process, command_line
| sort -count

# Comunicación con países inusuales
index=firewall action=allowed
| iplocation dest_ip
| where NOT (country IN ("Mexico", "United States", "Canada"))
| stats sum(bytes_out) as total_bytes by src_ip, dest_ip, country
| where total_bytes > 104857600
| sort -total_bytes
```

#### Elasticsearch KQL

```esql
# Autenticación fallida masiva
event.code: 4625 | stats count by source.ip, user.name | sort -count

# Modificación de grupos privilegiados
event.code: (4728 OR 4732) | table @timestamp, user.name, group.name, host.name

# Borrado de logs de auditoría
event.code: 1102 | table @timestamp, host.name, user.name
```

#### Microsoft Sentinel KQL

```kql
# Detección de viaje imposible (impossible travel)
SecurityAlert
| where TimeGenerated > ago(1h)
| where AlertName contains "impossible travel"
| project TimeGenerated, CompromisedEntity, AlertName, ExtendedProperties

# Alertas de Azure AD Identity Protection
SecurityAlert
| where ProviderName == "IPC"
| where TimeGenerated > ago(24h)
| summarize count() by AlertName, CompromisedEntity, bin(TimeGenerated, 1h)
```

### 3.5 Análisis de Threat Intelligence

Fuentes de inteligencia recomendadas para México:

| Fuente | Tipo | Acceso |
|--------|------|--------|
| **CCCS (Canadian Centre for Cyber Security)** | Alertas, advisories | Gratuito |
| **CISA (US)** | IOCs, advisories | Gratuito |
| **MISP Community** | IOCs compartidos | Gratuito |
| **AlienVault OTX** | IOCs, pulses | Gratuito |
| **VirusTotal** | Malware analysis | Freemium |
| **Shodan** | Exposición de servicios | Freemium |
| **ANSSI (Francia)** | Advisories | Gratuito |
| **CSIRT México** | Alertas nacionales | Gratuito |
| **CERT-MX** | Alertas México | Gratuito |
| **OAS Cyber Security Program** | Regional | Gratuito |

---

## 4. Alert Triage y Clasificación

### 4.1 Proceso de Triage

```
┌─────────────┐
│   Alerta     │
│   Generada   │
└──────┬──────┘
       │
       ▼
┌──────────────────┐     ┌──────────────┐
│  ¿Es un falso    │─Sí─▶│  Documentar  │
│  positivo?       │     │  y Cerrar    │
└──────┬───────────┘     └──────────────┘
       │ No
       ▼
┌──────────────────┐     ┌──────────────┐
│  ¿Requiere       │─No──▶│  Agregar a   │
│  investigación?  │     │  Watchlist   │
└──────┬───────────┘     └──────────────┘
       │ Sí
       ▼
┌──────────────────┐
│  Clasificar      │
│  Severidad       │
└──────┬───────────┘
       │
       ▼
┌──────────────────┐
│  Asignar a Tier  │
│  correspondiente │
└──────┬───────────┘
       │
       ▼
┌──────────────────┐
│  Investigar y    │
│  Documentar      │
└──────────────────┘
```

### 4.2 Matriz de Severidad

| Severidad | Descripción | Tiempo de Respuesta | Tiempo de Resolución | Ejemplo |
|-----------|-------------|--------------------|--------------------|---------|
| **CRITICAL (P1)** | Amenaza activa en curso, impacto inminente | ≤ 15 minutos | ≤ 4 horas | Ransomware activo, exfiltración en progreso, compromiso de dominio |
| **HIGH (P2)** | Amenaza confirmada, posible compromiso | ≤ 30 minutos | ≤ 8 horas | Malware detectado, fuerza bruta exitosa, C2 beaconing |
| **MEDIUM (P3)** | Actividad sospechosa, investigación requerida | ≤ 2 horas | ≤ 24 horas | Login anómalo, escaneo de puertos interno, política violada |
| **LOW (P4)** | Información, posible riesgo futuro | ≤ 8 horas | ≤ 72 horas | Alerta de vulnerabilidad nueva, intento bloqueado, configuración débil |
| **INFO (P5)** | Informativo, sin acción inmediata | ≤ 24 horas | ≤ 1 semana | Cambio de configuración, actualización de firmas, reporte periódico |

### 4.3 Criterios de Clasificación

#### Escalamiento a CRITICAL (P1):
- Ransomware detectado o sospechado
- Compromiso confirmado de cuenta de administrador
- Exfiltración de datos PII/financieros en progreso
- Ataque activo contra infraestructura crítica
- Brecha de seguridad confirmada

#### Escalamiento a HIGH (P2):
- Malware detectado por EDR (no bloqueado automáticamente)
- Comunicación C2 confirmada
- Acceso no autorizado a sistemas críticos
- Múltiples hosts comprometidos
- Credenciales filtradas detectadas

#### Escalamiento a MEDIUM (P3):
- Intentos de acceso no autorizado (bloqueados)
- Anomalías de comportamiento de usuario
- Escaneo interno de red
- Violaciones de política de seguridad
- Vulnerabilidades críticas sin parchear

### 4.4 Formato de Ticket de Incidente

```markdown
# INCIDENTE: [INC-YYYY-XXXX]

## Información General
- **ID:** INC-2026-0001
- **Título:** [Descripción breve]
- **Severidad:** P1/P2/P3/P4/P5
- **Estado:** Abajo / En Progreso / Contenido / Cerrado
- **Fecha/Hora de Detección:** YYYY-MM-DD HH:MM CST
- **Fecha/Hora de Contención:** YYYY-MM-DD HH:MM CST
- **Analista Asignado:** [Nombre]
- **MITRE ATT&CK:** [T####]

## Resumen Ejecutivo
[2-3 oraciones describiendo el incidente]

## Activos Afectados
- Host: [hostname]
- IP: [dirección IP]
- Usuario: [cuenta]
- Sistema: [aplicación/sistema]

## Timeline
| Hora (CST) | Evento | Fuente |
|-----------|--------|--------|
| HH:MM | [Descripción] | [Log source] |

## Evidencia Recolectada
- [ ] Capturas de pantalla
- [ ] Logs exportados
- [ ] PCAP (si aplica)
- [ ] Memoria volcada (si aplica)
- [ ] Hash de archivos maliciosos

## Acciones Tomadas
1. [Acción 1]
2. [Acción 2]

## Acciones Pendientes
- [ ] [Acción pendiente]

## Lecciones Aprendidas
[A completar al cierre]
```

---

## 5. Flujos de Escalamiento

### 5.1 Matriz de Escalamiento

```
┌──────────────────────────────────────────────────────────────────┐
│                    ESCALATION MATRIX                             │
│                                                                  │
│  TIER 1 (L1) ──▶ TIER 2 (L2) ──▶ TIER 3 (L3) ──▶ CISO         │
│                                                                  │
│  • Triage inicial    • Análisis      • Threat       • Decisión  │
│  • Clasificación       profundo        Hunting         ejecutiva │
│  • Filtro FP        • Contención    • Forense      • Legal      │
│  • Escalamiento     • Correlación   • Malware      • Regulatorio│
│    básico             avanzada        analysis      • PR/Comms   │
│                     • Escalamiento  • Escalamiento              │
│                       a L3            a CISO                    │
└──────────────────────────────────────────────────────────────────┘
```

### 5.2 Criterios de Escalamiento

| De | A | Criterio | Tiempo Máximo en Tier Origen |
|----|---|----------|------------------------------|
| L1 | L2 | Alerta clasificada P2 o superior | 15 minutos |
| L1 | L2 | No se puede determinar si es FP en 10 min | 10 minutos |
| L1 | L2 | Requiere análisis de logs de múltiples fuentes | Inmediato |
| L2 | L3 | Confirmación de compromiso (breach) | 30 minutos |
| L2 | L3 | Requiere análisis forense | 30 minutos |
| L2 | L3 | Múltiples sistemas afectados | 15 minutos |
| L2 | CISO | Incidente P1 confirmado | 15 minutos |
| L3 | CISO | Brecha de datos PII confirmada | Inmediato |
| L3 | CISO | Ransomware en producción | Inmediato |
| CISO | Legal/Directorio | Notificación regulatoria requerida | 2 horas |
| CISO | Externo (MSSP/Consultor) | Capacidad interna superada | 1 hora |

### 5.3 Canales de Comunicación por Severidad

| Severidad | Canal Principal | Canal Secundario | Notificación |
|-----------|---------------|------------------|-------------|
| **P1** | Llamada telefónica + War room (Teams/Slack) | SMS | CISO, Legal, Directorio |
| **P2** | Teams/Slack #soc-critical | Email | SOC Manager, CISO |
| **P3** | Teams/Slack #soc-alerts | Email | SOC Manager |
| **P4** | Ticket (Jira/ServiceNow) | Teams/Slack #soc-info | Analista asignado |
| **P5** | Ticket (Jira/ServiceNow) | — | — |

### 5.4 Escalamiento a Autoridades (México)

Para incidentes que requieran notificación a autoridades:

| Autoridad | Cuándo | Plazo | Contacto |
|-----------|--------|-------|---------- |
| **IFAI/INAI** | Brecha de datos personales | Sin demora indebida | www.inai.org.mx |
| **Policía Cibernética (SSC)** | Delito cibernético confirmado | Inmediato | 088 o denuncia.gob.mx |
| **CSIRT México** | Incidente que afecte infraestructura crítica | Inmediate | csirt.gob.mx |
| **Condusef** | Institución financiera, brecha de datos | 72 horas | www.condusef.gob.mx |
| **CNBV** | Institución financiera regulada | Según circular | www.cnbv.gob.mx |

---

## 6. Playbooks de Respuesta a Incidentes

### 6.1 Estructura Estándar de Playbook

```markdown
# PLAYBOOK: [NOMBRE]

## Metadatos
- **ID:** PB-YYYY-XXX
- **Versión:** X.X
- **Última Actualización:** YYYY-MM-DD
- **MITRE ATT&CK:** [Tactic/Technique IDs]
- **NIST CSF:** [Function/Category]
- **Severidad Asociada:** P1/P2/P3

## Descripción
[Qué cubre este playbook]

## Triggers
[Qué alertas o condiciones activan este playbook]

## Fases de Respuesta

### Fase 1: Detección y Análisis
1. [Paso 1]
2. [Paso 2]

### Fase 2: Contención
1. [Paso 1]
2. [Paso 2]

### Fase 3: Erradicación
1. [Paso 1]
2. [Paso 2]

### Fase 4: Recuperación
1. [Paso 1]
2. [Paso 2]

### Fase 5: Lecciones Aprendidas
1. [Paso 1]
2. [Paso 2]

## Checklist
- [ ] Paso 1 completado
- [ ] Paso 2 completado

## Contactos
- [Rol]: [Nombre] — [Teléfono] — [Email]

## Referencias
- [Enlace a documentación]
```

### 6.2 Playbook: Ransomware

```markdown
# PLAYBOOK: RANSOMWARE RESPONSE
## ID: PB-RANSOMWARE-001
## MITRE ATT&CK: T1486, T1490, T1498
## NIST CSF: RS.RP, RS.MI, RS.AN, RC.RP
## Severidad: P1 (CRITICAL)

### Fase 1: Detección y Análisis (0-30 min)
1. Confirmar indicadores de ransomware:
   - [ ] Cambio masivo de extensiones de archivo
   - [ ] Notas de rescate presentes
   - [ ] Shadow copies eliminadas
   - [ ] Procesos sospechosos en ejecución
2. Identificar el alcance:
   - [ ] ¿Cuántos hosts están afectados?
   - [ ] ¿Qué segmentos de red?
   - [ ] ¿Hay propagación activa?
3. Identificar la variante (si es posible):
   - [ ] Enviar muestra a VirusTotal / ID Ransomware
   - [ ] Verificar si existe decryptor (nomoreransom.org)
4. Preservar evidencia:
   - [ ] Capturar memoria RAM de hosts afectados
   - [ ] Exportar logs relevantes
   - [ ] Fotografiar notas de rescate

### Fase 2: Contención (30-60 min)
1. AISLAMIENTO INMEDIATO:
   - [ ] Desconectar hosts afectados de la red (NO apagar)
   - [ ] Bloquear IPs/dominios C2 identificados en firewall
   - [ ] Deshabilitar cuentas de usuario comprometidas
   - [ ] Bloquear puertos SMB (445) entre segmentos
2. Proteger sistemas no afectados:
   - [ ] Aplicar reglas de firewall restrictivas
   - [ ] Forzar cambio de contraseñas de admin de dominio
   - [ ] Verificar integridad de backups
   - [ ] Activar autenticación MFA si no estaba habilitada

### Fase 3: Erradicación (1-4 horas)
1. Eliminar malware de sistemas afectados
2. Identificar vector de entrada inicial
3. Parchear vulnerabilidades explotadas
4. Restablecer credenciales comprometidas
5. Verificar limpieza completa antes de reconexión

### Fase 4: Recuperación (4-72 horas)
1. Restaurar desde backups limpios (verificar integridad)
2. Reconectar sistemas de forma gradual
3. Monitoreo intensivo post-recuperación (72 horas)
4. Validar funcionalidad de sistemas restaurados

### Fase 5: Post-Incidente
1. Realizar lecciones aprendidas (blameless postmortem)
2. Actualizar playbooks según hallazgos
3. Reportar a autoridades si aplica (Policía Cibernética)
4. Notificar a titulares de datos si hay brecha (INAI/LFPDPPP)
5. Actualizar controles de seguridad

### DECISIÓN: ¿Pagar rescate?
- **RECOMENDACIÓN BRIDA: NO pagar**
- Consultar con FBI/CISA para decryptors disponibles
- Evaluar impacto legal (OFAC sanctions)
- Documentar la decisión y su justificación
```

### 6.3 Playbook: Compromiso de Email (BEC)

```markdown
# PLAYBOOK: BUSINESS EMAIL COMPROMISE
## ID: PB-BEC-001
## MITRE ATT&CK: T1566.001, T1566.002, T1534
## NIST CSF: PR.AC, DE.CM, RS.AN
## Severidad: P1/P2

### Fase 1: Detección y Análisis
1. Confirmar compromiso:
   - [ ] Verificar reglas de reenvío no autorizadas
   - [ ] Revisar actividad de login sospechosa
   - [ ] Verificar envíos masivos o inusuales
   - [ ] Revisar delegación de permisos
2. Determinar alcance:
   - [ ] ¿Qué correos fueron accedidos/reenviados?
   - [ ] ¿Se enviaron correos fraudulentos?
   - [ ] ¿Hay información financiera comprometida?

### Fase 2: Contención
1. Resetear contraseña de la cuenta comprometida
2. Revocar sesiones activas
3. Eliminar reglas de reenvío no autorizadas
4. Deshabilitar acceso API si fue explotado
5. Notificar a contactos si se enviaron correos fraudulentos

### Fase 3: Erradicación
1. Eliminar persistencia (reglas, apps OAuth, etc.)
2. Forzar MFA si no estaba habilitado
3. Revisar otras cuentas del mismo usuario
4. Buscar indicadores de phishing inicial

### Fase 4: Recuperación
1. Restablecer acceso con nuevas credenciales
2. Monitoreo de 30 días en la cuenta
3. Verificar que no haya fraude financiero en curso
```

### 6.4 Playbook: Exfiltración de Datos

```markdown
# PLAYBOOK: DATA EXFILTRATION
## ID: PB-EXFIL-001
## MITRE ATT&CK: T1041, T1048, T1567, T1020
## NIST CSF: PR.DS, DE.CM, RS.AN, RS.MI
## Severidad: P1

### Fase 1: Detección y Análisis
1. Confirmar exfiltración:
   - [ ] Volumen de datos transferido
   - [ ] Destino de la transferencia
   - [ ] Protocolo utilizado (HTTPS, DNS, FTP, etc.)
   - [ ] Datos involucrados (PII, financieros, IP)
2. Identificar origen:
   - [ ] Host/usuario que inició la transferencia
   - [ ] Cuándo comenzó
   - [ ] Duración de la exfiltración

### Fase 2: Contención
1. Bloquear destino de exfiltración en firewall/proxy
2. Aislar host fuente
3. Deshabilitar cuenta de usuario involucrada
4. Activar DLP rules si no estaban activas
5. Preservar evidencia (PCAP, logs, capturas)

### Fase 3: Evaluación de Impacto
1. Clasificar datos exfiltrados
2. Determinar si aplica notificación regulatoria
3. Evaluar impacto a clientes/socios
4. Documentar para posible acción legal

### Fase 4: Notificación (si aplica)
1. INAI — Brecha de datos personales (LFPDPPP)
2. Clientes afectados
3. Autoridades competentes según sector
4. Aseguradora de ciberriesgo
```

### 6.5 Playbook: Insider Threat

```markdown
# PLAYBOOK: INSIDER THREAT
## ID: PB-INSIDER-001
## MITRE ATT&CK: T1530, T1567, T1052, T1114
## NIST CSF: PR.AC, PR.PT, DE.CM, DE.AE
## Severidad: P1/P2

### Consideraciones Especiales
- Coordinar con Legal y RRHH desde el inicio
- Mantener confidencialidad de la investigación
- No alertar al sospechoso
- Documentar todo meticulosamente para posible acción legal

### Fase 1: Detección y Análisis
1. Correlacionar indicadores:
   - [ ] Acceso a datos fuera de rol
   - [ ] Descargas masivas
   - [ ] Uso de USB no autorizado
   - [ ] Envío de datos a cuentas personales
   - [ ] Acceso fuera de horario
   - [ ] Búsqueda de información sensible
2. Establecer timeline de actividad
3. Determinar si es malicioso o accidental

### Fase 2: Contención
1. Restringir acceso (sin alertar al usuario)
2. Preservar evidencia forense
3. Coordinar con RRHH para acciones de personal
4. Revocar accesos si es necesario

### Fase 3: Investigación
1. Análisis forense de dispositivos
2. Revisión de comunicaciones (con autorización legal)
3. Entrevista (coordinada con RRHH y Legal)
4. Documentación para expediente laboral
```

### 6.6 Playbooks Adicionales Requeridos

| ID | Playbook | MITRE ATT&CK | Prioridad |
|----|----------|-------------|-----------|
| PB-PHISH-001 | Phishing Response | T1566.001/002 | Alta |
| PB-DDOS-001 | DDoS Mitigation | T1498 | Alta |
| PB-WEB-001 | Web Application Attack | T1190, T1133 | Alta |
| PB-CLOUD-001 | Cloud Infrastructure Compromise | T1078 | Alta |
| PB-SUPPLY-001 | Supply Chain Compromise | T1195 | Media |
| PB-PHYSICAL-001 | Physical Security Breach | T1200 | Media |
| PB-ZERO-001 | Zero-Day Exploitation | T1203, T1190 | Alta |
| PB-CRED-001 | Credential Stuffing | T1110.004 | Alta |
| PB-MOBILE-001 | Mobile Device Compromise | T1406 | Media |
| PB-SOCIAL-001 | Social Engineering | T1598 | Alta |

---

## 7. Ejercicios Tabletop

### 7.1 Metodología

Los ejercicios tabletop son simulaciones de incidentes de seguridad donde los participantes discuten sus roles y respuestas en un escenario hipotético, sin impacto en sistemas reales.

**Frecuencia recomendada:**
- Ejercicio tabletop completo: **Trimestral** (4 veces al año)
- Mini-ejercicio (30 min): **Mensual**
- Ejercicio con directorio: **Semestral**

### 7.2 Estructura del Ejercicio

```
1. Preparación (1-2 semanas antes)
   ├── Definir escenario
   ├── Preparar inyecciones (eventos durante el ejercicio)
   ├── Identificar participantes
   └── Preparar materiales

2. Ejercicio (2-3 horas)
   ├── Introducción (15 min)
   │   ├── Objetivos del ejercicio
   │   ├── Reglas de engagement
   │   └── Roles asignados
   │
   ├── Fase 1: Detección (30 min)
   │   ├── Inyección inicial
   │   ├── Discusión de respuesta
   │   └── Inyección de seguimiento
   │
   ├── Fase 2: Contención (30 min)
   │   ├── Nuevas revelaciones
   │   ├── Decisiones de contención
   │   └── Coordinación entre equipos
   │
   ├── Fase 3: Escalamiento (30 min)
   │   ├── Comunicación ejecutiva
   │   ├── Decisión de notificación
   │   └── Gestión de crisis
   │
   └── Fase 4: Cierre y Lecciones (30 min)
       ├── Resumen de decisiones
       ├── Identificación de gaps
       └── Plan de mejora

3. Post-Ejercicio (1 semana después)
   ├── Documentar hallazgos
   ├── Crear plan de acción
   ├── Presentar a dirección
   └── Actualizar playbooks
```

### 7.3 Escenarios Recomendados para México 2026

#### Escenario 1: Ransomware en Sector Financiero

```markdown
## TABLETOP: RANSOME FINANCIERO MX-2026-01

**Contexto:** Empresa financiera mexicana (SOFOM/SOFIPO) con 800 empleados.
Operaciones en CDMX, Monterrey y Guadalajara.

**Inyección 1 (09:00):**
El SOC recibe múltiples alertas de EDR indicando que 15 estaciones de trabajo
en la sucursal de Monterrey han comenzado a cifrar archivos. Las estaciones
muestran una nota de rescate en pantalla solicitando 50 BTC.

**Inyección 2 (09:30):**
Se descubre que el ransomware se propagó a través de una vulnerabilidad en el
software de escritorio remoto utilizado por el equipo de soporte. El servidor
de archivos central en CDMX muestra actividad de cifrado.

**Inyección 3 (10:00):**
Los atacantes contactan por email al CFO exigiendo el pago y amenazando con
publicar datos de clientes si no pagan en 48 horas. Adjuntan muestra de datos
de 500 clientes.

**Inyección 4 (10:30):**
El periódico El Financiero contacta a la empresa preguntando sobre reportes de
una brecha de seguridad. Un empleado filtró información.

**Preguntas para discusión:**
1. ¿Cuál es la primera acción inmediata?
2. ¿Se notifica a la CNBV/Condusef? ¿En qué plazo?
3. ¿Se paga el rescate? ¿Cuáles son las implicaciones legales (OFAC)?
4. ¿Cómo se maneja la comunicación pública?
5. ¿Qué evidencia debe preservarse?
6. ¿Se activa el seguro de ciberriesgo?
```

#### Escenario 2: Ataque de Phishing a Proveedores (Supply Chain)

```markdown
## TABLETOP: SUPPLY CHAIN PHISHING MX-2026-02

**Contexto:** Empresa manufacturera en Querétaro con cadena de suministro
integrada vía portal web con 200 proveedores.

**Inyección 1:**
El equipo de seguridad descubre que el portal de proveedores fue comprometido.
Los atacantes inyectaron código malicioso que roba credenciales de acceso.
30 proveedores han ingresado al portal en las últimas 48 horas.

**Inyección 2:**
Uno de los proveedores reporta que recibió una factura fraudulenta desde el
email del CFO de su empresa solicitando un cambio de cuenta bancaria para
pagos. El proveedor ya realizó un transferencia de $2.5M MXN.

**Inyección 3:**
Se descubre que los atacantes tuvieron acceso al portal durante 3 semanas
antes de ser detectados. Datos de precios, contratos y NDA fueron accedidos.

**Preguntas para discusión:**
1. ¿Cómo se contiene el compromiso del portal?
2. ¿Se notifica a los 30 proveedores afectados?
3. ¿Se puede recuperar la transferencia fraudulenta?
4. ¿Qué implicaciones contractuales existen?
5. ¿Cómo se verifica la integridad de todo el sistema?
```

#### Escenario 3: Insider Threat en Departamento de TI

```markdown
## TABLETOP: INSIDER THREAT MX-2026-03

**Contexto:** Empresa de retail con 2,000 empleados y operaciones de e-commerce.

**Inyección 1:**
El DLP alerta que un administrador de base de datos descargó 50,000 registros
de clientes (incluyendo datos de tarjetas) a un USB la noche anterior. El
administrador tiene una renuncia pendiente en 2 semanas.

**Inyección 2:**
Se descubre que el administrador creó una cuenta de servicio con privilegios
elevados hace 6 meses que no está documentada. La cuenta sigue activa.

**Inyección 3:**
El administrador fue visto en las oficinas a las 2:00 AM el fin de semana
pasado. Los logs muestran que accedió a la base de datos de producción y al
repositorio de código fuente.

**Preguntas para discusión:**
1. ¿Cómo se maneja la investigación sin alertar al sospechoso?
2. ¿Cuándo se involucra a RRHH y Legal?
3. ¿Se restringe el acceso inmediatamente o se monitorea?
4. ¿Qué acciones legales son posibles?
5. ¿Cómo se protege al empleado si es falsa alarma?
```

#### Escenario 4: Compromiso de Infraestructura Cloud

```markdown
## TABLETOP: CLOUD COMPROMISE MX-2026-04

**Contexto:** Empresa de tecnología con infraestructura en AWS (70%) y Azure (30%).
Equipo de DevOps de 25 personas con acceso a producción.

**Inyección 1:**
AWS GuardDuty detecta actividad anómala: una instancia EC2 en us-east-1 está
realizando llamadas API inusuales, incluyendo attempts de escalamiento de
privilegios IAM y acceso a buckets S3 que contienen datos de clientes.

**Inyección 2:**
Se descubre que un access key de un desarrollador fue expuesto en un repositorio
público de GitHub hace 3 meses. El key nuvo fue rotado.

**Inyección 3:**
Los atacantes crearon 5 nuevas cuentas IAM con privilegios de administrador y
lanzaron instancias EC2 para minería de criptomonedas en regiones no
autorizadas. La factura del mes muestra un incremento de 300%.

**Preguntas para discusión:**
1. ¿Cómo se revoca el acceso comprometido sin afectar operaciones?
2. ¿Qué datos fueron accedidos? ¿Aplica notificación?
3. ¿Cómo se audita todo el acceso durante el periodo de compromiso?
4. ¿Qué controles fallaron y cómo se corrigen?
5. ¿Se reporta al proveedor cloud?
```

### 7.4 Evaluación del Ejercicio

| Criterio | Ponderación | Escala |
|----------|------------|--------|
| Tiempo de detección | 15% | 1-5 |
| Calidad de la contención | 20% | 1-5 |
| Comunicación efectiva | 15% | 1-5 |
| Cumplimiento de playbooks | 15% | 1-5 |
| Coordinación entre equipos | 15% | 1-5 |
| Documentación | 10% | 1-5 |
| Decisiones de escalamiento | 10% | 1-5 |

**Escala:** 1=Deficiente, 2=Insuficiente, 3=Aceptable, 4=Bueno, 5=Excelente

**Meta:** Promedio ≥ 3.5 en todos los criterios. Criterio individual no menor a 2.5.

---

## 8. Mapeo MITRE ATT&CK

### 8.1 Tácticas Relevantes para Mid-Market México

| Táctica ID | Táctica | Descripción | Relevancia MX |
|-----------|---------|-------------|---------------|
| TA0001 | Initial Access | Primer acceso al entorno | ★★★★★ |
| TA0002 | Execution | Ejecución de código malicioso | ★★★★★ |
| TA0003 | Persistence | Mantener acceso persistente | ★★★★ |
| TA0004 | Privilege Escalation | Obtener mayores privilegios | ★★★★ |
| TA0005 | Defense Evasion | Evadir detección | ★★★★★ |
| TA0006 | Credential Access | Robar credenciales | ★★★★★ |
| TA0007 | Discovery | Descubrir el entorno | ★★★ |
| TA0008 | Lateral Movement | Moverse lateralmente | ★★★★ |
| TA0009 | Collection | Recopilar datos objetivo | ★★★★ |
| TA0010 | Exfiltration | Extraer datos | ★★★★★ |
| TA0011 | Control (C2) | Comunicación con atacantes | ★★★★★ |
| TA0040 | Impact | Impacto (ransomware, destrucción) | ★★★★★ |
| TA0043 | Reconnaissance | Reconocimiento previo | ★★★ |

### 8.2 Técnicas de Mayor Prevalencia en México

| Técnica ID | Técnica | Descripción | Detección Clave |
|-----------|---------|-------------|-----------------|
| T1566.001 | Phishing: Spearphishing Attachment | Email con adjunto malicioso | Email gateway, EDR |
| T1566.002 | Phishing: Spearphishing Link | Email con link malicioso | Proxy, DNS, Email GW |
| T1059.001 | PowerShell | Ejecución vía PowerShell | EDR, Script Block Logging |
| T1059.003 | Windows Command Shell | Ejecución vía cmd.exe | EDR, Command Line Logging |
| T1078 | Valid Accounts | Uso de cuentas legítimas | SIEM correlation, UEBA |
| T1110 | Brute Force | Fuerza bruta | SIEM, AD logs |
| T1021.001 | Remote Services: RDP | Acceso remoto vía RDP | Firewall, EDR, AD |
| T1021.002 | Remote Services: SMB/Windows Admin Shares | Acceso vía SMB | EDR, Network monitoring |
| T1486 | Data Encrypted for Impact | Ransomware | EDR, File monitoring |
| T1490 | Inhibit System Recovery | Eliminar backups/shadow copies | EDR, Windows Event Logs |
| T1053.005 | Scheduled Task | Persistencia vía tareas programadas | EDR, Windows Event Logs |
| T1547.001 | Registry Run Keys | Persistencia vía registro | EDR, Registry monitoring |
| T1003.001 | LSASS Memory | Extracción de credenciales | EDR, Credential Guard |
| T1570 | Lateral Tool Transfer | Transferencia de herramientas | Network monitoring, EDR |
| T1046 | Network Service Discovery | Escaneo de servicios | IDS/IPS, Network monitoring |

### 8.3 Mapeo de Reglas SIEM a MITRE ATT&CK

| Regla SIEM | Técnica MITRE | Táctica |
|-----------|---------------|---------|
| BRIDA-SSH-BRUTE-FORCE | T1110 | Credential Access |
| BRIDA-AFTER-HOURS-LOGIN | T1078 | Initial Access / Persistence |
| BRIDA-LATERAL-MOVEMENT | T1021.001, T1021.002 | Lateral Movement |
| BRIDA-C2-COMMUNICATION | T1071, T1572 | Command and Control |
| BRIDA-DATA-EXFILTRATION | T1041, T1048 | Exfiltration |
| BRIDA-RANSOMWARE-INDICATORS | T1486, T1490 | Impact |

---

## 9. Mapeo NIST CSF

### 9.1 Funciones y Categorías Aplicables

| Función | Categoría | Subcategoría | Aplicación SOC |
|---------|-----------|-------------|----------------|
| **IDENTIFY (ID)** | Asset Management | ID.AM-1: Inventario de dispositivos físicos | Inventario de assets monitoreados por SIEM |
| | | ID.AM-2: Inventario de software | Software permitido vs. detectado |
| | Risk Assessment | ID.RA-1: Vulnerabilidades de assets | Correlación vuln scan + SIEM |
| | | ID.RA-3: Amenazas identificadas | Threat intel integration |
| | Risk Management Strategy | ID.RM-1: Risk management processes | Proceso de gestión de riesgo de seguridad |
| **PROTECT (PR)** | Identity Management | PR.AC-1: Identidades y credenciales | Gestión de accesos, MFA |
| | | PR.AC-4: Permisos de acceso | RBAC, least privilege |
| | | PR.AC-7: Gestión de acceso remoto | VPN, Zero Trust |
| | Awareness and Training | PR.AT-1: Concientización del usuario | Training anti-phishing |
| | Data Security | PR.DS-1: Protección de datos en reposo | Encryption, DLP |
| | | PR.DS-2: Protección de datos en tránsito | TLS, VPN |
| | | PR.DS-5: Protección contra fugas | DLP, CASB |
| | Protective Technology | PR.PT-1: Registros de auditoría | Log management, SIEM |
| | | PR.PT-3: Principio de least privilege | Access control |
| **DETECT (DE)** | Anomalies and Events | DE.AE-2: Análisis de alertas | SIEM correlation |
| | | DE.AE-3: Correlación de eventos | SIEM rules |
| | | DE.AE-5-4: Alertas de incidentes | Alert triage process |
| | Security Continuous Monitoring | DE.CM-1: Monitoreo de red | IDS/IPS, NDR |
| | | DE.CM-2: Monitoreo de actividad física | Physical security |
| | | DE.CM-3: Monitoreo de actividad de personal | UEBA, insider threat |
| | | DE.CM-4: Monitoreo de código malicioso | EDR, AV |
| | | DE.CM-5-7: Monitoreo de endpoints/red/movil | EDR, NDR, MDM |
| | Detection Processes | DE.DP-1: Procesos de detección | Playbooks, runbooks |
| | | DE.DP-4: Comunicación de eventos | Escalation workflows |
| **RESPOND (RS)** | Response Planning | RS.RP-1: Ejecución del plan | Playbook execution |
| | Communications | RS.CO-1: Notificación al personal | Escalation matrix |
| | | RS.CO-2-3: Reporteo y comunicación | Incident reporting |
| | | RS.CO-4-5: Notificación a stakeholders | Regulatory notification |
| | Analysis | RS.AN-1: Investigación de alertas | Triage, investigation |
| | | RS.AN-2-3: Análisis e impacto | Impact assessment |
| | | RS.AN-4-5: IOCs y threat intel | IOC management |
| | Mitigation | RS.MI-1: Contención | Containment procedures |
| | | RS.MI-2: Erradicación | Eradication procedures |
| | | RS.MI-3: Nuevos incidentes | Lessons learned |
| **RECOVER (RC)** | Recovery Planning | RC.RP-1: Ejecución del plan de recuperación | DR/BCP execution |
| | Improvements | RC.IM-1-2: Lecciones aprendidas | Post-incident review |
| | Communications | RC.CO-1-3: Comunicación de recuperación | Stakeholder communication |

### 9.2 Mapeo de Playbooks a NIST CSF

| Playbook | NIST CSF Functions | Categorías Principales |
|----------|-------------------|----------------------|
| Ransomware | DETECT, RESPOND, RECOVER | DE.CM, RS.RP, RS.MI, RC.RP |
| BEC | DETECT, RESPOND | DE.CM, DE.AE, RS.AN, RS.MI |
| Data Exfiltration | PROTECT, DETECT, RESPOND | PR.DS, DE.CM, RS.AN, RS.MI |
| Insider Threat | PROTECT, DETECT, RESPOND | PR.AC, DE.CM, RS.AN |
| Phishing | PROTECT, DETECT, RESPOND | PR.AT, DE.CM, RS.AN |
| DDoS | DETECT, RESPOND, RECOVER | DE.CM, RS.MI, RC.RP |
| Cloud Compromise | PROTECT, DETECT, RESPOND | PR.AC, DE.CM, RS.AN, RS.MI |

---

## 10. Mapeo D3FEND

### 10.1 Técnicas D3FEND Relevantes

| Técnica D3FEND | Descripción | Contramedida Contra |
|---------------|-------------|-------------------|
| **d3f:NetworkTrafficAnalysis** | Análisis de tráfico de red | C2, Exfiltración, Movimiento Lateral |
| **d3f:ProcessAnalysis** | Análisis de procesos | Malware, Ejecución, Persistencia |
| **d3f:Authentication** | Autenticación robusta | Credential Access, Valid Accounts |
| **d3f:CredentialAccessControl** | Control de acceso a credenciales | Credential Dumping, Brute Force |
| **d3f:FileAnalysis** | Análisis de archivos | Malware, Phishing Attachments |
| **d3f:IdentifierAnalysis** | Análisis de identificadores | Spoofing, Phishing |
| **d3f:SessionAnalysis** | Análisis de sesiones | Session Hijacking, Lateral Movement |
| **d3f:UserBehaviorAnalysis** | Análisis de comportamiento | Insider Threat, Compromised Accounts |
| **d3f:PlatformMonitoring** | Monitoreo de plataforma | Defense Evasion, Persistence |
| **d3f:ExecutableDenylisting** | Lista negra de ejecutables | Malware Execution, LOLBins |
| **d3f:FileIntegrityMonitoring** | Monitoreo de integridad de archivos | Tampering, Persistence |
| **d3f:RestoreSoftware** | Restauración de software | Ransomware, Destruction |
| **d3f:RestoreData** | Restauración de datos | Ransomware, Data Destruction |
| **d3f:IsolateHost** | Aislamiento de host | Contención de amenazas |
| **d3f:DecoyEnvironment** | Entorno señuelo (honeypots) | Detección temprana, Threat Intel |

### 10.2 Mapeo D3FEND → MITRE ATT&CK

| D3FEND Technique | MITRE ATT&CK Technique | Efectividad |
|-----------------|----------------------|-------------|
| d3f:NetworkTrafficAnalysis | T1071 (C2), T1041 (Exfiltration) | Alta |
| d3f:ProcessAnalysis | T1059 (Command Execution), T1053 (Scheduled Task) | Alta |
| d3f:Authentication | T1110 (Brute Force), T1078 (Valid Accounts) | Alta |
| d3f:UserBehaviorAnalysis | T1078 (Valid Accounts), Insider Threat | Media-Alta |
| d3f:ExecutableDenylisting | T1059 (LOLBins), T1204 (User Execution) | Media |
| d3f:FileIntegrityMonitoring | T1547 (Boot/Logon Autostart), T1112 (Modify Registry) | Alta |
| d3f:IsolateHost | T1021 (Lateral Movement), T1486 (Ransomware) | Crítica |
| d3f:RestoreData | T1486 (Ransomware), T1485 (Data Destruction) | Crítica |

---

## 11. Consideraciones Regulatorias Mexicanas

### 11.1 Marco Legal Aplicable

| Ley/Regulación | Alcance | Requisito de Seguridad | Sanción |
|---------------|---------|----------------------|---------|
| **LFPDPPP** | Datos personales | Medidas de seguridad administrativas, técnicas y físicas | Multa hasta 32,000 UMAs (~$3.4M MXN) |
| **Ley General de Ciberseguridad** | En discusión | Por definir | Por definir |
| **Código Penal Federal** | Delitos informáticos | N/A (sanción por comisión de delitos) | Prisión 6 meses – 12 años |
| **Circular Única Bancaria (CNBV)** | Instituciones financieras | Controles específicos de seguridad | Sanción administrativa |
| **Disposiciones de Carácter General (Condusef)** | SOFOMES, SOFIPOS | Medidas de seguridad de la información | Sanción administrativa |
| **NOM-151-SCFI-2016** | Conservación de mensajes de datos | Respaldo y conservación de registros | Sanción administrativa |
| **PCI DSS** | Tarjetas de pago | 12 requisitos de seguridad | Multa + pérdida de capacidad de procesamiento |

### 11.2 Notificación de Brechas de Datos Personales (LFPDPPP)

**Plazo:** Sin demora indebida (no hay plazo específico, pero se recomienda ≤ 72 horas)

**Contenido de la notificación al INAI:**
1. Naturaleza del incidente
2. Datos personales comprometidos
3. Medidas correctivas implementadas
4. Medidas preventivas para evitar recurrencia
5. Mecanismos para que los titulares ejerzan sus derechos ARCO

**Notificación a titulares:**
1. Naturaleza del incidente
2. Datos personales comprometidos
3. Recomendaciones de protección al titular
4. Medidas correctivas inmediatas
5. Donde pueden obtener más información

### 11.3 Delitos Cibernéticos (Código Penal Federal)

| Artículo | Delito | Pena |
|----------|--------|------|
| 211 bis | Acceso ilícito a sistemas | 6 meses – 2 años |
| 211 bis 1 | Acceso ilícito a sistemas protegidos | 1 – 4 años |
| 211 bis 2 | Interceptación de comunicaciones | 3 – 12 años |
| 211 bis 4 | Sabotaje informático | 2 – 8 años |
| 211 bis 5 | Fraude informático | 6 meses – 4 años |

---

## 12. Métricas y KPIs del SOC

### 12.1 Métricas Operativas

| Métrica | Descripción | Meta | Frecuencia |
|---------|-------------|------|-----------|
| **MTTD** (Mean Time to Detect) | Tiempo promedio de detección | < 24 horas | Mensual |
| **MTTR** (Mean Time to Respond) | Tiempo promedio de respuesta | < 4 horas (P1) | Mensual |
| **MTTC** (Mean Time to Contain) | Tiempo promedio de contención | < 8 horas (P1) | Mensual |
| **Alert Volume** | Volumen de alertas por día | Tendencia estable o decreciente | Diario |
| **False Positive Rate** | Tasa de falsos positivos | < 15% | Semanal |
| **True Positive Rate** | Tasa de verdaderos positivos | > 85% | Semanal |
| **Escalation Rate** | % de alertas escaladas a L2/L3 | 10-25% | Semanal |
| **Ticket Backlog** | Tickets pendientes | < 20% del volumen semanal | Diario |
| **SLA Compliance** | Cumplimiento de tiempos de respuesta | > 95% | Mensual |
| **Coverage** | % de assets cubiertos por monitoreo | > 90% | Mensual |

### 12.2 Métricas de Madurez

| Nivel | Descripción | Características |
|-------|-------------|-----------------|
| **1 — Inicial** | Ad-hoc, reactivo | Sin procesos formales, respuesta improvisada |
| **2 — Desarrollando** | Procesos básicos | Playbooks básicos, SIEM en operación, triage manual |
| **3 — Definido** | Procesos documentados | Playbooks completos, métricas definidas, automatización parcial |
| **4 — Gestionado** | Medible y controlado | KPIs en tiempo real, SOAR implementado, threat hunting activo |
| **5 — Optimizado** | Mejora continua | ML/AI en detecciones, purple teaming, inteligencia predictiva |

**Meta para mid-market mexicano:** Alcanzar Nivel 3 en 12 meses, Nivel 4 en 24 meses.

### 12.3 Dashboard Ejecutivo

```
┌─────────────────────────────────────────────────────────────┐
│              SOC DASHBOARD — BRIDA IT SERVICES               │
│                    Período: [Mes/Año]                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ALERTAS              INCIDENTES           SLA              │
│  ┌──────────┐        ┌──────────┐        ┌──────────┐      │
│  │  1,247   │        │   23     │        │  96.2%   │      │
│  │  total   │        │  activos │        │cumplido  │      │
│  └──────────┘        └──────────┘        └──────────┘      │
│                                                             │
│  TIEMPOS PROMEDIO          TASA FP        COBERTURA        │
│  ┌──────────┐             ┌──────────┐   ┌──────────┐     │
│  │MTTD: 4h  │             │  12.3%   │   │  94%     │     │
│  │MTTR: 2h  │             │          │   │          │     │
│  │MTTC: 6h  │             │          │   │          │     │
│  └──────────┘             └──────────┘   └──────────┘     │
│                                                             │
│  TOP 5 ALERTAS                    TOP MITRE ATT&CK          │
│  1. Phishing (342)                1. T1566 (Phishing)      │
│  2. Malware (187)                 2. T1059 (PowerShell)    │
│  3. Brute Force (156)             3. T1110 (Brute Force)   │
│  4. Anomalía Login (98)           4. T1078 (Valid Accts)   │
│  5. DLP Violation (67)            5. T1486 (Ransomware)    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 13. Herramientas Recomendadas

### 13.1 Stack de Seguridad para Mid-Market México

| Categoría | Herramienta | Alternativa | Presupuesto Estimado (MXN/año) |
|-----------|------------|-------------|-------------------------------|
| **SIEM** | Microsoft Sentinel | Elastic Security | $150K–$500K |
| **EDR** | CrowdStrike Falcon | Microsoft Defender for Endpoint | $200–$600/endpoint |
| **Email Security** | Proofpoint | Mimecast | $50–$150/usuario |
| **NDR** | Darktrace | Vectra AI | $200K–$500K |
| **SOAR** | Palo Alto XSOAR | Splunk SOAR | $100K–$300K |
| **Threat Intel** | Recorded Future | Anomali | $50K–$200K |
| **Vulnerability Mgmt** | Tenable.io | Qualys | $50K–$150K |
| **IAM / PAM** | CyberArk | BeyondTrust | $100K–$300K |
| **DLP** | Symantec DLP | Microsoft Purview | $50K–$200K |
| **Ticketing** | ServiceNow | Jira Service Management | $50K–$150K |
| **GRC** | Archer | ServiceNow GRC | $100K–$300K |
| **Forensics** | Magnet AXIOM | Autopsy (open source) | $30K–$100K |

### 13.2 Herramientas Open Source Recomendadas

| Herramienta | Uso | Notas |
|------------|-----|-------|
| **Wazuh** | SIEM + EDR + Compliance | Excelente para presupuestos limitados |
| **TheHive** | Incident Response Platform | Integración con MISP |
| **MISP** | Threat Intelligence Sharing | Estándar de la industria |
| **Cortex** | Observable Analysis | Complemento de TheHive |
| **Velociraptor** | DFIR y endpoint visibility | Análisis forense avanzado |
| **Snort/Suricata** | IDS/IPS | Detección de intrusión en red |
| **OSSEC** | HIDS | Detección de intrusión en host |
| **OpenVAS** | Vulnerability Scanner | Escaneo de vulnerabilidades |
| **Grafana** | Dashboards | Visualización de métricas |
| **Shuffle** | SOAR (open source) | Orquestación y automatización |

---

## 14. Plantillas y Quick References

### 14.1 Quick Reference: Comandos de Investigación

#### Windows (PowerShell)

```powershell
# Procesos en ejecución con conexiones de red
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"} |
    Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess,
    @{Name="ProcessName";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}}

# Eventos de seguridad recientes (últimas 24h)
Get-WinEvent -FilterHashtable @{LogName='Security'; Level=1,2,3; StartTime=(Get-Date).AddHours(-24)} |
    Select-Object TimeCreated, Id, LevelDisplayName, Message | Format-List

# Usuarios con sesión activa
quser

# Tareas programadas sospechosas
Get-ScheduledTask | Where-Object {$_.State -eq "Ready"} |
    Select-Object TaskName, TaskPath, @{Name="Action";Expression={(Get-ScheduledTaskInfo $_).LastRunTime}}

# Conexiones SMB activas
Get-SmbConnection

# DNS cache (buscar dominios sospechosos)
Get-DnsClientCache | Where-Object {$_.Entry -match "\.xyz$|\.top$|\.buzz$|\.club$"} |
    Select-Object Entry, Data
```

#### Linux

```bash
# Conexiones de red activas
ss -tulnp

# Procesos en ejecución con detalles
ps aux --sort=-%mem | head -20

# Últimos logins
last -a | head -20

# Intentos fallidos de SSH
grep "Failed password" /var/log/auth.log | tail -50

# Archivos modificados recientemente (última hora)
find / -type f -mmin -60 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null

# Crontabs de todos los usuarios
for user in $(cut -f1 -d: /etc/passwd); do echo "=== $user ==="; crontab -u $user -l 2>/dev/null; done

# Archivos SUID/SGID (posible escalamiento)
find / -perm /6000 -type f 2>/dev/null

# Historial de comandos de todos los usuarios
for user in $(cut -f1 -d: /etc/passwd); do
    home=$(eval echo "~${user}")
    if [ -f "$home/.bash_history" ]; then
        echo "=== $user ==="
        tail -20 "$home/.bash_history"
    fi
done
```

### 14.2 Quick Reference: IOC Types

| Tipo IOC | Formato Ejemplo | Herramienta de Búsqueda |
|---------|----------------|------------------------|
| MD5 Hash | `d41d8cd98f00b204e9800998ecf8427e` | VirusTotal |
| SHA256 Hash | `e3b0c44298fc1c149afbf4c8996fb924...` | VirusTotal |
| IP Address | `203.0.113.50` | VirusTotal, AbuseIPDB |
| Domain | `malware-c2.evil.com` | VirusTotal, PassiveDNS |
| URL | `http://evil.com/payload.exe` | VirusTotal, URLhaus |
| Email | `attacker@evil.com` | Have I Been Pwned |
| CVE | `CVE-2024-XXXX` | NVD, MITRE |
| YARA Rule | `rule example { ... }` | YARA Scanner |
| Mutex | `Global\MalwareMutex123` | EDR, Memory Analysis |
| Registry Key | `HKCU\Software\Malware` | EDR, Forensic Tools |

### 14.3 Quick Reference: Severidad y Tiempos

```
┌──────────────────────────────────────────────────────────────┐
│  SEVERIDAD  │  RESPUESTA  │  CONTENCIÓN  │  RESOLUCIÓN     │
├──────────────────────────────────────────────────────────────┤
│  P1 CRIT    │  ≤ 15 min   │  ≤ 1 hora    │  ≤ 4 horas      │
│  P2 HIGH    │  ≤ 30 min   │  ≤ 2 horas   │  ≤ 8 horas      │
│  P3 MED     │  ≤ 2 horas  │  ≤ 8 horas   │  ≤ 24 horas     │
│  P4 LOW     │  ≤ 8 horas  │  ≤ 24 horas  │  ≤ 72 horas     │
│  P5 INFO    │  ≤ 24 horas │  N/A         │  ≤ 1 semana     │
└──────────────────────────────────────────────────────────────┘
```

### 14.4 Quick Reference: Contactos de Emergencia

```
┌──────────────────────────────────────────────────────────────┐
│           CONTACTOS DE EMERGENCIA — BRIDA IT SERVICES        │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  SOC Hotline (24/7):    +52-XX-XXXX-XXXX                    │
│  SOC Email:             soc@brida.com.mx                     │
│  SOC Slack:             #soc-critical                        │
│                                                              │
│  CISO:                  [Nombre] — +52-XX-XXXX-XXXX          │
│  SOC Manager:           [Nombre] — +52-XX-XXXX-XXXX          │
│  Legal (Ciber):         [Nombre] — +52-XX-XXXX-XXXX          │
│                                                              │
│  MSSP (si aplica):      [Proveedor] — +1-XXX-XXX-XXXX       │
│  Aseguradora Cyber:     [Proveedor] — +1-XXX-XXX-XXXX       │
│                                                              │
│  Policía Cibernética:   088 (emergencias)                    │
│  CERT-MX:               certmx@seguridad.gob.mx              │
│  INAI:                  www.inai.org.mx                      │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### 14.5 Quick Reference: Kill Chain Mapping

```
┌─────────┐   ┌──────────┐   ┌────────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│ RECON   │──▶│ WEAPONIZE│──▶│  DELIVER   │──▶│ EXPLOIT  │──▶│ INSTALL  │──▶│   C2     │──▶│ ACTIONS  │
│         │   │          │   │            │   │          │   │          │   │          │   │ ON OBJ   │
└─────────┘   └──────────┘   └────────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
  T1595        T1587          T1566            T1190          T1053          T1071          T1486
  T1590        T1588          T1195            T1203          T1547          T1572          T1041
  T1589                       T1204            T1133          T1059          T1105          T1565
                                                                                              T1499

  ◄── DETECTAR EN ESTA FASE ES ÓPTIMO ──►
  ◄── DETECTAR EN ESTA FASE ES ACEPTABLE ──►
  ◄── DETECTAR EN ESTA FASE ES TARDÍO ──►
```

---

## Apéndice A: Glosario

| Término (EN) | Término (ES) | Definición |
|-------------|-------------|------------|
| Alert | Alerta | Notificación generada por un sistema de seguridad |
| Breach | Brecha / Incidente | Violación confirmada de la seguridad |
| Containment | Contención | Acciones para limitar el impacto de un incidente |
| EDR | Detección y Respuesta en Endpoint | Herramienta de seguridad para endpoints |
| Escalation | Escalamiento | Transferencia de un incidente a un nivel superior |
| Exfiltration | Exfiltración | Transferencia no autorizada de datos |
| False Positive | Falso Positiva | Alerta que no corresponde a una amenaza real |
| IOC | Indicador de Compromiso | Evidencia de un compromiso de seguridad |
| IR | Respuesta a Incidentes | Proceso de manejo de incidentes de seguridad |
| MITRE ATT&CK | MITRE ATT&CK | Framework de tácticas y técnicas de adversarios |
| NIST CSF | NIST CSF | Framework de ciberseguridad del NIST |
| Playbook | Playbook | Procedimiento documentado para respuesta a incidentes |
| SIEM | SIEM | Gestión de Eventos e Información de Seguridad |
| SOC | SOC | Centro de Operaciones de Seguridad |
| Tabletop | Ejercicio Tabletop | Simulación de discusión de un incidente |
| Threat Hunt | Caza de Amenazas | Búsqueda proactiva de amenazas |
| Triage | Triaje | Proceso de clasificación y priorización de alertas |
| True Positive | Verdadera Positiva | Alerta que corresponde a una amenaza real |

---

## Apéndice B: Referencias

1. **MITRE ATT&CK Framework** — https://attack.mitre.org
2. **NIST Cybersecurity Framework 2.0** — https://www.nist.gov/cyberframework
3. **MITRE D3FEND** — https://d3fend.mitre.org
4. **CISA Cybersecurity Advisories** — https://www.cisa.gov/news-events/cybersecurity-advisories
5. **CSIRT México** — https://www.gob.mx/seguridad/acciones-y-programas/computer-security-incident-response-team-mexico
6. **LFPDPPP** — Ley Federal de Protección de Datos Personales en Posesión de los Particulares
7. **SANS Incident Handler's Handbook** — https://www.sans.org/white-papers/33901
8. **NIST SP 800-61 Rev. 2** — Computer Security Incident Handling Guide
9. **ISO/IEC 27001:2022** — Information Security Management Systems
10. **PCI DSS v4.0** — Payment Card Industry Data Security Standard

---

*Documento propiedad de BRIDA IT Services. Clasificación: Uso Interno.*
*Última actualización: 2026-06-16. Versión 1.0.0*
*Para preguntas o actualizaciones contactar: soc@brida.com.mx*
