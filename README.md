# 🔐 BRIDA IT Services — Proyecto de Ciberseguridad

## Descripción

Proyecto integral de ciberseguridad para BRIDA IT Services, incluyendo:
- Penetration Testing (Black Box)
- Vulnerability Assessment
- Propuesta Comercial de Servicios
- Contrato de Servicios de Ciberseguridad
- Manual de Administración de Hermes Agent (Agente Ariana)
- Reportes Ejecutivos

## Estructura del Proyecto

```
brida-security-project/
├── README.md                    # Este archivo
├── docs/                        # Documentación operat│
│   ├── Guia_Reboot_Hermes_Agent.docx
│   ├── Registro_Instrucciones_Ariana_COMPLETO.docx
│   └── .gitkeep
├── reports/                     # Reportes de seguridad
│   ├── ReportE_Pentest_BlackBox_bridaitservices.com.docx
│   ├── Presentacion_Ejecutiva_Berni_BRIDA_Seguridad.docx
│   ├── Reporte_Ejecutivo_CEO_BRIDA_Seguridad.docx
│   └── Reporte_Seguridad_BRIDA_IT_Services.docx
├── contracts/                   # Contratos y propuestas
│   ├── Contrato_Servicios_Ciberseguridad_BRIDA.docx
│   └── Propuesta_Ciberseguridad_BRIDA_IT_Services.docx
├── skills/                      # Skills de Hermes Agent
│   └── .gitkeep
└── scripts/                     # Scripts de seguridad
    └── .gitkeep
```

## Hallazgos Clave del Pentest

**Score de Seguridad: 52/100 (REGULAR)**

| Categoría | Score | Estado |
|---|---|---|
| SSL/TLS | 85/100 | ✅ Bueno |
| Infraestructura | 70/100 | ✅ Bueno |
| Superficie de Ataque | 60/100 | ⚠️ Regular |
| Exposición Info | 45/100 | ⚠️ Regular |
| Seguridad Web | 40/100 | ❌ Débil |
| Seguridad Correo | 35/100 | ❌ Débil |
| Vulnerabilidades | 30/100 | ❌ Débil |

## Vulnerabilidades Críticas

1. **Sin DMARC** — Riesgo de spoofing de correo @bridaitservices.com
2. **Puertos 8080/8443 abiertos** — Posible exposición de servicios
3. **Sin Content-Security-Policy** — Riesgo XSS
4. **WordPress versión expuesta** — Facilita ataques dirigidos

## Propuesta de Servicios

### Fase 1: Remediación Crítica (0-15 días) — $20,000 MXN
- Implementar DMARC
- Cerrar puertos innecesarios
- Agregar headers de seguridad

### Fase 2: Hardening (15-45 días) — $40,000 MXN
- CSP, WAF, backups
- Hardening WordPress

### Fase 3: Operación Continua — $15,000 MXN/mes
- VA mensual con Qualys
- Pentest trimestral
- Respuesta a incidentes

**Total Primer Año: $245,000 MXN**

## Contacto

**Ing. Rogelio Torres Pimentel**
Senior Cybersecurity Consultant / Architect
- LinkedIn: https://www.linkedin.com/in/rogeliotorres/
- Email: rogelio.torres.pimentel@gmail.com
- Móvil: +52 33 1486 9253

---

*Documento generado: Junio 2026 — BRIDA IT Services*
