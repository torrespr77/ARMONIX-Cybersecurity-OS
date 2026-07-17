# Threat Model C&A México v4.0 - Referencia de Sesión

**Cliente:** C&A México (cyamoda.com)
**Entregable:** Threat_Model_CyA_Mexico_v4.0.docx
**Fecha:** Junio 2026
**Autor:** Ing. Rogelio Torres Pimentel - Senior Cybersecurity Consultant / Architect
**Ubicación:** `/home/hermes/.hermes/output/Threat_Model_CyA_Mexico_v4.0.docx`

---

## Resumen del Proyecto

Threat Model completo para C&A México (retail fashion, 84 tiendas, 3,500+ empleados, Salesforce Commerce Cloud). Entregado v4.0 con correcciones solicitadas por Roger (ortografía español mexicano, autor/contacto actualizado, Cloudflare CDN/WAF como control existente, sin referencias a BRIDA IT Services).

---

## Hallazgos Críticos (Top 5)

| # | Hallazgo | Severidad | Impacto |
|---|----------|-----------|---------|
| 1 | Certificado EV expira 18 sep 2026 (92 días) | 🔴 CRÍTICO | Advertencias "No seguro" en navegadores, pérdida ventas |
| 2 | 4 subdominios sin TLS: contenido, crédito, devoluciones, mi | 🔴 CRÍTICO | Tráfico PII/datos financieros en texto plano |
| 3 | Sin SPF/DKIM/DMARC en @cyamoda.com | 🔴 CRÍTICO | Phishing/BEC sin barrera |
| 4 | Sin header HSTS | 🟠 ALTO | Vulnerable a SSL stripping |
| 5 | Cuentas heredadas (COFRA/Delbora) tras adquisición Grupo Alfar 2023 | 🔴 CRÍTICO | Puertas traseras, espionaje corporativo |

---

## Metodología Aplicada

- **STRIDE + DREAD** (Microsoft) - 27 amenazas clasificadas y puntuadas
- **PTES** - Penetration Testing Execution Standard
- **Análisis TLS/HTTPS activo** - openssl s_client, curl, nslookup
- **OSINT** - LinkedIn, Google dorking, Wayback Machine, DNS, certificados CT logs

---

## Superficie de Ataque Identificada

### Dominios y Subdominios (8 activos)

| Subdominio | Función | Certificado | Estado |
|------------|---------|-------------|--------|
| cyamoda.com / www.cyamoda.com | E-commerce principal (SFCC) | DigiCert EV | ⚠️ Expira 92 días |
| careers.cyamoda.com | Reclutamiento | Sectigo DV | ✅ Válido 267 días |
| facturacion.cyamoda.com | Facturación electrónica/CFDI | Thawte Wildcard | ✅ Válido 215 días |
| contenido.cyamoda.com | Repositorio marca | **NINGUNO** | ❌ SIN TLS |
| credito.cyamoda.com | Soluciones crédito | **NINGUNO** | ❌ SIN TLS |
| devoluciones.cyamoda.com | Logística inversa | **NINGUNO** | ❌ SIN TLS |
| mi.cyamoda.com | Autogestión tarjetahabientes | **NINGUNO** | ❌ SIN TLS |
| cyamoda.sherlockhr.com | Vacantes (SaaS externo) | Terceros | Superficie terceros |

### Stack Tecnológico

| Componente | Tecnología | Confianza |
|------------|------------|-----------|
| E-commerce | Salesforce Commerce Cloud (Demandware) siteId "Cya_MX" | ALTA |
| CDN/WAF/DDoS | **Cloudflare** (headers cf-ray, cf-cache-status) | ALTA |
| Web Server | Apache / Tengine | MEDIA |
| Database | MySQL | MEDIA |
| Frontend | jQuery, FancyBox | MEDIA |
| Reviews | Yotpo | MEDIA |
| Comunicación | WhatsApp Business | MEDIA |
| Hosting/Telecom | Alestra (México) | MEDIA |

### Hallazgos TLS/HTTPS

