# Runbook: Respuesta a Incidentes Ariana Agent (Hermes)

**Objetivo**: Procedimiento formal de Incident Response para el agente de IA Ariana siguiendo NIST SP 800-61.

---

## Clasificación de Incidentes

| Tipo | Código | Descripción | Severidad Típica |
|---|---|---|---|
| Token Comprometido | TK-COMP | API key / bot token expuesto | S1 |
| Acceso No Autorizado | UA-ACC | Login SSH/IP no autorizada | S1-S2 |
| Gateway Down | GW-DOWN | Servicio Ariana offline | S2 |
| Data Leakage | DL-LEAK | Fuga de datos cliente/memoria | S1 |
| Skill Corruption | SK-CORR | Skills modificadas/eliminadas | S2-S3 |
| Cron Job Failure | CR-FAIL | Jobs programados no ejecutan | S3-S4 |
| Provider Compromised | PR-COMP | API key LLM robada | S1-S2 |
| Prompt Injection | PI-INJ | Instrucciones maliciosas via tools | S2 |

---

## Matriz de Severidad (SLA)

| Severidad | Impacto | Alcance | Detección | Notificación | Contención | Erradicación | Post-Incidente |
|---|---|---|---|---|---|---|---|
| **S1 CRÍTICA** | Datos comprometidos, sistema caído | Total | Auto (1 min) | Roger 15 min + Berni | 30 min | 4 horas | 48 horas |
| **S2 ALTA** | Funcionalidad degradada, riesgo alto | Parcial | Auto (5 min) | Roger 30 min | 2 horas | 8 horas | 72 horas |
| **S3 MEDIA** | Problema operativo, riesgo moderado | Limitado | Auto (30 min) | Roger 2 horas | 8 horas | 24 horas | 1 semana |
| **S4 BAJA** | Incidente menor, sin impacto seguridad | Mínimo | Weekly check | Roger 8 horas | Best effort | 1 semana | 2 semanas |

---

## Contactos de Escalación

| Rol | Nombre | Contacto | Disponibilidad |
|---|---|---|---|
| Primera Respuesta | Ariana | Telegram @Ariana_BRIDA_bot | 24/7 (auto) |
| Administrador | Roger Torres | Telegram ID: 585583379 | Lun-Vie 8AM-8PM |
| CEO BRIDA | Bernardo Gomez (Berni) | Telegram ID: 693441689 | Lun-Vie 9AM-7PM (urgencias 24/7) |
| Cliente | Moises Martinez | moises.martinez@pollopepe.com.mx / 33-38-80-80-50 | Horario laboral |

**Flujo S1**: Ariana → Roger (inmediato) → Berni (30 min) → IR completo

---

## Fases NIST SP 800-61

### 1. Preparación
- Backups semanales a GitHub (sync-to-github.sh)
- Monitoring: Daily/Weekly Health Checks
- Runbooks actualizados
- Contactos verificados

### 2. Detección y Análisis
- Alertas automáticas (Daily Check, Weekly Check)
- Clasificación inicial → Severidad → Escalación
- Captura de evidencia inicial

### 3. Contención, Erradicación, Recuperación
Ver playbooks específicos abajo

### 4. Post-Incidente
- Reporte formal (48h S1, 72h S2)
- Lecciones aprendidas → Actualizar runbooks
- Mejoras preventivas

---

## Playbooks Específicos

### TK-COMP: Token Comprometido (S1)
**Síntomas**: Token visible en logs/chat/GitHub, actividad sospechosa, error 401

**Respuesta**:
1. **Confirmar (0-5 min)**: `git log --all -p | grep -iE "(token|api_key|bot_token)"`
2. **Revocar INMEDIATO (5-15 min)**:
   - Telegram: @BotFather → /revoke → nuevo token
   - OpenRouter: Dashboard → API Keys → Revoke → Generate
   - Tavily: Dashboard → Rotate
3. **Actualizar .env (15-20 min)**: `nano ~/.hermes/.env` + `hermes gateway restart`
4. **Verificar (20-30 min)**: Revisar mensajes Telegram, commits GitHub, skills
5. **Documentar (30-60 min)**: Log IR, notificar Roger/Berni, forzar push .gitignore

