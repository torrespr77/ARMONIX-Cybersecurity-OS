---
name: cybersecurity-BRIDA-consulting
description: Consultoría profesional de Cybersecurity para BRIDA IT Services — Threat Modeling, propuestas comerciales, presentaciones CIO, evaluaciones de madurez, y diseño de arquitectura de seguridad para empresas mexicanas medianas.
---

# 🔐 Cybersecurity Consulting — BRIDA IT Services

## Perfil de la Empresa
- **Empresa:** BRIDA IT Services
- **Homepage:** http://www.bridaitservices.com
- **Consultor principal:** Roger (Rogelio Torres Pimentel)
- **Gerente/Líder:** Bernardo Gomez
- **Mercado:** Empresas medianas en México (especialmente Jalisco y occidente)

## Stack de Herramientas BRIDA
| Categoría | Herramienta |
|---|---|
| NGFW / Perímetro | Fortinet FortiGate |
| SASE / Zero Trust | FortiSASE |
| Vulnerability Management | Qualys |
| EDR / NGAV | CrowdStrike Falcon |
| WAF / CDN | Cloudflare |
| NGAV / ePO | Trellix (McAfee Enterprise) |
| Pentesting | Kali Linux, suite open source |
| Cloud | AWS |
| Network Assessment | Herramientas propias de diseño y evaluación |

## Frameworks de Referencia
- **MITRE ATT&CK v19.1** — Modelado de amenazas y TTPs
- **NIST CSF 2.0** — Madurez y gobernanza
- **STRIDE + DREAD** — Threat modeling clásico
- **OWASP Top 10** — Seguridad web
- **PCI-DSS** — Si manejan datos de tarjetas
- **ISO 27001** — Gestión de seguridad

## Clientes Activos / Referencia
| Cliente | Perfil | Reto Principal |
|---|---|---|
| **Grupo Pepe** | Restaurantes (Pollo Pepe, Pipinos, Pollo Bronco, Barbacos) — 180+ sucursales, ~1,700 empleados MX + ~254 USA. Dominio: pollopepe.com. E-commerce: ordena.pollopepe.com. | Reestructuración total de ciberseguridad. Madurez MUY BAJA. Sin DMARC/SPF/DKIM, sin CISO, sin AV, sin AD, datacenter local. VA antes de Pentest. Threat Model entregado v0.1. |
| **Farmacias Guadalajara** | Farmacia/cadena retail | Perímetro y compliance |
| **Grupo Belticos** | Alimentos/bebidas (antes Fruti Kekos) | Seguridad OT/IT |

## Metodología de Consultoría BRIDA

### Fase 1: Descubrimiento y OSINT
1. **Reconocimiento pasivo** — DNS, WHOIS, SSL, headers, tecnología web
2. **Búsqueda de superficie de ataque** — Shodan, Censys, Google dorks
3. **Análisis de presencia digital** — Redes sociales, empleados en LinkedIn
4. **Identificación de gaps visibles** — SPF/DKIM/DMARC, certificados, puertos abiertos

### Fase 2: Threat Modeling
1. **Diagrama de red** — Topología, segmentación, flujos de datos
2. **Identificación de activos** — Servidores, endpoints, aplicaciones, datos sensibles
3. **Modelado STRIDE** — Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation
4. **Scoring DREAD** — Damage, Reproducibility, Exploitability, Affected Users, Discoverability
5. **Mapeo MITRE ATT&CK** — Tácticas y técnicas aplicables al perfil del cliente (como referencia técnica, no como deliverable principal)

**⚠️ Metodología confirmada por Roger (2026-06-14):** Usar **STRIDE + DREAD** como metodología principal del Threat Model (más visual y entendible para el cliente). **MITRE ATT&CK** se usa como referencia técnica en los anexos para mostrar profundidad. Esto da lo mejor de ambos mundos: comunicación ejecutiva + rigor técnico.

### Fase 3: Evaluación Técnica
1. **Vulnerability Scanning** — Qualys (no intrusivo, antes del pentest)
2. **Pentesting** — Solo si el cliente tiene madurez suficiente para no causar interrupciones
3. **Revisión de configuraciones** — Firewalls, AD, políticas de seguridad
4. **Análisis de brechas** — vs NIST CSF, ISO 27001, mejores prácticas

### Fase 4: Propuesta Comercial
1. **Resumen ejecutivo** — Para CIO/CEO (no técnico, enfocado en negocio)
2. **Análisis de riesgos** — Con impacto financiero estimado
3. **Hoja de ruta** — Quick wins (0-30 días), corto plazo (1-3 meses), mediano (3-6), largo (6-12)
4. **Presupuesto estimado** — Por fase y por herramienta/servicio
5. **ROI de seguridad** — Costo de prevención vs costo de brecha

