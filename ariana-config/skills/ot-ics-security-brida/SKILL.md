---
name: ot-ics-security-brida
description: Seguridad OT/ICS para BRIDA IT Services — SCADA, Modbus, DNP3, IEC 62443,
  Purdue Model, IT/OT Convergence, MITRE ATT&CK for ICS, NIST CSF, D3FEND.
version: 1.0.0
author: BRIDA IT Services
license: Proprietary
platforms:
- linux
- macos
- windows
triggers:
- seguridad OT
- seguridad ICS
- SCADA
- Modbus
- DNP3
- IEC 62443
- Purdue Model
- IT/OT convergence
- MITRE ATT&CK ICS
- NIST CSF OT
- D3FEND
- redes industriales
- sistemas de control
- OT security
- ICS security
- industrial security
category: cybersecurity
metadata:
  hermes:
    tags:
    - ot
    - ics
    - scada
    - modbus
    - dnp3
    - iec-62443
    - purdue
    - it-ot-convergence
    - mitre-attack-ics
    - nist-csf
    - d3fend
    - industrial-security
    - critical-infrastructure
    homepage: https://www.bridaitservices.com
---

# Seguridad OT/ICS — BRIDA IT Services

## Descripción General

Este skill proporciona conocimiento especializado en **seguridad de Tecnologías Operativas (OT) y Sistemas de Control Industrial (ICS)** para BRIDA IT Services. Cubre análisis de protocolos industriales (Modbus, DNP3), marcos normativos (IEC 62443), arquitectura de redes (Purdue Model), convergencia IT/OT, y mapeos a frameworks de amenazas y defensas (MITRE ATT&CK for ICS, NIST CSF, D3FEND).

> **Nota:** Los términos técnicos de ciberseguridad se mantienen en inglés para preservar precisión y alineación con estándares internacionales.

---

## 1. Fundamentos de OT/ICS

### 1.1 Diferencias Clave: IT vs OT

| Aspecto | IT (Information Technology) | OT (Operational Technology) |
|---------|---------------------------|------------------------------|
| **Prioridad** | Confidencialidad > Integridad > Disponibilidad (CIA) | Disponibilidad > Integridad > Confidencialidad (AIC) |
| **Ciclo de vida** | 3-5 años | 15-30 años |
| **Parcheo** | Frecuente, automatizado | Requiere ventanas de mantenimiento, validación extensiva |
| **Protocolos** | TCP/IP, HTTP, SSH | Modbus, DNP3, OPC UA, EtherNet/IP, PROFINET |
| **Tolerancia a downtime** | Aceptable (minutos/horas) | Inaceptable (segundos pueden causar daño físico) |
| **Seguridad heredada** | Autenticación, cifrado comunes | Muchos protocolos sin autenticación ni cifrado nativos |
| **Regulación** | GDPR, PCI-DSS | IEC 62443, NERC CIP, NIST SP 800-82 |

### 1.2 Componentes Típicos de un ICS

- **SCADA** (Supervisory Control and Data Acquisition) — supervisión y control remoto
- **PLC** (Programmable Logic Controller) — control lógico programable
- **RTU** (Remote Terminal Unit) — unidades terminales remotas
- **HMI** (Human-Machine Interface) — interfaz operador-máquina
- **DCS** (Distributed Control System) — sistemas de control distribuido
- **IED** (Intelligent Electronic Device) — dispositivos electrónicos inteligentes
- **Historian** — base de datos de series temporales industriales
- **Engineering Workstation (EWS)** — estación de ingeniería para programación

### 1.3 Sectores de Infraestructura Crítica

| Sector | Ejemplos | Protocolos Comunes |
|--------|----------|--------------------|
| Energía Eléctica | Generación, transmisión, distribución | DNP3, IEC 61850, Modbus |
| Petróleo y Gas | Refinerías, oleoductos, gasoductos | Modbus, OPC UA, Foundation Fieldband |
| Agua y Saneamiento | Plantas de tratamiento, distribución | Modbus, DNP3, Profibus |
| Manufactura | Líneas de producción, robótica | EtherNet/IP, PROFINET, OPC UA |
| Transporte | Señalización, control de tráfico | DNP3, NTCIP |
| Químico | Plantas químicas, reactores | HART, Profibus PA, OPC UA |

---

## 2. Análisis de Protocolos Industriales

### 2.1 Modbus

#### 2.1.1 Visión General

Modbus es un protocolo de comunicaciones de tipo **request/response** desarrollado por Modicon (1979). Es el protocolo industrial más ampliamente desplegado del mundo.

**Variantes:**
- **Modbus RTU** — binario, sobre RS-232/RS-485
- **Modbus ASCII** — texto ASCII, sobre RS-232/RS-485
- **Modbus TCP** — sobre Ethernet/TCP (puerto 502)
- **Modbus Plus (MB+)** — red token-passing propietaria

#### 2.1.2 Estructura del Protocolo Modbus TCP

```
Modbus TCP ADU (Application Data Unit):
+-------------------+-------------------+-------+-------+------+----------+
| Transaction ID    | Protocol ID       | Length| Unit  | FC   | Data     |
| (2 bytes)         | (2 bytes, =0x0000)|(2 bytes)| ID  |(1 byte)| (N bytes)|
+-------------------+-------------------+-------+-------+------+----------+
         |                MBAP Header                    |  PDU       |
+------------------------------------------------------+------------+
```

#### 2.1.3 Function Codes (FC) Principales

| FC | Nombre | Acceso | Descripción |
|----|--------|--------|-------------|
| 0x01 | Read Coils | Lectura | Lee estado de coils (1 bit c/u) |
| 0x02 | Read Discrete Inputs | Lectura | Lee entradas discretas |
| 0x03 | Read Holding Registers | Lectura | Lee registros de retención (16 bits c/u) |
| 0x04 | Read Input Registers | Lectura | Lee registros de entrada |
| 0x05 | Write Single Coil | Escritura | Escribe un coil |
| 0x06 | Write Single Register | Escritura | Escribe un registro |
| 0x0F | Write Multiple Coils | Escritura | Escribe múltiples coils |
| 0x10 | Write Multiple Registers | Escritura | Escribe múltiples registros |
| 0x17 | Read/Write Multiple Registers | Lectura/Escritura | Operación combinada |
| 0x2B/0x0E | Read Device Identification | Lectura | Identifica el dispositivo |

#### 2.1.4 Modelo de Datos Modbus

| Tipo | Acceso | Rango de Direcciones | Tamaño |
|------|--------|----------------------|--------|
| Coils | Lectura/Escritura | 00001–09999 | 1 bit |
| Discrete Inputs | Solo lectura | 10001–19999 | 1 bit |
| Input Registers | Solo lectura | 30001–39999 | 16 bits |
| Holding Registers | Lectura/Escritura | 40001–49999 | 16 bits |

