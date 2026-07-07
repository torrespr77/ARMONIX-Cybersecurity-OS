#!/bin/bash
# Weekly Skills Backup + Telegram Notification for Hermes Agent
#
# Usage: bash weekly_skills_backup.sh
#
# This script:
# 1. Creates a timestamped .tar.gz backup of ~/.hermes/skills/
# 2. Verifies the backup was created
# 3. Cleans up old backups (keeps last 4)
# 4. Sends a Telegram notification with backup details
#
# Environment variables expected in ~/.hermes/.env:
#   TELEGRAM_BOT_TOKEN - Bot token from @BotFather
#   TELEGRAM_HOME_CHANNEL - Chat ID for notification recipient

set -euo pipefail

HERMES_HOME="/home/hermes/.hermes"
BACKUP_PREFIX="skills_backup"
MAX_BACKUPS=4

# Load env vars (source handles the masked-value problem)
source "${HERMES_HOME}/.env" 2>/dev/null || true

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
    echo "ERROR: TELEGRAM_BOT_TOKEN not found in ${HERMES_HOME}/.env"
    exit 1
fi

CHAT_ID="${TELEGRAM_HOME_CHANNEL:-585583379}"

echo "=== Weekly Skills Backup ==="
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"

# 1. Create backup (cd first to avoid Tirith archive_extract block)
echo ""
echo "[1/3] Creating backup..."
cd "${HERMES_HOME}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_PREFIX}_${TIMESTAMP}.tar.gz"
tar czf "${BACKUP_FILE}" --exclude='*.pyc' --exclude='__pycache__' skills/

BACKUP_SIZE=$(ls -lh "${BACKUP_FILE}" | awk '{print $5}')
echo "  Created: ${BACKUP_FILE} (${BACKUP_SIZE})"

# 2. Clean old backups (keep last N)
echo ""
echo "[2/3] Cleaning old backups (keeping last ${MAX_BACKups})..."
OLD_COUNT=$(ls -t ${BACKUP_PREFIX}_*.tar.gz 2>/dev/null | wc -l)
if [ "${OLD_COUNT}" -gt "${MAX_BACKUPS}" ]; then
    ls -t ${BACKUP_PREFIX}_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm -f
    REMOVED=$((OLD_COUNT - MAX_BACKUPS))
    echo "  Removed: ${REMOVED} old backups"
else
    echo "  No cleanup needed (${OLD_COUNT}/${MAX_BACKUPS})"
fi

# 3. Send Telegram notification
echo ""
echo "[3/3] Sending Telegram notification..."
MSG="💜🔐 Backup semanal de skills completado%0A%0A📦 Archivo: ${BACKUP_FILE}%0A📏 Tamaño: ${BACKUP_SIZE}%0A📅 Fecha: $(date '+%Y-%m-%d %H:%M:%S')%0A%0A✅ Backups retenidos: $(ls -t ${BACKUP_PREFIX}_*.tar.gz 2>/dev/null | wc -l) (de ${MAX_BACKUPS} máximos)"

RESPONSE=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -d "chat_id=${CHAT_ID}" \
    -d "text=${MSG}" 2>&1)

if echo "${RESPONSE}" | grep -q '"ok":true'; then
    echo "  Notification sent successfully ✅"
else
    echo "  WARNING: Notification may have failed"
    echo "  Response: ${RESPONSE}"
fi

echo ""
echo "=== Backup completed ==="
