---
name: fortinet-network-security
description: Fortinet Network Security
category: cybersecurity
---# Skill: Network Security Architecture — Fortinet

## Descripción
Diseño e implementación de arquitectura de seguridad de red con soluciones Fortinet para clientes de BRIDA IT Services.

## Stack Fortinet
- **FortiGate** — NGFW (Next-Generation Firewall)
- **FortiSASE** — Secure Access Service Edge (Zero Trust)
- **FortiSwitch** — Switches de red gestionados
- **FortiAP** — Access Points WiFi gestionados
- **FortiAnalyzer** — Logging, reporting y SIEM
- **FortiManager** — Gestión centralizada de dispositivos Fortinet
- **FortiClient** — Endpoint con VPN ZTNA
- **FortiEDR** — Endpoint Detection and Response
- **FortiMail** — Seguridad de correo
- **FortiWeb** — WAF (Web Application Firewall)

## Arquitectura de Seguridad Perimetral

### Modelo de Capas para Clientes BRIDA

```
                    ┌─────────────────────────────────┐
                    │           INTERNET               │
                    └──────────────┬──────────────────┘
                                   │
                    ┌──────────────▼──────────────────┐
                    │     CLOUDFLARE (CDN/WAF/DDoS)   │
                    └──────────────┬──────────────────┘
                                   │
                    ┌──────────────▼──────────────────┐
                    │      FORTIGATE NGFW (HA)         │
                    │  ┌─────────────────────────────┐ │
                    │  │ IPS/IDS | SSL Inspection    │ │
                    │  │ Application Control | AV    │ │
                    │  │ Web Filter | DNS Filter     │ │
                    │  └─────────────────────────────┘ │
                    └──────────────┬──────────────────┘
                                   │
              ┌────────────────────┼────────────────────┐
              │                    │                     │
    ┌─────────▼────────┐ ┌────────▼─────────┐ ┌────────▼─────────┐
    │   VLAN CORPORATIVO│ │  VLAN SERVIDORES │ │   VLAN INVITADOS │
    │   (Usuarios)      │ │  (Datacenter)    │ │   (WiFi Guest)   │
    └──────────────────┘ └──────────────────┘ └──────────────────┘
              │                    │                     │
    ┌─────────▼────────┐ ┌────────▼─────────┐ ┌────────▼─────────┐
    │  FORTISWITCH      │ │  FORTISWITCH     │ │  FORTIAP         │
    │  (Acceso)         │ │  (Servidores)    │ │  (WiFi)          │
    └──────────────────┘ └──────────────────┘ └──────────────────┘
```

### Para Sucursales (SD-WAN)
```
    ┌──────────┐     ┌──────────┐     ┌──────────┐
    │ Sucursal │     │ Sucursal │     │ Sucursal │
    │ FortiGate│     │ FortiGate│     │ FortiGate│
    │  60F     │     │  60F     │     │  60F     │
    └────┬─────┘     └────┬─────┘     └────┬─────┘
         │                │                │
         └────────────────┼────────────────┘
                          │
                    SD-WAN Overlay
                    (IPSec VPN Mesh)
                          │
                    ┌─────▼─────┐
                    │ CORPORATIVO│
                    │ FortiGate  │
                    │  100F/200F │
                    └───────────┘
```

## Configuración Base de FortiGate

### 1. Hardening Inicial
```
# Cambiar puerto de administración
config system global
    set admin-port 8443
    set admin-ssh-port 2222
    set admin-https-redirect enable
end

# Deshabilitar servicios innecesarios
config system interface
    edit "port1"
        set allowaccess ping https ssh
    next
end

# Habilitar NTP
config system ntp
    set ntpsync enable
    config ntpserver
        edit 1
            set server "time.google.com"
        next
    end
end
```

### 2. Políticas de Firewall (Principio de Menor Privilegio)
```
# Política: Internet para usuarios
config firewall policy
    edit 1
        set name "LAN-to-Internet"
        set srcintf "vlan-corporativo"
        set dstintf "wan1"
        set srcaddr "all"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set webfilter-profile "default"
        set ssl-ssh-profile "certificate-inspection"
        set av-profile "default"
        set ips-sensor "default"
        set application-list "default"
        set logtraffic all
    next
end

# Política: Denegar todo lo demás (default deny)
config firewall policy
    edit 999
        set name "Default-Deny"
        set srcintf "any"
        set dstintf "any"
        set srcaddr "all"
        set dstaddr "all"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
    next
end
```

### 3. SSL Inspection (crítico para detectar amenazas)
```
config firewall ssl-ssh-profile
    edit "deep-inspection"
        set ssl-exemptions-log-log enable
        config https
            set ports 443
            set status deep-inspection
            set client-certificate-bypass enable
        end
    next
end
```

### 4. IPS (Intrusion Prevention)
```
config ips sensor
    edit "brida-ips"
        config entries
            edit 1
                set severity high medium
                set status enable
                set log-packet enable
            next
        end
    next
end
```

### 5. SD-WAN para Sucursales
```
config system sdwan
    set status enable
    config members
        edit 1
            set interface "wan1"
            set zone "virtual-wan-link"
        next
        edit 2
            set interface "wan2"
            set zone "virtual-wan-link"
        next
    end
    config health-check
        edit "Google"
            set server "8.8.8.8"
            set members 1 2
            config sla
                edit 1
                    set latency-threshold 100
                    set jitter-threshold 50
                    set packetloss-threshold 5
                next
            end
        next
    end
end
```

## Zero Trust con FortiSASE

### Concepto
- **Nunca confiar, siempre verificar** — cada acceso se autentica y autoriza
- **Microsegmentación** — cada usuario/solo accede a lo que necesita
- **ZTNA (Zero Trust Network Access)** — reemplaza VPN tradicional

### Implementación para Grupo Pepe
1. **FortiClient** en cada endpoint (laptops, servidores)
2. **FortiSASE** como servicio cloud
3. **Políticas de acceso** basadas en:
   - Identidad del usuario (integración con AD/LDAP)
   - Health del endpoint (¿tiene AV? ¿está parcheado?)
   - Ubicación (¿está en la red corporativa o remoto?)
   - Aplicación (¿qué app quiere acceder?)

## Modelos Recomendados por Tamaño

| Cliente | FortiGate | FortiSwitch | FortiAP | Notas |
|---|---|---|---|---|
| Corporativo Grande (>500 users) | 200F | 448F | 431F | HA pair, FortiManager |
| Corporativo Medio (100-500) | 100F | 248E | 231F | HA opcional |
| Sucursal Grande (>50 users) | 80F | 124E | 231F | SD-WAN |
| Sucursal Pequeña (<50 users) | 60F | 108E | 221E | SD-WAN básico |

## Para Grupo Pepe Específicamente
- **Corporativo (Periférico):** FortiGate 100F + FortiSwitch 248E + FortiAP 231F
- **Sucursales (190+):** FortiGate 60F por sucursal con SD-WAN
- **E-commerce:** FortiWeb como WAF adicional a Cloudflare
- **FortiAnalyzer:** Centralizado en corporativo para logging de todas las sedes
- **FortiSASE:** Para acceso remoto de ejecutivos y helpdesk