#### 2.1.5 Vulnerabilidades de Seguridad Modbus

| Vulnerabilidad | Severidad | Descripción |
|---------------|-----------|-------------|
| Sin autenticación | **Crítica** | Cualquier dispositivo puede enviar comandos |
| Sin cifrado | **Crítica** | Tráfico en texto plano, susceptible a eavesdropping |
| Sin integridad de mensajes | **Alta** | No hay MAC ni firmas |
| Replay attacks | **Alta** | Mensajes pueden ser capturados y reinyectados |
| Denegación de servicio | **Alta** | Inundación de requests al esclavo |
| Function codes no restringidos | **Media** | FC peligrosos (0x05, 0x06, 0x0F, 0x10) sin control |
| Information disclosure | **Media** | FC 0x2B expone información del dispositivo |

#### 2.1.6 Detección y Análisis con Wireshark

```bash
```

#### 2.1.7 Herramientas de Análisis y Pentesting Modbus

| Herramienta | Uso | Enlace |
|------------|-----|--------|
| **mbtget** | Cliente Modbus TCP/RTU en línea de comandos | GitHub: 0x101010C/mbtget |
| **ModbusPal** | Simulador Modbus esclavo | modbuspal.sourceforge.net |
| **pymodbus** | Biblioteca Python para Modbus | pymodbus.readthedocs.io |
| **Scapy** | Crafting de paquetes Modbus | scapy.net |
| **Nmap scripts** | Enumeración y detección Modbus | nmap.org |
| **GRFICSv2** | Simulador de planta química con Modbus | GitHub |

```bash

# Lectura de registros con mbtget (RTU)
mbtget -a 1 -r 40001 -n 10 -p /dev/ttyUSB0 -b 9600 <slave_id>

# Lectura de registros con mbtget (TCP)
mbtget -a 1 -r 40001 -n 10 <ip> 502
```

---

### 2.2 DNP3 (Distributed Network Protocol)

#### 2.2.1 Visión General

DNP3 es un protocolo de comunicaciones diseñado para **sistemas de servicios públicos** (energía, agua). Desarrollado por Westronic/Harris (1993), basado en IEC 60870-5.

**Características principales:**
- Arquitectura **master/outstation** (similar a cliente/servidor)
- Soporte para **reporte por excepción** (event-driven)
- **Fragmentación** de mensajes grandes
- **Autenticación** segura (SAv5 — Secure Authentication Version 5)
- Transporte sobre serial (RS-232/RS-485) o TCP/IP (puerto 20000)

#### 2.2.2 Arquitectura DNP3

```
+----------+       +-------------+       +----------+
| Master   |<----->|  TCP/IP o   |<----->|Outstation|
| (Control)|       |  Serial     |       | (Campo)  |
| Station  |       |             |       | (RTU/IED)|
+----------+       +-------------+       +----------+
     |                                        |
|  SCADA                              PLCs, Sensores,
|  HMI                                Actuadores
```

#### 2.2.3 Estructura del Protocolo DNP3

```
DNP3 Data Link Layer Frame:
+------+-------+-------+-------+-------+-----+-------+
| 0x0564 | Len | Ctrl | Dest  | Source | CRC | Data  |
| (2B)  |(1B) | (1B) | (2B)  | (2B)   |(2B) | (N B) |
+------+-------+-------+-------+-------+-----+-------+

DNP3 Transport Function:
+------+--------+
| Header | Fragment |
| (1B)   | (N bytes) |
+------+--------+

DNP3 Application Layer:
+--------+--------+--------+
| App Ctrl | Function Code | Objects |
| (1B)    | (1B)          | (N bytes) |
+--------+--------+--------+
```

#### 2.2.4 Function Codes DNP3 Principales

| FC | Dirección | Nombre | Descripción |
|----|-----------|--------|-------------|
| 0x00 | M→O | Confirm | Confirmación |
| 0x01 | M→O | Read | Solicitud de lectura |
| 0x02 | M→O | Write | Solicitud de escritura |
| 0x03 | M→O | Select | Selección para operación |
| 0x04 | M→O | Operate | Ejecutar operación (SBO) |
| 0x05 | M→O | Direct Operate | Operación directa |
| 0x06 | M→O | Direct Operate No Ack | Operación directa sin ACK |
| 0x07 | M→O | Freeze | Congelar contadores |
| 0x08 | M→O | Freeze No Ack | Congelar sin ACK |
| 0x09 | M→O | Freeze and Clear | Congelar y limpiar |
| 0x10 | M→O | Cold Restart | Reinicio en frío |
| 0x11 | M→O | Warm Restart | Reinicio en caliente |
| 0x12 | M→O | Initialize Data | Inicializar datos |
| 0x15 | M→O | Enable Unsolicited | Habilitar mensajes no solicitados |
| 0x16 | M→O | Disable Unsolicited | Deshabilitar mensajes no solicitados |
| 0x17 | M→O | Assign Class | Asignar clase |
| 0x81 | O→M | Response | Respuesta |
| 0x82 | O→M | Unsolicited Response | Respuesta no solicitada |

#### 2.2.5 Objetos DNP3 Comunes

| Grupo | Variación | Tipo de Dato | Descripción |
|-------|-----------|-------------|-------------|
| 0 | 0-64 | Device Attributes | Atributos del dispositivo |
| 1 | 0-2 | Binary Input | Entradas binarias |
| 2 | 0-8 | Binary Input Change | Cambios en entradas binarias |
| 10 | 0-2 | Binary Output | Salidas binarias |
| 12 | 1 | Binary Output Command | Comando de salida binaria |
| 20 | 0-8 | Counter | Contadores |
| 30 | 0-6 | Analog Input | Entradas analógicas |
| 32 | 0-8 | Analog Input Change | Cambios en entradas analógicas |
| 40 | 0-4 | Analog Output | Salidas analógicas |
| 41 | 1-4 | Analog Output Command | Comando de salida analógica |
| 50 | 1 | Time and Date | Fecha y hora |
| 60 | 1-4 | Class Data | Datos por clase |
| 120 | 1-5 | Authentication | Autenticación segura |

#### 2.2.6 Secure Authentication (SAv5)

```
Proceso DNP3 SAv5:
1. Master envía Challenge al Outstation
2. Outstation responde con MAC (HMAC-SHA256)
3. Master verifica MAC
4. Si OK, se establece sesión autenticada
5. Todos los comandos críticos requieren autenticación

Modos de HMAC soportados:
- HMAC-SHA-1 (truncado a 10 bytes)
- HMAC-SHA-256 (truncado a 10 bytes)
- HMAC-SHA-1 (truncado a 4 bytes) — NO recomendado
- HMAC-SHA-256 (truncado a 4 bytes) — NO recomendado
- AES-GMAC
```

