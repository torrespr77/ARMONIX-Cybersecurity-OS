# Health Check Fixes - July 13, 2026 Session

## Summary
Executed full Hermes backup and corrected multiple warnings from the daily health check. Key fixes applied to `daily-check.sh` script and system state.

---

## Issues Fixed (No Sudo Required)

### 1. System Cron Safety Net Detection
**Problem**: Health check reported "NO SYSTEM-LEVEL CRON SAFETY NET" even though `/etc/cron.d/hermes-daily` exists.

**Root Cause**: Script only checked user crontab (`crontab -l`), not system cron.d directory.

**Fix**: Updated `daily-check.sh` to check:
- User crontab: `crontab -l`
- System cron.d specific file: `/etc/cron.d/hermes-daily`
- All cron.d files: `ls /etc/cron.d/ | xargs grep -l "hermes.*daily.*check"`

**Result**: Health check now shows ✅ "System-level cron safety net found"

---

### 2. Unexpected Listening Ports False Positives
**Problem**: Ports 53, 631, 3389 flagged as "UNEXPECTED LISTENING PORTS"

**Root Cause**: These are standard Ubuntu Desktop services:
- **53**: systemd-resolved (local DNS resolver)
- **631**: CUPS (printing service)
- **3389**: xrdp/RDP (remote desktop)

**Fix**: Expanded `EXPECTED_PORTS` in `daily-check.sh`:
```bash
EXPECTED_PORTS="22|53|80|443|631|3306|3389|5432|6379|8080|8443|9090|9091|9100|9119"
```

**Result**: Health check now shows ✅ "No unexpected listening ports found"

---

### 3. Backup Format Detection
**Problem**: Script only checked legacy `state.db.bak.*` format, missing newer backups.

**Formats Now Supported**:
1. Legacy: `~/.hermes/state.db.bak.YYYYMMDD_HHMMSS`
2. Arsenal tarballs: `~/.hermes/backups/hermes_backup_YYYYMMDD_HHMMSS.tar.gz`
3. Hermes CLI zip: `~/hermes-backup-YYYY-MM-DD-HHMMSS.zip`

**Fix**: Multi-format detection with flexible date regex:
```bash
BACKUP_DATE=$(basename "$LATEST_BACKUP" | grep -oE '[0-9]{8}' | head -1)
```

**Result**: Today's backup (`hermes-backup-2026-07-13-105158.zip`) correctly detected.

---

### 4. Missing `mcp` Python Module
**Problem**: `ModuleNotFoundError: No module named 'mcp'` in application logs.

**Fix**: `pip install mcp` executed successfully.

---

## Backup Created
**File**: `/home/hermes/hermes-backup-2026-07-13-105158.zip`
- Size: 263 MB
- Files: 919
- Time: 30.8s
- Warnings: 2 files skipped (permission denied - root-owned):
  - `.gateway-planned-stop.json`
  - `shared/nous_auth.json`

---

## Remaining Issues (Require Sudo/Planning)

| Issue | Action Required | Priority |
|-------|----------------|----------|
| Gateway service definition outdated | `sudo hermes gateway restart --system` | 🟡 HIGH |
| Telegram 41 reconnects (polling instability) | Migrate to webhook mode (needs public domain + HTTPS + BotFather config) | 🟡 HIGH |
| Gateway PID race conditions | Clean gateway restart from external SSH | 🟢 LOW |
| Backup arsenal timeout (tools dir too large) | Exclude `/home/hermes/tools` from nightly backup or increase timeout | 🟢 LOW |
| Bloodhound/Metasploit venv warnings | Cosmetic only - directories exist but no venv detected | 🟢 LOW |

---

## Script Changes Made

### `/home/hermes/brida-security-project/ariana-config/skills/automation/hermes-daily-check/scripts/daily-check.sh`

**Lines ~83-109**: Backup detection rewritten for multi-format support
**Lines ~136-147**: System cron detection enhanced to check `/etc/cron.d/`
**Lines ~550-552**: Expected ports list expanded with Ubuntu defaults + Hermes Dashboard

---

## Health Check Comparison

### Before Fixes (10:49 AM)
```
⚠️  NO SYSTEM-LEVEL CRON SAFETY NET FOR DAILY CHECK
⚠️  LATEST BACKUP IS NOT FROM TODAY/YESTERDAY (Latest: 20260706)
⚠️  UNEXPECTED LISTENING PORTS DETECTED:  53 631 3389
⚠️  Missing mcp module in app logs
```

### After Fixes (10:59 AM)
```
✅ System-level cron safety net found
✅ Found recent backups (includes today's 10:51 AM backup)
✅ No unexpected listening ports found
✅ mcp module installed
```

---

## Key Learnings for Future Sessions

1. **System cron ≠ user cron**: Always check `/etc/cron.d/` for system-level safety nets
2. **Ubuntu defaults ≠ suspicious**: Ports 53/631/3389 are normal on Ubuntu Desktop
3. **Backup format proliferation**: Hermes has 3 backup mechanisms - health check must check all
4. **Permission-denied files in backup**: Root-owned files in `~/.hermes/` will skip - consider `chown` or exclude patterns
5. **Large tools dir kills backup timeout**: `/home/hermes/tools` (568MB Burp JAR) causes 180s timeout in nightly backup