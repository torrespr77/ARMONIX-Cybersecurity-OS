---
name: cybersecurity-consulting
description: Metodología de consultoría en ciberseguridad — Threat Modeling, evaluación de vulnerabilidades, diseño de arquitectura, y propuestas comerciales para empresas mexicanas medianas.
---

# Skill: Cybersecurity Consulting

## Descripción
Metodología de consultoría en ciberseguridad para clientes enterprise en México.

## Stack de Herramientas
- **Firewall/NGFW:** Fortinet FortiGate, FortiSASE (Zero Trust Network Access)
- **Vulnerability Management:** Qualys VMDR
- **EDR/XDR:** CrowdStrike Falcon, Trellix ePO + Trellix Endpoint Security
- **CDN/WAF/DDoS:** Cloudflare
- **Pentesting/Ethical Hacking:** Kali Linux, suite of open-source tools
- **Cloud:** AWS (seguridad en la nube)
- **Email Security:** Google Workspace + SPF/DKIM/DMARC

## Metodología de Consultoría

### Fase 1: Descubrimiento y Assessment
1. **OSINT** — Reconocimiento pasivo (DNS, WHOIS, SSL, headers, tecnología)
2. **Análisis de certificados TLS/HTTPS** — Verificar validez, emisor, vigencia, subdominios, protocolos, cipher suites, headers de seguridad HTTP. Ver guía en `references/tls-certificate-analysis.md`
3. **Inventario de Activos** — Servidores, endpoints, red, cloud
4. **Vulnerability Scanning** — Qualys/Nessus scan sin autenticación y con credenciales
5. **Threat Modeling** — STRIDE + DREAD (o MITRE ATT&CK para detalle técnico)
6. **Gap Analysis** — Comparar contra frameworks (NIST CSF, ISO 27001, CIS Controls)

### Fase 2: Penetration Testing (si aplica)
1. **Reconocimiento activo** — Nmap, enum4linux, dnsrecon
2. **Explotación** — Metasploit, manual techniques
3. **Post-explotación** — Pivoting, escalamiento, persistencia
4. **Reporting** — Executive Summary + Technical Details + Remediation Plan

### Fase 3: Diseño de Arquitectura de Seguridad
1. **Perimetral** — FortiGate NGFW, IPS/IDS, SSL Inspection
2. **Email Security** — SPF, DKIM, DMARC, sandboxing
3. **Identity** — AD hardening, MFA, Zero Trust (FortiSASE)
4. **Endpoint** — CrowdStrike o Trellix como EDR corporativo
5. **Network Segmentation** — VLANs, microsegmentación
6. **Vulnerability Management** — Qualys deployment y Continuous Monitoring
7. **Cloud Security** — AWS Security Groups, IAM, CloudTrail, GuardDuty

### Fase 4: Implementación
1. Quick Wins first (SPF/DKIM/DMARC, reglas de firewall básicas)
2. EDR deployment
3. FortiGate configuration hardening
4. Patch management
5. Qualys agent deployment

### Fase 5: Validación y Handoff
1. Re-test de vulnerabilidades críticas
2. Documentación entregable
3. Capacitación al equipo IT del cliente
4. Plan de monitoreo continuo

## Formato de Entregables

### Preferencias de Documentación (vigente desde 18 Jun 2026)
- **Autor:** Ing. Rogelio Torres Pimentel — Senior Cybersecurity Consultant / Architect
- **Datos de contacto en portada y pie:**
  - LinkedIn: https://www.linkedin.com/in/rogeliotorres/
  - Email: rogelio.torres.pimentel@gmail.com
  - Móvil: +52 33 1486 9253
- **Sin referencias a BRIDA IT Services** — No incluir nombre, logo, URL ni mención alguna
- **Idioma:** Español mexicano con ortografía correcta (acentos, tildes). Términos técnicos en inglés (Pentesting, Vulnerability, Threat Model, Ransomware, etc.)
- **Formato principal:** Word (.docx) editable
- **Envío:** Por Telegram usando `MEDIA:/ruta/al/archivo`
- **Estructura:** Tablas con headers sombreados, filas alternadas en gris, badges de severidad con colores, secciones numeradas, glosario, control de versiones
- **Confirmar al terminar:** Avisar explícitamente cuando cada tarea esté completada