#### 2.2.7 Vulnerabilidades DNP3

| Vulnerabilidad | Severidad | Descripción |
|---------------|-----------|-------------|
| Sin autenticación (configuración por defecto) | **Crítica** | Outstations aceptan comandos de cualquier master |
| Replay attacks | **Alta** | Sin SAv5, mensajes pueden reinyectarse |
| Denegación de servicio | **Alta** | FC 0x10 (Cold Restart) puede interrumpir operaciones |
| Information disclosure | **Media** | FC 0x01 permite leer todos los objetos |
| Manipulación de salidas | **Crítica** | FC 0x05/0x06 permiten operar actuadores directamente |
| Falta de cifrado | **Alta** | Tráfico en texto plano |

#### 2.2.8 Herramientas de Análisis DNP3

| Herramienta | Uso |
|------------|-----|
| **OpenDNP3** | Implementación open-source de DNP3 (C++) |
| **pydnp3** | Bindings Python para OpenDNP3 |
| **Wireshark DNP3 dissector** | Análisis de tráfico DNP3 |
| **Nmap dnp3 scripts** | Enumeración DNP3 |
| **DNP3 Simulator** | Simulación master/outstation |

```bash
```

---

### 2.3 Comparativa de Protocolos Industriales

| Característica | Modbus TCP | DNP3 | OPC UA | EtherNet/IP | PROFINET |
|---------------|------------|------|--------|-------------|----------|
| **Año** | 1979 | 1993 | 2008 | 2001 | 2001 |
| **Capa de transporte** | TCP | TCP/Serial | TCP/HTTPS | TCP/UDP | Ethernet |
| **Puerto** | 502 | 20000 | 4840 | 44818 | 34964 |
| **Autenticación** | ❌ No | ✅ SAv5 | ✅ X.509, User/Pass | ❌ No | ❌ No |
| **Cifrado** | ❌ No | ❌ No (externo) | ✅ TLS | ❌ No | ❌ No |
| **Modelo** | Cliente/Servidor | Master/Outstation | Cliente/Servidor + Pub/Sub | Productor/Consumidor | Productor/Consumidor |
| **Reporte por excepción** | ❌ No | ✅ Sí | ✅ Subscriptions | ❌ No | ❌ No |
| **Complejidad** | Baja | Media | Alta | Media | Alta |
| **Uso principal** | Manufactura | Utilities (energía, agua) | Multi-sector | Manufactura (Rockwell) | Manufactura (Siemens) |

---

## 3. IEC 62443 — Estándar de Seguridad ICS

### 3.1 Visión General

IEC 62443 es el **estándar internacional de referencia** para la ciberseguridad de sistemas de control industrial. Desarrollado por la International Electrotechnical Commission (IEC) y adoptado por ISA como ISA/IEC 62443.

### 3.2 Estructura del Estándar

```
IEC 62443 — Serie de Estándares
├── IEC 62443-1-1  → Conceptos y modelos
├── IEC 62443-1-5  → Esquema de perfiles de seguridad
├── IEC 62443-2-1  → Requisitos del sistema de gestión de seguridad
├── IEC 62443-2-4  → Requisitos del proveedor de servicios (IACS)
├── IEC 62443-3-2  → Evaluación de riesgos y diseño de seguridad
├── IEC 62443-3-3  → Requisitos de seguridad del sistema
├── IEC 62443-4-1  → Ciclo de vida de desarrollo seguro
└── IEC 62443-4-2  → Requisitos técnicos de componentes
```

### 3.3 Roles y Responsabilidades

| Rol | Estándares Aplicables | Responsabilidad |
|-----|----------------------|-----------------|
| **Asset Owner** (Propietario) | -2-1, -3-2, -3-3 | Definir requisitos, gestionar riesgos |
| **System Integrator** (Integrador) | -2-4, -3-2, -3-3 | Diseñar e implementar la arquitectura segura |
| **Product Supplier** (Proveedor) | -4-1, -4-2 | Desarrollar productos seguros |
| **Service Provider** (Proveedor de Servicios) | -2-4 | Mantener y operar de forma segura |

### 3.4 Niveles de Seguridad (Security Levels — SL)

| SL | Nombre | Descripción | Amenazas Cubiertas |
|---|--------|-------------|-------------------|
| **SL 0** | Sin protección | No se requiere seguridad | Ninguna |
| **SL 1** | Protección contra amenazas casuales o accidentales | Errores humanos, fallos no intencionados | Accidental |
| **SL 2** | Protección contra acciones intencionales con recursos bajos | Hacking básico, scripts simples | Intencional, baja capacidad |
| **SL 3** | Protección contra acciones sofisticadas con recursos moderados | Grupos organizados, herramientas avanzadas | Sofisticado, recursos moderados |
| **SL 4** | Protección contra ataques de estado-nación con recursos extendidos | APTs, amenazas persistentes avanzadas | Máxima capacidad |

### 3.5 Requisitos Fundamentales (FR — Foundational Requirements)

| ID | Requisito | Descripción |
|----|-----------|-------------|
| **FR 1** | Identification and Authentication Control (IAC) | Control de identificación y autenticación |
| **FR 2** | Use Control (UC) | Control de uso (autorización) |
| **FR 3** | System Integrity (SI) | Integridad del sistema |
| **FR 4** | Data Confidentiality (DC) | Confidencialidad de datos |
| **FR 5** | Restricted Data Flow (RDF) | Flujo de datos restringido (segmentación) |
| **FR 6** | Timely Response to Events (TRE) | Respuesta oportuna a eventos |
| **FR 7** | Resource Availability (RA) | Disponibilidad de recursos |

### 3.6 Requisitos de Mejora (RE — Requirement Enhancements)

| FR | RE | Requisito de Mejora |
|----|----|---------------------|
| FR 1 (IAC) | RE(1) | Human user identification |
| FR 1 (IAC) | RE(2) | Software process identification |
| FR 1 (IAC) | RE(3) | Account management |
| FR 1 (IAC) | RE(4) | Identifier management |
| FR 1 (IAC) | RE(5) | Authenticator management |
| FR 1 (IAC) | RE(6) | Wireless access management |
| FR 2 (UC) | RE(1) | Authorization enforcement |
| FR 2 (UC) | RE(2) | Wireless use control |
| FR 2 (UC) | RE(3) | Use control for portable media |
| FR 3 (SI) | RE(1) | Input validation |
| FR 3 (SI) | RE(2) | Deterministic output |
| FR 3 (SI) | RE(3) | Error handling |
| FR 4 (DC) | RE(1) | Confidentiality over the network |
| FR 5 (RDF) | RE(1) | Network segmentation |
| FR 5 (RDF) | RE(2) | Zone boundary protection |
| FR 7 (RA) | RE(1) | Denial of service protection |
| FR 7 (RA) | RE(2) | Resource management |
| FR 7 (RA) | RE(3) | Control system backup |
| FR 7 (RA) | RE(4) | Control system recovery and reconstitution |

