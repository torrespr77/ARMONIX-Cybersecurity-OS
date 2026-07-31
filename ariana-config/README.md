# 🤖 Ariana Agent — Configuration Backup

This directory contains the full configuration backup of **Ariana**, 
a Hermes Agent instance for cybersecurity consulting at BRIDA IT Services.

## Contents

| Directory/File | Description |
|---|---|
| `SOUL.md` | Agent personality and identity |
| `MEMORY.md` | System prompt memory copy |
| `memories-MEMORY.md` | Persistent memory store (memory) |
| `memories-USER.md` | Persistent memory store (user profile) |
| `USER.md` | User profile copy |
| `config.yaml.sanitized` | Hermes config with secrets redacted |
| `cron-jobs.json` | Scheduled cron job definitions |
| `skills/` | All skills (active + archived) |
| `scripts/` | Operational scripts |

## Stats

- **Skills**: 139 total (139 active, 0 archived)
- **Memory store**: 7971 chars
- **User store**: 8120 chars
- **Scripts**: 11 files
- **Generated**: 2026-07-31 10:01:29

## Restore Instructions

To restore Ariana on a new Hermes Agent instance:

```bash
# 1. Copy identity
cp ariana-config/SOUL.md ~/.hermes/
cp ariana-config/USER.md ~/.hermes/

# 2. Copy persistent memory
cp ariana-config/memories-MEMORY.md ~/.hermes/memories/MEMORY.md
cp ariana-config/memories-USER.md ~/.hermes/memories/USER.md

# 3. Copy skills
rsync -av ariana-config/skills/ ~/.hermes/skills/

# 4. Copy scripts
cp ariana-config/scripts/* ~/scripts/

# 5. Review config.yaml.sanitized and fill in secrets
#    DO NOT copy blindly — you need to set your actual API keys, tokens, etc.
cp ariana-config/config.yaml.sanitized ~/.hermes/config.yaml
# Edit and fill in: Telegram bot token, Tavily API key, provider keys, etc.

# 6. Import cron jobs
# Review ariana-config/cron-jobs.json and recreate via: hermes cron create ...

# 7. Restart gateway
hermes gateway restart
```

## Security

- All secrets (API keys, tokens, passwords) are redacted as `***REDACTED***`
- The `.env` file is NEVER included — it contains live credentials
- `auth.json` is NEVER included — it contains provider authentication
- `state.db` is NEVER included — it contains conversation history
- This repo MUST remain **private**

## Schedule

This backup runs automatically every Friday at 10:00 AM (America/Mexico_City)
as part of the Hermes Weekly Health Check.

---
Author: Ariana (Hermes Agent) for Ing. Rogelio Torres Pimentel
Last sync: 2026-07-31 10:01:29
