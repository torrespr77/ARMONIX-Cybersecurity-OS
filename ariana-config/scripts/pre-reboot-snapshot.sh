#!/bin/bash
#############################
# pre-reboot-snapshot.sh - Crea snapshot del un reboot programado
# Usar: programarlo en CRON diario como backup
############################=

BACKUP_DIR=~/tools/backups
DATE=$(date +%Y%m%d_%H%M)

mkdir -p $BACKUP_DIR

# Snapshot de herramientas instaladas (binarios fáciles)
tar -czf $BACKUP_DIR/tools_binaries_$DATE.tar.gz \
    ~/.local/bin/ 2>/dev/null

# Snapshot de Python packages
tar -czf $BACKUP_DIR/python_libs_$DATE.tar.gz \
    ~/.local/lib/ 2>/dev/null

# Snapshot de configs críticas
tar -czf $BACKUP_DIR/java_jdk_$DATE.tar.gz \
    ~/tools/java/ 2>/dev/null

# Rotar  max 7 días
ls -t $BACKUP_DIR/tools_binaries_*.tar.gz | tail -n +8 | xargs rm -f 2>/dev/null
ls -t $BACKUP_DIR/python_libs_*.tar.gz     | tail -n +8 | xargs rm -f 2>/dev/null

echo "Snapshot: $DATE completado en $BACKUP_DIR"
du -sh $BACKUP_DIR
