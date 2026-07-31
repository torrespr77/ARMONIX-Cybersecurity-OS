---
name: compliance-governance-brida
description: "Cumplimiento normativo y gobernanza de ciberseguridad para BRIDA IT Services. Cubre NIST CSF 2.0, ISO 27001:2022, CIS Controls v8, PCI-DSS v4.0, SOC 2, LFPDPPP (Ley Federal de Protección de Datos Personales en Posesión de los Particulares), mapeo MITRE ATT&CK, D3FEND, metodología de gap assessment, roadmap de cumplimiento y preparación para auditorías. Activar cuando el cliente necesite: compliance, governance, NIST, ISO 27001, PCI-DSS, SOC 2, CIS, auditoría, protección de datos, LFPDPPP, gap assessment."
domain: cybersecurity
subdomain: compliance-governance
category: governance-and-compliance
tags:
  - compliance
  - governance
  - NIST-CSF
  - ISO-27001
  - PCI-DSS
  - SOC-2
  - CIS-Controls
  - LFPDPPP
  - LGPD
  - MITRE-ATTACK
  - D3FEND
  - gap-assessment
  - audit-preparation
  - risk-management
  - data-protection
  - mexico
version: 2.0.0
author: BRIDA IT Services
license: Apache-2.0
language: es
frameworks:
  nist_csf_version: "2.0"
  iso_27001_version: "2022"
  cis_controls_version: "v8"
  pci_dss_version: "v4.0"
  soc_version: "2"
nist_csf_functions:
  - GOVERN
  - IDENTIFY
  - PROTECT
  - DETECT
  - RESPOND
  - RECOVER
---

# Compliance and Governance — BRIDA IT Services v2.0

## Descripción

Skill integral de cumplimiento normativo y gobernanza de ciberseguridad para BRIDA IT Services. Proporciona guías, metodologías y plantillas para evaluar, planear e implementar controles de cumplimiento alineados a **NIST CSF 2.0**, **ISO 27001:2022**, **CIS Controls v8**, **PCI-DSS v4.0**, **SOC 2** y **LFPDPPP** (protección de datos personales en México).

Incluye mapeos cruzados entre frameworks, correlación con **MITRE ATT&CK** y **D3FEND**, metodología de gap assessment, roadmap de cumplimiento, y guías de preparación para auditorías.

---

## Cuándo Activar

Usar este skill cuando el usuario mencione o requiera:

- **Compliance**: evaluaciones de cumplimiento, auditorías, certificaciones
- **Frameworks**: NIST CSF, ISO 27001, CIS Controls, PCI-DSS, SOC 2
- **Protección de datos**: LFPDPPP, LGPD, privacidad, datos personales
- **Gap Assessment**: evaluación de brechas, madurez de seguridad, diagnóstico
- **Auditoría**: preparación para auditoría, evidencia de controles, audit readiness
- **Gobernanza**: políticas, roles, responsabilidad, oversight
- **Risk Management**: evaluación de riesgos, risk register, tratamiento de riesgos
- **MITRE ATT&CK / D3FEND**: mapeo de amenazas a controles defensivos

---

## 1. NIST Cybersecurity Framework (CSF) 2.0

### Estructura del Framework

```
NIST CSF 2.0
├── GOVERN (GV) — Establecer y monitorear estrategia de riesgo
│   ├── GV.OC — Organizational Context
│   ├── GV.RM — Risk Management Strategy
│   ├── GV.RR — Roles, Responsibilities, and Authorities
│   ├── GV.PO — Policy
│   └── GV.SC — Oversight
├── IDENTIFY (ID) — Comprender activos, riesgos, amenazas
│   ├── ID.AM — Asset Management
│   ├── ID.RA — Risk Assessment
│   └── ID.IM — Improvement
├── PROTECT (PR) — Implementar salvaguardas
│   ├── PR.AA — Identity Management, Authentication, and Access Control
│   ├── PR.AT — Awareness and Training
│   ├── PR.DS — Data Security
│   ├── PR.PS — Platform Security
│   └── PR.IR — Technology Infrastructure Resilience
├── DETECT (DE) — Detectar eventos de seguridad
│   ├── DE.CM — Continuous Monitoring
│   └── DE.AE — Adverse Event Analysis
├── RESPOND (RS) — Responder a incidentes
│   ├── RS.MA — Incident Management
│   ├── RS.AN — Incident Analysis
│   ├── RS.CO — Incident Response Reporting and Communication
│   └── RS.MI — Incident Mitigation
└── RECOVER (RC) — Recuperar capacidades
    ├── RP.RP — Incident Recovery Plan Execution
    └── RC.CO — Incident Recovery Communication
```

### Implementación por Nivel de Madurez (Tiers)

| Tier | Descripción | Características |
|------|-------------|-----------------|
| **1 — Parcial** | Ad-hoc, reactivo | Sin procesos formales; riesgos no prioritizados |
| **2 — Riesgo Informado** | Aprobado pero no organizacional | Gestión de riesgo reconocida pero no estandarizada |
| **3 — Repetible** | Formalmente aprobado, expresado como política | Procesos definidos, consistentes, regularmente actualizados |
| **4 — Adaptable** | Adapta prácticas basándose en lecciones aprendidas | Mejora continua; métricas; ajuste dinámico |

---

## 2. ISO 27001:2022 — Sistema de Gestión de Seguridad de la Información

### Cláusulas del SGSI (4–10)

| Cláusula | Nombre | Descripción |
|----------|--------|-------------|
| 4 | Contexto de la organización | Partes interesadas, alcance, SGSI |
| 5 | Liderazgo | Compromiso de dirección, política, roles |
| 6 | Planificación | Riesgos, objetivos, cambios |
| 7 | Soporte | Recursos, competencia, comunicación, documentación |
| 8 | Operación | Evaluación y tratamiento de riesgos |
| 9 | Evaluación del desempeño | Monitoreo, auditoría interna, revisión por dirección |
| 10 | Mejora | No conformidades, acciones correctivas, mejora continua |

### Controles del Anexo A (93 controles, 4 temas)

