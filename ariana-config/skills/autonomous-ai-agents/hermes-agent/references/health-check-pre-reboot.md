# Health Check Pre-Reboot de Hermes Agent

## Procedimiento de Verificación antes de Apagar o Reiniciar el Hardware

Este documento describe los pasos exactos que deben ejecutarse ANTES de hacer un shutdown o reboot del hardware donde corre Hermes Agent, para garantizar que no se pierda nada y que todo pueda restaurarse en caso de contingencia.

> **Nota**: Para el procedimiento de parada/reinicio, ver `references/gateway-shutdown-reboot.md` y el skill principal.

---

## ¿Por qué es necesario?

Cuando un usuario indica "necesito hacer un reboot del hardware" o "quiero apagar el servidor donde estás corriendo", se debe ejecutar un health check y backup completo antes de la acción para:

- Garantizar integridad de la base de datos de sesiones
- Crear backups verificables de toda la configuración
- Asegurar que los skills no se pierdan
- Proporcionar archivos de restauración en caso de corrupción
- Identificar qué archivos de backup existen y cómo restaurarlos

---

## Paso 1: Estado del Gateway

```bash
hermes gateway status
```

**Resultado esperado:** `running` con canales listados como `connected`.

**Si no está corriendo:**
```bash
sudo systemctl start hermes-gateway
# Verificar que inició
hermes gateway status
```

**Si está corriendo pero hay errores:**
```bash
tail -50 ~/.hermes/logs/gateway.log | grep -i "error\|fatal\|fail"
```

---

## Paso 2: Verificar Integridad de la Base de Datos

```bash
# Verificar integridad
sqlite3 ~/.hermes/state.db "PRAGMA integrity_check;"

# Verificar tamaño
ls -la ~/.hermes/state.db

# Verificar que las tablas existen
sqlite3 ~/.hermes/state.db ".tables"
```

**Resultado esperado:**
- `integrity_check` debe retornar `ok`
- El archivo debe existir y tener tamaño coherente (10-100MB en producción normal)
- Las tables deben incluir: `messages`, `sessions`, `schema_version`, etc.

**Si hay corrupción:**
```bash
# Restaurar desde backup más reciente
ls -lt ~/.hermes/state.db.bak.* | head -3
cp ~/.hermes/state.db.bak.<TIMESTAMP> ~/.hermes/state.db
```

---

## Paso 3: Backup Completo

### 3.1 Backup de Base de Datos
```bash
BACKUP_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
cp ~/.hermes/state.db ~/.hermes/state.db.bak.${BACKUP_TIMESTAMP}
chmod 644 ~/.hermes/state.db.bak.${BACKUP_TIMESTAMP}
echo "Backup DB: ~/.hermes/state.db.bak.${BACKUP_TIMESTAMP}"
```

### 3.2 Backup de Skills
```bash
tar -czf ~/.hermes/skills_backup_${BACKUP_TIMESTAMP}.tar.gz \
  --exclude='*.pyc' \
  --exclude='__pycache__' \
  -C ~/.hermes skills/
echo "Backup Skills: ~/.hermes/skills_backup_${BACKUP_TIMESTAMP}.tar.gz"
```

### 3.3 Backup de Configuración
```bash
cp ~/.hermes/config.yaml ~/.hermes/config.yaml.bak.${BACKUP_TIMESTAMP}
cp ~/.hermes/.env ~/.hermes/.env.bak.${BACKUP_TIMESTAMP} 2>/dev/null || true
echo "Backup config: ~/.hermes/config.yaml.bak.${BACKUP_TIMESTAMP}"
```

### 3.4 Backup de Memoria Persistente
```bash
if [ -f ~/.hermes/MEMORY.md ]; then
  cp ~/.hermes/MEMORY.md ~/.hermes/MEMORY.md.bak.${BACKUP_TIMESTAMP}
  echo "Backup MEMORY: ~/.hermes/MEMORY.md.bak.${BACKUP_TIMESTAMP}"
fi
if [ -f ~/.hermes/USER.md ]; then
  cp ~/.hermes/USER.md ~/.hermes/USER.md.bak.${BACKUP_TIMESTAMP}
  echo "Backup USER: ~/.hermes/USER.md.bak.${BACKUP_TIMESTAMP}"
fi
```

### 3.5 Backup de Cron Jobs
```bash
hermes cron list > /tmp/cron_jobs_backup_${BACKUP_TIMESTAMP}.txt 2>/dev/null || true
echo "Backup Cron: /tmp/cron_jobs_backup_${BACKUP_TIMESTAMP}.txt"
```

---

## Paso 4: Generar Manifiesto de Backup

