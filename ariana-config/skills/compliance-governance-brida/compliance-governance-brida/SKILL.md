---
name: compliance-governance-brida
description: 'Compliance and governance for BRIDA IT Services clients. Covers NIST CSF, ISO 27001, CIS Controls, PCI-DSS, SOC 2, LGPD/LFPDPPP (Mexican data protection), and regulatory frameworks. Includes gap assessment methodology, compliance roadmap, and audit preparation. Activates for: compliance, governance, NIST, ISO 27001, PCI-DSS, SOC 2, CIS, audit, regulatory, data protection, LFPDPPP.'
domain: cybersecurity
subdomain: compliance-governance
tags:
- compliance
- governance
- NIST-CSF
- ISO-27001
- PCI-DSS
- SOC-2
- CIS-Controls
- LFPDPPP
- audit
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- ID.GV-01
- ID.GV-02
- ID.GV-03
- ID.GV-04
- ID.RA-01
---

# Compliance and Governance — BRIDA IT Services

## Descripción
Cumplimiento normativo y gobernanza para clientes de BRIDA IT Services. Cubre NIST CSF, ISO 27001, CIS Controls, PCI-DSS, SOC 2, LFPDPPP (protección de datos en México) y marcos regulatorios. Incluye metodología de gap assessment, roadmap de cumplimiento y preparación para auditorías.

## Cuándo Usar
- Evaluación de cumplimiento normativo (gap assessment)
- Preparación para auditoría (PCI-DSS, ISO 27001, SOC 2)
- Diseño de programa de cumplimiento
- Implementación de controles de seguridad
- Evaluación de madurez de seguridad
- Cumplimiento de protección de datos (LFPDPPP)

## Frameworks de Cumplimiento

### NIST Cybersecurity Framework (CSF) 2.0
```
Funciones principales:
1. GOVERN (GV) — Gobernanza de riesgos de ciberseguridad
2. IDENTIFY (ID) — Identificar activos, riesgos, amenazas
3. PROTECT (PR) — Implementar salvaguardas
4. DETECT (DE) — Detectar eventos de seguridad
5. RESPOND (RS) — Responder a incidentes
6. RECOVER (RC) — Recuperar capacidades

Categorías clave por función:
- GV: Organizational Context, Risk Management Strategy, Roles, Policy, Oversight
- ID: Asset Management, Risk Assessment, Improvement
- PR: Identity Management, Awareness Training, Data Security, Platform Security, Technology Infrastructure Resilience
- DE: Continuous Monitoring, Adverse Event Analysis
- RS: Incident Management, Incident Analysis, Incident Response Reporting, Incident Mitigation
- RC: Incident Recovery Plan Execution, Incident Recovery Communication
```

### ISO 27001:2022
```
Estructura:
- Cláusulas 4-10: Requisitos del sistema de gestión
- Anexo A: 93 controles (4 temas)

Temas del Anexo A:
1. Organizational controls (37)
2. People controls (8)
3. Physical controls (14)
4. Technological controls (34)

Proceso de certificación:
1. Definir alcance del SGSI
2. Evaluación de riesgos
3. Declaración de Aplicabilidad (SoA)
4. Implementación de controles
5. Auditoría interna
6. Revisión por dirección
7. Auditoría de certificación (Etapa 1 y 2)
8. Certificación
9. Auditorías de vigilancia (anual)
10. Recertificación (cada 3 años)
```

### PCI-DSS v4.0
```
12 Requisitos principales:
1. Instalar y mantener controles de seguridad de red
2. Aplicar configuraciones seguras a todos los componentes del sistema
3. Proteger los datos almacenados de cuentas
4. Proteger los datos de tarjetahabiente con criptografía robusta durante la transmisión
5. Proteger todos los sistemas y redes contra software malicioso
6. Desarrollar y mantener sistemas y software seguros
7. Restringir el acceso a los datos de tarjetahabiente según necesidad de negocio
8. Identificar usuarios y autenticar el acceso a componentes del sistema
9. Restringir el acceso físico a los datos de tarjetahabiente
10. Registrar y monitorear todo el acceso a componentes del sistema y datos de tarjetahabiente
11. Probar regularmente los sistemas y procesos de seguridad
12. Respaldar la seguridad de la información con políticas y programas organizacionales

Niveles de comerciante:
- Nivel 1: >6M transacciones/año → QSA audit required
- Nivel 2: 1-6M transacciones/año → SAQ + posible QSA
- Nivel 3: 20K-1M transacciones/año → SAQ
- Nivel 4: <20K transacciones/año → SAQ
```

### CIS Controls v8
```
18 Controles priorizados:

IG1 (Basic):
1. Inventario y control de activos empresariales
2. Inventario y control de activos de software
3. Protección de datos
4. Configuración segura de activos y software
5. Gestión de cuentas
6. Gestión de controles de acceso

IG2 (Foundational):
7. Gestión continua de vulnerabilidades
8. Gestión de logs de auditoría
9. Protecciones de email y navegador web
10. Defensas contra malware
11. Recuperación de datos
12. Gestión de infraestructura de red

IG3 (Organizational):
13. Monitoreo y defensa de red
14. Gestión de habilidades de seguridad
15. Gestión de proveedores de servicios
16. Sensibilización de seguridad de aplicaciones
17. Gestión de respuesta a incidentes
18. Pruebas de penetración
```

