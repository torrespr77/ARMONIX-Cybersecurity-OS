# Incident Response Procedures — Ariana Agent

## Severity Matrix

| Severity | Impact | SLA Response | Escalate To |
|---|---|---|---|
| S1 CRITICA | Datos sensibles comprometidos, sistema caído | 15 min | Roger + Berni (CEO) |
| S2 ALTA | Funcionalidad degradada, riesgo alto | 30 min | Roger |
| S3 MEDIA | Problema operativo, riesgo moderado | 2 horas | Roger (auto-resolver si posible) |
| S4 BAJA | Incidente menor, sin impacto security | 8 horas | Ariana (auto-resolver) |

## Incident Types and Playbooks

### 1. Token Comprometido (S1)
- **Symptoms**: Token visible in chat/logs/GitHub, 401 Unauthorized errors
- **Response**: Confirm exposure → Revoke at BotFather/Provider dashboard → Update .env → Restart gateway → Verify integrity
- **Key**: NEVER write tokens in Telegram chat — they get auto-revoked

### 2. Acceso No Autorizado (S1-S2)
- **Symptoms**: SSH logins from unknown IPs, unexpected processes, modified files
- **Response**: Isolate (gateway stop) → Forensic capture → Erradicate → Restore from backup
- **Forensic dir**: `~/incident-YYYYMMDD/`

### 3. Gateway Down (S2)
- **Symptoms**: Bot unresponsive, gateway status fails
- **Response**: Diagnose (logs, resources) → Restart (from external terminal, NEVER from agent) → If DB corrupt, restore from backup
- **Key**: `hermes gateway restart` from within agent = auto-SIGTERM

### 4. Data Leakage (S1)
- **Symptoms**: Sensitive data in public repo, client data in Telegram
- **Response**: Identify scope → Contain (git filter-branch if in GitHub) → Notify affected parties → Legal (LFPDPPP if personal data)

### 5. Skill Corruption (S2-S3)
- **Symptoms**: Skills not loading, count mismatch, abnormal behavior
- **Response**: Identify affected → Restore from GitHub backup (rsync) → Investigate cause

### 6. Cron Job Failure (S3-S4)
- **Symptoms**: No output in cron/output/, ticker heartbeat stale
- **Response**: Check ticker → Restart gateway → Run jobs manually → Fix prompt if needed

### 7. Provider API Compromised (S1-S2)
- **Symptoms**: Abnormal API usage, unexpected costs, rate limiting
- **Response**: Revoke key immediately → Generate new → Update .env → Restart gateway

## Isolation Levels

| Level | Action | When |
|---|---|---|
| 1 Soft Stop | `hermes gateway stop` | Suspicion, need to analyze |
| 2 Token Revocation | Revoke all API tokens | Token compromise confirmed |
| 3 Network Isolation | Block outbound traffic | Active exfiltration |
| 4 Full Shutdown | `sudo shutdown -h now` | Total compromise |

## Forensic Capture (10 steps)

```bash
INCIDENT_DIR=~/incident-$(date +%Y%m%d-%H%M%S)
mkdir -p $INCIDENT_DIR
ps aux > $INCIDENT_DIR/processes.txt
netstat -tulnp > $INCIDENT_DIR/network.txt 2>&1
last > $INCIDENT_DIR/logins.txt
cp -r ~/.hermes/logs/ $INCIDENT_DIR/hermes-logs/
hermes gateway status > $INCIDENT_DIR/gateway-status.txt 2>&1
cp ~/.hermes/cron/jobs.json $INCIDENT_DIR/
cd ~/brida-security-project && git log --all --oneline -50 > $INCIDENT_DIR/git-log.txt
find ~/.hermes/skills -name "SKILL.md" -exec md5sum {} + > $INCIDENT_DIR/skills-hash.txt
cp ~/.hermes/memories/MEMORY.md $INCIDENT_DIR/
find ~ -mtime -1 -type f -not -path "*/.hermes/logs/*" > $INCIDENT_DIR/recent-files.txt
```

## Emergency Contacts

| Contact | Method |
|---|---|
| Roger Torres | Telegram: 585583379 |
| Berni (CEO) | Telegram: 693441689 |
| BotFather | @BotFather (revoke/regenerate tokens) |
| OpenRouter | support@openrouter.ai |
| Tavily | support@tavily.com |
| GitHub Security | security@github.com |

## Notification SLA

| Severity | Roger | Berni | Client |
|---|---|---|---|
| S1 | 15 min | 30 min | 1 hour |
| S2 | 30 min | 2 hours | 4 hours (if applicable) |
| S3 | 2 hours | No | No |
| S4 | Weekly report | No | No |

## Legal Considerations

- LFPDPPP: Notify INAI if personal data compromised
- Review client contracts for incident notification clauses
- All S1-S2 incidents require formal written report
- Preserve forensic evidence minimum 90 days

## Post-Incident Report Fields

ID, Detection date, Resolution date, Duration, Severity, Type, Description, 
Impact, Root cause, Actions taken, Lessons learned, Corrective actions, 
Runbook updates needed, Evidence directory path.

## Full Runbook

See: `Runbook_Respuesta_Incidentes_Ariana_v1.0.0.docx` (generated July 2026)