### 3.7 Zonas y Conductos (Zones and Conduits)

```
Concepto de Zonas y Conductos (IEC 62443-3-2):

Zona: Grupo de activos con requisitos de seguridad comunes (mismo SL)
Conducto: Canal de comunicación seguro entre zonas

Ejemplo:
+------------------+       +------------------+
|   Zona IT        |       |   Zona OT        |
|   (SL 2)         |<----->|   (SL 3)         |
|                  |Conducto|                 |
|  ERP, Email      |Seguro  |  SCADA, HMI     |
+------------------+       +------------------+

Principios:
- Cada zona tiene un SL objetivo
- Los conductos controlan el flujo entre zonas
- Los conductos implementan firewalls, VPNs, DPI
- La segmentación reduce la superficie de ataque
```

### 3.8 Metodología de Evaluación de Riesgos (IEC 62443-3-2)

```
Pasos para la evaluación de riesgos IEC 62443-3-2:

1. IDENTIFICACIÓN DE ACTIVOS
   → Inventario de todos los activos ICS
   → Clasificación por criticidad

2. MODELADO DE ZONAS Y CONDUCTOS
   → Agrupar activos en zonas
   → Definir conductos entre zonas
   → Establecer SL objetivo por zona

3. EVALUACIÓN DE RIESGOS
   → Identificar amenazas
   → Evaluar vulnerabilidades
   → Calcular riesgo: Riesgo = Amenaza × Vulnerabilidad × Impacto

4. DISEÑO DE SEGURIDAD
   → Definir contramedidas
   → Asignar SL a cada zona
   → Diseñar arquitectura de seguridad

5. IMPLEMENTACIÓN Y VERIFICACIÓN
   → Implementar controles
   → Verificar cumplimiento de SL
   → Documentar desviaciones
```

---

## 4. Purdue Model (Purdue Enterprise Reference Architecture — PERA)

### 4.1 Visión General

El **Purdue Model** (también conocido como PERA — Purdue Enterprise Reference Architecture) es el modelo de referencia para la **arquitectura de redes industriales**. Define niveles jerárquicos de control y segmentación.

### 4.2 Niveles del Modelo Purdue

```
╔══════════════════════════════════════════════════════════════╗
```

### 4.3 Controles de Seguridad por Nivel

| Nivel | Controles Recomendados |
|-------|----------------------|
| **L5 — Enterprise** | Firewall perimetral, WAF, EDR, SIEM, MFA |
| **DMZ** | Data Diode (unidireccional), Firewall NGFW, IDS/IPS, Jump Server con MFA |
| **L4 — Business** | Firewall, EDR, DLP, Vulnerability Management |
| **L3.5 — Industrial DMZ** | Firewall industrial, IDS/IPS OT (Claroty/Nozomi/Dragos), Data Diode |
| **L3 — Site Operations** | Firewall, Application Whitelisting, USB Control, Patch Management OT |
| **L2 — Supervisory** | Network Monitoring, Access Control, Application Whitelisting |
| **L1 — Control** | Network Segmentation, Protocol Filtering, Firmware Integrity |
| **L0 — Physical** | Physical Security, Tamper Detection, Safety Systems (SIS) |

### 4.4 Flujo de Datos y Reglas de Segmentación

```
Reglas de segmentación Purdue:

1. NUNCA permitir tráfico directo de L5/L4 a L1/L0
2. Todo tráfico IT→OT debe pasar por la DMZ industrial (L3.5)
3. Data Diode para flujo OT→IT (unidireccional)
4. Solo protocolos necesarios permitidos entre niveles
5. Remote Access solo a través de Jump Server con MFA
6. No Internet directo desde L3 o inferior
7. Historian en L3.5 como puente de datos (no en L3 ni L4)
```

### 4.5 Variantes y Evoluciones

| Variante | Descripción |
|----------|-------------|
| **Purdue Model Clásico** | 6 niveles (0-5), jerárquico estricto |
| **Modelo con DMZ** | Añade DMZ en L3.5 (ISA-95/IEC 62443) |
| **Purdue + IT/OT Convergence** | Integración de servicios cloud, IIoT |
| **Modelo de Redes Convergentes** | Flat networks con microsegmentación (Zero Trust OT) |

---

## 5. Convergencia IT/OT

### 5.1 Desafíos de la Convergencia

| Desafío | Impacto | Mitigación |
|---------|---------|------------|
| **Diferentes prioridades** | IT prioriza CIA, OT prioriza AIC | Políticas de seguridad unificadas con excepciones OT |
| **Diferentes ciclos de vida** | IT actualiza cada 3-5 años, OT cada 15-30 | Gestión de vulnerabilidades OT específica |
| **Protocolos inseguros** | Modbus/DNP3 sin auth/cifrado | Gateways de protocolo, VPNs industriales |
| **Shadow IT/OT** | Dispositivos no gestionados en red OT | Asset Discovery continuo |
| **Falta de visibilidad** | IT no entiende OT, OT no entiende IT | Plataformas de visibilidad OT (Claroty, Nozomi, Dragos) |
| **Ransomware cross-domain** | Ataque IT se propaga a OT | Segmentación estricta, DMZ industrial |
| **Remote access** | Acceso remoto inseguro a OT | Jump Servers, MFA, session recording |
| **Cloud connectivity** | IIoT envía datos a cloud | API security, cifrado, Zero Trust |

### 5.2 Arquitectura de Convergencia Segura

```
Arquitectura IT/OT Convergente Segura:

┌─────────────────────────────────────────────────────────┐
```

### 5.3 Zero Trust para OT

```
Principios Zero Trust aplicados a OT:

1. "Never trust, always verify"
   → Autenticación en cada punto de acceso
   → Verificación continua de integridad

2. Least Privilege
   → Solo los permisos mínimos necesarios
   → RBAC (Role-Based Access Control) granular

3. Microsegmentación
   → Segmentar la red OT en zonas pequeñas
   → Políticas por dispositivo, no por subred

4. Continuous Monitoring
   → Monitoreo continuo de tráfico OT
   → Detección de anomalías en tiempo real

5. Assume Breach
   → Diseñar asumiendo que la red está comprometida
   → Contención automática de incidentes

Herramientas Zero Trust OT:
- Claroty (The Claroty Platform)
- Nozomi Networks (Guardian)
- Dragos (Platform)
- Microsoft Defender for IoT
- Palo Alto Networks (OT Security)
- Fortinet (FortiGate Rugged + FortiNAC)
```

---

## 6. MITRE ATT&CK for ICS

### 6.1 Visión General

