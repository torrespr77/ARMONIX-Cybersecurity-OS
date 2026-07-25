#!/bin/bash
# Hermes Agent Daily Check Script
# Performs health check and outputs alert or [SILENT]

# Output file for consolidated issues
ISSUES_FILE=$(mktemp)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Initialize issues flag
HAS_ISSUES=0

# 1. Check Gateway Status
echo "🔍 Checking gateway status..." >&2
GATEWAY_STATUS=$(hermes gateway status 2>&1)
GATEWAY_EXIT=$?

if [ $GATEWAY_EXIT -ne 0 ]; then
    echo "❌ GATEWAY STATUS CHECK FAILED" >> "$ISSUES_FILE"
    echo "   Exit code: $GATEWAY_EXIT" >> "$ISSUES_FILE"
    echo "   Output: $GATEWAY_STATUS" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    # Check for concerning patterns in output
    if echo "$GATEWAY_STATUS" | grep -qi "error\|fail\|another.*gateway.*started\|exiting.*to.*avoid.*double\|service.*outdated\|both.*user.*and.*system.*gateway"; then
        echo "⚠️  GATEWAY STATUS ISSUES DETECTED" >> "$ISSUES_FILE"
        echo "   Output shows potential problems:" >> "$ISSUES_FILE"
        echo "$GATEWAY_STATUS" | grep -i "error\|fail\|another.*gateway.*started\|exiting.*to.*avoid.*double\|service.*outdated\|both.*user.*and.*system.*gateway" | sed 's/^/   /' >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
    
    # Check for manual foreground process blocking systemd
    if echo "$GATEWAY_STATUS" | grep -q "PID(s):"; then
        MANUAL_PID=$(echo "$GATEWAY_STATUS" | grep "PID(s):" | sed 's/.*PID(s): *//')
        if [ -n "$MANUAL_PID" ]; then
            echo "⚠️  MANUAL GATEWAY PROCESS DETECTED BLOCKING SYSTEMD" >> "$ISSUES_FILE"
            echo "   Manual process PID: $MANUAL_PID" >> "$ISSUES_FILE"
            echo "   This prevents systemd service from starting properly" >> "$ISSUES_FILE"
            echo "   Fix: pkill -f \"hermes_cli.main gateway run\" && hermes gateway restart" >> "$ISSUES_FILE"
            HAS_ISSUES=1
        fi
    fi
    
    # Check for Telegram bot token validation issues
    if echo "$GATEWAY_STATUS" | grep -qi "token.*reject\|invalid.*token\|chat not found"; then
        echo "⚠️  TELEGRAM BOT TOKEN/CHAT ID VALIDATION ISSUE" >> "$ISSUES_FILE"
        echo "   Gateway logs show token rejected or chat not found" >> "$ISSUES_FILE"
        echo "   Verify TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID in config" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
fi
echo "" >> "$ISSUES_FILE"

# 2. Check Persistent Memory Files
echo "🔍 Checking memory files..." >&2
USER_FILE="$HOME/.hermes/USER.md"
MEMORY_FILE="$HOME/.hermes/MEMORY.md"

if [ ! -f "$USER_FILE" ]; then
    echo "❌ MISSING USER.MD FILE" >> "$ISSUES_FILE"
    echo "   Expected: $USER_FILE" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

if [ ! -f "$MEMORY_FILE" ]; then
    echo "❌ MISSING MEMORY.MD FILE" >> "$ISSUES_FILE"
    echo "   Expected: $MEMORY_FILE" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

if [ -f "$USER_FILE" ] && [ -f "$MEMORY_FILE" ]; then
    echo "✅ Memory files present: USER.md: $(wc -l < "$USER_FILE") lines, $(wc -c < "$USER_FILE") bytes" >> "$ISSUES_FILE"
    echo "✅ Memory MEMORY.md: $(wc -l < "$MEMORY_FILE") lines, $(wc -c < "$MEMORY_FILE") bytes" >> "$ISSUES_FILE"
fi
echo "" >> "$ISSUES_FILE"

# 3. Check Disk Space
echo "🔍 Checking disk space..." >&2
DF_OUTPUT=$(df -h /home 2>&1)
DF_EXIT=$?

