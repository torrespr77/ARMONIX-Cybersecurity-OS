# Runbook: GitHub Backup de Configuración Ariana Agent

**Objetivo**: Respaldar toda la configuración del agente Hermes (Ariana) al repo privado `torrespr77/Cybersecurity` de forma semanal automatizada.

---

## Frecuencia y Trigger

- **Cron**: Weekly Health Check (viernes 10:00 AM, job `b1b8a3c46227`)
- **Script**: `~/scripts/sync-to-github.sh`
- **Entrega**: Output incluido en reporte del Weekly Health Check

---

## Qué se Respalda

| Archivo/Directorio | Origen | Destino en GitHub | Notas |
|---|---|---|---|
| `SOUL.md` | `~/.hermes/SOUL.md` | `ariana-config/SOUL.md` | Personalidad de Ariana |
| `MEMORY.md` | `~/.hermes/MEMORY.md` | `ariana-config/MEMORY.md` | Memoria system prompt |
| `memories-MEMORY.md` | `~/.hermes/memories/MEMORY.md` | `ariana-config/memories-MEMORY.md` | Memory store persistente |
| `memories-U` | `~/.hermes/memories/USER.md` | `ariana-config/memories-USER.md` | User store persistente |
| `USER.md` | `~/.hermes/USER.md` | `ariana-config/USER.md` | Perfil usuario |
| `config.yaml` | `~/.hermes/config.yaml` | `ariana-config/config.yaml.sanitized` | **SANITIZADA** |
| `cron-jobs.json` | `~/.hermes/cron/jobs.json` | `ariana-config/cron-jobs.json` | 3 cron jobs |
| `skills/` | `~/.hermes/skills/` | `ariana-config/skills/` | 130 skills (20 activas + 110 .archive) |
| `scripts/` | `~/scripts/` | `ariana-config/scripts/` | 6 scripts operacionales |

---

## Sanitización de Secrets (CRÍTICO)

El script aplica 12 patrones de sed a `config.yaml` antes de subir:

```bash
# API keys, tokens, passwords, secrets → ***REDACTED***
api_key: ***REDACTED***
token: ***REDACTED***
password: ***REDACTED***
secret: ***REDACTED***
# Tokens conocidos: sk-, pk-, AKIA, ghp_, ghp_, ghp_, Telegram (digitos:texto)
```

**NUNCA se suben**: `.env`, `auth.json`, `state.db`, `state.db-*`, `logs/`, `backups/`, `node_modules/`, `venv/`, `hermes-agent/` (código fuente oficial).

---

## Estructura en GitHub

```
torrespr77/Cybersecurity/
├── .gitignore                    # Bloquea .env, auth.json, *.db, logs/, backups/
├── README.md
├── ariana-config/
│   ├── README.md                 # Instrucciones de restore
│   ├── SOUL.md
│   ├── MEMORY.md
│   ├── USER.md
│   ├── memories-MEMORY.md
│   ├── memories-USER.md
│   ├── config.yaml.sanitized
│   ├── cron-jobs.json
│   ├── scripts/
│   │   ├── sync-to-github.sh
│   │   ├── check-tool-versions.py
│   │   ├── backup_arsenal.sh
│   │   ├── hermes_backup.sh
│   │   └── pre-reboot-snapshot.sh
│   └── skills/
│       ├── automation/
│       ├── cybersecurity/
│       └── .archive/             # 110 skills archivadas
├── reports/
├── docs/
└── contracts/
```

---

## Formato de Commit

```
backup: ariana-config weekly sync

- Skills: 20 active, 110 archived (130 total)
- Memory store: 2,663 chars
- User store: 2,247 chars
- Scripts: 6 files
- Config: sanitized (secrets redacted)
- Changed files: 12
- Generated: 2026-07-07 10:00:00
```

Si no hay cambios: script sale silencioso sin commit.

---

## Procedimiento de Restauración (Disaster Recovery)

```bash
# 1. Clonar repo
cd ~ && git clone git@github.com:torrespr77/Cybersecurity.git brida-security-project

# 2. Restaurar identidad
cp ~/brida-security-project/ariana-config/SOUL.md ~/.hermes/
cp ~/brida-security-project/ariana-config/USER.md ~/.hermes/
cp ~/brida-security-project/ariana-config/MEMORY.md ~/.hermes/

# 3. Restaurar memoria persistente
mkdir -p ~/.hermes/memories/
cp ~/brida-security-project/ariana-config/memories-MEMORY.md ~/.hermes/memories/MEMORY.md
cp ~/brida-security-project/ariana-config/memories-USER.md ~/.hermes/memories/USER.md

# 4. Restaurar skills
rsync -av ~/brida-security-project/ariana-config/skills/ ~/.hermes/skills/

# 5. Restaurar scripts
mkdir -p ~/scripts/
cp ~/brida-security-project/ariana-config/scripts/* ~/scripts/
chmod +x ~/scripts/*.sh ~/scripts/*.py

# 6. Restaurar config (RELLENAR SECRETS MANUALMENTE)
cp ~/brida-security-project/ariana-config/config.yaml.sanitized ~/.hermes/config.yaml
# Editar y rellenar: api_key de OpenRouter, bot_token Telegram, api_key Tavily, etc.

# 7. Recrear cron jobs (desde cron-jobs.json)
hermes cron create --schedule "0 9 * * *" --prompt "..." --name "Daily Health Check"
hermes cron create --schedule "0 10 * * 5" --prompt "..." --name "Weekly Health Check"
hermes cron create --schedule "0 23 * * *" --prompt "..." --name "Nightly Backup" -T

# 8. Restaurar .env (MANUAL - NO en repo)
cat > ~/.hermes/.env << 'EOF'
TELEGRAM_BOT_TOKEN=<nuevo_token_de_BotFather>
TAVILY_API_KEY=<tavily_key>
# ... otras variables
EOF

# 9. Reiniciar gateway
hermes gateway restart
```

---

## Verificación Post-Restore

```bash
# 1. Gateway up
hermes gateway status

# 2. Health check
bash ~/.hermes/skills/automation/hermes-daily-check/scripts/daily-check.sh
# Debe dar [SILENT]

# 3. Ariana responde en Telegram
# 4. Skills cargadas: ls ~/.hermes/skills/
# 5. Cron jobs: hermes cron list
```

---

## Seguridad

- Repo **DEBE SER PRIVATE** (`torrespr77/Cybersecurity` ✅)
- Deploy key SSH (`~/.ssh/id_ed25519`) para push
- Git identity: `Roger Torres <torrespr77@users.noreply.github.com>`
- Sanitización verificada: `grep -iE "(api_key|token|password)" ariana-config/config.yaml.sanitized` → solo `***REDACTED***`
- `.env` y `auth.json` NUNCA en repo (bloqueados por `.gitignore`)

---

## Historial

- **v1.0.0** (2026-07-07): Primer sync exitoso - commit `23d97b4`, 570 archivos, 130 skills, 6 scripts
- Integrado en Weekly Health Check (viernes 10AM) como PASO 3