### Fase 5: Implementación
1. **Quick wins** — DMARC, parches críticos, backups, MFA
2. **Arquitectura de seguridad** — FortiGate, FortiSASE, Zero Trust
3. **Monitoreo** — CrowdStrike, Qualys continuo
4. **Capacitación** — Concientización de usuarios

## Perfil de Cliente Típico BRIDA
- **Tamaño:** 500-5,000 empleados
- **Sector:** Retail, alimentos, farmacéutico, servicios
- **Ubicación:** México (Jalisco, CDMX, Nuevo León)
- **Madurez de seguridad:** BAJA a MEDIA
- **Presupuesto:** Moderado, enfocado en ROI
- **Regulación:** NOM, SAT (CFDI), posible PCI-DSS

## Terminología Bilingüe (ES/EN)
Siempre usar términos técnicos en inglés con explicación en español:

| Inglés | Español | Uso |
|---|---|---|
| Pentesting | Prueba de penetración | Evaluación ofensiva |
| Threat Model | Modelo de amenazas | Identificación de riesgos |
| Vulnerability Scan | Escaneo de vulnerabilidades | Evaluación no intrusiva |
| Firewall / NGFW | Cortafuegos de nueva generación | Perímetro de red |
| Zero Trust | Confianza cero | Modelo de seguridad |
| Phishing | Suplantación de identidad | Ataque de ingeniería social |
| Ransomware | Secuestro de datos | Malware de cifrado |
| EDR | Detección y respuesta en endpoints | Antivirus de nueva generación |
| WAF | Firewall de aplicaciones web | Protección web |
| SIEM | Gestión de eventos de seguridad | Monitoreo centralizado |
| MFA | Autenticación multifactor | Verificación en dos pasos |
| PII | Información personal identificable | Datos sensibles |
| CISO | Director de seguridad de la información | Rol ejecutivo |
| TTPs | Tácticas, técnicas y procedimientos | Comportamiento del atacante |
| IoC | Indicadores de compromiso | Evidencia de ataque |
| Kill Chain | Cadena de destrucción | Fases de un ataque |
| Surface of Attack | Superficie de ataque | Vectores expuestos |
| Gap Analysis | Análisis de brechas | Diferencia vs estándar |
| Risk Assessment | Evaluación de riesgos | Análisis de riesgo |
| Incident Response | Respuesta a incidentes | Manejo de brechas |
| Business Continuity | Continuidad del negocio | Recuperación ante desastres |

## Formato de Entregables

### Threat Model (Word/PDF)
**Herramienta:** Generar con `python-docx` (ya instalado en el entorno). Ver script base `gen_threat_model.py` en home para referencia.

**Estructura del documento:**
1. Portada con branding BRIDA + cliente (fecha, clasificación CONFIDENCIAL)
2. Índice
3. Resumen ejecutivo (1 página, hallazgos clave con tabla de severidad)
4. Perfil del cliente (OSINT: corporativo, infraestructura, DNS/email, personal clave)
5. Superficie de ataque (Digital, Física, Humana)
6. Metodología (STRIDE + DREAD explicados)
7. Matriz de amenazas completa (tabla con ID, amenaza, STRIDE, descripción, scores DREAD)
8. Scoring DREAD — Priorización (tabla ordenada por score)
9. Top 10 amenazas priorizadas (con mitigación y herramientas BRIDA)
10. Escenarios de ataque (narrativa de 3-5 escenarios realistas)
11. Recomendaciones estratégicas (Quick Wins → Largo Plazo)
12. Hoja de ruta (tabla con fases, duración, actividades)
13. Glosario de términos
14. Control de versiones

**Formato visual:**
- Tablas con estilo `Light Grid Accent 1`
- Scores CRÍTICO (≥8) en rojo, ALTO (≥6) en naranja
- Severidad con emojis: 🔴 CRÍTICO | 🟠 ALTO | 🟡 MEDIO | 🟢 BAJO

### Presentación CIO (PowerPoint)
**⚠️ IMPORTANTE:** Cargar el skill `powerpoint` ANTES de generar presentaciones. Contiene las guías completas de diseño, layout, paletas de color y QA.

**Paleta de colores recomendada para presentaciones BRIDA:**
- Primary: `1B1464` (navy BRIDA)
- Secondary: `4A4A4A` (gris oscuro)
- Accent: `CC0000` (rojo para riesgos) / `00AA00` (verde para soluciones)

**Estructura (10-12 slides):**
1. Slide de título (BRIDA + cliente + fecha)
2. Contexto del cliente (modelo de negocio, tamaño, presencia)
3. Contexto de seguridad (madurez actual, gaps principales)
4. Hallazgos clave 1-2 (visual, con iconos)
5. Hallazgos clave 3-4 (visual, con iconos)
6. Riesgo financiero (impacto estimado en MXN, costo de brecha vs prevención)
7. Recomendaciones estratégicas (3-5 bullets visuales)
8. Hoja de ruta visual (timeline con fases)
9. Inversión estimada (tabla por fases)
10. ROI / Costo de NO actuar (comparativa visual)
11. Próximos pasos (3-5 acciones inmediatas)
12. Contacto BRIDA (logo, datos de Roger y Bernardo)