```
Anexo A — ISO 27001:2022
├── A.5 Organizational controls (37)
│   ├── A.5.1  Policies for information security
│   ├── A.5.2  Information security roles and responsibilities
│   ├── A.5.7  Threat intelligence
│   ├── A.5.9  Inventory of information and other associated assets
│   ├── A.5.10 Acceptable use of information
│   ├── A.5.12 Classification of information
│   ├── A.5.15 Access control
│   ├── A.5.16 Identity management
│   ├── A.5.17 Authentication information
│   ├── A.5.18 Access rights
│   ├── A.5.24 Incident management planning and preparation
│   ├── A.5.25 Assessment and decision on information security events
│   ├── A.5.26 Response to information security incidents
│   ├── A.5.28 Collection of evidence
│   ├── A.5.30 ICT readiness for business continuity
│   └── ... (19 controles adicionales)
├── A.6 People controls (8)
│   ├── A.6.1  Screening
│   ├── A.6.3  Information security awareness, education and training
│   ├── A.6.5  Responsibilities after termination or change
│   └── ... (5 controles adicionales)
├── A.7 Physical controls (14)
│   ├── A.7.1  Physical security perimeters
│   ├── A.7.4  Physical security monitoring
│   ├── A.7.9  Security of assets off-premises
│   └── ... (11 controles adicionales)
└── A.8 Technological controls (34)
    ├── A.8.1  User endpoint devices
    ├── A.8.3  Restrictions on access to information
    ├── A.8.5  Secure authentication
    ├── A.8.8  Management of technical vulnerabilities
    ├── A.8.10 Information masking
    ├── A.8.11 Data leakage prevention
    ├── A.8.12 Data prevention measures
    ├── A.8.15 Logging
    ├── A.8.16 Monitoring activities
    ├── A.8.19 Installation of software on operational systems
    ├── A.8.20 Networks security
    ├── A.8.23 Web filtering
    ├── A.8.24 Use of cryptography
    ├── A.8.25 Secure development lifecycle
    ├── A.8.28 Secure coding
    ├── A.8.34 Penetration testing
    └── ... (18 controles adicionales)
```

### Proceso de Certificación ISO 27001

```
Fase 1: Preparación
├── Paso 1: Definir alcance del SGSI
├── Paso 2: Realizar evaluación de riesgos
├── Paso 3: Elaborar Declaración de Aplicabilidad (SoA)
├── Paso 4: Implementar controles del Anexo A
├── Paso 5: Desarrollar documentación (políticas, procedimientos)
└── Paso 6: Auditoría interna

Fase 2: Certificación
├── Paso 7: Revisión por dirección (Management Review)
├── Paso 8: Auditoría Etapa 1 (Document review)
├── Paso 9: Auditoría Etapa 2 (Implementación)
├── Paso 10: Certificación
├── Paso 11: Auditorías de vigilancia (anual)
└── Paso 12: Recertificación (cada 3 años)
```

---

## 3. CIS Controls v8 (Center for Internet Security)

### Los 18 Controles Priorizados (Implementation Groups)

```
IG1 — Básico (56 prácticas) — Organizaciones con recursos limitados
├── CIS 1:  Inventory and Control of Enterprise Assets
├── CIS 2:  Inventory and Control of Software Assets
├── CIS 3:  Data Protection
├── CIS 4:  Secure Configuration of Enterprise Assets and Software
├── CIS 5:  Account Management
└── CIS 6:  Access Control Management

IG2 — Fundacional (127 prácticas) — Organizaciones con equipos de TI dedicados
├── CIS 7:  Continuous Vulnerability Management
├── CIS 8:  Audit Log Management
├── CIS 9:  Email and Web Browser Protections
├── CIS 10: Malware Defenses
├── CIS 11: Data Recovery
└── CIS 12: Network Infrastructure Management

IG3 — Organizacional (153 prácticas) — Organizaciones con programas de seguridad maduros
├── CIS 13: Network Monitoring and Defense
├── CIS 14: Security Awareness and Skills Training
├── CIS 15: Service Provider Management
├── CIS 16: Application Software Security
├── CIS 17: Incident Response Management
└── CIS 18: Penetration Testing
```

---

## 4. PCI-DSS v4.0

### 12 Requisitos Principales

| # | Requisito | Descripción | Ejemplos de Evidencia |
|---|-----------|-------------|----------------------|
| 1 | Network Security Controls | Instalar y mantener controles de seguridad de red | Diagramas de red, reglas de firewall, configuración de segmentación |
| 2 | Secure Configurations | Aplicar configuraciones seguras a todos los componentes | Hardening guides, SCAP benchmarks, imágenes base |
| 3 | Stored Account Data | Proteger los datos almacenados de cuentas | Política de retención, encriptación en reposo, masking |
| 4 | Cryptographic Transmission | Proteger datos de tarjetahabiente en transmisión | TLS 1.2+, certificados válidos, cipher suites permitidos |
| 5 | Anti-Malware | Proteger contra software malicioso | EDR/Antivirus, políticas de actualización, reportes |
| 6 | Secure Software | Desarrollar y mantener sistemas y software seguros | SDLC seguro, code review, WAF, escaneos de vulnerabilidades |
| 7 | Restrict Access | Restringir acceso según necesidad de negocio | Matriz de accesos, RBAC, revisiones trimestrales |
| 8 | Identify & Authenticate | Identificar usuarios y autenticar acceso | MFA, política de contraseñas, gestión de cuentas |
| 9 | Physical Access | Restringer acceso físico | CCTV, logs de acceso físico, controles de visitantes |
| 10 | Log & Monitor | Registrar y monitorear todo acceso | SIEM, logs centralizados, alertas, retención mínima |
| 11 | Security Testing | Probar regularmente seguridad | Pentests, ASV scans, análisis de vulnerabilidades |
| 12 | Information Security Policy | Respaldar seguridad con políticas y programas | Política de seguridad, plan de conciencia, responsables |

### Niveles de Comerciante

| Nivel | Volumen de Transacciones | Requisito de Auditoría |
|-------|------------------------|----------------------|
| 1 | >6 millones/año | QSA audit obligatorio (ROC + AOC) |
| 2 | 1–6 millones/año | SAQ + posible QSA |
| 3 | 20K–1 millón/año | SAQ |
| 4 | <20K transacciones/año | SAQ |

### Customized Approach (Nuevo en v4.0)

PCI-DSS v4.0 introduce el **Customized Approach** que permite a las organizaciones diseñar controles alternativos que cumplan el objetivo de seguridad, siempre que:
- Se documente el análisis de riesgo
- Se defina el control alternativo
- Se mida la efectividad del control
- Se mantenga evidencia de cumplimiento

---

## 5. SOC 2 (Service Organization Control 2)

### Trust Service Criteria (TSC)

| Categoría | Código | Descripción | Controles Típicos |
|-----------|--------|-------------|-------------------|
| **Security** (CC) | CC6.1-CC9.2 | Protección contra acceso no autorizado obligatorio | Firewalls, MFA, IDS/IPS, encriptación |
| **Availability** (A) | A1.1-A1.3 | Disponibilidad del sistema | DR, BCP, monitoreo de uptime, SLA |
| **Processing Integrity** (PI) | PI1.1-PI1.5 | Integridad del procesamiento | Validación de datos, QA, monitoreo de errores |
| **Confidentiality** (C) | C1.1-C1.2 | Protección de información confidencial | Clasificación, DLP, NDA, encriptación |
| **Privacy** (P) | P1.0-P8.1 | Protección de información personal | Avisos de privacidad, consentimiento, retención |

### Tipos de Reporte SOC 2

| Tipo | Descripción | Período | Uso |
|------|-------------|---------|-----|
| **Tipo I** | Evaluación del diseño de controles | Punto en el tiempo | Clientes que necesitan evidencia rápida |
| **Tipo II** | Evaluación del diseño y operación efectiva | 6–12 meses | Clientes que necesitan garantía de efectividad |

