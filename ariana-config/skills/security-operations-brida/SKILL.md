---
name: security-operations-brida
description: 'Security Operations (SecOps) and SOC operations for BRIDA IT Services
  clients. Covers SIEM correlation, log analysis, alert triage, escalation workflows,
  playbook development, and tabletop exercises. Adapted for mid-market Mexican enterprises.
  Activates for: SIEM operations, security monitoring, alert triage, SOC setup, log
  analysis, security operations center.'
domain: cybersecurity
subdomain: security-operations
tags:
- security-operations
- SIEM
- SOC
- alert-triage
- log-analysis
- monitoring
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- DE.AE-02
- DE.CM-01
- DE.DP-01
- RS.AN-03
mitre_attack:
- T1071
- T1059
- T1078
- T1021
category: cybersecurity
---

# Security Operations (SecOps) — BRIDA IT Services

## Descripción
Operaciones de seguridad y SOC para clientes de BRIDA IT Services. Cubre correlación SIEM, análisis de logs, triaje de alertas, workflows de escalamiento, playbooks y ejercicios tabletop.

## Cuándo Usar
- Diseño o mejora de un Centro de Operaciones de Seguridad (SOC)
- Creación de playbooks de respuesta a incidentes
- Implementación/regla de correlación SIEM
- Ejercicios de simulación (tableteam/tabletop)
- Onboarding de fuentes de log

## Componentes del SOC

### 1. SIEM (Security Information and Event Management)
**Herramientas recomendadas por stack BRIDA:**
| Herramienta | Tipo | Caso de Uso |
|---|---|---|
| Splunk Enterprise | Comercial | Enterprise SIEM, correlation rules |
| Microsoft Sentinel | Cloud | Azure-native SIEM |
| Elastic SIEM (ELK) | Open/Commercial | Log analysis, dashboards |
| Wazuh | Open Source | SIEM + HIDS, budget-friendly |
| Splunk SOAR | Comercial | SOAR, automated response |

### 2. EDR/XDR Integration
- CrowdStrike Falcon → SIEM integration
- Trellix ePO → SIEM correlation
- Windows Event Log → Forwarding al SIEM

### 3. Fuentes de Log Críticas
```
Prioridad CRÍTICA:
- Firewall logs (FortiGate)
- Authentication logs (AD, VPN)
- Email gateway logs (Google Workspace)
- EDR alerts (CrowdStrike/Trellix)
- DNS logs
- Web proxy/CDN logs (Cloudflare)

Prioridad ALTA:
- Application logs
- Database audit logs
- Cloud service logs (AWS CloudTrail)
- Endpoint logs (Windows Event Log)
- Network flow data (NetFlow/sFlow)

Prioridad MEDIA:
- Printer logs
- Badge access logs
- DHCP logs
```

## Proceso de Triage de Alertas

### Nivel 1: Automated Triage
```
Alerta generada → Enriquecimiento automático:
  - IP reputation check (VirusTotal, AbuseIPDB)
  - Domain reputation check
  - User context (HR data, role, department)
  - Asset context (criticality, OS, owner)
  - Historical context (past alerts, patterns)
```

### Nivel 2: Analyst Review (Tier 1)
```
Verificar:
  1. ¿Es un falso positivo? → Cerrar con justificación
  2. ¿Es una actividad legítima sospechosa? → Escalar a Tier 2
  3. ¿Es un incidente confirmado? → Iniciar IR playbook
  4. ¿Requiere más información? → Pausar, solicitar datos
```

### Nivel 3: Deep Investigation (Tier 2)
```
Análisis profundo:
  - Timeline reconstruction
  - Lateral movement detection
  - Data exfiltration assessment
  - Scope determination
  - MITRE ATT&CK mapping
```

### Nivel 4: Incident Commander (Tier 3)
```
Gestión del incidente:
  - Declaración formal de incidente
  - Comunicación a stakeholders
  - Coordinación de contención
  - Forensics
  - Recuperación
  - Lessons learned
```

## SIEM Correlation Rules — Ejemplos

### Detección de Brute Force
```spl
# Splunk SPL
index=auth action=failed
| stats count by src_ip, user, _time
| where count > 5
| sort -count
```

### Detección de Lateral Movement
```spl
index=windows EventCode=4624 LogonType=3
| stats dc(src_ip) as unique_sources by user
| where unique_sources > 3
```

### Detección de Data Exfiltration
```spl
index=proxy bytes_out > 104857600
| stats sum(bytes_out) as total_bytes by src_ip, user
| where total_bytes > 1073741824
```

### Detección de PowerShell Malicioso
```spl
index=windows EventCode=4104
| search ScriptBlockText="*Invoke-* OR *DownloadString* OR *-enc *"
| stats count by ComputerName, user, ScriptBlockText
```

## Playbooks Esenciales

### Playbook: Phishing Detected
```
1. Identificar el correo malicioso (headers, URLs, attachments)
2. Determinar el alcance (¿quién lo recibió? ¿quién hizo clic?)
3. Contener: bloquear URL/dominio en proxy/firewall
4. Eliminar: quitar el correo de todos los inboxes
5. Investigar: ¿se ejecutó payload? ¿se robaron credenciales?
6. Comunicar: notificar a usuarios afectados
7. Documentar: lecciones aprendidas
```

### Playbook: Malware Detected
```
1. Aislar el endpoint (deshabilitar red, EDR quarantine)
2. Identificar el malware (hash, familia, comportamiento)
3. Buscar indicadores de compromiso (IoCs) en toda la red
4. Determinar el alcance (¿otros endpoints afectados?)
5. Erradicar: limpieza completa o reimagen
6. Recuperar: restaurar desde backup si es necesario
7. Verificar: confirmar limpieza con escaneo completo
```

### Playbook: Unauthorized Access
```
1. Deshabilitar la cuenta comprometida
2. Revisar logs de actividad de la cuenta
3. Identificar recursos accedidos
4. Determinar si hubo exfiltración de datos
5. Resetear credenciales de todas las cuentas relacionadas
6. Habilitar MFA si no estaba activo
7. Investigar origen del acceso no autorizado
```

## KPIs del SOC
| KPI | Meta | Descripción |
|---|---|---|
| MTTD | < 30 min | Mean Time to Detect |
| MTTR | < 4 hours | Mean Time to Respond |
| Alert Triage Time | < 15 min | Tiempo de triaje por alerta |
| False Positive Rate | < 20% | Tasa de falsos positivos |
| Escalation Accuracy | > 85% | Precisión de escalamiento |
| Playbook Coverage | > 80% | % de escenarios con playbook |

## Ejercicios Tabletop
Frecuencia recomendada: Trimestral

Escenarios para Grupo Pepe:
1. Ransomware en el corporativo → ¿Cómo responden?
2. Compromiso de credenciales del CIO → ¿Detectan BEC?
3. Filtración de datos de clientes → ¿Notificación a usuarios?
4. Ataque DDoS durante promoción → ¿Continuidad del e-commerce?
5. Empleado descontento roba datos → ¿Detectan insider threat?
