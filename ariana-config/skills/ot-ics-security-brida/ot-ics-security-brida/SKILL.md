---
name: ot-ics-security-brida
description: 'OT/ICS (Operational Technology / Industrial Control Systems) security for BRIDA IT Services clients with manufacturing, industrial, or critical infrastructure environments. Covers SCADA security, Modbus/DNP3 protocol analysis, IEC 62443, Purdue model, and IT/OT convergence. Activates for: OT security, SCADA, ICS, industrial security, Modbus, DNP3, IEC 62443, historian security.'
domain: cybersecurity
subdomain: ot-ics-security
tags:
- OT-security
- ICS
- SCADA
- industrial-security
- Modbus
- DNP3
- IEC-62443
version: 1.0.0
author: BRIDA IT Services (adapted from mukul975/Anthropic-Cybersecurity-Skills)
license: Apache-2.0
nist_csf:
- ID.AM-03
- PR.AC-05
- PR.DS-03
- DE.CM-01
mitre_attack:
- T0800
- T0801
- T0802
- T0803
- T0804
---

# OT/ICS Security — BRIDA IT Services

## Descripción
Seguridad de Tecnología Operativa (OT) y Sistemas de Control Industrial (ICS) para clientes de BRIDA IT Services con entornos de manufactura, industriales o infraestructura crítica. Cubre seguridad SCADA, protocolos Modbus/DNP3, IEC 62443, modelo Purdue y convergencia IT/OT.

## Cuándo Usar
- Evaluación de seguridad en plantas de producción o manufactura
- Diseño de segmentación IT/OT
- Cumplimiento IEC 62443 o NERC CIP
- Evaluación de sistemas SCADA/HMI
- Seguridad de protocolos industriales (Modbus, DNP3, OPC UA)

## Modelo Purdue (ISA-95) — Niveles

```
Nivel 5: Enterprise Network (ERP, email, internet)
  ↕ [DMZ - Industrial DMZ]
Nivel 4: Business Planning (MES, data warehouse)
  ↕ [DMZ]
Nivel 3.5: Industrial DMZ (jump servers, data diodes)
  ↕
Nivel 3: Site Operations (HMI, historian, SCADA server)
  ↕
Nivel 2: Area Supervisory (PLCs, RTUs, controllers)
  ↕
Nivel 1: Basic Control (sensors, actuators, drives)
  ↕
Nivel 0: Physical Process (motors, valves, pumps)
```

## Protocolos Industriales — Riesgos

### Modbus TCP (Puerto 5002)
- **Riesgo:** Sin autenticación, sin cifrado, sin integridad
- **Ataques:** Command injection, replay, man-in-the-middle
- **Detección:** Anomalías en Function Codes, registros fuera de rango
- **Mitigación:** Firewall OT, whitelisting de comandos, monitoreo de red

### DNP3 (Distributed Network Protocol)
- **Riesgo:** Autenticación débil (Secure Authentication v5 es mejorable)
- **Ataques:** Replay, spoofing, DoS
- **Detección:** Anomalías en Object Headers, secuencias inesperadas
- **Mitigación:** DNP3 Secure Authentication, segmentación de red

### OPC UA
- **Riesgo:** Configuración insegura, certificados autofirmados
- **Ataques:** Information disclosure, DoS
- **Detección:** Anomalías en sesiones, certificados inválidos
- **Mitigación:** Certificados PIA, autenticación X.509, cifrado

## IEC 62443 — Framework

### Zonas y Conductores
```
Zona: Grupo de activos con requisitos de seguridad similares
Conducto: Camino de comunicación entre zonas

Requisitos por zona:
- SL 1: Protección contra amenazas casuales
- SL 2: Protección contra amenazas intencionales con bajo recursos
- SL 3: Protección contra amenazas sofisticadas con recursos moderados
- SL 4: Protección contra amenazas avanzadas con recursos extensos
```

### 7 Foundational Requirements
1. **FR1:** Identification and Authentication Control
2. **FR2:** Use Control
3. **FR3:** System Integrity
4. **FR4:** Data Confidentiality
5. **FR5:** Restricted Data Flow
6. **FR6:** Timely Response to Events
7. **FR7:** Resource Availability

## Evaluación de Seguridad OT

### Fase 1: Inventario de Activos OT
```
Identificar:
- PLCs (marca, modelo, firmware)
- RTUs
- HMIs (marca, software, versión)
- Historian servers
- SCADA servers
- Network switches/routers OT
- Wireless access points
- Puertos de acceso remoto
- USB ports y uso de USB
```

### Fase 2: Análisis de Red OT
```bash
# Captura pasiva de tráfico OT (NO usar escaneo activo)
tcpdump -i eth0 -w ot_traffic.pcap port 5002 or port 20000

# Análisis con Zeek (Bro)
zeek -i eth0

# Detección de dispositivos OT con Nmap (cuidado en producción)
nmap -sU -p 5002,20000,4840 --script modbus-discover <target>
```

### Fase 3: Evaluación de Vulnerabilidades OT
```
- Verificar firmware versions vs CVEs conocidos
- Evaluar configuración de PLCs (passwords, lógica)
- Revisar segmentación de red IT/OT
- Evaluar acceso remoto (VPN, TeamViewer, etc.)
- Verificar backup de configuraciones de PLCs
- Evaluar procedimientos de parcheo
```

### Fase 4: Hardening Recommendations
```
1. Segmentación IT/OT con firewall industrial (FortiGate Rugged)
2. Deshabilitar puertos USB en HMIs
3. Implementar jump servers para acceso remoto
4. Backup regular de configuraciones de PLCs
5. Monitoreo pasivo de red OT (Nozomi Networks, Claroty, o Wazuh)
6. Procedimientos de parcheo OT-tested
7. Autenticación fuerte en HMIs
8. Cifrado de comunicaciones OPC UA
```

## Detección de Ataques OT

### Anomalías Modbus
```
- Function codes no estándar (ej: Write en solo-lectura)
- Registros fuera de rango
- Frecuencia de polling anómala
- Comandos de escritura desde fuentes no autorizadas
- Respuestas con exception codes inesperados
```

### Anomalías DNP3
```
- Unsolicited responses inesperadas
- Sequence numbers fuera de orden
- Object headers no estándar
- Cold restart commands no autorizados
- Integrity polls anómalos
```

## Herramientas OT Security
| Herramienta | Uso | Tipo |
|---|---|---|
| Wireshark | Análisis de protocolos OT | Open Source |
| Zeek (Bro) | Network monitoring OT | Open Source |
| Nmap + scripts | Descubrimiento de dispositivos OT | Open Source |
| GRASSMARLIN | Passive OT network visibility | Open Source |
| Nozomi Networks | OT network monitoring | Comercial |
| Claroty | OT security platform | Comercial |
| FortiGate Rugged | Firewall industrial | Comercial |
| Dragos | OT threat intelligence | Comercial |

## Mapeo MITRE ATT&CK for ICS
| Táctica | Técnicas Clave |
|---|---|
| Initial Access | Internet-facing Remote Services, Exploit Public-Facing Application |
| Execution | Command and Scripting Interpreter, Change Operating Mode |
| Persistence | Module Firmware, System Firmware |
| Evasion | Masquerading, Spoof Reporting Message |
| Collection | Automated Collection, Data from Information Repositories |
| Inhibit Process Control | Activate Firmware Update Mode, Alarm Suppression |
| Impair Process Control | Brute Force I/O, Modify Parameter |
| Impact | Denial of Service, Loss of Safety, Loss of View |
