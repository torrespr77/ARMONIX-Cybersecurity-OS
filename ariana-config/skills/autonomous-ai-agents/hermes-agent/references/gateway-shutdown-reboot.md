# Gateway Shutdown & Reboot Procedure

## Stop (Clean Shutdown)

```bash
# 1. Check current status
hermes gateway status

# 2. Stop the gateway (closes all connections cleanly)
hermes gateway stop

# 3. Verify it stopped
hermes gateway status
# Expected: 'stopped' or 'not running'

# 4. Kill residual processes if needed
pkill -f "hermes gateway"
pkill -f hermes
ps aux | grep hermes | grep -v grep  # should be empty
```

## Start (Boot)

```bash
# Start in foreground (to see logs)
hermes gateway start

# OR start in background (recommended for production)
nohup hermes gateway start &

# Verify
hermes gateway status
# Expected: 'running' with channels listed as connected
```

## Restart (Shortcut)

```bash
hermes gateway restart
```

## Emergency: Process Won't Stop

```bash
# Last resort only — can corrupt session DB if used carelessly
kill -9 $(pgrep -f hermes)
# After: check DB integrity
sqlite3 ~/.hermes/state.db 'PRAGMA integrity_check;'
```

## Verification Checklist

| Check | Command | Expected |
|---|---|---|
| Gateway running | `hermes gateway status` | `running` |
| No residual processes | `ps aux | grep hermes | grep -v grep` | empty |
| DB integrity | `sqlite3 ~/.hermes/state.db 'PRAGMA integrity_check;'` | `ok` |
| Logs clean | `tail -20 ~/.hermes/logs/gateway.log` | No FATAL/ERROR |
| Telegram connected | check logs | `Telegram connection established` |
| Cron jobs active | `hermes cron list` | jobs listed |

## Key Paths

```
~/.hermes/config.yaml       Main configuration
~/.hermes/.env              API keys and secrets
~/.hermes/state.db          Session store (SQLite)
~/.hermes/logs/gateway.log  Gateway logs
~/.hermes/skills/           Skill files (PERSISTENT — not deleted by cleanup)
~/.hermes/memory/           Memory files (MEMORY.md, USER.md)
```

## Important Notes

- **NEVER use `kill -9`** unless `hermes gateway stop` fails repeatedly — it can corrupt the session database
- **Cron jobs survive reboots** — stored in SQLite, reactivated on start
- **Skills are permanent** — stored in `~/.hermes/skills/`, not affected by gateway restarts or curator cleanup
- **Memory is persistent** — MEMORY.md and USER.md survive reboots
- **Active sessions close on shutdown** — history preserved in SQLite, users just send a new message
- **systemd**: if configured, Hermes starts automatically on server reboot
