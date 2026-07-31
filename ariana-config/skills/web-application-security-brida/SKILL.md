---
name: "web-application-security-brida"
description: "Skill integral de seguridad de aplicaciones web para BRIDA IT Services. Cubre OWASP Top 10 (2021), metodología WSTG, Burp Suite, seguridad de APIs (OWASP API Top 10), y fallos de lógica de negocio. Incluye metodología de pruebas, vulnerabilidades comunes, guías de remediación, y plantillas de reportes. Mapeo con MITRE ATT&CK, NIST CSF, y D3FEND."
triggers:
  - "web app security"
  - "OWASP Top 10"
  - "pentesting web"
  - "seguridad aplicaciones web"
  - "Burp Suite"
  - "API security"
  - "OWASP API Top 10"
  - "WSTG"
  - "business logic flaw"
  - "fallo de lógica de negocio"
  - "web application pentest"
  - "security assessment web"
  - "BRIDA web security"
  - "pruebas de seguridad web"
  - "vulnerabilidades web"
category: "security"
---

# Web Application Security - BRIDA IT Services

## Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Metodología de Pruebas](#metodología-de-pruebas)
3. [Configuración del Entorno](#configuración-del-entorno)
4. [OWASP Top 10 (2021)](#owasp-top-10-2021)
5. [OWASP API Top 10 (2023)](#owasp-api-top-10-2023)
6. [Metodología WSTG](#metodología-wstg)
7. [Business Logic Flaws](#business-logic-flaws)
8. [Herramientas - Burp Suite](#herramientas---burp-suite)
9. [Mapeo con MITRE ATT&CK, NIST CSF y D3FEND](#mapeo-con-mitre-attck-nist-csf-y-d3fend)
10. [Guías de Remediación](#guías-de-remediación)
11. [Plantillas de Reporte](#plantillas-de-reporte)
12. [Checklist de Auditoría](#checklist-de-auditoría)

---

## Visión General

### Objetivo

Este skill proporciona un framework completo para la evaluación de seguridad de aplicaciones web y APIs en el contexto de BRIDA IT Services. Está diseñado para:

- Estandarizar las pruebas de seguridad web
- Garantizar cobertura completa según OWASP y WSTG
- Integrar mapeos con frameworks de seguridad reconocidos (MITRE ATT&CK, NIST CSF, D3FEND)
- Proporcionar documentación y reportes profesionales

### Alcance

| Área | Cobertura |
|------|-----------|
| Aplicaciones web tradicionales | HTML, JavaScript, SPAs, SSR |
| APIs | REST, GraphQL, SOAP, gRPC |
| Autenticación y autorización | Sesiones, JWT, OAuth 2.0, SAML |
| Lógica de negocio | Flujos de transacción, workflows |
| Infraestructura web | Servidores, CDNs, WAF |

---

## Metodología de Pruebas

### Fase 1: Reconocimiento (Reconnaissance)

```bash
# Enumeración de subdominios
amass enum -d target.com -passive
subfinder -d target.com -o subdomains.txt

# Descubrimiento de endpoints
gau target.com --threads 5
waybackurls target.com | sort -u

# Fingerprinting de tecnologias
whatweb https://target.com
wappalyzer https://target.com

# Enumeración de directorios
ffuf -w wordlist.txt -u https://target.com/FUZZ -mc all -fc 404

# Verificación de certificados
curl -vI https://target.com 2>&1 | grep -E "SSL|certificate|issuer"
```

**Entregables de Fase 1:**
- Inventario de subdominios
- Mapa de tecnologías identificadas
- Lista de endpoints descubiertos
- Certificados SSL/TLS vigentes

### Fase 2: Análisis de Superficie de Ataque (Attack Surface Analysis)

```bash
# Identificación de formularios y puntos de entrada
python3 -c "
import requests
from bs4 import BeautifulSoup
resp = requests.get('https://target.com')
soup = BeautifulSoup(resp.text, 'html.parser')
forms = soup.find_all('form')
for f in forms:
    print(f'Action: {f.get(\"action\")}, Method: {f.get(\"method\")}')
    inputs = f.find_all('input')
    for i in inputs:
        print(f'  Input: {i.get(\"name\")} (type={i.get(\"type\")})')
"

# Detección de API endpoints en JavaScript
grep -roh 'https://[^"]*api[^"]*' ./js_files/ | sort -u
grep -roh '/api/v[0-9/]*[^"]*' ./js_files/ | sort -u
```

### Fase 3: Pruebas de Vulnerabilidades

Seguir la guía WSTG (ver sección [Metodología WSTG](#metodología-wstg)).

### Fase 4: Explotación Controlada

Solo con autorización explícita del cliente. Documentar cada paso.

### Fase 5: Post-Explotación y Análisis de Impacto

- Evaluar el impacto real de cada vulnerabilidad encontrada
- Determinar escenarios de ataque combinado (chaining)
- Documentar evidencia con capturas de pantalla y requests/responses

### Fase 6: Reporte y Remediación

- Generar reporte ejecutivo y técnico
- Proporcionar guías de remediación específicas
- Incluir mapeo con MITRE ATT&CK, NIST CSF, y D3FEND

---

## Configuración del Entorno

### Burp Suite Professional

```bash
# Instalación de Burp Suite (Linux)
wget https://portswigger.net/burp/releases/download?product=pro&version=2024.1.1&type=jar -O burpsuite_pro.jar
java -jar burpsuite_pro.jar &

# Configuración del proxy del navegador
# Proxy: 127.0.0.1:8080
# Instalar certificado CA de Burp en el navegador
```

### Extensiones Recomendadas para Burp Suite

| Extensión | Propósito |
|-----------|-----------|
| **Autorize** | Testing de autorización |
| **Param Miner** | Descubrimiento de parámetros ocultos |
| **Turbo Intruder** | Fuzzing de alta velocidad |
| **Retire.js** | Detección de vulnerabilidades en JS |
| **Active Scan++** | Escaneo activo mejorado |
| **Logger++** | Logging avanzado |
| **JSON Web Tokens** | Análisis y ataques a JWT |
| **GraphQL Raider** | Testing de GraphQL |
| **HTTP Request Smuggler** | Detección de request smuggling |
| **403 Bypasser** | Bypass de restricciones 403 |

### Herramientas Complementarias

```bash
# Instalación de herramientas esenciales
pip3 install sqlmap
pip3 install wfuzz
pip3 install nikto
pip3 install nuclei

# Nuclei templates para web
nuclei -update-templates

# ffuf para fuzzing
apt install ffuf

# httpx para verificación
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# jwt_tool para análisis de JWT
git clone https://github.com/ticarpi/jwt_tool
cd jwt_tool && pip3 install -r requirements.txt
```

---

## OWASP Top 10 (2021)

### A01:2021 - Broken Access Control

**Descripción:** Fallos en la restricción de acciones de usuarios autenticados.

**Tipos comunes:**

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| IDOR | Referencia directa a objeto inobjetable | `GET /api/user/1234/profile` → cambiar 1234 por otro ID |
| Missing function level access control | Falta de control a nivel de función | Usuario regular accediendo a `/admin/deleteUser` |
| CORS misconfiguration | Configuración incorrecta de CORS | `Access-Control-Allow-Origin: *` con credenciales |
| Directory traversal | Recorrido de directorios | `GET /files?name=../../../etc/passwd` |
| JWT manipulation | Manipulación de tokens JWT | Cambiar algoritmo a `none`, modificar payload |

**Pruebas con Burp Suite:**

```
# Probar IDOR - Enviar a Repeater y modificar IDs
GET /api/v1/users/1001/orders HTTP/1.1
→ Cambiar 1001 por 1002, 1003, 9999

# Probar bypass de autorización
GET /admin/dashboard HTTP/1.1
Cookie: session=user_session_token
→ Cambiar cookie por la de otro usuario con menor privilegio

# Probar CORS
GET /api/sensitive-data HTTP/1.1
Origin: https://evil.com
→ Verificar si Access-Control-Allow-Origin refleja el Origin
```

**Remediación:**

```python
# Ejemplo: Control de acceso basado en el recurso
def get_user_profile(request, user_id):
    # NUNCA confiar en el ID proporcionado por el cliente
    # Verificar que el usuario autenticado tiene acceso
    if request.session.user_id != int(user_id):
        raise PermissionError("Acceso no autorizado")
    return User.objects.get(id=user_id)

# Ejemplo: CORS seguro
CORS_ALLOWED_ORIGINS = [
    "https://app.bridait.com",
    "https://www.bridait.com",
]
CORS_ALLOW_CREDENTIALS = True
```

**Mapeo:**
- MITRE ATT&CK: T1530 (Data from Cloud Storage), T1078 (Valid Accounts)
- NIST CSF: PR.AC (Identity Management and Access Control)
- D3FEND: d3f:AccessLimitation, d3f:ObjectAccessControl

---

### A02:2021 - Cryptographic Failures

**Descripción:** Fallos relacionados con criptografía que llevan a exposición de datos sensibles.

**Vulnerabilidades comunes:**

| Vulnerabilidad | Indicador | Prueba |
|---------------|-----------|--------|
| Datos en tránsito sin cifrar | HTTP en lugar de HTTPS | `curl -I http://target.com` |
| Algoritmos débiles | MD5, SHA1, DES, RC4 | Analizar certificados y headers |
| Almacenamiento inseguro | Contraseñas en texto plano | Revisar base de datos expuesta |
| Claves hardcodeadas | Keys en código fuente | `grep -r "password\|secret\|key" ./src` |
| Tokens predecibles | Sesiones secuenciales | Analizar patrones de session ID |

**Pruebas:**

```bash
# Verificar configuración SSL/TLS
nmap --script ssl-enum-ciphers -p 443 target.com
testssl.sh target.com

# Verificar headers de seguridad
curl -I https://target.com | grep -iE "strict-transport|x-frame|x-content|content-security"

# Verificar información en respuestas
curl -v https://target.com 2>&1 | grep -iE "server|x-powered-by|via"
```

**Remediación:**

```python
# Configuración TLS recomendada (nginx)
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
ssl_prefer_server_ciphers on;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

# Hash seguro de contraseñas
import bcrypt
password = b"user_password"
salt = bcrypt.gensalt(rounds=12)
hashed = bcrypt.hashpw(password, salt)
```

**Mapeo:**
- MITRE ATT&CK: T1552 (Unsecured Credentials), T1040 (Network Sniffing)
- NIST CSF: PR.DS (Data Security)
- D3FEND: d3f:DataEncryption, d3f:KeyManagement

---

### A03:2021 - Injection

**Descripción:** Datos no confiables enviados a un intérprete como parte de un comando o consulta.

**Tipos de inyección:**

| Tipo | Payload de Prueba | Impacto |
|------|-------------------|---------|
| SQLi | `' OR 1=1--` | Acceso no autorizado a datos |
| NoSQLi | `{"$gt": ""}` | Bypass de autenticación |
| OS Command | `; cat /etc/passwd` | Ejecución de comandos en servidor |
| LDAP | `*)(uid=*))(|(uid=*` | Bypass de autenticación |
| XSS (stored/reflected) | `<script>alert(1)</script>` | Ejecución de scripts en navegador |
| SSTI | `{{7*7}}` | Ejecución en servidor (template injection) |

**Pruebas con Burp Suite:**

```
# SQL Injection - Enviar a Intruder
GET /products?id=1 HTTP/1.1
→ Posición: id=§1§
→ Payload: ' OR 1=1--, ' UNION SELECT 1,2,3--, 1' AND '1'='1

# NoSQL Injection
POST /api/login HTTP/1.1
Content-Type: application/json
→ {"username": {"$gt": ""}, "password": {"$gt": ""}}

# OS Command Injection
POST /api/ping HTTP/1.1
→ {"host": "127.0.0.1; cat /etc/passwd"}

# SSTI
GET /profile?name={{7*7}} HTTP/1.1
→ Si retorna "49", es vulnerable a SSTI
```

**Remediación:**

```python
# SQLi - Usar consultas parametrizadas
import psycopg2
cursor.execute(
    "SELECT * FROM users WHERE id = %s AND active = %s",
    (user_id, True)
)

# NoSQLi - Validar tipos de datos
from bson import ObjectId
def find_user(user_id):
    # Validar que user_id es un ObjectId válido
    if not ObjectId.is_valid(user_id):
        raise ValueError("Invalid user ID")
    return db.users.find_one({"_id": ObjectId(user_id)})

# OS Command - Evitar llamadas al sistema
import subprocess
# NUNCA: subprocess.call(f"ping {user_input}", shell=True)
# MEJOR: Usar librerías nativas
import icmp
# O si es necesario, usar allowlist
ALLOWED_HOSTS = ["127.0.0.1", "10.0.0.0/8"]
```

**Mapeo:**
- MITRE ATT&CK: T1190 (Exploit Public-Facing Application), T1059 (Command and Scripting Interpreter)
- NIST CSF: PR.IP (Information Protection Processes)
- D3FEND: d3f:InputValidation, d3f:ParameterizedQueries

---

### A04:2021 - Insecure Design

**Descripción:** Fallos en el diseño y arquitectura que no fueron previstos para amenazas.

**Patrones de diseño inseguros:**

| Patrón | Problema | Ejemplo |
|--------|----------|---------|
| Rate limiting ausente | Ataques de fuerza bruta | Sin límite de intentos de login |
| Sin validación de negocio | Manipulación de precios | Cambiar precio en carrito de compras |
| Trust client-side | Validación solo en frontend | Reglas de negocio en JavaScript |
| Missing anti-automation | Bots y scraping | Sin CAPTCHA ni detección de bots |
| Race conditions | Concurrencia no manejada | Doble gasto en transacciones |

**Pruebas:**

```bash
# Probar rate limiting
for i in $(seq 1 100); do
    curl -s -o /dev/null -w "%{http_code}" -X POST https://target.com/api/login \
      -d "user=admin&pass=wrong$i"
done

# Probar race condition con Turbo Intruder
# Enviar múltiples requests simultáneas para verificar
# si se puede explotar una condición de carrera
```

**Remediación:**

```python
# Rate limiting con Redis
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

limiter = Limiter(
    app,
    key_func=get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

@app.route("/api/login", methods=["POST"])
@limiter.limit("5 per minute")
def login():
    pass

# Validación de negocio en servidor
def process_order(order):
    # NUNCA confiar en precios enviados por el cliente
    product = Product.objects.get(id=order.product_id)
    actual_price = product.price  # Precio desde el servidor
    if order.price != actual_price:
        raise ValueError("Price mismatch - possible tampering")
```

**Mapeo:**
- MITRE ATT&CK: T1498 (Network Denial of Service), T1078 (Valid Accounts)
- NIST CSF: ID.RA (Risk Assessment), PR.IP (Information Protection)
- D3FEND: d3f:ApplicationHardening, d3f:RateLimit

---

### A05:2021 - Security Misconfiguration

**Descripción:** Configuraciones de seguridad ausentes o incorrectas.

**Configuraciones comunes a verificar:**

| Elemento | Verificación | Herramienta |
|----------|-------------|-------------|
| Default credentials | admin/admin, admin/password | Burp Intruder |
| Directory listing | `/uploads/`, `/backup/` | `ffuf` |
| Error messages | Stack traces en respuestas | Manual |
| HTTP methods | OPTIONS, TRACE, PUT, DELETE | `curl -X OPTIONS` |
| Security headers | CSP, HSTS, X-Frame-Options | `curl -I` |
| Cloud storage | S3 buckets públicos | `s3scanner` |
| Debug mode | Entornos de producción con debug | Manual |

**Pruebas:**

```bash
# Verificar headers de seguridad faltantes
curl -I https://target.com | grep -iE "x-frame|x-content|strict|content-security|x-xss|referrer-policy"

# Verificar métodos HTTP permitidos
curl -X OPTIONS https://target.com -v 2>&1 | grep "Allow"

# Verificar archivos sensibles
ffuf -w sensitive_files.txt -u https://target.com/FUZZ
# sensitive_files.txt: .env, .git/HEAD, .htaccess, web.config, phpinfo.php

# Verificar default credentials en login
# Usar Burp Intruder con lista de credenciales por defecto
```

**Remediación:**

```python
# Headers de seguridad (Flask)
@app.after_request
def set_security_headers(response):
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    response.headers['Content-Security-Policy'] = "default-src 'self'"
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
    response.headers['Permissions-Policy'] = 'geolocation=(), camera=()'
    return response

# Deshabilitar debug en producción
DEBUG = False
TESTING = False
```

**Mapeo:**
- MITRE ATT&CK: T1082 (System Information Discovery), T1595 (Active Scanning)
- NIST CSF: PR.IP (Information Protection), PR.PT (Protective Technology)
- D3FEND: d3f:ConfigurationHardening, d3f:SoftwareHardening

---

### A06:2021 - Vulnerable and Outdated Components

**Descripción:** Uso de componentes con vulnerabilidades conocidas.

**Pruebas:**

```bash
# Identificar versiones de componentes
retire.js  # Extensión de Burp Suite
nuclei -t technologies/ -u https://target.com

# Verificar vulnerabilidades conocidas
# CVE databases: https://cve.mitre.org/, https://nvd.nist.gov/
# Herramientas:
pip3 install safety
safety check -r requirements.txt

npm audit  # Para proyectos Node.js
```

**Remediación:**

```yaml
# Dependabot configuration (.github/dependabot.yml)
version: 2
updates:
  - package-ecosystem: "pip"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10

  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
```

**Mapeo:**
- MITRE ATT&CK: T1190 (Exploit Public-Facing Application)
- NIST CSF: ID.RA (Risk Assessment), PR.IP (Information Protection)
- D3FEND: d3f:VulnerabilityAnalysis, d3f:PatchManagement

---

### A07:2021 - Identification and Authentication Failures

**Descripción:** Fallos en los mecanismos de autenticación.

**Vulnerabilidades comunes:**

| Vulnerabilidad | Prueba | Impacto |
|---------------|--------|---------|
| Credential stuffing | Burp Intruder con wordlists | Acceso no autorizado |
| Weak password policy | Probar contraseñas débiles | Compromiso de cuenta |
| Session fixation | Reutilizar session ID pre-login | Secuestro de sesión |
| JWT none algorithm | Cambiar alg a "none" | Bypass de autenticación |
| Brute force sin rate limiting | Múltiples intentos | Compromiso de cuenta |
| Insecure "remember me" | Analizar token de sesión | Persistencia no autorizada |

**Pruebas con JWT:**

```python
# jwt_tool - Análisis y ataque a JWT
python3 jwt_tool.py <token>
python3 jwt_tool.py <token> -X a  # Algorithm none attack
python3 jwt_tool.py <token> -C -d jwt_secrets.txt  # Cracking
```

**Remediación:**

```python
# Configuración segura de JWT
import jwt
from datetime import datetime, timedelta

def create_token(user_id):
    payload = {
        "sub": user_id,
        "iat": datetime.utcnow(),
        "exp": datetime.utcnow() + timedelta(minutes=15),
        "iss": "brida-auth-service"
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

def verify_token(token):
    try:
        # ESPECIFICAR algoritmos permitidos - NUNCA confiar en el header
        payload = jwt.decode(
            token,
            SECRET_KEY,
            algorithms=["HS256"],  # Lista blanca de algoritmos
            issuer="brida-auth-service"
        )
        return payload
    except jwt.ExpiredSignatureError:
        raise AuthenticationError("Token expirado")
    except jwt.InvalidTokenError:
        raise AuthenticationError("Token inválido")
```

**Mapeo:**
- MITRE ATT&CK: T1110 (Brute Force), T1556 (Modify Authentication Process)
- NIST CSF: PR.AC (Identity Management and Access Control)
- D3FEND: d3f:Authentication, d3f:MultiFactorAuthentication

---

### A08:2021 - Software and Data Integrity Failures

**Descripción:** Código e infraestructura que no protege contra violaciones de integridad.

**Vulnerabilidades comunes:**

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| Insecure deserialization | Datos serializados manipulados | Java deserialization, Python pickle |
| CI/CD sin verificar integridad | Código malicioso en pipeline | Dependency confusion |
| Actualizaciones sin firma | Updates no verificados | Descarga de updates sin verificar hash |
| Cache poisoning | Envenenamiento de caché | Cache key injection |

**Pruebas:**

```bash
# Probar insecure deserialization (Java)
# Enviar payloads serializados maliciosos
ysoserial.jar  # Generar payloads de prueba

# Probar cache poisoning
GET /page HTTP/1.1
X-Forwarded-Host: evil.com
X-Forwarded-Scheme: https
→ Verificar si la respuesta refleja evil.com
```

**Remediación:**

```python
# NUNCA usar pickle para datos no confiables
import json

# INSEGURO:
# data = pickle.loads(user_input)

# SEGURO:
data = json.loads(user_input)

# Verificar integridad de dependencias (pip)
pip install pip-audit
pip-audit -r requirements.txt

# Verificar integridad de downloads
import hashlib
def verify_download(filepath, expected_hash):
    sha256 = hashlib.sha256()
    with open(filepath, 'rb') as f:
        for chunk in iter(lambda: f.read(4096), b''):
            sha256.update(chunk)
    return sha256.hexdigest() == expected_hash
```

**Mapeo:**
- MITRE ATT&CK: T1195 (Supply Chain Compromise), T1565 (Data Manipulation)
- NIST CSF: PR.DS (Data Security), PR.IP (Information Protection)
- D3FEND: d3f:FileIntegrityAnalysis, d3f:SoftwareVerification

---

### A09:2021 - Security Logging and Monitoring Failures

**Descripción:** Falta de logging, detección, monitoreo y respuesta a incidentes.

**Verificaciones:**

| Elemento | Verificación | Impacto si falta |
|----------|-------------|-----------------|
| Login events | Intentos exitosos/fallidos | No detección de brute force |
| Input validation failures | Errores de validación | No detección de ataques |
| Admin actions | Acciones privilegiadas | No auditoría de admins |
| Log injection | Caracteres especiales en logs | Corrupción de logs |
| Alerting | Alertas automáticas | Respuesta tardía a incidentes |

**Pruebas:**

```bash
# Probar log injection
username=admin\n[2024-01-01] INFO: User logged in successfully
→ Verificar si el log muestra la inyección

# Verificar si eventos críticos son logueados
# Realizar acciones y verificar si aparecen en logs
```

**Remediación:**

```python
import logging
import json
from datetime import datetime

# Logging estructurado
class SecurityLogger:
    def __init__(self):
        self.logger = logging.getLogger('security')
        handler = logging.FileHandler('/var/log/security.log')
        handler.setFormatter(logging.Formatter('%(message)s'))
        self.logger.addHandler(handler)

    def log_auth_event(self, event_type, user_id, ip, success, details=""):
        log_entry = {
            "timestamp": datetime.utcnow().isoformat(),
            "event_type": event_type,
            "user_id": str(user_id),
            "source_ip": ip,
            "success": success,
            "details": details
        }
        self.logger.info(json.dumps(log_entry))

    def log_access_denied(self, user_id, resource, ip):
        self.log_auth_event("access_denied", user_id, ip, False,
                          f"Attempted access to {resource}")

    def log_input_validation_failure(self, user_id, field, value, ip):
        # NO loguear el valor completo para evitar log injection
        sanitized = value[:50] if value else ""
        self.log_auth_event("input_validation_failure", user_id, ip, False,
                          f"Field: {field}, Value preview: {sanitized}")
```

**Mapeo:**
- MITRE ATT&CK: T1562 (Impair Defenses), T1070 (Indicator Removal)
- NIST CSF: DE.CM (Security Continuous Monitoring), DE.AE (Anomalies and Events)
- D3FEND: d3f:LogAnalysis, d3f:EventLogAnalysis

---

### A10:2021 - Server-Side Request Forgery (SSRF)

**Descripción:** La aplicación web obtiene un recurso remoto sin validar la URL proporcionada.

**Tipos de SSRF:**

| Tipo | Descripción | Payload |
|------|-------------|---------|
| Basic SSRF | Acceso a recursos internos | `url=http://169.254.169.254/latest/meta-data/` |
| Blind SSRF | Sin respuesta visible | `url=http://internal-service:8080/admin` |
| DNS-based SSRF | Verificación vía DNS | `url=http://burpcollaborator.net` |
| Protocol smuggling | Usar protocolos no HTTP | `url=file:///etc/passwd` |

**Pruebas con Burp Suite:**

```
# Basic SSRF
POST /api/fetch HTTP/1.1
Content-Type: application/json
→ {"url": "http://169.254.169.254/latest/meta-data/iam/security-credentials/"}

# Blind SSRF con Burp Collaborator
→ {"url": "http://<burp-collaborator-id>.burpcollaborator.net"}

# Protocol smuggling
→ {"url": "file:///etc/passwd"}
→ {"url": "gopher://internal-service:6379/_FLUSHALL"}
```

**Remediación:**

```python
import ipaddress
import socket
from urllib.parse import urlparse

def validate_url(url):
    """Validar URL para prevenir SSRF"""
    parsed = urlparse(url)

    # 1. Solo permitir HTTP/HTTPS
    if parsed.scheme not in ('http', 'https'):
        raise ValueError("Only HTTP/HTTPS protocols allowed")

    # 2. Resolver DNS y verificar IP
    try:
        hostname = parsed.hostname
        resolved_ips = socket.getaddrinfo(hostname, None)
        for family, type_, proto, canonname, sockaddr in resolved_ips:
            ip = ipaddress.ip_address(sockaddr[0])
            # 3. Bloquear IPs privadas y reservadas
            if ip.is_private or ip.is_loopback or ip.is_reserved or ip.is_link_local:
                raise ValueError(f"Access to private IP {ip} is not allowed")
    except socket.gaierror:
        raise ValueError("Could not resolve hostname")

    # 4. Allowlist de dominios (si aplica)
    ALLOWED_DOMAINS = ["api.bridait.com", "cdn.bridait.com"]
    if hostname not in ALLOWED_DOMAINS:
        raise ValueError(f"Domain {hostname} is not in the allowed list")

    return True
```

**Mapeo:**
- MITRE ATT&CK: T1190 (Exploit Public-Facing Application), T1098 (Account Manipulation)
- NIST CSF: PR.AC (Access Control), PR.DS (Data Security)
- D3FEND: d3f:URLAnalysis, d3f:NetworkTrafficAnalysis

---

## OWASP API Top 10 (2023)

### API1:2023 - Broken Object Level Authorization (BOLA)

**Descripción:** La API no verifica si el usuario tiene acceso al objeto solicitado.

**Pruebas:**

```
# BOLA en REST API
GET /api/v1/users/1001/documents/5001 HTTP/1.1
Authorization: Bearer <token_user_1001>
→ Cambiar 1001 por 1002 (otro usuario)
→ Cambiar 5001 por IDs de documentos de otros usuarios

# BOLA en acciones
DELETE /api/v1/documents/5001 HTTP/1.1
Authorization: Bearer <token_user_1001>
→ Verificar si puede eliminar documentos de otros usuarios

# Prueba con UUID (más difícil de enumerar pero aún vulnerable)
GET /api/v1/documents/a1b2c3d4-e5f6-7890-abcd-ef1234567890 HTTP/1.1
→ Si se descubre un UUID de otro usuario, verificar acceso
```

**Remediación:**

```python
# Middleware de autorización a nivel de objeto
def authorize_object_access(resource_type, resource_id):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            current_user = get_authenticated_user()
            resource = db.query(resource_type).get(resource_id)

            if not resource:
                abort(404)

            # Verificar propiedad del recurso
            if resource.owner_id != current_user.id and not current_user.is_admin:
                abort(403, description="Access denied to this resource")

            return func(*args, **kwargs)
        return wrapper
    return decorator

@app.route("/api/v1/documents/<doc_id>", methods=["GET"])
@authorize_object_access("Document", "doc_id")
def get_document(doc_id):
    document = Document.query.get(doc_id)
    return jsonify(document.to_dict())
```

---

### API2:2023 - Broken Authentication

**Descripción:** Mecanismos de autenticación de API implementados incorrectamente.

**Vulnerabilidades específicas de APIs:**

| Vulnerabilidad | Prueba | Impacto |
|---------------|--------|---------|
| API keys en URL | `?api_key=abc123` en query string | Exposición en logs y referrer |
| Basic auth sin HTTPS | Authorization header en texto plano | Interceptación de credenciales |
| Token refresh abuse | Reutilizar refresh tokens | Acceso prolongado |
| No token expiration | Tokens que nunca expiran | Acceso permanente |

**Pruebas:**

```bash
# Verificar si API key está en query string
curl "https://api.target.com/v1/data?api_key=sk_live_abc123"

# Verificar token expiration
# Obtener token, esperar, intentar usarlo de nuevo
curl -H "Authorization: Bearer <token>" https://api.target.com/v1/data

# Verificar refresh token rotation
# Usar el mismo refresh token múltiples veces
curl -X POST https://api.target.com/v1/auth/refresh \
  -d "refresh_token=<token>"
```

**Remediación:**

```python
# API Key en header, no en query string
@app.before_request
def require_api_key():
    api_key = request.headers.get('X-API-Key')
    if not api_key:
        abort(401, description="API key required in X-API-Key header")
    # Validar API key...

# Token rotation
def refresh_access_token(refresh_token):
    # Invalidar el refresh token usado
    stored_token = RefreshToken.query.filter_by(token=refresh_token).first()
    if stored_token.is_revoked:
        # Posible token reuse attack - revocar todos los tokens del usuario
        revoke_all_user_tokens(stored_token.user_id)
        raise SecurityError("Refresh token reuse detected")

    # Crear nuevo par de tokens
    new_access = create_access_token(stored_token.user_id)
    new_refresh = create_refresh_token(stored_token.user_id)

    # Revocar el refresh token usado
    stored_token.revoke()

    return {"access_token": new_access, "refresh_token": new_refresh}
```

---

### API3:2023 - Broken Object Property Level Authorization

**Descripción:** Exposición de propiedades de objetos que el usuario no debería ver.

**Tipos:**

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| Mass assignment | Asignar propiedades no permitidas | Enviar `{"role": "admin"}` en update |
| Information disclosure | Propiedades sensibles en respuesta | `password_hash` en perfil response |
| Property level access | Acceder a propiedades de otros | Ver `email` de otros usuarios |

**Pruebas:**

```
# Mass assignment
PUT /api/v1/users/profile HTTP/1.1
Content-Type: application/json
→ {"name": "Test", "role": "admin", "is_admin": true, "credits": 999999}

# Information disclosure
GET /api/v1/users/1 HTTP/1.1
→ Verificar si la respuesta incluye: password, password_hash, ssn, credit_card

# Property filtering bypass
GET /api/v1/users/1?fields=name,email,role,internal_notes HTTP/1.1
→ Probar diferentes combinaciones de campos
```

**Remediación:**

```python
# DTO / Schema validation
from marshmallow import Schema, fields, validate, EXCLUDE

class UserUpdateSchema(Schema):
    name = fields.Str(validate=validate.Length(max=100))
    email = fields.Email()
    # NO incluir: role, is_admin, credits, etc.

    class Meta:
        unknown = EXCLUDE  # Ignorar campos no esperados

@app.route("/api/v1/users/profile", methods=["PUT"])
@require_auth
def update_profile():
    schema = UserUpdateSchema()
    data = schema.load(request.get_json())
    # Solo los campos permitidos se procesan
    current_user.update(**data)
    return jsonify({"status": "updated"})
```

---

### API4:2023 - Unrestricted Resource Consumption

**Descripción:** La API no limita el consumo de recursos, permitiendo DoS o costos excesivos.

**Pruebas:**

```bash
# Probar rate limiting
for i in $(seq 1 1000); do
    curl -s -o /dev/null -w "%{http_code}\n" \
      https://api.target.com/v1/search?q=test
done

# Probar query complexity (GraphQL)
curl -X POST https://api.target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ users { posts { comments { author { posts { comments { author { name } } } } } } } }"}'

# Probar upload de archivos grandes
dd if=/dev/zero of=large_file.bin bs=1M count=500
curl -X POST https://api.target.com/v1/upload -F "file=@large_file.bin"

# Probar paginación sin límite
curl "https://api.target.com/v1/users?limit=999999&offset=0"
```

**Remediación:**

```python
# Rate limiting por usuario
from flask_limiter import Limiter

limiter = Limiter(key_func=lambda: get_api_key_or_user())

@app.route("/api/v1/search")
@limiter.limit("30 per minute")
def search():
    pass

# Paginación con límite máximo
@app.route("/api/v1/users")
def list_users():
    limit = min(int(request.args.get('limit', 20)), 100)  # Max 100
    offset = int(request.args.get('offset', 0))
    return jsonify(User.query.limit(limit).offset(offset).all())

# GraphQL query complexity
from graphql import validate, parse
MAX_COMPLEXITY = 1000

def calculate_complexity(query_string):
    # Implementar cálculo de complejidad
    pass
```

---

### API5:2023 - Broken Function Level Authorization

**Descripción:** La API no verifica permisos a nivel de función/endpoint.

**Pruebas:**

```
# Acceder a endpoints de admin con token de usuario regular
GET /api/v1/admin/users HTTP/1.1
Authorization: Bearer <regular_user_token>

# Probar métodos HTTP no esperados
POST /api/v1/users/1001/role HTTP/1.1
Authorization: Bearer <regular_user_token>
→ {"role": "admin"}

# Probar endpoints ocultos
GET /api/v1/internal/debug HTTP/1.1
GET /api/v1/_debug_toolbar HTTP/1.1
```

**Remediación:**

```python
# Decorador de autorización por rol
def require_role(*roles):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            user = get_authenticated_user()
            if user.role not in roles:
                abort(403, description="Insufficient permissions")
            return func(*args, **kwargs)
        return wrapper
    return decorator

@app.route("/api/v1/admin/users", methods=["GET"])
@require_role("admin", "superadmin")
def admin_list_users():
    return jsonify(User.query.all())
```

---

### API6:2023 - Unrestricted Access to Sensitive Business Flows

**Descripción:** APIs que exponen flujos de negocio sensibles sin protección adecuada.

**Ejemplos:**
- Compra de productos sin límite de cantidad
- Creación masiva de cuentas
- Envío masivo de mensajes
- Redención ilimitada de cupones

**Pruebas:**

```bash
# Probar compra sin límite de cantidad
curl -X POST https://api.target.com/v1/orders \
  -H "Authorization: Bearer <token>" \
  -d '{"product_id": 1, "quantity": 999999}"

# Probar redención múltiple de cupón
for i in $(seq 1 100); do
    curl -X POST https://api.target.com/v1/redeem \
      -H "Authorization: Bearer <token>" \
      -d '{"coupon_code": "PROMO2024"}'
done
```

---

### API7:2023 - Server Side Request Forgery (SSRF)

Ver sección [A10:2021 - SSRF](#a102021---server-side-request-forgery-ssrf) con enfoque adicional en APIs.

**Pruebas específicas para APIs:**

```
POST /api/v1/webhook/register HTTP/1.1
Content-Type: application/json
→ {"url": "http://169.254.169.254/latest/meta-data/"}

POST /api/v1/fetch HTTP/1.1
Content-Type: application/json
→ {"url": "http://internal-service.bridait.local:8080/admin"}
```

---

### API8:2023 - Security Misconfiguration

Ver sección [A05:2021](#a052021---security-misconfiguration) con enfoque adicional en APIs.

**Verificaciones específicas para APIs:**

| Elemento | Verificación |
|----------|-------------|
| CORS | `Access-Control-Allow-Origin` no debe ser `*` |
| API versioning | Versiones antiguas sin parchear |
| Error handling | Stack traces en respuestas de error |
| OpenAPI/Swagger | Documentación expuesta en producción |
| GraphQL introspection | Introspection habilitada en producción |

---

### API9:2023 - Improper Inventory Management

**Descripción:** La API no gestiona adecuadamente sus versiones y endpoints.

**Pruebas:**

```bash
# Probar versiones antiguas
curl https://api.target.com/v1/users    # Versión actual
curl https://api.target.com/v0/users    # Versión antigua
curl https://api.target.com/v1beta/users  # Versión beta

# Probar endpoints de debug
curl https://api.target.com/v1/debug
curl https://api.target.com/__debug__

# Verificar documentación expuesta
curl https://api.target.com/swagger.json
curl https://api.target.com/openapi.yaml
curl https://api.target.com/graphql?query={__schema{types{name}}}
```

**Remediación:**

```python
# Deshabilitar introspection en producción
import graphql
from graphql import build_schema, graphql_sync

# Deshabilitar Swagger en producción
app.config['SWAGGER_ENABLED'] = os.getenv('ENV') == 'development'

# Depreciation headers en APIs antiguas
@app.after_request
def add_deprecation_headers(response):
    if request.path.startswith('/v0/'):
        response.headers['Deprecation'] = 'true'
        response.headers['Sunset'] = 'Sat, 01 Jan 2025 00:00:00 GMT'
    return response
```

---

### API10:2023 - Unsafe Consumption of APIs

**Descripción:** La API consume otras APIs externas de forma insegura.

**Vulnerabilidades:**

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| SSRF via API calls | Pasar URLs sin validar a APIs internas | Webhook URLs |
| Trusting API responses | No validar respuestas de terceros | Confiar en datos de API externa |
| Sensitive data in logs | Loguear responses de APIs con datos sensibles | Números de tarjeta en logs |
| No timeout | APIs externas sin timeout | Colgado si API externa no responde |

**Remediación:**

```python
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry

# Configurar timeouts y retries
session = requests.Session()
retry_strategy = Retry(
    total=3,
    backoff_factor=1,
    status_forcelist=[429, 500, 502, 503, 504],
)
session.mount("https://", HTTPAdapter(max_retries=retry_strategy))

# Siempre usar timeout
response = session.get(
    external_api_url,
    timeout=(3.05, 27),  # (connect_timeout, read_timeout)
    verify=True  # Verificar SSL
)

# Validar respuesta antes de procesar
if response.status_code == 200:
    data = response.json()
    # Validar esquema de la respuesta
    validated = ExternalAPISchema().load(data)
```

---

## Metodología WSTG

### WSTG - Information Gathering

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-INFO-01 | Conduct Search Engine Discovery | Google Dorking, Shodan | Alta |
| WSTG-INFO-02 | Fingerprint Web Server | `whatweb`, `nmap` | Alta |
| WSTG-INFO-03 | Review Webserver Metafiles | `robots.txt`, `sitemap.xml` | Alta |
| WSTG-INFO-04 | Enumerate Applications on Webserver | `ffuf`, `dirsearch` | Alta |
| WSTG-INFO-05 | Review Webpage Content | Manual, Burp | Media |
| WSTG-INFO-06 | Identify Application Entry Points | Burp Spider | Alta |
| WSTG-INFO-07 | Map Execution Paths | Burp, Manual | Alta |
| WSTG-INFO-08 | Fingerprint Web Application Framework | `wappalyzer`, `whatweb` | Alta |
| WSTG-INFO-09 | Fingerprint Web Application | Manual | Media |
| WSTG-INFO-10 | Map Application Architecture | Manual | Alta |

### WSTG - Configuration and Deployment Management

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-CONF-01 | Test Network/Infrastructure Configuration | `nmap`, `dnsenum` | Alta |
| WSTG-CONF-02 | Test Application Platform Configuration | Manual, Burp | Alta |
| WSTG-CONF-03 | Test File Extensions Handling | `ffuf` | Media |
| WSTG-CONF-04 | Review Old, Unreferenced Files | `gau`, `waybackurls` | Alta |
| WSTG-CONF-05 | Enumerate Infrastructure and Admin Interfaces | `ffuf` | Alta |
| WSTG-CONF-06 | Test HTTP Methods | `curl`, Burp | Alta |
| WSTG-CONF-07 | Test HTTP Strict Transport Security | `curl`, `testssl.sh` | Alta |
| WSTG-CONF-08 | Test RIA Domain Policy Files | Manual | Baja |
| WSTG-CONF-09 | Test File Permission | Manual | Alta |
| WSTG-CONF-10 | Test for Subdomain Takeover | `subjack`, `nuclei` | Alta |
| WSTG-CONF-11 | Test Cloud Storage | `s3scanner`, `gcpbucketbrute` | Alta |

### WSTG - Identity Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-IDENT-01 | Test Role Definitions | Manual, Burp | Alta |
| WSTG-IDENT-02 | Test User Registration Process | Manual | Alta |
| WSTG-IDENT-03 | Test Account Provisioning Process | Manual | Alta |
| WSTG-IDENT-04 | Testing for Account Enumeration | Burp Intruder | Alta |
| WSTG-IDENT-05 | Test for Weak Username Policy | Manual | Media |
| WSTG-IDENT-06 | Test Permissions of Guest/Unauthenticated | Manual | Alta |
| WSTG-IDENT-07 | Test Account Suspension/Resumption | Manual | Media |
| WSTG-IDENT-08 | Test Account Privilege Escalation | Manual, Burp | Alta |

### WSTG - Authentication Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-AUTHN-01 | Test Credentials Transported over Encrypted Channel | `curl`, Burp | Alta |
| WSTG-AUTHN-02 | Test for Default Credentials | Burp Intruder | Alta |
| WSTG-AUTHN-03 | Test for Weak Lockout Policy | Manual | Alta |
| WSTG-AUTHN-04 | Test for Bypassing Authentication Schema | Manual, Burp | Alta |
| WSTG-AUTHN-05 | Test for Vulnerable Remember Password | Manual | Media |
| WSTG-AUTHN-06 | Test for Browser Cache Weakness | Manual | Media |
| WSTG-AUTHN-07 | Test for Weak Password Policy | Manual | Alta |
| WSTG-AUTHN-08 | Test for Weak Security Question | Manual | Media |
| WSTG-AUTHN-09 | Test for Weak Password Reset | Manual | Alta |
| WSTG-AUTHN-10 | Test for Weak Authentication in Alternative Channel | Manual | Alta |

### WSTG - Authorization Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-AUTHZ-01 | Test Directory Traversal | `ffuf`, Burp | Alta |
| WSTG-AUTHZ-02 | Test for Bypassing Authorization Schema | Manual, Burp | Alta |
| WSTG-AUTHZ-03 | Test for Privilege Escalation | Manual, Burp | Alta |
| WSTG-AUTHZ-04 | Test for Insecure Direct Object References | Manual, Burp | Alta |
| WSTG-AUTHZ-05 | Test for OAuth Weakness | Manual, Burp | Alta |
| WSTG-AUTHZ-06 | Test for Insecure Direct Object References in URL | Manual | Alta |
| WSTG-AUTHZ-07 | Test for Authorization Bypass Through User-Controlled Key | Manual | Alta |
| WSTG-AUTHZ-08 | Test for Authorization Bypass Through User-Controlled SFTP | Manual | Media |
| WSTG-AUTHZ-09 | Test for Authorization Bypass Through User-Controlled AWS S3 | Manual | Alta |
| WSTG-AUTHZ-10 | Test for Improper Handling of Unstructured Data | Manual | Media |

### WSTG - Session Management Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-SESS-01 | Test Session Management Schema | Burp Sequencer | Alta |
| WSTG-SESS-02 | Test for Cookies Attributes | Burp, Manual | Alta |
| WSTG-SESS-03 | Test Session Fixation | Manual, Burp | Alta |
| WSTG-SESS-04 | Test for Exposed Session Variables | Manual | Alta |
| WSTG-SESS-05 | Test for Cross-Site Request Forgery | Manual, Burp | Alta |
| WSTG-SESS-06 | Test for Logout Functionality | Manual | Alta |
| WSTG-SESS-07 | Test Session Timeout | Manual | Media |
| WSTG-SESS-08 | Test for Session Puzzling | Manual | Media |
| WSTG-SESS-09 | Test for Session Hijacking | Manual | Alta |

### WSTG - Input Validation Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-INPVAL-01 | Test for Reflected Cross-Site Scripting | Burp, `nuclei` | Alta |
| WSTG-INPVAL-02 | Test for Stored Cross-Site Scripting | Burp, Manual | Alta |
| WSTG-INPVAL-03 | Test for HTTP Verb Tampering | Burp | Alta |
| WSTG-INPVAL-04 | Test for HTTP Parameter Pollution | Burp | Alta |
| WSTG-INPVAL-05 | Test for SQL Injection | `sqlmap`, Burp | Alta |
| WSTG-INPVAL-06 | Test for LDAP Injection | Manual | Media |
| WSTG-INPVAL-07 | Test for ORM Injection | Manual | Media |
| WSTG-INPVAL-08 | Test for XML Injection | Manual | Alta |
| WSTG-INPVAL-09 | Test for SSI Injection | Manual | Media |
| WSTG-INPVAL-10 | Test for XPath Injection | Manual | Media |
| WSTG-INPVAL-11 | Test for IMAP/SMTP Injection | Manual | Baja |
| WSTG-INPVAL-12 | Test for Code Injection | Manual | Alta |
| WSTG-INPVAL-13 | Test for Command Injection | Manual | Alta |
| WSTG-INPVAL-14 | Test for Format String Injection | Manual | Baja |
| WSTG-INPVAL-15 | Test for Incubated Vulnerability | Manual | Alta |
| WSTG-INPVAL-16 | Test for HTTP Splitting/Smuggling | Burp, `smuggler` | Alta |

### WSTG - Error Handling

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-ERR-01 | Test for Improper Error Handling | Manual, Burp | Alta |
| WSTG-ERR-02 | Test for Stack Traces | Manual | Alta |
| WSTG-ERR-03 | Test for Debug Information | Manual | Alta |

### WSTG - Cryptography

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-CRYP-01 | Test for Weak Transport Layer Security | `testssl.sh`, `nmap` | Alta |
| WSTG-CRYP-02 | Test for Padding Oracle | Manual | Alta |
| WSTG-CRYP-03 | Test for Sensitive Information Sent via Unencrypted Channels | Burp | Alta |
| WSTG-CRYP-04 | Test for Weak Encryption | Manual | Alta |

### WSTG - Business Logic Testing

Ver sección [Business Logic Flaws](#business-logic-flaws).

### WSTG - Client Side Testing

| ID | Prueba | Herramienta | Prioridad |
|----|--------|------------|-----------|
| WSTG-CLNT-01 | Test for DOM-Based Cross-Site Scripting | Manual, Burp | Alta |
| WSTG-CLNT-02 | Test for JavaScript Execution | Manual | Alta |
| WSTG-CLNT-03 | Test for HTML Injection | Manual | Alta |
| WSTG-CLNT-04 | Test for Client Side Resource Manipulation | Manual | Media |
| WSTG-CLNT-05 | Test for Cross-Origin Resource Sharing | Manual | Alta |
| WSTG-CLNT-06 | Test for Cross Site Flashing | Manual | Baja |
| WSTG-CLNT-07 | Test for Clickjacking | Manual | Alta |
| WSTG-CLNT-08 | Test for WebSocket | Burp | Alta |
| WSTG-CLNT-09 | Test for Web Messaging | Manual | Alta |
| WSTG-CLNT-10 | Test for Local Storage | Manual | Alta |
| WSTG-CLNT-11 | Test for Session Storage | Manual | Alta |
| WSTG-CLNT-12 | Test for IndexedDB | Manual | Media |
| WSTG-CLNT-13 | Test for Cookies | Burp | Alta |

---

## Business Logic Flaws

### Tipos de Fallos de Lógica de Negocio

#### 1. Manipulación de Precios

```
# Escenario: Carrito de compras
POST /api/v1/cart/add HTTP/1.1
Content-Type: application/json
→ {"product_id": 1, "price": 0.01, "quantity": 1}
# El precio debería obtenerse del servidor, no del cliente

# Variantes:
# - Cambiar precio negativo para obtener crédito
# - Cambiar cantidad negativa
# - Aplicar cupones múltiples veces
# - Manipular descuentos de volumen
```

#### 2. Race Conditions

```
# Escenario: Redención de cupón
# Enviar múltiples requests simultáneas para el mismo cupón
# Solo debería poder usarse una vez

# Escenario: Transferencia bancaria
# Enviar múltiples requests de transferencia simultáneamente
# El saldo debería verificarse atómicamente

# Escenario: Compra de producto con stock limitado
# Múltiples usuarios intentan comprar el último producto simultáneamente
```

**Prueba con Turbo Intruder (Burp Suite):**

```python
# Script para Turbo Intruder - Race condition test
def queueRequests(target, wordlists):
    for i in range(100):
        engine.queue(target.req, gate='race')

    engine.openGate('race')

def handleResponse(req, interesting):
    table.add(req)
```

#### 3. Bypass de Flujos de Trabajo

```
# Escenario: Checkout con pasos
# Paso 1: Agregar al carrito
# Paso 2: Información de envío
# Paso 3: Pago
# Paso 4: Confirmación

# Ataque: Saltar directamente al paso 4 sin completar el pago
POST /api/v1/orders/confirm HTTP/1.1
→ {"order_id": 12345}
# Verificar si se puede confirmar sin haber pagado

# Ataque: Repetir un paso completado
POST /api/v1/orders/12345/pay HTTP/1.1
# Enviar múltiples veces para obtener múltiples "confirmaciones"
```

#### 4. Manipulación de Límites

```
# Escenario: Transferencia con límite diario de $10,000
# Ataque: Enviar transferencias de $9,999 múltiples veces
# El sistema debería acumular el total diario

# Escenario: Creación de cuentas con bono de bienvenida
# Ataque: Crear múltiples cuentas para obtener múltiples bonos

# Escenario: Cashback o puntos de recompensa
# Ataque: Manipular la cantidad de puntos ganados
```

#### 5. Bypass de Validación de Negocio

```
# Escenario: Aprobación de documentos
PUT /api/v1/documents/123/approve HTTP/1.1
→ {"approver_id": 1, "status": "approved"}
# Verificar si un usuario puede aprobar sus propios documentos

# Escenario: Transferencia entre cuentas propias
POST /api/v1/transfer HTTP/1.1
→ {"from_account": "A", "to_account": "B", "amount": 1000}
# Verificar si las cuentas A y B pertenecen al mismo usuario
# y si esto elude controles de lavado de dinero
```

#### 6. Time-of-Check to Time-of-Use (TOCTOU)

```
# Escenario: Verificación de saldo vs. uso
# 1. Verificar saldo suficiente
# 2. Procesar transacción
# Entre 1 y 2, otra transacción podría reducir el saldo

# Escenario: Verificación de permisos vs. acción
# 1. Verificar que el usuario tiene permiso
# 2. Ejecutar la acción
# Entre 1 y 2, los permisos podrían cambiarse
```

### Metodología de Pruebas de Lógica de Negocio

```
1. IDENTIFICAR: Mapear todos los flujos de negocio críticos
2. COMPRENDER: Entender las reglas de negocio y restricciones
3. ANALIZAR: Identificar posibles bypasses y manipulaciones
4. PROBAR: Diseñar casos de prueba específicos para cada flujo
5. DOCUMENTAR: Registrar hallazgos con evidencia clara
```

### Checklist de Pruebas de Lógica de Negocio

- [ ] ¿Se pueden manipular precios en el carrito?
- [ ] ¿Se pueden aplicar cupones múltiples veces?
- [ ] ¿Se pueden saltar pasos en flujos de trabajo?
- [ ] ¿Existen race conditions en transacciones?
- [ ] ¿Se pueden manipular cantidades (negativas, decimales)?
- [ ] ¿Se pueden eludir límites de transferencia/compra?
- [ ] ¿Se pueden aprobar acciones propias (self-approval)?
- [ ] ¿Se pueden manipular fechas de transacciones?
- [ ] ¿Se pueden crear órdenes con estado manipulado?
- [ ] ¿Se pueden acceder a recursos de otros usuarios mediante lógica de negocio?

---

## Herramientas - Burp Suite

### Flujo de Trabajo con Burp Suite

```
1. Configurar proxy (127.0.0.1:8080)
2. Instalar certificado CA en navegador
3. Navegar la aplicación objetivo (Spidering)
4. Enviar requests interesantes a Repeater
5. Usar Intruder para fuzzing y fuerza bruta
6. Usar Scanner para escaneo automático
7. Usar extensiones para pruebas específicas
8. Documentar hallazgos en Logger++
```

### Configuración de Proyecto

```
# Project options
- Scope: Definir target scope (Include/Exclude)
- Sessions: Configurar reglas de sesión
- TLS: Configurar Client TLS certificates

# User options
- TLS: Configurar TLS negotiation
- Display: Configurar UI
- Misc: Configurar hotkeys
```

### Intruder - Payloads y Posiciones

```
# Tipos de ataque:
# 1. Sniper - Una posición, un payload a la vez
# 2. Battering ram - Mismo payload en todas las posiciones
# 3. Pitchfork - Un payload por posición, en paralelo
# 4. Cluster bomb - Combinación de todos los payloads

# Payloads comunes:
# - Numbers: 1-10000
# - Runtime file: /usr/share/wordlists/rockyou.txt
# - Custom iterator: Combinaciones de campos
# - Character substitution: Mutaciones de payloads
```

### Repeater - Tips

```
# Enviar requests con modificaciones rápidas
# Usar Ctrl+R para enviar a Repeater
# Usar Ctrl+Shift+R para enviar a Repeater y editar

# Comparar respuestas
# Click derecho → "Compare with response..."
# Útil para identificar diferencias sutiles entre respuestas
```

### Scanner Configuration

```
# Scan configuration:
# - Crawl and Audit: Escaneo completo
# - Crawl Only: Solo descubrimiento
# - Audit Only: Solo auditoría de URLs conocidas

# Scan speed:
# - Fast: Menos requests, menos cobertura
# - Thorough: Más requests, más cobertura
# - Custom: Configuración personalizada

# Insertion point types:
# - URL path
# - URL parameters
# - Body parameters
# - Cookie parameters
# - Multipart form-data
# - JSON parameters
# - XML parameters
```

---

## Mapeo con MITRE ATT&CK, NIST CSF y D3FEND

### Tabla de Mapeo Completa

| OWASP Top 10 | MITRE ATT&CK (Tactic/Technique) | NIST CSF | D3FEND |
|-------------|----------------------------------|----------|--------|
| A01 - Broken Access Control | TA0004/Privilege Escalation, T1078 | PR.AC | d3f:AccessLimitation |
| A02 - Cryptographic Failures | TA0006/Credential Access, T1552 | PR.DS | d3f:DataEncryption |
| A03 - Injection | TA0002/Execution, T1190 | PR.IP | d3f:InputValidation |
| A04 - Insecure Design | TA0043/Reconnaissance, T1498 | ID.RA | d3f:ApplicationHardening |
| A05 - Security Misconfiguration | TA0001/Initial Access, T1082 | PR.PT | d3f:ConfigurationHardening |
| A06 - Vulnerable Components | TA0001/Initial Access, T1190 | ID.RA | d3f:VulnerabilityAnalysis |
| A07 - Auth Failures | TA0006/Credential Access, T1110 | PR.AC | d3f:Authentication |
| A08 - Integrity Failures | TA0003/Persistence, T1195 | PR.DS | d3f:FileIntegrityAnalysis |
| A09 - Logging Failures | TA0005/Defense Evasion, T1562 | DE.CM | d3f:LogAnalysis |
| A10 - SSRF | TA0001/Initial Access, T1190 | PR.AC | d3f:URLAnalysis |

### Mapeo Detallado - MITRE ATT&CK

```
# Tácticas relevantes para Web App Security:

# TA0001 - Initial Access
#   T1190 - Exploit Public-Facing Application
#   T1133 - External Remote Services
#   T1078 - Valid Accounts

# TA0002 - Execution
#   T1059 - Command and Scripting Interpreter
#   T1203 - Exploitation for Client Execution

# TA0003 - Persistence
#   T1505 - Server Software Component
#   T1195 - Supply Chain Compromise

# TA0004 - Privilege Escalation
#   T1078 - Valid Accounts
#   T1068 - Exploitation for Privilege Escalation

# TA0005 - Defense Evasion
#   T1562 - Impair Defenses
#   T1070 - Indicator Removal

# TA0006 - Credential Access
#   T1110 - Brute Force
#   T1552 - Unsecured Credentials
#   T1040 - Network Sniffing

# TA0007 - Discovery
#   T1082 - System Information Discovery
#   T1087 - Account Discovery

# TA0008 - Lateral Movement
#   T1080 - Taint Shared Content

# TA0009 - Collection
#   T1530 - Data from Cloud Storage

# TA0010 - Exfiltration
#   T1048 - Exfiltration Over Alternative Protocol

# TA0011 - Command and Control
#   T1071 - Application Layer Protocol
#   T1132 - Data Encoding
```

### Mapeo Detallado - NIST CSF

```
# Identify (ID)
#   ID.AM - Asset Management
#   ID.RA - Risk Assessment
#   ID.RM - Risk Management Strategy

# Protect (PR)
#   PR.AC - Identity Management and Access Control
#   PR.DS - Data Security
#   PR.IP - Information Protection Processes
#   PR.PT - Protective Technology

# Detect (DE)
#   DE.CM - Security Continuous Monitoring
#   DE.AE - Anomalies and Events
#   DE.DP - Detection Processes

# Respond (RS)
#   RS.AN - Analysis
#   RS.MI - Mitigation
#   RS.CO - Communications

# Recover (RC)
#   RC.RP - Recovery Plan Execution
#   RC.IM - Improvements
#   RC.CO - Communications
```

### Mapeo Detallado - D3FEND

```
# Modelo D3FEND - Técnicas de contramedida:

# d3f:AccessLimitation - Limitar acceso a recursos
# d3f:ApplicationHardening - Endurecimiento de aplicación
# d3f:Authentication - Mecanismos de autenticación
# d3f:ConfigurationHardening - Endurecimiento de configuración
# d3f:DataEncryption - Cifrado de datos
# d3f:FileIntegrityAnalysis - Análisis de integridad de archivos
# d3f:InputValidation - Validación de entrada
# d3f:LogAnalysis - Análisis de logs
# d3f:MultiFactorAuthentication - Autenticación multifactor
# d3f:NetworkTrafficAnalysis - Análisis de tráfico de red
# d3f:ObjectAccessControl - Control de acceso a objetos
# d3f:ParameterizedQueries - Consultas parametrizadas
# d3f:PatchManagement - Gestión de parches
# d3f:RateLimit - Limitación de tasa
# d3f:SoftwareVerification - Verificación de software
# d3f:URLAnalysis - Análisis de URLs
# d3f:VulnerabilityAnalysis - Análisis de vulnerabilidades
```

---

## Guías de Remediación

### Matriz de Priorización

| Severidad | Tiempo de Remediación | SLA BRIDA |
|-----------|----------------------|-----------|
| Critical | 24-48 horas | Inmediato |
| High | 1 semana | 72 horas |
| Medium | 30 días | 2 semanas |
| Low | 90 días | 1 mes |
| Informational | Próximo release | Próximo sprint |

### Principios Generales de Remediación

1. **Defense in Depth:** Múltiples capas de seguridad
2. **Least Privilege:** Mínimo privilegio necesario
3. **Fail Safe Defaults:** Denegar por defecto
4. **Input Validation:** Validar en el servidor, nunca confiar en el cliente
5. **Output Encoding:** Codificar salida según contexto
6. **Secure by Design:** Seguridad desde el diseño

### Quick Wins de Seguridad

```python
# 1. Headers de seguridad (implementación inmediata)
SECURITY_HEADERS = {
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'X-XSS-Protection': '1; mode=block',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
    'Content-Security-Policy': "default-src 'self'",
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'Permissions-Policy': 'geolocation=(), camera=(), microphone=()',
}

# 2. Configuración segura de cookies
SESSION_COOKIE_SECURE = True
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SAMESITE = 'Lax'
SESSION_COOKIE_NAME = '__Host-session'  # Cookie prefix

# 3. Configuración segura de CORS
CORS_ALLOWED_ORIGINS = ['https://app.bridait.com']
CORS_ALLOW_CREDENTIALS = True
CORS_MAX_AGE = 600

# 4. Rate limiting global
RATELIMIT_DEFAULT = "200/hour"
RATELIMIT_STORAGE_URL = "redis://localhost:6379/0"

# 5. Logging de seguridad
LOGGING = {
    'version': 1,
    'handlers': {
        'security_file': {
            'class': 'logging.FileHandler',
            'filename': '/var/log/security.log',
        },
    },
    'loggers': {
        'security': {
            'handlers': ['security_file'],
            'level': 'INFO',
        },
    },
}
```

### Secure Coding Checklist

```
# Antes de cada release, verificar:

## Autenticación
- [ ] Contraseñas hasheadas con bcrypt/argon2
- [ ] MFA implementado para cuentas privilegiadas
- [ ] Sesiones con timeout configurado
- [ ] Tokens JWT con algoritmos seguros y expiración
- [ ] Rate limiting en endpoints de autenticación

## Autorización
- [ ] Verificación de acceso a cada recurso (object-level)
- [ ] Roles y permisos bien definidos
- [ ] No confiar en validación del cliente
- [ ] Principio de mínimo privilegio

## Input Validation
- [ ] Validación de tipo, longitud, formato y rango
- [ ] Consultas parametrizadas (nunca concatenación)
- [ ] Sanitización de HTML/JavaScript
- [ ] Validación de file uploads (tipo, tamaño, contenido)

## Output Encoding
- [ ] Encoding según contexto (HTML, JS, URL, CSS)
- [ ] Content-Type correcto en respuestas
- [ ] No exponer datos sensibles en respuestas

## Criptografía
- [ ] TLS 1.2+ en todas las comunicaciones
- [ ] Algoritmos criptográficos actualizados
- [ ] Claves gestionadas de forma segura (KMS/Vault)
- [ ] No hardcodear secretos en código

## Logging y Monitoreo
- [ ] Eventos de seguridad logueados
- [ ] Alertas configuradas para eventos críticos
- [ ] Logs protegidos contra manipulación
- [ ] Retención de logs según compliance
```

---

## Plantillas de Reporte

### Plantilla de Reporte Ejecutivo

```markdown
# Reporte de Seguridad de Aplicación Web
## BRIDA IT Services

---

**Cliente:** [Nombre del Cliente]
**Fecha de Evaluación:** [DD/MM/YYYY] - [DD/MM/YYYY]
**Versión del Documento:** 1.0
**Clasificación:** CONFIDENCIAL

---

## Resumen Ejecutivo

### Alcance
Evaluación de seguridad de la aplicación web [nombre] accesible en [URL],
realizada siguiendo la metodología OWASP Top 10 (2021) y WSTG.

### Hallazgos por Severidad

| Severidad | Cantidad | Porcentaje |
|-----------|----------|------------|
| 🔴 Critical | X | X% |
| 🟠 High | X | X% |
| 🟡 Medium | X | X% |
| 🔵 Low | X | X% |
| ⚪ Informational | X | X% |
| **Total** | **X** | **100%** |

### Risk Score General: [CRITICAL / HIGH / MEDIUM / LOW]

### Principales Hallazgos

1. **[Nombre de la vulnerabilidad]** - [Breve descripción]
2. **[Nombre de la vulnerabilidad]** - [Breve descripción]
3. **[Nombre de la vulnerabilidad]** - [Breve descripción]

### Recomendaciones Prioritarias

1. [Recomendación 1 - Acción inmediata]
2. [Recomendación 2 - Acción a corto plazo]
3. [Recomendación 3 - Acción a mediano plazo)

### Próximos Pasos

- [ ] Remediación de hallazgos Critical y High
- [ ] Re-evaluación post-remediación
- [ ] Implementación de controles de seguridad preventivos
- [ ] Programa de seguridad continua (DevSecOps)

---

**Elaborado por:** [Nombre del Analista]
**Revisado por:** [Nombre del Revisor]
**Aprobado por:** [Nombre del Líder]
```

### Plantilla de Hallazgo Técnico

```markdown
## [VULN-YYYY-NNN] [Nombre de la Vulnerabilidad]

### Información General

| Campo | Valor |
|-------|-------|
| **ID** | VULN-YYYY-NNN |
| **Título** | [Nombre de la vulnerabilidad] |
| **Severidad** | Critical / High / Medium / Low / Informational |
| **CVSS v3.1** | [Score] ([Vector]) |
| **OWASP Top 10** | [A0X:2021 - Nombre] |
| **WSTG** | [WSTG-XXX-NN] |
| **MITRE ATT&CK** | [TXXXX - Technique Name] |
| **NIST CSF** | [PR.XX / DE.XX / etc.] |
| **D3FEND** | [d3f:TechniqueName] |
| **Affected URL** | https://target.com/vulnerable-endpoint |
| **Affected Parameter** | [param_name] |
| **Método HTTP** | GET / POST / PUT / DELETE |
| **Autenticación** | Requerida / No requerida |

### Descripción

[Descripción detallada de la vulnerabilidad, incluyendo:
- Qué es la vulnerabilidad
- Por qué es un problemo
- Cómo fue identificada
- Contexto técnico]

### Pasos para Reproducir

```http
### Request

POST /api/v1/endpoint HTTP/1.1
Host: target.com
Content-Type: application/json
Authorization: Bearer <token>

{
    "param1": "value1",
    "param2": "malicious_payload"
}

### Response

HTTP/1.1 200 OK
Content-Type: application/json

{
    "result": "vulnerable_response",
    "data": "sensitive_information"
}
```

**Paso 1:** [Descripción del paso]
**Paso 2:** [Descripción del paso]
**Paso 3:** [Descripción del paso]

### Evidencia

**Screenshot 1:** [Descripción de la captura]
**Screenshot 2:** [Descripción de la captura]

### Impacto

[Descripción detallada del impacto potencial:
- Datos que podrían comprometerse
- Sistemas afectados
- Impacto en el negocio
- Escenarios de ataque]

### Remediación

**Solución Inmediata (Quick Fix):**
[Acción inmediata para mitigar el riesgo]

**Solución Definitiva:**
[Solución completa con código de ejemplo]

```python
# Código de remediación
def secure_endpoint(request):
    # 1. Validar entrada
    user_input = validate_input(request.param)

    # 2. Verificar autorización
    if not has_permission(request.user, 'resource:read'):
        abort(403)

    # 3. Usar consultas parametrizadas
    result = db.execute(
        "SELECT * FROM resources WHERE id = %s",
        (user_input,)
    )

    # 4. Codificar salida
    return sanitize_output(result)
```

**Referencias:**
- [OWASP - Vulnerability Name](https://owasp.org/...)
- [CWE-XXX](https://cwe.mitre.org/...)
- [CVE-XXXX-XXXXX](https://nvd.nist.gov/...)

### Notas Adicionales

[Cualquier información adicional relevante]
```

### Plantilla de Reporte Técnico Completo

```markdown
# Reporte Técnico de Seguridad
## Evaluación de Aplicación Web
### BRIDA IT Services

---

## 1. Información del Proyecto

| Campo | Valor |
|-------|-------|
| Cliente | [Nombre] |
| Proyecto | [Nombre del Proyecto] |
| Fecha Inicio | [DD/MM/YYYY] |
| Fecha Fin | [DD/MM/YYYY] |
| Tipo de Prueba | Black Box / Gray Box / White Box |
| Alcance | [URLs, APIs, funcionalidades] |
| Exclusiones | [URLs o funcionalidades excluidas] |
| Ventana de Pruebas | [Fechas y horarios permitidos] |
| Contacto Técnico | [Nombre, email, teléfono] |

## 2. Equipo de Evaluación

| Rol | Nombre | Certificaciones |
|-----|--------|-----------------|
| Líder Técnico | [Nombre] | OSCP, OSWE |
| Analista Senior | [Nombre] | CEH, GWAPT |
| Analista | [Nombre] | eWPT |

## 3. Metodología

Esta evaluación siguió las siguientes metodologías y estándares:
- OWASP Top 10 (2021)
- OWASP Testing Guide v4.2
- OWASP API Top 10 (2023)
- WSTG (Web Security Testing Guide)
- PTES (Penetration Testing Execution Standard)

## 4. Herramientas Utilizadas

| Herramienta | Versión | Propósito |
|-------------|---------|-----------|
| Burp Suite Professional | 2024.x | Proxy, escaneo, fuzzing |
| SQLMap | 1.x | SQL Injection |
| Nuclei | 3.x | Escaneo de vulnerabilidades |
| ffuf | 2.x | Fuzzing de directorios |
| jwt_tool | 2.x | Análisis de JWT |
| Custom scripts | N/A | Pruebas específicas |

## 5. Hallazgos

### 5.1 Resumen de Hallazgos

| ID | Título | Severidad | CVSS | Estado |
|----|--------|-----------|------|--------|
| VULN-2024-001 | SQL Injection in Search | Critical | 9.8 | Open |
| VULN-2024-002 | Broken Access Control | High | 8.1 | Open |
| VULN-2024-003 | Sensitive Data Exposure | High | 7.5 | Open |
| VULN-2024-004 | XSS Reflected | Medium | 6.1 | Open |
| VULN-2024-005 | Missing Security Headers | Low | 3.1 | Open |

### 5.2 Detalle de Hallazgos

[Usar Plantilla de Hallazgo Técnico para cada hallazgo]

## 6. Mapeo con Frameworks

### 6.1 MITRE ATT&CK Mapping

| Hallazgo | Táctica | Técnica | ID |
|----------|---------|---------|----|
| SQLi | Execution | Exploit Public-Facing Application | T1190 |
| BOLA | Privilege Escalation | Valid Accounts | T1078 |
| XSS | Execution | Exploitation for Client Execution | T1203 |

### 6.2 NIST CSF Mapping

| Hallazgo | Función | Categoría | ID |
|----------|---------|-----------|----|
| SQLi | Protect | Information Protection Processes | PR.IP |
| BOLA | Protect | Identity Management | PR.AC |
| Missing Logging | Detect | Security Continuous Monitoring | DE.CM |

### 6.3 D3FEND Mapping

| Hallazgo | Contramedida | ID |
|----------|-------------|----|
| SQLi | Parameterized Queries | d3f:ParameterizedQueries |
| BOLA | Object Access Control | d3f:ObjectAccessControl |
| XSS | Input Validation | d3f:InputValidation |

## 7. Recomendaciones

### 7.1 Acciones Inmediatas (0-48 horas)
1. [Acción 1]
2. [Acción 2]

### 7.2 Acciones a Corto Plazo (1-4 semanas)
1. [Acción 1]
2. [Acción 2]

### 7.3 Acciones a Mediano Plazo (1-3 meses)
1. [Acción 1]
2. [Acción 2]

### 7.4 Mejoras a Largo Plazo (3-12 meses)
1. Implementar DevSecOps pipeline
2. Programa de bug bounty
3. Security training para desarrolladores
4. WAF (Web Application Firewall)

## 8. Conclusión

[Resumen ejecutivo de los hallazgos principales y el estado general
de seguridad de la aplicación]

## Apéndices

### Apéndice A: Evidencia Adicional
### Apéndice B: Requests y Responses Completos
### Apéndice C: Configuración de Herramientas
### Apéndice D: Glosario
```

---

## Checklist de Auditoría

### Pre-Engagement

```
[ ] Autorización escrita del cliente recibida
[ ] Scope documentado y acordado
[ ] Reglas de engagement definidas
[ ] Ventana de pruebas confirmada
[ ] Contactos de emergencia identificados
[ ] Credenciales de prueba proporcionadas
[ ] Entorno de prueba configurado
[ ] Herramientas actualizadas
[ ] Plantillas de reporte preparadas
[ ] NDA firmado
```

### Testing Checklist

```
# OWASP Top 10 (2021)
[ ] A01 - Broken Access Control
    [ ] IDOR testing
    [ ] Privilege escalation
    [ ] CORS configuration
    [ ] Directory traversal
    [ ] JWT manipulation
    [ ] Path traversal

[ ] A02 - Cryptographic Failures
    [ ] TLS configuration
    [ ] Sensitive data exposure
    [ ] Weak algorithms
    [ ] Key management
    [ ] Certificate validation

[ ] A03 - Injection
    [ ] SQL Injection
    [ ] NoSQL Injection
    [ ] OS Command Injection
    [ ] LDAP Injection
    [ ] XSS (Reflected, Stored, DOM)
    [ ] SSTI
    [ ] XML Injection (XXE)

[ ] A04 - Insecure Design
    [ ] Rate limiting
    [ ] Anti-automation
    [ ] Business logic review
    [ ] Race conditions

[ ] A05 - Security Misconfiguration
    [ ] Default credentials
    [ ] Directory listing
    [ ] Error handling
    [ ] Security headers
    [ ] HTTP methods
    [ ] Cloud storage

[ ] A06 - Vulnerable Components
    [ ] Version detection
    [ ] Known CVEs
    [ ] Dependency check
    [ ] End-of-life software

[ ] A07 - Auth Failures
    [ ] Password policy
    [ ] Session management
    [ ] MFA implementation
    [ ] Account lockout
    [ ] Password reset
    [ ] JWT security

[ ] A08 - Integrity Failures
    [ ] Deserialization
    [ ] CI/CD integrity
    [ ] Update verification
    [ ] Cache poisoning

[ ] A09 - Logging Failures
    [ ] Security event logging
    [ ] Log injection
    [ ] Alert configuration
    [ ] Log protection

[ ] A10 - SSRF
    [ ] Basic SSRF
    [ ] Blind SSRF
    [ ] Protocol smuggling
    [ ] Cloud metadata access

# API Security
[ ] BOLA
[ ] Broken Authentication
[ ] Property Level Authorization
[ ] Resource Consumption
[ ] Function Level Authorization
[ ] Sensitive Business Flows
[ ] SSRF
[ ] Misconfiguration
[ ] Inventory Management
[ ] Unsafe API Consumption

# Business Logic
[ ] Price manipulation
[ ] Race conditions
[ ] Workflow bypass
[ ] Limit manipulation
[ ] Self-approval
[ ] TOCTOU
```

### Post-Engagement

```
[ ] Todos los hallazgos documentados
[ ] Evidencia capturada y almacenada
[ ] Reporte ejecutivo completado
[ ] Reporte técnico completado
[ ] Mapeo MITRE ATT&CK incluido
[ ] Mapeo NIST CSF incluido
[ ] Mapeo D3FEND incluido
[ ] Guías de remediación proporcionadas
[ ] Revisión de calidad del reporte
[ ] Entrega al cliente programada
[ ] Reunión de debriefing agendada
[ ] Datos de prueba eliminados
[ ] Acceso temporal revocado
[ ] Lecciones aprendidas documentadas
```

---

## Referencias

- OWASP Top 10 (2021): https://owasp.org/Top10/
- OWASP API Top 10 (2023): https://owasp.org/API-Security/
- OWASP Testing Guide: https://owasp.org/www-project-web-security-testing-guide/
- WSTG: https://owasp.org/www-project-web-security-testing-guide/
- MITRE ATT&CK: https://attack.mitre.org/
- NIST CSF: https://www.nist.gov/cyberframework
- D3FEND: https://d3fend.mitre.org/
- CWE: https://cwe.mitre.org/
- PortSwigger Web Security Academy: https://portswigger.net/web-security

---

*Documento mantenido por BRIDA IT Services - Security Team*
*Última actualización: 2024*
*Para actualizaciones o consultas: security@bridait.com*
