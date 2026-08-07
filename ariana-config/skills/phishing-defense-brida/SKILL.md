---
name: phishing-defense-brida
description: 'Defensa integral contra phishing, spear-phishing, BEC (Business Email
  Compromise) y ataques de ingeniería social por correo electrónico para clientes
  de BRIDA IT Services. Cubre autenticación de email (SPF/DKIM/DMARC), análisis forense
  de headers, análisis de URLs y attachments, sandboxing, detección de BEC, simulaciones
  con GoPhish, concientización de usuarios, respuesta a incidentes de phishing y plantillas
  de reporte. Mapeo completo a MITRE ATT&CK (T1566, T1598), NIST CSF y D3FEND. Activado
  por: phishing, email security, BEC, spear phishing, spoofing, DMARC, SPF, DKIM,
  email compromise, phishing response, email forensic, análisis de correo, ingeniería
  social, email spoofing, phishing simulation, GoPhish.

  '
domain: cybersecurity
subdomain: email-security
category: cybersecurity
tags:
- phishing
- spear-phishing
- email-security
- spf-dkim-dmarc
- bec
- business-email-compromise
- spoofing
- email-gateway
- email-forensics
- url-analysis
- sandboxing
- gophish
- phishing-simulation
- user-awareness
- incident-response
- nist-csf
- mitre-attack
- d3fend
- google-workspace
- cloudflare
mitre_attack:
- T1566.001
- T1566.002
- T1566.003
- T1598.001
- T1598.002
- T1598.003
- T1204.002
- T1204.001
- T1114.002
- T1114.003
- T1056.003
- T1583.001
- T1585.001
nist_csf:
- PR.AT-01
- PR.AT-02
- PR.DS-02
- DE.CM-01
- DE.CM-09
- DE.AE-02
- DE.AE-06
- RS.MA-01
- RS.AN-03
- RS.AN-06
- RC.RP-01
d3fend:
- D3-DNSA
- D3-ER
- D3-ET
- D3-EF
- D3-IA
- D3-URA
- D3-SS
- D3-SEA
- D3-SPP
- D3-PA
- D3-UBA
- D3-NTA
- D3-IS
version: 2.0.0
author: BRIDA IT Services
methodology: NIST SP 800-83, NIST SP 800-61 Rev. 2, CISA Phishing Guidance
tools:
- Google Workspace Admin Console
- Cloudflare DNS
- MXToolbox
- VirusTotal
- Any.Run
- URLScan.io
- GoPhish
- Email Header Analyzer (Google Admin Toolbox)
- CrowdStrike Falcon (EDR)
- Trellix ePO (Endpoint Protection)
frameworks:
- MITRE ATT&CK v14
- NIST Cybersecurity Framework v2.0
- MITRE D3FEND
- CISA Phishing Guidance
language: es (términos de ciberseguridad en inglés)
---

# Phishing Defense — BRIDA IT Services v2.0

## Tabla de Contenidos

