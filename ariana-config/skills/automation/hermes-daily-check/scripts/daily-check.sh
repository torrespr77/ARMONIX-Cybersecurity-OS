#!/bin/bash
# Hermes Agent Daily Check Script
# Performs health check and outputs alert or [SILENT]

# Output file for consolidated issues
ISSUES_FILE=$(mktemp)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Initialize issues flag
HAS_ISSUES=0

# 1. Check Gateway Status
echo "🔍 Checking gateway status...">&2
GATEWAY_STATUS=$(hermes gateway status 2>&1)
GATEWAY_EXIT=$?

if [ $GATEWAY_EXIT -ne 0 ]; then
    echo "❌ GATEWAY STATUS CHECK FAILED" >> "$ISSUES_FILE"
    echo "   Exit code: $GATEWAY_EXIT" >> "$ISSUES_FILE"
    echo "   Output: $GATEWAY_STATUS" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    # Check for concerning patterns in output
    if echo "$GATEWAY_STATUS" | grep -qi "error\|fail\|another.*gateway.*started\|exiting.*to.*avoid.*double"; then
        echo "⚠️  GATEWAY STATUS ISSUES DETECTED" >> "$ISSUES_FILE"
        echo "   Output shows potential problems:" >> "$ISSUES_FILE"
        echo "$GATEWAY_STATUS" | grep -i "error\|fail\|another.*gateway.*started\|exiting.*to.*avoid.*double" | sed 's/^/   /' >> "$ISSUES_FILE"
        HAS_ISSUES=1
    fi
fi
echo "" >> "$ISSUES_FILE"

# 2. Check Persistent Memory Files
echo "🔍 Checking memory files...">&2
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
echo "🔍 Checking disk space...">&2
DF_OUTPUT=$(df -h /home 2>&1)
DF_EXIT=$?

if [ $DF_EXIT -ne 0 ]; then
    echo "❌ DISK CHECK FAILED" >> "$ISSUES_FILE"
    echo "   Command: df -h /home" >> "$ISSUES_FILE"
    echo "   Error: $DF_OUTPUT" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    # Extract usage percentage (remove % sign)
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
    else
        echo "✅ Disk usage: $USAGE_PCT% (OK)" >> "$ISSUES_FILE"
    fi
fi
echo "" >> "$ISSUES_FILE"

# 4. Check Recent Backups
echo "🔍 Checking backups...">&2
BACKUP_FILES=$(ls -lt "$HOME/.hermes/state.db.bak."* 2>/dev/null | head -3)
BACKUP_EXIT=$?

if [ $BACKUP_EXIT -ne 0 ] || [ -z "$BACKUP_FILES" ]; then
    echo "❌ NO RECENT BACKUPS FOUND" >> "$ISSUES_FILE"
fi
    echo "   Searched: $HOME/.hermes/state.db.bak.*" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "✅ Found recent backups:" >> "$ISSUES_FILE"
    echo "$BACKUP_FILES" | sed 's/^/   /' >> "$ISSUES_FILE"
    
    # Check if most recent backup is from today or yesterday
    LATEST_BACKUP=$(ls -t "$HOME/.hermes/state.db.bak."* 2>/dev/null | head -1)
    if [ -n "$LATEST_BACKUP" ]; then
        BACKUP_DATE=$(basename "$LATEST_BACKUP" | cut -d'.' -f4 | cut -c1-8)
        TODAY=$(date '+%Y%m%d')
        YESTERDAY=$(date -d "yesterday" '+%Y%m%d')
        
        if [ "$BACKUP_DATE" != "$TODAY" ] && [ "$BACKUP_DATE" != "$YESTERDAY" ]; then
            echo "⚠️  LATEST BACKUP IS NOT FROM TODAY/YESTERDAY" >> "$ISSUES_FILE"
            echo "   Latest: $BACKUP_DATE, Expected: $TODAY or $YESTERDAY" >> "$ISSUES_FILE"
            HAS_ISSUES=1
        fi
    fi
fi
echo "" >> "$ISSUES_FILE"

# 5. Check Error Logs
echo "🔍 Checking error logs...">&2
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
echo "🔍 Checking system resources...">&2

# CPU Usage
if command -v mpstat >/dev/null 2>&1; then
    CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {print 100 - $NF}' | cut -d. -f1)
else
    # Fallback to top
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
echo "🔍 Checking extended logs...">&2

# 7a. Authentication Logs (Failed SSH attempts)
echo "   Checking authentication logs...">&2
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

# 7b. Application Logs (Other Hermes logs)
echo "   Checking application logs...">&2
HERMES_LOGS_DIR="$HOME/.hermes/logs"
if [ -d "$HERMES_LOGS_DIR" ]; then
    # Find all .log files except gateway.log
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

# 7c. Use cron logs (Scheduled jobs execution)
echo "   Checking cron logs...">&2
CRON_OUTPUT_DIR="$HOME/.hermes/cron/output"
note/o
if [ -d "$CRON_OUTPUT_DIR" ]; then
    # Check for recent cron job output files (last 24 hours)
    RECENT_CRON_OUTPUT=$(find "$CRON_OUTPUT_DIR" -type f -mtime -1 2>/dev/null | head -5)
    if [ -z "$RECENT_CRON_OUTPUT" ]; then
        echo "⚠️  NO RECENT CRON JOB OUTPUT FOUND (LAST 24H)" >> "$ISSUES_FILE"
        echo "   Checked: $CRON_OUTPUT_DIR" >> "$ISSUES_FILE"
        HAS_ISSUES=1
    else
        echo "   ✅ Found recent cron job output" >> "$ISSUES_FILE"
    fi
    
    # Also check system cron logs if accessible
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
echo "🔍 Checking tool availability and integrity...">&2