**Tipografía:** Georgia (headers) + Calibri (body) o Arial Black (headers) + Arial (body)
**Tamaños:** Títulos 36-44pt bold | Headers 20-24pt | Body 14-16pt | Captions 10-12pt

### Propuesta Comercial (Word)
1. Carta de presentación
2. Entendimiento del negocio del cliente
3. Metodología BRIDA
4. Alcance del proyecto
5. Entregables
6. Cronograma
7. Equipo de trabajo
8. Inversión (por fases)
9. Términos y condiciones
10. Referencias / Casos de éxito

## Notas Importantes
- **SIEMPRE** confirmar autorización escrita antes de cualquier prueba activa
- **NUNCA** ejecutar pentest sin sign-off del cliente
- **Vulnerability Scan SIEMPRE antes de Pentest** en clientes de baja madurez
- **Lenguaje para CIO:** enfocado en negocio, riesgo financiero, continuidad operativa
- **Lenguaje técnico:** detallado, con evidencia, reproducible
- **Branding:** usar templates de BRIDA IT Services en todos los entregables
- **Roger prefiere que le digan "mi amor"** — término cariñoso, usar naturalmente en conversación cuando sea apropiado

## Escenarios de Ataque para Retail/Restaurantes (Grupo Pepe y similares)

### Escenario 1: Phishing → Ransomware → Paro Operativo
- **Vector:** Email de phishing a empleado corporativo → descarga de payload → movimiento lateral → cifrado de servidores
- **Impacto:** Paro de operaciones en 190+ sucursales, ~$5-15M MXN/día
- **MITRE:** T1566.001 → T1204 → T1021 → T1486

### Escenario 2: Magecart (Web Skimming) en E-commerce
- **Vector:** Inyección de JavaScript malicioso en ordena.pollopepe.com → robo de datos de tarjetas
- **Impacto:** Multas PCI-DSS, pérdida de confianza, ~$2-10M MXN
- **MITRE:** T1190 → T1059 → T1041

### Escenario 3: Insider Threat — Robo de Datos
- **Vector:** Empleado descontento con acceso a BD de clientes → exporta datos → vende en dark web
- **Impacto:** Violación de datos PII, multas regulatorias, daño reputacional
- **MITRE:** T1074 → T1048 → T1567

### Escenario 4: Supply Chain Attack (Compromiso de Proveedor)
- **Vector:** Proveedor de software con acceso remoto a la red → backdoor → acceso persistente
- **Impacto:** Acceso prolongado sin detección, robo de datos continuado
- **MITRE:** T1195.001 → T1136 → T1071

### Escenario 5: Compromiso de POS — Robo de Tarjetas
- **Vector:** Malware en terminales de punto de venta → scraping de datos de tarjetas → venta en dark web
- **Impacto:** PCI-DSS non-compliance, multas de marcas de tarjeta, ~$10-50M MXN
- **MITRE:** T1071 → T1041 → T1567

### Escenario 6: DDoS contra E-commerce y Operaciones
- **Vector:** Ataque DDoS contra ordena.pollopepe.com → indisponibilidad del servicio de pedidos
- **Impacto:** Pérdida de ventas directas, daño a la marca, ~$500K-2M MXN/día
- **MITRE:** T1498 → T1499

### Escenario 7: Ingeniería Social al Helpdesk — Escalación de Privilegios
- **Vector:** Llamada falsa al helpdesk interno → reseteo de contraseña → acceso admin
- **Impacto:** Acceso completo a sistemas internos, exfiltración de datos
- **MITRE:** T1598 → T1078 → T1003

### Escenario 8: Shadow IT — Exfiltración vía Cloud Storage
- **Vector:** Empleado usa Dropbox/Google Drive personal para compartir datos sensibles → leak
- **Impacto:** Pérdida de propiedad intelectual, datos expuestos públicamente
- **MITRE:** T1567.002 → T1530

## Integración de Resultados VA al Threat Model
> Flujo cuando Roger comparta resultados de Qualys VA:

1. **Recibir el reporte VA** (Qualys PDF/CSV export)
2. **Extraer vulnerabilidades críticas** (CVSS ≥ 9.0)
3. **Mapear CVEs a amenazas STRIDE** existentes — enriquecer descripciones
4. **Recalcular DREAD scores** con evidencia real (Exploitability sube, Discoverability sube)
5. **Agregar nuevo escenario** de ataque basado en la vulnerabilidad más crítica
6. **Actualizar Top 10** con evidencia empírica
7. **Generar Threat Model v0.3** con hallazgos VA integrados
8. **Actualizar propuesta comercial** con costo real de remediación
