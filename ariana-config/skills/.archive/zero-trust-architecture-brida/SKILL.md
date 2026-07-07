---
name: "Zero Trust Architecture - BRIDA IT Services"
description: "Modelo integral de Arquitectura Zero Trust para BRIDA IT Services basado en FortiSASE y el Modelo de Madurez Zero Trust de CISA. Cubre principios ZTNA, verificación de identidad, confianza de dispositivos, segmentación de red, acceso a aplicaciones, protección de datos, monitoreo continuo y hoja de ruta de implementación. Incluye mapeo a MITRE ATT&CK, NIST CSF y D3FEND."
triggers:
  - "zero trust"
  - "ztna"
  - "fortisase"
  - "cisa zero trust"
  - "arquitectura zero trust"
  - "brida zero trust"
  - "segmentación de red"
  - "acceso seguro"
  - "verificación de identidad"
  - "confianza de dispositivo"
  - "protección de datos"
  - "monitoreo continuo"
  - "sase"
  - "perímetro definido por software"
  - "sdp"
  - "microsegmentación"
category: "cybersecurity"
---

# Zero Trust Architecture - BRIDA IT Services

## Descripción General

Este skill proporciona una guía completa para diseñar, implementar y operar una arquitectura **Zero Trust** en BRIDA IT Services, utilizando **FortiSASE** como plataforma principal y alineada con el **CISA Zero Trust Maturity Model (ZTMM)**.

> **Principio fundamental:** "Nunca confiar, siempre verificar" (*Never Trust, Always Verify*). Cada solicitud de acceso — sin importar su origen — se autentica, autoriza y cifra antes de otorgar acceso.

---

## 1. Principios Fundamentales de ZTNA

### 1.1 Definición de ZTNA

**Zero Trust Network Access (ZTNA)** reemplaza el modelo tradicional de perímetro de red con un enfoque donde:

- **Ningún usuario, dispositivo o aplicación es inherentemente confiable.**
- **Cada solicitud de acceso se evalúa en tiempo real** basándose en múltiples señales de contexto.
- **El acceso se otorga con privilegios mínimos** (least privilege) y solo al recurso específico solicitado.
- **Todo el tráfico se registra y analiza** para detección de anomalías.

### 1.2 Pilares de la Arquitectura Zero Trust

| Pilar | Descripción | Implementación FortiSASE |
|-------|-------------|--------------------------|
| **Identidad** | Verificación continua de usuarios y servicios | FortiGate + FortiAuthenticator + SAML/OIDC |
| **Dispositivos** | Evaluación de postura de seguridad de endpoints | FortiClient EMS + FortiSASE endpoint profiling |
| **Red** | Microsegmentación y cifrado de tráfico | FortiSASE SASE fabric + IPsec/SSL VPN |
| **Aplicaciones** | Acceso granular a aplicaciones, no a la red | FortiSASE ZTNA reverse proxy + FortiGate firewall policies |
| **Datos** | Clasificación, DLP y cifrado de datos | FortiSASE DLP + FortiGuard content inspection |

### 1.3 Modelo de Madurez CISA ZTMM

El **CISA Zero Trust Maturity Model** define cinco niveles de madurez:

```
┌─────────────────────────────────────────────────────────┐
│  Nivel 5: ADAPTIVE                                      │
│  → Políticas dinámicas basadas en IA/ML, respuesta     │
│    automatizada en tiempo real                          │
├─────────────────────────────────────────────────────────┤
│  Nivel 4: INITIAL                                       │
│  → Automatización parcial, análisis centralizado,      │
│    políticas basadas en riesgo contextual               │
├─────────────────────────────────────────────────────────┤
│  Nivel 3: ADVANCED                                      │
│  → Automatización completa, orquestación de            │
│    políticas, visibilidad integral                      │
├─────────────────────────────────────────────────────────┤
│  Nivel 2: INTERMEDIATE                                  │
│  → Controles ZTNA implementados, MFA obligatorio,      │
│    segmentación básica                                  │
├─────────────────────────────────────────────────────────┤
│  Nivel 1: TRADITIONAL                                   │
│  → Modelo perimetral, controles básicos,                │
│    autenticación de un solo factor                     │
└─────────────────────────────────────────────────────────┘
```

**Meta de BRIDA IT Services:** Alcanzar el **Nivel 3 (Advanced)** en 18 meses y **Nivel 4 (Initial)** en 36 meses.

---

## 2. Verificación de Identidad

### 2.1 Estrategia de Identidad Zero Trust

La identidad es el **nuevo perímetro**. En FortiSASE, la verificación de identidad se implementa mediante:

#### 2.1.1 Autenticación Multifactor (MFA)