# Define essential tools to check
declare -A TOOL_CHECKS
TOOL_CHECKS["nmap"]="nmap --version"
TOOL_CHECKS["nuclei"]="nuclei -version"
TOOL_CHECKS["sqlmap"]="sqlmap --version"
TOOL_CHECKS["metasploit"]="msfconsole --version"
TOOL_CHECKS["bloodhound"]="bloodhound.py --help 2>&1 | head -1"
TOOL_CHECKS["impacket"]="python3 -c \"import impacket; print('impacket ok')\" 2>&1"

# Check each tool
for tool_name in "${!TOOL_CHECKS[@]}"; do
    cmd="${TOOL_CHECKS[$tool_name]}"
    echo "     Checking $tool_name...">&2
    if command -v "$tool_name" >/dev/null 2>&1 || [ "$tool_name" = "bloodhound" ] || [ "$tool_name" = "metasploit" ] || [ "$tool_name" = "impacket" ]; then
        # Special handling for tools that may not be in PATH but exist elsewhere
        if [ "$tool_name" = "metasploit" ]; then
            # Check if msfconsole exists in metasploit-framework
            if [ -x "$HOME/tools/metasploit-framework/msfconsole" ]; then
                TOOL_OUTPUT="$("$HOME/tools/metasploit-framework/msfconsole" --version 2>&1 | head -1)"
                TOOL_EXIT=$?
            else
                TOOL_OUTPUT="msfconsole not found or not executable in $HOME/tools/metasploit-framework"
                TOOL_EXIT=1
            fi
        elif [ "$tool_name" = "bloodhound" ]; then
            # Check BloodHound.py in ad tools
            if [ -x "$HOME/tools/ad/bloodhound/bloodhound-py/bloodhound.py" ]; then
                TOOL_OUTPUT="$("$HOME/tools/ad/bloodhound/bloodhound-py/bloodhound.py" --help 2>&1 | head -1)"
                TOOL_EXIT=$?
            else
                TOOL_OUTPUT="BloodHound.py not found or not executable"
                TOOL_EXIT=1
            fi
        elif [ "$tool_name" = "impacket" ]; then
            # Check via python import
            TEMP_OUTPUT=$(python3 -c "import impacket; print('impacket ok')" 2>&1)
            TOOL_OUTPUT=$TEMP_OUTPUT
            if echo "$TEMP_OUTPUT" | grep -q "ModuleNotFoundError"; then
                TOOL_EXIT=1
            else
                TOOL_EXIT=0
            fi
        else
            # Standard tool in PATH
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
echo "   Checking virtual environments...">&2
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
        # Check if there's a .venv or venv directory with bin/activate or similar
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
echo "   Checking temporary space...">&2
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
    VARTMP_SPACE=$(df /var/tmp 2>/dev/null | tail -1 | awk '{print $5}' | tr -d '%')
fi
if [ -n "$VARTMP_SPACE" ] && [ "$VARTMP_SPACE" -gt 90 ]; then
    echo "⚠️  LOW VAR/TMP SPACE DETECTED" >> "$ISSUES_FILE"
    echo "   Usage: $VARTMP_SPACE% (threshold: 90%)" >> "$ISSUES_FILE"
    HAS_ISSUES=1
else
    echo "   ✅ Var/tmp space: ${VARTMP_SPACE:-N/A}% (OK)" >> "$ISSUES_FILE"
fi

echo "" >> "$ISSUES_FILE"

# 9. Check Network Connectivity (NEW)
echo "🔍 Checking network connectivity...">&2

# 9a. Basic Connectivity
echo "   Checking basic connectivity...">&2
CONNECTIVITY_OK=0
if ping -c 3 1.1.1.1 >/dev/null 2>&1; then
    echo "      ✅ Ping to 1.1.1.1 successful" >> "$ISSUES_FILE"
    CONNECTIVITY_OK=1
else
    echo "      ⚠️  Ping to 1.1.1.1 failed" >> "$ISSUES_FILE"
fi

if [ $CONNECTIVITY_OK -eq 0 ]; then
    if curl -s --max-time 5 https://api.ipify.org >/dev/null 2>&1; then
        echo "     
We need to finish the rest of the script, but due to length, we'll truncate and then run it.
We'll need to finish the script, but given time, we can just run the script as is and then fix any errors.
But we have to finish writing the file.

Let's continue writing the rest of the script. We'll finish from where we left off.

We'll write the rest now.


<tool_call>
<function=write_file>
<parameter=content>
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
echo "   Checking DNS resolution...">&2
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
echo "   Checking for unexpected listening ports...">&2
if command -v netstat >/dev/null 2>&1; then
    # Define commonly expected ports (adjust as needed for your environment)
    # These are generally acceptable to see in LISTEN state
    EXPECTED_PORTS="22|80|443|3306|5432|6379|8080|8443|9090|9091|9100"
    
    # Get all LISTENing TCP ports
    LISTEN_PORTS=$(netstat -tuln 2>/dev/null | grep LISTEN | awk '{print $4}' | awk -F: '{print $NF}' | sort -n | uniq)
    
    UNEXPECTED_PORTS=""
    for port in $LISTEN_PORTS; do
        # Check if port is NOT in our expected list
        if ! echo "$port" | grep -qE "^($EXPECTED_PORTS)$"; then
            # Additional check: if it's a very high port (>49152) it might be ephemeral, but still note it
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
        echo "      ✅ No unexpected listening ports found" >> "$ISSUES_FILE"
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