### Implementación SOC 2

```
Preparación (2-3 meses)
├── Definir alcance (qué TSC aplican)
├── Mapear controles existentes a Trust Service Criteria
├── Implementar controles faltantes
├── Configurar recolección de evidencia automática
└── Auditoría interna

Examen (6-12 meses para Tipo II)
├── Seleccionar CPA firm
├── Entregar documentación y evidencia → auditor
├── Período de observación (mínimo 6 meses para Tipo II)
├── Remediar hallazgos
└── Recibir reporte SOC 2
```

---

## 6. LFPDPPP — Ley Federal de Protección de Datos Personales en Posesión de los Particulares (México)

### Fundamentos Legales

| Concepto | Descripción | Base Legal |
|----------|-------------|------------|
| **Dato personal** | Cualquier información concerniente a una persona identificada o identificable | Art. 3, Fracción V |
| **Dato personal sensible** | Datos que afecten a la esfera más íntima o cuya utilización indebida pueda dar origen a discriminación | Art. 3, Fracción VI |
| **Responsable** | Persona física o moral que decide sobre el tratamiento de datos | Art. 3, Fracción IX |
| **Encargado** | Persona física o jurídica que trate datos por cuenta del responsable | Art. 3, Fracción VII |
| **Titular** | Persona física a quien corresponden los datos | Art. 3, Fracción X |

### Principios Rectores

| Principio | Descripción | Obligación Práctica |
|-----------|-------------|-------------------|
| **Licitud** | Tratamiento conforme a la Ley | Cumplir todos los requisitos legales |
| **Consentimiento** | Obtener consentimiento del titular | Avisos de privacidad, formularios de consentimiento |
| **Información** | Informar al titular sobre el tratamiento | Avisos de privacidad claros y accesibles |
| **Calidad** | Datos exactos y actualizados | Procesos de actualización y verificación |
| **Finalidad** | Tratamiento solo para fines establecidos | Vincular cada dato a una finalidad documentada |
| **Lealtad** | Protección de interés del titular | Tratamiento sin medios engañosos o fraudulentos |
| **Proporcionalidad** | Solo datos necesarios | Minimización de datos |
| **Responsabilidad** | Medidas para cumplir principios | Políticas, auditorías, evidencias |

### Derechos ARCO

| Derecho | Descripción | Plazo de Respuesta |
|---------|-------------|-------------------|
| **Acceso** | Conocer qué datos se tienen | 20 días hábiles |
| **Rectificación** | Corregir datos inexactos | 15 días hábiles |
| **Cancelación** | Solicitar eliminación de datos | 15 días hábiles |
| **Oposición** | Oponerse al tratamiento | 15 días hábiles |
| **Portabilidad** (LGPD) | Transferir datos a otro responsable | 15 días hábiles |

### Avisos de Privacidad

Tipos de aviso de privacidad según la Ley:

| Tipo | Alcance | Entrega |
|------|---------|---------|
| **Integral** | Tratamiento amplio de datos | Por escrito o electrónico |
| **Simplificado** | Tratamiento limitado | En medio electrónico visible |
| **Corto** | Tratamiento muy limitado | En texto breve |

Contenido obligatorio del aviso de privacidad:
1. Identidad del responsable
2. Datos personales recopilados
3. Finalidades del tratamiento
4. Opciones para limitar uso/revelación
5. Derechos ARCO
6. Transferencias de datos
7. Procedimientos para cambios al aviso

### Sanciones y Penalidades

| Gravedad | Multa | Referencia |
|----------|-------|------------|
| Infracción estándar | 100–320,000 días de salario mínimo (UMG) | Art. 64 |
| Datos sensibles | 200–640,000 días de salario mínimo (UMG) | Art. 65 |
| Responsabilidad penal | 3–12 años de prisión (casos graves) | Art. 69 |

> **UMG (Unidad de Medida y Actualización):** Sustituyó al salario mínimo como unidad de referencia a partir de 2016.

### Violaciones de Seguridad

**Obligaciones ante violación de seguridad (Art. 40-42):**
1. Notificar a los titulares sin dilaciones indebidas
2. Informar las medidas correctivas implementadas
3. Notificar al INAI cuando la violación afecte significativamente los derechos patrimoniales o morales
4. Incluir la violación en el registro interno de incidentes

### Obligaciones del Responsable

```
Implementar
├── Medidas de seguridad administrativas
│   ├── Designar un encargado de protección de datos / DPO
│   ├── Políticas internas de protección de datos
│   ├── Programa de capacitación al personal
│   ├── Procedimientos para atención de derechos ARCO
│   └── Gestión de documentos y registros
├── Medidas de seguridad técnicas
│   ├── Controles de acceso lógicos y físicos
│   ├── Mecanismos de autenticación
│   ├── Encriptación de datos sensibles
│   ├── Monitoreo y auditoría de accesos
│   └── Gestión de incidentes de seguridad
└── Medidas de seguridad físicas
    ├── Control de acceso físico a áreas con datos
    └── Protección de equipos que almacenan datos
```

---

## 7. LGPD — Lei Geral de Proteção de Dados (Brasil) — Referencia

Dado que BRIDA IT Services opera en Latinoamérica, se incluye referencia a LGPD para clientes con operaciones en Brasil:

| Aspecto | LFPDPPP (México) | LGPD (Brasil) |
|---------|-------------------|----------------|
| **Base legal** | Consentimiento (principal) | 10 bases legales |
| **DPO requerido** | Recomendado | Obligatorio (DPO/Encarregado) |
| **Notificación de brechas** | Al titular + INAI (significativa) | Autoridad + titulares (riesgo relevante) |
| **Multas** | Hasta 320,000 UMG / penal | Hasta 2% facturación (R$50M) |
| **Transferencia internacional** | Con consentimiento informado | Adecuación, SCC, BCR, etc. |

---

## 8. MITRE ATT&CK Mapping

### Mapeo de Tácticas ATT&CK → Frameworks de Compliance

