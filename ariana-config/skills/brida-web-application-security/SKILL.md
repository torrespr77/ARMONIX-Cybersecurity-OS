---
name: brida-web-application-security
description: 'Web Application Security assessment and penetration testing for BRIDA
  IT Services clients. Covers OWASP Top 10 (2021), WSTG methodology, Burp Suite testing,
  API security (OWASP API Top 10), and business logic flaws. Adapted for mid-market
  Mexican enterprises with e-commerce, web portals, and internal applications. Activates
  for: web app pentest, OWASP testing, application security, API security assessment,
  web vulnerability testing.'
domain: cybersecurity
subdomain: web-application-security
tags:
- web-security
- OWASP
- Burp-Suite
- API-security
- WSTG
- application-security
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- ID.RA-01
- ID.RA-06
- GV.OV-02
- DE.AE-07
mitre_attack:
- T1595
- T1190
- T1059
- T1078
- T1133
category: cybersecurity
---

# Web Application Security — BRIDA IT Services

## Descripción
Metodología de evaluación de seguridad de aplicaciones web para clientes de BRIDA IT Services. Cubre OWASP Top 10 (2021), WSTG, Burp Suite, API Security (OWASP API Top 10) y fallas de lógica de negocio. Adaptada para empresas mexicanas medianas con e-commerce, portales web y aplicaciones internas.

## Cuándo Usar
- Evaluación de seguridad antes de producción (e-commerce, portales)
- Cumplimiento PCI-DSS 6.6, SOC 2 Type II
- Validación de remediación de vulnerabilidades previas
- Evaluación de aplicaciones de terceros antes de integración
- Pruebas de seguridad en aplicaciones web custom

**NO usar** sin autorización escrita, en producción en horas pico sin aprobación, ni para pruebas DoS.

## Pre-requisitos
- SoW firmado definiendo URLs, entornos y límites
- Burp Suite Professional con extensiones actualizadas
- Cuentas de prueba por nivel de privilegio (no autenticado, usuario, admin)
- Documentación: API specs (OpenAPI/Swagger), sitemap, stack tecnológico
- Browser configurado con proxy Burp + certificado CA instalado

## Metodología OWASP Top 10 (2021)

### A01: Broken Access Control
- **Testing:** Autorize extension en Burp, manipulación de IDs (IDOR), escalamiento de privilegios
- **Herramientas:** Burp Suite, Autorize, JWT_Tool
- **Comandos:**
  ```bash
  # IDOR testing
  curl -s "https://target.com/api/user/1234/profile" -H "Authorization: Bearer <token>"
  curl -s "https://target.com/api/user/5678/profile" -H "Authorization: Bearer <token>"
  ```
- **Severidad:** CRÍTICO — Acceso no autorizado a datos de otros usuarios

### A02: Cryptographic Failures
- **Testing:** TLS analysis, datos sensibles en tránsito y reposo, hashing débil
- **Herramientas:** testssl.sh, Burp Suite, hashcat
- **Comandos:**
  ```bash
  # TLS analysis
  testssl.sh https://target.com
  # Check for sensitive data in URLs
  grep -r "password\|token\|secret" /var/log/nginx/access.log
  ```
- **Severidad:** ALTO — Exposición de datos sensibles

### A03: Injection
- **Testing:** SQLi, NoSQLi, LDAP injection, OS command injection, XXE
- **Herramientas:** SQLMap, Burp Suite, NoSQLMap, XXEinjector
- **Comandos:**
  ```bash
  # SQLMap básico
  sqlmap -u "https://target.com/search?q=test" --batch --risk=3 --level=5
  # NoSQL injection
  curl "https://target.com/login" -d '{"username":{"$gt":""},"password":{"$gt":""}}'
  ```
- **Severidad:** CRÍTICO — Ejecución de código, exfiltración de datos

### A04: Insecure Design
- **Testing:** Business logic flaws, race conditions, workflow bypass
- **Herramientas:** Burp Suite (manual testing), Turbo Intruder
- **Ejemplo:** Modificar precio en carrito de compras, bypass de flujo de pago
- **Severidad:** ALTO — Fraude, bypass de controles de negocio

### A05: Security Misconfiguration
- **Testing:** Default credentials, directory listing, verbose errors, unnecessary features
- **Herramientas:** Nikto, Gobuster, Burp Suite
- **Comandos:**
  ```bash
  nikto -h https://target.com
  gobuster dir -u https://target.com -w /usr/share/wordlists/dirb/common.txt
  ```
