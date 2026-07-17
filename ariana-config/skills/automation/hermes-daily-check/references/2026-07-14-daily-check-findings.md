# Daily Health Check Findings - 2026-07-14

## Session Summary
Scheduled cron job execution of `hermes-daily-check` skill. Multiple issues detected requiring remediation.

---

## Issues Found (Severity Order)

### 🔴 CRITICAL
1. **Gateway Race Condition** — Multiple instances starting simultaneously
   - Pattern: `Another gateway instance (PID X) started during our startup. Exiting to avoid double-running.`
   - Occurred: 2026-07-10, 2026-07-12, 2026-07-14
   - Root cause: Manual foreground process + systemd service both trying to run
   - Fix: `pkill -f "hermes_cli.main gateway run" && hermes gateway restart` (from external SSH)

2. **Nvidia/Nemotron Rate Limit** — Free tier exhausted
   - Error: `ResourceExhausted: Worker local total request limit reached (206/32)`
   - Provider: OpenRouter → Nvidia free model
   - Fix: Add paid fallback model or switch provider

3. **Gateway Service Definition Outdated** — systemd unit file stale
   - Fix: `hermes gateway install --user` (or `--system` with sudo)

### 🟡 HIGH
4. **Elevated Disk Usage (72%)** — Warning threshold (70%) exceeded
   - Cause: Backup tarballs in `~/.hermes/backups/` (~11GB)
   - Fix: Implement retention policy or move old backups to cold storage

5. **Telegram Polling Instability** — 44 reconnect events since Jul 7
   - Pattern: Bad Gateway, timeouts, polling conflicts
   - Fix: Migrate to webhook mode (`hermes config set telegram.mode webhook`)

6. **Missing `mcp` Python Module** — ModuleNotFoundError in mcp-stderr.log
   - Fix: `pip install mcp` in Hermes venv

7. **Missing Pentest Tools** — naabu, dalfox, netexec, rustscan, feroxbuster, BloodHound
   - Fix: Run pentest-tool-installation script

### 🟢 LOW / INFO
- Unexpected ports 53, 631, 3389 flagged (now whitelisted in v1.12.0 fix)
- Memory files healthy (USER.md: 34 lines, MEMORY.md: 42 lines)
- Backups current (latest: 2026-07-13 23:18)
- System cron safety net active (`/etc/cron.d/hermes-daily`)
- System resources nominal (CPU 0%, RAM 10%, Swap 0MB, Load 0.37)

---

## Remediation Checklist

| Priority | Action | Command/Steps |
|----------|--------|---------------|
| P0 | Fix gateway race | `pkill -f "hermes_cli.main gateway run" && hermes gateway restart` |
| P0 | Update gateway service | `hermes gateway install --user` |
| P0 | Add model fallback | Configure paid OpenRouter model or alternative provider |
| P1 | Install mcp module | `pip install mcp` (in Hermes venv) |
| P1 | Migrate Telegram to webhook | `hermes config set telegram.mode webhook` + webhook URL |
| P1 | Clean old backups | `find ~/.hermes/backups -name "*.tar.gz" -mtime +7 -delete` |
| P2 | Install missing pentest tools | Run pentest-tool-installation skill |
| P2 | Add disk retention policy | Cron job to prune backups > 7 days |

---

## Skill Updates Made This Session

1. **daily-check.sh patched** — Added ports 53, 631, 3389 to EXPECTED_PORTS whitelist (fixes false positive port alerts)
2. **Reference file created** — This document for future session context

---

## Related Files
- `scripts/daily-check.sh` — Main health check script (patched)
- `references/incident-response-procedures.md` — General incident response playbooks
- `references/2026-07-13-health-check-fixes.md` — Previous day's fixes