| Táctica ATT&CK | ID | NIST CSF | ISO 27001 | CIS Control | PCI-DSS | SOC 2 |
|----------------|-----|----------|-----------|-------------|---------|-------|
| Reconnaissance | TA0043 | ID.RA | A.5.7 | 18 | 11.4 | CC6.6 |
| Resource Development | TA0042 | ID.RA | A.5.7 | 18 | 11.4 | CC6.6 |
| Initial Access | TA0001 | PR.AC, PR.PS | A.8.1-A.8.5 | 6 | 1, 1, 8 | CC6.1, CC6.7 |
| Execution | TA0002 | PR.PS | A.8.7 | 10, 16 | 5, CC | CC7.2 |
| Persistence | TA0003 | PR.AC, PR.PS | A.8.3 | 5, 6 | 7, 8 | CC6.1 |
| Privilege Escalation | TA0004 | PR.AC | A.8.3 | 5, 6 | 7, 8 | CC6.1 |
| Defense Evasion | TA0005 | DE.CM | A.8.16 | 10, 13 | 5, 10 | CC7.2 |
| Credential Access | TA0006 | PR.AC | A.8.5 | 5, 6 | 8 | CC6.1 |
| Discovery | TA0007 | DE.CM | A.8.15, A.8.16 | 13 | 10 | CC7.2 |
| Lateral Movement | TA0008 | PR.AC, PR.PS | A.8.20 | 6, 12 | 1, 7 | CC6.1, CC6.7 |
| Collection | TA0009 | PR.DS | A.8.11 | 3 | 3, 4 | C1.1, C1.2 |
| Command and Control | TA0011 | DE.CM, RS.AN | A.8.20 | 12, 13 | 1, 10 | CC7.2 |
| Exfiltration | TA0010 | PR.DS, DE.CM | A.8.11, A.8.12 | 3, 13 | 4 | C1.1, C1.2 |
| Impact | TA0040 | RS.MI, RC. RP | A.5.24-A.5.30 | 17 | 12 | A1.2, A1.3 |

### Detecciones ATTCK → Controles de Compliance

**Ejemplo: Detección de Técnicas de Exfiltration (TA0010)**

```
Técnica: Exfiltration Over Web Service (T1567)
├── MITRE ATT&CK ID: T1567.001 / T1567.002
├── Detección:
│   ├── Analytics de DLP (Data Loss Prevention)
│   ├── Monitoreo de tráfico saliente anómalo
│   ├── Web filtering / URL categorization
│   └── Baseline de volumen de transferencia de datos
├── Controles Compliance:
│   ├── NIST CSF: PR.DS-01, PR.DS-02, DE.CM-01
│   ├── ISO 27001: A.8.11 (Data Leakage Prevention), A.8.15 (Logging)
│   ├── CIS Control 3: Data Protection
│   ├── PCI-DSS: Req 3.1 (Stored data), Req 4.1 (Encryption in transit)
│   ├── SOC 2: C1.1, C1.2 (Confidentiality), CC7.2
│   └── LFPDPPP: Medidas de seguridad administrativas y técnicas
└── D3FEND: Network Traffic Analysis, Egress Filtering
```

---

## 9. MITRE D3FEND Mapping

### Controles D3FEND por Técnica Defensiva

| D3FEND Technique | Artefacto | NIST CSF | CIS Control | Uso en Compliance |
|-------------------|-----------|----------|-------------|-------------------|
| **Network Traffic Analysis** | Network traffic | DE.CM-01 | 13 | Detección de anomalías, exfiltration |
| **Egress Filtering** | Network process, application | PR.AC-05, PR.PS-05 | 12 | Control de salidas de red |
| **Credential Hardening** | Credential | PR.AC-01, PR.AC-07 | 5, 6 | Política de contraseñas, MFA |
| **File Analysis** | File | DE.CM-09 | 10 | Detección de malware |
| **Process Analysis** | Process | DE.CM-09 | 10 | Detección de ejecución maliciosa |
| **Authentication Behavior Analysis** | User account session | DE.CM-03 | 8 | Detección de compromiso de cuentas |
| **Biometric Authentication** | Credential | PR.AC-07 | 8 | Autenticación reforzada |
| **Certificate-based Authentication** | Digital certificate | PR.AC-01 | 8 | Acceso seguro |
| **Encryption** | Data, network traffic | PR.DS-01, PR.DS-02 | 3 | Protección de datos en tránsito/reposo |
| **Key Management** | Cryptographic key | PR.DS-01 | 3 | Gestión de claves criptográficas |
| **Platform Monitoring** | Platform process | DE.CM-09 | 10 | Monitoreo de endpoints |
| **User Behavior Analysis** | User account session | DE.CM-03 | 8 | Detección de Insider Threat |
| **Decoy Content** | File, service | DE.CE-01 |  | Honeypots, detección temprana |
| **Domain Filtering** | Network traffic | PR.PS-03 | 9 | Bloqueo de dominios maliciosos |
| **Execute Authorization** | Operating system process | PR.PS-05 | 6, 12 | Control de ejecución de aplicaciones |

### Mapping D3FEND → NIST CSF Ejemplo Completo

```
D3FEND Technique: Identifier Analysis
├── Artifact: Identifier
├── Definition: Analysis of identifier correlation and authentication
├── NIST CSF Mapping:
│   ├── PR.AC-01: Identity Management and Access Control
│   ├── PR.AC-06: Authentication
│   ├── DE.CM-03: Personnel Activity Monitoring
│   └── RS.AN-03: Investigation
├── ISO 27001: A.8.2 (Privileged Access Rights), A.8.5 (Secure Authentication)
├── CIS: CIS 5 (Account Management), CIS 6 (Access Control)
├── PCI-DSS: Req 8 (Identify & Authenticate)
└── SOC 2: CC6.1 (Logical & Physical Access)
```

---

## 10. Metodología Gap Assessment — BRIDA IT Services

### Fase 1: Alcance y Planificación

```
Actividades:
├── 1.1 Definir el framework objetivo (o combinación)
│   └── Criterio: requisito regulatorio, cliente, industria
├── 1.2 Definir el alcance del assessment
│   ├── Organización (entidades, subsidiarias)
│   ├── Sistemas (infraestructura, aplicaciones, datos)
│   ├── Ubicaciones (oficinas, data centers, nube)
│   └── Procesos (operaciones, desarrollo, soporte)
├── 1.3 Identificar stakeholders y responsables
│   ├── Comité de seguridad / CISO
│   ├── TI (infraestructura, operaciones, desarrollo)
│   ├── Áreas de negocio (procesos afectados)
│   ├── Legal y compliance
│   └── Proveedores terceros críticos
├── 1.4 Establecer cronograma y entregables
│   ├── Duración típica: 2-4 semanas
│   └── KPIs del assessment
└── 1.5 Solicitar documentación existente
    ├── Políticas de seguridad
    ├── Procedimientos operativos
    ├── Inventarios (activos, software, datos)
    ├── Diagramas de red
    ├── Contratos con proveedores
    ├── Resultados de auditorías previas
    └── Registros de incidentes
```

### Fase 2: Evaluación

```
Para cada control/categoría del framework:

2.1 Revisar documentación existente
    ├── ¿Existe política/procedimiento?
    ├── ¿Está actualizado?
    └── ¿Está aprobado por dirección?

2.2 Entrevistar a responsables
    ├── ¿Conocen el control?
    ├── ¿Lo aplican consistentemente?
    └── ¿Tienen evidencia de su operación?

2.3 Verificar implementación técnica
    ├── Configuraciones de seguridad
    ├── Registros de logs
    ├── Capturas de pantalla
    └── Pruebas técnicas (escaneos, revisión de configs)

2.4 Evaluar nivel de madurez (0-5)
    └── Usar escala de madurez definida abajo

2.5 Documentar hallazgos y evidencias
    ├── Evidencia de cumplimiento
    ├── Evidencia de brecha
    └── Referencia a control específico

2.6 Calificar cumplimiento
    ├── Cumple (C): Control implementado y operando
    ├── Parcial (P): Control parcialmente implementado
    ├── No Cumple (NC): Control no implementado
    └── No Aplica (NA): Control no aplicable al alcance
```