### GW-DOWN: Gateway Down (S2)
**Síntomas**: Bot no responde, `hermes gateway status` falla, cron jobs no ejecutan

**Respuesta**:
1. **Diagnosticar (0-5 min)**: `hermes gateway status`, `tail -50 ~/.hermes/logs/gateway.log`
2. **Recuperar (5-15 min)**: `hermes gateway stop && sleep 3 && hermes gateway start`
3. **Si falla (15-30 min)**: Verificar token en .env, DB integrity (`sqlite3 ~/.hermes/state.db "PRAGMA integrity_check"`), restaurar backup
4. **Notificar (30 min)**: Escalar a Roger si no recupera

### DL-LEAK: Data Leakage (S1)
**Síntomas**: Datos cliente en memoria/Telegram, skills con metodologías en repo público, config.yaml con tokens en commit

**Respuesta**:
1. **Alcance (0-15 min)**: `git log --all --diff-filter=D --name-only`, revisar memoria
2. **Contener (15-30 min)**: `git filter-branch` para limpiar historial + force push
3. **Notificar (30-60 min)**: Roger → cliente directo, rotar tokens (ver TK-COMP), limpiar memoria
4. **Legal**: LFPDPPP → notificar INAI si datos personales comprometidos

### SK-CORR: Skill Corruption (S2-S3)
**Síntomas**: Skill no carga, skill_manage error, skills list incompleto, comportamiento anómalo

**Respuesta**:
1. **Identificar (0-10 min)**: Comparar `find ~/.hermes/skills -name "SKILL.md"` vs backup GitHub
2. **Restaurar (10-30 min)**: `rsync -av ~/brida-security-project/ariana-config/skills/ ~/.hermes/skills/`
3. **Investigar (30-60 min)**: Logs, cron jobs, acceso no autorizado?

### PR-COMP: Provider API Compromised (S1-S2)
**Síntomas**: Uso anómalo en dashboard OpenRouter, mensajes no solicitados, rate limiting

**Respuesta**:
1. **Suspender (0-5 min)**: OpenRouter Dashboard → Revoke key
2. **Nueva key (5-10 min)**: Generate → actualizar .env → `hermes gateway restart`
3. **Verificar (10-30 min)**: Dashboard uso, IPs origen, funcionalidad Ariana

---

## Procedimiento de Aislamiento (Niveles)

| Nivel | Acción | Cuando Aplicar |
|---|---|---|
| 1. Soft Stop | `hermes gateway stop` | Sospecha incidente |
| 2. Token Revocation | Revocar todos los tokens API | Token comprometido confirmado |
| 3. Network Isolation | `iptables -A OUTPUT -p tcp --dport 443 -j DROP` | Data leakage activo |
| 4. Full Shutdown | `sudo shutdown -h now` | Compromiso total, persistence |

---

## Procedimiento Forense (Captura Evidencia)

```bash
INCIDENT_DIR=~/incident-$(date +%Y%m%d-%H%M%S)
mkdir -p $INCIDENT_DIR

# 1. Procesos
ps aux > $INCIDENT_DIR/processes.txt

# 2. Red
netstat -tulnp > $INCIDENT_DIR/network.txt 2>&1
ss -tulnp >> $INCIDENT_DIR/network.txt 2>&1

# 3. Logins
last > $INCIDENT_DIR/logins.txt
grep "session\|Failed\|Accepted" /var/log/auth.log 2>/dev/null > $INCIDENT_DIR/auth.log

# 4. Logs Hermes
cp -r ~/.hermes/logs/ $INCIDENT_DIR/hermes-logs/

# 5. Gateway
hermes gateway status > $INCIDENT_DIR/gateway-status.txt 2>&1

# 6. Cron jobs
cp ~/.hermes/cron/jobs.json $INCIDENT_DIR/
cat ~/.hermes/cron/ticker_heartbeat > $INCIDENT_DIR/ticker_heartbeat.txt

# 7. Git
cd ~/brida-security-project
git log --all --oneline -50 > $INCIDENT_DIR/git-log.txt
git diff HEAD~5 > $INCIDENT_DIR/git-diff.txt 2>&1

# 8. Skills integrity
find ~/.hermes/skills -name "SKILL.md" -exec md5sum {} + > $INCIDENT_DIR/skills-hash.txt

# 9. Memoria
cp ~/.hermes/memories/MEMORY.md $INCIDENT_DIR/
cp ~/.hermes/memories/USER.md $INCIDENT_DIR/

# 10. Archivos recientes (24h)
find ~ -mtime -1 -type f -not -path "*/.hermes/logs/*" > $INCIDENT_DIR/recent-files.txt
```