```yaml
# Configuración MFA en FortiAuthenticator
mfa_policy:
  name: "BRIDA-MFA-Policy"
  methods:
    primary: "LDAP/Active Directory"
    secondary: "FortiToken (TOTP/HOTP)"
    tertiary: "Push notification via FortiToken Mobile"
  conditions:
    - all_users: true
    - all_applications: true
    - risk_based_step_up: true  # MFA adicional para accesos de alto riesgo
  session:
    timeout: 8h
    re_auth_on_privilege_escalation: true
    continuous_authentication: true
```

#### 2.1.2 Single Sign-On (SSO) Federado

- **Protocolos soportados:** SAML 2.0, OAuth 2.0, OpenID Connect
- **Integración con IdP:** Azure AD, Okta, Google Workspace, ADFS
- **Just-in-Time (JIT) provisioning:** Creación automática de cuentas basada en atributos federados

#### 2.1.3 Evaluación de Riesgo de Identidad (Identity Risk Score)

| Señal de Riesgo | Peso | Acción |
|-----------------|------|--------|
| Ubicación geográfica inusual | Alto | Bloquear o step-up auth |
| Horario de acceso atípico | Medio | Step-up auth |
| Nuevo dispositivo | Medio | Registro + verificación |
| Credenciales en dark web | Crítico | Bloqueo inmediato |
| Velocidad de viaje imposible | Alto | Bloqueo inmediato |
| Patrón de acceso anómalo | Alto | Alerta + revisión |

### 2.2 Gestión de Acceso Privilegiado (PAM)

- **Principio de mínimo privilegio:** Los usuarios solo obtienen los permisos estrictamente necesarios.
- **Privileged Access Workstations (PAW):** Estaciones dedicadas para tareas administrativas.
- **Time-bound access:** Accesos privilegiados con límite temporal.
- **Session recording:** Grabación de sesiones privilegiadas para auditoría.

---

## 3. Confianza de Dispositivos (Device Trust)

### 3.1 Evaluación de Postura del Endpoint

FortiSASE evalúa la **confianza del dispositivo** antes y durante la sesión mediante **FortiClient EMS**:

```yaml
# Perfil de evaluación de postura del dispositivo
device_trust_profile:
  name: "BRIDA-Device-Trust"
  checks:
    os_version:
      require_patches: true
      max_days_since_update: 30
      supported_os:
        - "Windows 10/11 (latest 2 versions)"
        - "macOS (latest 2 versions)"
        - "iOS (latest 2 versions)"
        - "Android (latest 2 versions)"
    antivirus:
      required: true
      engines: ["FortiClient", "CrowdStrike", "Microsoft Defender"]
      real_time_protection: true
      signature_age_max_hours: 24
    disk_encryption:
      required: true
      type: "BitLocker / FileVault"
    firewall:
      required: true
      status: "enabled"
    certificate:
      required: true
      type: "device certificate from BRIDA-CA"
    jailbreak_rooted:
      action: "block"
    prohibited_applications:
      action: "block"
      list: ["tor", "unauthorized_vpn", "remote_access_tools"]
  risk_levels:
    compliant: "full_access"
    minor_violation: "restricted_access"
    major_violation: "quarantine"
    non_compliant: "block"
```

### 3.2 Endpoint Detection and Response (EDR)

- **FortiEDR** integrado para detección avanzada de amenazas en endpoints.
- **Respuesta automatizada:** Aislamiento automático de dispositivos comprometidos.
- **Threat hunting proactivo:** Búsqueda continua de indicadores de compromiso (IoCs).

### 3.3 Gestión Unificada de Endpoints (UEM)

- **Inscripción automática** de dispositivos corporativos.
- **Aplicación remota de políticas** de seguridad.
- **Inventario completo** de activos con visibilidad en tiempo real.
- **Borrado remoto** de dispositivos perdidos o robados.

---

## 4. Segmentación de Red

### 4.1 Microsegmentación con FortiSASE

La **microsegmentación** divide la red en zonas de confianza granular, limitando el movimiento lateral:

```
┌──────────────────────────────────────────────────────────────┐
│                    FORTI SASE FABRIC                         │
│                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ │
│  │  Zona:      │  │  Zona:      │  │  Zona:              │ │
│  │  Servidores │  │  Estaciones │  │  IoT/OT             │ │
│  │  Críticos   │  │  de Trabajo │  │  Dispositivos       │ │
│  │             │  │             │  │                     │ │
│  │  - BBDD     │  │  - Windows  │  │  - Cámaras          │ │
│  │  - AD       │  │  - macOS    │  │  - Sensores         │ │
│  │  - ERP      │  │  - Linux    │  │  - PLCs             │ │
│  └──────┬──────┘  └──────┬──────┘  └──────────┬──────────┘ │
│         │                │                     │            │
│         └────────────────┼─────────────────────┘            │
│                          │                                  │
│              ┌───────────▼───────────┐                      │
│              │   FortiGate Policies  │                      │
│              │   (Inspección L7)     │                      │
│              └───────────────────────┘                      │
└──────────────────────────────────────────────────────────────┘
```