### Generación de Documentos Word con python-docx
1. Crear script Python temporal en `/tmp/gen_doc.py`
2. Usar funciones helper: `shade(cell, color)`, `tbl(headers, data, hcolor)`, `code(text)`
3. **Pitfall crítico — brackets en datos de tabla:** La función `tbl()` espera `data` como lista de listas `[[fila1], [fila2]]`. **SIEMPRE usar `[]` para las filas de datos, NUNCA `()`.** Mezclar tuplas y listas causa `SyntaxError`. Verificar que cada fila cierre con `],` y no con `),`.
4. **Pitfall crítico — ortografía española:** Todos los documentos deben incluir acentos y tildes correctos en español (crítico, vulnerabilidad, autenticación, configuración, implementación, etc.)
5. Ejecutar: `python3 /tmp/gen_doc.py` y verificar output
6. Enviar: `MEDIA:/ruta/archivo.docx` por Telegram

### Estructura Estándar de Documento Técnico
1. Portada (título, cliente, fecha, autor, contacto)
2. Página de control de documento (metadatos, historial de cambios)
3. Índice numerado
4. Introducción y Objetivos
5. Perfil Corporativo del Cliente
6. Metodología
7. Perfil OSINT y Superficie de Ataque (incluye análisis TLS/HTTPS)
8. Análisis de Amenazas STRIDE + DREAD
9. Matriz de Amenazas Consolidada
10. Top 10 Amenazas Priorizadas
11. Escenarios de Ataque
12. Recomendaciones Estratégicas
13. Hoja de Ruta de Implementación
14. Anexos (glosario, fuentes, referencias, control de versiones)

## Frameworks de Referencia
- **NIST CSF:** Identify, Protect, Detect, Response, Recover
- **MITRE ATT&CK:** Tácticas y técnicas de atacantes reales
- **STRIDE:** Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation of Privilege
- **DREAD:** Damage, Reproducibility, Exploitability, Affected Users, Discoverability
- **CIS Controls:** 18 controles priorizados
- **ISO 27001:** Sistema de gestión de seguridad de información

## Clientes Típicos
- Restaurantes/cadenas de retail con sucursales múltiples
- Farmacias con cientos de locaciones
- Empresas medianas (500-5000 empleados) en Jalisco/occidente de México
- Madurez de seguridad típicamente BAJA a MEDIA

## Lecciones Aprendidas (Self-Improvement Jun 2026)