---

## Comunicación y Notificación

### Plantilla Inicial
```
🚨 INCIDENTE DE SEGURIDAD DETECTADO
Fecha/Hora: YYYY-MM-DD HH:MM:SS
Severidad: S1/S2/S3/S4
Tipo: TK-COMP / UA-ACC / GW-DOWN / ...
Estado: Investigando / Contenido / Erradicado / Resuelto

Descripción: [qué pasó, sistemas afectados]
Acciones: [acción 1, acción 2]
Próximos pasos: [paso 1, paso 2]
Contacto: Roger Torres
Próxima actualización: [tiempo]
```

### Matriz Notificación
| Severidad | Roger | Berni (CEO) | Cliente |
|---|---|---|---|
| S1 | 15 min | 30 min | 1 hora |
| S2 | 30 min | 2 horas | Si aplica, 4h |
| S3 | 2 horas | No | No |
| S4 | Weekly | No | No |

### Legal
- **LFPDPPP**: Datos personales comprometidos → notificar INAI
- **Contratos**: Revisar cláusulas notificación incidentes
- **Evidencia**: Preservar 90 días mínimo

---

## Post-Incidente (Reporte Formal)

Completar dentro de 48h (S1) / 72h (S2):

| Campo | Descripción |
|---|---|
| ID Incidente | INC-YYYY-NNN |
| Fecha Detección | YYYY-MM-DD HH:MM |
| Fecha Resolución | YYYY-MM-DD HH:MM |
| Duración Total | X horas/minutos |
| Severidad Final | S1/S2/S3/S4 |
| Tipo | TK-COMP/UA-ACC/GW-DOWN/DL/S... |
| Descripción | Qué pasó, cómo se detectó |
| Impacto | Datos afectados, servicios caídos, costo |
| Causa Raíz | Cómo ocurrió |
| Acciones | Contención, erradicación, recuperación |
| Lecciones | Qué aprender, qué mejorar |
| Correctivas | Cambios para prevenir recurrencia |
| Runbook Update | Secciones a actualizar |
| Evidencia | Directorio ~/incident-XXX/ |

---

## Comandos de Emergencia (Apéndice)

### Diagnóstico Rápido
```bash
hermes gateway status
ps aux | grep -i hermes
free -m; df -h /home
cat ~/.hermes/cron/ticker_heartbeat
grep -i "error\|fatal" ~/.hermes/logs/gateway.log | tail -20
last -20
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -10
netstat -tulnp 2>/dev/null || ss -tulnp
```

### Recuperación Rápida
```bash
# Gateway (desde terminal externa)
hermes gateway stop && sleep 3 && hermes gateway start

# Restaurar skills
rsync -av ~/brida-security-project/ariana-config/skills/ ~/.hermes/skills/

# Restaurar memoria
cp ~/brida-security-project/ariana-config/memories-MEMORY.md ~/.hermes/memories/MEMORY.md
cp ~/brida-security-project/ariana-config/memories-USER.md ~/.hermes/memories/USER.md

# Health check
bash ~/.hermes/skills/automation/hermes-daily-check/scripts/daily-check.sh

# Sync GitHub
bash ~/scripts/sync-to-github.sh
```

### Contactos Rápidos
| Contacto | Cómo alcanzar |
|---|---|
| Roger Torres | Telegram ID: 585583379 |
| Berni (CEO) | Telegram ID: 693441689 |
| BotFather | @BotFather en Telegram |
| OpenRouter | support@openrouter.ai |
| Tavily | support@tavily.com |
| GitHub Security | security@github.com |

---

## Historial
- **v1.0.0** (2026-07-07): Versión inicial completa con 8 tipos de incidente, playbooks, forense, legal, post-incidente