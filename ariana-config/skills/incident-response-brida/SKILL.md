---
name: incident-response-brida
description: Incident Response Brida
category: cybersecurity
---# Incident Response - BRIDA IT Services
## Habilidades y Procedimientos de Respuesta a Incidentes

---

```yaml
name: incident-response-brida
description: >
  Procedimientos de Respuesta a Incidentes (IR) para BRIDA IT Services basados en
  NIST SP 800-61 Rev. 2. Incluye playbooks para ransomware, phishing, BEC,
  data breach, insider threat, recolección de evidencia, cadena de custodia,
  plantillas de comunicación y reportes post-incidente. Mapeo a MITRE ATT&CK,
  NIST CSF y D3FEND.
triggers:
  - "incidente"
  - "incident response"
  - "respuesta a incidentes"
  - "security incident"
  - "ransomware"
  - "phishing"
  - "BEC"
  - "data breach"
  - "fuga de datos"
  - "insider threat"
  - "amenaza interna"
  - "brecha"
  - "security breach"
  - "compromiso"
  - "compromise"
  - "forense"
  - "forensic"
  - "containment"
  - "contención"
  - "eradication"
  - "eradicación"
  - "chain of custody"
  - "cadena de custodia"
  - "playbook"
  - "evidence collection"
  - "recolección de evidencia"
  - "post-incident"
  - "lecciones aprendidas"
  - "lessons learned"
  - "IR"
  - "CSIRT"
  - "SOC"
category: security
version: "1.0.0"
author: BRIDA IT Services
methodology: NIST SP 800-61 Rev. 2
tools:
  - CrowdStrike Falcon (EDR)
  - Trellix ePO (Endpoint Protection)
  - FortiGate (Network Security)
  - Qualys (Vulnerability Management)
frameworks:
  - MITRE ATT&CK
  - NIST Cybersecurity Framework (CSF)
  - D3FEND
language: "es (términos de ciberseguridad en inglés)"
```

---

## Tabla de Contenidos