if [ $DF_EXIT -ne 0 ]; then
    echo "❌ DISK CHECK FAILED" >> "$ISSUES_FILE"
    echo "   Command: df -h /home" >> "$ISSUES_FILE"
    echo "   Error: $DF_OUTPUT" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    USAGE_PCT=$(echo "$DF_OUTPUT" | tail -1 | awk '{print $5}' | tr -d '%')
    if [ -z "$USAGE_PCT" ] || ! [[ "$USAGE_PCT" =~ ^[0-9]+$ ]]; then
        echo "❌ COULD NOT PARSE DISK USAGE" >> "$ISSUES_FILE"
        echo "   Output: $DF_OUTPUT" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    elif [ "$USAGE_PCT" -gt 80 ]; then
        echo "⚠️  HIGH DISK USAGE DETECTED" >> "$ISSUES_FILE"
        echo "   Usage: $USAGE_PCT% (threshold: 80%)" >> "$ISSUES_FILE"
        echo "   Details: $DF_OUTPUT" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    elif [ "$USAGE_PCT" -gt 70 ]; then
        echo "⚠️  ELEVATED DISK USAGE (WARNING TIER)" >> "$ISSUES_FILE"
        echo "   Usage: $USAGE_PCT% (warning: 70%, alert: 80%)" >> "$ISSUES_FILE"
        echo "   Details: $DF_OUTPUT" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "✅ Disk usage: $USAGE_PCT% (OK)" >> "$ISSUES_FILE"
    fi
fi
echo "" >> "$ISSUES_FILE"

# 4. Check Recent Backups
echo "🔍 Checking backups..." >&2

# Check BOTH backup formats: legacy state.db.bak.* AND new hermes_backup_*.tar.gz
BACKUP_FILES_LEGACY=$(ls -lt "$HOME/.hermes/state.db.bak."* 2>/dev/null | head -3)
BACKUP_FILES_NEW=$(ls -lt "$HOME/.hermes/backups/hermes_backup_"*.tar.gz 2>/dev/null | head -3)

BACKUP_FILES=""
if [ -n "$BACKUP_FILES_NEW" ]; then
    BACKUP_FILES="$BACKUP_FILES_NEW"
elif [ -n "$BACKUP_FILES_LEGACY" ]; then
    BACKUP_FILES="$BACKUP_FILES_LEGACY"
fi

if [ -z "$BACKUP_FILES" ]; then
    echo "❌ NO RECENT BACKUPS FOUND" >> "$ISSUES_FILE"
    echo "   Searched: $HOME/.hermes/state.db.bak.* and $HOME/.hermes/backups/hermes_backup_*.tar.gz" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "✅ Found recent backups:" >> "$ISSUES_FILE"
    echo "$BACKUP_FILES" | sed 's/^/   /' >> "$ISSUES_FILE"
    
    # Use the newest backup (prefer new format)
    LATEST_BACKUP=""
    if [ -n "$BACKUP_FILES_NEW" ]; then
        LATEST_BACKUP=$(ls -t "$HOME/.hermes/backups/hermes_backup_"*.tar.gz 2>/dev/null | head -1)
    else
        LATEST_BACKUP=$(ls -t "$HOME/.hermes/state.db.bak."* 2>/dev/null | head -1)
    fi
    
    if [ -n "$LATEST_BACKUP" ]; then
        BACKUP_BASENAME=$(basename "$LATEST_BACKUP")
        # Extract date from formats: 
        # - state.db.bak.20260706_020034 or state.db.bak.2026-07-06_020034
        # - hermes_backup_20260712_201954.tar.gz
        if echo "$BACKUP_BASENAME" | grep -qE 'hermes_backup_([0-9]{8})_'; then
            BACKUP_DATE=$(echo "$BACKUP_BASENAME" | sed -E 's/.*hermes_backup_([0-9]{8})_.*/\1/')
        elif echo "$BACKUP_BASENAME" | grep -qE '\.([0-9]{8})_'; then
            BACKUP_DATE=$(echo "$BACKUP_BASENAME" | sed -E 's/.*\.([0-9]{8})_.*/\1/')
        elif echo "$BACKUP_BASENAME" | grep -qE '\.([0-9]{4}-[0-9]{2}-[0-9]{2})_'; then
            BACKUP_DATE=$(echo "$BACKUP_BASENAME" | sed -E 's/.*\.([0-9]{4}-[0-9]{2}-[0-9]{2})_.*/\1/' | tr -d '-')
        else
            BACKUP_DATE=""
        fi
        
        TODAY=$(date '+%Y%m%d')
        YESTERDAY=$(date -d "yesterday" '+%Y%m%d')
        
        if [ -n "$BACKUP_DATE" ] && [ "$BACKUP_DATE" != "$TODAY" ] && [ "$BACKUP_DATE" != "$YESTERDAY" ]; then
            echo "⚠️  LATEST BACKUP IS NOT FROM TODAY/YESTERDAY" >> "$ISSUES_FILE"
            echo "   Latest: $BACKUP_DATE, Expected: $TODAY or $YESTERDAY" >> "$ISSUES_FILE"
            HAS_ISSUES=1
        fi
    fi