### Escala de Madurez (CMMI-based)

| Nivel | Nombre | Descripción | Indicadores |
|-------|--------|-------------|-------------|
| **0** | Inexistente | No hay evidencia de implementación | Sin documentación, sin procesos, sin tecnología |
| **1** | Inicial | Implementación ad-hoc, no documentada | Depende de individuos; no repetible |
| **2** | En desarrollo | Procesos definidos pero no consistentes | Documentado pero no seguido uniformemente |
| **3** | Definido | Procesos documentados y estandarizados | Políticas aprobadas; capacitación realizada |
| **4** | Gestionado | Procesos medidos y monitoreados | Métricas definidas; KPIs reportados |
| **5** | Optimizado | Mejora continua basada en métricas | Lecciones aprendidas; ajuste proactivo |

### Fase 3: Análisis y Reporte

```
3.1 Calcular nivel de cumplimiento por categoría
    ├── % de controles cumplidos por función/categoría
    ├── Heat map de madurez
    └── Comparación vs benchmark de industria

3.2 Identificar gaps por severidad
    ├── Crítico: Riesgo inminente de incumplimiento o brecha de seguridad
    │   → Remediación inmediata (0-30 días)
    ├── Alto: Brecha significativa que afecta cumplimiento
    │   → Remediación prioritaria (30-90 días)
    ├── Medio: Mejora necesaria pero no bloqueante
    │   → Remediación planificada (90-180 días)
    └── Bajo: Mejora recomendada para madurez
        → Remediación a largo plazo (180-365 días)

3.3 Priorizar remediación
    ├── Por riesgo (impacto × probabilidad)
    ├── Por esfuerzo (costo, tiempo, recursos)
    ├── Por dependencia (controles que habilitan otros)
    └── Por requisito regulatorio (deadlines legales)

3.4 Crear roadmap de cumplimiento
    └── Ver sección 11

3.5 Estimar recursos necesarios
    ├── Personal (interno vs externo)
    ├── Tecnología (herramientas, licencias)
    ├── Capacitación
    └── Consultoría especializada

3.6 Presentar resultados a stakeholders
    ├── Ejecutivo: resumen ejecutivo, heat map, inversión
    ├── Técnico: detalle de gaps, evidencias, recomendaciones
    └── Operativo: plan de acción, responsables, fechas
```

### Fase 4: Seguimiento y Mejora Continua

```
4.1 Establecer programa de monitoreo
    ├── Revisiones trimestrales de cumplimiento
    ├── Métricas de efectividad de controles
    └── Alertas de desviación

4.2 Programa de auditorías internas
    ├── Auditoría interna anual (mínimo)
    ├── Scope: controles críticos + muestra aleatoria
    └── Resultados → revisión por dirección

4.3 Actualización de riesgos
    ├── Re-evaluación de riesgos semestral
    ├── Incorporación de nuevas amenazas
    └── Ajuste de controles según threat landscape

4.4 Lecciones aprendidas
    ├── Post-auditoría externa
    ├── Post-incidente
    └── Benchmarking con peers
```

---

## 11. Roadmap de Cumplimiento — BRIDA IT Services

### Quick Wins (0-3 meses)

```
Prioridad: ALTA | Esfuerzo: BAJO

├── Políticas de seguridad básicas
│   ├── Política de uso aceptable
│   ├── Política de contraseñas
│   ├── Política de clasificación de datos
│   └── Política de respuesta a incidentes
├── Capacitación de conciencia en seguridad
│   ├── Phishing awareness
│   ├── Protección de datos personales (LFPDPPP)
│   └── Seguridad en el uso de TI
├── Configuraciones de seguridad básicas
│   ├── MFA en cuentas privilegiadas y correo
│   ├── SPF/DKIM/DMARC en dominios
│   ├── Desactivación de servicios innecesarios
│   └── Actualización de parches críticos
├── Inventario de activos
│   ├── Inventario de hardware
│   ├── Inventario de software
│   └── Inventario de datos personales (LFPDPPP)
└── Avisos de privacidad (LFPDPPP)
    ├── Aviso integral
    ├── Aviso simplificado
    └── Mecanismo de consentimiento
```

### Corto Plazo (3-6 meses)

```
Prioridad: ALTA | Esfuerzo: MEDIO

├── Implementación de controles técnicos
│   ├── Firewall / NGFW con reglas documentadas
│   ├── EDR en endpoints críticos
│   ├── Segmentación de red básica
│   └── Encriptación de datos sensibles
├── Procedimientos de respuesta a incidentes
│   ├── Plan de respuesta a incidentes
│   ├── Playbooks por tipo de incidente
│   ├── Equipo de respuesta (CSIRT)
│   └── Procedimiento de notificación de brechas (LFPDPPP)
├── Gestión de vulnerabilidades
│   ├── Programa de escaneo periódico
│   ├── Priorización por riesgo (CVSS + contexto)
│   ├── SLA de remediación por severidad
│   └── Reporte ejecutivo mensual
├── Monitoreo básico
│   ├── Centralización de logs
│   ├── Alertas de seguridad básicas
│   └── Monitoreo de disponibilidad
└── Gestión de accesos
    ├── Revisión de accesos privilegiados
    ├── Proceso de onboarding/offboarding
    └── Matriz de roles y permisos
```

### Mediano Plazo (6-12 meses)

```
Prioridad: MEDIA | Esfuerzo: MEDIO-ALTO

├── Programa de cumplimiento formal
│   ├── GRC platform (ServiceNow, Archer, Drata, Vanta)
│   ├── Risk register automatizado
│   ├── Métricas y dashboards de cumplimiento
│   └── Comité de seguridad con reuniones periódicas
├── Auditorías internas
│   ├── Programa anual de auditorías
│   ├── Checklists por framework
│   ├── Seguimiento de hallazgos
│   └── Preparación para auditoría externa
├── Gestión de proveedores
│   ├── Evaluación de seguridad de proveedores
│   ├── Cláusulas de seguridad en contratos
│   ├── Monitoreo continuo de terceros
│   └── Due diligence para nuevos proveedores
├── Continuidad de negocio
│   ├── Plan de continuidad (BCP)
│   ├── Plan de recuperación ante desastres (DRP)
│   ├── Pruebas de recuperación (tabletop + simulacro)
│   └── RTO/RPO definidos por sistema
└── Seguridad en desarrollo
    ├── Secure SDLC
    ├── Code review automatizado (SAST)
    ├── Escaneo de dependencias (SCA)
    └── Pruebas de seguridad en aplicaciones (DAST)
```

### Largo Plazo (12-24 meses)

