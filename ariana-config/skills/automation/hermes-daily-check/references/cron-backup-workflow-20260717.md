# Cron Job & Backup Workflow — 2026-07-17 Update

## Overview
Roger restructured the cron job schedule to run all maintenance tasks on **Fridays** in a clean sequence:
**Clean → Backup → Health Check**

---

## Current Cron Jobs (Active as of 2026-07-17)

| Job ID | Name | Schedule | Description |
|--------|------|----------|-------------|
| `309e244039eb` | **Weekly Disk Cleanup** | `0 8 * * 5` (Fri 08:00) | Purges old backups (keep 3), clears pip/npm/huggingface/uv/nvidia caches, reports disk usage |
| `f93a5953e431` | **Hermes Weekly Backup** | `0 9 * * 5` (Fri 09:00) | Runs `~/scripts/backup_arsenal.sh` — creates arsenal backup (~4GB) + Hermes config backup (~41MB) in `~/.hermes/backups/` |
| `b1b8a3c46227` | **Hermes Weekly Health Check** | `0 10 * * 5` (Fri 10:00) | Full health check: gateway, disk, memory, backups, tools, network, cron systemd, GitHub sync (`sync-to-github.sh`) |

**Removed:** `ff22f6cee779` — Daily Health Check (was `0 9 * * *`)

---

## Friday Timeline

```
08:00  →  Weekly Disk Cleanup
         • Removes hermes_backup_*.tar.gz older than 3 most recent
         • pip cache purge, npm cache clean --force
         • rm -rf ~/.cache/{pip,huggingface,uv,nvidia}
         • df -h /home → reports usage

09:00  →  Hermes Weekly Backup (backup_arsenal.sh)
         • Creates timestamped tarballs in ~/.hermes/backups/
         • arsenal: ~4 GB (pentest tools + binaries)
         • config: ~41 MB (Hermes configs)

10:00  →  Hermes Weekly Health Check
         • Runs all health checks (gateway, disk, memory, backups, tools, network, cron)
         • Executes `hermes backup` → creates ZIP ~268 MB in ~/
         • Runs `~/scripts/sync-to-github.sh` → pushes sanitized config to torrespr77/Cybersecurity
         • Prunes old backups (keep last 3)
         • Reports final disk usage
```

---

## Backup Artifacts

### Arsenal Backup (backup_arsenal.sh)
- Location: `~/.hermes/backups/hermes_backup_YYYYMMDD_HHMMSS.tar.gz`
- Contents: `~/.local/bin/`, `~/.local/lib/`, `~/tools/` (pentest arsenal)
- Size: ~4 GB
- Retention: Keep last 3 (handled by Weekly Disk Cleanup + Health Check)

### Hermes Config Backup (hermes backup)
- Location: `~/hermes-backup-YYYY-MM-DD-HHMMSS.zip`
- Contents: SOUL.md, MEMORY.md, USER.md, config.yaml (sanitized), cron-jobs.json, skills/, scripts/
- Size: ~268 MB
- Retention: Keep last 3 (handled by Weekly Health Check)

### GitHub Sync (sync-to-github.sh)
- Repo: `torrespr77/Cybersecurity` (private)
- Branch: `main`
- Commit format: `backup: ariana-config weekly sync`
- Sanitization: 12 sed patterns → `***REDACTED***` for api_key, token, password, secret, sk-*, AKIA*, ghp_*, Telegram tokens
- NEVER includes: `.env`, `auth.json`, `state.db`, `logs/`, `hermes-agent/`

---

## Manual Execution (Tested 2026-07-17)

```bash
# Run backup now
hermes run cronjob --job-id f93a5953e431

# Run health check now (includes GitHub sync)
hermes run cronjob --job-id b1b8a3c46227

# Run disk cleanup now
hermes run cronjob --job-id 309e244039eb
```

All three executed successfully on 2026-07-17:
- Backup: Created 2 tarballs (4.1 GB + 41 MB) in `~/.hermes/backups/`
- Health check: Created ZIP (268 MB), GitHub sync commit `2c8f440`
- Disk: 77% → 57% after cleanup → 61% after new backups

---

## Disk Space Policy

| Threshold | Action |
|-----------|--------|
| < 70% | Normal |
| 70-80% | Warning — trigger cleanup |
| > 80% | Critical — immediate cleanup + alert |

**Current (post-cleanup + new backups):** 61% (63 GB used / 110 GB)

---

## Key Files

| File | Purpose |
|------|---------|
| `~/scripts/backup_arsenal.sh` | Arsenal + config backup to `~/.hermes/backups/` |
| `~/scripts/sync-to-github.sh` | Sanitized config sync to GitHub |
| `~/scripts/daily-check.sh` | Daily health check (no longer cron-scheduled) |
| `~/scripts/check-tool-versions.py` | Tool version check vs GitHub releases |
| `~/.hermes/cron/jobs.json` | Hermes cron job definitions |

---

## Pitfalls & Fixes Applied

### Chat ID for Telegram
- **Wrong:** `@RogelioTr` (username)
- **Correct:** `585583379` (numeric chat_id)
- **Rule:** Cron jobs output `[SILENT]` on success; Hermes delivers to configured `deliver` target automatically.

### Gateway Race Condition
- Multiple instances can start simultaneously
- **Fix:** `pkill -f "hermes_cli.main gateway run" && hermes gateway restart` from external SSH

### Wrapper Script Heredoc Bug
- **Never** use `cat > ~/.local/bin/tool << 'EOF'` inside a tool's git-cloned directory
- Overwrites original script → recursive shell (SHLVL=1000)
- **Fix:** Use `write_file` tool to create wrappers in `~/.local/bin/`

### Backup Timeout
- Large tarballs (>1.6 GB) exceed 300s terminal timeout
- **Fix:** Increase timeout or stream compression

---

## Verification Commands

```bash
# List cron jobs
hermes cronjob list

# Check backup directory
ls -lh ~/.hermes/backups/

# Check disk usage
df -h /home

# Verify GitHub sync
cd ~/brida-security-project && git log --oneline -3

# Verify no secrets in sanitized config
grep -iE "(api_key|token|password|secret)" ~/brida-security-project/ariana-config/config.yaml.sanitized
# Should show only ***REDACTED***
```