fi
echo "" >> "$ISSUES_FILE"

# 4b. Check Cron Jobs Status (Nightly Backup Job Health)
echo "🔍 Checking cron job health..." >&2
CRON_JOBS_FILE="$HOME/.hermes/cron/jobs.json"
if [ -f "$CRON_JOBS_FILE" ]; then
    # Check for failed nightly backup job (model drift issue)
    NIGHTLY_JOB_STATUS=$(grep -A 15 '"name": "Hermes Nightly Backup"' "$CRON_JOBS_FILE" 2>/dev/null | grep -E '"last_status"|"last_error"')
    if echo "$NIGHTLY_JOB_STATUS" | grep -q '"last_status": "error"'; then
        echo "⚠️  NIGHTLY BACKUP JOB IS FAILING" >> "$ISSUES_FILE"
        echo "   Last error: $(echo "$NIGHTLY_JOB_STATUS" | grep '"last_error"' | sed 's/.*"last_error": "//; s/".*//' | head -c 200)" >> "$ISSUES_FILE"
        echo "   Fix: Pin the model with: hermes cronjob action=update job_id=f93a5953e431 provider=openrouter model=nvidia/nemotron-3-ultra-550b-a55b:free" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
    
    # Check for daily check job itself
    DAILY_JOB_STATUS=$(grep -A 15 '"name": "Hermes Daily Health Check"' "$CRON_JOBS_FILE" 2>/dev/null | grep -E '"last_status"|"last_error"')
    if echo "$DAILY_JOB_STATUS" | grep -q '"last_status": "error"'; then
        echo "⚠️  DAILY HEALTH CHECK JOB IS FAILING" >> "$ISSUES_FILE"
        echo "   Last error: $(echo "$DAILY_JOB_STATUS" | grep '"last_error"' | sed 's/.*"last_error": "//; s/".*//' | head -c 200)" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
else
    echo "   ℹ️  Cron jobs file not found: $CRON_JOBS_FILE" >> "$ISSUES_FILE"
fi
echo "" >> "$ISSUES_FILE"

# Check for system-level cron safety net
echo "🔍 Checking for system-level cron safety net..." >&2
SYSTEM_CRON_FOUND=0
USER_CRON_FOUND=0

# Check user crontab
if crontab -l 2>/dev/null | grep -q "hermes.*daily.*check\|daily.*health.*check"; then
    USER_CRON_FOUND=1
fi

# Check system crontabs
if [ -f /etc/crontab ] && grep -q "hermes.*daily.*check\|daily.*health.*check" /etc/crontab 2>/dev/null; then
    SYSTEM_CRON_FOUND=1
fi
if ls /etc/cron.d/ 2>/dev/null | grep -q hermes; then
    if grep -r "hermes.*daily.*check\|daily.*health.*check" /etc/cron.d/ 2>/dev/null; then
        SYSTEM_CRON_FOUND=1
    fi
fi

if [ $USER_CRON_FOUND -eq 1 ] && [ $SYSTEM_CRON_FOUND -eq 1 ]; then
    echo "   ✅ System-level AND user-level cron safety nets found" >> "$ISSUES_FILE"
elif [ $SYSTEM_CRON_FOUND -eq 1 ]; then
    echo "   ✅ System-level cron safety net found" >> "$ISSUES_FILE"
elif [ $USER_CRON_FOUND -eq 1 ]; then
    echo "   ⚠️  ONLY USER-LEVEL CRON FOUND (no system safety net)" >> "$ISSUES_FILE"
    echo "   The daily health check runs inside Hermes only. If Hermes is down, no alert fires." >> "$ISSUES_FILE"
    echo "   Recommendation: Add system cron as safety net:" >> "$ISSUES_FILE"
    echo "     echo \"0 9 * * * hermes /usr/local/bin/hermes run skill:hermes-daily-check\" | sudo tee /etc/cron.d/hermes-daily" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "⚠️  NO SYSTEM-LEVEL CRON SAFETY NET FOR DAILY CHECK" >> "$ISSUES_FILE"
    echo "   The daily health check runs inside Hermes only. If Hermes is down, no alert fires." >> "$ISSUES_FILE"
    echo "   Recommendation: Add system cron as safety net:" >> "$ISSUES_FILE"
    echo "     echo \"0 9 * * * hermes /usr/local/bin/hermes run skill:hermes-daily-check\" | sudo tee /etc/cron.d/hermes-daily" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi
echo "" >> "$ISSUES_FILE"