### 4.2 Políticas de Segmentación

```yaml
# Política de microsegmentación BRIDA
segmentation_policies:
  - name: "BBDD-Access"
    source: "Zona-Estaciones-Trabajo"
    destination: "Zona-Servidores-Criticos"
    service: "MSSQL(1433), Oracle(1521)"
    action: "allow"
    inspection: "deep-inspection"
    logging: true
    conditions:
      - device_trust_level: "compliant"
      - user_group: "DB-Admins"
      - mfa_verified: true

  - name: "Deny-Lateral-Movement"
    source: "any"
    destination: "any"
    service: "any"
    action: "deny"
    conditions:
      - same_zone: false
      - no_business_justification: true
    logging: true

  - name: "IoT-Restricted"
    source: "Zona-IoT"
    destination: "Zona-Servidores-Criticos"
    service: "any"
    action: "deny"
    logging: true
```

### 4.3 Secure SD-WAN Integration

- **Túneles cifrados** entre sedes de BRIDA IT Services mediante **IPsec/SSL VPN**.
- **Aplicación de políticas consistentes** en todas las ubicaciones.
- **Optimización de tráfico** con steering inteligente basado en aplicación.
- **Redundancia** con enlaces múltiples (MPLS, broadband, 4G/5G).

---

## 5. Acceso a Aplicaciones

### 5.1 ZTNA Reverse Proxy

FortiSASE proporciona acceso seguro a aplicaciones sin exponerlas a internet:

```yaml
# Configuración ZTNA para aplicaciones BRIDA
ztna_application_access:
  - name: "ERP-BRIDA"
    type: "web-app"
    url_internal: "https://erp.internal.brida.com"
    url_external: "https://erp.brida.com"
    access_policy:
      authentication: "saml_sso"
      mfa_required: true
      device_trust_required: true
      allowed_groups: ["ERP-Users", "Finance-Team"]
      session_timeout: 4h
      clipboard_control: "disabled"
      download_policy: "watermarked_only"
      browser_isolation: true

  - name: "SSH-Servers"
    type: "tcp_forwarding"
    destination: "10.0.1.0/24"
    port: 22
    access_policy:
      authentication: "ldap"
      mfa_required: true
      device_trust_required: true
      allowed_groups: ["SysAdmins"]
      session_recording: true
      command_filtering: true

  - name: "RDP-Remote"
    type: "rdp"
    destination: "rdp.internal.brida.com"
    access_policy:
      authentication: "saml_sso"
      mfa_required: true
      device_trust_required: true
      allowed_groups: ["IT-Support"]
      session_recording: true
      drive_mapping: "disabled"
```

### 5.2 Acceso a Aplicaciones SaaS

- **CASB (Cloud Access Security Broker):** Inspección de tráfico SaaS (Microsoft 365, Google Workspace, Salesforce, etc.).
- **Shadow IT discovery:** Identificación de aplicaciones SaaS no autorizadas.
- **DLP en la nube:** Prevención de fuga de datos en aplicaciones SaaS.
- **Tenant restrictions:** Limitación de acceso solo a tenants corporativos autorizados.

### 5.3 Acceso a Infraestructura Cloud

- **Cloud Security Posture Management (CSPM):** Evaluación continua de la postura de seguridad en AWS, Azure, GCP.
- **Cloud Workload Protection:** Protección de cargas de trabajo en contenedores y máquinas virtuales.
- **Infrastructure as Code (IaC) scanning:** Análisis de seguridad en Terraform, CloudFormation antes del despliegue.

---

## 6. Protección de Datos

### 6.1 Clasificación de Datos

| Nivel | Descripción | Ejemplos BRIDA | Controles |
|-------|-------------|----------------|-----------|
| **Público** | Información disponible públicamente | Website, marketing | Cifrado en tránsito |
| **Interno** | Uso interno de la organización | Manuales, políticas internas | Cifrado en tránsito y reposo |
| **Confidencial** | Datos sensibles de negocio | Contratos, financieros | Cifrado + DLP + acceso controlado |
| **Restringido** | Datos críticos regulados | PII, PCI, HIPAA | Cifrado + DLP + acceso estricto + auditoría |

### 6.2 Prevención de Fuga de Datos (DLP)

```yaml
# Política DLP para BRIDA IT Services
dlp_policies:
  - name: "BRIDA-DLP-Confidential"
    description: "Protección de datos confidenciales"
    rules:
      - pattern: "credit_card_numbers"
        action: "block"
        alert: true
      - pattern: "social_security_numbers"
        action: "block"
        alert: true
      - pattern: "proprietary_documents"
        watermark: true
        encrypt: true
      - pattern: "source_code"
        action: "allow"
        log: true
        conditions:
          - destination: "approved_repos_only"
    channels:
      - email
      - web_upload
      - cloud_storage
      - usb
      - print
      - clipboard
```