1. **Siempre generar el archivo real** — No describir lo que "incluiría" el documento. Crear el script Python, ejecutarlo y enviar el archivo `.docx` por Telegram con `MEDIA:ruta`.
2. **python-docx + tablas** — Construir tablas con `rows=1+len(data)` desde el inicio. **SIEMPRE usar `[]` para filas de datos, NUNCA `()`.** Verificar que cada fila cierre con `],`.
3. **Verificar antes de enviar** — Comprobar que el archivo existe y tiene tamaño > 0 antes de enviar.
4. **Confirmación de finalización** — Avisar explícitamente cuando cada tarea esté completada.
5. **Pausas en el trabajo** — Anotar el estado exacto de lo pendiente para retomar sin fricción.
6. **Ortografía española** — Todos los documentos deben incluir acentos y tildes correctos. Revisar: crítico, vulnerabilidad, autenticación, configuración, implementación, etc.
7. **Controles de seguridad existentes** — Antes de puntuar amenazas DREAD, verificar qué controles de seguridad ya están implementados (ej. Cloudflare CDN/WAF, TLS 1.3, MFA existente). Ajustar scores según el riesgo residual, no el riesgo teórico. Si un cliente tiene Cloudflare activo, las amenazas DDoS deben puntuarse considerando esa mitigación parcial.
8. **Análisis de certificados TLS/HTTPS** — Incluir siempre en Threat Models con presencia web. Crear sección dedicada y categoría "TLS/Certificados" en STRIDE+DREAD. Ver guía en `references/tls-certificate-analysis.md`.
9. **Threat Model para Retail/E-commerce** — Incluir siempre: análisis de plataforma (Salesforce, Shopify, etc.), riesgos de APIs, suplantación de marca en redes sociales, PCI-DSS si manejan tarjetas, ransomware impactando tiendas físicas, DDoS en temporada alta.
10. **Control de versiones en documentos** — Incluir página de control de documento y tabla de historial de cambios en cada versión.
11. **Formato profesional para equipos IT** — Tablas con headers sombreados, filas alternadas, badges de severidad con colores, tablas centradas, glosario de términos técnicos.
12. **Flujo OSINT → Threat Model** — Cuando el usuario entrega reportes OSINT en Word: extraer texto con python-docx, identificar activos/gaps/superficie, mapear amenazas STRIDE+DREAD, generar escenarios con impacto en MXN, crear documento Word completo.
13. **Creación masiva de skills** — Cuando el usuario pide muchos skills a la vez, usar `delegate_task` con `tasks[]` para crearlos en paralelo (hasta 3 simultáneos).
14. **Análisis de repositorios GitHub para skills** — Cuando el usuario pide analizar un repo de GitHub: usar `curl -s https://api.github.com/repos/USER/REPO/contents/` para explorar estructura, `curl -s https://raw.githubusercontent.com/...` para leer archivos, y `curl -s https://api.github.com/repos/USER/REPO` para metadatos (stars, descripción, topics). No instalar nada, solo analizar.
16. **Pitfall: comillas dobles en cierre de strings python-docx** — Al generar scripts Python para documentos Word, verificar que los strings dentro de datos de tabla no terminen con `''),` (comilla doble + paréntesis). Debe ser `'text'],`. Usar `re.sub(r"''\),\s*", r"'),  ", content)` como corrección global después de escribir el script.
17. **Pitfall: unicode escapes en write_file** — Al generar scripts Python con `write_file`, los emojis unicode como `\U0001f49c\uU0001f510` causan `SyntaxError: truncated \uXXXX escape`. **Solución:** Usar `execute_code` con heredoc (`python3 << 'PYEOF'`) o evitar emojis unicode en strings generados. Ver `references/docx-generation-pattern.md`.
18. **Exportar historial de sesión a Word** — Cuando el usuario pida un "journal" o "registro de instrucciones": consultar `~/.hermes/state.db` (SQLite), extraer mensajes de usuario con `SELECT ... WHERE role='user' ORDER BY timestamp ASC`, categorizar por tipo (verificación, configuración, errores, skills, documentos), y generar documento Word con python-docx. Ver flujo completo en `references/session-history-export.md`.
17. **Pitfall: unicode escapes en write_file** — Al generar scripts Python con `write_file`, los emojis unicode como `\U0001f49c\uU0001f510` causan `SyntaxError: truncated \uXXXX escape`. **Solución:** Usar `execute_code` con heredoc (`python3 << 'PYEOF'`) o evitar emojis unicode en strings generados. Ver `references/docx-generation-pattern.md`.
18. **Exportar historial de sesión a Word** — Cuando el usuario pida un "journal" o "registro de instrucciones": consultar `~/.hermes/state.db` (SQLite), extraer mensajes de usuario con `SELECT ... WHERE role='user' ORDER BY timestamp ASC`, categorizar por tipo (verificación, configuración, errores, skills, documentos), y generar documento Word con python-docx. Ver flujo completo en `references/session-history-export.md`..
17. **Pitfall: unicode escapes en write_file** — Al generar scripts Python con `write_file`, los emojis unicode como `\U0001f49c\uU0001f510` causan `SyntaxError: truncated \uXXXX escape`. **Solución:** Usar `execute_code` con heredoc (`python3 << 'PYEOF'`) o evitar emojis unicode en strings generados. Ver `references/docx-generation-pattern.md`.
18. **Exportar historial de sesión a Word** — Cuando el usuario pida un "journal" o "registro de instrucciones": consultar `~/.hermes/state.db` (SQLite), extraer mensajes de usuario con `SELECT ... WHERE role='user' ORDER BY timestamp ASC`, categorizar por tipo (verificación, configuración, errores, skills, documentos), y generar documento Word con python-docx. Ver flujo completo en `references/session-history-export.md`.
## Terminología Bilingüe (EN → ES)
| Inglés | Español |
|---|---|
| Penetration Testing | Prueba de Penetración / Pentesting |
| Vulnerability Assessment | Evaluación de Vulnerabilidades |
| Threat Modeling | Modelado de Amenazas |
| Firewall | Cortafuegos |
| Spoofing | Suplantación de identidad |
| Phishing | Suplantación por email |
| Ransomware | Secuestro de datos |
| Exploit | Código de explotación |
| Payload | Carga maliciosa útil |
| Pivoting | Movimiento lateral |
| Privilege Escalation | Escalamiento de privilegios |
| Data Exfiltration | Extracción de datos |
| Denial of Service (DoS/DDoS) | Denegación de servicio |
| Zero Day | Día Cero |
| Patch | Parche de seguridad |
| Endpoint | Dispositivo final |
| Network Segment | Segmento de red |
| Cloud Security | Seguridad en la nube |
| Incident Response | Respuesta a incidentes |
| Business Continuity | Continuidad del negocio |
| Forensics | Informática forense |
| TLS/SSL | Seguridad de la Capa de Transporte |
| Certificate Authority (CA) | Autoridad de Certificación |
| Extended Validation (EV) | Validación Extendida |
| Content Delivery Network (CDN) | Red de Distribución de Contenido |
| Web Application Firewall (WAF) | Firewall de Aplicaciones Web |
| Strict Transport Security (HSTS) | Seguridad Estricta de Transporte |