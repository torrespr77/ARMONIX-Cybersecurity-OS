# Threat Modeling for Cybersecurity Proposals — BRIDA IT Services

> **Metodología confirmada por Roger (2026-06-14):** Usar **STRIDE + DREAD** como metodología principal del Threat Model. **MITRE ATT&CK** como referencia técnica en anexos. Mejor de ambos mundos: comunicación ejecutiva + rigor técnico.

## Framework Selection

| Criterio | STRIDE + DREAD | MITRE ATT&CK |
|---|---|---|
| Mejor para | Deliverable principal | Anexo técnico |
| Granularidad | 6 categorías | 14 tácticas, cientos de técnicas |
| **Recomendación** | **✅ Principal** | **✅ Anexo** |

## VA vs Pentest

| Madurez | Primera Acción | Por Qué |
|---|---|---|
| Muy Baja (sin AV/AD/EDR) | **Vulnerability Assessment** | Pentest puede causar interrupción |
| Media | VA → Pentest scopeado | Validar primero |
| Alta | Pentest completo | Infraestructura soporta |

## Workflow

1. Definir alcance (activos, topología, trust boundaries)
2. Identificar adversarios (ransomware, BEC, insider, crimen organizado MX)
3. Modelar STRIDE (Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation)
4. Scoring DREAD (Damage, Reproducibility, Exploitability, Affected Users, Discoverability)
5. Mapear MITRE ATT&CK (anexo técnico)
6. Mapear gaps vs soluciones BRIDA

## Estructura Entregable (Word)

1. Portada → 2. Índice → 3. Resumen Ejecutivo → 4. Perfil Cliente → 5. Superficie Ataque → 6. Metodología → 7. Matriz STRIDE+DREAD → 8. Scoring DREAD → 9. Top 10 → 10. Escenarios (3-8) → 11. Recomendaciones → 12. Hoja de Ruta → 13. Glosario → 14. Control Versiones

## Escenarios Retail/Restaurantes

| # | Escenario | Impacto | MITRE |
|---|---|---|---|
| 1 | Phishing → Ransomware | $5-15M MXN/día | T1566→T1486 |
| 2 | Magecart E-commerce | $2-10M MXN | T1190→T1041 |
| 3 | Insider Threat | PII leak | T1074→T1567 |
| 4 | Supply Chain | Acceso prolongado | T1195→T1071 |
| 5 | POS Compromise | $10-50M MXN | T1071→T1567 |
| 6 | DDoS E-commerce | $500K-2M/día | T1498 |
| 7 | Social Engineering Helpdesk | Acceso total | T1598→T1078 |
| 8 | Shadow IT | IP leak | T1567→T1530 |

## Pitfalls
- No jerga técnica ante ejecutivos
- No saltarse VA en clientes frágiles
- Sucursales = mayor riesgo
- Considerar crimen organizado MX
