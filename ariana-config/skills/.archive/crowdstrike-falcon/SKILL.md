# Skill: CrowdStrike Falcon EDR

## Descripción
Implementación, configuración y operación de CrowdStrike Falcon (EDR/XDR) para detección, respuesta y threat hunting en clientes de BRIDA IT Services.

## Productos CrowdStrike en el Stack BRIDA

### Falcon Prevent (Next-Gen Antivirus)
- **Función:** Reemplazo de antivirus tradicional (Trellix, etc.)
- **Tecnología:** ML/AI + indicator-based detection
- **Deploy:** Agente ligero en endpoints (Windows, Linux, Mac)

### Falcon Insight (EDR)
- **Función:** Detección y respuesta en endpoints avanzada
- **Tecnología:**Behavioral analysis + threat intelligence
- **Uso:** Investigación de incidentes, threat hunting

### Falcon Discover (IT Hygiene)
- **Función:** Inventario de software, cuentas, vulnerabilidades
- **Uso:** Identificar software no autorizado, cuentas privilegiadas

### Falcon OverWatch (Managed Threat Hunting)
- **Función:** Caza de amenazas 24/7 por analistas CrowdStrike
- **Uso:** Clientes sin SOC propio (como Grupo Pepe)

### Falcon Complete (MDR)
- **Función:** Detección + respuesta completamente gestionada
- **Uso:** Outsourcing de SOC para clientes medianos

---

## Despliegue de CrowdStrike para Clientes BRIDA

### Paso 1: Preparación
```
1. Obtener licencias del portal CrowdStrike (https://falcon.crowdstrike.com)
2. Identificar el "CID" (Customer ID) y "Installation Token"
3. Preparar lista de endpoints:
   - Windows: Versión de .NET (requerido 4.5+)
   - Linux: Kernel 2.6+ 
   - RAM mínima: 256MB
4. Exclusiones necesarias:
   - Directorios de bases de datos (SQL, Oracle)
   - Software de terceros incompatible
   - Sistemas de producción (ventana de mantenimiento)
```

### Paso 2: Instalación del Sensor (Agente)

**Windows (PowerShell como Administrador):**
```
# Descargar sensor desde el portal CrowdStrike
# Instalación silenciosa
WindowsSensor.exe /install /quiet /norestart CID=<CUSTOMER_ID>
# Con grupos de política
WindowsSensor.exe /install /quiet /norestart CID=<CUSTOMER_ID> GROUPING_TAGS="GrupoPepe,Produccion"
```

**Linux:**
```
# RHEL/Centos
sudo yum install -y falcon-sensor
sudo /opt/CrowdStrike/falconctl -s --cid=<CUSTOMER_ID>

# Ubuntu/Debian
sudo apt-get install -y falcon-sensor
sudo /opt/CrowdStrike/falconctl -s --cid=<CUSTOMER_ID>

# Verificar estado
sudo /opt/CrowdStrike/falconctl -g --cid
```

**macOS:**
```
sudo installer -pkg FalconSensor.pkg -target /
sudo /Applications/Falcon.app/Contents/Resources/falconctl license <CID>
```

**AWS (via UserData):**
```
#!/bin/bash
curl -O https://falcon-agent.s3.amazonaws.com/falcon-sensor-latest.rpm
sudo rpm -ivh falcon-sensor-latest.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=<CUSTOMER_ID>
```

### Paso 3: Configuración de Políticas
```
# Acceder a Falcon Console > Configuration > Prevention Policies

# Política de Prevención (Grupo Pepe - Alta Seguridad)
- Sensor Detection Mode: Detection and Prevention
- Cloud Detection: High
- Executable Blocking: Enabled
- Block malicious scripts: Enabled
- USB Device Control: Read-Only (bloquear escritura)
- Ransomware Protection: Enabled
- Unknown Detection: Cloud ML analysis

# Política de Detección (GrupoPepe - Monitoreo)
- Sensor Visibility: Full
- Custom Indicators: Importar IOCs del cliente
- Machine Learning: High sensitivity
- Behavioral Threat Detection: Aggressive
```

### Paso 4: Configuración de Alertas y Respuesta
```
# Notification Policies
- Critical severidad → Email + Slack + Telegram (BRIDA SOC)
- High severidad → Email (BRIDA SOC + IT cliente)
- Medium severidad → Dashboard

# Automated Response (Falcon Fusion SOAR)
- Si Ransomware detected → Aislar endpoint + Notificar
- Si Lateral Movement → Investigación automática + Escalación
- Si Known Malware → Kill process + Quarantine + Notificar
```