### 6.3 Cifrado

- **En tránsito:** TLS 1.3 para todo el tráfico, IPsec para túneles site-to-site.
- **En reposo:** AES-256 para bases de datos, discos y backups.
- **En uso:** Confidential Computing donde esté disponible.
- **Gestión de claves:** HSM (Hardware Security Module) para almacenamiento seguro de claves.

### 6.4 Data Loss Prevention en FortiSASE

- **Inspección SSL/TLS:** Descifrado e inspección del tráfico cifrado para detección de DLP.
- **Fingerprinting de datos:** Identificación de documentos sensibles mediante huella digital.
- **OCR:** Reconocimiento óptico de caracteres para detectar datos sensibles en imágenes.

---

## 7. Monitoreo Continuo

### 7.1 Arquitectura de Monitoreo

```
┌──────────────────────────────────────────────────────────────┐
│                 MONITOREO CONTINUO ZERO TRUST                │
│                                                              │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐ │
│  │ FortiSIEM  │  │ FortiAnalyzer│ │ FortiSASE Analytics   │ │
│  │            │  │             │  │                        │ │
│  │ - Correlac.│  │ - Logs      │  │ - User behavior        │ │
│  │ - Alertas  │  │ - Reportes  │  │ - Device trust         │ │
│  │ - Dashb.   │  │ - Compliance│  │ - Network analytics    │ │
│  └──────┬─────┘  └──────┬──────┘  └──────────┬─────────────┘ │
│         │               │                     │              │
│         └───────────────┼─────────────────────┘              │
│                         │                                    │
│              ┌──────────▼──────────┐                         │
│              │   SOC BRIDA IT      │                         │
│              │   (Security Ops)    │                         │
│              │                     │                         │
│              │ - 24/7 Monitoring   │                         │
│              │ - Incident Response │                         │
│              │ - Threat Hunting    │                         │
│              └─────────────────────┘                         │
└──────────────────────────────────────────────────────────────┘
```

### 7.2 Métricas Clave de Seguridad (KPIs)

| Métrica | Descripción | Objetivo |
|---------|-------------|----------|
| **MTTD** (Mean Time to Detect) | Tiempo promedio de detección de incidentes | < 1 hora |
| **MTTR** (Mean Time to Respond) | Tiempo promedio de respuesta a incidentes | < 4 horas |
| **Device Compliance Rate** | % de dispositivos que cumplen la postura de seguridad | > 95% |
| **MFA Adoption** | % de usuarios con MFA activado | 100% |
| **Policy Violations** | Número de violaciones de política por semana | Tendencia decreciente |
| **Lateral Movement Attempts** | Intentos de movimiento lateral bloqueados | 100% bloqueados |
| **DLP Incidents** | Incidentes de fuga de datos | Tendencia decreciente |
| **Session Risk Score** | Puntuación promedio de riesgo de sesión | < 3/10 |

### 7.3 User and Entity Behavior Analytics (UEBA)

- **Baseline de comportamiento:** Establecimiento de patrones normales de actividad por usuario, dispositivo y aplicación.
- **Detección de anomalías:** Identificación de desviaciones del baseline que indiquen posible compromiso.
- **Risk scoring dinámico:** Puntuación de riesgo en tiempo real que ajusta los controles de acceso automáticamente.

### 7.4 Automatización de Respuesta (SOAR)

```yaml
# Playbook de respuesta automatizada
playbook:
  name: "BRIDA-Incident-Response"
  triggers:
    - "high_risk_score_detected"
    - "lateral_movement_detected"
    - "data_exfiltration_detected"
  actions:
    - step: 1
      action: "isolate_device"
      tool: "FortiEDR"
      condition: "risk_score > 8"
    - step: 2
      action: "disable_user_account"
      tool: "Active Directory"
      condition: "confirmed_compromise"
    - step: 3
      action: "block_ip_globally"
      tool: "FortiGate"
      condition: "malicious_ip_confirmed"
    - step: 4
      action: "notify_soc"
      tool: "FortiSIEM"
      priority: "P1"
    - step: 5
      action: "create_ticket"
      tool: "ServiceNow"
      assign_to: "Security-Incident-Response"
```

---

## 8. Mapeo a Frameworks de Seguridad

### 8.1 Mapeo MITRE ATT&CK

Las capacidades de FortiSASE y la arquitectura Zero Trust mitigan las siguientes técnicas del framework **MITRE ATT&CK**:

