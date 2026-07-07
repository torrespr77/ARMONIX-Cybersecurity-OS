# Skill: EDR Deployment — CrowdStrike & Trellix

## Descripción
Guía de despliegue y configuración de soluciones EDR (Endpoint Detection and Response) de CrowdStrike Falcon y Trellix ePO para clientes de BRIDA IT Services.

## Cuándo Usar
- Despliegue inicial de EDR en un cliente nuevo
- Migración de antivirus tradicional a EDR
- Configuración de políticas de detección y respuesta
- Investigación de incidentes con EDR
- Evaluación de cobertura de endpoints

## Comparativa Rápida

| Característica | CrowdStrike Falcon | Trellix ePO + Endpoint |
|---|---|---|
| **Modelo** | Cloud-native (SaaS) | On-prem ePO + cloud |
| **Agente** | Falcon Sensor (ligero) | Trellix Agent + Endpoint Security |
| **Detección** | AI/ML + Threat Intelligence | Signature + Behavioral + ML |
| **Respuesta** | Automated (containment) | Manual + automated policies |
| **EPP integrado** | Sí (AV + EDR) | Sí (Endpoint Security suite) |
| **Ideal para** | Clientes cloud-first | Clientes con infra on-prem existente |
| **Licenciamiento** | Por endpoint/mes | Por endpoint/año |
| **Integración FortiGate** | Sí (via API) | Sí (via ePO policies) |

## CrowdStrike Falcon — Despliegue

### Paso 1: Preparación
1. Obtener CID (Customer ID) de CrowdStrike
2. Descargar Falcon Sensor para cada SO:
   - Windows: `.msi` o `.exe`
   - Linux: `.rpm` o `.deb`
   - macOS: `.pkg`
3. Definir grupos de hosts (Host Groups):
   - Por ubicación: "Corporativo", "Sucursales"
   - Por criticidad: "Servidores", "Workstations", "POS"
   - Por SO: "Windows", "Linux", "macOS"

### Paso 2: Instalación del Agente
**Windows (silent install):**
```cmd
WindowsSensor.exe /install /quiet /norestart CID=<YOUR-CID>
```

**Linux:**
```bash
sudo yum install -y falcon-sensor --enablerepo=crowdstrike
sudo /opt/CrowdStrike/falconctl -s --cid=<YOUR-CID>
sudo systemctl start falasensor
```

**macOS:**
```bash
sudo installer -pkg FalconSensor.pkg -target /
sudo /Applications/Falcon.app/Contents/Resources/falconctl license <CID>
```

**GPO/SCCM/Intune (masivo):**
- Crear paquete de instalación con el CID embebido
- Distribuir vía GPO Software Installation o SCCM Application
- Verificar instalación con query de CrowdStrike Console

### Paso 3: Políticas de Detección
Configurar en Falcon Console > Configuration > Prevention Policies:

| Política | Prevención | Detección | Respuesta |
|---|---|---|---|
| **Servidores Críticos** | Block + Alert | High sensitivity | Contain + Network isolation |
| **Workstations** | Block + Alert | Medium sensitivity | Alert only |
| **POS/Pagos** | Block + Alert | High sensitivity | Contain immediately |
| **Desarrollo** | Alert only | Low sensitivity | Alert only |

### Paso 4: Políticas de Respuesta (Response Policies)
```
Configuración > Response Policies
- Enable/Disable machine: Allow (solo admins)
- Network containment: Auto-contain on critical detections
- Custom scripts: Permitir scripts de remediación
- Detonation: Cloud sandboxing habilitado
```

### Paso 5: Monitoreo y Alertas
- **Dashboard principal:** Threats by severity, detection trends
- **Custom alerts:** Configurar para detecciones críticas
- **SIEM integration:** CrowdStrike Falcon Data Replicator → SIEM
- **Weekly report:** Resumen de detenciones y amenazas bloqueadas

## Trellix ePO — Despliegue

### Paso 1: Preparación del Servidor ePO
1. **Requisitos de servidor:**
   - Windows Server 2019/2022
   - SQL Server 2019+ (o SQL Express para < 500 endpoints)
   - 8+ GB RAM, 4+ vCPU
   - Puerto 8443 (console), 80/443 (agent-server)
2. **Instalación ePO:**
   - Ejecutar instalador de Trellix ePO
   - Configurar base de datos SQL
   - Activar licencia
   - Configurar cuenta de administrador

### Paso 2: Despliegue del Agente Trellix
**Agente (Trellix Agent 5.7+):**
```
FramePkg.exe /install=agent /forceinstall
```

**Distribución masiva:**
- **ePO:** System Tree > Actions > Agent > Deploy Agents
- **GPO:** Crear GPO con startup script que ejecuta FramePkg.exe
- **SCCM:** Package/Program con línea de comandos silenciosa

### Paso 3: Políticas de Endpoint Security
Configurar en ePO > Policy > Policy Catalog:

**Anti-malware (Scan Type):**
- **On-Access Scan:** Habilitado, scan on read/write
- **On-Demand Scan:** Schedule semanal (domingo 2:00 AM)
- **Email Scan:** Habilitado para Outlook/Thunderbird

**Firewall (Host Intrusion Prevention):**
- **Profile:** Corporate (no Public, no Home)
- **Rules:** Bloquear inbound por defecto, permitir outbound selectivo
- **IPS:** Habilitado con reglas de prevención

**Web Control:**
- **URL Filtering:** Bloquear categorías maliciosas
- **HTTPS Scan:** Habilitado
- **Download Reputation:** Habilitado

**Exploit Prevention (ENS):**
- **Exploit Prevention:** Habilitado
- **Memory Protection:** Habilitado
- **Advanced Machine Learning:** Habilitado

### Paso 4: Monitoreo ePO
- **Dashboard:** Threats detected, agent coverage, compliance
- **Queries:** Crear queries personalizadas por cliente
- **Reports:** Programar reportes semanales automáticos
- **Alerts:** Configurar notificaciones email para detecciones críticas

## Checklist de Despliegue EDR

### Pre-Despliegue
- [ ] Inventario de endpoints completo (SO, versión, hardware)
- [ ] Compatibilidad verificada (SO soportado, recursos mínimos)
- [ ] Exclusiones definidas (aplicaciones legítimas que generan falsos positivos)
- [ ] Ventana de despliegue comunicada al cliente
- [ ] Plan de rollback documentado

### Despliegue
- [ ] Agente instalado en 100% de endpoints
- [ ] Políticas asignadas por grupo
- [ ] Exclusiones configuradas
- [ ] Conexión al cloud/servidor verificada
- [ ] Primera actualización de firmas completada

### Post-Despliegue
- [ ] Monitoreo activo durante 48-72 horas
- [ ] Falsos positivos identificados y excluidos
- [ ] Reporte de cobertura generado
- [ ] Capacitación al equipo IT del cliente
- [ ] Documentación entregada al cliente

## Integración con Stack BRIDA
- **EDR + FortiGate:** Compartir IoCs (Indicators of Compromise) entre plataformas
- **EDR + Qualys:** Correlacionar vulnerabilidades con detecciones activas
- **EDR + Cloudflare:** Bloquear IPs maliciosas en WAF basado en detecciones EDR
- **EDR + SIEM:** Enviar logs a SIEM centralizado para correlación