---

## Operación Diaria

### Dashboard Principal
```
Falcon Console > Dashboard
- Monitorear: Active Detections, Severity Breakdown, Top Threats
- Revisar: Incidents queue, Pending actions
```

### Investigación de Incidentes
```
Falcon Console > Incidents > Review

Flujo de investigación:
1. Abrir incidente → Ver resumen del detection tree
2. Examinar: Process tree, network connections, file modifications
3. Determinar: False Positive (FP) o True Positive (TP)
4. Si TP:
   - Contener: Aislar endpoint (Network Containment)
   - Eradicar: Kill process, delete file, remove persistence
   - Verificar: Re-scan endpoint
   - Documentar: Notas y evidence
5. Si FP → Suprimir rule o agregar exclusion
```

### Threat Hunting con Falcon Spotlight
```
Falcon Console > Spotlight > Vulnerabilities

Queries útiles:
# Vulnerabilidades críticas sin parche
"vulnerability.severity:'critical' AND vulnerability.status:'open'"

# Software desactualizado
"software.name:'apache' AND software.version:[* TO 2.4.57]"

# Credenciales débiles / expuestas
"detection.behavior:'credential_access'"

# Lateral movement detectado
"detection.tactic:'lateral_movement'"

# Persistence mechanisms
"detection.technique:'Registry Run Keys' OR detection.technique:'Scheduled Task'"
```

### Hunting con RTR (Real Response)
```
Falcon Console > Hosts > Seleccionar host > Real Time Response

Comandos útiles en RTR:
# Lista de procesos
ps

# Conexiones de red activas
netstat

# Persistence (Windows)
runscript -Raw="Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'"
runscript -Raw="schtasks /query /fo LIST /v"

# Archivos sospechosos recientes
runas -Raw="Get-ChildItem C:\Users\ -Recurse -Filter '*.exe' | Where-Object {$_.LastWriteTime -gt '2024-01-01'}"

# Persistence Linux
cat /etc/crontab
systemctl list-units --type=service --state=running
ls -la /etc/init.d/

# Volcado de memoria (forense)
memdump
```

---

## Integración con Stack BRIDA

### CrowdStrike + Fortinet
```
# Crear IoC en FortiGate desde CrowdStrike detections
config firewall address
    edit "C2-Server-Block"
        set type ipmask
        set subnet 198.51.100.50/32
        set comment "CrowdStrike Detection - C2 Communication"
    next
end

# Política de bloqueo
config firewall policy
    edit 998
        set name "Block-CrowdStrike-IoC"
        set srcintf "lan1"
        set dstintf "wan1"
        set srcaddr "all"
        set dstaddr "C2-Server-Block"
        set action deny
        set schedule "always"
        set service "ALL"
        set logtraffic all
    next
end
```

### CrowdStrike + Qualys
```
# Exportar vulnerabilidades de CrowdStrike Discover → Importar a Qualys
# Qualys Agent puede complementar CrowdStrike para VM

# Priorización: Si Qualys marca CRITICAL + CrowdStrike detecta explotación activa
# → Escalar a incidente de seguridad inmediato
```

### CrowdStrike + Cloudflare
```
# Bloquear IPs detectadas por CrowdStrike en Cloudflare WAF
# API de Cloudflare para crear reglas desde CrowdStrike IoCs

# Ejemplo: Bloquear IP de ataque
curl -X POST "https://api.cloudflare.com/client/v4/zones/{zone_id}/firewall/access_rules/rules" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  --data '{"mode":"block","configuration":{"target":"ip","value":"198.51.100.50"},"notes":"CrowdStrike IoC"}'
```

---

## Métricas KPIs para el Cliente

| KPI | Descripción | Meta |
|---|---|---|
| Mean Time to Detect (MTTD) | Tiempo promedio de detección | < 1 hora |
| Mean Time to Respond (MTTR) | Tiempo promedio de respuesta | < 4 horas |
| Coverage rate | % de endpoints con agente activo | > 95% |
| Critical detections | Detecciones críticas por mes | Tendencia descendente |
| Contained threats | Amenazas contenidas exitosamente | 100% |
| False positive rate | Tasa de falsos positivos | < 5% |

---

## Referencias
- CrowdStrike Documentation: https://falcon.crowdstrike.com/documentation
- Falcon RTR Guide: https://falcon.crowdstrike.com/documentation/page/dc9339d3/real-time-response
- MITRE ATT&CK & CrowdStrike: https://attack.mitre.org/
- CrowdStrike Adversary Universe: https://adversary.crowdstrike.com