- **Severidad:** MEDIO — Información expuesta, acceso no autorizado

### A06: Vulnerable and Outdated Components
- **Testing:** Version detection, known CVEs, dependency analysis
- **Herramientas:** Retire.js, OWASP Dependency-Check, nuclei
- **Comandos:**
  ```bash
  nuclei -u https://target.com -t technologies/
  ```
- **Severidad:** ALTO — Explotación de CVEs conocidos

### A07: Identification and Authentication Failures
- **Testing:** Brute force, session fixation, credential stuffing, MFA bypass
- **Herramientas:** Burp Suite, Hydra, JWT_Tool
- **Comandos:**
  ```bash
  # JWT analysis
  jwt_tool <token> -M at -t "https://target.com/api/"
  ```
- **Severidad:** CRÍTICO — Toma de control de cuentas

### A08: Software and Data Integrity Failures
- **Testing:** CI/CD pipeline security, unsigned updates, deserialization
- **Herramientas:** ysoserial, SerializationDumper
- **Severidad:** ALTO — Ejecución de código remoto

### A09: Security Logging and Monitoring Failures
- **Testing:** Verificar si eventos de seguridad se registran y alertan
- **Herramientas:** Revisar logs, intentar acciones maliciosas y verificar detección
- **Severidad:** MEDIO — Sin detección no hay respuesta

### A10: Server-Side Request Forgery (SSRF)
- **Testing:** Internal network access, cloud metadata, file read
- **Herramientas:** Burp Suite, SSRFmap, interact.sh
- **Comandos:**
  ```bash
  # Cloud metadata SSRF
  curl "https://target.com/fetch?url=http://169.254.169.254/latest/meta-data/"
  ```
- **Severidad:** CRÍTICO — Acceso a infraestructura interna

## API Security (OWASP API Top 10)
- **API1:** Broken Object Level Authorization (BOLA/IDOR)
- **API2:** Broken Authentication
- **API3:** Broken Object Property Level Authorization
- **API4:** Unrestricted Resource Consumption
- **API5:** Broken Function Level Authorization
- **API6:** Unrestricted Access to Sensitive Business Flows
- **API7:** Server Side Request Forgery
- **API8:** Security Misconfiguration
- **API9:** Improper Inventory Management
- **API10:** Unsafe Consumption of APIs

## Workflow de Testing

### Fase 1: Reconocimiento
1. Mapeo de la aplicación (spidering manual + Burp)
2. Identificación de tecnologías (Wappalyzer, WhatWeb)
3. Enumeración de endpoints (Gobuster, ffuf)
4. Revisión de documentación API (Swagger/OpenAPI)

### Fase 2: Testing Activo
1. Authentication testing (A07)
2. Authorization testing (A01)
3. Input validation (A03)
4. Business logic (A04)
5. Session management (A07)
6. API security (OWASP API Top 10)
7. SSRF (A10)

### Fase 3: Reporte
1. Executive Summary (para CEO/CIO)
2. Technical Findings (para IT/CISO)
3. Remediation Roadmap
4. Retest plan

## Mapeo MITRE ATT&CK
| Técnica | ID | Descripción |
|---|---|---|
| Exploit Public-Facing Application | T1199 | Explotar apps web expuestas |
| Exploitation for Client Execution | T1203 | Explotar vulnerabilidades del cliente |
| Command and Scripting Interpreter | T1059 | Inyección de comandos |
| Valid Accounts | T1078 | Uso de credenciales válidas |
| Exploitation of Remote Services | T1210 | Explotar servicios remotos |

## Herramientas Principales
| Herramienta | Uso | Licencia |
|---|---|---|
| Burp Suite Pro | Proxy, scanner, manual testing | Comercial |
| OWASP ZAP | Scanner de vulnerabilidades | Open Source |
| SQLMap | SQL injection automático | Open Source |
| Nuclei | Template-based scanning | Open Source |
| Gobuster/ffuf | Directory/file brute forcing | Open Source |
| JWT_Tool | JWT analysis | Open Source |
| testssl.sh | TLS/SSL analysis | Open Source |
| Nikto | Web server scanner | Open Source |

## Entregables para el Cliente
1. **Executive Summary** — 1 página, lenguaje no técnico, riesgo de negocio
2. **Technical Report** — Detalle de cada hallazgo con evidencia (screenshots, requests/responses)
3. **Risk Matrix** — CVSS scoring + business impact
4. **Remediation Plan** — Priorizado por severidad y esfuerzo
5. **Retest Plan** — Verificación de correcciones