MITRE ATT&CK for ICS es una **base de conocimiento de tácticas, técnicas y procedimientos (TTPs)** específicos para amenazas contra sistemas de control industrial. Se basa en el framework MITRE ATT&CK Enterprise pero adaptado al entorno OT.

### 6.2 Tactics (Tácticas) MITRE ATT&CK for ICS

| ID | Táctica | Descripción |
|----|---------|-------------|
| **TA0108** | Initial Access | Acceso inicial al entorno OT |
| **TA0104** | Execution | Ejecución de código malicioso |
| **TA0103** | Persistence | Persistencia en el entorno OT |
| **TA0102** | Evasion | Evasión de defensas |
| **TA0109** | Discovery | Descubrimiento del entorno OT |
| **TA0100** | Lateral Movement | Movimiento lateral entre sistemas OT |
| **TA0110** | Collection | Recopilación de datos del proceso |
| **TA0101** | Command and Control | Comunicación C2 |
| **TA0107** | Inhibit Response Function | Inhibir funciones de respuesta (safety) |
| **TA0106** | Impair Process Control | Deteriorar el control del proceso |
| **TA0105** | Impact | Impacto en el proceso físico |

### 6.3 Técnicas Clave por Táctica

#### Initial Access (TA0108)

| Técnica | ID | Descripción |
|---------|----|-------------|
| Drive-by Compromise | T0817 | Compromiso de sitio web para acceder a OT |
| Exploitation of Remote Services | T0822 | Explotación de servicios remotos (RDP, SSH) |
| Internet Accessible Device | T0883 | Dispositivos OT accesibles desde Internet |
| Remote Services | T0886 | Acceso remoto (VPN, TeamViewer, RDP) |
| Supply Chain Compromise | T0862 | Compromiso de la cadena de suministro |
| Valid Accounts | T0859 | Uso de credenciales válidas |
| Wireless Compromise | T0860 | Compromiso de redes inalámbricas |

#### Execution (TA0104)

| Técnica | ID | Descripción |
|---------|----|-------------|
| Change Operating Mode | T0858 | Cambio de modo de operación (program→run) |
| Command-Line Interface | T0807 | Ejecución por línea de comandos |
| Execution through API | T0871 | Ejecución vía API (OPC, Modbus) |
| Graphical User Interface | T0823 | Ejecución vía HMI |
| Program Download | T0843 | Descarga de programa al PLC |
| Scripting | T0853 | Scripts (PowerShell, Python) |

#### Impact (TA0105)

| Técnica | ID | Descripción |
|---------|----|-------------|
| Damage to Property | T0879 | Daño a propiedad física |
| Denial of Control | T0813 | Denegación de control |
| Denial of View | T0815 | Denegación de visibilidad |
| Loss of Availability | T0826 | Pérdida de disponibilidad |
| Loss of Control | T0816 | Pérdida de control |
| Loss of Productivity and Revenue | T0828 | Pérdida de productividad |
| Loss of Safety | T0880 | Pérdida de sistemas de seguridad |
| Loss of View | T0829 | Pérdida de visibilidad |
| Manipulation of Control | T0831 | Manipulación del control |
| Manipulation of View | T0832 | Manipulación de la vista |
| Theft of Operational Information | T0882 | Robo de información operacional |

#### Inhibit Response Function (TA0107)

| Técnica | ID | Descripción |
|---------|----|-------------|
| Activate Firmware Update Mode | T0800 | Activar modo de actualización de firmware |
| Alarm Suppression | T0878 | Supresión de alarmas |
| Block Command Message | T0803 | Bloqueo de mensajes de comando |
| Block Reporting Message | T0804 | Bloqueo de mensajes de reporte |
| Block Serial COM | T0817 | Bloqueo de comunicación serial |
| Data Destruction | T0809 | Destrucción de datos |
| Denial of Service | T0814 | Denegación de servicio |
| Device Restart/Shutdown | T0816 | Reinicio/apagado de dispositivos |
| Manipulate I/O Image | T0842 | Manipulación de imagen de E/S |
| Modify Alarm Settings | T0838 | Modificación de configuración de alarmas |
| Rootkit | T0841 | Rootkits en dispositivos OT |
| Service Stop | T0881 | Detención de servicios |
| System Firmware | T0847 | Manipulación de firmware del sistema |

### 6.4 Grupos de Amenaza (Threat Groups) Relevantes

| Grupo | Alias | Sector Objetivo | TTPs Notables |
|-------|-------|-----------------|---------------|
| **Sandworm** | Telebots, Voodoo Bear | Energía, Gobierno | BlackEnergy, Industroyer, NotPetya, TRITON |
| **APT33** | Elfin, HOLMIUM | Petróleo, Energía | Shamoon, custom ICS tools |
| **XENOTIME** | — | Petróelo y Gas | TRITON/TRISIS (SIS attack) |
| **CHERNOVITE** | — | Petróleo y Gas | PIPEDREAM/INCONTROLLER |
| **Lazarus** | APT38 | Financiero, Manufactura | Custom ICS malware |

### 6.5 Mapeo MITRE ATT&CK ICS → IEC 62443

| Táctica ATT&CK ICS | FR IEC 62443 | Control Recomendado |
|--------------------|--------------|---------------------|
| Initial Access (TA0108) | FR 1 (IAC) | Autenticación fuerte, segmentación |
| Execution (TA0104) | FR 2 (UC) | Application Whitelisting, autorización |
| Persistence (TA0103) | FR 3 (SI) | Integridad de firmware, monitoreo |
| Lateral Movement (TA0100) | FR 5 (RDF) | Segmentación, microsegmentación |
| Collection (TA0110) | FR 4 (DC) | Cifrado, DLP |
| Impact (TA0105) | FR 7 (RA) | Redundancia, backup, SIS |
| Inhibit Response (TA0107) | FR 6 (TRE) | Monitoreo, alerting, respuesta |

---

## 7. NIST Cybersecurity Framework (CSF) para OT

### 7.1 Visión General

El NIST CSF proporciona un marco de **gestión de riesgos de ciberseguridad** aplicable a entornos OT. Las cinco funciones principales se adaptan al contexto industrial.

### 7.2 Funciones del NIST CSF Aplicadas a OT

#### IDENTIFY (ID)

| Categoría | ID | Aplicación OT |
|-----------|----|--------------|
| Asset Management | ID.AM | Inventario de activos OT (PLCs, RTUs, HMIs, redes) |
| Business Environment | ID.BE | Comprensión del proceso físico y su criticidad |
| Governance | ID.GV | Políticas de seguridad OT, roles IT/OT |
| Risk Assessment | ID.RA | Evaluación de riesgos OT (IEC 62443-3-2) |
| Risk Management Strategy | ID.RM | Estrategia de gestión de riesgos IT/OT |
| Supply Chain Risk Management | ID.SC | Gestión de riesgos de proveedores OT |

