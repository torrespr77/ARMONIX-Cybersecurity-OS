# Caso de Estudio: C&A México (cyamoda.com)

## Perfil del Cliente
- **Empresa:** C&A México, S. de R.L. de C.V.
- **Grupo:** Grupo Alfar (adquirida en 2023, antes COFRA Holding AG)
- **CEO:** Gabriela Villalobos (desde febrero 2024)
- **Dominio:** cyamoda.com
- **Sector:** Retail / Fashion / E-commerce
- **Tiendas:** 84 en más de 50 ciudades
- **Colaboradores:** 3,500+
- **Sede:** San Pedro Tlaquepaque, Jalisco

## Stack Tecnológico
- **E-commerce:** Salesforce Commerce Cloud (Demandware), site ID "Cya_MX"
- **CDN/WAF:** Cloudflare (confirmado via headers)
- **Servidor:** Apache / Tengine
- **BD:** MySQL
- **Frontend:** jQuery, FancyBox
- **App Móvil:** C&A MEXICO (com.cyamoda.android.prod) — Google Play

## Hallazgos Clave de Seguridad

### Certificados TLS
- **Principal:** DigiCert EV RSA CA G2, expira Sep 18 2026 (92 días desde junio 2026)
- **Subdominios sin certificado:** contenido, credito, devoluciones, mi (4 subdominios)
- **Mezcla de CAs:** DigiCert (principal), Sectigo (careers), Thawte (facturacion wildcard)
- **Protocolo:** TLS 1.3 por defecto, TLS 1.2 soportado
- **Cipher:** TLS_AES_256_GCM_SHA384 (TLS 1.3), ECDHE-RSA-AES256-GCM-SHA384 (TLS 1.2)

### Headers de Seguridad
- ✅ Presentes: CSP (frame-ancestors), X-Content-Type-Options, Cache-Control, Secure cookies
- ❌ Faltantes: HSTS, X-Frame-Options, X-XSS-Protection, Referrer-Policy, Permissions-Policy

### DNS/IP
- **IP:** 189.206.52.176
- **CDN:** Cloudflare (cf-ray header presente)
- **HTTP/3:** Soportado (alt-svc: h3=":443")

### Presencia Digital
- Facebook: 2.39M | Instagram: 576K | LinkedIn: ~1,500 empleados

## Amenazas Principales Identificadas
1. Phishing sin SPF/DKIM/DMARC (Score 15)
2. DDoS contra e-commerce (Score 15)
3. Expiración cert EV en 92 días (Score 15)
4. Suplantación de marca en RRSS (Score 14)
5. XSS en portal web (Score 14)
6. Ausencia de HSTS (Score 13)
7. Subdominios sin certificado TLS (Score 12)
8. Fuga de PII de clientes (Score 12)
9. Ransomware en operaciones retail (Score 12)
10. APIs sin autenticación (Score 12)

## Documentos Entregados
- Threat Model v1.0 (21 amenazas, formato básico)
- Threat Model v2.0 (mejorado con tablas y badges)
- Threat Model v3.0 (integrado análisis TLS/HTTPS, 27 amenazas, formato profesional para IT)

## Lecciones Aprendidas
- El análisis de certificados TLS debe ser parte estándar del OSINT para clientes con e-commerce
- Los subdominios sin certificado son un hallazgo crítico que debe elevarse inmediatamente
- La expiración de certificados EV es un escenario de ataque legítimo para Threat Models
- Incluir sección de headers de seguridad HTTP en el análisis OSINT
- El formato de documento debe ser consistente entre versiones (control de versiones)