# 5. Check Error Logs
echo "🔍 Checking error logs..." >&2
LOG_FILE="$HOME/.hermes/logs/gateway.log"
if [ ! -f "$LOG_FILE" ]; then
    echo "⚠️  GATEWAY LOG FILE NOT FOUND" >> "$ISSUES_FILE"
    echo "   Expected: $LOG_FILE" >> "$ISSUES_FILE"
else
    ERRORS=$(grep -i "error\|fatal" "$LOG_FILE" 2>/dev/null | tail -10)
    if [ -n "$ERRORS" ]; then
        echo "⚠️  ERRORS/FATALS FOUND IN GATEWAY LOG" >> "$ISSUES_FILE"
        echo "   Last 10 matches:" >> "$ISSUES_FILE"
        echo "$ERRORS" | sed 's/^/   /' >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "✅ No errors/fatals found in gateway log" >> "$ISSUES_FILE"
    fi
fi
echo "" >> "$ISSUES_FILE"

# 6. Check System Resources (NEW)
echo "🔍 Checking system resources..." >&2

# CPU Usage
if command -v mpstat >/dev/null 2>&1; then
    CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {print 100 - $NF}' | cut -d. -f1)
else
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}' | cut -d. -f1)
fi
if [ -z "$CPU_USAGE" ]; then CPU_USAGE=0; fi
if [ "$CPU_USAGE" -gt 85 ]; then
    echo "⚠️  HIGH CPU USAGE DETECTED" >> "$ISSUES_FILE"
    echo "   Usage: $CPU_USAGE% (threshold: 85%)" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "✅ CPU usage: $CPU_USAGE% (OK)" >> "$ISSUES_FILE"
fi

# Memory Usage
MEM_INFO=$(free -m)
MEM_USAGE_PERCENT=$(echo "$MEM_INFO" | awk 'NR==2{printf "%.0f", $3*100/$2 }')
MEM_USED_MB=$(echo "$MEM_INFO" | awk 'NR==2{print $3}')
MEM_TOTAL_MB=$(echo "$MEM_INFO" | awk 'NR==2{print $2}')
if [ "$MEM_USAGE_PERCENT" -gt 85 ]; then
    echo "⚠️  HIGH MEMORY USAGE DETECTED" >> "$ISSUES_FILE"
    echo "   Usage: $MEM_USAGE_PERCENT% ($MEM_USED_MB MB / $MEM_TOTAL_MB MB) (threshold: 85%)" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "✅ Memory usage: $MEM_USAGE_PERCENT% ($MEM_USED_MB MB / $MEM_TOTAL_MB MB) (OK)" >> "$ISSUES_FILE"
fi

# Swap Usage
SWAP_INFO=$(free -m)
SWAP_USED_MB=$(echo "$SWAP_INFO" | awk 'NR==3{print $3}')
SWAP_TOTAL_MB=$(echo "$SWAP_INFO" | awk 'NR==3{print $2}')
if [ "$SWAP_TOTAL_MB" -gt 0 ]; then
    if [ "$SWAP_USED_MB" -gt 500 ]; then
        echo "⚠️  HIGH SWAP USAGE DETECTED" >> "$ISSUES_FILE"
        echo "   Usage: $SWAP_USED_MB MB (threshold: 500MB)" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "✅ Swap usage: $SWAP_USED_MB MB (OK)" >> "$ISSUES_FILE"
    fi
else
    echo "ℹ️  No swap configured" >> "$ISSUES_FILE"
fi

# Load Average
CPU_CORES=$(nproc)
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)
if [ -z "$LOAD_AVG" ]; then LOAD_AVG=0; fi
LOAD_THRESHOLD=$CPU_CORES
if (( $(echo "$LOAD_AVG > $LOAD_THRESHOLD" | bc -l) )); then
    echo "⚠️  HIGH LOAD AVERAGE DETECTED" >> "$ISSUES_FILE"
    echo "   Load: $LOAD_AVG (threshold: $LOAD_THRESHOLD for $CPU_CORES core(s))" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "✅ Load average: $LOAD_AVG (OK)" >> "$ISSUES_FILE"
fi
echo "" >> "$ISSUES_FILE"

# 7. Check Extended Logs (Authentication, Application, Cron)
echo "🔍 Checking extended logs..." >&2

# 7a. Authentication Logs (Failed SSH attempts)
echo "   Checking authentication logs..." >&2
if [ -r "/var/log/auth.log" ]; then
    FAILED_SSH=$(grep -i "failed.*password\|invalid user\|authentication failure" /var/log/auth.log 2>/dev/null | tail -5)
    if [ -n "$FAILED_SSH" ]; then
        echo "⚠️  FAILED SSH ATTEMPTS DETECTED" >> "$ISSUES_FILE"
        echo "   Recent attempts:" >> "$ISSUES_FILE"
        echo "$FAILED_SSH" | sed 's/^/      /' >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "   ✅ No failed SSH attempts found" >> "$ISSUES_FILE"
    fi