#### PROTECT (PR)

| Categoría | ID | Aplicación OT |
|-----------|----|--------------|
| Identity Management and Access Control | PR.AC | Control de acceso a OT (MFA, RBAC, Jump Servers) |
| Awareness and Training | PR.AT | Capacitación de operadores OT en ciberseguridad |
| Data Security | PR.DS | Protección de datos OT (configuraciones, firmware) |
| Information Protection Processes | PR.IP | Gestión de parches OT, hardening |
| Maintenance | PR.MA | Mantenimiento seguro de equipos OT |
| Protective Technology | PR.PT | Firewalls OT, IDS/IPS, Application Whitelisting |

#### DECTECT (DE)

| Categoría | ID | Aplicación OT |
|-----------|----|--------------|
| Anomalies and Events | DE.AE | Detección de anomalías en tráfico OT |
| Security Continuous Monitoring | DE.CM | Monitoreo continuo de red OT (passive) |
| Detection Processes | DE.DP | Procesos de detección específicos OT |

#### RESPOND (RS)

| Categoría | ID | Aplicación OT |
|-----------|----|--------------|
| Response Planning | RS.RP | Plan de respuesta a incidentes OT |
| Communications | RS.CO | Comunicación durante incidentes OT |
| Analysis | RS.AN | Análisis forense OT |
| Mitigation | RS.MI | Mitigación de incidentes OT |
| Improvements | RS.IM | Lecciones aprendidas |

#### RECOVER (RC)

| Categoría | ID | Aplicación OT |
|-----------|----|--------------|
| Recovery Planning | RC.RP | Plan de recuperación OT (RTO/RPO) |
| Improvements | RC.IM | Mejoras post-incidente |
| Communications | RC.CO | Comunicación de recuperación |

### 7.3 NIST SP 800-82 — Guía de Seguridad ICS

NIST SP 800-82 Rev. 3 es la guía complementaria específica para ICS:

| Sección | Contenido |
|---------|----------|
| **Capítulo 1** | Introducción a ICS y seguridad |
| **Capítulo 2** | Arquitectura de sistemas ICS |
| **Capítulo 3** | Amenazas y vulnerabilidades ICS |
| **Capítulo 4** | Programas de seguridad ICS |
| **Capítulo 5** | Controles de seguridad para ICS |
| **Capítulo 6** | Respuesta a incidentes ICS |
| **Apéndices** | Mapeo de controles, referencias |

### 7.4 Mapeo NIST CSF → IEC 62443

| Función NIST CSF | Estándar IEC 62443 | Descripción |
|-------------------|---------------------|-------------|
| IDENTIFY | IEC 62443-2-1, -3-2 | Gestión de activos, evaluación de riesgos |
| PROTECT | IEC 62443-3-3, -4-2 | Controles técnicos, desarrollo seguro |
| DETECT | IEC 62443-3-3 (FR 6) | Monitoreo, respuesta a eventos |
| RESPOND | IEC 62443-2-1, -2-4 | Gestión de incidentes, operaciones |
| RECOVER | IEC 62443-3-3 (FR 7 RA) | Disponibilidad, backup, recuperación |

---

## 8. MITRE D3FEND para ICS

### 8.1 Visión General

MITRE D3FEND es una **base de conocimiento de técnicas defensivas** que se mapea directamente a las técnicas ofensivas de MITRE ATT&CK. Proporciona contramedidas estructuradas.

### 8.2 Categorías D3FEND Aplicables a OT

| Categoría | Técnicas Clave para OT |
|-----------|----------------------|
| **Network Traffic Analysis** | Deep Packet Inspection (DPI) de protocolos OT, detección de anomalías |
| **Protocol Analysis** | Análisis de Modbus/DNP3, validación de function codes |
| **File Analysis** | Verificación de firmware, integridad de programas PLC |
| **Authentication** | MFA para acceso OT, autenticación de dispositivos |
| **Access Control** | RBAC, segmentación de red, Jump Servers |
| **Process Analysis** | Monitoreo de comportamiento de procesos, detección de anomalías |
| **Configuration Management** | Hardening de dispositivos OT, gestión de cambios |
| **Credential Management** | Rotación de credenciales, PAM para OT |

### 8.3 Mapeo D3FEND → MITRE ATT&CK ICS (Ejemplos)

| Técnica ATT&CK ICS | Contramedida D3FEND | Implementación OT |
|--------------------|--------------------|--------------------|
| T0883 — Internet Accessible Device | Network Isolation | Segmentación Purdue, DMZ |
| T0858 — Change Operating Mode | Process Whitelisting | Application Whitelisting en PLCs |
| T0843 — Program Download | Firmware Integrity | Verificación de firma de firmware |
| T0814 — Denial of Service | Network Traffic Filtering | Rate limiting, protocol filtering |
| T0831 — Manipulation of Control | Process Anomaly Detection | Monitoreo de valores de proceso |
| T0832 — Manipulation of View | Data Integrity Checking | Verificación de integridad HMI |
| T0878 — Alarm Suppression | Alarm Auditing | Monitoreo independiente de alarmas |
| T0847 — System Firmware | Firmware Verification | Secure Boot, integrity checks |
| T0886 — Remote Services | Multi-Factor Authentication | MFA en Jump Servers |
| T0809 — Data Destruction | Backup | Backups offline de configuraciones |

### 8.4 Matriz D3FEND para OT

```
Modelo D3FEND para OT:

┌─────────────────────────────────────────────────────────────┐
```

---

## 9. Herramientas de Seguridad OT/ICS

### 9.1 Plataformas de Visibilidad y Monitoreo OT

| Herramienta | Tipo | Capacidades |
|------------|------|-------------|
| **Claroty** | Comercial | Asset discovery, threat detection, remote access seguro |
| **Nozomi Networks Guardian** | Comercial | Visibilidad OT, detección de vulnerabilidades, monitoreo |
| **Dragos Platform** | Comercial | Threat intelligence OT, detección de TTPs, forense |
| **Microsoft Defender for IoT** | Comercial | Asset discovery, vulnerability management, threat detection |
| **Tenable.ot** | Comercial | Asset discovery, vulnerability assessment, threat detection |
| **Armis** | Comercial | Agentless device security, visibilidad OT/IoT |

### 9.2 Herramientas Open-Source

| Herramienta | Uso | Enlace |
|------------|-----|--------|
| **GRASSMARLIN** | Passive network discovery para ICS | GitHub: iadgov/grassmarlin |
| **Conpot** | Honeypot ICS/SCADA | GitHub: mushorg/conpot |
| **GRFICSv2** | Simulador de planta química virtual | GitHub: djformby/GRFICSv2 |
| **Malcolm** | Análisis de tráfico de red OT | GitHub: idaholab/Malcolm |
| **Zeek (Bro)** | Network analysis con scripts OT | zeek.org |
| **Suricata** | IDS/IPS con reglas OT | suricata.io |
| **Wireshark** | Análisis de protocolos OT | wireshark.org |
| **pymodbus** | Biblioteca Python Modbus | pymodbus.readthedocs.io |
| **OpenDNP3** | Implementación DNP3 | GitHub: automatak/dnp3 |
| **ICSpector** | Análisis de tráfico ICS | GitHub |