| Hallazgo | Severidad |
|----------|-----------|
| TLS 1.3 por defecto (TLS_AES_256_GCM_SHA384) | ✅ POSITIVO |
| TLS 1.2 soportado (ECDHE-RSA-AES256-GCM-SHA384) | ✅ POSITIVO |
| TLS 1.0/1.1 deshabilitados | ✅ POSITIVO |
| Cookies Secure + HttpOnly + SameSite=None | ✅ POSITIVO |
| HTTP/3 (QUIC) soportado | ✅ POSITIVO |
| **HSTS AUSENTE** | 🟠 ALTO |
| **CSP básico (solo frame-ancestors)** | 🟠 MEDIO |
| Headers faltantes: X-XSS-Protection, Referrer-Policy, Permissions-Policy | 🟠 MEDIO |
| 3 CAs distintas (DigiCert, Sectigo, Thawte) | 🟡 MEDIO |

---

## Matriz de Amenazas STRIDE + DREAD (27 amenazas)

### Top 10 por Score DREAD

| Prioridad | STRIDE | ID | Amenaza | Score | Nivel |
|-----------|--------|-----|---------|-------|-------|
| 1 | SPOOFING | SP-01 | Phishing sin SPF/DKIM/DMARC | 15 | 🔴 CRÍTICO |
| 2 | TLS | TL-01 | Expiración certificado EV 92 días | 15 | 🔴 CRÍTICO |
| 3 | SPOOFING | SP-04 | Suplantación marca redes sociales | 14 | 🔴 CRÍTICO |
| 4 | TAMPERING | TA-02 | Cross-Site Scripting (XSS) | 14 | 🔴 CRÍTICO |
| 5 | TLS | TL-03 | Ausencia header HSTS | 13 | 🟠 ALTO |
| 6 | INFO DISC | ID-05 | Errores configuración expuestos | 13 | 🟠 ALTO |
| 7 | DoS | DS-03 | Ransomware operaciones retail | 12 | 🟠 ALTO |
| 8 | INFO DISC | ID-01 | Fuga PII clientes | 12 | 🟠 ALTO |
| 9 | INFO DISC | ID-04 | APIs sin autenticación adecuada | 12 | 🟠 ALTO |
| 10 | TAMPERING | TA-01 | SQL Injection e-commerce | 12 | 🟠 ALTO |

### Distribución por Categoría

| Categoría | Amenazas | Score Máx | Nivel Global |
|-----------|----------|-----------|--------------|
| SPOOFING | 4 | 15 | 🔴 CRÍTICO |
| TAMPERING | 4 | 14 | 🔴 CRÍTICO |
| REPUDIACIÓN | 3 | 10 | 🟡 MEDIO |
| DIVULGACIÓN INFO | 5 | 13 | 🟠 ALTO |
| DENEGACIÓN SERVICIO | 3 | 12 | 🟠 ALTO* |
| ELEVACIÓN PRIVILEGIOS | 5 | 11 | 🟠 ALTO |
| TLS/CERTIFICADOS | 3 | 15 | 🔴 CRÍTICO |
| **TOTAL** | **27** | **15 (máx)** | 🔴 **CRÍTICO** |

*Nota: Scores DoS ajustados considerando protección Cloudflare CDN/WAF existente

---

## Escenarios de Ataque (8 narrativas con impacto MXN)

| # | Escenario | Severidad | Impacto Estimado |
|---|-----------|-----------|------------------|
| 8.1 | Phishing masivo sin DMARC → Fraude financiero | 🔴 CRÍTICO | $500K - $5M MXN |
| 8.2 | Expiración certificado → Pérdida confianza | 🔴 CRÍTICO | $5M - $50M MXN |
| 8.3 | XSS en e-commerce → Robo sesiones | 🔴 CRÍTICO | $2M - $50M MXN |
| 8.4 | Ransomware vía phishing → Paro 84 tiendas | 🟠 ALTO | $10M - $100M MXN |
| 8.5 | Explotación API → Extracción masiva datos | 🟠 ALTO | $5M - $50M MXN |
| 8.6 | Suplantación Instagram → Estafa clientes | 🟠 ALTO | $1M - $20M MXN |
| 8.7 | Cuentas heredadas → Espionaje corporativo | 🟠 ALTO | $5M - $30M MXN |
| 8.8 | DDoS temporada alta → Pérdidas millonarias | 🟠 ALTO | $5M - $50M MXN |

