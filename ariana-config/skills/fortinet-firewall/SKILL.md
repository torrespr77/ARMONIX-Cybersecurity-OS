---
name: fortinet-firewall
description: Fortinet Firewall
category: cybersecurity
---# Skill: Fortinet Firewall Configuration & Hardening

## Descripción
Guía de configuración y hardening de firewalls Fortinet (FortiGate, FortiSASE) para clientes de BRIDA IT Services, incluyendo mejores prácticas de seguridad perimetral, VPN, SD-WAN y Zero Trust.

## Cuándo Usar
- Implementación inicial de FortiGate en un cliente
- Hardening de configuración existente
- Auditoría de reglas de firewall
- Configuración de VPN site-to-site o remote access
- Implementación de FortiSASE (Zero Trust)
- Actualización de firmware y security profiles

## Modelos Fortinet Típicos por Tipo de Cliente

| Cliente | Modelo Recomendado | Throughput | Features |
|---|---|---|---|
| Sucursal pequeña (< 50 users) | FortiGate 40F/60F | 1-2 Gbps | NGFW, VPN, SD-WAN |
| Sucursal mediana (50-200 users) | FortiGate 80F/100F | 3-5 Gbps | + IPS, SSL Inspection |
| Corporativo (200-1000 users) | FortiGate 200F/400F | 10-20 Gbps | + HA, Advanced Threat |
| Enterprise (1000+ users) | FortiGate 600F/1800F | 40+ Gbps | + Full UTM, Sandboxing |

## Configuración Inicial (Out of Box)

### Paso 1: Acceso y Credenciales
1. Conectar por consola o puerto management
2. Cambiar contraseña de admin inmediatamente
3. Crear cuentas de administrador individuales (no compartir admin)
4. Configurar MFA para acceso admin (FortiToken)
5. Restringir acceso admin a IPs específicas

### Paso 2: Interfaces y Red
```
config system interface
    edit "wan1"
        set mode dhcp
        set allowaccess ping https ssh
        set role wan
    next
    edit "internal"
        set mode static
        set ip 192.168.1.1/24
        set allowaccess ping https ssh http
        set role lan
    next
    edit "dmz"
        set mode static
        set ip 10.0.0.1/24
        set allowaccess ping
        set role dmz
    next
end
```

### Paso 3: DNS
```
config system dns
    set primary 8.8.8.8
    set secondary 1.1.1.1
    set protocol cleartext/dns-over-tls
end
```

### Paso 4: NTP
```
config system ntp
    set ntpsync enable
    set syncinterval 60
    config ntpserver
        edit 1
            set server "time.google.com"
        next
    end
end
```

## Security Profiles (Perfiles de Seguridad)

### Antivirus
```
config antivirus profile
    edit "AV-BRIDA-Standard"
        set av-block-log enable
        set av-virus-log enable
        config http
            set av-scan enable
            set quarantine enable
        end
        config smtp
            set av-scan enable
            set quarantine enable
        end
    next
end
```

### IPS (Intrusion Prevention)
```
config ips sensor
    edit "IPS-BRIDA-Standard"
        config entries
            edit 1
                set severity high medium
                set status enable
                set log enable
                set action block
            next
        end
    next
end
```

### Web Filter
```
config webfilter profile
    edit "WF-BRIDA-Standard"
        set web-filter-referer-log enable
        config web
            set urlfilter-table <id>
        end
    next
end
```

### SSL Inspection
```
config firewall ssl-ssh-profile
    edit "SSL-BRIDA-Inspect"
        config https
            set ports 443
            set status deep-inspection
            set client-certificate enable
        end
    next
end
```

## Reglas de Firewall — Mejores Prácticas

### Orden de Reglas (de arriba a abajo)
1. **Anti-spoofing** — Bloquear IPs falsificadas
2. **Administración** — Acceso admin restringido
3. **VPN** — Tráfico VPN permitido
4. **Servicios específicos** — Por aplicación/protocolo
5. **General outbound** — Internet para usuarios
6. **DMZ** — Reglas de DMZ
7. **Deny all** — Denegar todo lo demás (implícito, pero documentar)