### 9.3 Herramientas de Pentesting OT

| Herramienta | Uso |
|------------|-----|
| **Nmap + NSE scripts** | Escaneo de dispositivos OT (Modbus, DNP3, S7, EtherNet/IP) |
| **Metasploit (OT modules)** | Explotación de vulnerabilidades OT |
| **mbtget** | Cliente Modbus para testing |
| **ModbusPal** | Simulador Modbus |
| **Scapy** | Crafting de paquetes OT personalizados |
| **CrackMapExec** | Testing de credenciales en redes OT Windows |

---

## 10. Procedimientos de Evaluación de Seguridad OT

### 10.1 Metodología de Auditoría OT

```
Fase 1: PREPARACIÓN
├── Definir alcance y objetivos
├── Obtener autorización formal del asset owner
├── Identificar ventanas de evaluación (no interrumpir operaciones)
├── Preparar herramientas y entorno de prueba
└── Establecer plan de rollback

Fase 2: RECOPILACIÓN DE INFORMACIÓN (Passive)
├── Asset discovery pasivo (GRASSMARLIN, Wireshark)
├── Análisis de documentación (diagramas de red, P&ID)
├── Revisión de configuraciones existentes
├── Entrevistas con operadores e ingenieros
└── Revisión de políticas y procedimientos

Fase 3: ANÁLISIS ACTIVO (con precaución)
├── Escaneo de red limitado (nmap, bajo impacto)
├── Análisis de tráfico (Wireshark, Zeek)
├── Verificación de configuraciones de seguridad
├── Pruebas de autenticación (con autorización)
└── Evaluación de vulnerabilidades (Tenable.ot, Nessus)

Fase 4: ANÁLISIS DE RIESGOS
├── Evaluación de vulnerabilidades encontradas
├── Mapeo a MITRE ATT&CK ICS
├── Evaluación de impacto operacional
├── Clasificación de riesgos (probabilidad × impacto)
└── Priorización de remediación

Fase 5: REPORTE Y REMEDIACIÓN
├── Informe ejecutivo (riesgo de negocio)
├── Informe técnico (hallazgos detallados)
├── Plan de remediación priorizado
├── Recomendaciones de arquitectura (Purdue, IEC 62443)
└── Métricas y KPIs de seguridad OT
```

### 10.2 Checklist de Seguridad OT

```
CHECKLIST DE SEGURIDAD OT — BRIDA IT Services

SEGMENTACIÓN DE RED
□ ¿Existe segmentación entre red IT y OT?
□ ¿Hay una DMZ industrial (L3.5) implementada?
□ ¿Se utiliza Data Diode para flujo OT→IT?
□ ¿Los firewalls filtran tráfico entre niveles Purdue?
□ ¿Están definidas zonas y conductos (IEC 62443)?

CONTROL DE ACCESO
□ ¿Se requiere MFA para acceso remoto a OT?
□ ¿Existe Jump Server para acceso remoto?
□ ¿Las credenciales OT son diferentes a las de IT?
□ ¿Se implementa RBAC en sistemas OT?
□ ¿Se registra y audita todo acceso a OT?

VISIBILIDAD Y MONITOREO
□ ¿Existe inventario actualizado de activos OT?
□ ¿Se monitorea el tráfico de red OT (pasivo)?
□ ¿Hay IDS/IPS industrial desplegado?
□ ¿Se detectan anomalías en protocolos OT?
□ ¿Se correlacionan eventos OT en SIEM?

GESTIÓN DE VULNERABILIDADES
□ ¿Se realizan escaneos de vulnerabilidades OT?
□ ¿Se gestionan parches de forma segura (ventanas de mantenimiento)?
□ ¿Se verifican firmas de firmware antes de actualizar?
□ ¿Se evalúan vulnerabilidades de proveedores?

RESPUESTA A INCIDENTES
□ ¿Existe plan de respuesta a incidentes OT?
□ ¿Se han realizado simulacros de incidentes OT?
□ ¿Se cuenta con backups de configuraciones OT?
□ ¿Se ha definido RTO/RPO para sistemas OT?
□ ¿Se coordina con el equipo de seguridad física?

SEGURIDAD DE PROTOCOLOS
□ ¿Se filtran function codes peligrosos (Modbus/DNP3)?
□ ¿Se implementa DNP3 Secure Authentication (SAv5)?
□ ¿Se cifra el tráfico OT sensible (VPN, TLS)?
□ ¿Se validan los rangos de registros Modbus?
□ ¿Se detectan dispositivos OT no autorizados?

SEGURIDAD FÍSICA
□ ¿Están protegidos físicamente los dispositivos OT?
□ ¿Se controla el acceso USB a dispositivos OT?
□ ¿Existen cerraduras en gabinetes de red OT?
□ ¿Se monitorea el acceso físico a salas de control?

CONFORMIDAD
□ ¿Se cumple con IEC 62443?
□ ¿Se cumple con NIST SP 800-82?
□ ¿Se cumple con regulaciones sectoriales (NERC CIP, etc.)?
□ ¿Se realizan auditorías periódicas?
□ ¿Se documentan las excepciones de seguridad?
```

---

## 11. Respuesta a Incidentes OT

### 11.1 Plan de Respuesta a Incidentes OT

```
FASE 1: PREPARACIÓN
├── Equipo de respuesta OT (IT + OT + Seguridad + Gerencia)
├── Playbooks específicos para incidentes OT
├── Herramientas de forense OT preparadas
├── Contactos de emergencia (proveedores, reguladores)
└── Acuerdos de comunicación con stakeholders

FASE 2: DETECCIÓN Y ANÁLISIS
├── Confirmar el incidente (no es un falso positivo)
├── Determinar el alcance (¿qué sistemas OT afectados?)
├── Evaluar impacto operacional (¿proceso en riesgo?)
├── Clasificar severidad (Safety > Availability > Integrity > Confidentiality)
└── Mapear a MITRE ATT&CK ICS (TTPs observados)

FASE 3: CONTENCIÓN
├── Contención inmediata (¿aislar sin detener el proceso?)
├── Contención a corto plazo (segmentación de emergencia)
├── Contención a largo plazo (arquitectura temporal)
└── ¿Activar Safety Instrumented System (SIS) si es necesario?

FASE 4: ERRADICACIÓN
├── Eliminar malware/código malicioso
├── Restaurar configuraciones conocidas como buenas
├── Actualizar firmware si es necesario
├── Cambiar todas las credenciales comprometidas
└── Verificar integridad de todos los sistemas afectados

FASE 5: RECUPERACIÓN
├── Restaurar operaciones normales de forma gradual
├── Monitoreo intensivo post-recuperación
├── Verificar que el proceso opera dentro de parámetros normales
└── Confirmar con operadores que todo funciona correctamente

FASE 6: LECCIONES APRENDIDAS
├── Post-mortem del incidente
├── Actualizar playbooks y procedimientos
├── Mejorar controles de seguridad
├── Capacitar al equipo
└── Actualizar evaluación de riesgos
```