else
    echo "   ℹ️  Cannot read /var/log/auth.log (insufficient permissions)" >> "$ISSUES_FILE"
fi

# 7b. Telegram Network Instability Check (NEW)
echo "   Checking Telegram connectivity stability..." >&2
LOG_FILE="$HOME/.hermes/logs/gateway.log"
if [ -f "$LOG_FILE" ]; then
    TELEGRAM_RECONNECTS=$(grep -i "telegram.*network error.*reconnecting\|telegram.*polling resumed after network error" "$LOG_FILE" 2>/dev/null | tail -10)
    TELEGRAM_RECONNECT_COUNT=$(grep -c "telegram.*network error.*reconnecting" "$LOG_FILE" 2>/dev/null || echo 0)
    if [ -n "$TELEGRAM_RECONNECTS" ]; then
        echo "⚠️  TELEGRAM NETWORK INSTABILITY DETECTED" >> "$ISSUES_FILE"
        echo "   Reconnect events in log: $TELEGRAM_RECONNECT_COUNT" >> "$ISSUES_FILE"
        echo "   Recent events:" >> "$ISSUES_FILE"
        echo "$TELEGRAM_RECONNECTS" | sed 's/^/      /' >> "$ISSUES_FILE"
        if [ "$TELEGRAM_RECONNECT_COUNT" -gt 5 ]; then
            echo "   ⚠️  High frequency - consider webhook mode migration" >> "$ISSUES_FILE"
        fi
        HAS_ISSUES=1
    else
        echo "   ✅ No Telegram reconnect events found" >> "$ISSUES_FILE"
    fi
else
    echo "   ℹ️  Gateway log not found" >> "$ISSUES_FILE"
fi

# 7c. Application Logs (Other Hermes logs)
echo "   Checking application logs..." >&2
HERMES_LOGS_DIR="$HOME/.hermes/logs"
if [ -d "$HERMES_LOGS_DIR" ]; then
    OTHER_LOGS=$(find "$HERMES_LOGS_DIR" -name "*.log" ! -name "gateway.log" -type f 2>/dev/null)
    if [ -n "$OTHER_LOGS" ]; then
        APP_ERRORS=""
        for logfile in $OTHER_LOGS; do
            if [ -r "$logfile" ]; then
                errors=$(grep -i "error\|fatal\|exception\|traceback" "$logfile" 2>/dev/null | tail -3)
                if [ -n "$errors" ]; then
                    APP_ERRORS="$APP_ERRORS\nIn $logfile:\n$errors"
                fi
            fi
        done
        if [ -n "$APP_ERRORS" ]; then
            echo "⚠️  ERRORS FOUND IN APPLICATION LOGS" >> "$ISSUES_FILE"
            echo -e "$APP_ERRORS" | sed 's/^/   /' >> "$ISSUES_FILE"
            HAS_ISSUES=1
        else
            echo "   ✅ No errors found in other Hermes logs" >> "$ISSUES_FILE"
        fi
    else
        echo "   ℹ️  No other Hermes log files found" >> "$ISSUES_FILE"
    fi
else
    echo "   ⚠️  HERMES LOGS DIRECTORY NOT FOUND" >> "$ISSUES_FILE"
    echo "      Expected: $HERMES_LOGS_DIR" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

# 7d. Cron Job Status Check (NEW)
echo "   Checking cron job health..." >&2
JOBS_FILE="$HOME/.hermes/cron/jobs.json"
if [ -f "$JOBS_FILE" ]; then
    # Check nightly backup job status
    BACKUP_JOB_ERROR=$(grep -A 20 '"name": "Hermes Nightly Backup"' "$JOBS_FILE" 2>/dev/null | grep -A 5 '"last_error"' | head -6)
    if echo "$BACKUP_JOB_ERROR" | grep -q "model.*drifted\|config drifted"; then
        echo "⚠️  NIGHTLY BACKUP JOB MODEL DRIFT DETECTED" >> "$ISSUES_FILE"
        echo "   Error: $(echo "$BACKUP_JOB_ERROR" | grep '"last_error"' | sed 's/.*"last_error": *"//; s/".*//')" >> "$ISSUES_FILE"
        echo "   Fix: hermes cronjob action=update job_id=f93a5953e431 provider=openrouter model=nvidia/nemotron-3-ultra-550b-a55b:free" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    elif echo "$BACKUP_JOB_ERROR" | grep -q '"last_status": "error"'; then
        echo "⚠️  NIGHTLY BACKUP JOB FAILING" >> "$ISSUES_FILE"
        echo "   Last error: $(echo "$BACKUP_JOB_ERROR" | grep '"last_error"' | sed 's/.*"last_error": *"//; s/".*//')" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "   ✅ Nightly backup job status OK" >> "$ISSUES_FILE"
    fi