---

## Recomendaciones Estratégicas (Roadmap 6 Fases)

| Fase | Período | Actividades Principales | Entregable | Inversión |
|------|---------|-------------------------|------------|-----------|
| 0: OSINT | Completado | Reconocimiento pasivo + Análisis TLS/HTTPS | **Este Threat Model v4.0** | Incluido |
| 1: Quick Wins | Sem 1-4 | Renovar cert EV, certs subdominios, SPF/DKIM/DMARC, HSTS, MFA, WAF | Reporte implementación | $ |
| 2: Assessment | Mes 2-3 | VA (Qualys) + Pentest externo e-commerce, APIs, apps móviles | Hallazgos + remediación | $$ |
| 3: EDR + Segmentación | Mes 3-4 | CrowdStrike/Trellix + Segmentación red | Ambiente protegido | $$$ |
| 4: NGFW + WAF | Mes 4-6 | FortiGate + Optimización Cloudflare + FortiSASE | Perímetro robusto | $$$$ |
| 5: SOC + IR | Mes 6-9 | Monitoreo 24/7 + Plan respuesta + Capacitación | Operaciones seguridad | $$$$ |
| 6: Madurez | Mes 9-12 | Red Team + ISO 27001 + Bug Bounty | Programa maduro | $$$$ |

---

## Quick Wins (0-30 días) - CRÍTICOS

| # | Acción | Beneficio | Prioridad |
|---|--------|-----------|-----------|
| 1 | Renovar certificado EV (expira 18 sep 2026) | Evita warnings navegadores | 🔴 CRÍTICA |
| 2 | Instalar certificados TLS en 4 subdominios faltantes | Cifrado completo servicios | 🔴 CRÍTICA |
| 3 | Implementar SPF, DKIM, DMARC (política none) | Elimina suplantación básica | 🔴 CRÍTICA |
| 4 | Agregar header HSTS | Previene SSL stripping | 🟠 ALTA |
| 5 | Habilitar MFA en todas las cuentas corporativas | Previene 99% ataques credenciales | 🔴 CRÍTICA |
| 6 | Revocar cuentas heredadas (COFRA/Delbora) | Cierra puertas traseras | 🟠 ALTA |
| 7 | Headers faltantes (X-XSS, Referrer, Permissions) | Mejora seguridad navegador | 🟡 MEDIA |
| 8 | Reglas WAF personalizadas Cloudflare | Protección capa 7 adicional | 🟠 ALTA |

---

## Formato de Entrega BRIDA

- **Autor en portada y pie:** "Ing. Rogelio Torres Pimentel, Consultor en Ciberseguridad"
- **Idioma:** Español mexicano
- **Formatos:** Word editable (.docx) + PDF
- **Frameworks:** MITRE ATT&CK, STRIDE+DREAD, NIST CSF, ISO 27001
- **Visuales:** Headers sombreados, badges severidad colores, DREAD scores visuales, escenarios numerados
- **Sin referencias a BRIDA IT Services** (requisito v4.0)

---

## Referencias Técnicas

- **Archivo fuente:** `/home/hermes/.hermes/output/Threat_Model_CyA_Mexico_v4.0.docx` (1,738 líneas, 59KB)
- **Versiones previas:** v1.0, v2.0, v3.0 en mismo directorio
- **Generador:** `/home/hermes/Documents/gen_threat_model.py`
- **Metodología:** `/home/hermes/.hermes/skills/.archive/cybersecurity-client-recon/references/threat-modeling-methodology.md`

---

## Notas para Próximas Sesiones

1. **Roger pidió explícitamente:** "NO usar BRIDA IT Services en documentos cliente" → v4.0 lo cumple
2. **Ortografía español mexicano** corregida en v4.0 (no "estándar" español peninsular)
3. **Cloudflare CDN/WAF** debe considerarse SIEMPRE como control existente en mitigaciones DoS
4. **Formato ejecutivo:** Roger consume notas de voz en descansos → resúmenes con bullets y badges visuales
5. **Entregables Word editables** - nunca PDF-only para cliente final

---

*Última actualización: Julio 10, 2026 - Sesión con Roger (recuperación entregable v4.0)*