### Reglas Recomendadas para Grupo Pepe
```
# Regla 1: Anti-spoofing
Source: Invalid IPs | Dest: Any | Action: DENY | Log: Yes

# Regla 2: Admin access (solo desde IT VLAN)
Source: 192.168.10.0/24 | Dest: FortiGate | Service: HTTPS,SSH | Action: ACCEPT

# Regla 3: VPN remote access
Source: VPN Pool | Dest: Internal Networks | Action: ACCEPT | UTM: Full

# Regla 4: Corporate to Internet
Source: 192.168.20.0/24 | Dest: Any | Service: HTTP,HTTPS,DNS | Action: ACCEPT | UTM: AV+WF+IPS

# Regla 5: POS network (PCI-DSS)
Source: 192.168.40.0/24 | Dest: Payment Gateway IPs | Service: HTTPS | Action: ACCEPT | UTM: Full
# Deny POS to general internet

# Regla 6: Guest network (internet only)
Source: 192.168.50.0/24 | Dest: Any | Service: HTTP,HTTPS,DNS | Action: ACCEPT | UTM: AV+WF
# Deny guest to internal networks

# Regla 7: IoT/Cameras (isolated)
Source: 192.168.60.0/24 | Dest: NTP,DNS only | Action: ACCEPT
# Deny IoT to everything else

# Regla 8: Deny inter-VLAN (default deny)
Source: Internal VLANs | Dest: Other Internal VLANs | Action: DENY | Log: Yes
```

## VPN Configuration

### Site-to-Site (entre sucursales)
```
config vpn ipsec phase1-interface
    edit "VPN-Sucursal01"
        set interface "wan1"
        set ike-version 2
        set peertype any
        set net-device disable
        set proposal aes256-sha256
        set remote-gw <IP_SUCURSAL>
        set psksecret <STRONG_PSK>
    next
end

config vpn ipsec phase2-interface
    edit "VPN-Sucursal01-p2"
        set phase1name "VPN-Sucursal01"
        set proposal aes256-sha256
        set src-subnet 192.168.1.0/24
        set dst-subnet 192.168.X.0/24
    next
end
```

### Remote Access (SSL-VPN con MFA)
```
config vpn ssl settings
    set servercert "Fortinet_Factory"
    set tunnel-ip-pools "SSLVPN_TUNNEL_ADDR1"
    set source-interface "wan1"
    set source-address "all"
    set default-portal "full-access"
    set authentication-rule
        edit 1
            set groups "VPN-Users"
            set portal "full-access"
        next
    end
end
```

## FortiSASE (Zero Trust Network Access)
Para clientes que necesitan acceso remoto moderno:
- Reemplaza VPN tradicional con ZTNA
- Verifica identidad + dispositivo + contexto antes de cada acceso
- Integra con FortiGate on-premises
- Ideal para empleados remotos y sucursales

## Hardening Checklist
- [ ] Contraseña admin cambiada y MFA activado
- [ ] Cuentas individuales de administrador
- [ ] Acceso admin restringido por IP
- [ ] Firmware actualizado a última versión estable
- [ ] Security profiles activos (AV, IPS, Web Filter, SSL Inspection)
- [ ] Reglas de firewall documentadas y ordenadas
- [ ] Logging habilitado (FortiAnalyzer o syslog)
- [ ] HA configurado (si aplica)
- [ ] VPN con IKEv2 y cifrado fuerte (AES-256)
- [ ] FortiGuard actualizado
- [ ] Unnecessary services deshabilitados
- [ ] SNMP v3 (no v1/v2)
- [ ] SSH key-based auth (no solo password)
- [ ] Backup de configuración programado
- [ ] Security audit trimestral de reglas

## Comandos de Diagnóstico Útiles
```bash
# Ver sesiones activas
diagnose sys session list

# Ver tráfico en tiempo real
diagnose sniffer packet any "host <IP>" 4

# Ver reglas de firewall hit count
diagnose firewall policy list

# Ver estado VPN
diagnose vpn ike gateway list
diagnose vpn tunnel list

# Ver logs en tiempo real
diagnose debug application -1
diagnose debug enable

# Test de conectividad
execute ping <IP>
execute traceroute <IP>

# Ver estadísticas de interfaz
diagnose hardware deviceinfo nic <interface>
```