else
    echo "   ℹ️  Jobs file not found" >> "$ISSUES_FILE"
fi

# 7e. Use cron logs (Scheduled jobs execution)
echo "   Checking cron logs..." >&2
CRON_OUTPUT_DIR="$HOME/.hermes/cron/output"
if [ -d "$CRON_OUTPUT_DIR" ]; then
    RECENT_CRON_OUTPUT=$(find "$CRON_OUTPUT_DIR" -type f -mtime -1 2>/dev/null | head -5)
    if [ -z "$RECENT_CRON_OUTPUT" ]; then
        echo "⚠️  NO RECENT CRON JOB OUTPUT FOUND (LAST 24H)" >> "$ISSUES_FILE"
        echo "   Checked: $CRON_OUTPUT_DIR" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "   ✅ Found recent cron job output" >> "$ISSUES_FILE"
    fi
    
    if [ -r "/var/log/cron" ] || [ -r "/var/log/cron.log" ]; then
        CRON_LOG="/var/log/cron"
        [ ! -r "$CRON_LOG" ] && CRON_LOG="/var/log/cron.log"
        CRON_ERRORS=$(grep -i "error\|fail\|cannot.*execute" "$CRON_LOG" 2>/dev/null | tail -5)
        if [ -n "$CRON_ERRORS" ]; then
            echo "⚠️  ERRORS FOUND IN SYSTEM CRON LOG" >> "$ISSUES_FILE"
            echo "   Recent errors:" >> "$ISSUES_FILE"
            echo "$CRON_ERRORS" | sed 's/^/      /' >> "$ISSUES_FILE"
            HAS_ISSUES=1
        else
            echo "   ✅ No errors found in system cron log" >> "$ISSUES_FILE"
        fi
    else
        echo "   ℹ️  Cannot read system cron log (insufficient permissions)" >> "$ISSUES_FILE"
    fi
else
    echo "   ⚠️  CRON OUTPUT DIRECTORY NOT FOUND" >> "$ISSUES_FILE"
    echo "      Expected: $CRON_OUTPUT_DIR" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

echo "" >> "$ISSUES_FILE"

# 8. Check Tool Availability and Integrity (NEW)
echo "🔍 Checking tool availability and integrity..." >&2

declare -A TOOL_CHECKS
TOOL_CHECKS["nmap"]="nmap --version"
TOOL_CHECKS["nuclei"]="nuclei -version"
TOOL_CHECKS["sqlmap"]="sqlmap --version"
TOOL_CHECKS["metasploit"]="msfconsole --version"
TOOL_CHECKS["bloodhound"]="bloodhound.py --help 2>&1 | head -1"
TOOL_CHECKS["impacket"]="python3 -c \"import impacket; print('impacket ok')\" 2>&1"
TOOL_CHECKS["feroxbuster"]="feroxbuster --version"
TOOL_CHECKS["dalfox"]="dalfox version"
TOOL_CHECKS["naabu"]="naabu -version"
TOOL_CHECKS["nxc"]="nxc --version"
TOOL_CHECKS["netexec"]="netexec --version"
TOOL_CHECKS["rustscan"]="rustscan --version"

