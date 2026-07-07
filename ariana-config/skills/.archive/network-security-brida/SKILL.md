---
name: network-security-brida
description: >
  Configuración, hardening y operación de seguridad de red para BRIDA IT Services
  centrada en Fortinet FortiGate (NGFW on-premises) y FortiSASE (cloud/Zero Trust).
  Cubre hardening de firewall, IDS/IPS, VPN site-to-site y SSL-VPN,
  segmentación VLAN, SD-WAN, Zero Trust Network Access (ZTNA),
  análisis de tráfico, monitoreo de red, y respuesta a incidentes de red.
  Incluye mapeo a MITRE ATT&CK, NIST CSF 2.0 y MITRE D3FEND.
  Activado por: firewall, fortigate, fortsase, network security, NGFW,
  VPN, IPsec, SSL-VPN, SD-WAN, VLAN, IDS, IPS, IDS/IPS, ZTNA,
  zero trust, network monitoring, traffic analysis, firewall hardening,
  network segmentation, incident response network, WAF, web filter,
  anti-malware, network forensics, SIEM, NetFlow, FortiAnalyzer.
domain: cybersecurity
subdomain: network-security
category: defensive-security
tags:
  - fortinet
  - fortigate
  - fortsase
  - firewall
  - network-security
  - NGFW
  - VPN
  - IPsec
  - SSL-VPN
  - SD-WAN
  - VLAN
  - network-segmentation
  - IDS
  - IPS
  - ZTNA
  - zero-trust
  - traffic-analysis
  - network-monitoring
  - firewall-hardening
  - incident-response
  - network-forensics
  - SIEM
  - NetFlow
  - FortiAnalyzer
  - FortiSOAR
  - fortiweb
  - WAF
  - cloudflare
  - nist-csf
  - mitre-attack
  - d3fend
mitre_attack:
  - T1021  # Remote Services
  - T1046  # Network Service Scanning
  - T1071  # Application Layer Protocol
  - T1090  # Proxy
  - T1095  # Non-Application Layer Protocol
  - T1190  # Exploit Public-Facing Application
  - T1210  # Exploitation of Remote Services
  - T1565.001  # Data Manipulation: Stored Data Manipulation
  - T1572  # Protocol Tunneling
  - T1583  # Acquire Infrastructure
  - T1583.004  # Server
  - T1595  # Active Scanning
  - T1595.001  # Scanning IP Blocks
  - T1595.002  # Vulnerability Scanning
  - T1601  # Modify System Image
  - T1048  # Exfiltration Over Alternative Protocol
  - T1011  # Exfiltration Over Other Network Medium
  - T1567  # Exfiltration Over Web Service
  - T1052  # Exfiltration Over Physical Medium
  - T1030  # Data Transfer Size Limits
nist_csf:
  - PR.AC-1  # Identities and credentials are issued, managed, verified
  - PR.AC-3  # Remote access is managed
  - PR.AC-4  # Access permissions and authorizations are managed
  - PR.AC-5  # Network integrity is protected
  - PR.AC-6  # Identities are proofed and bound to credentials
  - PR.AC-7  # Users, devices, and other assets are authenticated
  - PR.DS-2  # Data-in-transit is protected
  - PR.DS-5  # Protections against data leaks are implemented
  - PR.IP-1  # A baseline configuration of technology is created and maintained
  - PR.IP-7  # Protection processes are improved
  - PR.PT-3  # The principle of least functionality is incorporated
  - PR.PT-4  # Network connections and communications are managed
  - DE.AE-1  # A baseline of network operations and expected data flows is established
  - DE.AE-2  # Detected events are analyzed to identify attack targets and methods
  - DE.AE-3  # Event data are collected and correlated from multiple sources
  - DE.CM-1  # Networks and network services are monitored
  - DE.CM-6  # External service provider activities are monitored
  - DE.DP-4  # Event detection information is communicated
  - DE.CM-7  # Monitoring for unauthorized personnel, connections, devices
  - RS.AN-1  # Notifications from detection systems investigated
  - RS.AN-3  # Forensic analysis is performed
  - RS.AN-4  # Incidents are categorized consistent with response plans
  - RS.MI-1  # Incidents are contained
  - RS.MI-2  # Incidents are mitigated
  - RC.RP-1  # Recovery plan is executed
  - ID.AM-1  # Physical devices and systems are inventoried
  - ID.RA-1  # Asset vulnerabilities are identified and documented
  - ID.RA-2  # Cyber threat intelligence from information sharing forums
  - ID.SC-2  # Supply chain risk management is developed and implemented
d3fend:
  - D3-NI   # Network Isolation
  - D3-FR   # Firmware Revision Verification
  - D3-WAF  # Web Application Firewall
  - D3-IDS  # Intrusion Detection System
  - D3-NTA  # Network Traffic Analysis
  - D3-TA   # Traffic Analysis
  - D3-NA   # Network Analysis
  - D3-PLA  # Platform Monitoring
  - D3-AN   # Authentication
  - D3-MFA  # Multi-factor Authentication
  - D3-CB   # Certificate-based Authentication
  - D3-AC   # Access Control
  - D3-AA   # Administrative Access Control
  - D3-IPSec  # Internet Protocol Security
  - D3-VPN  # Virtual Private Network
  - D3-TLS  # Transport Layer Security
  - D3-DNS  # Domain Name System Configuration
  - D3-DNSA # DNS Record Analysis
  - D3-DNST # DNS Traffic Analysis
  - D3-NM   # Network Mapping
  - D3-NIC  # Network Intrusion Detection
  - D3-PE   # Physical Link Access
  - D3-SS   # Session Analysis
  - D3-URA  # User Request Analysis
  - D3-HS   # Host Status Analysis
  - D3-CE   # Configuration Enforcement
  - D3-EDR  # Endpoint Detection and Response
  - D3-SIEM # Security Information and Event Management
  - D3-BA   # Behavioral Analysis
  - D3-LA   # Log Analysis
  - D3-EP   # Endpoint Privilege
  - D3-PA   # Patch Application
  - D3-DC   # Data Classification
version: "2.0"
author: BRIDA IT Services
license: Apache-2.0
language: es
---

# Network Security — BRIDA IT Services v2.0

> **Stack principal:** Fortinet FortiGate (NGFW on-premises) + FortiSASE (cloud/Zero Trust) + Cloudflare (CDN/WAF/DDoS)
> **Firmware objetivo:** FortiOS 7.x / FortiSASE 24.x+
> **Frameworks:** MITRE ATT&CK v15, NIST CSF 2.0, MITRE D3FEND

---

## Tabla de Contenido