```
Prioridad: ESTRATÉGICA | Esfuerzo: ALTO

├── Certificación
│   ├── ISO 27001:2022 (SGSI)
│   ├── SOC 2 Tipo II
│   ├── PCI-DSS (si aplica)
│   └── Cumplimiento LFPDPPP verificado
├── Mejora continua
│   ├── Programa de métricas avanzadas
│   ├── Threat intelligence integrado
│   ├── Red team / Purple team exercises
│   └── Benchmarking con industria
├── Automatización de controles
│   ├── SOAR para respuesta automatizada
│   ├── Compliance-as-Code
│   ├── Infraestructura como código con controles embebidos
│   └── Monitoreo continuo de controles (CCM)
├── Madurez nivel 4-5
│   ├── Procesos medidos y optimizados
│   ├── Predicción de riesgos
│   ├── Integración de seguridad en cultura organizacional
│   └── Security by design en todos los proyectos
└── Gobernanza avanzada
    ├── Board-level security reporting
    ├── Cyber risk quantification (FAIR)
    ├── Cyber insurance optimization
    └── Regulatory change management
```

---

## 12. Preparación para Auditorías

### Auditoría ISO 27001

```
Pre-Auditoría (3-6 meses antes)
├── Revisión de la Declaración de Aplicabilidad (SoA)
├── Verificación de que todos los controles del Anexo A están implementados
├── Auditoría interna completa
├── Revisión por dirección documentada
├── Registros de capacitación al personal
├── Registros de gestión de incidentes
├── Registros de gestión de riesgos
└── Evidencia de mejora continua

Durante la Auditoría
├── Etapa 1 (Documental):
│   ├── Revisión de políticas y procedimientos
│   ├── Revisión del SoA
│   ├── Revisión de la evaluación de riesgos
│   └── Revisión de la revisión por dirección
├── Etapa 2 (Implementación):
│   ├── Verificación de implementación de controles
│   ├── Entrevistas con personal
│   ├── Observación de procesos
│   ├── Revisión de registros y evidencias
│   └── Pruebas de efectividad de controles
└── Hallazgos:
    ├── Major NC: Bloquea certificación
    ├── Minor NC: Requiere plan de acción
    └── Oportunidad de mejora (OI)

Post-Auditoría
├── Plan de acción para hallazgos
├── Implementación de correcciones
├── Evidencia de corrección
├── Auditoría de seguimiento (si aplica)
└── Certificación emitida
```

### Auditoría PCI-DSS

```
Pre-Auditoría (3-6 meses antes)
├── Definir alcance del CDE (Cardholder Data Environment)
├── Segmentación de red validada
├── ASV scans trimestrales (si aplica)
├── Escaneos internos de vulnerabilidades
├── Pruebas de penetración anuales
├── Revisión de políticas y procedimientos
├── Registros de acceso (mínimo 12 meses)
├── Registros de monitoreo (mínimo 3 meses online)
└── Evidencia de capacitación en seguridad

Durante la Auditoría (QSA)
├── Entrevistas con personal clave
├── Revisión de configuraciones técnicas
├── Verificación de controles de acceso
├── Revisión de logs y monitoreo
├── Verificación de cifrado
├── Pruebas de segmentación
└── Revisión de contratos con proveedores

Entregables
├── ROC (Report on Compliance) — Nivel 1
├── SAQ (Self-Assessment Questionnaire) — Niveles 2-4
├── AOC (Attestation of Compliance)
└── Remediation plan (si hay hallazgos)
```

### Auditoría SOC 2

```
Pre-Auditoría (6-12 meses antes para Tipo II)
├── Definir Trust Service Criteria aplicables
├── Mapear controles a cada criterio
├── Implementar herramienta de compliance (Drata, Vanta, etc.)
├── Configurar recolección automática de evidencia
├── Establecer período de observación (mínimo 6 meses)
├── Auditoría interna de controles
├── Documentar procesos y procedimientos
└── Preparar evidencia de operación continua

Evidencia Clave para SOC 2
├── Security (CC):
│   ├── Políticas de seguridad de la información
│   ├── Registros de acceso lógico
│   ├── Registros de cambios (change management)
│   ├── Resultados de escaneos de vulnerabilidades
│   ├── Registros de capacitación
│   └── Registros de gestión de incidentes
├── Availability (A):
│   ├── Monitoreo de uptime
│   ├── Pruebas de DR/BCP
│   └── SLAs cumplidos
├── Processing Integrity (PI):
│   ├── Validaciones de datos
│   └── Registros de errores y correcciones
├── Confidentiality (C):
│   ├── Clasificación de datos
│   ├── Controles de acceso a datos confidenciales
│   └── Acuerdos de confidencialidad (NDAs)
└── Privacy (P):
    ├── Avisos de privacidad
    ├── Procesos de consentimiento
    └── Procedimientos de atención de derechos
```

### Auditoría LFPDPPP

```
Pre-Auditoría
├── Verificar avisos de privacidad actualizados
├── Revisar mecanismos de consentimiento
├── Verificar medidas de seguridad implementadas
├── Revisar procedimientos de atención de derechos ARCO
├── Verificar registro de tratamientos de datos
├── Revisar contratos con encargados (proveedores)
├── Verificar programa de capacitación
└── Revisar procedimiento de notificación de brechas

Evidencia Clave
├── Avisos de privacidad (integral, simplificado, corto)
├── Registros de consentimiento
├── Inventario de datos personales
├── Medidas de seguridad documentadas
├── Registros de atención de derechos ARCO
├── Registros de transferencias de datos
├── Registros de violaciones de seguridad
├── Programa de capacitación documentado
└── Designación del encargado de protección de datos
```

---

## 13. Mapeo Cruzado Completo de Frameworks

### Matriz de Correspondencia Principal