for tool_name in "${!TOOL_CHECKS[@]}"; do
    cmd="${TOOL_CHECKS[$tool_name]}"
    echo "     Checking $tool_name..." >&2
    TOOL_AVAILABLE=0
    if command -v "$tool_name" >/dev/null 2>&1; then
        TOOL_AVAILABLE=1
    elif [ "$tool_name" = "metasploit" ] && [ -x "$HOME/tools/metasploit-framework/msfconsole" ]; then
        TOOL_AVAILABLE=1
    elif [ "$tool_name" = "bloodhound" ] && [ -x "$HOME/tools/ad/bloodhound/bloodhound-py/bloodhound.py" ]; then
        TOOL_AVAILABLE=1
    elif [ "$tool_name" = "impacket" ]; then
        TOOL_AVAILABLE=1
    fi
    
    if [ $TOOL_AVAILABLE -eq 1 ]; then
        if [ "$tool_name" = "metasploit" ]; then
            if [ -x "$HOME/tools/metasploit-framework/msfconsole" ]; then
                TOOL_OUTPUT="$("$HOME/tools/metasploit-framework/msfconsole" --version 2>&1 | head -1)"
                TOOL_EXIT=$?
            else
                TOOL_OUTPUT="msfconsole not found or not executable in \$HOME/tools/metasploit-framework"
                TOOL_EXIT=1
            fi
        elif [ "$tool_name" = "bloodhound" ]; then
            if [ -x "$HOME/tools/ad/bloodhound/bloodhound-py/bloodhound.py" ]; then
                TOOL_OUTPUT="$("$HOME/tools/ad/bloodhound/bloodhound-py/bloodhound.py" --help 2>&1 | head -1)"
                TOOL_EXIT=$?
            else
                TOOL_OUTPUT="BloodHound.py not found or not executable"
                TOOL_EXIT=1
            fi
        elif [ "$tool_name" = "impacket" ]; then
            # Dynamic Python version detection
            PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>/dev/null)
            TEMP_OUTPUT=$(PYTHONPATH="$HOME/.local/lib/python${PY_VER}/site-packages:$PYTHONPATH" python3 -c "import impacket; print('impacket ok')" 2>&1)
            TOOL_OUTPUT=$TEMP_OUTPUT
            if echo "$TEMP_OUTPUT" | grep -q "ModuleNotFoundError"; then
                TOOL_EXIT=1
            else
                TOOL_EXIT=0
            fi
        else
            TOOL_OUTPUT=$($cmd 2>&1)
            TOOL_EXIT=$?
        fi
        
        if [ $TOOL_EXIT -eq 0 ]; then
            echo "       ✅ $tool_name: $TOOL_OUTPUT" >> "$ISSUES_FILE"
        else
            echo "⚠️  $tool_name CHECK FAILED OR NOT AVAILABLE" >> "$ISSUES_FILE"
            echo "      Output: $TOOL_OUTPUT" >> "$ISSUES_FILE"
            HAS_ISSUES=1
        fi
    else
        echo "⚠️  $tool_name NOT FOUND IN PATH" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
done

# Check Virtual Environments for specific tools
echo "   Checking virtual environments..." >&2
VENV_CHECKS=(
    "$HOME/tools/metasploit-framework"
    "$HOME/tools/ad/bloodhound/bloodhound-py"
    "$HOME/tools/postex/impacket"
    "$HOME/tools/cloud/pacu"
    "$HOME/tools/cloud/ScoutSuite"
    "$HOME/tools/cloud/prowler"
)
for venv_dir in "${VENV_CHECKS[@]}"; do
    if [ -d "$venv_dir" ]; then
        if [ -d "$venv_dir/.venv" ] || [ -d "$venv_dir/venv" ] || [ -f "$venv_dir/requirements.txt" ] || [ -d "$venv_dir/bin" ]; then
            echo "      ✅ $venv_dir: Environment appears configured" >> "$ISSUES_FILE"
        else
            echo "      ℹ️  $venv_dir: Directory exists but no obvious venv structure" >> "$ISSUES_FILE"
        fi
    else
        echo "      ℹ️  $venv_dir: Directory not found" >> "$ISSUES_FILE"
    fi
done