1. [Stack Tecnológico BRIDA](#1-stack-tecnológico-brida)
2. [Cuándo Usar Este Skill](#2-cuándo-usar-este-skill)
3. [Fase 1: Prevención — Email Authentication (SPF/DKIM/DMARC)](#3-fase-1-prevención--email-authentication-spfdkimdmarc)
4. [Fase 2: Detección — Análisis de Correos Sospechosos](#4-fase-2-detección--análisis-de-correos-sospechosos)
5. [Fase 3: Análisis Forense de Headers](#5-fase-3-análisis-forense-de-headers)
6. [Fase 4: Análisis de URLs](#6-fase-4-análisis-de-urls)
7. [Fase 5: Análisis de Attachments y Sandboxing](#7-fase-5-análisis-de-attachments-y-sandboxing)
8. [Fase 6: Detección de BEC (Business Email Compromise)](#8-fase-6-detección-de-bec-business-email-compromise)
9. [Fase 7: Respuesta a Incidentes de Phishing](#9-fase-7-respuesta-a-incidentes-de-phishing)
10. [Fase 8: Simulación de Phishing con GoPhish](#10-fase-8-simulación-de-phishing-con-gophish)
11. [Fase 9: Programa de Concientización](#11-fase-9-programa-de-concientización)
12. [Plantillas de Reporte](#12-plantillas-de-reporte)
13. [Matrices de Mapeo](#13-matrices-de-mapeo)
14. [Herramientas y Comandos de Referencia](#14-herramientas-y-comandos-de-referencia)
15. [Notas Específicas para Clientes BRIDA](#15-notas-específicas-para-clientes-brida)

---

## 1. Stack Tecnológico BRIDA

| Capa | Herramienta | Propósito |
|------|-------------|-----------|
| **Email Service** | Google Workspace | Correo electrónico empresarial |
| **DNS / CDN** | Cloudflare | Gestión de registros DNS (SPF/DKIM/DMARC) |
| **Email Gateway** | Google Workspace built-in + Cloudflare Email Security | Filtrado de spam y phishing |
| **Análisis de URLs** | VirusTotal, URLScan.io, Any.Run | Escaneo de enlaces sospechosos |
| **Análisis de Archivos** | VirusTotal, Any.Run (sandbox) | Escaneo de attachments |
| **Simulación** | GoPhish | Campañas de phishing simulado |
| **EDR** | CrowdStrike Falcon / Trellix ePO | Detección de payloads en endpoints |
| **DNS Lookup** | MXToolbox, `dig`, `nslookup` | Verificación de registros |
| **Header Analysis** | Google Admin Toolbox, MXToolbox | Análisis de cabeceras de correo |

---

## 2. Cuándo Usar Este Skill

- Implementación inicial de SPF/DKIM/DMARC para un cliente
- Respuesta a un incidente de phishing activo
- Análisis de un correo electrónico sospechoso
- Investigación de BEC (Business Email Compromise)
- Configuración de simulaciones de phishing con GoPhish
- Solicitud del cliente: *"nos llegó un correo sospechoso"*
- Auditoría de seguridad del correo electrónico
- Programa de concientización y entrenamiento de usuarios
- Reporte post-incidente de phishing

---

## 3. Fase 1: Prevención — Email Authentication (SPF/DKIM/DMARC)

### 3.1 SPF (Sender Policy Framework)

SPF permite al propietario de un dominio especificar qué servidores están autorizados a enviar correos en su nombre.

#### Implementación en Cloudflare DNS

**Registro TXT para Google Workspace:**
```
Tipo: TXT
Nombre: @
Valor: v=spf1 include:_spf.google.com ~all
TTL: Auto
```

**Registro para dominios que NO envían correo (protección contra abuso):**
```
Tipo: TXT
Nombre: @
Valor: v=spf1 -all
```

#### Proceso de Implementación

1. **Auditar el dominio actual:**
   ```bash
   dig TXT ejemplo.com +short
   nslookup -type=TXT ejemplo.com
   ```

2. **Verificar con MXToolbox:**
   - Ir a https://mxtoolbox.com/spf.aspx
   - Ingresar el dominio del cliente
   - Verificar que no exista un registro SPF previo conflictivo

3. **Crear el registro en Cloudflare:**
   - Acceder al dashboard de Cloudflare
   - Seleccionar el dominio del cliente
   - Ir a **DNS → Records**
   - Agregar registro TXT con los valores indicados arriba

4. **Fase de monitoreo (2-4 semanas):**
   - Usar `~all` (softfail) inicialmente
   - Revisar los informes DMARC para identificar fuentes legítimas
   - Agregar cualquier fuente legítima faltante al registro SPF

5. **Hardfail:**
   - Cambiar a `-all` una vez verificado que todo el tráfico legítimo pasa
   - `-all` rechaza correos de servidores no autorizados

#### Errores Comunes de SPF

| Error | Descripción | Solución |
|-------|-------------|----------|
| `PermError` | El registro SPF tiene sintaxis inválida | Revisar sintaxis con MXToolbox |
| `Too many lookups` | Más de 10 lookups DNS | Simplificar includes, usar IPs directas |
| `Neutral` | El registro usa `?all` | Cambiar a `~all` o `-all` |
| `None` | No existe registro SPF | Crear el registro SPF |

### 3.2 DKIM (DomainKeys Identified Mail)

DKIM agrega una firma criptográfica a cada correo saliente, permitiendo al receptor verificar que el correo no fue alterado en tránsito.

#### Implementación con Google Workspace + Cloudflare

1. **Generar la clave DKIM en Google Workspace:**
   - Ir a **Admin Console → Apps → Google Workspace → Gmail → Authenticate email**
   - Seleccionar el dominio
   - Hacer clic en **Generate new record**
   - Google proporcionará un selector (generalmente `google`) y la clave pública

2. **Publicar el registro en Cloudflare DNS:**
   ```
   Tipo: TXT
   Nombre: google._domainkey
   Valor: v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA...
   TTL: Auto
   ```

3. **Activar la firma DKIM:**
   - En Google Workspace Admin Console, hacer clic en **Start authentication**
   - Esperar 24-48 horas para propagación DNS

4. **Verificación:**
   ```bash
   dig TXT google._domainkey.ejemplo.com +short
   ```
   - Enviar un correo de prueba a `check-auth@verifier.port25.com`
   - Verificar con https://mxtoolbox.com/dkim.aspx

#### Selectores DKIM

Si se usan múltiples servicios de correo, cada uno necesita su propio selector:
- Google Workspace: `google._domainkey`
- Microsoft 365: `selector1._domainkey`, `selector2._domainkey`
- Servicios adicionales: `service1._domainkey`, etc.

### 3.3 DMARC (Domain-based Message Authentication, Reporting & Conformance)

DMARC combina SPF y DKIM, y proporciona instrucciones a los servidores receptores sobre cómo manejar correos que fallan la autenticación. También genera informes agregados y forenses.

#### Implementación Gradual (Enfoque en 3 Fases)

**Fase 1 — Monitoreo (p=none):**
```
Tipo: TXT
Nombre: _dmarc
Valor: v=DMARC1; p=none; rua=mailto:dmarc-aggregate@ejemplo.com; ruf=mailto:dmarc-forensic@ejemplo.com; fo=1; adkim=r; aspf=r; pct=100
```
- Duración: 2-4 semanas
- No se toma acción sobre correos que fallan
- Se recopilan datos sobre todo el tráfico de correo

**Fase 2 — Cuarentena (p=quarantine):**
```
Valor: v=DMARC1; p=quarantine; pct=100; rua=mailto:dmarc-aggregate@ejemplo.com; ruf=mailto:dmarc-forensic@ejemplo.com; fo=1
```
- Duración: 2-4 semanas
- Correos que fallan van a spam/quarantine
- Se monitorea impacto en correos legítimos

**Fase 3 — Rechazo (p=reject):**
```
Valor: v=DMARC1; p=reject; rua=mailto:dmarc-aggregate@ejemplo.com; ruf=mailto:dmarc-forensic@ejemplo.com; fo=1
```
- Correos que fallan son rechazados por el servidor receptor
- Protección máxima contra spoofing

#### Parámetros DMARC

| Parámetro | Valores | Descripción |
|-----------|---------|-------------|
| `p` | `none`, `quarantine`, `reject` | Política para el dominio |
| `sp` | `none`, `quarantine`, `reject` | Política para subdominios |
| `pct` | 0-100 | Porcentaje de correos a los que aplica la política |
| `rua` | email | Destino de informes agregados (XML) |
| `ruf` | email | Destino de informes forenses (individuales) |
| `fo` | 0, 1, d, s | Opciones de generación de fallos |
| `adkim` | `r` (relaxed), `s` (strict) | Alineación DKIM |
| `aspf` | `r` (relaxed), `s` (strict) | Alineación SPF |

#### Procesamiento de Informes DMARC

Los informes DMARC llegan como archivos XML comprimidos (gzip). Herramientas para procesarlos:

- **dmarcian** (https://dmarcian.com) — Procesamiento visual de informes
- **Postmark DMARC Digests** — Procesamiento gratuito
- **Parsedmarc** (Python):
  ```bash
  pip install parsedmarc
  parsedmarc -c /etc/parsedmarc.ini /path/to/reports/
  ```
- **Google Workspace** — Configurar un grupo de correo para recibir informes

### 3.4 BIMI (Brand Indicators for Message Identification) — Opcional

BIMI permite mostrar el logo de la marca en los correos autenticados (compatible con Gmail y Yahoo).

```
Tipo: TXT
Nombre: _bimi
Valor: v=BIMI1; l=https://ejemplo.com/logo.svg; a=https://ejemplo.com/vmc.pem
```

Requiere:
- DMARC en `p=quarantine` o `p=reject`
- Logo en formato SVG Tiny P/S
- VMC (Verified Mark Certificate) — opcional pero recomendado

### 3.5 MTA-STS (Mail Transfer Agent Strict Transport Security)

Fuerza conexiones TLS entre servidores de correo.

```
Tipo: TXT
Nombre: _mta-sts
Valor: v=STSv1; id=20240615
```

Archivo `mta-sts.txt` en `https://mta-sts.ejemplo.com/.well-known/mta-sts.txt`:
```
version: STSv1
mode: enforce
mx: aspmx.l.google.com
mx: alt1.aspmx.l.google.com
mx: alt2.aspmx.l.google.com
max_age: 604800
```

### 3.6 TLS-RPT (TLS Reporting)

Informes sobre problemas de TLS en conexiones SMTP.

```
Tipo: TXT
Nombre: _smtp._tls
Valor: v=TLSRPTv1; rua=mailto:tls-reports@ejemplo.com
```

### 3.7 Verificación Post-Implementación

```bash
# Verificar SPF
dig TXT ejemplo.com +short | grep "v=spf1"

# Verificar DKIM
dig TXT google._domainkey.ejemplo.com +short

# Verificar DMARC
dig TXT _dmarc.ejemplo.com +short

# Verificación completa
nslookup -type=TXT ejemplo.com
nslookup -type=TXT _dmarc.ejemplo.com
```

**Herramientas online de verificación:**
- https://mxtoolbox.com (SPF, DKIM, DMARC, Blacklist)
- https://dmarcian.com/dmarc-inspector/
- https://www.mail-tester.com (enviar correo de prueba)
- https://google.com (abrir correo → "Mostrar original" → verificar autenticación)

---

## 4. Fase 2: Detección — Análisis de Correos Sospechosos

### 4.1 Indicadores de Phishing (IOCs por Categoría)

#### Indicadores del Remitente

| Indicador | Ejemplo | Riesgo |
|-----------|---------|--------|
| Dominio similar (typosquatting) `@g00gle.com`, `@paypa1.com` | Alto |
| Dominio con guiones `@secure-paypal.com` | Alto |
| Subdominio engañoso `@paypal.security-update.com` | Alto |
| Display name ≠ email real | "CEO Nombre" `<hacker@evil.com>` | Crítico |
| Dominio público para "empresa" | `<ceo-empresa@gmail.com>` | Alto |
| Dominio registrado recientemente | WHOIS < 30 días | Medio-Alto |
| Dominio con TLD sospechoso | `.xyz`, `.top`, `.buzz`, `.click` | Medio |

#### Indicadores del Contenido

| Indicador | Ejemplo | Riesgo |
|-----------|---------|--------|
| Urgencia artificial | "Su cuenta será suspendida en 24h" | Alto |
| Amenazas | "Acción legal si no responde" | Alto |
| Solicitud de credenciales | "Verifique su contraseña aquí" | Crítico |
| Solicitud de datos sensibles | "Envíe su número de tarjeta" | Crítico |
| Cambio de datos bancarios | "Nueva cuenta para pagos" | Crítico (BEC) |
| Gramática deficiente | Errores ortográficos, traducción automática | Medio |
| Saludo genérico | "Estimado cliente" en lugar del nombre | Medio |
| Logos pixelados o alterados | Imágenes de baja calidad | Medio |
| Inconsistencias de marca | Colores, tipografía incorrectos | Medio |

#### Indicadores Técnicos

| Indicador | Ejemplo | Riesgo |
|-----------|---------|--------|
| URL acortada | `bit.ly/xxx`, `tinyurl.com/xxx` | Alto |
| HTTP en lugar de HTTPS | `http://login-banco.com` | Alto |
| IP como URL | `http://192.168.1.1/login` | Alto |
| Redirección encadenada | Múltiples redirects | Alto |
| Punycode/IDN homograph | `xn--googl-1sa.com` (gооgle con caracteres Unicode) | Crítico |
| Attachment ejecutable | `.exe`, `.js`, `.vbs`, `.scr`, `.ps1` | Crítico |
| Office con macros | `.docm`, `.xlsm`, `.pptm` | Alto |
| Archivo comprimido con password | `.zip` con contraseña en el cuerpo | Alto |
| Doble extensión | `factura.pdf.exe` | Crítico |
| Archivo ISO/IMG | `.iso`, `.img` (bypass de Mark-of-the-Web) | Alto |

### 4.2 Proceso de Análisis de Correo Sospechoso

```
┌─────────────────────────────────────────────────────────────┐
│              FLUJO DE ANÁLISIS DE CORREO SOSPECHOSO         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. RECEPCIÓN                                                │
│     └─→ ¿Quién reportó? ¿Cómo se detectó?                   │
│                                                             │
│  2. PRESERVACIÓN                                             │
│     └─→ Guardar .eml original, headers completos            │
│     └─→ NO hacer clic en enlaces ni abrir attachments        │
│                                                             │
│  3. ANÁLISIS DE HEADERS                                      │
│     └─→ Verificar SPF/DKIM/DMARC                            │
│     └─→ Rastrear ruta del correo (Received chain)           │
│     └─→ Verificar Return-Path vs From                       │
│     └─→ Revisar X-Originating-IP                            │
│                                                             │
│  4. ANÁLISIS DE CONTENIDO                                    │
│     └─→ Extraer todas las URLs                               │
│     └─→ Verificar dominios (WHOIS, reputación)              │
│     └─→ Analizar tono, urgencia, solicitudes                │
│                                                             │
│  5. ANÁLISIS DE ATTACHMENTS                                  │
│     └─→ Calcular hashes (MD5, SHA256)                       │
│     └─→ Buscar en VirusTotal                                │
│     └─→ Sandboxing (Any.Run) si es sospechoso               │
│                                                             │
│  6. BÚSQUEDA DE IOCs                                        │
│     └─→ Dominios, IPs, hashes en:                           │
│         VirusTotal, AlienVault OTX, AbuseIPDB,              │
│         PhishTank, URLhaus                                  │
│                                                             │
│  7. CLASIFICACIÓN                                            │
│     └─→ Legítimo / SPAM / Phishing / BEC / Malware          │
│                                                             │
│  8. RESPUESTA                                                 │
│     └─→ Contener, bloquear, investigar, remediar            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 4.3 Clasificación de Correos

| Clasificación | Descripción | Acción |
|---------------|-------------|--------|
| **Legítimo** | Correo auténtico, pasa todas las verificaciones | Ninguna |
| **SPAM** | Correo no deseado, no malicioso | Eliminar, marcar como spam |
| **Phishing** | Intento de obtener credenciales o datos | Bloquear, investigar, reportar |
| **Spear-Phishing** | Phishing dirigido a una persona/organización específica | Respuesta prioritaria, investigación profunda |
| **BEC** | Compromiso o suplantación de correo empresarial | Respuesta urgente, verificar transacciones |
| **Malware Delivery** | Correo con payload malicioso | Contener, escanear endpoints, bloquear |
| **Whaling** | Spear-phishing dirigido a ejecutivos (C-level) | Respuesta prioritaria máxima |

---

## 5. Fase 3: Análisis Forense de Headers

### 5.1 Estructura de un Header de Correo

Los headers se leen de **abajo hacia arriba** para rastrear el origen real. El `Received` más inferior es el primero en la cadena.

```
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.222.49])
        by mx.ejemplo.com with ESMTPS id abc123
        for <usuario@ejemplo.com>; Mon, 16 Jun 2024 10:30:00 -0500

Received: from unknown (HELO mail.evil.com) ([198.51.100.42])
        by mail-wr1-f49.google.com with SMTP id xyz789
        for <usuario@ejemplo.com>; Mon, 16 Jun 2024 10:29:58 -0500

From: "CEO Empresa" <ceo@ejemplo.com>
To: <finanzas@ejemplo.com>
Subject: Urgente: Transferencia bancaria
Date: Mon, 16 Jun 2024 10:29:55 -0500
Message-ID: <abc123@mail.evil.com>
Return-Path: <attacker@mail.evil.com>
Reply-To: <attacker@personal-email.com>
MIME-Version: 1.0
Content-Type: text/html; charset="utf-8"
Authentication-Results: mx.ejemplo.com;
       spf=pass (sender IP is 209.85.222.49) smtp.mailfrom=ejemplo.com;
       dkim=pass header.d=ejemplo.com;
       dmarc=pass (p=reject) header.from=ejemplo.com
X-Originating-IP: [198.51.100.42]
```

### 5.2 Campos Críticos para Análisis

| Campo | Qué Verificar | Red Flag |
|-------|---------------|----------|
| `Received` (cadena) | Ruta del correo, IPs intermedias | IPs en listas negras, saltos inusuales |
| `From` | Dirección del remitente | No coincide con display name |
| `Return-Path` | Dirección de rebote | Diferente de `From` |
| `Reply-To` | Dirección de respuesta | Diferente de `From` (táctica común de phishing) |
| `Message-ID` | Identificador único | Dominio no coincide con remitente |
| `X-Originating-IP` | IP del remitente original | IP sospechosa o en listas negras |
| `Authentication-Headers` | Resultados SPF/DKIM/DMARC | Cualquier resultado `fail` |
| `X-Mailer` | Cliente de correo usado | Herramientas de phishing conocidas |
| `Received-SPF` | Resultado de verificación SPF | `fail`, `softfail`, `neutral` |

### 5.3 Análisis de la Cadena Received

La cadena `Received` muestra cada servidor que manejó el correo. Se lee de abajo (origen) hacia arriba (destino).

**Ejemplo de análisis:**

```
# Paso 1 (ORIGEN): El correo salió de 198.51.100.42
Received: from unknown (HELO mail.evil.com) ([198.51.100.42])
        by mail-wr1-f49.google.com with SMTP

# Paso 2: Google lo recibió y lo envió al servidor del destinatario
Received: from mail-wr1-f49.google.com (209.85.222.49)
        by mx.ejemplo.com with ESMTPS

# Paso 3: El servidor del destinatario lo entregó al buzón
Received: from mx.ejemplo.com (10.0.0.5)
        by mail.ejemplo.com with LMTP
```

**Análisis:**
- El correo ORIGINÓ desde `198.51.100.42` (no desde Google)
- Google fue solo un relay intermedio
- El HELO dice `mail.evil.com` — dominio sospechoso
- **Conclusión:** El correo NO fue enviado legítimamente desde Google Workspace

### 5.4 Verificación de Autenticación

**Resultado legíto (todo pasa):**
```
Authentication-Results: mx.ejemplo.com;
       spf=pass smtp.mailfrom=ejemplo.com;
       dkim=pass header.d=ejemplo.com;
       dmarc=pass (p=reject) header.from=ejemplo.com
```

**Resultado sospechoso (falla SPF):**
```
Authentication-Results: mx.ejemplo.com;
       spf=fail (sender IP is 198.51.100.42) smtp.mailfrom=ejemplo.com;
       dkim=none header.d=ejemplo.com;
       dmarc=fail header.from=ejemplo.com
```

**Interpretación:**
- `spf=fail` → El IP 198.51.100.42 NO está autorizado en el SPF de ejemplo.com
- `dkim=none` → No hay firma DKIM (el correo no fue firmado)
- `dmarc=fail` → Falla DMARC porque SPF y DKIM fallan
- **Conclusión:** Correo fraudulento — spoofing confirmado

### 5.5 Herramientas de Análisis de Headers

**Google Admin Toolbox:**
- https://toolbox.googleapps.com/apps/messageheader/
- Pegar headers completos → análisis visual

**MXToolbox Header Analyzer:**
- https://mxtoolbox.com/EmailHeaders.aspx
- Análisis detallado con timestamps y rutas

**Comandos manuales:**
```bash
# Extraer IPs de headers
grep -oP '(\d{1,3}\.){3}\d{1,3}' email_headers.txt | sort -u

# Verificar IP en AbuseIPDB
curl -s "https://api.abuseipdb.com/api/v2/check" \
  -H "Key: YOUR_API_KEY" \
  -H "Accept: application/json" \
  -G --data-urlencode "ipAddress=198.51.100.42"

# Verificar dominio en VirusTotal
curl -s "https://www.virustotal.com/api/v3/domains/ejemplo.com" \
  -H "x-apikey: YOUR_API_KEY"
```

### 5.6 Extracción de IOCs de Headers

```bash
# Extraer todas las URLs
grep -oP 'https?://[^\s<>"{}|\\^`\[\]]+' email_body.txt | sort -u

# Extraer dominios de URLs
grep -oP 'https?://([^/:@\s]+)' email_body.txt | sed 's|https\?://||' | sort -u

# Extraer direcciones de correo
grep -oP '[\w.+-]+@[\w-]+\.[\w.-]+' email_headers.txt | sort -u

# Calcular hash del attachment
md5sum attachment.pdf
sha256sum attachment.pdf
```

---

## 6. Fase 4: Análisis de URLs

### 6.1 Proceso de Análisis de URLs

1. **Extraer la URL completa** del correo (sin hacer clic)
2. **Desengarzar acortadores** (bit.ly, tinyurl, t.co, etc.)
3. **Analizar la estructura** de la URL
4. **Verificar el dominio** (WHOIS, reputación, antigüedad)
5. **Escanear en múltiples plataformas**
6. **Clasificar** como legítima / sospechosa / maliciosa

### 2 Anatomía de una URL de Phishing

```
https://login.ejemplo.com.evil-domain.com/secure/auth?user=admin

├── Protocolo: https (puede ser legítimo, no confiar solo en HTTPS)
├── Subdominio: login.ejemplo.com. (¡engañoso!)
├── Dominio real: evil-domain.com (¡el dominio malicioso!)
├── Ruta: /secure/auth (imitando una página legítima)
└── Parámetros: user=admin (puede contener tokens robados)
```

**Regla clave:** El dominio real es el que está **antes** del TLD (`.com`, `.net`, etc.) y **después** del subdominio. En `login.ejemplo.com.evil-domain.com`, el dominio real es `evil-domain.com`.

### 6.3 Técnicas de Ofuscación de URLs

| Técnica | Ejemplo | Detección |
|---------|---------|-----------|
| Typosquatting | `paypa1.com` (con número 1) | Comparar con dominio legímo carácter por carácter |
| Homoglyph/IDN | `gооgle.com` (caracteres cirílicos) | Verificar con Punycode: `xn--ggle-55da.com` |
| Subdominio engañoso | `paypal.com.evil.com` | El dominio real es `evil.com` |
| URL acortada | `bit.ly/3xYz` | Desengarzar con `curl -I bit.ly/3xYz` |
| @ en URL | `https://legit.com@evil.com` | Todo antes de `@` es ignorado por el navegador |
| Hex encoding | `evil.com/%6C%6F%67%69%6E` | Decodificar: `login` |
| Data URI | `data:text/html,<script>...` | Altamente sospechoso en correos |
| Redirect chain | `evil.com/r1 → evil.com/r2 → final` | Seguir toda la cadena de redirecciones |

### 6.4 Desengarzado de URLs Acortadas

```bash
# Ver destino final sin abrir en navegador
curl -sIL "https://bit.ly/3xYz" 2>&1 | grep -i "location"

# Seguir toda la cadena de redirects
curl -sIL "https://bit.ly/3xYz" 2>&1 | grep -i "location" | tail -1

# Con wget
wget --spider --max-redirect=10 "https://bit.ly/3xYz" 2>&1 | grep "Location"

# Servicio online
# https://unshorten.it/
# https://unshorten.me/
```

### 6.5 Herramientas de Análisis de URLs

| Herramienta | URL | Uso |
|-------------|-----|-----|
| **VirusTotal** | https://virustotal.com/gui/home/url | Escaneo con 70+ motores |
| **URLScan.io** | https://urlscan.io | Captura de pantalla y análisis de comportamiento |
| **PhishTank** | https://phishtank.org | Base de datos de phishing colaborativa |
| **AbuseIPDB** | https://abuseipdb.com | Reputación de IPs |
| **URLhaus** | https://urlhaus.abuse.ch | URLs maliciosas conocidas |
| **CheckPhish** | https://checkphish.ai | Análisis en tiempo real con IA |
| **Unshorten** | https://unshorten.it | Desengarzado de URLs acortadas |
| **WhoisXML API** | https://whoisxmlapi.com | WHOIS de dominios |

### 6.6 Análisis con VirusTotal (API)

```bash
# Escanear URL
curl -s "https://www.virustotal.com/api/v3/urls" \
  -H "x-apikey: YOUR_API_KEY" \
  -F "url=https://suspicious-domain.com/login"

# Obtener reporte de dominio
curl -s "https://www.virustotal.com/api/v3/domains/suspicious-domain.com" \
  -H "x-apikey: YOUR_API_KEY" | python3 -m json.tool

# Obtener reporte de IP
curl -s "https://www.virustotal.com/api/v3/ip_addresses/198.51.100.42" \
  -H "x-apikey: YOUR_API_KEY" | python3 -m json.tool
```

### 6.7 WHOIS de Dominios Sospechosos

```bash
# WHOIS básico
whois suspicious-domain.com

# Información clave a revisar:
# - Creation Date: < 30 días = muy sospechoso
# - Registrar: Algunos registradores son más usados por atacantes
# - Name Servers: NS sospechosos
# - Registrant: Redacted/privacy = común pero revisar contexto

# WHOIS con más detalle
whois suspicious-domain.com | grep -iE "creation|registrar|nameserver|status"
```

### 6.8 Checklist de Análisis de URLs

- [ ] ¿El dominio coincide exactamente con el legítimo?
- [ ] ¿El dominio tiene más de 30 días de antigüedad?
- [ ] ¿El certificado SSL es válido y del dominio correcto?
- [ ] ¿La URL pasa el escaneo de VirusTotal?
- [ ] ¿URLScan.io muestra contenido sospechoso?
- [ ] ¿El dominio está en PhishTank o URLhaus?
- [ ] ¿La IP de destino está en AbuseIPDB?
- [ ] ¿Hay redirecciones sospechosas?
- [ ] ¿La URL usa técnicas de ofuscación?
- [ ] ¿El contenido de la página imita un sitio legítimo?

---

## 7. Fase 5: Análisis de Attachments y Sandboxing

### 7.1 Tipos de Attachments Peligrosos

| Tipo de Archivo | Extensión | Riesgo | Técnica |
|-----------------|-----------|--------|---------|
| Ejecutables | `.exe`, `.msi`, `.scr`, `.com` | Crítico | Ejecución directa de malware |
| Scripts | `.js`, `.vbs`, `.ps1`, `.bat`, `.cmd`, `.wsf` | Crítico | Ejecución de scripts maliciosos |
| Office con macros | `.docm`, `.xlsm`, `.pptm`, `.xlsb` | Alto | Macros VBA para descargar payloads |
| Office con DDE | `.docx`, `.xlsx` (con campos DDE) | Alto | Dynamic Data Execution |
| Archivos comprimidos | `.zip`, `.rar`, `.7z`, `.iso`, `.img` | Alto | Contienen archivos maliciosos, bypass de MOTW |
| PDF | `.pdf` | Medio-Alto | JavaScript embebido, exploits |
| HTML/HTM | `.html`, `.htm`, `.mht` | Alto | Phishing pages, scripts |
| LNK (accesos directos) | `.lnk` | Alto | Ejecución de comandos |
| DLL | `.dll` | Alto | DLL sideloading, ejecución remota |

### 7.2 Proceso de Análisis de Attachments

```
┌─────────────────────────────────────────────────────────────┐
│           FLUJO DE ANÁLISIS DE ATTACHMENTS                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. EXTRACCIÓN SEGURA                                        │
│     └─→ Guardar en entorno aislado (no en producción)       │
│     └─→ NO abrir directamente                               │
│                                                             │
│  2. ANÁLISIS ESTÁTICO                                        │
│     ├─→ Calcular hashes (MD5, SHA1, SHA256)                 │
│     ├─→ Buscar hashes en VirusTotal                         │
│     ├─→ Verificar tipo real del archivo (file, magic bytes) │
│     ├─→ Analizar metadatos (exiftool, pdfinfo)              │
│     └─→ Buscar strings sospechosas (strings, YARA)          │
│                                                             │
│  3. ANÁLISIS DINÁMICO (SANDBOX)                              │
│     ├─→ Any.Run (sandbox interactivo)                       │
│     ├─→ VirusTotal (sandbox integrado)                      │
│     ├─→ Joe Sandbox                                         │
│     └─→ Cuckoo Sandbox (self-hosted)                        │
│                                                             │
│  4. CLASIFICACIÓN                                            │
│     └─→ Limpio / Sospechoso / Malicioso                     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 7.3 Análisis Estático

```bash
# Calcular hashes
md5sum archivo_sospechoso.docm
sha1sum archivo_sospechoso.docm
sha256sum archivo_sospechoso.docm

# Verificar tipo real del archivo (no confiar en la extensión)
file archivo_sospechoso.docm
xxd archivo_sospechoso.docm | head -5

# Buscar strings sospechosos
strings archivo_sospechoso.docm | grep -iE "http|powershell|cmd|shell|download|exec|wscript"

# Analizar metadatos de PDF
pdfinfo archivo_sospechoso.pdf
exiftool archivo_sospechoso.pdf

# Analizar macros de Office (oletools)
pip install oletools
olevba archivo_sospechoso.docm
oleobj archivo_sospechoso.docm
rtfobj archivo_sospechoso.docm

# Buscar con YARA
yara -r /path/to/rules.yar archivo_sospechoso.docm
```

### 7.4 Análisis Dinámico (Sandboxing)

#### Any.Run (Recomendado para BRIDA)

1. Ir a https://any.run
2. Crear cuenta (gratuita con limitaciones)
3. Subir el archivo sospechoso
4. Seleccionar entorno (Windows 10/11, navegador)
5. Ejecutar y observar:
   - Conexiones de red (IPs, dominios contactados)
   - Archivos creados/modificados/eliminados
   - Registro de Windows modificado
   - Procesos creados
   - Capturas de pantalla del comportamiento

#### VirusTotal

1. Ir a https://virustotal.com
2. Subir el archivo (máx. 650 MB con cuenta)
3. Revisar:
   - Detección por antivirus (70+ motores)
   - Sandbox behavior (si disponible)
   - Relaciones (URLs contactadas, archivos dropeados)

#### Joe Sandbox

1. Ir to https://www.joesandbox.com
2. Subir archivo
3. Obtener reporte detallado con:
   - Análisis de red
   - Análisis de sistema de archivos
   - Análisis de memoria
   - Indicadores de compromiso (IOCs)

### 7.5 Análisis de Macros de Office

```bash
# Instalar oletools
pip install oletools

# Extraer macros VBA
olevba archivo.docm

# Extraer macros con análisis de autoexec
olevba --analysis archivo.docm

# Detectar URLs en macros
olevba archivo.docm | grep -iE "http|https|ftp"

# Detectar PowerShell en macros
olevba archivo.docm | grep -iE "powershell|cmd|wscript|shell"

# Extraer objetos OLE
oleobj archivo.docm
```

**Indicadores de macros maliciosas:**
- `AutoOpen`, `AutoClose`, `Document_Open`, `Workbook_Open`
- `Shell`, `WScript.Shell`, `PowerShell`
- `DownloadString`, `DownloadFile`, `Invoke-Expression`
- `CreateObject("WScript.Shell")`
- URLs en strings dentro del código VBA
- Ofuscación excesiva (Chr(), concatenación de strings)

### 7.6 Análisis de PDFs Sospechosos

```bash
# Información básica
pdfinfo archivo.pdf

# Buscar JavaScript embebido
grep -i "javascript" archivo.pdf
grep -i "/JS" archivo.pdf

# Buscar acciones sospechosas
grep -iE "/Launch|/SubmitForm|/ImportData" archivo.pdf

# Analizar con peepdf
pip install peepdf
peepdf -f archivo.pdf

# Extraer URLs del PDF
strings archivo.pdf | grep -iE "http|https"
```

---

## 8. Fase 6: Detección de BEC (Business Email Compromise)

### 8.1 Tipos de BEC

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| **CEO Fraud** | Impersonación del CEO/directivo | "Necesito una transferencia urgente" |
| **Account Compromise** | Cuenta legítima comprometida | Correos desde la cuenta real del CFO |
| **Invoice Fraud** | Facturas falsas de proveedores | "Actualización de datos bancarios" |
| **Attorney Impersonation** | Impersonación de abogados | "Confidencial: caso legal urgente" |
| **Data Theft** | Solicitud de datos de empleados | "Necesito la lista de empleados y salarios" |
| **Email Forwarding Rule** | Regla de reenvío silenciosa | Regla que copia correos a atacante externo |

### 8.2 Indicadores de BEC

#### Indicadores de CEO Fraud / Impersonación

- Correo del CEO solicitando transferencias bancarias urgentes
- Solicitud de confidencialidad ("no le digas a nadie")
- Presión por tiempo ("necesito esto en la próxima hora")
- El correo llega en horarios inusuales (madrugada, fin de semana)
- Display name correcto pero dominio diferente
- Respuesta a un hilo de correo existente (thread hijacking)

#### Indicadores de Account Compromise

- Cambio repentino en el estilo de escritura
- Solicitudes que normalmente no se hacen por correo
- Correos enviados a contactos que normalmente no se incluyen
- Reglas de correo nuevas y sospechosas (reenvío automático)
- Actividad de inicio de sesión desde ubicaciones inusuales
- Cambio de contraseña sin notificación

#### Indicadores de Invoice Fraud

- Proveedor conocido solicita cambio de cuenta bancaria
- Factura con monto inusualmente alto
- Presión para pagar rápidamente
- Datos bancarios en un país diferente al habitual
- Factura sin orden de compra asociada

### 8.3 Detección Técnica de BEC

```bash
# Verificar reglas de correo sospechosas en Google Workspace
# Admin Console → Apps → Google Workspace → Gmail → Routing

# Buscar reglas de reenvío a dominios externos
# (Requiere Google Workspace Admin API o revisar manualmente)

# Verificar actividad de login sospechosa
# Admin Console → Reports → Audit → Login

# Buscar correos con display name de ejecutivos
# Usar Google Vault o DLP rules
```

### 8.4 Reglas de Detección en Google Workspace

Configurar en **Admin Console → Apps → Google Workspace → Gmail → Compliance**:

**Regla 1: Display name de ejecutivos con dominio externo**
```
IF: Header "From" contains "CEO Name" AND sender domain != "empresa.com"
THEN: Quarantine / Alert
```

**Regla 2: Palabras clave de BEC**
```
IF: Subject or body contains ("transferencia urgente", "cambio de cuenta", 
    "datos bancarios", "confidencial", "wire payment", "urgent payment")
AND sender domain != "empresa.com"
THEN: Add warning banner
```

**Regla 3: Dominios similares (lookalike)**
```
IF: Sender domain matches "empresa-corp.com", "empresa-corp.com", "empresa.co"
THEN: Quarantine
```

### 8.5 Verificación de BEC — Protocolo de Confirmación

Cuando se detecta un posible BEC:

1. **NO responder al correo sospechoso**
2. **Verificar por canal alternativo:**
   - Llamar al remitente por teléfono (número conocido, no el del correo)
   - Mensajería interna (Slack, Teams)
   - Verificación presencial
3. **Verificar la solicitud:**
   - ¿Es normal este tipo de solicitud?
   - ¿El remitente suele hacer este tipo de pedidos?
   - ¿Los datos bancarios coinciden con los registrados?
4. **Documentar** la verificación
5. **Reportar** si se confirma como BEC

---

## 9. Fase 7: Respuesta a Incidentes de Phishing

### 9.1 Clasificación de Severidad

| Nivel | Nombre | Descripción | Tiempo de Respuesta | Ejemplo |
|-------|--------|-------------|-------------------|---------|
| **P1** | **Crítico** | Compromiso activo de credenciales o sistemas. BEC confirmado con transferencia en curso. | ≤ 15 minutos | Credenciales de admin comprometidas, transferencia BEC en proceso, malware ejecutándose |
| **P2** | **Alto** | Phishing con clics confirmados o credenciales posiblemente comprometidas. | ≤ 30 minutos | Usuario hizo clic e ingresó credenciales, attachment malicioso abierto |
| **P3** | **Medio** | Phishing detectado, sin confirmación de compromiso. | ≤ 2 horas | Correo de phishing recibido pero sin clics confirmados |
| **P4** | **Bajo** | Intento de phishing bloqueado por filtros. | ≤ 24 horas | Phishing bloqueado por Google Workspace, SPAM |

### 9.2 Playbook de Respuesta a Phishing

#### Paso 1: Contención Inmediata (0-15 minutos)

```bash
# 1a. Purgar el correo de todos los buzones (Google Workspace)
# Admin Console → Apps → Google Workspace → Gmail → Search and delete
# O usar Google Vault para búsqueda y purga masiva

# 1b. Bloquear remitente y dominio
# Admin Console → Apps → Google Workspace → Gmail → Blocked senders

# 1c. Bloquear URLs en proxy/firewall
# Agregar dominios/URLs a lista negra en FortiGate

# 1d. Bloquear IOCs en EDR
# CrowdStrike: Add IOCs to Custom IOCs
# Trellix: Add to Detection Rules
```

#### Paso 2: Investigación (15-60 minutos)

```bash
# 2a. Identificar quién recibió el correo
# Google Vault → Search → criterios: remitente, fecha, asunto

# 2b. Identificar quién hizo clic en enlaces
# Revisar logs de proxy/firewall para accesos a URLs maliciosas
# Revisar logs de Cloudflare Gateway

```bash
# 2c. Identificar quién abrió attachments
# Revisar logs de EDR (CrowdStrike/Trellix) para ejecución de archivos

# 2d. Recopilar IOCs
# Hashes de archivos, URLs, IPs, dominios del correo

# 2e. Preservar evidencia
# Guardar .eml original, capturas de pantalla, logs relevantes
```

#### Paso 3: Erradicación (1-4 horas)

```
3a. Resetear contraseñas de cuentas comprometidas
3b. Revocar tokens de sesión activos
3c. Eliminar reglas de correo maliciosas (reenvío, filtros)
3d. Remover attachments maliciosos de endpoints (via EDR)
3e. Bloquear IOCs en todas las capas:
    - Email gateway (remitente, dominio)
    - Firewall/proxy (IPs, dominios, URLs)
    - EDR (hashes, IPs, dominios)
    - DNS filtering (dominios)
```

#### Paso 4: Recuperación (4-24 horas)

```
4a. Verificar que no hay persistencia del atacante
4b. Monitorear cuentas comprometidas por actividad anómala
4c. Restaurar archivos afectados desde backup (si aplica)
4d. Verificar integridad de sistemas comprometidos
4e. Confirmar que el bloqueo de IOCs funciona correctamente
```

#### Paso 5: Comunicación

- **Interna:** Notificar al equipo de seguridad, IT, y gestión
- **Usuarios afectados:** Informar sin causar pánico, instrucciones claras
- **Dirección/Ejecutivos:** Resumen ejecutivo del incidente
- **Externa:** Solo si es requerido (reguladores, clientes afectados, autoridades)

#### Paso 6: Documentación Post-Incidente

```
6a. Timeline del incidente (detección → contención → erradicación → recuperación)
6b. IOCs identificados
6c. Impacto: ¿Cuántos usuarios afectados? ¿Se comprometieron credenciales?
6d. Lecciones aprendidas
6e. Mejoras recomendadas
6f. Actualización de reglas de detección
```

---

## 10. Fase 8: Simulación de Phishing con GoPhish

### 10.1 ¿Qué es GoPhish?

GoPhish es una plataforma open source para simulación de phishing que permite crear y ejecutar campañas de phishing controladas para medir la resistencia de los usuarios y entrenarlos.

**Repositorio:** https://github.com/gophish/gophish
**Documentación:** https://docs.getgophish.com/

### 10.2 Instalación de GoPhish

#### Opción A: Binario pre-compilado (Recomendado)

```bash
# Descargar la última versión
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip

# Descomprimir
unzip gophish-v0.12.1-linux-64bit.zip
cd gophish-v0.12.1-linux-64bit

# Configurar
chmod +x gophish
```

#### Opción B: Docker

```bash
docker pull gophish/gophish

docker run -d \
  --name gophish \
  -p 3333:3333 \
  -p 8080:80 \
  gophish/gophish
```

#### Opción C: Desde fuente

```bash
go install github.com/gophish/gophish@latest
```

### 10.3 Configuración Inicial

**Archivo `config.json`:**
```json
{
  "admin_server": {
    "listen_url": "0.0.0.0:3333",
    "use_tls": true,
    "cert_path": "gophish_admin.crt",
    "key_path": "gophish_admin.key"
  },
  "phish_server": {
    "listen_url": "0.0.0.0:8080",
    "use_tls": false,
    "cert_path": "example.com.crt",
    "key_path": "example.com.key"
  },
  "db_name": "sqlite3",
  "db_path": "gophish.db",
  "migrations_prefix": "db/db_",
  "contact_address": ""
}
```

```bash
# Generar certificado autofirmado para el panel de admin
openssl req -x509 -newkey rsa:4096 -keyout gophish_admin.key \
  -out gophish_admin.crt -days 365 -nodes \
  -subj "/CN=gophish-admin"

# Iniciar GoPhish
./gophish

# Acceder al panel de admin
# https://<IP>:3333
# Usuario: admin (la contraseña aparece en la consola al iniciar)
```

### 10.4 Configuración de DNS y Dominio

```bash
# 1. Configurar registro A apuntando al servidor GoPhish
# En Cloudflare:
Tipo: A
Nombre: secure-login
Valor: <IP del servidor GoPhish>
TTL: Auto

# 2. Configurar certificado SSL para el dominio de phishing
# 3. Configurar SPF para permitir que GoPhish envíe correos
v=spf1 include:_spf.google.com ip4:<IP_GO_PHISH> ~all
```

### 10.5 Componentes de una Campaña GoPhish

| Componente | Descripción | Ejemplo |
|------------|-------------|---------|
| **User Groups** | Grupos de destinatarios (importar CSV) | `nombre,email,puesto` |
| **Email Templates** | Plantillas de correo de phishing | HTML con variables `{{.FirstName}}` |
| **Landing Pages** | Páginas de destino falsas | Clon de login de Google |
| **Sending Profiles** | Perfil del servidor SMTP que envía | Configuración SMTP de prueba |
| **Campaigns** | La campaña que combina todo | Selecciona template + landing + grupo |
| **Results** | Métricas y resultados | Emails enviados, clics, datos enviados |

### 10.6 Crear una Campaña Paso a Paso

#### Paso 1: User Groups (Grupos de Usuarios)

```csv
email,first_name,last_name,position
usuario1@empresa.com,Juan,Pérez,Contabilidad
usuario2@empresa.com,María,Gómez,RRHH
usuario3@empresa.com,Carlos,López,IT
```

Ir a **Users & Groups → Groups → New Group** → Importar CSV

#### Paso 2: Email Template (Plantilla de Correo)

```html
<html>
<body>
<p>Estimado {{.FirstName}},</p>

<p>Hemos detectado actividad inusual en su cuenta de Google Workspace.
Por su seguridad, es necesario que actualice su contraseña inmediatamente
para evitar la suspensión de su cuenta.</p>

<p><a href="{{.URL}}">Actualizar contraseña ahora</a></p>

<p>Si no realiza esta acción en las próximas 24 horas, su cuenta será suspendida.</p>

<p>Atentamente,<br>Equipo de Seguridad de Empresa</p>

<p style="display:none">{{.Tracker}}</p>
</body>
</html>
```

**Variables disponibles:**
- `{{.Email}}`, `{{.FirstName}}`, `{{.LastName}}`, `{{.Position}}`
- `{{.URL}}` — URL de phishing
- `{{.Tracker}}` — Pixel de seguimiento

#### Paso 3: Landing Page (Página de Destino)

Ir a **Landing Pages → New Landing Page**

- Marcar **"Capture submitted data"** para capturar credenciales
- Marcar **"Capture passwords"** para capturar contraseñas
- Configurar **Redirect to** para redirigir a página de entrenamiento

#### Paso 4: Sending Profile (Perfil de Envío)

```yaml
Name: BRIDA Test SMTP
From: "Google Workspace Security" <security@empresa-test.com>
Host: smtp.gmail.com:587
Username: test-sender@empresa.com
Password: [App Password]
```

#### Paso 5: Lanzar la Campaña

Ir a **Campaigns → New Campaign** y seleccionar template, landing page, sending profile y user group.

### 10.7 Escenarios de Simulación Recomendados

| Escenario | Dificultad | Descripción |
|-----------|------------|-------------|
| **Actualización de contraseña** | Fácil | Correo urgente pidiendo actualizar contraseña |
| **Factura pendiente** | Medio | Factura falsa con attachment o enlace |
| **Paquete en aduanas** | Fácil | Notificación de envío de paquetería |
| **Compartir documento** | Medio | "Alguien compartió un documento contigo" |
| **Solicitud del CEO** | Difícil | BEC simulado: solicitud urgente del CEO |
| **Notificación de RRHH** | Difícil | Cambio de política, actualización de datos |

### 10.8 Métricas Clave (KPIs)

| Métrica | Fórmula | Objetivo |
|---------|---------|----------|
| **Click Rate** | (Clics / Enviados) × 100 | < 5% aceptable, < 2% excelente |
| **Submission Rate** | (Datos enviados / Enviados) × 100 | < 2% aceptable |
| **Report Rate** | (Reportados / Enviados) × 100 | > 70% excelente |
| **Time to First Click** | Tiempo hasta el primer clic | Menor = más urgente el escenario |
| **Time to Report** | Tiempo hasta el primer reporte | < 15 min excelente |

### 10.9 Consideraciones Éticas y Legales

- **Obtener autorización escrita** de la dirección antes de cualquier simulación
- **Comunicar al equipo de IT/SOC** para que no confundan la simulación con un ataque real
- **No usar datos reales** capturados para otro propósito que no sea entrenamiento
- **No simular escenarios traumáticos** (despidos, emergencias médicas)
- **Proporcionar entrenamiento inmediato** a quienes caigan en la simulación
- **Respetar la privacidad** de los resultados individuales
- **Documentar todo** el proceso y los resultados

---

## 11. Fase 9: Programa de Concientización

### 11.1 Estructura del Programa

| Componente | Frecuencia | Duración | Audiencia |
|------------|------------|----------|-----------|
| **Simulación de phishing** | Mensual/Trimestral | 15-30 min | Todos los empleados |
| **Entrenamiento en línea** | Trimestral | 30-60 min | Todos los empleados |
| **Sesiones en vivo** | Semestral | 60 min | Todos los empleados |
| **Entrenamiento dirigido** | Inmediato tras caer | 15-30 min | Usuarios que fallaron |
| **Boletín de seguridad** | Mensual | 5 min lectura | Todos los empleados |
| **Capacitación de ejecutivos** | Trimestral | 60 min | C-level, directivos |
| **Onboarding de seguridad** | Al ingreso | 60 min | Nuevos empleados |

### 11.2 Contenido de Entrenamiento

**Módulo 1: Fundamentos de Phishing (Todos)**
- ¿Qué es el phishing y por qué importa?
- Tipos de phishing (mass, spear, whaling, BEC, vishing, smishing)
- Cómo identificar correos sospechosos (práctica con ejemplos reales)
- Qué hacer ante un correo sospechoso (reportar, no hacer clic)
- El botón "Report Phish" en Google Workspace

**Módulo 2: Amenazas Avanzadas (IT, Finanzas, RRHH)**
- Spear-phishing dirigido, BEC, vishing, smishing
- Verificación de solicitudes sensibles

**Módulo 3: Protección de Cuentas (Todos)**
- Contraseñas fuertes y únicas, MFA, password manager
- Reconocer páginas de login falsas, verificar URLs

**Módulo 4: Respuesta a Incidentes (Todos)**
- Cómo reportar un correo sospechoso
- Qué hacer si hizo clic o ingresó credenciales en página falsa
- Contactos de seguridad

### 11.3 Botón "Report Phish" en Google Workspace

1. Ir a **Admin Console → Apps → Google Workspace → Gmail → Advanced settings**
2. Habilitar **"Report phishing"** button
3. Configurar que los correos reportados se envíen a `phishing-reports@empresa.com`

### 11.4 Métricas del Programa

| KPI | Meta | Medición |
|-----|------|----------|
| Tasa de clic en simulaciones | < 5% (decreciente) | GoPhish |
| Tasa de reporte | > 70% (creciente) | Sistema de reporte |
| Tiempo promedio de reporte | < 15 minutos | Sistema de reporte |
| Finalización de entrenamiento | > 95% | LMS |
| Incidentes de phishing reales | Decreciente | SOC/IR |

---

## 12. Plantillas de Reporte

### 12.1 Plantilla: Reporte de Análisis de Correo Sospechoso

```markdown
# REPORTE DE ANÁLISIS DE CORREO SOSPECHOSO

## Información General
- **ID del Caso:** PH-2024-001
- **Fecha de Recepción:** [DD/MM/AAAA HH:MM]
- **Fecha de Análisis:** [DD/MM/AAAA HH:MM]
- **Analista:** [Nombre]
- **Severidad:** [P1/P2/P3/P4]
- **Estado:** [Abierto / En Progreso / Cerrado]

## Resumen Ejecutivo
[Descripción breve del incidente en 2-3 oraciones]

## Detalles del Correo
- **De (Display Name):** [Nombre mostrado]
- **De (Email):** [dirección@dominio.com]
- **Para:** [destinatario@empresa.com]
- **Asunto:** [Asunto del correo]
- **Fecha/Hora:** [Timestamp]
- **Message-ID:** [ID del mensaje]

## Resultados de Autenticación
| Método | Resultado | Detalles |
|--------|-----------|----------|
| SPF | [pass/fail/neutral] | [Detalles] |
| DKIM | [pass/fail/none] | [Detalles] |
| DMARC | [pass/fail] | [Detalles] |

## Análisis de Headers
- **IP de Origen:** [IP]
- **Ruta del Correo:** [Servidor1 → Servidor2 → Destinatario]
- **Return-Path:** [email]
- **Reply-To:** [email] (si diferente de From)

## Análisis de URLs
| URL | Dominio Real | Antigüedad | VirusTotal | Clasificación |
|-----|-------------|------------|------------|---------------|
| [URL1] | [dominio] | [días] | [X/70] | [Limpia/Sospechosa/Maliciosa] |

## Análisis de Attachments
| Archivo | Tipo Real | MD5 | SHA256 | VirusTotal | Clasificación |
|---------|-----------|-----|--------|------------|---------------|
| [archivo] | [tipo] | [hash] | [hash] | [X/70] | [Limpio/Sospechoso/Malicioso] |

## IOCs Identificados
- **Dominios:** [lista]
- **IPs:** [lista]
- **URLs:** [lista]
- **Hashes (MD5):** [lista]
- **Hashes (SHA256):** [lista]

## Clasificación Final
- [ ] Legítimo / [ ] SPAM / [ ] Phishing / [ ] Spear-Phishing / [ ] BEC / [ ] Malware Delivery / [ ] Whaling

## Acciones Tomadas
1. [Acción 1]
2. [Acción 2]

## Mapeo a Marcos de Referencia
- **MITRE ATT&CK:** [Técnica ID] — [Descripción]
- **NIST CSF:** [Función] — [Categoría]
- **D3FEND:** [Contramedida ID] — [Descripción]
```

### 12.2 Plantilla: Reporte de Incidente de Phishing

```markdown
# REPORTE DE INCIDENTE DE PHISHING

## Información del Incidente
- **ID:** IR-PH-2024-001
- **Fecha/Hora de Detección:** [DD/MM/AAAA HH:MM]
- **Fecha/Hora de Contención:** [DD/MM/AAAA HH:MM]
- **Fecha/Hora de Cierre:** [DD/MM/AAAA HH:MM]
- **Severidad:** [P1/P2/P3/P4]
- **Estado:** [Abierto/Contenido/Erradicado/Cerrado]
- **Analista Líder:** [Nombre]

## Resumen Ejecutivo
[2-3 oraciones describiendo el incidente, impacto y resolución]

## Timeline del Incidente
| Hora | Evento | Acción |
|------|--------|--------|
| [HH:MM] | Detección del correo | [Quién detectó] |
| [HH:MM] | Análisis inicial | [Resultado] |
| [HH:MM] | Contención | [Acciones] |
| [HH:MM] | Erradicación | [Acciones] |
| [HH:MM] | Recuperación | [Acciones] |
| [HH:MM] | Cierre | [Confirmación] |

## Impacto
- **Usuarios que recibieron el correo:** [Número]
- **Usuarios que hicieron clic:** [Número]
- **Usuarios que ingresaron credenciales:** [Número]
- **Sistemas comprometidos:** [Lista o "Ninguno"]
- **Datos comprometidos:** [Descripción o "Ninguno"]
- **Impacto financiero:** [Monto o "Ninguno"]

## Lecciones Aprendidas
1. [Lección 1]
2. [Lección 2]

## Mejoras Recomendadas
1. [Mejora 1 — Responsable — Fecha]
2. [Mejora 2 — Responsable — Fecha]
```

### 12.3 Plantilla: Reporte de Simulación de Phishing

```markdown
# REPORTE DE SIMULACIÓN DE PHISHING

## Información de la Campaña
- **Campaña:** [Nombre]
- **Fecha:** [DD/MM/AAAA]
- **Escenario:** [Descripción]
- **Plataforma:** GoPhish

## Métricas Generales
| Métrica | Resultado | Meta | Estado |
|---------|-----------|------|--------|
| Correos enviados | [N] | — | — |
| Tasa de clic | [N] ([%]) | < 5% | [✅/❌] |
| Tasa de envío de datos | [N] ([%]) | < 2% | [✅/❌] |
| Tasa de reporte | [N] ([%]) | > 70% | [✅/❌] |
| Tiempo al primer reporte | [min] | < 15 min | [✅/❌] |

## Resultados por Departamento
| Departamento | Enviados | Clics | Datos Enviados | Reportes | Tasa de Clic |
|--------------|----------|-------|----------------|----------|--------------|
| [Depto] | [N] | [N] | [N] | [N] | [%] |

## Usuarios que Requieren Entrenamiento Adicional
| Usuario | Email | Acción Tomada |
|---------|-------|---------------|
| [Nombre] | [email] | [Entrenamiento enviado/completado] |
```

### 12.4 Plantilla: Reporte de Implementación SPF/DKIM/DMARC

```markdown
# REPORTE DE IMPLEMENTACIÓN SPF/DKIM/DMARC

## Información del Cliente
- **Cliente:** [Nombre]
- **Dominio(s):** [dominio.com]
- **Fecha de Implementación:** [DD/MM/AAAA]

## Estado de Implementación

### SPF
- [ ] Registro SPF creado en Cloudflare
- [ ] Hardfail (-all) implementado
- **Registro:** `v=spf1 include:_spf.google.com -all`

### DKIM
- [ ] Clave DKIM generada en Google Workspace
- [ ] Registro DKIM publicado en Cloudflare
- [ ] Firma DKIM activada

### DMARC
- [ ] Fase 1 (p=none) completada
- [ ] Fase 2 (p=quarantine) completada
- [ ] Fase 3 (p=reject) implementada

## Verificación Final
dig TXT dominio.com +short
dig TXT google._domainkey.dominio.com +short
dig TXT _dmarc.dominio.com +short
```

---

## 13. Matrices de Mapeo

### 13.1 MITRE ATT&CK — Técnicas de Phishing

| Técnica ID | Técnica | Táctica | Contramedida BRIDA |
|------------|---------|---------|-------------------|
| **T1566.001** | Spearphishing Attachment | Initial Access | Sandboxing, EDR, entrenamiento |
| **T1566.002** | Spearphishing Link | Initial Access | URL filtering, proxy, entrenamiento |
| **T1566.003** | Spearphishing via Service | Initial Access | MFA, verificación de identidad |
| **T1598.001** | Phishing for Info: Attachment | Reconnaissance | Sandboxing, DLP |
| **T1598.002** | Phishing for Info: Link | Reconnaissance | URL filtering, entrenamiento |
| **T1598.003** | Phishing for Info: Service | Reconnaissance | MFA, verificación |
| **T1204.001** | User Execution: Malicious Link | Execution | Entrenamiento, URL filtering |
| **T1204.002** | User Execution: Malicious File | Execution | Sandboxing, EDR, entrenamiento |
| **T1114.002** | Email Collection: Remote | Collection | MFA, monitoreo de login |
| **T1114.003** | Email Collection: Forwarding Rule | Collection | Monitoreo de reglas, alertas |
| **T1056.003** | Input Capture: Web Portal | Collection | MFA, entrenamiento, DMARC |
| **T1583.001** | Acquire Infrastructure: Domains | Resource Development | Monitoreo de dominios lookalike |
| **T1585.001** | Establish Accounts: Social Media | Resource Development | Monitoreo de marca |

### 13.2 NIST CSF — Mapeo de Funciones

| Función | Categoría | Aplicación en Phishing |
|---------|-----------|----------------------|
| **IDENTIFY** | ID.RA-01 | Evaluar riesgo de phishing |
| **PROTECT** | PR.AT-01 | Entrenar usuarios para reconocer phishing |
| **PROTECT** | PR.DS-02 | Proteger correo en tránsito (TLS, DKIM) |
| **DETECT** | DE.CM-01 | Monitorear tráfico para IOCs de phishing |
| **DETECT** | DE.AE-02 | Analizar eventos sospechosos |
| **RESPOND** | RS.MA-01 | Ejecutar plan de respuesta a phishing |
| **RESPOND** | RS.AN-03 | Analizar el incidente |
| **RECOVER** | RC.RP-01 | Ejecutar plan de recuperación |

### 13.3 D3FEND — Contramedidas

| ID | Contramedida | Implementación BRIDA |
|----|-------------|---------------------|
| **D3-DNSA** | DNS Analysis | Cloudflare Gateway, DNS filtering |
| **D3-ER** | Email Filtering | Google Workspace spam filter |
| **D3-ET** | Email Content Filtering | Google Workspace DLP rules |
| **D3-EF** | Email Header Analysis | SPF/DKIM/DMARC verification |
| **D3-URA** | URL Analysis | VirusTotal, URLScan.io, proxy |
| **D3-SS** | System Call Analysis | Any.Run, CrowdStrike |
| **D3-SEA** | Sender MTA Reputation | Google Workspace, SPF checking |
| **D3-SPP** | SMTP Presentation Protocol | MTA-STS, TLS-RPT |
| **D3-PA** | Platform Monitoring | Google Workspace audit logs |
| **D3-UBA** | User Behavior Analysis | Google Workspace alerts |
| **D3-NTA** | Network Traffic Analysis | FortiGate, Cloudflare Gateway |
| **D3-IS** | Isolation | EDR network containment |

---

## 14. Herramientas y Comandos de Referencia

### 14.1 Comandos DNS

```bash
# Verificar SPF
dig TXT dominio.com +short | grep "v=spf1"

# Verificar DKIM
dig TXT google._domainkey.dominio.com +short

# Verificar DMARC
dig TXT _dmarc.dominio.com +short

# Verificar MX
dig MX dominio.com +short

# Verificación completa
dig ANY dominio.com +short
```

### 14.2 Comandos de Análisis de Correo

```bash
# Extraer headers relevantes
grep -E "^(From|To|Subject|Date|Message-ID|Return-Path|Reply-To|Received|Authentication-Results):" correo.eml

# Extraer URLs
grep -oP 'https?://[^\s<>"{}|\\^`\[\]]+' correo.eml | sort -u

# Extraer IPs
grep -oP '(\d{1,3}\.){3}\d{1,3}' correo.eml | sort -u

# Hash de attachment
md5sum archivo.pdf
sha256sum archivo.pdf

# Tipo real de archivo
file archivo.pdf

# Strings sospechosos
strings archivo.docm | grep -iE "http|powershell|cmd|shell|download|exec"
```

### 14.3 Comandos de Análisis de URLs

```bash
# Desengarzar URL acortada
curl -sIL "https://bit.ly/3xYz" 2>&1 | grep -i "location"

# Verificar certificado SSL
openssl s_client -connect dominio.com:443 -servername dominio.com < /dev/null 2>/dev/null | openssl x509 -noout -dates -subject

# WHOIS
whois dominio.com | grep -iE "creation|registrar|nameserver"

# Verificar lista negra
dig +short dominio.com.zen.spamhaus.org
```

### 14.4 Comandos de Análisis de Attachments

```bash
# Instalar oletools
pip install oletools

# Extraer macros VBA
olevba archivo.docm

# Analizar PDF
pdfinfo archivo.pdf
strings archivo.pdf | grep -iE "javascript|/JS|/Launch"

# Análisis con YARA
yara -r /path/to/phishing_rules.yar archivo_sospechoso.docm
```

### 14.5 API Queries

```bash
# VirusTotal — Escanear URL
curl -s -X POST "https://www.virustotal.com/api/v3/urls" \
  -H "x-apikey: VT_API_KEY" \
  -F "url=https://suspicious.com/login"

# AbuseIPDB — Verificar IP
curl -s "https://api.abuseipdb.com/api/v2/check" \
  -H "Key: ABUSEIPDB_API_KEY" \
  -H "Accept: application/json" \
  -G --data-urlencode "ipAddress=198.51.100.42" \
  --data-urlencode "maxAgeInDays=90"
```

---

## 15. Notas Específicas para Clientes BRIDA

### 15.1 Grupo Pepe — Estado Actual y Prioridades

- **🔴 CRÍTICO:** Actualmente SIN SPF/DKIM/DMARC (máxima prioridad)
- **Riesgo BEC:** Alto — sin DMARC, cualquiera puede enviar correos falsos como el CEO
- **Recomendación:** Implementar SPF/DKIM/DMARC en Semana 1 del plan de seguridad

**Dominios a proteger:**
| Dominio | Estado | Prioridad |
|---------|--------|-----------|
| pollopepe.com | Sin autenticación | 🔴 Crítica |
| pipinospizza.com | Sin autenticación | 🔴 Crítica |
| elpollobronco.com | Sin autenticación | 🔴 Crítica |
| barbacos.com | Sin autenticación | 🔴 Crítica |

**Dominios inactivos:** Configurar con `v=spf1 -all` para evitar abuso.

### 15.2 Plan de Implementación Recomendado

**Semana 1: Auditoría y SPF**
1. Auditar registros DNS actuales de cada dominio
2. Crear registros SPF con `~all` (softfail)
3. Verificar con MXToolbox

**Semana 2: DKIM**
1. Generar claves DKIM en Google Workspace
2. Publicar registros en Cloudflare
3. Activar firma DKIM

**Semana 3-4: DMARC Fase 1 (Monitoreo)**
1. Crear registro DMARC con `p=none`
2. Configurar dirección de correo para recibir informes
3. Monitorear informes diariamente

**Semana 5-6: DMARC Fase 2 (Cuarentena)**
1. Cambiar a `p=quarantine`
2. Monitorear impacto
3. Ajustar SPF/DKIM si es necesario

**Semana 7-8: DMARC Fase 3 (Rechazo)**
1. Cambiar a `p=reject`
2. Verificar que todo el tráfico legítimo pasa
3. Configurar MTA-STS y TLS-RPT

**Mes 3: Primera Simulación de Phishing**
1. Instalar GoPhish
2. Diseñar primera campaña
3. Ejecutar y medir resultados
4. Entrenar usuarios que fallaron

### 15.3 Configuraciones Específicas para Google Workspace

**Protecciones avanzadas (Admin Console → Security → Gmail):**
- Habilitar "Inbound email authentication" (SPF/DKIM check)
- Habilitar "DMARC authentication"
- Habilitar "Spoofing and authentication protection"
- Configurar acciones para correos que fallan autenticación

**DLP Rules para BEC:**
- Crear regla para detectar display names de ejecutivos con dominio externo
- Crear regla para palabras clave de BEC

**Alertas de seguridad:**
- Configurar alertas para actividad sospechosa de login
- Configurar alertas para reglas de correo nuevas

### 15.4 Checklist de Verificación Post-Implementación

- [ ] SPF configurado y verificado con MXToolbox (Pass)
- [ ] DKIM configurado y verificado con MXToolbox (Pass)
- [ ] DMARC en `p=reject` y verificado con MXToolbox (Pass)
- [ ] MTA-STS configurado
- [ ] TLS-RPT configurado
- [ ] Informes DMARC llegan correctamente
- [ ] Google Workspace spam filter configurado
- [ ] DLP rules para BEC configuradas
- [ ] Botón "Report Phish" habilitado
- [ ] GoPhish instalado y configurado
- [ ] Primera simulación de phishing programada
- [ ] Programa de concientización documentado
- [ ] Proceso de respuesta a phishing documentado
- [ ] Plantillas de reporte disponibles
- [ ] Equipo entrenado en análisis de correos sospechosos

---

*Última actualización: Junio 2024*
*Versión: 2.0.0*
*BRIDA IT Services — Cybersecurity Division*