| Área de Control | NIST CSF | ISO 27001 | CIS Control | PCI-DSS | SOC 2 | ATT&CK | D3FEND |
|-----------------|----------|-----------|-------------|---------|-------|--------|--------|
| **Gobernanza** | GV.OC, GV.RR, GV.PO | A.5.1, A.5.2 | — | 12.1-12.4 | CC1.1-CC1.5 | — | — |
| **Risk Management** | GV.RM, ID.RA | A.5.3, A.8.2 | — | 12.1.2 | CC3.2, CC3.4 | TA0043 | — |
| **Asset Management** | ID.AM | A.5.9, A.5.12 | 1, 2 | 1.1, 2.1 | CC6.1 | — | — |
| **Access Control** | PR.AC | A.5.15-A.5.18 | 5, 6 | 7, 8 | CC6.1, CC6.3 | TA0001, TA0003, TA0004, TA0006 | Credential Hardening, Authentication |
| **Data Protection** | PR.DS | A.8.10-A.8.12 | 3 | 3, 4 | C1.1, C1.2 | TA0009, TA0010 | Encryption, Key Management |
| **Vulnerability Mgmt** | ID.RA, PR.IP | A.8.8 | 7 | 6.3, 11.3 | CC7.1 | — | — |
| **Logging & Monitoring** | DE.CM, DE.AE | A.8.15-A.8.17 | 8, 13 | 10 | CC7.2, CC7.3 | TA0005, TA0007 | Network Traffic Analysis, Process Analysis |
| **Incident Response** | RS.RP, RS.MI | A.5.24-A.5.28 | 17 | 12.10 | CC7.4, CC7.5 | TA0040 | — |
| **Network Security** | PR.PT | A.8.20-A.8.23 | 12, 13 | 1, 11.4 | CC6.6, CC6.7 | TA0001, TA0008, TA0011 | Egress Filtering, Domain Filtering |
| **Malware Protection** | PR.PT | A.8.7 | 10 | 5 | CC7.2 | TA0002, TA0005 | File Analysis, Platform Monitoring |
| **Security Awareness** | PR.AT | A.6.3 | 14 | 12.6 | CC1.4 | — | — |
| **Encryption** | PR.DS | A.8.24 | 3.6-3.11 | 3.4, 4.1 | C1.2 | — | Encryption, Key Management |
| **Physical Security** | — | A.7.1-A.7.14 | — | 9 | CC6.4, CC6.5 | — | — |
| **Business Continuity** | RC.RP | A.5.29-A.5.30 | 11 | — | A1.2, A1.3 | TA0040 | — |
| **Supplier Management** | GV.SC | A.5.19-A.5.23 | 15 | 12.8, 12.9 | CC9.2 | TA0042 | — |
| **Penetration Testing** | DE.CM | A.8.34 | 18 | 11.4, 11.5 | CC4.1 | TA0043 | — |
| **Privacy** | — | A.5.34 | — | — | P1.0-P8.1 | — | — |
| **Data Protection (LFPDPPP)** | PR.DS | A.8.10-A.8.12 | 3 | 3 | C1.1, C1.2, P | — | Encryption, DLP |

---

## 14. Herramientas de Compliance y GRC

### Plataformas GRC Comerciales

| Herramienta | Frameworks Soportados | Tipo | Ideal Para |
|-------------|----------------------|------|------------|
| **Drata** | SOC 2, ISO 27001, PCI-DSS, HIPAA, NIST CSF | SaaS | Startups y scale-ups |
| **Vanta** | SOC 2, ISO 27001, PCI-DSS, HIPAA | SaaS | Empresas tech |
| **ServiceNow GRC** | Multi-framework | Enterprise | Grandes empresas |
| **RSA Archer** | Multi-framework | Enterprise | Grandes empresas |
| **OneTrust** | Privacy, GDPR, LGPD, LFPDPPP | SaaS | Privacy-focused |
| **Hyperproof** | Multi-framework | SaaS | Mid-market |
| **AuditBoard** | SOX, SOC 2, ISO 27001 | SaaS | Audit management |

### Herramientas Técnicas de Compliance

| Herramienta | Uso | Tipo | Framework |
|-------------|-----|------|-----------|
| **OpenSCAP** | Benchmarking CIS, STIG | Open Source | CIS, NIST |
| **CIS-CAT Pro** | Evaluación CIS Controls | Freemium | CIS |
| **Lynis** | Auditoría de seguridad Linux | Open Source | ISO 27001, PCI-DSS |
| **Prowler** | AWS security/compliance | Open Source | CIS, PCI-DSS, NIST |
| **ScoutSuite** | Multi-cloud compliance | Open Source | CIS, NIST |
| **Nessus / Qualys** | Vulnerability scanning | Comercial | PCI-DSS, ISO 27001 |
| **Wazuh** | SIEM + compliance monitoring | Open Source | PCI-DSS, ISO 27001 |
| **Trivy** | Container security scanning | Open Source | CIS, NIST |
| **Checkov** | IaC security scanning | Open Source | CIS, NIST |
| **Osquery** | Endpoint visibility | Open Source | CIS, NIST |

---

## 15. Entregables de Compliance

### Lista de Entregables

| # | Entregable | Descripción | Framework |
|---|-----------|-------------|-----------|
| 1 | **Gap Assessment Report** | Estado actual vs framework objetivo con heat map | Todos |
| 2 | **Risk Register** | Riesgos identificados con scoring y tratamiento | NIST, ISO 27001 |
| 3 | **Remediation Roadmap** | Plan de acción priorizado por riesgo y esfuerzo | Todos |
| 4 | **Policy Templates** | Plantillas de políticas requeridas por framework | Todos |
| 5 | **Evidence Matrix** | Mapeo de evidencias por control | Todos |
| 6 | **Executive Dashboard** | Resumen visual de cumplimiento para dirección | Todos |
| 7 | **SoA (Statement of Applicability)** | Declaración de aplicabilidad de controles | ISO 27001 |
| 8 | **Treatment Plan** | Plan de tratamiento de riesgos | ISO 27001 |
| 9 | **Avisos de Privacidad** | Avisos integral, simplificado y corto | LFPDPPP |
| 10 | **Audit Readiness Checklist** | Lista de verificación pre-auditoría | Todos |
| 11 | **Control Testing Procedures** | Procedimientos de prueba de controles | SOC 2, ISO 27001 |
| 12 | **Metrics Report** | Métricas de efectividad de controles | Todos |

---

## 16. Plantillas de Documentos

### Plantilla: Gap Assessment Report

```markdown
# Gap Assessment Report — [Framework] para [Cliente]

## Información del Proyecto
- Cliente: [Nombre]
- Framework: [NIST CSF / ISO 27001 / PCI-DSS / SOC 2 / LFPDPPP]
- Fecha de evaluación: [Fecha]
- Evaluador: [BRIDA IT Services]
- Versión: [1.0]

## Resumen Ejecutivo
- Nivel de cumplimiento general: [XX%]
- Controles evaluados: [N]
- Controles cumplidos: [N]
- Controles parciales: [N]
- Controles no cumplidos: [N]
- Gaps críticos: [N]
- Inversión estimada: [Rango]

## Heat Map de Madurez
[Insertar matriz visual de madurez por categoría]

## Hallazgos Detallados
### Gaps Críticos
| ID | Control | Framework | Estado | Hallazgo | Recomendación | Prioridad |
|----|---------|-----------|--------|----------|---------------|-----------|
| G-001 | [Control] | [Ref] | NC | [Descripción] | [Acción] | Crítica |

### Gaps Altos
[Formato similar]

### Gaps Medios
[Formato similar]

### Gaps Bajos
[Formato similar]

## Roadmap de Remediación
[Insertar roadmap por fases]

## Anexos
- A: Lista de controles evaluados
- B: Evidencias recopiladas
- C: Entrevistas realizadas
- D: Mapeo cruzado de frameworks
```

### Plantilla: Política de Seguridad de la Información