| Táctica MITRE | Técnica | Mitigación Zero Trust | Control FortiSASE |
|---------------|---------|----------------------|-------------------|
| **Initial Access** | T1078 - Valid Accounts | MFA obligatorio, identity risk scoring | FortiAuthenticator, SAML/OIDC |
| **Initial Access** | T1190 - Exploit Public-Facing App | ZTNA reverse proxy, no exposed apps | FortiSASE ZTNA |
| **Execution** | T1059 - Command and Scripting | Endpoint protection, command filtering | FortiEDR, FortiClient |
| **Persistence** | T1136 - Create Account | PAM, JIT provisioning, monitoring | FortiAuthenticator PAM |
| **Privilege Escalation** | T1078 - Valid Accounts | Least privilege, time-bound access | FortiGate policies |
| **Defense Evasion** | T1070 - Indicator Removal | Comprehensive logging, SIEM | FortiAnalyzer, FortiSIEM |
| **Credential Access** | T1003 - OS Credential Dumping | Device trust, EDR | FortiEDR, FortiClient |
| **Discovery** | T1087 - Account Discovery | UEBA, anomaly detection | FortiSASE Analytics |
| **Lateral Movement** | T1021 - Remote Services | Microsegmentation, ZTNA | FortiGate, FortiSASE |
| **Collection** | T1005 - Data from Local System | DLP, encryption | FortiSASE DLP |
| **Exfiltration** | T1048 - Exfiltration Over Alt Protocol | DLP, SSL inspection, CASB | FortiSASE DLP, CASB |
| **Impact** | T1486 - Data Encrypted for Impact | EDR, backup, device isolation | FortiEDR |

### 8.2 Mapeo NIST Cybersecurity Framework (CSF)

| Función NIST CSF | Categoría | Implementación Zero Trust | Control FortiSASE |
|-------------------|-----------|--------------------------|-------------------|
| **IDENTIFY (DE)** | ID.AM - Asset Management | Inventario de dispositivos y usuarios | FortiClient EMS, FortiSASE |
| **IDENTIFY (DE)** | ID.RA - Risk Assessment | Evaluación continua de riesgo | FortiSASE risk scoring |
| **PROTECT (PR)** | PR.AC - Identity Mgmt & Access Control | MFA, ZTNA, least privilege | FortiAuthenticator, FortiSASE ZTNA |
| **PROTECT (PR)** | PR.DS - Data Security | Cifrado, DLP, clasificación | FortiSASE DLP, encryption |
| **PROTECT (PR)** | PR.IP - Protective Technology | Microsegmentation, endpoint security | FortiGate, FortiEDR |
| **PROTECT (PR)** | PR.PT - Technology Infrastructure | Secure SD-WAN, SASE fabric | FortiSASE SD-WAN |
| **DETECT (DE)** | DE.CM - Continuous Monitoring | SIEM, UEBA, analytics | FortiSIEM, FortiAnalyzer |
| **DETECT (DE)** | DE.AE - Anomaly Detection | Behavioral analytics, alerts | FortiSASE Analytics |
| **RESPOND (RS)** | RS.MI - Incident Mitigation | SOAR, automated response | FortiSOAR integration |
| **RECOVER (RC)** | RC.RP - Incident Recovery | Backup, DR, business continuity | FortiSASE backup policies |

### 8.3 Mapeo D3FEND

| Técnica D3FEND | Descripción | Implementación Zero Trust |
|----------------|-------------|--------------------------|
| **D3-MFA** | Multi-Factor Authentication | FortiAuthenticator con TOTP/Push |
| **D3-NTCD** | Network Traffic Analysis | FortiSASE deep packet inspection |
| **D3-DA** | Dynamic Authorization | Risk-based access policies |
| **D3-EDR** | Endpoint Detection and Response | FortiEDR integration |
| **D3-DLP** | Data Loss Prevention | FortiSASE DLP engine |
| **D3-SDM** | Software Deployment Management | FortiClient EMS |
| **D3-IAA** | Identity Authentication Attribute Verification | SAML/OIDC claims validation |
| **D3-PS** | Patch Management | FortiClient EMS compliance checks |
| **D3-FS** | File System Analysis | FortiEDR file integrity monitoring |
| **D3-NRA** | Network Response Actions | Automated quarantine via FortiGate |
| **D3-IS** | Isolation | Device isolation via FortiEDR |
| **D3-RA** | Restore | Backup and recovery procedures |

---

## 9. Hoja de Ruta de Implementación

### 9.1 Fase 1: Fundación (Meses 1-6) — Nivel CISA: Intermediate

**Objetivo:** Establecer los cimientos de identidad y visibilidad.

