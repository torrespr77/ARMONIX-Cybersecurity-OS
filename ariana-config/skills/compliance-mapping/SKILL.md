---
name: compliance-mapping
description: Compliance Mapping
category: cybersecurity
---# Skill: Compliance Mapping — NIST CSF, ISO 27001, CIS, PCI-DSS

## Descripción
Guía de mapeo de frameworks de cumplimiento y seguridad (NIST CSF, ISO 27001, CIS Controls, PCI-DSS) para clientes de BRIDA IT Services, incluyendo gap assessment y roadmap de cumplimiento.

## Cuándo Usar
- Cliente requiere cumplimiento regulatorio
- Preparación para auditoría de seguridad
- Gap assessment inicial
- Diseño de programa de seguridad
- Propuesta de servicios de cumplimiento

## Frameworks de Referencia

### NIST Cybersecurity Framework (CSF) 2.0

| Función | Descripción | Categorías |
|---|---|---|
| **GOVERN** | Establecer y monitorear estrategia de riesgo | Organizational Context, Risk Management Strategy, Roles, Policy, Oversight |
| **IDENTIFY** | Comprender activos y riesgos | Asset Management, Risk Assessment, Improvement |
| **PROTECT** | Implementar salvaguardas | Identity Management & Access Control, Awareness Training, Data Security, Platform Security, Technology Infrastructure Resilience |
| **DETECT** | Descubrir eventos de seguridad | Continuous Monitoring, Adverse Event Analysis |
| **RESPOND** | Tomar acción ante incidentes | Incident Management, Incident Analysis, Incident Response Reporting, Incident Mitigation |
| **RECOVER** | Restaurar capacidades | Incident Recovery Plan Execution, Incident Recovery Communication |

### ISO 27001:2022 — Controles (93 controles en 4 temas)

| Tema | Controles | Ejemplos |
|---|---|---|
| **Organizational** (37) | Políticas, roles, threat intelligence, asset management, access control, supplier relationships |
| **People** (8) | Screening, terms of employment, awareness, disciplinary process |
| **Physical** (14) | Perimeters, physical entry, securing offices, monitoring, equipment |
| **Technological** (34) | Endpoint devices, privileged access, source code, web filtering, cryptography, malware protection, logging, network security |

### CIS Controls v8 (18 controles)

| Control | Nombre | IG1 | IG2 | IG3 |
|---|---|---|---|---|
| 1 | Inventory and Control of Enterprise Assets | ✅ | ✅ | ✅ |
| 2 | Inventory and Control of Software Assets | ✅ | ✅ | ✅ |
| 3 | Data Protection | ✅ | ✅ | ✅ |
| 4 | Secure Configuration of Enterprise Assets | ✅ | ✅ | ✅ |
| 5 | Account Management | ✅ | ✅ | ✅ |
| 6 | Access Control Management | ✅ | ✅ | ✅ |
| 7 | Continuous Vulnerability Management | ✅ | ✅ | ✅ |
| 8 | Audit Log Management | ✅ | ✅ | ✅ |
| 9 | Email and Web Browser Protections | ✅ | ✅ | ✅ |
| 10 | Malware Defenses | ✅ | ✅ | ✅ |
| 11 | Data Recovery | ✅ | ✅ | ✅ |
| 12 | Network Infrastructure Management | ✅ | ✅ | ✅ |
| 13 | Network Monitoring and Defense | | ✅ | ✅ |
| 14 | Security Awareness and Skills Training | | ✅ | ✅ |
| 15 | Service Provider Management | | ✅ | ✅ |
| 16 | Application Software Security | | ✅ | ✅ |
| 17 | Incident Response Management | | ✅ | ✅ |
| 18 | Penetration Testing | | | ✅ |

### PCI-DSS v4.0 (12 requisitos)

| Requisito | Descripción | Aplica a Grupo Pepe |
|---|---|---|
| 1 | Install and maintain network security controls | ✅ Si procesa tarjetas |
| 2 | Apply secure configurations to all system components | ✅ |
| 3 | Protect stored account data | ✅ Si almacena datos de tarjeta |
| 4 | Protect cardholder data with strong cryptography during transmission | ✅ |
| 5 | Protect all systems and networks from malicious software | ✅ |
| 6 | Develop and maintain secure systems and software | ✅ |
| 7 | Restrict access to system components by business need-to-know | ✅ |
| 8 | Identify users and authenticate access | ✅ |
| 9 | Restrict physical access to cardholder data | ✅ Si hay POS físicos |
| 10 | Log and monitor all access | ✅ |
| 11 | Test security of systems and networks regularly | ✅ |
| 12 | Support organizational policies and programs | ✅ |

