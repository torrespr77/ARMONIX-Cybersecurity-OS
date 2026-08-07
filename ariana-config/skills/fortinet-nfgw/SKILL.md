---
name: fortinet-nfgw
description: Fortinet Nfgw
category: cybersecurity
---# Skill: Fortinet NGFW — FortiGate & FortiSASE

## Descripción
Configuración, hardening y operación de firewalls Fortinet FortiGate (on-premises) y FortiSASE (cloud/Zero Trust) para clientes de BRIDA IT Services.

## Productos Fortinet en el Stack BRIDA

### FortiGate (NGFW On-Premises)
- **Función:** Firewall de próxima generación, IPS/IDS, VPN, filtrado web, antivirus de gateway
- **Modelos típicos para clientes medianos:** FortiGate 60F, 80F, 100F, 200F
- **Ubicación:** Corporativo del cliente, datacenter local

### FortiSASE (Zero Trust Network Access)
- **Función:** Acceso seguro a la nube, SD-WAN, ZTNA, CASB, SWG
- **Uso:** Conexión segura de sucursales, trabajadores remotos, acceso a AWS
- **Modelo:** Cloud-based (suscripción)

### FortiManager
- **Función:** Gestión centralizada de múltiples FortiGate
- **Uso:** Ideal para Grupo Pepe con 190+ sucursales

### FortiAnalyzer
- **Función:** Logging, reporting, SIEM básico
- **Uso:** Centralización de logs para compliance y forenses

---

## Configuración Inicial FortiGate

### Paso 1: Acceso Inicial
```
# Conexión por consola (serial) o web (https://192.168.1.99)
# Usuario por defecto: admin (sin contraseña)
# Cambiar contraseña inmediatamente
```

### Paso 2: Hardening Básico
```
# Cambiar puerto de administración
config system global
    set admin-port 8443
    set admin-sport 8443
    set admin-ssh-port 8022
end

# Deshabilitar acceso HTTP
config system global
    set admin-https-redirect enable
end

# Habilitar solo HTTPS y SSH para administración
config system interface
    edit "port1"
        set allowaccess ping https ssh
    next
end

# Configurar política de contraseñas
config system password-policy
    set status enable
    set minimum-length 12
    set require-uppercase enable
    set require-lowercase enable
    set require-numeric enable
    set require-special-character enable
    set expire 90
end

# Habilitar 2FA para administradores
config user admin
    edit "admin"
        set two-factor fortitoken
    next
end
```

### Paso 3: Configurar Interfaces
```
# WAN (Internet)
config system interface
    edit "wan1"
        set mode dhcp
        set allowaccess ping
        set role wan
        set detectprotocol https
    next
end

# LAN (Red interna)
config system interface
    edit "lan1"
        set mode static
        set ip 10.0.1.1/24
        set allowaccess ping https ssh
        set role lan
    next
end

# DMZ (Servidores)
config system interface
    edit "dmz1"
        set mode static
        set ip 172.16.0.1/24
        set allowaccess ping
        set role dmz
    next
end
```

### Paso 4: Políticas de Firewall
```
# Política LAN → WAN (permitir navegación)
config firewall policy
    edit 1
        set name "LAN-to-WAN"
        set srcintf "lan1"
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
        set logtraffic all
    next
end

# Política DMZ → WAN (servidores)
config firewall policy
    edit 2
        set name "DMZ-to-WAN"
        set srcintf "dmz1"
        set dstintf "wan1"
        set srcaddr "DMZ-Servers"
        set dstaddr "all"
        set action accept
        set schedule "always"
        set service "HTTP" "HTTPS"
        set utm-status enable
        set ssl-ssh-profile "deep-inspection"
        set logtraffic all
    next
end

# Política WAN → DMZ (acceso público a web)
config firewall policy
    edit 3
        set name "WAN-to-DMZ-Web"
        set srcintf "wan1"
        set dstintf "dmz1"
        set srcaddr "all"
        set dstaddr "Web-Server-VIP"
        set action accept
        set schedule "always"
        set service "HTTP" "HTTPS"
        set utm-status enable
        set ssl-ssh-profile "deep-inspection"
        set av-profile "default"
        set ips-sensor "default"
        set logtraffic all
    next
end

# Denegar todo lo demás (implícito, pero explícito para logging)
config firewall policy
    edit 999
        set name "Deny-All"
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

### Paso 5: VPN IPsec (Sucursales ↔ Corporativo)
```
# Fase 1: Propuesta IKE
config vpn ipsec phase1-interface
    edit "VPN-Sucursal-001"
        set interface "wan1"
        set ike-version 2
        set peertype any
        set net-device disable
        set proposal aes256-sha256
        set dpd on-idle
        set dhgrp 14
        set pskkey "CLAVE_COMPARTIDA_SEGURA_AQUI"
        set remote-gw 203.0.113.50
    next