### SOC 2
```
Trust Service Criteria:
1. Security (CC) — Protección contra acceso no autorizado
2. Availability (A) — Disponibilidad del sistema
3. Processing Integrity (PI) — Integridad del procesamiento
4. Confidentiality (C) — Protección de información confidencial
5. Privacy (P) — Protección de información personal

Tipos:
- Tipo I: Diseño de controles en un punto en el tiempo
- Tipo II: Operación efectiva de controles en un período (6-12 meses)
```

### LFPDPPP (Ley Federal de Protección de Datos Personales en Posesión de los Particulares)
```
Principios clave:
- Licitud
- Consentimiento
- Información
- Calidad
- Finalidad
- Lealtad
- Proporcionalidad
- Responsabilidad

Obligaciones:
- Designar un encargado de protección de datos
- Elaborar y publicar avisos de privacidad
- Implementar medidas de seguridad administrativas, técnicas y físicas
- Atender derechos ARCO (Acceso, Rectificación, Cancelación, Oposición)
- Notificar violaciones de seguridad al IAI
- Capacitar al personal en protección de datos

Sanciones:
- Multas de 100 a 320,000 días de salario mínimo
- En caso de datos sensibles: multas de 200 a 640,000 días
- Responsabilidad penal en casos graves
```

## Metodología Gap Assessment

### Fase 1: Alcance y Planificación
```
1. Definir el framework objetivo (NIST CSF, ISO 27001, PCI-DSS, etc.)
2. Definir el alcance (organización, sistemas, ubicaciones)
3. Identificar stakeholders y responsables
4. Establecer cronograma y entregables
5. Recopilar documentación existente (políticas, procedimientos, evidencias)
```

### Fase 2: Evaluación
```
Para cada control/categoría del framework:
1. Revisar documentación existente
2. Entrevistar a responsables
3. Verificar implementación técnica
4. Evaluar nivel de madurez (0-5)
5. Documentar hallazgos y evidencias
6. Calificar cumplimiento: Cumple / Parcial / No Cumple / No Aplica
```

### Escala de Madurez
```
0 - Inexistente: No hay evidencia de implementación
1 - Inicial: Implementación ad-hoc, no documentada
2 - En desarrollo: Procesos definidos pero no consistentes
3 - Definido: Procesos documentados y estandarizados
4 - Gestionado: Procesos medidos y monitoreados
5 - Optimizado: Mejora continua basada en métricas
```

### Fase 3: Análisis y Reporte
```
1. Calcular nivel de cumplimiento por categoría
2. Identificar gaps críticos, altos, medios y bajos
3. Priorizar remediación por riesgo y esfuerzo
4. Crear roadmap de cumplimiento
5. Estimar recursos necesarios
6. Presentar resultados a stakeholders
```

### Fase 4: Roadmap de Cumplimiento
```
Quick Wins (0-3 meses):
- Políticas de seguridad básicas
- Capacitación de conciencia
- Configuraciones de seguridad básicas
- Inventario de activos

Corto Plazo (3-6 meses):
- Implementación de controles técnicos
- Procedimientos de respuesta a incidentes
- Gestión de vulnerabilidades
- Monitoreo básico

Mediano Plazo (6-12 meses):
- Programa de cumplimiento formal
- Auditorías internas
- Métricas y reporting
- Gestión de proveedores

Largo Plazo (12-24 meses):
- Certificación (ISO 27001, SOC 2, PCI-DSS)
- Mejora continua
- Automatización de controles
- Madurez nivel 4-5
```

## Mapeo Cruzado de Frameworks
| Control | NIST CSF | ISO 27001 | CIS | PCI-DSS |
|---|---|---|---|---|
| Asset Management | ID.AM | A.5.9, A.5.12 | 1, 2 | 1.1, 2.1 |
| Access Control | PR.AC | A.5.15-A.5.18 | 5, 6 | 7.1, 8.1 |
| Vulnerability Mgmt | DE.CM | A.8.8 | 7 | 6.3, 11.3 |
| Incident Response | RS.RP | A.5.24-A.5.28 | 17 | 12.10 |
| Data Protection | PR.DS | A.8.10-A.8.12 | 3 | 3.1, 4.1 |
| Security Awareness | PR.AT | A.6.3 | 14 | 12.6 |
| Network Security | PR.PT | A.8.20-A.8.23 | 12, 13 | 1.2, 11.4 |

## Herramientas de Compliance
| Herramienta | Uso | Tipo |
|---|---|---|
| GRC Platforms (ServiceNow, Archer) | Gestión de compliance | Comercial |
| Drata | Automatización SOC 2 / ISO 27001 | Comercial |
| Vanta | Automatización compliance | Comercial |
| OpenSCAP | Benchmarking CIS | Open Source |
| Lynis | Auditoría de seguridad Linux | Open Source |
| CIS-CAT | Evaluación CIS Controls | Open Source |
| Prowler | AWS security/compliance | Open Source |
| ScoutSuite | Multi-cloud compliance | Open Source |

## Entregables de Compliance
1. **Gap Assessment Report** — Estado actual vs framework objetivo
2. **Risk Register** — Riesgos identificados con scoring
3. **Remediation Roadmap** — Plan de acción priorizado
4. **Policy Templates** — Plantillas de políticas requeridas
5. **Evidence Matrix** — Mapeo de evidencias por control
6. **Executive Dashboard** — Resumen visual de cumplimiento