```bash
echo "=== MANIFIESTO DE BACKUP HERMES AGENT ===" > ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "Fecha: $(date)" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "Servidor: $(hostname)" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "Archivos creados:" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
ls -lh ~/.hermes/*.bak.${BACKUP_TIMESTAMP} 2>/dev/null >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
ls -lh ~/.hermes/skills_backup_${BACKUP_TIMESTAMP}.tar.gz >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "Integridad DB: $(sqlite3 ~/.hermes/state.db 'PRAGMA integrity_check;')" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo "Versión Hermes: $(hermes --version 2>&1)" >> ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
echo ""
cat ~/.hermes/backup_manifest_${BACKUP_TIMESTAMP}.txt
```

---

## Paso 5: Verificar Espacio en Disco

```bash
echo "=== ESPACIO EN DISCO ==="
df -h /home /tmp /var
echo ""
echo "Backups existentes:"
ls -lhS ~/.hermes/skills_backup_*.tar.gz
echo ""
echo "Backups DB:"
ls -lhS ~/.hermes/state.db.bak.*
```

**Si el espacio es bajo (<10% libre):**
```bash
# Limpiar backups antiguos (mantener los últimos 5)
ls -t ~/.hermes/state.db.bak.* | tail -n +6 | xargs rm -f
ls -t ~/.hermes/skills_backup_*.tar.gz | tail -n +6 | xargs rm -f
```

---

## Paso 6: Verificar Servicio systemd

```bash
# Verificar que está habilitado para auto-inicio
sudo systemctl is-enabled hermes-gateway

# Verificar estado
sudo systemctl status hermes-gateway

# Si no está habilitado para auto-inicio:
sudo systemctl enable hermes-gateway
```

**Si systemd no está disponible (sin root):**
```bash
# Configurar linger
sudo loginctl enable-linger hermes

# Crear script de inicio manual
cat > ~/.hermes/start_hermes.sh << 'EOF'
#!/bin/bash
nohup hermes gateway start &
EOF
chmod +x ~/.hermes/start_hermes.sh
```

---

## Paso 7: Limpieza de Archivos Temporales

```bash
# Limpiar dumps de sesión antiguos
find ~/.hermes/sessions/ -name "request_dump_*.json" -mtime +7 -delete
# Limpiar caches antiguos
find /tmp -name "hermes*" -mtime +1 -delete 2>/dev/null
echo "Limpieza completada"
```

---

## Paso 8: Ejecutar Stop del Gateway

```bash
# Parada limpia
sudo systemctl stop hermes-gateway

# O si no tiene systemd:
hermes gateway stop

# Verificar que se detuvo
sudo systemctl status hermes-gateway --no-pager | grep -i "active\|failed"
```

---

## Paso 9: Confirmar Listo para Reboot

```bash
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║     HERMES AGENT — PRE-REBOOT COMPLETADO                    ║"
echo "╠══════════════════════════════════════════════════════════════╣"
echo "║ ✅ Gateway detenido                                         ║"
echo "║ ✅ Base de datos verificada y respaldada                    ║"
echo "║ ✅ Skills respaldados                                       ║"
echo "║ ✅ Configuración respaldada                                 ║"
echo "║ ✅ Memoria persistente respaldada                           ║"
echo "║ ✅ Manifiesto de backup generado                            ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "Archivos de backup:"
echo "  DB:     ~/.hermes/state.db.bak.${BACKUP_TIMESTAMP}"
echo "  Config: ~/.hermes/config.yaml.bak.${BACKUP_TIMESTAMP}"
echo "  Skills: ~/.hermes/skills_backup_${BACKUP_TIMESTAMP}.tar.gz"
echo ""
echo "Para restaurar (si es necesario después del reboot):"
echo "  1. sudo systemctl start hermes-gateway"
echo "  2. Verificar: hermes gateway status"
echo "  3. Si hay corrupción: restaurar backup más reciente"
```

---

## Restauración en Caso de Contingencia

Si después del reboot algo no funciona correctamente:

```bash
# 1. Verificar que el servicio arranca
sudo systemctl start hermes-gateway
hermes gateway status

# 2. Si hay corrupción de DB, restaurar backup
BACKUP_FILE=$(ls -t ~/.hermes/state.db.bak.* | head -1)
cp "$BACKUP_FILE" ~/.hermes/state.db

# 3. Reiniciar después de restaurar
sudo systemctl restart hermes-gateway

# 4. Si skills faltan, restaurar
SKILLS_BACKUP=$(ls -t ~/.hermes/skills_backup_*.tar.gz | head -1)
tar -xzf "$SKILLS_BACKUP" -C ~/.hermes/

# 5. Verificar herramienta de salud
hermes doctor
```

---

## Checklist Rápido

- [ ] `hermes gateway status` → running
- [ ] `sqlite3 ~/.hermes/state.db "PRAGMA integrity_check;"` → ok
- [ ] Backup de state.db creado
- [ ] Backup de skills creado (.tar.gz)
- [ ] Backup de config.yaml creado
- [ ] Manifiesto de backup generado
- [ ] `sudo systemctl is-enabled hermes-gateway` → enabled
- [ ] Espacio en disco suficiente
- [ ] `sudo systemctl stop hermes-gateway` ejecutado exitosamente