1. [Cuándo Usar](#1-cuándo-usar)
2. [Arquitectura de Referencia](#2-arquitectura-de-referencia)
3. [Firewall Hardening — FortiGate](#3-firewall-hardening--fortigate)
4. [IDS/IPS Configuration](#4-idsips-configuration)
5. [VPN Setup — Site-to-Site IPsec & SSL-VPN](#5-vpn-setup--site-to-site-ipsec--ssl-vpn)
6. [Segmentación de Red — VLAN](#6-segmentación-de-red--vlan)
7. [SD-WAN Configuration](#7-sd-wan-configuration)
8. [Zero Trust Network Access (ZTNA) — FortiSASE](#8-zero-trust-network-access-ztna--fortisase)
9. [Análisis de Tráfico y NetFlow](#9-análisis-de-tráfico-y-netflow)
10. [Monitoreo de Red y SIEM](#10-monitoreo-de-red-y-siem)
11. [Respuesta a Incidentes de Red](#11-respuesta-a-incidentes-de-red)
12. [Integración con Cloudflare](#12-integración-con-cloudflare)
13. [Auditoría y Cumplimiento](#13-auditoría-y-cumplimiento)
14. [Mapeo a Frameworks](#14-mapeo-a-frameworks)
15. [Checklist Pre-Producción](#15-checklist-pre-producción)

---

## 1. Cuándo Usar

- Configuración inicial o migración de un FortiGate
- Hardening post-deploy de cualquier appliance de red Fortinet
- Implementación de segmentación VLAN para cumplimiento (PCI-DSS, ISO 27001)
- Diseño o rediseño de arquitectura SD-WAN
- Implementación de ZTNA para acceso remoto seguro (SASE)
- Configuración de VPN site-to-site o SSL-VPN para teletrabajo
- Incidentes de red: intrusión, exfiltración, DoS/DDoS lateral
- Monitoreo continuo de tráfico y correlación de eventos de red
- Auditoría de configuraciones de firewall
- Integración FortiGate → FortiAnalyzer → FortiSOAR

---

## 2. Arquitectura de Referencia

### 2.1 Diagrama Lógico

```
[Internet]
    │
    ▼
┌─────────────────────┐
│   Cloudflare Edge    │ ← CDN, WAF, DDoS Protection, DNS
│   (Anycast Network)  │
└─────────┬───────────┘
          │
          ▼
┌─────────────────────┐
│   ISP Primary        │
│   (WAN1)             │
└─────────┬───────────┘
          │
          ▼
┌─────────────────────────────────────────────────┐
──────────────┬──────────────────────────────────+
─────────────────────────────────────────────────┐
───────┬─────────────────────────────────────────+
───────▼───────────+────────────────────+
───────▼───────────+
```

### 2.2 Zonas de Seguridad

| Zona | Interfaz | Propósito | Nivel de Confianza |
|------|----------|-----------|--------------------|
| **WAN** | port1, port2 | Internet / ISP | 0 (Sin confianza) |
| **DMZ** | port3 | Servidores públicos (web, mail, DNS) | 25 |
| **Internal** | port4 (trunk) | Red corporativa interna | 75 |
| **Management** | port5 | Administración OOB (fuera de banda) | 90 |
| **IoT/OT** | VLAN 50 | Dispositivos IoT, cámaras, OT | 10 |
| **Guest** | VLAN 40 | Invitados, BYOD | 5 |

---

## 3. Firewall Hardening — FortiGate

### 3.1 Principios Fundamentales

- **Least Privilege (Privilegio Mínimo):** Denegar todo por default, permitir solo lo necesario
- **Defense in Depth (Defensa en Profundidad):** Múltiples capas de control
- **Default-Deny Posture:** Políticas implícitas de denegación
- **Segmentación estricta:** Tráfico inter-VLAN controlado por capa 7
- **Inspección SSL:** Inspeccionar tráfico cifrado (inbound y outbound)
- **Actualización continua:** Firmware, AV/IPS signatures, firmware revision control

### 3.2 Hardening Checklist — Administración

#### 3.2.1 Acceso Administrativo
```bash
# Configurar fuerte autenticación admin
config system admin
    edit "admin"
        set password ${STRONG_PASSWORD_POLICY}
        set trusthost1 10.0.10.0/24    # Solo desde red de management
        set trusthost2 10.0.10.10      # Host específico de jump server
        set vdom "root"
    next
end

# Deshabilitar acceso HTTP — solo HTTPS
config system global
    set admin-port 8443
    set admin-sport 8443             # HTTPS management port
    set admin-ssh-port 8022
    set admin-ssh-grace-time 30
    set admin-ssh-password-disable  # Solo SSH keys
    set gui-https-redirect enable
    set gui-usb-image-download disable
    set gui-wireless-opensecurity disable
    set gui-display-hostname enable
    set gui-firmware-upgrade-warning enable
    set gui-theme green
    set hostname "FW-[SITE]-01"
end

# Deshabilitar cuenta admin por defecto — crear cuentas individuales
config system admin
    edit "admin"
        set accprofile "super_admin"
        set vdom "root"
        set password ENC ${HASH}
    next
    edit "netadmin-jperez"
        set accprofile "netadmin"
        set vdom "root"
        set password ENC ${HASH}
        set trusthost1 10.0.10.0/24
    next
end

# Crear perfil de acceso personalizado (no usar super_admin)
config system accprofile
    edit "netadmin"
        set secfabgrp read-write
        set ftviewgrp read-write
        set authgrp read-write
        set sysgrp read-write
        set fwgrp read-write
        set vpngrp read-write
        set utmgrp read-write
        set wanoptgrp read-write
        set wifi disable
    next
end
```

#### 3.2.2 Autenticación Multifactor (MFA)
```bash
# Configurar FortiToken / FortiAuthenticator como MFA
config user fortitoken
    edit "FTKxxxxxxxxxxxxx"
        set activation-code xxxxxxxx
        set activation-expire 2026-12-31
    next
end

config user local
    edit "netadmin-jperez"
        set type password
        set passwd ${STRONG_PASSWORD}
        set two-factor fortitoken
        set fortitoken "FTKxxxxxxxxxxxxx"
        set email-to "jperez@brida.mx"
        set sms-phone "5512345678"
    next
end

# Alternativa: RADIUS con FortiAuthenticator
config user radius
    edit "FAC-RADIUS"
        set server "10.0.10.5"
        set secret ${RADIUS_SECRET}
        set rsso enable
        set sso-attribute "Class"
    next
end
```

#### 3.2.3 Hardening de Servicios
```bash
# Deshabilitar servicios innecesarios en interfaces
config system interface
    edit "port1"
        set allowaccess ping          # Solo ping en WAN
        set type physical
        set role wan
    next
    edit "port4"
        set allowaccess ping          # Sin acceso admin desde internal
        set type hard-switch
        set role lan
    next
    edit "port5"
        set allowaccess https ssh     # Solo management
        set type physical
        set role dmz
        set dedicated-to management
    next
end

# Deshabilitar unused features
config system global
    set ssl-min-prover tls1-2       # Mínimo TLS 1.2
    set strong-crypto enable          # Solo ciphers fuertes
    set check-reset-range enable     # Protección contra TCP RST injection
    set tcp-halfclose-timer 120
    set tcp-halfopen-timer 10
    set tcp-timewait-timer 1
    set udp-idle-timer 180
    set gui-dns-database disable
    set gui-explicit-proxy disable
    set gui-dynamic-routing disable
    set gui-ipsec-manualkey disable
    set gui-replacement-message-groups disable
    set gui-wan-load-balancing disable
    set gui-wireless-controller disable
end

# Deshabilitar Telnet, FTP, SNMPv1/v2
config system snmp sysinfo
    set status disable
end

config system snmp community
    # Eliminar todas las comunidades SNMPv1/v2
    # Usar SNMPv3 si es necesario
    edit 1
        set name "snmpv3-only"
        set status disable
    next
end
```

#### 3.2.4 NTP y Logging
```bash
# Configurar NTP (crítico para correlación de eventos)
config system ntp
    set ntpsync enable
    set syncinterval 60
    config ntpserver
        edit 1
            set server "time.google.com"
            set ntpv3 enable
        next
        edit 2
            set server "time.cloudflare.com"
            set ntpv3 enable
        next
    end
end

# Configurar logging centralizado
config log fortianalyzer setting
    set status enable
    set server "10.0.10.6"
    set reliable enable
    set upload-option realtime
    set enc-algorithm high
end

config log syslogd setting
    set status enable
    set server "10.0.10.7"
    set port 514
    set facility local6
    set format default
    set mode udp
    set csv disable
end

# Habilitar logging en todas las políticas de firewall
config firewall policy
    edit 1
        set logtraffic all            # Log all sessions
        set logtraffic-start enable   # Log session start
        set utm-status enable
        set webfilter-profile "default"
        set ssl-ssh-profile "certificate-inspection"
        set av-profile "default"
        set ips-sensor "default"
        set application-list "default"
        set nat enable
    next
end
```

#### 3.2.5 HA (High Availability)
```bash
# Configurar cluster HA Active-Passive
config system ha
    set mode a-p
    set group-name "FW-CLUSTER-[SITE]"
    set group-id 10
    set password ${HA_PASSWORD}
    set hbdev port6 50
    set session-pickup enable
    set session-pickup-connectionless enable
    set session-pickup-delay enable
    set override enable
    set priority 200                # Primary unit
    set monitor port1 port4
    set ha-uptime-diff-margin 300
    set unicast-hb enable
    set unicast-hb-peerip 10.0.10.2
    set unicast-hb-netmask 255.255.255.252
end
```

### 3.3 Hardening de Políticas de Firewall

#### 3.3.1 Reglas Base (Implicit Deny)
```bash
# Política 1: Management Access (restrictivo)
config firewall policy
    edit 1
        set name "MGMT-Access"
        set srcintf "port5"
        set dstintf "any"
        set srcaddr "MGMT-Servers" "Jump-Server"
        set dstaddr "All"
        set action accept
        set schedule "always"
        set service "HTTPS" "SSH" "PING" "SNMP"
        set logtraffic all
        set logtraffic-start enable
        set utm-status enable
        set ssl-ssh-profile "deep-inspection"
        set comments "Acceso de administración desde red de management"
    next

    # Política 2: Internal → Internet (con inspección)
    edit 2
        set name "Internal-to-Internet"
        set srcintf "port4"
        set dstintf "port1"
        set srcaddr "VLAN30-Corporate"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set webfilter-profile "corporate-web-filter"
        set ssl-ssh-profile "certificate-inspection"
        set av-profile "default"
        set ips-sensor "default"
        set application-list "corporate-apps"
        set nat enable
        set logtraffic all
        set comments "Tráfico corporativo con inspección completa"
    next

    # Política 3: DMZ → Internet (limitado)
    edit 3
        set name "DMZ-to-Internet-Restricted"
        set srcintf "port3"
        set dstintf "port1"
        set srcaddr "DMZ-Servers"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "HTTP" "HTTPS" "DNS" "NTP"
        set utm-status enable
        set av-profile "default"
        set ips-sensor "default"
        set nat enable
        set logtraffic all
        set comments "Servidores DMZ con acceso limitado a Internet"
    next

    # Política 4: Denegar todo lo demás (explícito)
    edit 999
        set name "DENY-ALL-IMPLICIT"
        set srcintf "any"
        set dstintf "any"
        set srcaddr "all"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set comments "Denegar todo el tráfico no explícitamente permitido"
    next
end
```

#### 3.3.2 Políticas de Segmentación Inter-VLAN
```bash
# VLAN 30 (Corporate) → VLAN 20 (Servers) — permitido
config firewall policy
    edit 10
        set name "Corp-to-Servers"
        set srcintf "vlan30"
        set dstintf "vlan20"
        set srcaddr "VLAN30-Corporate"
        set dstaddr "SRV-Web" "SRV-DB" "SRV-Mail"
        set action accept
        set schedule "always"
        set service "HTTP" "HTTPS" "DNS" "LDAP" "LDAPS" "SMTP" "SMTPS" "IMAP" "IMAPS" "MSSQL" "MySQL"
        set utm-status enable
        set ips-sensor "default"
        set logtraffic all
    next

    # VLAN 40 (Guest) → DENEGAR todo excepto Internet
    edit 11
        set name "Guest-Deny-Internal"
        set srcintf "vlan40"
        set dstintf "vlan30" "vlan20" "vlan50" "vlan10"
        set srcaddr "VLAN40-Guest"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set comments "Guest no puede acceder a redes internas"
    next

    # VLAN 50 (IoT) → Solo servicios específicos
    edit 12
        set name "IoT-Restricted"
        set srcintf "vlan50"
        set dstintf "vlan20"
        set srcaddr "VLAN50-IoT"
        set dstaddr "SRV-NTP" "SRV-MQTT"
        set action accept
        set schedule "always"
        set service "NTP" "MQTT" "HTTPS"
        set utm-status enable
        set ips-sensor "iot-protection"
        set logtraffic all
        set comments "IoT solo puede comunicarse con servicios específicos"
    next

    # IoT → Denegar todo lo demás
    edit 13
        set name "IoT-Deny-All-Else"
        set srcintf "vlan50"
        set dstintf "any"
        set srcaddr "VLAN50-IoT"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set comments "IoT denegado a todo lo demás"
    next
end
```

### 3.4 Protección contra Ataques de Red

```bash
# Protección contra DoS/DDoS
config firewall DoS-policy
    edit 1
        set interface "port1"
        set srcaddr "all"
        set dstaddr "all"
        config anomaly
            edit "tcp.syn.flood"
                set status enable
                set log enable
                set action block
                set threshold 2000
            next
            edit "udp.flood"
                set status enable
                set log enable
                set action block
                set threshold 2000
            next
            edit "icmp.flood"
                set status enable
                set log enable
                set action block
                set threshold 500
            next
            edit "ip.srcfrag"
                set status enable
                set log enable
                set action block
            next
            edit "tcp.port.scan"
                set status enable
                set log enable
                set action monitor
                set threshold 500
            next
        end
    next
end

# Protección contra IP spoofing
config firewall policy
    edit 1
        set name "MGMT-Access"
        set srcintf "port5"
        set dstintf "any"
        set srcaddr "MGMT-Servers" "Jump-Server"
        set anti-replay enable
        set geoip-match and
        set srcaddr-negate disable
    next
end

# GeoIP blocking (bloquear países de alto riesgo)
config firewall address
    edit "GeoIP-HighRisk"
        set type geography
        set country "KP" "IR" "RU" "CN"    # Ajustar según threat intelligence
        set color 1
    next
end

config firewall policy
    edit 0
        set name "GeoIP-Block-HighRisk"
        set srcintf "port1"
        set dstintf "any"
        set srcaddr "GeoIP-HighRisk"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
        set comments "Bloqueo de países de alto riesgo basado en GeoIP"
    next
end
```

---

## 4. IDS/IPS Configuration

### 4.1 Modos de Operación

| Modo | Descripción | Uso Recomendado |
|------|-------------|-----------------|
| **Inline (IPS)** | Inspecciona y bloquea en tiempo real | Interfaces internas, DMZ |
| **Sniffer (IDS)** | Solo monitoreo, sin bloqueo | Análisis forense, monitoreo pasivo |
| **Mixed** | Combinación de ambos | Producción general |

### 4.2 Configuración de IPS Sensor

```bash
# Crear IPS Sensor principal
config ips sensor
    edit "default"
        set comment "IPS Sensor — Protección general"
        config entries
            edit 1
                set rule 16443            # SQL Injection
                set status enable
                set log enable
                set action block
                set severity high critical
                set location server
                set os Linux Windows
                set protocol TCP
                set application "Web_Server"
            next
            edit 2
                set rule 16444            # XSS
                set status enable
                set log enable
                set action block
                set severity high critical
            next
            edit 3
                set rule 16445            # Command Injection
                set status enable
                set log enable
                set action block
                set severity critical
            next
            edit 4
                set rule 16446            # Buffer Overflow
                set status enable
                set log enable
                set action block
                set severity critical
            next
            edit 5
                set rule 16447            # CVE-2024-XXXX (ejemplo)
                set status enable
                set log enable
                set action block
                set severity critical
                set cve "CVE-2024-XXXX"
            next
        end
    next

    # IPS Sensor para IoT/OT
    edit "iot-protection"
        set comment "IPS Sensor — Protección IoT/OT"
        config entries
            edit 1
                set rule 16500            # Mirai botnet signatures
                set status enable
                set log enable
                set action block
                set severity critical
            next
            edit 2
                set rule 16501            # MQTT exploitation
                set status enable
                set log enable
                set action block
                set severity high critical
            next
            edit 3
                set rule 16502            # Modbus/TCP anomalies
                set status enable
                set log enable
                set action block
                set severity high
            next
        end
    next

    # IPS Sensor para DMZ
    edit "dmz-protection"
        set comment "IPS Sensor — Protección DMZ"
        config entries
            edit 1
                set rule 16600            # Web attack signatures
                set status enable
                set log enable
                set action block
                set severity high critical
                set location server
                set os Linux Windows
            next
            edit 2
                set rule 16601            # Mail server attacks
                set status enable
                set log enable
                set action block
                set severity high critical
            next
        end
    next
end
```

### 4.3 Configuración de IPS Global

```bash
# Configuración global de IPS
config ips global
    set fail-open enable              # Fail-open para evitar downtime
    set packet-log enable              # Log de paquetes sospechosos
    set session-log enable             # Log de sesiones
    set engine-count 4                 # Usar múltiples engines
    set socket-size 32
    set queue-size 16384
end

# Programar actualización automática de firmas
config system autoupdate schedule
    set frequency daily
    set time 02:00
end

config system autoupdate tunneling
    set status enable
    set address "update.fortinet.com"
    set port 443
end
```

### 4.4 Custom Signatures

```bash
# Crear firmas IPS personalizadas
config ips custom
    edit "Custom-C2-Detection"
        set signature "F-SBID( --name \"Custom.C2.Beacon\"; --protocol tcp; --flow established,to_server; --pattern \"|00 01 02 03|\"; --no_case; --service http;)"
        set action block
        set log enable
        set severity high
        set comment "Detección de beaconing C2 personalizado"
    next

    edit "Custom-Data-Exfil"
        set signature "F-SBID( --name \"Custom.Exfil.LargeTransfer\"; --protocol tcp; --flow established,to_client; --dsize >10485760; --service http;)"
        set action monitor
        set log enable
        set severity medium
        set comment "Detección de transferencias grandes (posible exfiltración)"
    next
end
```

### 4.5 Análisis de Logs IPS

```bash
# Comandos CLI para diagnóstico IPS
diagnose ips signature list                    # Listar todas las firmas
diagnose ips signature status                  # Estado de las firmas
diagnose ips memory pool                       # Uso de memoria IPS
diagnose ips session list                      # Sesiones activas IPS
diagnose ips session stat                      # Estadísticas de sesiones
diagnose ips session clear                     # Limpiar sesiones
diagnose sniffer packet any "port 80" 4        # Captura de paquetes
diagnose debug application ips -1              # Debug IPS
diagnose debug application ipsmonitor -1       # Debug IPS monitor
diagnose debug enable
```

---

## 5. VPN Setup — Site-to-Site IPsec & SSL-VPN

### 5.1 VPN Site-to-Site IPsec

#### 5.1.1 Fase 1 (IKE)
```bash
# Configurar Phase 1 Interface
config vpn ipsec phase1-interface
    edit "VPN-SiteA-to-SiteB"
        set interface "port1"
        set ike-version 2
        set peertype any
        set net-device disable
        set proposal aes256-sha256 aes256-sha384 aes256-sha512
        set dhgrp 14 19 20              # DH Group 14 (2048-bit), 19 (256-bit ECP), 20 (384-bit ECP)
        set remote-gw 203.0.113.1
        set psksecret ${STRONG_PSK}
        set dpd-retrycount 3
        set dpd-retryinterval 10
        set idle-timeout enable
        set idle-timeoutinterval 30
        set auto-negotiate enable
        set add-route enable
        set ipv4-start-ip 0.0.0.0
        set ipv4-end-ip 0.0.0.0
        set ipv4-netmask 255.255.255.255
        set comments "VPN Site-to-Site: [SiteA] ↔ [SiteB]"
    next
end
```

#### 5.1.2 Fase 2 (IPsec)
```bash
# Configurar Phase 2
config vpn ipsec phase2-interface
    edit "VPN-SiteA-to-SiteB-P2"
        set phase1name "VPN-SiteA-to-SiteB"
        set proposal aes256-sha256 aes256-sha384
        set dhgrp 14 19 20
        set pfs enable                   # Perfect Forward Secrecy
        set protocol esp
        set src-subnet 10.0.0.0/16
        set dst-subnet 10.1.0.0/16
        set keylifeseconds 3600
        set keylifekbs 51200
        set auto-negotiate enable
        set comments "Phase 2: Red local 10.0.0.0/16 ↔ Remota 10.1.0.0/16"
    next
end
```

#### 5.1.3 Política de Firewall para VPN
```bash
# Crear direcciones para redes remotas
config firewall address
    edit "Remote-SiteB-Network"
        set subnet 10.1.0.0/16
        set associated-interface "VPN-SiteA-to-SiteB"
    next
end

# Política de firewall para tráfico VPN
config firewall policy
    edit 50
        set name "VPN-SiteB-Inbound"
        set srcintf "VPN-SiteA-to-SiteB"
        set dstintf "port4"
        set srcaddr "Remote-SiteB-Network"
        set dstaddr "VLAN30-Corporate"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set ips-sensor "default"
        set logtraffic all
        set comments "Tráfico entrante desde SiteB vía VPN"
    next

    edit 51
        set name "VPN-SiteB-Outbound"
        set srcintf "port4"
        set dstintf "VPN-SiteA-to-SiteB"
        set srcaddr "VLAN30-Corporate"
        set dstaddr "Remote-SiteB-Network"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set ips-sensor "default"
        set logtraffic all
        set comments "Tráfico saliente hacia SiteB vía VPN"
    next
end
```

#### 5.1.4 Diagnóstico VPN
```bash
# Comandos de diagnóstico VPN
diagnose vpn ike gateway list                  # Estado de gateways IKE
diagnose vpn ike gateway flush                 # Limpiar gateways IKE
diagnose vpn tunnel list                       # Lista de túneles activos
diagnose vpn tunnel up [tunnel-name]           # Levantar túnel
diagnose vpn tunnel down [tunnel-name]         # Bajar túnel
diagnose vpn ike log-filter dst-addr4 203.0.113.1  # Filtrar logs IKE
diagnose debug application ike -1              # Debug IKE
diagnose debug enable
get vpn ipsec tunnel summary                   # Resumen de túneles
```

### 5.2 SSL-VPN (Acceso Remoto)

#### 5.2.1 Configuración del Portal SSL-VPN
```bash
# Configurar interfaz SSL-VPN
config vpn ssl settings
    set servercert "Fortinet_Factory"          # Usar certificado propio en producción
    set tunnel-ip-pools "SSLVPN_TUNNEL_ADDR1"
    set source-interface "port1"
    set source-address "all"
    set default-portal "full-access"
    set port 10443
    set idle-timeout 1800
    set tunnel-ipv6-pools "SSLVPN_TUNNEL_IPv6_ADDR1"
    set algorithm high
    set ssl-max-prover tls1-3
    set ssl-min-prover tls1-2
    set dtls-tunnel enable
    set dtls-max-prover tls1-2
    set check-referer enable
    set http-request-header-timeout 20
    set http-request-body-timeout 30
    set login-attempt-limit 3
    set login-block-time 60
end

# Configurar portal SSL-VPN
config vpn ssl web portal
    edit "full-access"
        set tunnel-mode enable
        set web-mode enable
        set ip-pools "SSLVPN_TUNNEL_ADDR1"
        set split-tunneling enable
        set split-tunneling-routing-address "VLAN30-Corporate" "VLAN20-Servers"
        set theme blue
        set show-full-calendar disable
        set display-bookmark enable
        set display-connection-tools enable
        set display-history enable
        set display-status enable
        set ip-mode range
        set ipv6-tunnel-mode enable
        set web-mode enable
        set limit-user-logins enable
        set max-session-per-user 2
    next

    edit "web-only"
        set tunnel-mode disable
        set web-mode enable
        set web-mode-snat enable
        set theme green
        set comments "Portal web-only para acceso a aplicaciones específicas"
    next
end

# Configurar usuarios SSL-VPN
config user local
    edit "vpn-user-jperez"
        set type password
        set passwd ${STRONG_PASSWORD}
        set two-factor fortitoken
        set fortitoken "FTKxxxxxxxxxxxxx"
        set email-to "jperez@brida.mx"
    next
end

config user group
    edit "SSLVPN-Users"
        set member "vpn-user-jperez"
        config match
            edit 1
                set server-name "full-access"
                set group-name "SSLVPN-Users"
            next
        end
    next
end

# Política de firewall para SSL-VPN
config firewall policy
    edit 60
        set name "SSLVPN-Access"
        set srcintf "ssl.root"
        set dstintf "port4"
        set srcaddr "SSLVPN_TUNNEL_ADDR1"
        set dstaddr "VLAN30-Corporate" "VLAN20-Servers"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set ssl-ssh-profile "certificate-inspection"
        set ips-sensor "default"
        set logtraffic all
        set comments "Acceso SSL-VPN con inspección"
    next
end
```

#### 5.2.2 Hardening SSL-VPN
```bash
# Restricciones adicionales de seguridad
config vpn ssl settings
    set reqclientcert enable                    # Requerir certificado de cliente
    set ssl-undefined-san-action block          # Bloquear SANs no definidos
    set ssl-hpkp enable                         # HTTP Public Key Pinning
    set ssl-hpkp-age 5184000                    # 60 días
    set ssl-hpkp-subinclude enable
    set ssl-hpkp-primary-sha256 ${HPKP_HASH}
    set source-interface "port1"                # Solo desde WAN
    set source-address "all"
    set web-forward-snat enable
end

# Rate limiting para prevenir brute force
config webfilter profile
    edit "sslvpn-protection"
        config ftgd-wf
            config filters
                edit 1
                    set category 178            # Proxy Avoidance
                    set action block
                next
            end
        end
    next
end
```

---

## 6. Segmentación de Red — VLAN

### 6.1 Diseño de VLANs

| VLAN ID | Nombre | Subnet | Gateway | Propósito |
|---------|--------|--------|---------|-----------|
| 10 | MGMT | 10.0.10.0/24 | 10.0.10.1 | Administración de red |
| 20 | SERVERS | 10.0.20.0/24 | 10.0.20.1 | Servidores internos |
| 30 | CORPORATE | 10.0.30.0/24 | 10.0.30.1 | Usuarios corporativos |
| 40 | GUEST | 10.0.40.0/24 | 10.0.40.1 | Invitados / BYOD |
| 50 | IOT | 10.0.50.0/24 | 10.0.50.1 | Dispositivos IoT |
| 60 | VOIP | 10.0.60.0/24 | 10.0.60.1 | Telefonía IP |
| 99 | NATIVE | — | — | Native VLAN (no usar) |
| 4094 | BLACKHOLE | — | — | VLAN para puertos no usados |

### 6.2 Configuración de VLANs en FortiGate

```bash
# Crear interfaces VLAN
config system interface
    edit "vlan10"
        set vdom "root"
        set ip 10.0.10.1/24
        set allowaccess ping https ssh
        set device-identification enable
        set role lan
        set snmp-index 10
        set interface "port4"
        set vlanid 10
    next
    edit "vlan20"
        set vdom "root"
        set ip 10.0.20.1/24
        set allowaccess ping
        set device-identification enable
        set role lan
        set snmp-index 20
        set interface "port4"
        set vlanid 20
    next
    edit "vlan30"
        set vdom "root"
        set ip 10.0.30.1/24
        set allowaccess ping
        set device-identification enable
        set role lan
        set snmp-index 30
        set interface "port4"
        set vlanid 30
    next
    edit "vlan40"
        set vdom "root"
        set ip 10.0.40.1/24
        set allowaccess ping
        set device-identification enable
        set role lan
        set snmp-index 40
        set interface "port4"
        set vlanid 40
    next
    edit "vlan50"
        set vdom "root"
        set ip 10.0.50.1/24
        set allowaccess ping
        set device-identification enable
        set role lan
        set snmp-index 50
        set interface "port4"
        set vlanid 50
    next
    edit "vlan60"
        set vdom "root"
        set ip 10.0.60.1/24
        set allowaccess ping
        set device-identification enable
        set role lan
        set snmp-index 60
        set interface "port4"
        set vlanid 60
    next
end
```

### 6.3 DHCP por VLAN

```bash
# Configurar DHCP Server por VLAN
config system dhcp server
    edit 1
        set dns-service default
        set default-gateway 10.0.10.1
        set netmask 255.255.255.0
        set interface "vlan10"
        config ip-range
            edit 1
                set start-ip 10.0.10.100
                set end-ip 10.0.10.200
            next
        end
        set lease-time 28800
    next
    edit 2
        set dns-service default
        set default-gateway 10.0.30.1
        set netmask 255.255.255.0
        set interface "vlan30"
        config ip-range
            edit 1
                set start-ip 10.0.30.100
                set end-ip 10.0.30.250
            next
        end
        set lease-time 28800
    next
    edit 3
        set dns-service default
        set default-gateway 10.0.40.1
        set netmask 255.255.255.0
        set interface "vlan40"
        config ip-range
            edit 1
                set start-ip 10.0.40.100
                set end-ip 10.0.40.200
            next
        end
        set lease-time 14400               # Menor lease para guest
        set timezone-option default
    next
end
```

### 6.4 Seguridad de Puertos de Switch

```bash
# Configuración recomendada en switches (ejemplo genérico)
# Deshabilitar puertos no usados
interface range GigabitEthernet0/1-24
    switchport mode access
    switchport access vlan 4094          # Blackhole VLAN
    shutdown

# Puertos en uso — seguridad
interface GigabitEthernet0/1
    description "Corporate User Port"
    switchport mode access
    switchport access vlan 30
    switchport port-security
    switchport port-security maximum 2
    switchport port-security violation restrict
    switchport port-security aging time 60
    spanning-tree portfast
    spanning-tree bpduguard enable
    ip dhcp snooping limit rate 15
    storm-control broadcast level 10
    storm-control multicast level 10
    no cdp enable
    no lldp transmit

# Trunk hacia FortiGate
interface GigabitEthernet0/48
    description "Trunk to FortiGate port4"
    switchport mode trunk
    switchport trunk allowed vlan 10,20,30,40,50,60
    switchport trunk native vlan 99
    switchport nonegotiate
    spanning-tree guard root
```

### 6.5 Private VLAN y Microsegmentación

```bash
# Para entornos que requieren microsegmentación avanzada
# FortiGate soporta VLAN filtering y políticas granulares

# Crear zonas de seguridad lógicas
config system zone
    edit "Zone-Corporate"
        set interface "vlan30" "vlan60"
        set intrazone allow
    next
    edit "Zone-Servers"
        set interface "vlan20"
        set intrazone allow
    next
    edit "Zone-Restricted"
        set interface "vlan40" "vlan50"
        set intrazone allow
    next
end

# Políticas basadas en zonas
config firewall policy
    edit 100
        set name "Zone-Corp-to-Servers"
        set srcintf "Zone-Corporate"
        set dstintf "Zone-Servers"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set logtraffic all
    next
    edit 101
        set name "Zone-Restricted-Deny-Internal"
        set srcintf "Zone-Restricted"
        set dstintf "Zone-Corporate" "Zone-Servers"
        set srcaddr "all"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
    next
end
```

---

## 7. SD-WAN Configuration

### 7.1 Diseño SD-WAN

| Link | Interfaz | Tipo | Prioridad | Rol |
|------|----------|------|-----------|-----|
| ISP-Primary | port1 | Fiber 1Gbps | 10 | Primary |
| ISP-Backup | port2 | Fiber 500Mbps | 20 | Backup |
| LTE-Backup | port7 | 4G/LTE | 30 | Failover |

### 7.2 Configuración SD-WAN

```bash
# Agregar interfaces al SD-WAN
config system sdwan
    set status enable
    config members
        edit 1
            set interface "port1"
            set zone "virtual-wan-link"
            set priority 10
            set cost 10
            set source 10.0.0.1
            set gateway 198.51.100.1
            set comments "ISP Primary — Fiber 1Gbps"
        next
        edit 2
            set interface "port2"
            set zone "virtual-wan-link"
            set priority 20
            set cost 20
            set source 10.0.0.2
            set gateway 198.51.200.1
            set comments "ISP Backup — Fiber 500Mbps"
        next
        edit 3
            set interface "port7"
            set zone "virtual-wan-link"
            set priority 30
            set cost 30
            set source 10.0.0.3
            set comments "LTE Failover — 4G"
        next
    end

    # Configurar health checks (SLA)
    config health-check
        edit "Google-DNS"
            set server 8.8.8.8 8.8.4.4
            set protocol ping
            set interval 5000
            set failtime 3
            set recoverytime 3
            set update-static-route enable
            set sla
                edit 1
                    set id 1
                next
            end
        next
        edit "Cloudflare-DNS"
            set server 1.1.1.1 1.0.0.1
            set protocol ping
            set interval 5000
            set failtime 3
            set recoverytime 3
            set update-static-route enable
            set sla
                edit 1
                    set id 1
                next
            end
        next
    end

    # Reglas de enrutamiento SD-WAN
    config service
        edit 1
            set name "Critical-Traffic"
            set mode priority
            set src "VLAN30-Corporate"
            set dst "VLAN20-Servers"
            set priority-members 1 2
            set health-check "Google-DNS"
            set sla
                edit 1
                    set id 1
                next
            end
            set comments "Tráfico crítico: usar ISP Primary, failover a Backup"
        next
        edit 2
            set name "Internet-Traffic"
            set mode load-balance
            set src "VLAN30-Corporate"
            set dst "all"
            set priority-members 1 2 3
            set load-balance-algorithm source-ip-hash
            set comments "Tráfico general: balanceo de carga entre ISPs"
        next
        edit 3
            set name "Guest-Traffic"
            set mode priority
            set src "VLAN40-Guest"
            set dst "all"
            set priority-members 2 3
            set comments "Guest: usar ISP Backup, failover a LTE"
        next
        edit 4
            set name "VoIP-Traffic"
            set mode priority
            set src "VLAN60-VoIP"
            set dst "all"
            set priority-members 1
            set health-check "Google-DNS"
            set comments "VoIP: siempre por ISP Primary (baja latencia)"
        next
    end
end
```

### 7.3 SD-WAN Performance SLA

```bash
# Configurar SLA targets para calidad de servicio
config system sdwan
    config health-check
        edit "VoIP-SLA"
            set server 8.8.8.8
            set protocol ping
            set interval 1000
            set failtime 5
            set recoverytime 5
            set sla
                edit 1
                    set id 1
                    set latency-threshold 50      # < 50ms
                    set jitter-threshold 20       # < 20ms
                    set packetloss-threshold 1    # < 1%
                next
            end
            set comments "SLA para VoIP: latencia <50ms, jitter <20ms, pérdida <1%"
        next
    end
end
```

### 7.4 Diagnóstico SD-WAN

```bash
# Comandos de diagnóstico SD-WAN
diagnose sys sdwan member                          # Estado de miembros
diagnose sys sdwan service                         # Estado de servicios
diagnose sys sdwan health-check                    # Resultados de health checks
diagnose sys sdwan sla-log                         # Log de SLA
diagnose sys sdwan history                         # Historial de decisiones
get router info routing-table all                  # Tabla de rutas
diagnose sniffer packet "port1" "host 8.8.8.8" 4  # Captura en interfaz SD-WAN
```

---

## 8. Zero Trust Network Access (ZTNA) — FortiSASE

### 8.1 Principios ZTNA

| Principio | Descripción |
|-----------|-------------|
| **Never Trust, Always Verify** | Verificar cada solicitud, sin importar el origen |
| **Least Privilege Access** | Acceso mínimo necesario para la tarea |
| **Assume Breach** | Diseñar asumiendo que la red ya está comprometida |
| **Continuous Verification** | Verificación continua de postura y contexto |
| **Microsegmentación** | Segmentar el acceso a nivel de aplicación |

### 8.2 Arquitectura FortiSASE

```
[Remote Users / Branch Offices]
         │
         ▼
┌─────────────────────────────┐
──────────────▼──────────────┐
```

### 8.3 Configuración ZTNA en FortiGate (On-Premises)

```bash
# Habilitar ZTNA en FortiGate
config firewall access-proxy
    edit "ZTNA-WebApp"
        set client-cert enable
        set vip "VIP-WebApp"
        set api-gateway "ZTNA-Gateway-WebApp"
    next
end

# Configurar API Gateway (ZTNA tags)
config firewall access-proxy
    edit "ZTNA-WebApp"
        set client-cert enable
        config api-gateway
            edit 1
                set url-map "/webapp"
                set service HTTP
                set realservers
                    edit 1
                        set address "Internal-WebApp"
                        set health-check enable
                    next
                end
                set ssl-ssh-profile "certificate-inspection"
                set client-cert enable
                set log-url enable
            next
        end
    next
end

# Configurar ZTNA tags (etiquetas de postura)
config firewall address
    edit "ZTNA-Trusted-Devices"
        set type ipmask
        set associated-interface "port4"
    next
end

config user device-category
    edit "Corporate-Laptop"
        set comment "Dispositivos corporativos gestionados"
    next
end

config user device-group
    edit "ZTNA-Authorized-Devices"
        set member "Corporate-Laptop"
    next
end

# Reglas ZTNA
config firewall proxy-policy
    edit 1
        set name "ZTNA-WebApp-Access"
        set proxy access-proxy
        set access-proxy "ZTNA-WebApp"
        set srcintf "ssl.root"
        set srcaddr "all"
        set dstaddr "VIP-WebApp"
        set ztna-ems-tag "ZTNA-Trusted-Devices"
        set action accept
        set schedule "always"
        set service "HTTPS"
        set logtraffic all
        set comments "Acceso ZTNA a aplicación web interna"
    next
end
```

### 8.4 Configuración FortiSASE (Cloud)

```bash
# Configuración de FortiSASE via GUI/CLI
# Nota: FortiSASE se configura principalmente vía portal cloud

# 1. Registrar FortiGate como conector SD-WAN hacia FortiSASE
config vpn ipsec phase1-interface
    edit "FSASE-Connector"
        set interface "port1"
        set ike-version 2
        set peertype any
        set proposal aes256-sha256
        set dhgrp 14 20
        set remote-gw ${FSASE_TUNNEL_IP}
        set psksecret ${FSASE_PSK}
        set add-route enable
        set auto-negotiate enable
    next
end

# 2. Configurar ZTNA Application Sets en FortiSASE Portal
#    - Definir aplicaciones privadas (Private Applications)
#    - Configurar Access Policies basadas en identidad y postura
#    - Habilitar SWG (Secure Web Gateway) para filtrado de Internet
#    - Configurar CASB para SaaS

# 3. Configurar ZTNA Tags en FortiClient EMS
#    - Posture check: OS version, AV status, disk encryption, firewall enabled
#    - Asignar tags basados en postura
#    - Mapear tags a políticas de acceso ZTNA

# 4. Políticas de acceso ZTNA (ejemplo conceptual)
#    Policy 1: Corporate Laptop + Compliant → Full Access to Internal Apps
#    Policy 2: BYOD + Compliant → Limited Access (Web Apps only)
#    Policy 3: Non-Compliant → Quarantine (remediation portal only)
#    Policy 4: Unknown Device → Deny All
```

### 8.5 FortiClient EMS — Posture Check

```bash
# Configurar perfiles de postura en FortiClient EMS
# Estos se sincronizan con FortiSASE para decisiones ZTNA

# Perfil de postura corporativo:
# - OS: Windows 10/11 (versión mínima 22H2) o macOS 13+
# - Antivirus: FortiClient activo y actualizado
# - Firewall: Habilitado
# - Disk Encryption: BitLocker/FileVault activo
# - VPN: No conectado a VPN personal
# - Certificado: Certificado de cliente válido
# - Dominio: Dispositivo unido a dominio AD

# Perfil de postura BYOD:
# - OS: Windows 10/11, macOS 12+, iOS 16+, Android 12+
# - Antivirus: Cualquier AV con firmas actualizadas
# - Firewall: Habilitado
# - Certificado: Certificado de cliente válido
```

### 8.6 Integración ZTNA + SD-WAN

```bash
# Para branch offices: SD-WAN + ZTNA integrado
# El FortiGate en la branch conecta vía SD-WAN a FortiSASE
# y aplica políticas ZTNA para el tráfico de usuarios

config system sdwan
    config members
        edit 10
            set interface "FSASE-Connector"
            set zone "virtual-wan-link"
            set priority 10
            set comments "FortiSASE Cloud Connector"
        next
    end
    config service
        edit 10
            set name "ZTNA-Traffic"
            set mode priority
            set src "VLAN30-Corporate"
            set dst "FSASE-Applications"
            set priority-members 10
            set comments "Tráfico ZTNA hacia FortiSASE"
        next
    end
end
```

---

## 9. Análisis de Tráfico y NetFlow

### 9.1 Configuración de NetFlow / sFlow

```bash
# Habilitar NetFlow en FortiGate
config system netflow
    set collector-ip 10.0.10.8
    set collector-port 2055
    set source-ip 10.0.10.1
    set active-flow-timeout 1
    set inactive-flow-timeout 15
end

# Habilitar NetFlow por interfaz
config system interface
    edit "port1"
        set netflow-sampler both
    next
    edit "port4"
        set netflow-sampler both
    next
end

# Habilitar NetFlow por política de firewall
config firewall policy
    edit 2
        set name "Internal-to-Internet"
        set netflow-sampler both
        set logtraffic all
    next
end
```

### 9.2 Análisis de Tráfico con FortiAnalyzer

```bash
# Configurar FortiAnalyzer como destino de logs
config log fortianalyzer setting
    set status enable
    set server "10.0.10.6"
    set reliable enable
    set upload-option realtime
    set enc-algorithm high
    set upload-day Monday
    set upload-time 02:00
end

# Configurar filtros de log
config log fortianalyzer filter
    set severity information
    set forward-traffic enable
    set local-traffic enable
    set multicast-traffic enable
    set sniffer-traffic enable
    set anomaly enable
    set voip enable
    set gtp enable
    set free-style
        edit 1
            set category 3               # Traffic
            set filter "srcip 10.0.30.0/24"
            set filter-type inclusive
        next
    end
end
```

### 9.3 Captura de Paquetes (Packet Capture)

```bash
# Captura en tiempo real con sniffer
diagnose sniffer packet any "host 10.0.30.50" 4
diagnose sniffer packet "port1" "port 443" 4 l
diagnose sniffer packet "port4" "host 10.0.20.10 and port 3306" 4 l

# Captura con buffer (guardar en archivo)
diagnose sniffer packet any "host 10.0.30.50" 4 l /tmp/capture.pcap

# Captura de tráfico VPN
diagnose sniffer packet "VPN-SiteA-to-SiteB" "host 10.1.0.10" 4

# Captura de tráfico SSL-VPN
diagnose sniffer packet "ssl.root" "port 10443" 4

# Captura de tráfico SD-WAN
diagnose sniffer packet "virtual-wan-link" "host 8.8.8.8" 4

# Análisis de buffer
diagnose sniffer packet any "" 4 100    # 100 paquetes
diagnose sniffer packet any "" 4 1000 l # 1000 paquetes con detalle
```

### 9.4 Análisis de Tráfico con CLI

```bash
# Ver sesiones activas
diagnose sys session list
diagnose sys session stat
diagnose sys session clear

# Filtrar sesiones por criterio
diagnose sys session filter src 10.0.30.50
diagnose sys session filter dst 8.8.8.8
diagnose sys session filter proto 6       # TCP
diagnose sys session filter dport 443
diagnose sys session list

# Ver estadísticas de tráfico
diagnose netlink interface list
diagnose netlink brctl list
diagnose hardware deviceinfo nic port1

# Ver tabla de rutas
get router info routing-table all
get router info routing-table details 10.0.0.0/8
get router info bgp neighbors
get router info ospf database

# Ver estadísticas de firewall
diagnose firewall policy list
diagnose firewall policy statistics
diagnose firewall shaper traffic-shaper list
```

### 9.5 Detección de Anomalías de Tráfico

```bash
# Monitoreo de bandwidth por interfaz
diagnose netlink traffic-stat list

# Detectar conexiones sospechosas
# Buscar conexiones a puertos inusuales
diagnose sys session filter dport 4444    # Metasploit default
diagnose sys session list

diagnose sys session filter dport 5555    # Posible C2
diagnose sys.session list

# Detectar escaneo de puertos
diagnose sys session filter state syn-sent
diagnose sys session list

# Detectar transferencias grandes (posible exfiltración)
diagnose sys session filter bytes > 104857600  # > 100MB
diagnose sys session list

# Ver conexiones por IP de origen (detectar beaconing)
diagnose sys session filter src 10.0.30.50
diagnose sys session list
diagnose sys session clear
```

---

## 10. Monitoreo de Red y SIEM

### 10.1 Stack de Monitoreo BRIDA

| Componente | Producto | Función |
|------------|----------|---------|
| **Firewall Logs** | FortiGate → FortiAnalyzer | Logs de tráfico, UTM, VPN |
| **SIEM** | FortiAnalyzer + Syslog | Correlación, alertas, dashboards |
| **SOAR** | FortiSOAR | Orchestración y respuesta automatizada |
| **NMS** | SNMP + FortiMonitor | Monitoreo de disponibilidad y rendimiento |
| **EDR** | FortiClient EMS | Postura de endpoints, ZTNA tags |
| **Cloud** | FortiSASE Portal | Monitoreo de tráfico cloud/ZTNA |
| **CDN/WAF** | Cloudflare Dashboard | Monitoreo de ataques web, DDoS |

### 10.2 Configuración de SNMP

```bash
# Configurar SNMPv3 (no usar v1/v2)
config system snmp sysinfo
    set status enable
    set contact "noc@brida.mx"
    set location "DC-Primary [Site]"
    set engine-id "FW-[SITE]-01"
end

config system snmp user
    edit "snmp-monitor"
        set auth-proto sha256
        set auth-pwd ${SNMP_AUTH_PWD}
        set priv-proto aes256
        set priv-pwd ${SNMP_PRIV_PWD}
        set queries enable
        set trap-threshold-cpu 80
        set trap-threshold-memory 85
        set trap-threshold-log 90
        set security-level auth-priv
    next
end

config system snmp community
    # Eliminar todas las comunidades v1/v2
end
```

### 10.3 Alertas y Thresholds

```bash
# Configurar alertas por email
config system email-server
    set server "smtp.office365.com"
    set port 587
    set security starttls
    set username "noc@brida.mx"
    set password ${SMTP_PASSWORD}
end

config alertemail setting
    set username "noc@brida.mx"
    set mailto1 "soc@brida.mx"
    set mailto2 "noc-manager@brida.mx"
    set filter-mode category
    set severity filter
    set CPU filter
    set memory filter
    set disk filter
    set session filter
    set IPsec filter
    set SSL-VPN filter
    set admin-login filter
    set HA filter
    set license filter
    set intrusion filter
    set anomaly filter
    set virus filter
    set ssh filter
    set violation filter
    set vpn-event filter
    set wan-opt filter
end
```

### 10.4 Dashboards Recomendados (FortiAnalyzer)

| Dashboard | Métricas Clave |
|-----------|---------------|
| **Security Overview** | Threats blocked, top attacks, severity distribution |
| **Traffic Analysis** | Top talkers, bandwidth utilization, app usage |
| **VPN Status** | Active tunnels, SSL-VPN users, VPN bandwidth |
| **SD-WAN Performance** | SLA compliance, link utilization, failover events |
| **Threat Map** | GeoIP attack sources, C2 communications, botnet activity |
| **Compliance** | PCI-DSS, ISO 27001 network controls status |

### 10.5 Integración con SIEM Externo

```bash
# Enviar logs a SIEM externo vía Syslog (CEF format)
config log syslogd setting
    set status enable
    set server "10.0.10.7"           # SIEM collector
    set port 514
    set facility local6
    set format cef                    # Common Event Format
    set mode udp                      # O TCP para reliability
    set csv disable
end

config log syslogd filter
    set severity information
    set forward-traffic enable
    set local-traffic enable
    set anomaly enable
    set virus enable
    set ssh enable
    set event enable
    set waf enable
    set sslvpn enable
    set vpn enable
end

# API REST para integración con SIEM/SOAR
# FortiGate API: https://<fgt-ip>/api/v2/
# FortiAnalyzer API: https://<faz-ip>/jsonrpc
# Ejemplo de consulta API:
# GET /api/v2/monitor/firewall/policy/
# GET /api/v2/monitor/vpn/ipsec/
# GET /api/v2/monitor/system/session-statistics/
```

---

## 11. Respuesta a Incidentes de Red

### 11.1 Playbook: Detección de Intrusión (IDS/IPS Alert)

```yaml
playbook: Network Intrusion Detection Response
severity: HIGH
mitre_attack:
  - T1046  # Network Service Scanning
  - T1210  # Exploitation of Remote Services
  - T1190  # Exploit Public-Facing Application

Fase 1 — Detección (0-5 min):
  1. Verificar alerta en FortiAnalyzer / SIEM
  2. Identificar: source IP, destination IP, signature ID, severity
  3. Clasificar: true positive / false positive / needs investigation
  4. Verificar contexto: ¿es un activo conocido? ¿es tráfico esperado?

Fase 2 — Análisis (5-30 min):
  1. Revisar logs de la IP origen en FortiAnalyzer
  2. Verificar si hay más alertas relacionadas (correlación)
  3. Analizar tráfico con packet capture:
     diagnose sniffer packet any "host <source_ip>" 4 l
  4. Verificar sesiones activas:
     diagnose sys session filter src <source_ip>
     diagnose sys session list
  5. Consultar threat intelligence (FortiGuard, VirusTotal, AbuseIPDB)
  6. Determinar alcance: ¿qué sistemas fueron afectados?

Fase 3 — Contención (30-60 min):
  1. Bloquear IP origen (si es externo):
     config firewall address
         edit "BLOCKED-<incident-id>"
             set type ipmask
             set subnet <source_ip>/32
             set color 1
         next
     end
     config firewall policy
         edit 0
             set name "INCIDENT-BLOCK-<id>"
             set srcintf "port1"
             set dstintf "any"
             set srcaddr "BLOCKED-<incident-id>"
             set dstaddr "all"
             set action deny
             set schedule "always"
             set service "ALL"
             set logtraffic all
         next
     end
  2. Si es interno: aislar endpoint afectado (desconectar puerto / VLAN quarantine)
  3. Bloquear signature específica si es false positive:
     config ips sensor
         edit "default"
             config entries
                 edit <signature-id>
                     set status disable
                 next
             end
         next
     end
  4. Notificar al equipo de seguridad y al cliente

Fase 4 — Erradicación (1-4 horas):
  1. Identificar vector de ataque y vulnerabilidad explotada
  2. Aplicar parches o mitigaciones
  3. Actualizar firmas IPS si es necesario
  4. Verificar que no hay persistencia (backdoors, C2)
  5. Escanear sistemas afectados con FortiClient

Fase 5 — Recuperación (4-24 horas):
  1. Restaurar servicios afectados
  2. Verificar integridad de sistemas
  3. Monitoreo intensivo por 72 horas
  4. Remover reglas de bloqueo temporales

Fase 6 — Lecciones Aprendidas (1-2 semanas):
  1. Documentar incidente en sistema de ticketing
  2. Actualizar playbooks si es necesario
  3. Mejorar reglas de detección
  4. Presentar reporte post-incidente
```

### 11.2 Playbook: Ataque DDoS

```yaml
playbook: DDoS Attack Response
severity: CRITICAL
mitre_attack:
  - T1498  # Network Denial of Service
  - T1499.004  # Endpoint DoS: Application or System Exploitation

Fase 1 — Detección (0-5 min):
  1. Verificar alertas de bandwidth / session count en FortiGate
  2. Identificar tipo de ataque: volumetric, protocol, application layer
  3. Verificar si Cloudflare está absorbiendo (para tráfico web)
  4. Comando diagnóstico:
     diagnose sys session stat
     diagnose netlink traffic-stat list
     get system performance status

Fase 2 — Activar Protección (5-15 min):
  1. Verificar que DoS policies están activas:
     diagnose firewall DoS-policy list
  2. Activar modo "Under Attack" en Cloudflare (si aplica)
  3. Contactar ISP para upstream filtering (blackhole / scrubbing)
  4. Habilitar rate limiting agresivo:
     config firewall DoS-policy
         edit 1
             config anomaly
                 edit "tcp.syn.flood"
                     set action block
                     set threshold 500    # Reducir temporalmente
                 next
             end
         next
     end
  5. Habilitar GeoIP blocking si el ataque es de regiones específicas

Fase 3 — Mitigación (15-60 min):
  1. Analizar patrones de ataque (source IPs, puertos, protocolos)
  2. Crear address groups dinamicos para bloquear fuentes
  3. Habilitar BGP Flowspec o RTBH si disponible
  4. Redirigir trafico a scrubbing center
  5. Monitorear efectividad de reglas

Fase 4 — Recuperacion (1-4 horas):
  1. Verificar servicios respondiendo normalmente
  2. Reducir gradualmente medidas restrictivas
  3. Monitoreo intensivo 48-72 horas

Fase 5 — Post-Incidente:
  1. Generar reporte
  2. Actualizar DoS policies
  3. Compartir IOCs con ISACs
```

### 11.3 Playbook: Exfiltracion de Datos (CRITICAL - T1048, T1567)

Fase 1 (0-10 min): Verificar alerta NetFlow/DLP, identificar src/dst/volume.
Fase 2 (10-60 min): Determinar tipo de datos, correlacionar con EDR.
Fase 3 (1-2 horas): Bloquear destino, aislar endpoint, revocar credenciales.
Fase 4: Eliminar malware, aplicar DLP restrictivo.

### 11.4 Playbook: Compromiso de VPN (HIGH - T1133, T1078)

Fase 1: Verificar login anomalo, diagnose vpn ssl list.
Fase 2: Identificar cuenta comprometida.
Fase 3: Deshabilitar cuenta, desconectar sesiones, bloquear IP.
Fase 4: Resetear credenciales.
Fase 5: Restaurar acceso, monitoreo 72h, considerar ZTNA.

### 11.5 Forense de Red

```bash
diagnose sniffer packet any "" 4 l /tmp/forensic.pcap
show full-configuration
diagnose sys session list > /tmp/sessions.txt
sha256sum /tmp/forensic.pcap
```

---

## 12. Integracion con Cloudflare

Arquitectura: Users -> Cloudflare (CDN/WAF/DDoS) -> FortiGate (NGFW/IPS)

```bash
config firewall addrgrp
    edit "Cloudflare-IPv4"
        set member "CF-173.245.48.0/20" "CF-103.21.244.0/22"
    next
end
config firewall policy
    edit 200
        set srcaddr "Cloudflare-IPv4"
        set dstaddr "DMZ-WebServers"
        set action accept
    next
    edit 201
        set srcaddr "all"
        set dstaddr "DMZ-WebServers"
        set action deny
    next
end
```

Headers: CF-Connecting-IP, CF-IPCountry, CF-Ray, CF-Threat-Score

---

## 13. Auditoria y Cumplimiento

PCI-DSS v4.0: 1.2.1, 1.3.1, 2.2.7, 11.4.1, 11.5.1
ISO 27001:2022: A.8.20, A.8.22, A.8.24, A.8.15

```bash
show full-configuration
diagnose firewall policy list
diagnose system session stat
get system performance status
```

---

## 14. Mapeo a Frameworks

### MITRE ATT&CK
| Tactica | Tecnicas | Contramedidas |
|---------|----------|---------------|
| Reconnaissance | T1595 | IPS, GeoIP blocking |
| Initial Access | T1190 | WAF, IPS, SSL inspection |
| C2 | T1071, T1572 | DNS filtering, IPS |
| Lateral Movement | T1021, T1210 | VLANs, ZTNA, IPS |
| Exfiltration | T1048, T1567 | DLP, NetFlow |
| Impact | T1498 | DoS policies, Cloudflare |

### NIST CSF 2.0
| Funcion | Subcategoria | Implementacion |
|---------|-------------|----------------|
| Protect | PR.AC-3 | SSL-VPN, ZTNA, FortiSASE |
| Protect | PR.AC-5 | VLANs, firewall, IPS |
| Protect | PR.DS-2 | IPsec, TLS 1.2+ |
| Detect | DE.AE-1 | NetFlow, FortiAnalyzer |
| Detect | DE.CM-1 | SNMP, syslog, SIEM |
| Respond | RS.AN-3 | Packet capture, analysis |
| Respond | RS.MI-1 | Dynamic rules, quarantine |
| Recover | RC.RP-1 | Backup, HA failover |

### MITRE D3FEND
| Ofensiva | Contramedida | Implementacion |
|----------|--------------|----------------|
| Scanning | D3-NIC | IPS signatures |
| Tunneling | D3-DNST | DNS filtering |
| Exfiltration | D3-DF | DLP policies |
| DoS | D3-NI | DoS policies, Cloudflare |
| Remote Access | D3-VPN, D3-IPSec | VPN hardening |
| Lateral Movement | D3-NI | VLANs, ZTNA |
| C2 | D3-DNSA | DNS filtering, IPS |
| Credential Theft | D3-MFA | MFA, certificates |
| Log Tampering | D3-LA, D3-SIEM | FortiAnalyzer, SIEM |
| Firmware Mod | D3-FR | Integrity checks |

---

## 15. Checklist Pre-Produccion

### 15.1 FortiGate
- [ ] Admin default deshabilitado, cuentas individuales, MFA
- [ ] Solo HTTPS/SSH, SSH solo con claves
- [ ] Firmware y FortiGuard actualizados
- [ ] TLS 1.2+, strong crypto
- [ ] Default deny, logging en todas las politicas
- [ ] Sin "ANY" innecesarios
- [ ] IPS/AV/Web Filter en todas las politicas
- [ ] IKEv2, AES-256+, PFS, MFA en SSL-VPN
- [ ] SD-WAN health checks, HA sincronizado
- [ ] FortiAnalyzer, syslog, alertas email
- [ ] FortiSASE conector, ZTNA tags, EMS sync
- [ ] Backup de configuracion

### 15.2 VLANs
- [ ] VLANs documentadas, subnets sin overlap
- [ ] Native VLAN cambiada, blackhole VLAN
- [ ] Guest/IoT aisladas, management aislada
- [ ] Inter-VLAN: deny by default
- [ ] Port security, DHCP snooping, DAI
- [ ] BPDU guard, storm control

### 15.3 IR Readiness
- [ ] Playbooks documentados
- [ ] Equipo con roles definidos
- [ ] Alertas IPS/VPN/DoS configuradas
- [ ] Correlacion SIEM activa
- [ ] VLAN cuarentena configurada
- [ ] Backup verificado, monitoreo 72h

---

## Referencias Rapidas

### Comandos CLI
get system status | get system performance status | diagnose sys session stat
diagnose sys session list | diagnose sniffer packet any "<f>" 4 l
diagnose firewall policy list | diagnose vpn ike gateway list
diagnose vpn tunnel list | diagnose vpn ssl list
diagnose sys sdwan member | diagnose ips session stat
get router info routing-table all | get system ha status

### Puertos Comunes
22/SSH, 53/DNS, 80/HTTP, 443/HTTPS, 500/IKE, 4500/NAT-T
514/Syslog, 1812/RADIUS, 3306/MySQL, 3389/RDP, 5432/PostgreSQL
8443/HTTPS-Alt, 10443/SSL-VPN

---
> BRIDA IT Services - Network Security Team - v2.0 - 2026-01-15 - Apache-2.0
> Uso interno. Adaptar a cada cliente. Probar en lab antes de produccion.
  2. Crear address groups dinámicos para bloquear fuent