# Check Temp Space
echo "   Checking temporary space..." >&2
TMP_SPACE=$(df -h /tmp 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')
if [ -z "$TMP_SPACE" ]; then
    TMP_SPACE=$(df /tmp 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')
fi
if [ -n "$TMP_SPACE" ] && [ "$TMP_SPACE" -gt 90 ]; then
    echo "⚠️  LOW TEMP SPACE DETECTED" >> "$ISSUES_FILE"
    echo "   Usage: $TMP_SPACE% (threshold: 90%)" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "   ✅ Temp space: ${TMP_SPACE:-N/A}% (OK)" >> "$ISSUES_FILE"
fi

VAR_TMP_SPACE=$(df -h /var/tmp 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')
if [ -z "$VAR_TMP_SPACE" ]; then
    VAR_TMP_SPACE=$(df /var/tmp 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')
fi
if [ -n "$VAR_TMP_SPACE" ] && [ "$VAR_TMP_SPACE" -gt 90 ]; then
    echo "⚠️  LOW VAR/TMP SPACE DETECTED" >> "$ISSUES_FILE"
    echo "   Usage: $VAR_TMP_SPACE% (threshold: 90%)" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "   ✅ Var/tmp space: ${VAR_TMP_SPACE:-N/A}% (OK)" >> "$ISSUES_FILE"
fi

echo "" >> "$ISSUES_FILE"

# 9. Check Network Connectivity (NEW)
echo "🔍 Checking network connectivity..." >&2

# 9a. Basic Connectivity
echo "   Checking basic connectivity..." >&2
CONNECTIVITY_OK=0
if ping -c 3 1.1.1.1 >/dev/null 2>&1; then
    echo "      ✅ Ping to 1.1.1.1 successful" >> "$ISSUES_FILE"
    CONNECTIVITY_OK=1
else
    echo "      ⚠️  Ping to 1.1.1.1 failed" >> "$ISSUES_FILE"
fi

if [ $CONNECTIVITY_OK -eq 0 ]; then
    if curl -s --max-time 5 https://api.ipify.org >/dev/null 2>&1; then
        echo "      ✅ Curl to https://api.ipify.org successful" >> "$ISSUES_FILE"
        CONNECTIVITY_OK=1
    else
        echo "      ⚠️  Curl to https://api.ipify.org failed" >> "$ISSUES_FILE"
    fi
fi

if [ $CONNECTIVITY_OK -eq 1 ]; then
    echo "   ✅ Basic connectivity: OK" >> "$ISSUES_FILE"
else
    echo "⚠️  BASIC CONNECTIVITY FAILED" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

# 9b. DNS Resolution
echo "   Checking DNS resolution..." >&2
DNS_OK=0
if [ -r "/etc/resolv.conf" ]; then
    RESOLV_CONF_CONTENT=$(cat /etc/resolv.conf)
    if echo "$RESOLV_CONF_CONTENT" | grep -q "nameserver"; then
        echo "      ✅ /etc/resolv.conf contains nameserver entries" >> "$ISSUES_FILE"
        DNS_OK=1
    else
        echo "      ⚠️  /etc/resolv.conf missing nameserver entries" >> "$ISSUES_FILE"
    fi
else
    echo "      ⚠️  Cannot read /etc/resolv.conf" >> "$ISSUES_FILE"
fi

if [ $DNS_OK -eq 1 ]; then
    if dig google.com +short >/dev/null 2>&1; then
        echo "      ✅ DNS resolution for google.com works" >> "$ISSUES_FILE"
    else
        echo "      ⚠️  DNS resolution for google.com failed" >> "$ISSUES_FILE"
        DNS_OK=0
    fi
fi

if [ $DNS_OK -eq 1 ]; then
    echo "   ✅ DNS resolution: OK" >> "$ISSUES_FILE"
else
    echo "⚠️  DNS RESOLUTION FAILED" >> "$ISSUES_FILE"
    HAS_ISSUES=1
fi

# 9c. Unexpected Listening Ports
echo "   Checking for unexpected listening ports..." >&2
if command -v netstat >/dev/null 2>&1; then
    # Expected ports: 22 (SSH), 53 (systemd-resolved DNS), 80/443 (HTTP/HTTPS), 3306 (MySQL), 5432 (PostgreSQL), 6379 (Redis),
    # 8080/8443 (alt HTTP/HTTPS), 9090/9091 (Prometheus/alertmanager), 9100 (node_exporter),
    # 9119 (Hermes Dashboard), 3389 (RDP/xrdp), 631 (CUPS printing)
    EXPECTED_PORTS="22|53|80|443|3306|5432|6379|8080|8443|9090|9091|9100|9119|3389|631"
    
    LISTEN_PORTS=$(netstat -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $NF}' | sort -n | uniq)
    
    UNEXPECTED_PORTS=""
    for port in $LISTEN_PORTS; do
        if ! echo "$port" | grep -qE "^(${EXPECTED_PORTS})$"; then
            if [ "$port" -gt 49152 ]; then
                UNEXPECTED_PORTS="$UNEXPECTED_PORTS $port(ephemeral?)"
            else
                UNEXPECTED_PORTS="$UNEXPECTED_PORTS $port"
            fi
        fi
    done
    
    if [ -n "$UNEXPECTED_PORTS" ]; then
        echo "⚠️  UNEXPECTED LISTENING PORTS DETECTED: $UNEXPECTED_PORTS" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "      ✅ No unexpected listening ports found (9119 Hermes Dashboard is expected)" >> "$ISSUES_FILE"
    fi
else
    echo "   ℹ️  netstat not available, skipping port check" >> "$ISSUES_FILE"
fi

echo "" >> "$ISSUES_FILE"

# Output result
if [ $HAS_ISSUES -eq 0 ]; then
    echo "[SILENT]"
else
    echo "🚨 *Hermes Agent Daily Check Alert* 🚨"
    echo "   Time: $TIMESTAMP"
    echo ""
    cat "$ISSUES_FILE"
fi

# Cleanup
rm -f "$ISSUES_FILE"