end

# Fase 2: Selector de tráfico
config vpn ipsec phase2-interface
    edit "VPN-Sucursal-001-P2"
        set phase1name "VPN-Sucursal-001"
        set proposal aes256-sha256
        set dhgrp 14
        set src-subnet 10.0.1.0/24
        set dst-subnet 10.10.1.0/24
    next
end

# Ruta estática para la sucursal
config router static
    edit 100
        set device "VPN-Sucursal-001"
        set dst 10.10.1.0/24
    next
end
```

### Paso 6: VPN SSL (Acceso Remoto)
```
# Configurar portal VPN SSL
config vpn ssl settings
    set servercert "Fortinet_Factory"
    set tunnel-ip-pools "SSLVPN_TUNNEL_ADDR1"
    set source-interface "wan1"
    set source-address "all"
    set default-portal "full-access"
    set port 10443
end

# Política para usuarios VPN
config firewall policy
    edit 50
        set name "SSLVPN-to-LAN"
        set srcintf "ssl.root"
        set dstintf "lan1"
        set srcaddr "SSLVPN_TUNNEL_ADDR1"
        set dstaddr "LAN-Subnet"
        set action accept
        set schedule "always"
        set service "ALL"
        set utm-status enable
        set logtraffic all
    next
end
```

---

## Hardening Checklist

### Seguridad del Dispositivo
- [ ] Cambiar contraseña por defecto de admin
- [ ] Crear cuentas individuales (no compartir admin)
- [ ] Habilitar 2FA/MFA para administradores
- [ ] Cambiar puertos de administración (no 443/22)
- [ ] Restringir acceso de administración a IPs específicas
- [ ] Deshabilitar HTTP, Telnet, SNMPv1/v2
- [ ] Habilitar solo HTTPS y SSH
- [ ] Configurar timeout de sesión (15 min)
- [ ] Habilitar bloqueo por intentos fallidos

### Políticas de Seguridad
- [ ] Principio de mínimo privilegio (denegar todo, permitir lo necesario)
- [ ] UTM habilitado en todas las políticas (AV, IPS, Web Filter, SSL Inspection)
- [ ] Logging habilitado en todas las políticas
- [ ] SSL Inspection para tráfico HTTPS saliente
- [ ] IPS con firmas actualizadas
- [ ] Web Filter con categorías apropiadas
- [ ] Antivirus de gateway habilitado

### Red
- [ ] Segmentación de red (VLANs: corporativa, invitados, servidores, IoT)
- [ ] DMZ para servidores públicos
- [ ] VPN para conexión de sucursales (IPsec)
- [ ] VPN SSL para acceso remoto
- [ ] SD-WAN si hay múltiples enlaces de Internet

### Monitoreo
- [ ] FortiAnalyzer para centralización de logs
- [ ] Alertas por email para eventos críticos
- [ ] Revisión semanal de logs
- [ ] Reportes mensuales de seguridad

---

## Comandos de Diagnóstico

```
# Ver estado del sistema
get system status

# Ver políticas activas
diagnose firewall policy list

# Ver sesiones activas
diagnose sys session list

# Ver estado de VPN
diagnose vpn ike gateway list
diagnose vpn tunnel list

# Ver logs en tiempo real
diagnose debug application httpsd -1
diagnose debug enable

# Ver estadísticas de interfaz
diagnose hardware deviceinfo nic

# Ver uso de CPU/RAM
get system performance status

# Ver tabla de rutings
get router info routing-table all

# Captura de paquetes
diagnose sniffer packet any "host 10.0.1.100" 4

# Ver estado de UTM
diagnose ips session list
diagnose webfilter urlfilter list
```

---

## FortiSASE (Zero Trust)

### Configuración para Clientes BRIDA
1. **Registrar tenant** en FortiSASE (https://fortisase.fortinet.com)
2. **Configurar endpoints:** Instalar FortiClient en estaciones de trabajo
3. **Definir políticas ZTNA:** Acceso basado en identidad, no en red
4. **Configurar SD-WAN:** Conexión de sucursales vía internet
5. **Habilitar CASB:** Control de aplicaciones SaaS (Google Workspace, etc.)
6. **Habilitar SWG:** Web filtering cloud-based

### Políticas ZTNA Típicas
| Usuario | Aplicación | Acción |
|---|---|---|
| Admins IT | Todas las internas | Permitir |
| Empleados | Google Workspace, ERP | Permitir |
| Invitados | Internet solo | Permitir |
| Cualquier | Torrents, redes sociales | Bloquear |

---

## Referencias
- Fortinet Documentation: https://docs.fortinet.com
- FortiGate Hardening Guide: https://docs.fortinet.com/document/fortigate/latest/hardening-guide
- NIST SP 800-41 (Firewall Policy): https://csrc.nist.gov/publications/detail/sp/800-41/rev-1/final