### 11.2 Playbook: Ransomware en Entorno OT

```
PLAYBOOK: RANSOMWARE EN ENTORNO OT

1. DETECCIÓN
   - Indicadores: archivos cifrados, notas de rescate, comportamiento anómalo
   - Fuentes: SIEM, EDR, operadores, IDS/IPS

2. EVALUACIÓN INMEDIATA
   - ¿El ransomware alcanzó la red OT?
   - ¿Están afectados los sistemas de control (L1-L3)?
   - ¿Están afectados los sistemas de safety (SIS)?
   - ¿Se puede aislar la red OT sin detener el proceso?

3. CONTENCIÓN
   - Desconectar inmediatamente la conexión IT/OT (si es seguro)
   - Bloquear tráfico entre zonas Purdue comprometidas
   - NO apagar sistemas OT (puede ser peor que el ransomware)
   - Activar procedimientos manuales si es necesario

4. COMUNICACIÓN
   - Notificar al equipo de respuesta a incidentes
   - Notificar a gerencia y legal
   - Considerar notificación a reguladores (NERC CIP, TSA, CISA)
   - NO pagar rescate (recomendación CISA/FBI)

5. RECUPERACIÓN
   - Restaurar desde backups verificados
   - Reconstruir sistemas desde imágenes conocidas como buenas
   - Verificar integridad de firmware y configuraciones OT
   - Monitoreo intensivo durante 30 días

6. POST-INCIDENTE
   - Análisis forense completo
   - Mejorar segmentación IT/OT
   - Implementar/improver backups offline
   - Actualizar plan de respuesta
```

---

## 12. Referencias y Recursos

### 12.1 Estándares y Normativas

| Estándar | Descripción | Enlace |
|----------|-------------|--------|
| **IEC 62443** | Seguridad de sistemas de control industrial | webstore.iec.ch |
| **NIST SP 800-82** | Guía de seguridad ICS | nist.gov |
| **NIST CSF 2.0** | Framework de ciberseguridad | nist.gov/cyberframework |
| **NERC CIP** | Estándares de protección de infraestructura crítica eléctrica | nerc.com |
| **IEC 61850** | Comunicación en subestaciones eléctricas | webstore.iec.ch |
| **ISA-95** | Integración de sistemas de control con enterprise | isa.org |
| **ISO 27001/27002** | Gestión de seguridad de la información | iso.org |
| **NIST SP 800-53** | Controles de seguridad y privacidad | nist.gov |

### 12.2 Frameworks de Amenazas y Defensas

| Framework | Descripción | Enlace |
|----------|-------------|--------|
| **MITRE ATT&CK for ICS** | TTPs de amenazas ICS | attack.mitre.org/ics |
| **MITRE ATT&CK Enterprise** | TTPs de amenazas IT | attack.mitre.org |
| **MITRE D3FEND** | Técnicas defensivas | d3fend.mitre.org |
| **MITRE FiGHT** | TTPs de amenazas 5G | fight.mitre.org |
| **MITRE Engage** | Framework de engagement | engage.mitre.org |

### 12.3 Recursos de Inteligencia de Amenazas OT

| Recurso | Descripción |
|---------|-------------|
| **CISA ICS-CERT Advisories** | Alertas y avisos de vulnerabilidades OT |
| **Dragos WorldView** | Inteligencia de amenazas OT |
| **Claroty Team82** | Investigación de vulnerabilidades OT |
| **Nozomi Networks Research** | Investigación de amenazas OT |
| **Mandiant OT Threat Intelligence** | Inteligencia de amenazas OT |
| **Dragos ICS/SCADA Threat Landscape** | Panorama de amenazas ICS |

### 12.4 Capacitación y Certificaciones

| Certificación | Organización | Enfoque |
|--------------|-------------|---------|
| **GICSP** (Global Industrial Cyber Security Professional) | SANS/GIAC | Seguridad ICS general |
| **CSSA** (Certified SCADA Security Architect) | IACRB | Arquitectura SCADA |
| **ISA/IEC 62443 Cybersecurity Certificate** | ISA | Implementación IEC 62443 |
| **CSSP** (Certified SCADA Security Professional) | — | Seguridad SCADA |
| **OSCP/OSCE** | Offensive Security | Pentesting (base IT) |
| **GRID** (GIAC Response and Industrial Defense) | SANS/GIAC | Respuesta a incidentes OT |

---

## 13. Glosario

| Término | Definición |
|---------|-----------|
| **SCADA** | Supervisory Control and Data Acquisition — sistema de supervisión y control |
| **PLC** | Programmable Logic Controller — controlador lógico programable |
| **RTU** | Remote Terminal Unit — unidad terminal remota |
| **HMI** | Human-Machine Interface — interfaz humano-máquina |
| **DCS** | Distributed Control System — sistema de control distribuido |
| **IED** | Intelligent Electronic Device — dispositivo electrónico inteligente |
| **SIS** | Safety Instrumented System  | sistema instrumentado de seguridad |
| **P&ID** | Piping and Instrumentation Diagram — diagrama de tuberías e instrumentación |
| **MTU** | Master Terminal Unit  | unidad terminal maestra (sinónimo de master SCADA) |
| **OPC** | Open Platform Communications  | estándar de comunicación industrial |
| **DMZ** | Demilitarized Zone  | zona desmilitarizada (segmento de red aislado) |
| **Data Diode** | Dispositivo de transferencia unidireccional de datos |
| **EWS** | Engineering Workstation  | estación de ingeniería |
| **Historian** | Base de datos de series temporales industriales |
| **Firmware** | Software embebido en dispositivos hardware |
| **Function Code** | Código de función en protocolos industriales (Modbus/DNP3) |
| **Coil** | Registro de 1 bit en Modbus (salida digital) |
| **Register** | Registro de 16 bits en Modbus |
| **Outstation** | Dispositivo esclavo en DNP3 |
| **Master** | Dispositivo controlador en DNP3/Modbus |

---

*Documento creado por BRIDA IT Services — Seguridad OT/ICS*
*Versión 1.0.0 — Junio 2026*
*Este skill es para uso interno y de clientes de BRIDA IT Services.*