```markdown
# Política de Seguridad de la Información — [Cliente]

## 1. Objetivo
Establecer los lineamientos para proteger la información de [Cliente] contra amenazas internas y externas.

## 2. Alcance
Aplica a todo el personal, contratistas, proveedores y terceros que accedan a los activos de información de [Cliente].

## 3. Roles y Responsabilidades
- **Dirección**: Aprobar la política y asignar recursos
- **CISO / Responsable de Seguridad**: Implementar y monitorear
- **TI**: Configurar y mantener controles técnicos
- **Usuarios**: Cumplir con la política y reportar incidentes

## 4. Requisitos
4.1 Control de acceso basado en necesidad de negocio
4.2 Uso de contraseñas robustas y MFA
4.3 Clasificación y manejo de información
4.4 Protección de datos personales (LFPDPPP)
4.5 Reporte de incidentes de seguridad
4.6 Uso aceptable de recursos de TI

## 5. Sanciones
El incumplimiento de esta política puede resultar en acciones disciplinarias.

## 6. Revisión
Esta política se revisa anualmente o ante cambios significativos.

Aprobado por: [Nombre, Cargo]
Fecha: [Fecha]
Versión: [1.0]
```

---

## 17. Métricas y KPIs de Compliance

### Métricas Operacionales

| Métrica | Descripción | Meta | Frecuencia |
|---------|-------------|------|------------|
| % Cumplimiento por framework | Controles cumplidos / Total controles | >90% | Mensual |
| Tiempo de remediación de gaps | Días promedio para cerrar hallazgos | <30 días (crítico) | Mensual |
| Cobertura de parches | Sistemas parcheados / Total sistemas | >95% | Semanal |
| Tasa de phishing | Usuarios que caen en simulacros | <5% | Trimestral |
| Tiempo de detección (MTTD) | Tiempo promedio de detección de incidentes | <24 horas | Mensual |
| Tiempo de respuesta (MTTR) | Tiempo promedio de respuesta a incidentes | <4 horas | Mensual |
| Cobertura de escaneo | Activos escaneados / Total activos | 100% | Mensual |
| Cobertura de backups | Sistemas con backup / Sistemas críticos | 100% | Semanal |
| Cobertura de capacitación | Personal capacitado / Total personal | >95% | Trimestral |
| Hallazgos de auditoría abiertos | Número de hallazgos pendientes | 0 críticos | Mensual |

### Métricas de Madurez

| Métrica | Descripción | Meta a 12 meses |
|---------|-------------|-----------------|
| Nivel de madurez promedio | Promedio de todos los controles | ≥3.0 (Definido) |
| Controles en nivel ≥3 | % de controles en nivel 3 o superior | >80% |
| Controles en nivel 0-1 | % de controles inexistentes o iniciales | <10% |
| Frameworks cubiertos | Número de frameworks con cumplimiento >80% | ≥2 |

---

## 18. Consideraciones por Industria

### Retail / E-commerce
```
Frameworks prioritarios: PCI-DSS, SOC 2, NIST CSF
Regulaciones: LFPDPPP (México), CCPA/CPRA (California)
Riesgos principales: Robo de datos de tarjetas, fraude, skimming
Controles clave: Segmentación CDE, tokenización, ASV scans, WAF
```

### Servicios Financieros
```
Frameworks prioritarios: PCI-DSS, SOC 2, ISO 27001, NIST CSF
Regulaciones: LFPDPPP, CNBV, Banxico (disposiciones de seguridad)
Riesgos principales: Fraude financiero, lavado de dinero cibernético
Controles clave: Monitoreo de transacciones, segregación de funciones, encriptación
```

### Salud / Healthcare
```
Frameworks prioritarios: NIST CSF, ISO 27001, SOC 2
Regulaciones: LFPDPPP (datos de salud = sensibles), NOM-004-SSA3
Riesgos principales: Robo de datos de salud, ransomware
Controles clave: Encriptación de datos sensibles, controles de acceso estrictos
```

### Manufactura / OT
```
Frameworks prioritarios: NIST CSF, CIS Controls, IEC 62443
Regulaciones: LFPDPPP (datos de empleados)
Riesgos principales: Ataques a sistemas OT, interrupción de producción
Controles clave: Segmentación IT/OT, monitoreo de red industrial, redundancia
```

### Gobierno / Sector Público
```
Frameworks prioritarios: NIST CSF, ISO 27001, CIS Controls
Regulaciones: LFPDPPP, Ley General de Transparencia, lineamientos de seguridad
Riesgos principales: Ataques de estado-nación, filtración de datos ciudadanos
Controles clave: Clasificación de información, controles de acceso, auditoría
```

---

## 19. Flujo de Trabajo de Consultoría BRIDA

```
1. Contacto Inicial
   ├── Entender necesidades del cliente
   ├── Identificar frameworks aplicables
   └── Propuesta de servicios

2. Gap Assessment
   ├── Fase 1: Alcance y planificación
   ├── Fase 2: Evaluación
   ├── Fase 3: Análisis y reporte
   └── Fase 4: Presentación de resultados

3. Roadmap de Cumplimiento
   ├── Quick wins (0-3 meses)
   ├── Corto plazo (3-6 meses)
   ├── Mediano plazo (6-12 meses)
   └── Largo plazo (12-24 meses)

4. Implementación
   ├── Desarrollo de políticas y procedimientos
   ├── Implementación de controles técnicos
   ├── Capacitación al personal
   └── Configuración de herramientas GRC

5. Pre-Auditoría
   ├── Auditoría interna
   ├── Remediación de hallazgos
   ├── Preparación de evidencias
   └── Simulacro de auditoría

6. Auditoría Externa
   ├── Acompañamiento durante auditoría
   ├── Soporte en respuestas a auditores
   └── Remediación de hallazgos post-auditoría

7. Mejora Continua
   ├── Monitoreo de cumplimiento
   ├── Actualización de controles
   ├── Re-evaluación periódica
   └── Ajuste de roadmap
```

---

## 20. Referencias y Recursos

### Frameworks y Estándares
- **NIST CSF 2.0**: https://www.nist.gov/cyberframework
- **ISO 27001:2022**: https://www.iso.org/standard/27001
- **CIS Controls v8**: https://www.cisecurity.org/controls/v8
- **PCI-DSS v4.0**: https://www.pcisecuritystandards.org/
- **SOC 2 (AICPA)**: https://www.aicpa.org/interestareas/frc/assuranceadvisoryservices/sorhome.html
- **MITRE ATT&CK**: https://attack.mitre.org/
- **MITRE D3FEND**: https://d3fend.mitre.org/

### Regulación Mexicana
- **LFPDPPP**: https://www.diputados.gob.mx/LeyesBiblio/pdf/259_200220.pdf
- **INAI (Instituto Nacional de Transparencia)**: https://home.inai.org.mx/
- **Ley General de Protección de Datos Personales en Posesión de Sujetos Obligados**: https://www.diputados.gob.mx/LeyesBiblio/pdf/LGPDPPSO.pdf

### Guías de Implementación
- **NIST SP 800-53**: Security and Privacy Controls
- **NIST SP 800-37**: Risk Management Framework
- **NIST SP 800-30**: Guide for Conducting Risk Assessments
- **ISO 27002:2022**: Code of Practice for Information Security Controls
- **ISO 27005:2022**: Information Security Risk Management
- **CIS RAM**: Risk Assessment Method
