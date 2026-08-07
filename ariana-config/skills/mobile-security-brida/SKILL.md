---
name: mobile-security-brida
description: 'Mobile security assessment and management for BRIDA IT Services clients.
  Covers mobile app penetration testing (OWASP MASTG), Android/iOS security analysis,
  MDM/EMM deployment, mobile threat defense, and mobile device forensics. Activates
  for: mobile security, mobile pentest, Android security, iOS security, MDM, mobile
  app security, OWASP MASTG.'
domain: cybersecurity
subdomain: mobile-security
tags:
- mobile-security
- mobile-pentest
- Android
- iOS
- MDM
- mobile-app-security
- OWASP-MASTG
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- PR.PT-03
- PR.AC-03
- DE.CM-01
- ID.AM-01
mitre_attack:
- T1426
- T1409
- T1521
- T1633
category: cybersecurity
---

# Mobile Security — BRIDA IT Services

## Descripción
Evaluación de seguridad móvil y gestión para clientes de BRIDA IT Services. Cubre penetration testing de apps móviles (OWASP MASTG), análisis de seguridad Android/iOS, despliegue MDM/EMM, defensa contra amenazas móviles y forenses de dispositivos móviles.

## Cuándo Usar
- Evaluación de seguridad de apps móviles corporativas
- Despliegue de MDM/EMM para gestión de dispositivos
- Evaluación de seguridad de dispositivos BYOD
- Pruebas de seguridad en apps de clientes (ej: app de pedidos)
- Respuesta a incidentes en dispositivos móviles

## OWASP Mobile Top 10 (2024)

### M1: Improper Credential Usage
- Hardcoded credentials in apps
- Weak token management
- Insecure credential storage

### M2: Inadequate Supply Chain Security
- Third-party library vulnerabilities
- Insecure CI/CD pipelines
- Unsigned code

### M3: Insecure Authentication/Authorization
- Weak authentication mechanisms
- Biometric bypass
- Token theft

### M4: Insufficient Input/Output Validation
- Injection attacks
- XSS in WebViews
- Path traversal

### M5: Insecure Communication
- Cleartext traffic
- Certificate validation bypass
- Man-in-the-middle

### M6: Inadequate Privacy Controls
- Excessive data collection
- PII leakage
- Missing privacy policy

### M7: Insufficient Binary Protections
- No code obfuscation
- Debugging enabled
- Reverse engineering

### M8: Security Misconfiguration
- Debug mode in production
- Verbose error messages
- Default configurations

### M9: Insecure Data Storage
- Unencrypted sensitive data
- SQLite database exposure
- Shared preferences leakage

### M10: Insufficient Cryptography
- Weak algorithms (MD5, SHA1, DES)
- Hardcoded keys
- Improper key management

## Mobile App Pentesting Workflow

### Fase 1: Static Analysis (SAST)
```bash
# Android APK analysis
apktool d app.apk -o app_decompiled
# Search for hardcoded secrets
grep -r "password\|secret\|api_key\|token" app_decompiled/
# Check AndroidManifest.xml for permissions
cat app_decompiled/AndroidManifest.xml

# iOS IPA analysis
unzip app.ipa -d app_decompiled
# Check Info.plist
cat app_decompiled/Payload/*.app/Info.plist | grep -i "url\|transport"
# Search for hardcoded secrets
grep -r "password\|secret\|api_key" app_decompiled/
```

### Fase 2: Dynamic Analysis (DAST)
```bash
# Configurar proxy (Burp Suite) en dispositivo móvil
# Instalar certificado CA de Burp en el dispositivo

# Android con Frida (instrumentación dinámica)
frida -U -f com.target.app -l ssl-bypass.js

# iOS con objection (jailbreak requerido)
objection -g com.target.app explore

# Interceptar tráfico HTTPS
# Burp Suite proxy: 192.168.1.x:8080
```

### Fase 3: API Testing
```bash
# Extraer endpoints de la app
# Probar autenticación API
curl -X POST "https://api.target.com/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"test"}'

# Probar autorización (IDOR)
curl "https://api.target.com/user/1234/orders" \
  -H "Authorization: Bearer <token>"
curl "https://api.target.com/user/5678/orders" \
  -H "Authorization: Bearer <token>"
```

## MDM/EMM Deployment

### Soluciones Recomendadas
| Solución | Tipo | Caso de Uso |
|---|---|---|
| Microsoft Intune | Cloud | Entornos Microsoft 365 |
| VMware Workspace ONE | Cloud/On-prem | Enterprise multi-platform |
| Jamf Pro | Cloud | Entornos Apple |
| Google Workspace MDM | Cloud | Entornos Android/Google |
| ManageEngine MDM | Cloud/On-prem | Budget-friendly |

### Políticas MDM Recomendadas
```
Seguridad del dispositivo:
- Requerir PIN/contraseña (mínimo 6 dígitos)
- Requerir cifrado de dispositivo
- Bloquear dispositivos rooteados/jailbreak
- Requerir bloqueo automático (1-5 minutos)
- Habilitar borrado remoto

Gestión de apps:
- Whitelist de apps permitidas
- Blacklist de apps prohibidas
- Forzar actualizaciones de apps
- Configurar VPN siempre activa
- Habilitar modo kiosk si aplica

Protección de datos:
- Deshabilitar copia/pegado entre apps corporativas y personales
- Deshabilitar backup en la nube de datos corporativos
- Forzar cifrado de datos en tránsito
- Configurar contenedorización de datos corporativos
- Deshabilitar captura de pantalla en apps sensibles
```

## Android Security Assessment
```bash
# Verificar si el dispositivo está rooteado
adb shell su -c "id"

# Extraer APK instaladas
adb shell pm list packages -f

# Analizar permisos de una app
adb shell dumpsys package com.target.app | grep permission

# Verificar si la app usa SSL pinning
# (usar Frida para bypass)
frida -U -f com.target.app -l ssl-pinning-bypass.js

# Analizar tráfico con tcpdump en el dispositivo
adb shell tcpdump -i any -s 0 -w /sdcard/capture.pcap
adb pull /sdcard/capture.pcap
```

## iOS Security Assessment
```bash
# Verificar si el dispositivo está jailbroken
# Buscar Cydia, checkra1n, unc0ver

# Extraer IPA de dispositivo jailbroken
# Usar clutch o frida-ios-dump

# Analizar Info.plist
plutil -p Payload/*.app/Info.plist

# Verificar ATS (App Transport Security)
# Buscar NSAllowsArbitraryLoads en Info.plist

# Analizar keychain
# Usar keychain-dumper en dispositivo jailbroken
```

## Mobile Threat Defense (MTD)
```
Capacidades:
- Detección de dispositivos comprometidos (root/jailbreak)
- Detección de redes Wi-Fi maliciosas (evil twin)
- Detección de apps maliciosas
- Detección de ataques de phishing móvil
- Protección contra ataques MITM
- Evaluación de configuración del dispositivo

Soluciones:
- CrowdStrike Falcon for Mobile
- Lookout Mobile Security
- Zimperium zIPS
- Microsoft Defender for Endpoint (mobile)
```

## Entregables Mobile Security
1. **Executive Summary** — Riesgo de negocio, impacto en datos de clientes
2. **Technical Findings** — Vulnerabilidades con evidencia (screenshots, requests)
3. **OWASP MASTG Mapping** — Cada hallazgo mapeado al test ID correspondiente
4. **Risk Matrix** — CVSS scoring + business impact
5. **Remediation Plan** — Priorizado por severidad
6. **MDM Policy Recommendations** — Si aplica