| Actividad | Entregable | Responsable |
|-----------|-----------|-------------|
| Inventario de activos (usuarios, dispositivos, aplicaciones, datos) | CMDB actualizado | IT Operations |
| Implementación de MFA para todos los usuarios | 100% MFA adoption | Security Team |
| Despliegue de FortiClient EMS en endpoints | Agent installed on all devices | Endpoint Team |
| Integración de FortiSASE con IdP (Azure AD/Okta) | SSO funcional | Identity Team |
| Configuración básica de ZTNA para 5 aplicaciones críticas | ZTNA operational | Network Security |
| Establecimiento de logging centralizado (FortiAnalyzer) | Logs aggregated | SOC |
| Definición de política de clasificación de datos | Data classification policy | Data Governance |

### 9.2 Fase 2: Expansión (Meses 7-12) — Nivel CISA: Advanced

**Objetivo:** Implementar controles avanzados y automatización.

| Actividad | Entregable | Responsable |
|-----------|-----------|-------------|
| Microsegmentación de red completa | Segmentation policies deployed | Network Team |
| DLP policies implementadas y en modo enforce | DLP operational | Security Team |
| Device trust scoring en producción | Risk-based access active | Security Team |
| CASB integration para SaaS apps | SaaS visibility achieved | Cloud Security |
| UEBA baselines establecidos | Anomaly detection active | SOC |
| SOAR playbooks para respuesta automatizada | 10 playbooks operational | SOC |
| Evaluación de postura cloud (CSPM) | Cloud security baseline | Cloud Team |

### 9.3 Fase 3: Optimización (Meses 13-18) — Nivel CISA: Advanced

**Objetivo:** Madurez operacional y optimización continua.

| Actividad | Entregable | Responsable |
|-----------|-----------|-------------|
| ZTNA extendido a todas las aplicaciones | Full ZTNA coverage | Network Security |
| Políticas adaptativas basadas en riesgo | Dynamic policies active | Security Team |
| Threat hunting proactivo | Monthly threat hunts | SOC |
| Red team exercises (Zero Trust validation) | Pen test report | Red Team |
| Automatización de compliance reporting | Automated compliance dashboards | GRC |
| Integración completa MITRE ATT&CK mapping | ATT&CK coverage report | Security Architecture |

### 9.4 Fase 4: Innovación (Meses 19-36) — Nivel CISA: Initial

**Objetivo:** Capacidades adaptativas y respuesta autónoma.

| Actividad | Entregable | Responsable |
|-----------|-----------|-------------|
| AI/ML para detección de amenazas avanzada | ML models in production | Data Science + Security |
| Respuesta autónoma a incidentes | Autonomous IR capabilities | SOC |
| Zero Trust para OT/IoT environments | OT security framework | OT Security |
| Continuous authentication (biometrics, behavioral) | Passwordless auth pilot | Identity Team |
| Quantum-safe cryptography evaluation | Crypto agility roadmap | Cryptography Team |

### 9.5 Diagrama de Gantt Simplificado

```
Fase 1: Fundación        ████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
Fase 2: Expansión        ░░░░░░░░░░░░████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
Fase 3: Optimización     ░░░░░░░░░░░░░░░░░░░░░░░░████████████░░░░░░░░░░░░░░░░░░░░
Fase 4: Innovación       ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░████████████████████
                         |----|----|----|----|----|----|----|----|----|----|----|----|
                         M1   M3   M6   M9   M12  M15  M18  M21  M24  M27  M30  M33  M36
```

---

## 10. Configuraciones de Referencia FortiSASE

### 10.1 Configuración Base de FortiSASE

```yaml
# Configuración base FortiSASE para BRIDA IT Services
fortisase_config:
  organization: "BRIDA IT Services"
  region: "LATAM"
  
  identity:
    idp:
      type: "Azure AD"
      protocol: "SAML 2.0"
      tenant_id: "${AZURE_TENANT_ID}"
      client_id: "${AZURE_CLIENT_ID}"
    mfa:
      provider: "FortiAuthenticator"
      methods: ["totp", "push", "sms"]
      enforcement: "all_users"
    
  ztna:
    mode: "explicit_proxy"  # Opciones: explicit_proxy, transparent, agent_based
    client: "FortiClient"
    default_policy: "deny_all"
    applications:
      - name: "ERP-BRIDA"
        fqdn: "erp.internal.brida.com"
        access_groups: ["ERP-Users"]
      - name: "HR-System"
        fqdn: "hr.internal.brida.com"
        access_groups: ["HR-Team"]
      - name: "DevOps-Tools"
        fqdn: "devops.internal.brida.com"
        access_groups: ["DevOps-Team", "Developers"]
    
  sdwan:
    hubs:
      - name: "BRIDA-HQ"
        location: "Sede Principal"
        wan_links: ["MPLS", "Broadband", "4G"]
      - name: "BRIDA-DR"
        location: "Sitio de Recuperación"
        wan_links: ["MPLS", "Broadband"]
    spoke_sites:
      - name: "BRIDA-Office-1"
        location: "Oficina Norte"
      - name: "BRIDA-Office-2"
        location: "Oficina Sur"
    application_steering:
      - app: "Microsoft 365"
        priority: "high"
        path: "lowest_latency"
      - app: "SAP"
        priority: "critical"
        path: "MPLS_primary"
    
  security:
    ssl_inspection: true
    certificate: "BRIDA-SubCA"
    ips:
      enabled: true
      mode: "block"
      severity: "high"
    antivirus:
      enabled: true
      action: "block"
    web_filtering:
      enabled: true
      categories_blocked: ["malware", "phishing", "adult", "gambling"]
    dlp:
      enabled: true
      policies: ["BRIDA-DLP-Confidential", "BRIDA-DLP-PCI"]
    casb:
      enabled: true
      providers: ["Microsoft 365", "Google Workspace", "Salesforce"]
```