1. [Marco Metodológico](#1-marco-metodológico)
2. [Fases de Respuesta a Incidentes (NIST SP 800-61)](#2-fases-de-respuesta-a-incidentes-nist-sp-800-61)
   - [Fase 1: Preparación](#fase-1-preparación)
   - [Fase 2: Detección y Análisis](#fase-2-detección-y-análisis)
   - [Fase 3: Contención](#fase-3-contención)
   - [Fase 4: Erradicación](#fase-4-erradicación)
   - [Fase 5: Recuperación](#fase-5-recuperación)
   - [Fase 6: Actividad Post-Incidente (Lecciones Aprendidas)](#fase-6-actividad-post-incidente-lecciones-aprendidas)
3. [Herramientas del Stack de BRIDA](#3-herramientas-del-stack-de-brida)
4. [Playbooks de Incidentes](#4-playbooks-de-incidentes)
   - [Playbook: Ransomware](#playbook-ransomware)
   - [Playbook: Phishing / Spear-Phishing](#playbook-phishing--spear-phishing)
   - [Playbook: Business Email Compromise (BEC)](#playbook-business-email-compromise-bec)
   - [Playbook: Data Breach / Fuga de Datos](#playbook-data-breach--fuga-de-datos)
   - [Playbook: Insider Threat / Amenaza Interna](#playbook-insider-threat--amenaza-interna)
5. [Recolección de Evidencia](#5-recolección-de-evidencia)
6. [Cadena de Custodia](#6-cadena-de-custodia)
7. [Plantillas de Comunicación](#7-plantillas-de-comunicación)
8. [Reporte Post-Incidente](#8-reporte-post-incidente)
9. [Matrices de Mapeo](#9-matrices-de-mapeo)
   - [MITRE ATT&CK](#mitre-attck)
   - [NIST CSF](#nist-csf)
   - [D3FEND](#d3fend)
10. [Glosario](#10-glosario)

---

## 1. Marco Metodológico

BRIDA IT Services sigue la metodología de **NIST SP 800-61 Rev. 2** (*Computer Security Incident Handling Guide*). Este marco proporciona un enfoque estructurado y repetible para detectar, analizar, contener, erradicar y recuperarse de incidentes de ciberseguridad.

### Principios Rectores

1. **Velocidad con precisión**: Actuar rápido pero con datos suficientes para tomar decisiones informadas.
2. **Minimizar el impacto**: Priorizar la protección de personas, datos críticos y operaciones del negocio.
3. **Preservación de evidencia**: Toda acción debe considerar la integridad forense.
4. **Comunicación oportuna**: Informar a las partes interesadas con la frecuencia y detalle apropiados.
5. **Mejora continua Cada incidente es una oportunidad de aprendizaje para madurar el programa de seguridad.

### Clasificación de Severidad

| Nivel | Nombre | Descripción | Tiempo de Respuesta | Ejemplo |
|-------|--------|-------------|-------------------|---------|
| **P1** | **Crítico** | Impacto severo en operaciones, datos o reputación. Activo en curso. | ≤ 15 minutos | Ransomware activo, breach de datos masivo, compromiso de AD |
| **P2** | **Alto** | Impacto significativo potencial. Propagación limitada. | ≤ 30 minutos | Phishing con credenciales comprometidas, malware sin propagación |
| **P3** | **Medio** | Impacto moderado. Incidente contenido o de alcance limitado. | ≤ 2 horas | Intento de acceso no autorizado bloqueado, malware aislado |
| **P4** | **Bajo** | Impacto mínimo. Sin compromiso confirmado de datos o sistemas. | ≤ 24 horas | Escaneo de puertos, intento de phishing no exitoso, política violada |

### Flujo de Trabajo General

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
       ▲                                                       │
       │                                                       ▼
       │               ┌─────────────┐    ┌─────────────────────────┐
       │               │             │    │                         │
       └───────────────│LECCIONES    │◀───│      RECUPERACIÓN       │
                       │APRENDIDAS   │    │                         │
                       └─────────────┘    └─────────────────────────┘
```

---

## 2. Fases de Respuesta a Incidentes (NIST SP 800-61)

### Fase 1: Preparación

La preparación es la base de un programa de IR efectivo. Incluye todas las actividades realizadas **antes** de que ocurra un incidente.

#### 1.1 Organización del CSIRT

| Rol | Responsabilidad | Contacto |
|-----|----------------|----------|
| **IR Lead** | Coordinación general del incidente, decisiones estratégicas | [Definir] |
| **Analyst Tier 1** | Triaje inicial, clasificación, escalamiento | [Definir] |
| **Analyst Tier 2** | Análisis profundo, contención, erradicación | [Definir] |
| **Forensic Analyst** | Recolección y análisis forense, cadena de custodia | [Defir] |
| **Threat Hunter** | Búsqueda proactiva de amenazas, IOC sweep | [Definir] |
| **Comms Lead** | Comunicación interna y externa, relaciones con reguladores | [Definir] |
| **Legal Counsel** | Asesoría legal, obligaciones regulatorias, notificación | [Definir] |

#### 1.2 Preparación Técnica

- [ ] **CrowdStrike Falcon**: Asegurar que todos los endpoints tengan sensor Falcon activo y actualizado. Configurar políticas de detección y respuesta automatizada.
- [ ] **Trellix ePO**: Verificar que las políticas de protección estén actualizadas. Mantener las bases de DAT y Motor de Scan actualizados.
- [ ] **FortiGate**: Configurar logging centralizado. Establecer políticas de segmentación de red. Preparar reglas de bloqueo de emergencia.
- [ ] **Qualys**: Mantener escaneos de vulnerabilidades al día. Priorizar remediación de vulnerabilidades críticas.
- [ ] **SIEM**: Configurar correlación de reglas y alertas. Asegurar retención de logs mínima de 12 meses.
- [ ] **Herramientas forenses**: Mantener kits de herramientas listos (FTK Imager, Volatility, Wireshark, KAPE, etc.)
- [ ] **Comunicaciones de emergencia**: Establecer canales fuera de banda (teléfono satelital, Signal, etc.)
- [ ] **Documentación**: Mantener actualizados runbooks, playbooks y árboles de decisión.

#### 1.3 Preparación de Comunicaciones

- Plantillas pre-aprobadas para notificación a clientes, reguladores y medios.
- Lista de contactos de emergencia actualizada (internos y externos).
- Acuerdos con firmas forenses externas (por ejemplo, para escalamiento).
- Procedimiento de notificación a autoridades (por ejemplo, fiscalía, regulador de protección de datos).

#### 1.4 Métricas de Preparación

| Métrica | Meta | Frecuencia de Medición |
|---------|------|----------------------|
| Cobertura de EDR en endpoints | ≥ 98% | Mensual |
| Tiempo de despliegue de parches críticos | ≤ 72 horas | Por vulnerabilidad |
| Ejercicios de tabletop realizados | ≥ 4/año | Trimestral |
| Tasa de falsos positivos | ≤ 15% | Mensual |
| Tiempo medio de detección (MTTD) | ≤ 1 hora | Mensual |
| Tiempo medio de respuesta (MTTR) | ≤ 4 horas | Mensual |

---

### Fase 2: Detección y Análisis

#### 2.1 Fuentes de Detección

| Fuente | Herramienta BRIDA | Tipo de Alerta |
|--------|-------------------|----------------|
| Endpoint Detection & Response | CrowdStrike Falcon | Detección de malware, comportamiento anómalo, IOC match |
| Endpoint Protection | Trellix ePO | Detección basada en firmas, heurística, GTI |
| Network Firewall | FortiGate | Tráfico malicioso, C2 communication, exfiltration |
| Vulnerability Management | Qualys | Vulnerabilidades explotables, configuración insegura |
| Email Gateway | [Definir] | Phishing, BEC, adjuntos maliciosos |
| SIEM | [Definir] | Correlación de eventos, anomalías |
| Threat Intelligence | [Definir] | IOCs, TTPs, alertas de amenazas |
| Reporte humano | Cualquier canal | Usuario reporta actividad sospechosa |

#### 2.2 Proceso de Triaje

```
┌──────────────────┐
│   ALERTA /       │
│   REPORTE        │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐     ┌──────────────────┐
│ ¿Es un incidente │─NO─▶│  Registrar y     │
│ de seguridad?    │     │  Cerrar          │
└────────┬─────────┘     └──────────────────┘
         │ SÍ
         ▼
┌──────────────────┐
│ Clasificar       │
│ Severidad (P1-P4)│
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Asignar a        │
│ analista         │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Análisis inicial │
│ (scope, impact)  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ ¿Requiere        │
│ escalamiento?    │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Activar playbook │
│ correspondiente  │
└──────────────────┘
```

#### 2.3 Análisis Inicial (Primeros 30 minutos)

1. **Confirmar la alerta**: ¿Es un true positive o false positive?
2. **Identificar el vector de ataque**: ¿Cómo ingresó el atacante?
3. **Determinar el alcance**: ¿Qué sistemas, usuarios o datos están afectados?
4. **Evaluar el impacto**: ¿Cuál es el impacto en confidencialidad, integridad y disponibilidad?
5. **Mapear a MITRE ATT&CK**: Identificar tácticas, técnicas y procedimientos (TTPs) observados.
6. **Recopilar IOCs**: Direcciones IP, dominios, hashes de archivos, patrones de comportamiento.
7. **Documentar todo**: Timestamp, acciones tomadas, evidencia recolectada.

#### 2.4 Análisis de Indicadores de Compromiso (IOCs)

| Tipo de IOC | Ejemplo | Herramienta de Análisis |
|-------------|---------|------------------------|
| Hash de archivo (MD5/SHA256) | `a1b2c3d4e5f6...` | CrowdStrike Falcon, VirusTotal |
| Dirección IP | `203.0.113.50` | FortiGate logs, VirusTotal, AbuseIPDB |
| Dominio | `malicious-domain.com` | DNS logs, PassiveTotal, VirusTotal |
| URL | `http://evil.com/payload.exe` | Proxy logs, URLhaus |
| Email sender | `attacker@fake-bank.com` | Email gateway logs |
| Regla YARA | Regla personalizada | Trellix ePO, CrowdStrike |
| Patrón de red | Beaconing cada 30s | FortiGate, Wireshark |
| Ruta de archivo | `C:\Users\Public\svchost.exe` | CrowdStrike Falcon |

#### 2.5 Técnicas de Análisis

- **Análisis estático**: Examinar archivos sin ejecutarlos (strings, headers, imports, entropy).
- **Análisis dinámico**: Ejecutar en sandbox y observar comportamiento (Cuckoo, Any.Run).
- **Análisis de memoria**: Volcado de memoria y análisis con Volatility.
- **Análisis de red**: Captura de paquetes con Wireshark/tcpdump, análisis de flujos NetFlow.
- **Análisis de logs**: Correlación en SIEM, búsqueda de anomalías.
- **Análisis de timeline**: Construir línea de tiempo de eventos (log2timeline, Plaso).

---

### Fase 3: Contención

El objetivo de la contención es **limitar el daño** y **prevenir la propagación** del incidente mientras se preserva la evidencia.

#### 3.1 Estrategias de Contención por Tipo de Incidente

| Tipo | Contención Inmediata | Contención a Corto Plazo |
|------|---------------------|-------------------------|
| **Ransomware** | Desconectar endpoint de red (NO apagar). Bloquear IOCs en FortiGate. | Aislar segmento de red. Deshabilitar SMB/RDP entre segmentos. |
| **Phishing** | Bloquear dominio/remitente en email gateway. Revocar sesiones comprometidas. | Resetear credenciales afectadas. Revisar reglas de correo. |
| **BEC** | Bloquear transferencias financieras pendientes. Notificar banco. | Revisar reglas de reenvío. Auditar accesos a correo. |
| **Data Breach** | Bloquear canales de exfiltración. Aislar sistemas comprometidos. | Revisar accesos a datos sensibles. Implementar DLP. |
| **Insider Threat** | Revocar accesos de forma controlada (sin alertar al sospechoso inicialmente). | Monitoreo aumentado. Preservar evidencia forense. |

#### 3.2 Contención con Herramientas BRIDA

**CrowdStrike Falcon:**
```
# Aislar endpoint (Network Containment)
1. Falcon Console → Host Management → Seleccionar host
2. Actions → Contain → Network Containment: Full
# Bloquear hash (IOC)
1. Falcon Console → Configuration → IOC Management
2. Agregar hash SHA256 → Action: Block, Detect, or Blocking
# Ejecutar respuesta en vivo (Live Response)
1. Falcon Console → Host → Live Response
2. Comandos: ps, netstat, reg query, get <archivo>
```

**Trellix ePO:**
```
# Poner endpoint en cuarentena
1. ePO Console → Systems → Seleccionar sistema
2. Actions → Quarantine → Full Quarantine
# Actualizar políticas de detección
1. ePO Console → Policy → Policy Catalog
2. Modificar reglas de Access Protection
```

**FortiGate:**
```
# Bloquear IP maliciosa
config firewall address
    edit "MALICIOUS_IP"
        set type ipmask
        set subnet 203.0.113.50 255.255.255.255
        set associated-interface "internal"
    next
end

# Crear política de bloqueo
config firewall policy
    edit 0
        set srcintf "internal"
        set dstintf "wan1"
        set srcaddr "all"
        set dstaddr "MALICIOUS_IP"
        set action deny
        set schedule "always"
        set logtraffic all
    next
end

# Aislar VLAN (emergencia)
config system interface
    edit "vlan-isolated"
        set vlanid 999
        set interface "internal"
        set vlanforward disable
    next
end
```

**Qualys:**
```
# Escaneo de emergencia de vulnerabilidades
1. Qualys VM → Scans → New Scan
2. Seleccionar asset group afectado
3. Template: "Critical Vulnerabilities"
4. Launch scan inmediato
# Verificar parches faltantes
1. Qualys VM → Reports → Host Based
2. Filtrar por hosts afectados
3. Identificar vulnerabilidades explotadas
```

#### 3.3 Decisiones de Contención

| Decisión | Criterio | Riesgo |
|----------|----------|--------|
| **Aislar endpoint** | Confirmada actividad maliciosa en un host | Pérdida temporal de servicio |
| **Bloquear tráfico** | IOCs confirmados (IP, dominio) | Posible bloqueo de tráfico legítimo |
| **Deshabilitar cuenta** | Cuenta de usuario comprometida | Impacto en productividad |
| **Aislar segmento de red** | Propagación lateral confirmada | Impacto en múltiples sistemas |
| **Apagar sistema** | Último recurso (ej: daño físico inminente) | Pérdida de evidencia volátil |

> **⚠️ IMPORTANTE**: Nunca apague un sistema comprometido como primera acción. La memoria RAM contiene evidencia volátil crítica. Siempre realice adquisición de memoria antes de apagar.

---

### Fase 4: Erradicación

La erradicación implica **eliminar completamente** la amenaza del entorno y **restaurar la confianza** en los sistemas afectados.

#### 4.1 Actividades de Erradicación

1. **Eliminar malware**: Usar CrowdStrike Falcon y Trellix ePO para eliminar archivos maliciosos.
2. **Eliminar persistencia**: Revisar y eliminar mecanismos de persistencia:
   - Registry Run keys
   - Scheduled tasks
   - Services
   - WMI subscriptions
   - Startup folders
   - DLL hijacking
3. **Parchear vulnerabilidades**: Aplicar parches para las vulnerabilidades explotadas (usar Qualys para verificar).
4. **Restablecer credenciales**: Resetear contraseñas de todas las cuentas potencialmente comprometidas.
5. **Eliminar backdoors**: Verificar y eliminar cuentas no autorizadas, SSH keys, web shells.
6. **Actualizar reglas de detección**: Agregar nuevos IOCs y reglas de detección a todas las herramientas.
7. **Verificar integridad**: Comparar con baselines conocidos (hashes, configuraciones).

#### 4.2 Verificación de Erradicación

| Verificación | Herramienta | Criterio de Éxito |
|--------------|-------------|-------------------|
| Escaneo completo de malware | CrowdStrike Falcon + Trellix ePO | 0 detecciones |
| Búsqueda de IOCs | CrowdStrike Falcon (IOC sweep) | 0 coincidencias |
| Verificación de vulnerabilidades | Qualys | Vulnerabilidades críticas remediadas |
| Análisis de red | FortiGate logs | Sin tráfico C2 |
| Verificación de cuentas | Active Directory | Sin cuentas no autorizadas |
| Escaneo de web shells | Manual + herramienta | 0 web shells |

---

### Fase 5: Recuperación

La recuperación busca **restaurar los sistemas afectados** a su operación normal de manera segura y verificable.

#### 5.1 Proceso de Recuperación

1. **Restaurar desde backups limpios**:
   - Verificar integridad del backup antes de restaurar.
   - Restaurar en entorno aislado primero para verificación.
   - Comparar con baseline conocido.
2. **Reconstruir sistemas**:
   - Si la integridad no puede verificarse, reconstruir desde cero.
   - Aplicar hardening antes de reconectar a la red.
3. **Reconectar gradualmente**:
   - Reconectar sistemas de forma incremental.
   - Monitorear intensivamente durante las primeras 72 horas.
4. **Verificar funcionalidad**:
   - Pruebas de funcionalidad del negocio.
   - Verificación de rendimiento.
   - Confirmación de que la amenaza ha sido erradicada.

#### 5.2 Monitoreo Post-Recuperación

| Período | Actividad | Herramienta |
|---------|-----------|-------------|
| 0-24 horas | Monitoreo continuo, alertas en tiempo real | CrowdStrike Falcon, SIEM |
| 24-72 horas | Escaneos programados cada 4 horas | Trellix ePO, Qualys |
| 1-2 semanas | Monitoreo aumentado, revisión diaria de logs | Todas las herramientas |
| 1-3 meses | Monitoreo estándar con atención a IOCs relacionados | Todas las herramientas |

#### 5.3 Criterios para Declarar el Incidente como Resuelto

- [ ] Amenaza completamente erradicada (verificado por escaneo completo)
- [ ] Todos los sistemas restaurados y funcionando normalmente
- [ ] Vulnerabilidades explotadas parcheadas
- [ ] Credenciales comprometidas restablecidas
- [ ] Monitoreo post-recuperación activo
- [ ] Reporte post-incidente completado
- [ ] Lecciones aprendidas documentadas
- [ ] Aprobación del IR Lead para cierre

---

### Fase 6: Actividad Post-Incidente (Lecciones Aprendidas)

#### 6.1 Reunión de Lecciones Aprendidas (Lessons Learned)

**Cuándo**: Dentro de las 2 semanas posteriores al cierre del incidente.

**Participantes**: Todo el equipo IR involucrado, stakeholders relevantes.

**Agenda**:
1. Cronología del incidente (timeline)
2. ¿Qué salió bien?
3. ¿Qué salió mal?
4. ¿Qué se puede mejorar?
5. Acciones de mejora (con responsables y fechas)
6. Actualización de playbooks y procedimientos

#### 6.2 Métricas Post-Incidente

| Métrica | Descripción |
|---------|-------------|
| **MTTD** (Mean Time to Detect) | Tiempo desde el compromiso inicial hasta la detección |
| **MTTR** (Mean Time to Respond) | Tiempo desde la detección hasta la contención |
| **MTTC** (Mean Time to Contain) | Tiempo desde la contención hasta la erradicación |
| **MTTREC** (Mean Time to Recover) | Tiempo desde la erradicación hasta la recuperación completa |
| **Scope** | Número de sistemas, usuarios y datos afectados |
| **Impact** | Impacto financiero, operacional y reputacional |
| **Root Cause** | Causa raíz identificada |
| **Detection Gap** | Por qué los controles existentes no detectaron el incidente antes |

#### 6.3 Retención de Evidencia Post-Incidente

- Toda la evidencia debe retenerse según la política de retención de BRIDA (mínimo 2 años, o según requisitos regulatorios).
- Documentación del incidente archivada de forma segura.
- IOCs y TTPs compartidos con el equipo de Threat Intelligence.

---

## 3. Herramientas del Stack de BRIDA

### 3.1 Matriz de Uso por Fase

| Herramienta | Preparación | Detección | Contención | Erradicación | Recuperación |
|-------------|:-----------:|:---------:|:----------:|:------------:|:------------:|
| **CrowdStrike Falcon** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Trellix ePO** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **FortiGate** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Qualys** | ✅ | ✅ | ❌ | ✅ | ✅ |
| **SIEM** | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Herramientas forenses** | ✅ | ✅ | ✅ | ✅ | ❌ |

### 3.2 Comandos de Referencia Rápida

**CrowdStrike Falcon (Live Response):**
```bash
# Listar procesos
ps
# Conexiones de red
netstat
# Archivos en directorio sospechoso
ls "C:\Users\Public\"
# Obtener archivo para análisis
get "C:\Windows\Temp\suspicious.exe"
# Consulta al registro
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"
# Tareas programadas
run schtasks /query /fo LIST /v
# Información del sistema
systeminfo
```

**FortiGate (CLI):**
```bash
# Ver sesiones activas
diagnose sys session list
# Bloquear IP inmediatamente
execute firewall iprope set 203.0.113.50 action deny
# Ver logs de tráfico
diagnose sniffer packet any "host 203.0.113.50" 4
# Ver políticas de firewall
show firewall policy
# Estadísticas de interfaz
diagnose hardware deviceinfo nic <interface>
```

**Trellix ePO:**
```bash
# Forzar actualización de DAT
cmdagent /u
# Forzar escaneo completo
cmdagent /s
# Ver estado del agente
cmdagent /status
```

---

## 4. Playbooks de Incidentes

### Playbook: Ransomware

> **Severidad por defecto**: P1 (Crítico)
> **MITRE ATT&CK**: TA0040 (Impact) — T1486 (Data Encrypted for Impact), T1490 (Inhibit System Recovery)

#### Detección

| Indicador | Fuente | Prioridad |
|-----------|--------|-----------|
| Archivos con extensión cifrada (.locked, .encrypted, .crypto, etc.) | CrowdStrike Falcon, usuario | Crítica |
| Nota de ransom (README_DECRYPT.txt, etc.) | Usuario, EDR | Crítica |
| Alto uso de CPU/disco en múltiples endpoints | CrowdStrike Falcon, SIEM | Alta |
| Modificación masiva de archivos | CrowdStrike Falcon | Alta |
| Elimination de Shadow Copies (vssadmin delete shadows) | CrowdStrike Falcon | Crítica |
| Deshabilitar Windows Defender / CrowdStrike | CrowdStrike Falcon | Crítica |
| Movimiento lateral (SMB, RDP, PsExec) | CrowdStrike Falcon, FortiGate | Alta |

#### Procedimiento de Respuesta

**Paso 1 — Contención Inmediata (0-15 min)**
```
1. NO apagar los sistemas afectados
2. Desconectar de red (Network Containment en CrowdStrike Falcon)
3. Bloquear IOCs conocidos en FortiGate (IPs C2, dominios)
4. Aislar segmentos de red afectados
5. Deshabilitar SMB/RDP entre segmentos
6. Notificar al IR Lead y activar CSIRT
7. Iniciar documentación del incidente
```

**Paso 2 — Análisis (15-60 min)**
```
1. Identificar el ransomware (ID Ransomware: https://id-ransomware.malwarehunterteam.com/)
2. Determinar el alcance (¿cuántos sistemas afectados?)
3. Identificar el vector de entrada inicial
4. Verificar si hay decryptor disponible (No More Ransom: https://www.nomoreransom.org/)
5. Verificar estado de backups (¿están limpios? ¿cuándo fue el último backup?)
6. Mapear TTPs a MITRE ATT&CK
7. Recolectar IOCs (hashes, IPs, dominios, extensiones)
```

**Paso 3 — Contención Extendida (1-4 horas)**
```
1. Bloquear IOCs en todas las herramientas (Falcon, FortiGate, Trellix, email gateway)
2. Deshabilitar cuentas comprometidas
3. Resetear credenciales de administrador
4. Bloquear comunicación C2 en FortiGate
5. Realizar sweep de IOCs en todo el entorno
6. Verificar integridad de backups
```

**Paso 4 — Erradicación (4-24 horas)**
```
1. Eliminar malware de todos los sistemas afectados
2. Eliminar mecanismos de persistencia
3. Parchear vulnerabilidades explotadas
4. Restablecer todas las credenciales potencialmente comprometidas
5. Eliminar cuentas de administrador no autorizadas
6. Verificar que no hay backdoors
```

**Paso 5 — Recuperación (24-72 horas)**
```
1. Restaurar sistemas desde backups limpios
2. Reconectar sistemas de forma gradual y monitoreada
3. Verificar funcionalidad del negocio
4. Monitoreo aumentado durante 30 días
```

#### Mapeo MITRE ATT&CK

| Táctica | Técnica | ID |
|---------|---------|-----|
| Initial Access | Phishing | T1566 |
| Execution | Command and Scripting Interpreter | T1059 |
| Persistence | Registry Run Keys | T1547.001 |
| Privilege Escalation | Valid Accounts | T1078 |
| Defense Evasion | Disable or Modify Tools | T1562.001 |
| Lateral Movement | Remote Services (SMB/RDP) | T1021 |
| Impact | Data Encrypted for Impact | T1486 |
| Impact | Inhibit System Recovery | T1490 |

#### Mapeo NIST CSF

| Función | Categoría | Subcategoría |
|---------|-----------|-------------|
| **DE** (Detect) | Anomalies and Events | DE.AE-1, DE.AE-3 |
| **DE** (Detect) | Security Continuous Monitoring | DE.CM-1, DE.CM-7 |
| **RS** (Respond) | Response Planning | RS.RP-1 |
| **RS** (Respond) | Mitigation | RS.MI-1, RS.MI-2 |
| **RC** (Recover) | Recovery Planning | RC.RP-1 |

#### Mapeo D3FEND

| Técnica D3FEND | Descripción |
|----------------|-------------|
| **D3-NTA** (Network Traffic Analysis) | Análisis de tráfico para detectar C2 |
| **D3-PSA** (Process Analysis) | Análisis de procesos para detectar ransomware |
| **D3-FCA** (File Content Analysis) | Análisis de contenido de archivos |
| **D3-ICA** (Identifier Analysis) | Análisis de identificadores (hashes) |
| **D3-NTCD** (Network Isolation) | Aislamiento de red |
| **D3-RRDD** (Restore Restore Disk Image) | Restauración desde imagen de disco |

---

### Playbook: Phishing / Spear-Phishing

> **Severidad por defecto**: P2 (Alto) — P1 si hay compromiso confirmado
> **MITRE ATT&CK**: TA0001 (Initial Access) — T1566.001 (Phishing: Spearphishing Attachment), T1566.002 (Phishing: Spearphishing Link)

#### Detección

| Indicador | Fuente | Prioridad |
|-----------|--------|-----------|
| Usuario reporta correo sospechoso | Usuario, helpdesk | Alta |
| Email con adjunto malicioso detectado | Email gateway, Trellix | Alta |
| URL maliciosa en correo | Email gateway, proxy | Alta |
| Credenciales comprometidas (login anómalo) | SIEM, IdP | Crítica |
| Malware ejecutándose tras abrir adjunto | CrowdStrike Falcon | Crítica |

#### Procedimiento de Respuesta

**Paso 1 — Triaje (0-30 min)**
```
1. Analizar el correo sospechoso:
   - Headers completos
   - URLs (no hacer click, usar sandbox)
   - Adjuntos (analizar en sandbox)
   - Remitente (verificar SPF, DKIM, DMARC)
2. Determinar si es phishing genérico o spear-phishing dirigido
3. Identificar a todos los destinatarios del correo
4. Verificar si algún destinatario interactuó con el correo
```

**Paso 2 — Contención (30-60 min)**
```
1. Bloquear remitente/dominio en email gateway
2. Bloquear URLs maliciosas en proxy/firewall (FortiGate)
3. Eliminar el correo de todas las bandejas (purge)
4. Si se hizo click en URL: aislar endpoint, analizar con CrowdStrike
5. Si se abrió adjunto: aislar endpoint, análisis forense
6. Si se ingresaron credenciales: resetear contraseña inmediatamente, revocar sesiones
```

**Paso 3 — Análisis (1-4 horas)**
```
1. Analizar el correo completo (headers, URLs, adjuntos)
2. Identificar IOCs (URLs, hashes de adjuntos, remitentes)
3. Verificar si hay compromiso adicional (malware, credenciales)
4. Mapear a MITRE ATT&CK
5. Determinar si es parte de una campaña más amplia
```

**Paso 4 — Erradicación y Recuperación**
```
1. Eliminar malware si existe
2. Resetear credenciales de cuentas afectadas
3. Revocar tokens de sesión
4. Actualizar reglas de email gateway
5. Bloquear IOCs en todas las herramientas
6. Capacitación de usuarios afectados
```

#### Mapeo MITRE ATT&CK

| Táctica | Técnica | ID |
|---------|---------|-----|
| Initial Access | Spearphishing Attachment | T1566.001 |
| Initial Access | Spearphishing Link | T1566.002 |
| Execution | User Execution | T1204 |
| Collection | Credential Harvesting | T1598 |

#### Mapeo NIST CSF

| Función | Categoría | Subcategoría |
|---------|-----------|-------------|
| **PR** (Protect) | Awareness and Training | PR.AT-1, PR.AT-2 |
| **DE** (Detect) | Anomalies and Events | DE.AE-2, DE.AE-5 |
| **RS** (Respond) | Communications | RS.CO-1, RS.CO-2 |

#### Mapeo D3FEND

| Técnica D3FEND | Descripción |
|----------------|-------------|
| **D3-DA** (Dynamic Analysis) | Análisis dinámico de adjuntos en sandbox |
| **D3-UA** (URL Analysis) | Análisis de URLs |
| **D3-ETI** (Email Filtering) | Filtrado de correo electrónico |
| **D3-ANAA** (Authentication Behavior Analysis) | Análisis de comportamiento de autenticación |

---

### Playbook: Business Email Compromise (BEC)

> **Severidad por defecto**: P1 (Crítico)
> **MITRE ATT&CK**: TA0001 (Initial Access) — T1566.003 (Phishing: Spearphishing via Service), TA0006 (Credential Access) — T1589 (Gather Victim Identity Information)

#### Detección

| Indicador | Fuente | Prioridad |
|-----------|--------|-----------|
| Solicitud inusual de transferencia financiera | Usuario, finanzas | Crítica |
| Correo de "CEO" o proveedor con instrucciones urgentes | Usuario | Alta |
| Reglas de reenvío no autorizadas en correo | Email admin, SIEM | Alta |
| Acceso desde ubicación/IP anómala | IdP, SIEM | Alta |
| Cuenta de correo comprometida | SIEM, CrowdStrike | Crítica |

#### Procedimiento de Respuesta

**Paso 1 — Verificación Inmediata (0-15 min)**
```
1. Verificar la legitimidad de la solicitud por CANAL ALTERNATIVO
   (llamada telefónica al remitente conocido, NO responder al correo)
2. Si hay transferencia financiera en curso: CONTACTAR AL BANCO INMEDIATAMENTE
3. Bloquear la transacción si es posible
4. Notificar al CFO/Director Financiero
5. Activar el CSIRT
```

**Paso 2 — Contención (15-60 min)**
```
1. Bloquear la cuenta de correo comprometida
2. Revocar todas las sesiones activas
3. Resetear credenciales
4. Eliminar reglas de reenvío no autorizadas
5. Bloquear dominios similares (typosquatting) en FortiGate y email gateway
6. Notificar al banco y solicitar recall de transferencia
7. Contactar a las autoridades (fiscalía, policía cibernética)
```

**Paso 3 — Análisis (1-8 horas)**
```
1. Analizar la cuenta comprometida:
   - Reglas de correo (reenvío, eliminación)
   - Actividad de login (IP, geolocalización, hora)
   - Correos enviados desde la cuenta
   - Contactos afectados
2. Identificar el vector de compromiso (phishing, credential stuffing, etc.)
3. Determinar el alcance (¿otras cuentas comprometidas?)
4. Rastrear el destino de los fondos transferidos
5. Recolectar toda la evidencia para investigación legal
```

**Paso 4 — Erradicación y Recuperación**
```
1. Restablecer credenciales de todas las cuentas afectadas
2. Implementar MFA en todas las cuentas de correo (si no estaba activo)
3. Eliminar reglas de correo no autorizadas
4. Bloquear IOCs en todas las herramientas
5. Notificar a clientes/proveedores afectados
6. Iniciar proceso de recuperación de fondos con el banco
7. Presentar denuncia formal ante autoridades
```

#### Mapeo MITRE ATT&CK

| Táctica | Técnica | ID |
|---------|---------|-----|
| Initial Access | Spearphishing via Service | T1566.003 |
| Credential Access | Phishing for Information | T1598 |
| Collection | Email Collection | T1114 |
| Persistence | Account Manipulation | T1098 |

#### Mapeo NIST CSF

| Función | Categoría | Subcategoría |
|---------|-----------|-------------|
| **ID** (Identify) | Risk Assessment | ID.RA-1, ID.RA-5 |
| **PR** (Protect) | Awareness and Training | PR.AT-1, PR.AT-3 |
| **DE** (Detect** | Anomalies and Events | DE.AE-1, DE.AE-3 |
| **RS** (Respond) | Communications | RS.CO-1, RS.CO-2, RS.CO-4 |
| **RC** (Recover) | Recovery Planning | RC.RP-1 |

#### Mapeo D3FEND

| Técnica D3FEND | Descripción |
|----------------|-------------|
| **D3-ETI** (Email Filtering) | Filtrado avanzado de correo |
| **D3-ANAA** (Authentication Behavior Analysis) | Detección de login anómalo |
| **D3-DKIM** (DKIM Verification) | Verificación de autenticidad de correo |
| **D3-SPP** (Strong Password Policies) | Políticas de contraseñas robustas |
| **D3-MFA** (Multi-factor Authentication) | Autenticación multifactor |

---

### Playbook: Data Breach / Fuga de Datos

> **Severidad por defecto**: P1 (Crítico)
> **MITRE ATT&CK**: TA0010 (Exfiltration) — T1041 (Exfiltration Over C2 Channel), T1567 (Exfiltration Over Web Service), TA0009 (Collection) — T1005 (Data from Local System)

#### Detección

| Indicador | Fuente | Prioridad |
|-----------|--------|-----------|
| Tráfico de salida anómalo (gran volumen) | FortiGate, SIEM | Crítica |
| Acceso no autorizado a datos sensibles | DLP, SIEM, base de datos | Crítica |
| Datos de la empresa en dark web / paste sites | Threat intel, monitoreo | Crítica |
| Alerta de DLP (Data Loss Prevention) | DLP, SIEM | Alta |
| Descarga masiva de datos desde aplicaciones | SIEM, application logs | Alta |

#### Procedimiento de Respuesta

**Paso 1 — Confirmación Inicial (0-30 min)**
```
1. Confirmar que ha ocurrido una fuga de datos
2. Identificar qué tipo de datos se han filtrado (PII, financieros, IP, credenciales)
3. Determinar el volumen de datos afectados
4. Identificar el origen de la fuga
5. Activar CSIRT y notificar a Legal Counsel
6. Iniciar documentación detallada (será requerida para notificación regulatoria)
```

**Paso 2 — Contención (30 min - 4 horas)**
```
1. Bloquear el canal de exfiltración (FortiGate, proxy)
2. Aislar los sistemas de datos afectados
3. Revocar accesos comprometidos
4. Preservar logs y evidencia
5. Capturar tráfico de red actual
6. Identificar todos los datos que pueden haber sido expuestos
7. Notificar a la alta dirección
```

**Paso 3 — Análisis Forense (4-48 horas)**
```
1. Determinar la causa raíz de la fuga
2. Identificar todos los datos afectados (tipo, volumen, sujetos)
3. Rastrear el movimiento de datos dentro y fuera de la organización
4. Identificar al responsable (atacante externo o insider)
5. Evaluar el impacto regulatorio (GDPR, leyes locales de protección de datos)
6. Documentar la cronología completa del incidente
7. Preparar documentación para notificación regulatoria
```

**Paso 4 — Notificación y Cumplimiento**
```
1. Notificar a la autoridad de protección de datos (plazo según regulación local)
2. Notificar a los individuos afectados (si es requerido)
3. Notificar a las autoridades policiales (si aplica)
4. Preparar comunicación pública (con aprobación de Legal y Comms)
5. Ofrecer servicios de monitoreo de crédito/identidad a afectados (si aplica)
6. Documentar todas las notificaciones realizadas
```

**Paso 5 — Erradicación y Recuperación**
```
1. Eliminar el vector de exfiltración
2. Implementar controles DLP adicionales
3. Reforzar controles de acceso a datos sensibles
4. Cifrar datos sensibles en reposo y en tránsito
5. Implementar monitoreo de acceso a datos críticos
6. Revisar y actualizar políticas de clasificación de datos
```

#### Mapeo MITRE ATT&CK

| Táctica | Técnica | ID |
|---------|---------|-----|
| Collection | Data from Local System | T1005 |
| Collection | Data from Cloud Storage | T1530 |
| Exfiltration | Exfiltration Over C2 Channel | T1041 |
| Exfiltration | Exfiltration Over Web Service | T1567 |
| Exfiltration | Exfiltration to Cloud Storage | T1567.002 |

#### Mapeo NIST CSF

| Función | Categoría | Subcategoría |
|---------|-----------|-------------|
| **ID** (Identify) | Asset Management | ID.AM-1, ID.AM-2 |
| **ID** (Identify) | Governance | ID.GV-1, ID.GV-4 |
| **PR** (Protect) | Data Security | PR.DS-1, PR.DS-2, PR.DS-5 |
| **DE** (Detect** | Security Continuous Monitoring | DE.CM-1, DE.CM-3, DE.CM-7 |
| **RS** (Respond) | Response Planning | RS.RP-1 |
| **RS** (Respond) | Communications | RS.CO-1, RS.CO-2, RS.CO-3 |

#### Mapeo D3FEND

| Técnica D3FEND | Descripción |
|----------------|-------------|
| **D3-DI** (Data Inventory) | Inventario de datos |
| **D3-DK** (Data Encryption) | Cifrado de datos |
| **D3-DI** (Dynamic Analysis) | Análisis dinámico de comportamiento |
| **D3-NTA** (Network Traffic Analysis) | Detección de exfiltración |
| **D3-FEM** (File Encryption) | Cifrado de archivos |
| **D3-RA** (Runtime Analysis) | Análisis en tiempo de ejecución |

---

### Playbook: Insider Threat / Amenaza Interna

> **Severidad por defecto**: P1-P2 (Alto a Crítico)
> **MITRE ATT&CK**: TA0009 (Collection), TA0010 (Exfiltration), TA0005 (Defense Evasion) — T1562 (Impair Defenses), T1565 (Data Manipulation)

#### Detección

| Indicador | Fuente | Prioridad |
|-----------|--------|-----------|
| Acceso a datos fuera del horario laboral | SIEM, DLP | Alta |
| Descarga masiva de datos sensibles | DLP, SIEM | Crítica |
| Desactivación de controles de seguridad | CrowdStrike Falcon, Trellix ePO | Crítica |
| Acceso a sistemas fuera de su rol | SIEM, IAM | Alta |
| Uso de herramientas de anonimización (Tor, VPN) | FortiGate, proxy | Alta |
| Comportamiento errático o señales de insatisfacción | Reporte de colegas, HR | Media |
| Copia de datos a servicios cloud personales | DLP, proxy | Alta |

#### Procedimiento de Respuesta

> **⚠️ PRECAUCIÓN ESPECIAL**: En casos de amenaza interna, las acciones deben ser coordinadas con **Legal** y **Recursos Humanos**. La evidencia debe ser recolectada de forma que sea admisible legalmente. No alertar al sospechoso prematuramente.

**Paso 1 — Evaluación Inicial (0-2 horas)**
```
1. Evaluar la credibilidad del reporte/alerta
2. Notificar a Legal Counsel y HR (de forma confidencial)
3. Revisar el perfil del sospechoso (rol, accesos, historial)
4. Determinar si hay riesgo inminente de daño
5. Decidir si se requiere monitoreo encubierto
6. Establecer equipo de respuesta reducido (need-to-know)
```

**Paso 2 — Investigación Discreta (2-72 horas)**
```
1. Revisar logs de acceso del sospechoso (SIEM, IAM)
2. Analizar actividad de red (FortiGate, proxy)
3. Revisar uso de endpoints (CrowdStrike Falcon, Trellix ePO)
4. Verificar uso de dispositivos USB (logs de DLP)
5. Analizar actividad de correo electrónico
6. Revisar accesos a datos sensibles
7. Documentar toda la evidencia con timestamps
8. Mantener la investigación estrictamente confidencial
```

**Paso 3 — Contención (cuando se tenga evidencia suficiente)**
```
1. Coordinar con Legal y HR el momento de la acción
2. Revocar accesos de forma simultánea (red, correo, aplicaciones, físico)
3. Recolectar evidencia forense de dispositivos asignados
4. Preservar logs y registros
5. Asegurar dispositivos físicos (laptop, teléfono)
6. Realizar entrevista (con presencia de Legal y HR)
```

**Paso 4 — Erradicación y Recuperación**
```
1. Eliminar cualquier backdoor o acceso persistente
2. Verificar integridad de datos potencialmente manipulados
3. Restablecer credenciales que el sospechoso conocía
4. Auditar todos los accesos del sospechuto durante el período de compromiso
5. Implementar controles adicionales para prevenir recurrencia
6. Gestionar la salida del empleado (si aplica)
7. Documentar todo el proceso para posibles acciones legales
```

#### Mapeo MITRE ATT&CK

| Táctica | Técnica | ID |
|---------|---------|-----|
| Collection | Data from Local System | T1005 |
| Collection | Email Collection | T1114 |
| Exfiltration | Exfiltration over USB | T1052.001 |
| Exfiltration | Exfiltration to Cloud Storage | T1567.002 |
| Defense Evasion | Disable or Modify Tools | T1562.001 |
| Defense Evasion | Indicator Removal | T1070 |
| Impact | Data Manipulation | T1565 |

#### Mapeo NIST CSF

| Función | Categoría | Subcategoría |
|---------|-----------|-------------|
| **ID** (Identify) | Risk Assessment | ID.RA-1, ID.RA-3, ID.RA-6 |
| **PR** (Protect) | Awareness and Training | PR.AT-1, PR.AT-4 |
| **PR** (Protect) | Data Security | PR.DS-1, PR.DS-2 |
| **DE** (Detect) | Security Continuous Monitoring | DE.CM-1, DE.CM-3, DE.CM-7 |
| **DE** (Detect) | Detection Processes | DE.DP-1, DE.DP-4 |
| **RS** (Respond) | Response Planning | RS.RP-1 |
| **RS** (Respond) | Communications | RS.CO-1, RS.CO-2 |

#### Mapeo D3FEND

| Técnica D3FEND | Descripción |
|----------------|-------------|
| **D3-UBA** (User Behavior Analysis) | Análisis de comportamiento de usuario |
| **D3-DI** (Data Inventory) | Inventario y clasificación de datos |
| **D3-ACL** (Access Control) | Control de acceso granular |
| **D3-NTA** (Network Traffic Analysis) | Monitoreo de tráfico de red |
| **D3-FEM** (File Encryption) | Cifrado de archivos sensibles |
| **D3-AI** (Asset Inventory) | Inventario de activos |

---

## 5. Recolección de Evidencia

### 5.1 Orden de Volatilidad

La evidencia debe recolectarse en orden de volatilidad (de más volátil a menos volatilidad), siguiendo el protocolo RFC 3227:

| Prioridad | Tipo de Evidencia | Volatilidad | Herramienta |
|:---------:|-------------------|-------------|------------|
| 1 | Registros de CPU, caché | Muy alta | Herramientas forenses especializadas |
| 2 | Memoria RAM (volatile memory) | Muy alta | WinPMEM, FTK Imager, Magnet RAM Capture |
| 3 | Estado de red (conexiones, sesiones) | Alta | `netstat`, Wireshark, `ss` |
| 4 | Procesos en ejecución | Alta | `ps`, CrowdStrike Falcon, Process Hacker |
| 5 | Archivos temporales | Media-alta | KAPE, manual |
| 6 | Disco (particiones activas) | Media | FTK Imager, dd, Guymager |
| 7 | Logs del sistema | Media | SIEM, Event Viewer, syslog |
| 8 | Configuración del sistema | Media-baja | `systeminfo`, `reg export` |
| 9 | Disco (archivos eliminados) | Baja | FTK Imager, Autopsy, PhotoRec |
| 10 | Backups | Muy baja | Sistema de backup |
| 11 | Archivos de red/archivados | Muy baja | Repositorios de logs |

### 5.2 Procedimiento de Recolección

#### Memoria RAM
```bash
# Windows - Usando WinPMEM
winpmem_mini_x64.exe output.raw

# Linux - Usando LiME
sudo insmod lime-$(uname -r).ko "path=/evidence/memdump.lime format=lime"

# Verificación de integridad
sha256sum output.raw > output.raw.sha256
```

#### Disco (Imagen Forense)
```bash
# Usando FTK Imager
# 1. Seleccionar "Create Disk Image"
# 2. Seleccionar fuente (Physical Drive / Logical Drive)
# 3. Formato: E01 (Expert Witness Format) o RAW (dd)
# 4. Completar caso información
# 5. Verificar hashes automáticamente

# Usando dd (Linux)
dd if=/dev/sda of=/evidence/disk_image.dd bs=4M conv=noerror,sync
sha256sum /evidence/disk_image.dd > /evidence/disk_image.dd.sha256
```

#### Evidencia de Red
```bash
# Captura de paquetes con tcpdump
tcpdump -i eth0 -w /evidence/capture.pcap -C 100 -W 10

# Captura con Wireshark (GUI)
# 1. Seleccionar interfaz
# 2. Aplicar filtro si es necesario
# 3. Iniciar captura
# 4. Exportar como .pcapng

# NetFlow/sFlow
# Configurar exportación desde FortiGate a colector
```

#### Evidencia de Logs
```bash
# Windows Event Logs
wevtutil epl System /evidence/System.evtx
wevtutil epl Security /evidence/Security.evtx
wevtutil epl Application /evidence/Application.evtx
wevtutil epl "Microsoft-Windows-Sysmon/Operational" /evidence/Sysmon.evtx

# Linux Logs
cp /var/log/syslog /evidence/
cp /var/log/auth.log /evidence/
cp /var/log/kern.log /evidence/

# Logs de aplicaciones
# Copiar logs relevantes de la aplicación afectada
```

### 5.3 Integridad de la Evidencia

- **Hashing**: Generar hash SHA-256 de toda la evidencia recolectada.
- **Verificación**: Verificar hashes antes y después de la transferencia.
- **Almacenamiento**: Almacenar evidencia en medio write-once o con protección de escritura.
- **Documentación**: Registrar hash, fecha, hora, recolector y descripción de cada pieza de evidencia.

### 5.4 Checklist de Recolección

- [ ] Fotografía del estado de la pantalla (si está encendido)
- [ ] Registro de fecha/hora del sistema y comparación con hora real
- [ ] Captura de conexiones de red activas
- [ ] Captura de procesos en ejecución
- [ ] Volcado de memoria RAM
- [ ] Imagen forense de disco(s)
- [ ] Logs del sistema operativo
- [ ] Logs de aplicaciones relevantes
- [ ] Logs de seguridad (EDR, firewall, proxy)
- [ ] Configuración de red (IP, rutas, DNS)
- [ ] Archivos sospechosos (copiar, no mover)
- [ ] Hashes SHA-256 de toda la evidencia
- [ ] Cadena de custodia iniciada

---

## 6. Cadena de Custodia

### 6.1 Definición

La cadena de custodia (Chain of Custody) es el documento que registra **quién, cuándo, dónde y cómo** se ha manejado cada pieza de evidencia, desde su recolección hasta su presentación.

### 6.2 Formato de Cadena de Custodia

```
═══════════════════════════════════════════════════════════════
           CADENA DE CUSTODIA — BRIDA IT SERVICES
═══════════════════════════════════════════════════════════════

Número de Caso:     IR-2024-XXXX
Fecha de Apertura:  DD/MM/AAAA HH:MM TZ
Analista Principal:  [Nombre]
Descripción:         [Descripción del incidente]

───────────────────────────────────────────────────────────────
EVIDENCIA #001
───────────────────────────────────────────────────────────────
Tipo de Evidencia:   [Memoria RAM / Disco / Logs / Captura de red]
Descripción:         [Descripción detallada]
ID del Activo:       [Hostname / Serial Number]
Ubicación Original:  [Ubicación física/lógica]
Hash SHA-256 (Orig): [hash]
Hash SHA-256 (Copy): [hash]
Medio de Almacenamiento: [USB forense / Servidor seguro / etc.]

REGISTRO DE TRANSFERENCIAS:
┌────┬────────────┬──────────────┬──────────────┬─────────────┬──────────┐
│ #  │ Fecha/Hora │ De           │ A            │ Propósito   │ Firma    │
├────┼────────────┼──────────────┼──────────────┼─────────────┼──────────┤
│ 01 │            │              │              │ Recolección │          │
│ 02 │            │              │              │ Análisis    │          │
│ 03 │            │              │              │ Almacenaje  │          │
│ 04 │            │              │              │             │          │
│ 05 │            │              │              │             │          │
└────┴────────────┴──────────────┴──────────────┴─────────────┴──────────┘

NOTAS:
[Cualquier observación relevante sobre la evidencia]

═══════════════════════════════════════════════════════════════
```

### 6.3 Reglas de Cadena de Custodia

1. **Toda transferencia debe documentarse**: Sin excepciones.
2. **Mínimo dos personas** deben verificar cada transferencia.
3. **La evidencia debe almacenarse** en un lugar seguro con control de acceso.
4. **Nunca modificar la evidencia original**: Siempre trabajar sobre copias.
5. **Verificar hashes** en cada transferencia.
6. **Documentar cualquier anomalía**: Si la evidencia no coincide con lo esperado, documentar inmediatamente.
7. **Retención mínima**: 2 años o según requisitos regulatorios.

### 6.4 Almacenamiento Seguro de Evidencia

| Requisito | Implementación |
|-----------|---------------|
| Control de acceso | Solo personal autorizado (IR team) |
| Cifrado | AES-256 para evidencia en tránsito y reposo |
| Integridad | Verificación periódica de hashes |
| Redundancia | Copia de seguridad en ubicación separada |
| Registro de acceso | Log de quién accedió a la evidencia y cuándo |
| Protección física | Caja fuerte o sala segura para medios físicos |

---

## 7. Plantillas de Comunicación

### 7.1 Notificación Interna Inicial (Activación CSIRT)

```
ASUNTO: [P1/P2/P3] ACTIVACIÓN CSIRT — Incidente de Seguridad IR-2024-XXXX

Fecha/Hora: [DD/MM/AAAA HH:MM TZ]
Severidad: [P1/P2/P3/P4]
IR Lead: [Nombre]

RESUMEN:
[Descripción breve del incidente en 2-3 líneas]

IMPACTO ACTUAL:
[Qué sistemas/datos/usuarios están afectados]

ACCIONES EN CURSO:
[Qué se está haciendo en este momento]

PRÓXIMOS PASOS:
[Qué se espera hacer en las próximas horas]

CONTACTO:
IR Lead: [Nombre] — [Teléfono] — [Email]
Canal de comunicación: [Slack/Teams/Canal dedicado]

NOTA: Este incidente es CONFIDENCIA. No compartir información fuera del
equipo autorizado sin aprobación del IR Lead.
```

### 7.2 Actualización Periódica de Estado

```
ASUNTO: [P1/P2] ACTUALIZACIÓN IR-2024-XXXX — [Estado Actual]

Fecha/Hora de actualización: [DD/MM/AAAA HH:MM TZ]
Tiempo desde detección: [X horas]
Estado: [Contención / Erradicación / Recuperación / Monitoreo]

RESUMEN DE ACTIVIDAD DESDE ÚLTIMA ACTUALIZACIÓN:
[Acciones tomadas]

ESTADO ACTUAL:
[Situación actual del incidente]

IMPACTO ACTUALIZADO:
[Cambios en el impacto]

PRÓXIMOS PASOS:
[Plan para las próximas horas]

SIGUIENTE ACTUALIZACIÓN: [DD/MM/AAAA HH:MM TZ]
```

### 7.3 Notificación a Clientes

```
ASUNTO: Notificación de Incidente de Seguridad — BRIDA IT Services

Estimado/a [Nombre del Cliente],

Le escribimos para informarle sobre un incidente de seguridad que ha afectado
a [descripción general del impacto en el cliente].

¿QUÉ OCURRIÓ?
[Descripción del incidente en lenguaje no técnico]

¿QUÉ INFORMACIÓN SE VIO AFECTADA?
[Descripción de los datos afectados, si aplica]

¿QUÉ ESTAMOS HACIENDO?
[Acciones de respuesta tomadas]

¿QUÉ PUEDE HACER USTED?
[Recomendaciones para el cliente: cambiar contraseñas, monitorear cuentas, etc.]

Estamos comprometidos con la seguridad de sus datos y le mantendremos informado
a medida que avance nuestra investigación.

Para preguntas, contacte a:
[Nombre] — [Email] — [Teléfono]

Atentamente,
[Nombre]
Cargo
BRIDA IT Services
```

### 7.4 Notificación a Reguladores

```
ASUNTO: Notificación de Brecha de Datos — [Organización] — [Referencia]

Autoridad: [Nombre de la autoridad reguladora]
Fecha: [DD/MM/AAAA]

1. INFORMACIÓN DE LA ORGANIZACIÓN
   - Nombre: [Organización]
   - Domicilio: [Dirección]
   - Contacto del DPO: [Nombre, email, teléfono]

2. DESCRIPCIÓN DEL INCIDENTE
   - Fecha de descubrimiento: [DD/MM/AAAA]
   - Fecha del incidente: [DD/MM/AAAA] (si se conoce)
   - Descripción: [Descripción detallada]

3. DATOS AFECTADOS
   - Tipos de datos: [PII, financieros, salud, etc.]
   - Número de registros afectados: [Cantidad estimada]
   - Categorías de sujetos afectados: [Clientes, empleados, etc.]

4. MEDIDAS ADOPTADAS
   - Contención: [Descripción]
   - Erradicación: [Descripción]
   - Recuperación: [Descripción]

5. CONSECUENCIAS
   - Impacto potencial: [Descripción]
   - Impacto actual: [Descripción]

6. COMUNICACIÓN A AFECTADOS
   - ¿Se ha notificado a los afectados? [Sí/No]
   - Fecha de notificación: [DD/MM/AAAA]
   - Método de notificación: [Email, carta, publicación]

7. MEDIDAS PREVENTIVAS FUTURAS
   - [Descripción de mejoras implementadas o planificadas]

Firma: ________________________
Cargo: ________________________
Fecha: ________________________
```

### 7.5 Comunicación Pública (Comunicado de Prensa)

```
COMUNICADO DE PRENSA — BRIDA IT Services
Fecha: [DD/MM/AAAA]

BRIDA IT Services informa sobre incidente de seguridad

[Ciudad, País] — BRIDA IT Services ("BRIDA") informa que el [fecha]
detectó un incidente de seguridad que [descripción general].

Al detectar el incidente, BRIDA activó inmediatamente su plan de respuesta
a incidentes, notificó a las autoridades competentes y contrató expertos
forenses externos para apoyar la investigación.

"La seguridad de los datos de nuestros clientes es nuestra máxima prioridad.
Estamos trabajando diligentemente para entender el alcance completo del
incidente y tomar todas las medidas necesarias para proteger a nuestros
clientes y socios." — [Nombre, Cargo]

BRIDA recomienda a [clientes/usuarios] que [recomendaciones generales].

Para más información:
[Contacto de prensa] — [Email] — [Teléfono]

###
```

### 7.6 Escalamiento Interno

```
ASUNTO: [URGENTE] ESCALAMIENTO — IR-2024-XXXX

A: [C-Level / Directorio]
De: [IR Lead]

Motivo de escalamiento:
[Por qué se requiere escalamiento]

Impacto actual:
[Impacto en negocio, datos, operaciones]

Decisión requerida:
[Qué decisión se necesita y de quién]

Tiempo límite para decisión: [DD/MM/AAAA HH:MM TZ]

Riesgo de no actuar:
[Consecuencias de no tomar acción]
```

---

## 8. Reporte Post-Incidente

### 8.1 Estructura del Reporte

```
═══════════════════════════════════════════════════════════════
        REPORTE POST-INCIDENTE — BRIDA IT SERVICES
                    CONFIDENCIAL
═══════════════════════════════════════════════════════════════

1. RESUMEN EJECUTIVO
   - Incidente: [Nombre/ID]
   - Fecha de detección: [DD/MM/AAAA]
   - Fecha de cierre: [DD/MM/AAAA]
   - Severidad: [P1/P2/P3/P4]
   - Estado: Cerrado
   - Resumen: [2-3 párrafos con visión general]

2. CRONOLOGÍA DEL INCIDENTE (TIMELINE)
   ┌────────────────┬──────────────────────────────────────────┐
   │ Fecha/Hora     │ Evento                                   │
   ├────────────────┼──────────────────────────────────────────┤
   │ DD/MM HH:MM    │ [Evento 1]                               │
   │ DD/MM HH:MM    │ [Evento 2]                               │
   │ DD/MM HH:MM    │ [Evento 3]                               │
   │ ...            │ ...                                      │
   └────────────────┴──────────────────────────────────────────┘

3. CAUSA RAÍZ
   - Vector de entrada: [Phishing / Vulnerabilidad / Insider / etc.]
   - Vulnerabilidades explotadas: [CVE-XXXX-XXXX, configuración débil, etc.]
   - Factores contribuyentes: [Falta de segmentación, sin MFA, etc.]

4. ALCANCE E IMPACTO
   - Sistemas afectados: [Lista]
   - Datos afectados: [Tipo y volumen]
   - Usuarios afectados: [Número]
   - Impacto financiero: [Estimado]
   - Impacto operacional: [Descripción]
   - Impacto reputacional: [Descripción]

5. ACCIONES DE RESPUESTA
   - Contención: [Qué se hizo, cuándo, resultado]
   - Erradicación: [Qué se hizo, cuándo, resultado]
   - Recuperación: [Qué se hizo, cuándo, resultado]

6. INDICADORES DE COMPROMISOCOMPROMISO (IOCs)
   - [Lista completa de IOCs identificados]

7. MAPEO MITRE ATT&CK
   - [TTPs identificados con IDs]

8. MÉTRICAS
   - MTTD: [X horas/minutos]
   - MTTR: [X horas/minutos]
   - MTTC: [X horas/minutos]
   - MTTREC: [X horas/minutos]

9. LECCIONES APRENDIDAS
   - ¿Qué salió bien?
   - ¿Qué salió mal?
   - ¿Qué se puede mejorar?

10. PLAN DE MEJORA
   ┌────┬──────────────────────┬──────────────┬────────────┬──────────┐
   │ #  │ Acción               │ Responsable  │ Fecha      │ Estado   │
   ├────┼──────────────────────┼──────────────┼────────────┼──────────┤
   │ 01 │ [Acción]             │ [Nombre]     │ [Fecha]    │ [Estado] │
   │ 02 │ [Acción]             │ [Nombre]     │ [Fecha]    │ [Estado] │
   │ ...│ ...                  │ ...          │ ...        │ ...      │
   └────┴──────────────────────┴──────────────┴────────────┴──────────┘

11. APÉNDICES
   - A: Evidencia recolectada
   - B: Capturas de pantalla
   - C: Logs relevantes
   - D: Comunicaciones enviadas
   - E: Cadena de custodia

═══════════════════════════════════════════════════════════════
Elaborado por: [Nombre]
Revisado por: [Nombre]
Aprobado por: [Nombre]
Fecha: [DD/MM/AAAA]
Clasificación: CONFIDENCIAL
═══════════════════════════════════════════════════════════════
```

### 8.2 Métricas Clave a Reportar

| Métrica | Fórmula | Meta |
|---------|---------|------|
| **MTTD** | Tiempo de detección − Tiempo de compromiso inicial | ≤ 1 hora |
| **MTTR** | Tiempo de contención − Tiempo de detección | ≤ 4 horas |
| **MTTC** | Tiempo de erradicación − Tiempo de contención | ≤ 24 horas |
| **MTTREC** | Tiempo de recuperación completa − Tiempo de erradicación | ≤ 72 horas |
| **Scope** | # sistemas + # usuarios + # registros de datos | Minimizar |
| **Cost** | Costo directo + Costo indirecto | Minimizar |

---

## 9. Matrices de Mapeo

### MITRE ATT&CK

#### Mapeo Consolidado por Tipo de Incidente

| Táctica | Técnica | ID | Ransomware | Phishing | BEC | Data Breach | Insider |
|---------|---------|----|:----------:|:--------:|:---:|:-----------:|:-------:|
| Initial Access | Phishing | T1566 | ✅ | ✅ | ✅ | ✅ | ❌ |
| Initial Access | Exploit Public-Facing App | T1190 | ✅ | ❌ | ❌ | ✅ | ❌ |
| Execution | Command and Scripting Interpreter | T1059 | ✅ | ✅ | ❌ | ✅ | ✅ |
| Persistence | Registry Run Keys | T1547.001 | ✅ | ✅ | ❌ | ❌ | ✅ |
| Persistence | Account Manipulation | T1098 | ❌ | ❌ | ✅ | ❌ | ✅ |
| Privilege Escalation | Valid Accounts | T1078 | ✅ | ❌ | ✅ | ✅ | ✅ |
| Defense Evasion | Disable or Modify Tools | T1562.001 | ✅ | ❌ | ❌ | ❌ | ✅ |
| Defense Evasion | Indicator Removal | T1070 | ✅ | ❌ | ❌ | ✅ | ✅ |
| Credential Access | Credential Dumping | T1003 | ✅ | ❌ | ❌ | ✅ | ❌ |
| Lateral Movement | Remote Services | T1021 | ✅ | ❌ | ❌ | ✅ | ❌ |
| Collection | Data from Local System | T1005 | ❌ | ❌ | ❌ | ✅ | ✅ |
| Collection | Email Collection | T1114 | ❌ | ❌ | ✅ | ✅ | ✅ |
| Exfiltration | Exfiltration Over C2 | T1041 | ❌ | ❌ | ❌ | ✅ | ❌ |
| Exfiltration | Exfiltration Over Web | T1567 | ❌ | ❌ | ❌ | ✅ | ✅ |
| Exfiltration | Exfiltration Over USB | T1052.001 | ❌ | ❌ | ❌ | ❌ | ✅ |
| Impact | Data Encrypted for Impact | T1486 | ✅ | ❌ | ❌ | ❌ | ❌ |
| Impact | Data Manipulation | T1565 | ❌ | ❌ | ❌ | ❌ | ✅ |

### NIST CSF

#### Mapeo Consolidado por Fase de IR

| Fase IR | Función CSF | Categoría | Subcategoría |
|---------|-------------|-----------|-------------|
| **Prepración** | ID (Identify) | Risk Management Strategy | ID.RM-1, ID.RM-2 |
| **Preparación** | PR (Protect) | Awareness and Training | PR.AT-1, PR.AT-2 |
| **Preparación** | PR (Protec) | Protective Technology | PR.PT-1, PR.PT-3 |
| **Detección** | DE (Detect) | Anomalies and Events | DE.AE-1, DE.AE-2, DE.AE-3 |
| **Detección** | DE (Detect) | Security Continuous Monitoring | DE.CM-1, DE.CM-3, DE.CM-7 |
| **Detección** | DE (Detect) | Detection Processes | DE.DP-1, DE.DP-3, DE.DP-4 |
| **Contención** | RS (Respond) | Response Planning | RS.RP-1 |
| **Contención** | RS (Respond) | Mitigation | RS.MI-1, RS.MI-2, RS.MI-3 |
| **Contención** | RS (Respond) | Communications | RS.CO-1, RS.CO-2, RS.CO-3 |
| **Erradicación** | RS (Respond) | Mitigation | RS.MI-1, RS.MI-2 |
| **Recuperación** | RC (Recover) | Recovery Planning | RC.RP-1 |
| **Recuperación** | RC (Recover) | Improvements | RC.IM-1, RC.IM-2 |
| **Lecciones Aprendidas** | ID (Identify) | Risk Assessment | ID.RA-1, ID.RA-3 |
| **Lecciones Aprendidas** | RC (Recover) | Improvements | RC.IM-1, RC.IM-2 |

### D3FEND

#### Mapeo Consolidado por Categoría de Defensa

| Categoría D3FEND | Técnicas | Fase IR Aplicabilidad |
|------------------|----------|----------------------|
| **Analyze** (Análisis) | D3-DA (Dynamic Analysis), D3-FCA (File Content Analysis), D3-PSA (Process Analysis), D3-NTA (Network Traffic Analysis), D3-ICA (Identifier Analysis) | Detección, Análisis |
| **Detect** (Detección) | D3-UBA (User Behavior Analysis), D3-ANAA (Authentication Behavior Analysis), D3-ETI (Email Filtering) | Detección |
| **Disrupt** (Interrupción) | D3-NTCD (Network Isolation), D3-PHPA (Process Hardening) | Contención |
| **Mitigate** (Mitigación) | D3-ACL (Access Control), D3-MFA (Multi-factor Authentication), D3-SPP (Strong Password Policies) | Contención, Erradicación |
| **Restore** (Restauración) | D3-RRDD (Restore Disk Image), D3-FEM (File Encryption), D3-DK (Data Encryption) | Recuperación |
| **Harden** (Fortalecimiento) | D3-PHPA (Process Hardening), D3-ACL (Access Control), D3-SPP (Strong Password Policies) | Preparación, Lecciones Aprendidas |

---

## 10. Glosario

| Término (EN) | Término (ES) | Definición |
|--------------|--------------|------------|
| **Breach** | Brecha | Acceso no autorizado a datos, sistemas o redes. |
| **Containment** | Contención | Acciones para limitar el daño y prevenir la propagación. |
| **EDR** | Detección y Respuesta en Endpoint | Herramienta de seguridad que monitorea endpoints continuamente. |
| **Eradication** | Erradicación | Eliminación completa de la amenaza del entorno. |
| **Exfiltration** | Exfiltración | Transferencia no autorizada de datos fuera de la organización. |
| **False Positive** | Falso Positivo | Alerta que indica una amenaza pero que es legítima. |
| **Forensics** | Informática Forense | Análisis científico de evidencia digital. |
| **IOC** | Indicador de Compromiso | Evidencia de que un sistema ha sido comprometido. |
| **IR** | Respuesta a Incidentes | Proceso de gestión de incidentes de seguridad. |
| **MTTD** | Tiempo Medio de Detección | Métrica de cuánto tarda en detectarse un incidente. |
| **MTTR** | Tiempo Medio de Respuesta | Métrica de cuánto tarda en responderse a un incidente. |
| **Playbook** | Libro de Jugadas | Procedimiento paso a paso para responder a un tipo de incidente. |
| **Ransomware** | Ransomware | Malware que cifra datos y exige un rescate. |
| **Root Cause** | Causa Raíz | La razón fundamental por la que ocurrió un incidente. |
| **SIEM** | Gestión de Eventos e Información de Seguridad | Plataforma que agrega y analiza logs de seguridad. |
| **Tabletop Exercise** | Ejercicio de Simulación | Ejercicio teórico para practicar la respuesta a incidentes. |
| **Threat Hunting** | Caza de Amenazas | Búsqueda proactiva de amenazas en el entorno. |
| **TTP** | Tácticas, Técnicas y Procedimientos | El comportamiento de un adversario. |
| **True Positive** | Verdadero Positivo | Alerta que indica una amenaza real. |
| **Write Blocker** | Bloqueador de Escritura | Dispositivo que permite leer un disco sin modificarlo. |

---

## Referencias

- NIST SP 800-61 Rev. 2: Computer Security Incident Handling Guide
- NIST Cybersecurity Framework (CSF) v2.0
- MITRE ATT&CK Framework: https://attack.mitre.org/
- MITRE D3FEND Framework: https://d3fend.mitre.org/
- No More Ransom Project: https://www.nomoreransom.org/
- ID Ransomware: https://id-ransomware.malwarehunterteam.com/
- CISA Incident Response: https://www.cisa.gov/incident-response
- SANS Incident Handler's Handbook

---

*Documento propiedad de BRIDA IT Services. Clasificación: CONFIDENCIAL.*

*Última actualización: Junio 2026 — Versión 1.0.0*