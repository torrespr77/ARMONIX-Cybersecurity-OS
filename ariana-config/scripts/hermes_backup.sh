#!/bin/bash
# ═══════════════════════════════════════════════════════════════
# Hermes Agent - Script de Respaldo Automático
# Comprimido en ZIP con timestamp
# ═══════════════════════════════════════════════════════════════

# Configuración
BACKUP_DIR="/home/hermes/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${BACKUP_DIR}/hermes_backup_${TIMESTAMP}.zip"
LOG_FILE="${BACKUP_DIR}/backup_log_${TIMESTAMP}.txt"

# Crear directorio de backups si no existe
mkdir -p "$BACKUP_DIR"

# Inicio del respaldo
echo "═══════════════════════════════════════════════════════" >> "$LOG_FILE"
echo " RESPALDO HERMES AGENT - $(date)" >> "$LOG_FILE"
echo "═══════════════════════════════════════════════════════" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Crear ZIP con timestamp
cd /home/hermes || exit 1

zip -r "$BACKUP_FILE" \
  .hermes/config.yaml \
  .hermes/.env \
  .hermes/state.db \
  .hermes/USER.md \
  .hermes/MEMORY.md \
  .hermes/skills/ \
  .hermes/cron/ \
  .hermes/plans/ \
  .hermes/profiles/ 2>/dev/null /dev/null

# Verificar si el ZIP se creó correctamente
if [ -f "$BACKUP_FILE" ]; then
    BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "✅ Respaldo exitoso: $BACKUP_FILE ($BACKUP_SIZE)" >> "$LOG_FILE"
    echo "✅ Archivos respaldados:" >> "$LOG_FILE"
    echo "   - config.yaml" >> "$LOG_FILE"
    echo "   - .env (credenciales)" >> "$LOG_FILE"
    echo "   - state.db (sesiones)" >> "$LOG_FILE"
    echo "   - USER.md (perfil usuario)" >> "$LOG_FILE"
    echo "   - MEMORY.md (memoria IA)" >> "$LOG_FILE"
    echo "   - skills/ (todos los skills BRIDA)" >> "$LOG_FILE"
    echo "   - cron/ (tareas programadas)" >> "$LOG_FILE"
else
    echo "❌ ERROR: No se pudo crear el respaldo" >> "$LOG_FILE"
    exit 1
fi

# Limpiar backups antiguos (mantener solo los últimos 10)
cd "$BACKUP_DIR" || exit 1
BACKUP_COUNT=$(ls -1 hermes_backup_*.zip 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt 7 ]; then
    ls -t hermes_backup_*.zip | tail -n +11 | xargs -r rm
    echo "🧹 Backups antiguos eliminados (manteniendo 7 más recientes)" >> "$LOG_FILE"
fi

echo "" >> "$LOG_FILE"
echo "═══════════════════════════════════════════════════════" >> "$LOG_FILE"
echo " RESPALDO COMPLETADO - $(date)" >> "$LOG_FILE"
echo "═══════════════════════════════════════════════════════" >> "$LOG_FILE"

echo "✅ Respaldo completado: $BACKUP_FILE ($BACKUP_SIZE)"