### 10.2 Políticas de Firewall Zero Trust

```bash
# Configuración FortiGate - Políticas Zero Trust para BRIDA

# Política por defecto: Denegar todo
config firewall policy
    edit 0
        set name "BRIDA-DENY-ALL"
        set srcintf "any"
        set dstintf "any"
        set srcaddr "all"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set comments "Default deny - Zero Trust principle"
    next
end

# Política ZTNA: Acceso a ERP
config firewall policy
    edit 100
        set name "BRIDA-ZTNA-ERP"
        set srcintf "ztna-tunnel"
        set dstintf "port2"
        set srcaddr "ZTNA-ERP-Users"
        set dstaddr "ERP-Server"
        set action accept
        set schedule "always"
        set service "HTTPS"
        set utm-status enable
        set ssl-ssh-profile "BRIDA-SSL-Inspection"
        set av-profile "BRIDA-AV"
        set webfilter-profile "BRIDA-WF"
        set ips-sensor "BRIDA-IPS"
        set dlp-sensor "BRIDA-DLP"
        set logtraffic all
        set comments "ZTNA access to ERP - Zero Trust enforced"
    next
end

# Política: Acceso a Internet con inspección
config firewall policy
    edit 200
        set name "BRIDA-INTERNET-ACCESS"
        set srcintf "port1"
        set dstintf "wan1"
        set srcaddr "BRIDA-Internal"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "HTTP" "HTTPS" "DNS"
        set utm-status enable
        set ssl-ssh-profile "BRIDA-SSL-Inspection"
        set av-profile "BRIDA-AV"
        set webfilter-profile "BRIDA-WF"
        set ips-sensor "BRIDA-IPS"
        set logtraffic all
        set comments "Internet access with full inspection"
    next
end
```

---

## 11. Métricas de Éxito y KPIs de la Arquitectura

### 11.1 Métricas Operacionales

| Métrica | Línea Base | Meta 6M | Meta 12M | Meta 18M |
|---------|-----------|---------|----------|----------|
| MFA Adoption | 30% | 80% | 95% | 100% |
| Device Compliance | 40% | 70% | 90% | 95% |
| ZTNA App Coverage | 10% | 40% | 80% | 100% |
| DLP Coverage | 0% | 50% | 80% | 100% |
| Microsegmentation | 0% | 30% | 70% | 90% |
| Mean Time to Detect | 24h | 4h | 1h | 30min |
| Mean Time to Respond | 48h | 12h | 4h | 1h |
| Lateral Movement Incidents | Unknown | Baseline | -50% | -90% |

### 11.2 Métricas de Negocio

| Métrica | Descripción |
|---------|-------------|
| **Reducción de superficie de ataque** | % reducción en puertos expuestos y servicios accesibles |
| **Tiempo de onboarding de usuarios** | Tiempo para otorgar acceso a nuevos empleados |
| **Cumplimiento regulatorio** | % de controles cumplidos (PCI-DSS, ISO 27001, etc.) |
| **Costo de incidentes** | Reducción del costo promedio de incidentes de seguridad |
| **Productividad del usuario** | Impacto positivo en la experiencia de acceso seguro |

---

## 12. Consideraciones Específicas para BRIDA IT Services

### 12.1 Requisitos de Cumplimiento

- **PCI-DSS:** Protección de datos de tarjetahabientes — segmentación + cifrado + DLP.
- **ISO 27001:** Gestión de seguridad de la información — controles A.9 (acceso), A.10 (criptografía), A.12 (operaciones).
- **Regulaciones locales:** Cumplimiento con leyes de protección de datos aplicables en cada jurisdicción donde opera BRIDA.

### 12.2 Integración con Ecosistema Existente

- **Active Directory / LDAP:** Directorio de identidad principal.
- **ServiceNow:** Gestión de tickets y flujos de trabajo de seguridad.
- **SIEM existente:** Integración vía syslog/CEF/API con FortiSIEM u otro SIEM.
- **Ticketing system:** Automatización de flujos de aprobación de acceso.