## Mapeo Cruzado de Frameworks

| Área | NIST CSF | ISO 27001 | CIS Control | PCI-DSS |
|---|---|---|---|---|
| Asset Management | ID.AM | A.5.9, A.5.12 | CIS 1, 2 | Req 1.2, 2.1 |
| Access Control | PR.AC | A.5.15-A.5.18 | CIS 5, 6 | Req 7, 8 |
| Vulnerability Management | ID.RA, PR.IP | A.8.8 | CIS 7 | Req 6.3, 11.3 |
| Logging & Monitoring | DE.AE, DE.CM | A.8.15-A.8.17 | CIS 8, 13 | Req 10 |
| Incident Response | RS.RP, RS.CO | A.5.24-A.5.28 | CIS 17 | Req 12.10 |
| Network Security | PR.AC, PR.PT | A.8.20-A.8.23 | CIS 12, 13 | Req 1 |
| Malware Protection | PR.PT | A.8.7 | CIS 10 | Req 5 |
| Data Protection | PR.DS | A.5.10, A.8.11 | CIS 3 | Req 3, 4 |
| Security Awareness | PR.AT | A.6.3 | CIS 14 | Req 12.6 |
| Penetration Testing | DE.CM | A.8.34 | CIS 18 | Req 11.4 |
| Email Security | PR.DS | A.6.7 | CIS 9 | Req 5.3 |
| Encryption | PR.DS | A.8.24 | CIS 3.6-3.11 | Req 3.4, 4.1 |

## Gap Assessment — Metodología BRIDA

### Paso 1: Seleccionar Framework Base
- **Sin requisito específico:** NIST CSF (más flexible)
- **Cliente enterprise/ISO:** ISO 27001
- **Cliente retail/pagos:** PCI-DSS + NIST CSF
- **Quick assessment:** CIS Controls IG1 (56 prácticas)

### Paso 2: Evaluar Madurez por Control
| Nivel | Descripción | Score |
|---|---|---|
| **0 - Inexistente** | No existe el control | 0% |
| **1 - Inicial** | Ad-hoc, no documentado | 25% |
| **2 - En desarrollo** | Documentado pero no consistente | 50% |
| **3 - Definido** | Documentado y consistente | 75% |
| **4 - Gestionado** | Medido y monitoreado | 90% |
| **5 - Optimizado** | Mejora continua basada en métricas | 100% |

### Paso 3: Generar Heat Map
Crear matriz visual de madurez por área:

```
                    N1  N2  N3  N4  N5
Gobernanza          ██              
Activos             ███             
Acceso              ██              
Vulnerabilidades    █               
Monitoreo           █               
Respuesta           █               
Recuperación        ██              
```

### Paso 4: Roadmap de Cumplimiento
Priorizar por:
1. **Riesgo más alto** (vulnerabilidades críticas primero)
2. **Quick wins** (SPF/DKIM/DMARC, MFA, backups)
3. **Requisito regulatorio** (si hay deadline)
4. **Costo-beneficio** (mayor impacto con menor inversión)

## Aplicación para Grupo Pepe

### Estado Actual Estimado
| Área | Madurez | Hallazgo |
|---|---|---|
| Gobernanza | N1 | Sin CISO, sin políticas formales |
| Asset Management | N1 | Sin inventario formal |
| Access Control | N1 | Sin AD, sin MFA |
| Vulnerability Mgmt | N0 | Sin Qualys ni escaneos |
| Network Security | N1 | Sin firewall enterprise |
| Endpoint Security | N0 | Sin AV/EDR corporativo |
| Email Security | N0 | Sin SPF/DKIM/DMARC |
| Logging & Monitoring | N0 | Sin SIEM ni logging centralizado |
| Incident Response | N0 | Sin plan documentado |
| Recovery | N1 | Backups no verificados |

### Roadmap Propuesto (12 meses)
**Mes 1-3 (Quick Wins):**
- SPF/DKIM/DMARC en todos los dominios
- MFA en Google Workspace
- Inventario de activos
- Políticas de seguridad básicas

**Mes 4-6 (Fundamentos):**
- FortiGate deployment (corporativo + sucursales)
- EDR deployment (CrowdStrike o Trellix)
- Qualys deployment + primer escaneo
- AD implementation

**Mes 7-9 (Madurez):**
- Vulnerability management program
- Security awareness training
- Incident response plan
- Network segmentation

**Mes 10-12 (Optimización):**
- SIEM deployment
- Pentest
- Compliance audit
- Continuous improvement program
