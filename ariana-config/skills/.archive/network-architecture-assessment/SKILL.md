# Skill: Network Architecture Assessment

## Descripción
Metodología para evaluar la arquitectura de red de clientes enterprise, identificar gaps de seguridad y proponer mejoras con enfoque en Fortinet, segmentación y Zero Trust.

## Cuándo Usar
- Assessment inicial de un cliente nuevo
- Revisión periódica de seguridad de red
- Pre-propuesta de rediseño de infraestructura
- Post-incident review de arquitectura

## Metodología de Evaluación

### Fase 1: Descubrimiento de Red
1. **Diagrama de red actual** — Solicitar al cliente o crear durante assessment
   - Topología física y lógica
   - Puntos de conexión a Internet
   - Enlaces entre sucursales (MPLS, VPN, SD-WAN)
   - DMZ, servidores, servicios cloud
2. **Inventario de dispositivos de red**
   - Firewalls (marca, modelo, firmware)
   - Switches (managed/unmanaged, PoE)
   - Access Points (marca, estándar WiFi)
   - Routers de borde
   - Balanceadores de carga
3. **Segmentación actual**
   - VLANs configuradas
   - Subredes y rangos IP
   - Reglas de firewall inter-VLAN
   - Separación de redes (corporativa, invitados, IoT, POS)

### Fase 2: Análisis de Gaps
Evaluar contra estos criterios:

| Área | Bueno | Aceptable | Deficiente |
|---|---|---|---|
| **Perimetral** | FortiGate + IPS/IDS + SSL Inspection | Firewall básico sin inspección | Sin firewall o desactualizado |
| **Segmentación** | VLANs + microsegmentación | VLANs básicas | Red plana (sin segmentar) |
| **WiFi** | WPA3 + red invitados separada | WPA2 + SSID único | WPA abierto o sin separación |
| **VPN** | FortiSASE/ZTNA + MFA | VPN IPsec básica | Sin VPN o PPTP |
| **Monitoreo** | SIEM + alertas + logging centralizado | Logs locales | Sin logging |
| **Redundancia** | Dual ISP + HA firewall | Single ISP + backup | Punto único de falla |
| **DNS** | DNS filtering (FortiGuard) | DNS público (8.8.8.8) | Sin control DNS |
| **SD-WAN** | FortiGate SD-WAN activo | MPLS dedicado | Conexiones sin optimizar |

### Fase 3: Arquitectura Objetivo (Propuesta BRIDA)

#### Perimetral
```
[Internet] → [FortiGate NGFW] → [DMZ] → [Core Switch] → [VLANs]
                ↓
           [IPS/IDS]
           [SSL Inspection]
           [FortiGuard Filtering]
           [SD-WAN]
```

#### Segmentación Recomendada
| VLAN | Propósito | Nivel de Seguridad |
|---|---|---|
| VLAN 10 | Administración/IT | 🔒 Alto — Solo IT |
| VLAN 20 | Corporativa (empleados) | 🔒 Alto — Autenticada |
| VLAN 30 | Servidores/DMZ | 🔒 Alto — Restringida |
| VLAN 40 | POS/Pagos | 🔒🔒 Crítico — PCI-DSS |
| VLAN 50 | Invitados/Clientes | 🔓 Bajo — Internet solo |
| VLAN 60 | IoT/Cámaras | 🔒 Alto — Aislada |
| VLAN 70 | VoIP/Telefonía | 🔒 Medio — QoS prioritario |

#### Conectividad Sucursales
- **Primaria:** FortiGate SD-WAN con balanceo de enlaces
- **Secundaria:** VPN IPsec site-to-site entre FortiGates
- **Acceso remoto:** FortiSASE (Zero Trust Network Access) + MFA

### Fase 4: Entregables
1. **Diagrama de red actual** (estado AS-IS)
2. **Diagrama de red propuesto** (estado TO-BE)
3. **Matriz de gaps** (actual vs deseado)
4. **Recomendaciones priorizadas** (Quick Wins → Corto plazo → Largo plazo)
5. **Estimación de inversión** (equipos, licencias, servicios)

## Herramientas de Evaluación
- **Nmap** — Escaneo de red y descubrimiento de hosts
- **Wireshark** — Análisis de tráfico
- **NetFlow/sFlow** — Análisis de flujos de red
- **FortiAnalyzer** — Logging y análisis Fortinet
- **draw.io / diagrams.net** — Diagramas de red

## Checklist de Assessment
- [ ] Diagrama de red documentado
- [ ] Inventario de dispositivos de red completo
- [ ] VLANs identificadas y documentadas
- [ ] Reglas de firewall revisadas
- [ ] Configuración WiFi evaluada
- [ ] VPN configurada y funcionando
- [ ] Redundancia de enlaces verificada
- [ ] DNS filtering activo
- [ ] Monitoreo/logging centralizado
- [ ] Acceso remoto seguro (ZTNA/MFA)