### 12.3 Modelo Operativo

```
┌──────────────────────────────────────────────────────────────┐
│              MODELO OPERATIVO ZERO TRUST BRIDA              │
│                                                              │
│  ┌──────────────────┐    ┌──────────────────────────────┐   │
│  │  IDENTITY TEAM   │    │  SECURITY OPERATIONS (SOC)   │   │
│  │                  │    │                              │   │
│  │  - IdP Mgmt      │    │  - 24/7 Monitoring           │   │
│  │  - MFA Ops       │    │  - Incident Response         │   │
│  │  - PAM           │    │  - Threat Hunting            │   │
│  │  - Certificates  │    │  - Vulnerability Mgmt        │   │
│  └────────┬─────────┘    └──────────────┬───────────────┘   │
│           │                             │                    │
│           └──────────┬──────────────────┘                    │
│                      │                                       │
│           ┌──────────▼──────────┐                            │
│           │  SECURITY ARCHITECT │                            │
│           │                     │                            │
│           │  - Policy Design    │                            │
│           │  - ZTNA Design      │                            │
│           │  - Risk Assessment  │                            │
│           │  - Compliance       │                            │
│           └──────────┬──────────┘                            │
│                      │                                       │
│           ┌──────────▼──────────┐                            │
│           │  NETWORK TEAM       │                            │
│           │                     │                            │
│           │  - FortiSASE Ops    │                            │
│           │  - SD-WAN           │                            │
│           │  - Segmentation     │                            │
│           │  - Cloud Security   │                            │
│           └─────────────────────┘                            │
└──────────────────────────────────────────────────────────────┘
```

---

## 13. Referencias y Recursos

### 13.1 Documentación Oficial

- [FortiSASE Documentation](https://docs.fortinet.com/product/fortisase)
- [CISA Zero Trust Maturity Model](https://www.cisa.gov/zero-trust-maturity-model)
- [NIST SP 800-207 - Zero Trust Architecture](https://csrc.nist.gov/publications/detail/sp/800-207/final)
- [MITRE ATT&CK Framework](https://attack.mitre.org/)
- [MITRE D3FEND](https://d3fend.mitre.org/)

### 13.2 Estándares y Frameworks

- **NIST CSF v2.0** — Cybersecurity Framework
- **ISO/IEC 27001:2022** — Information Security Management
- **CIS Controls v8** — Center for Internet Security
- **PCI DSS v4.0** — Payment Card Industry Data Security Standard

### 13.3 Fortinet Resources

- [Fortinet SASE Architecture](https://www.fortinet.com/solutions/sase)
- [FortiClient EMS Documentation](https://docs.fortinet.com/product/forticlient)
- [FortiAuthenticator Admin Guide](https://docs.fortinet.com/product/fortiauthenticator)
- [FortiGuard Labs](https://www.fortiguard.com/) — Threat Intelligence

---

## 14. Glosario

| Término | Definición |
|---------|-----------|
| **ZTNA** | Zero Trust Network Access — Acceso a red basado en principios Zero Trust |
| **SASE** | Secure Access Service Edge — Convergencia de seguridad y red en la nube |
| **SDP** | Software-Defined Perimeter — Perímetro definido por software |
| **MFA** | Multi-Factor Authentication — Autenticación multifactor |
| **DLP** | Data Loss Prevention — Prevención de fuga de datos |
| **CASB** | Cloud Access Security Broker — Seguridad de acceso a la nube |
| **UEBA** | User and Entity Behavior Analytics — Análisis de comportamiento de usuarios y entidades |
| **SOAR** | Security Orchestration, Automation and Response — Orquestación y automatización de seguridad |
| **EDR** | Endpoint Detection and Response — Detección y respuesta en endpoints |
| **PAM** | Privileged Access Management — Gestión de acceso privilegiado |
| **CSPM** | Cloud Security Posture Management — Gestión de postura de seguridad en la nube |
| **IdP** | Identity Provider — Proveedor de identidad |
| **SAML** | Security Assertion Markup Language — Lenguaje de marcado de aserciones de seguridad |
| **OIDC** | OpenID Connect — Protocolo de identidad sobre OAuth 2.0 |
| **MTTD** | Mean Time to Detect — Tiempo promedio de detección |
| **MTTR** | Mean Time to Respond — Tiempo promedio de respuesta |
| **IoC** | Indicator of Compromise — Indicador de compromiso |
| **HSM** | Hardware Security Module — Módulo de seguridad hardware |
| **JIT** | Just-in-Time — Aprovisionamiento justo a tiempo |
| **PAW** | Privileged Access Workstation — Estación de trabajo de acceso privilegiado |
