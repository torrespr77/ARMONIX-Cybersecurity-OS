# Health Check Post-Reboot de Hermes Agent

## Procedución de Verificación después del Reinicio del Hardware

Se recomienda ejecutar este health check después de cada reboot de hardware para verificar que Hermes Agent se recuperó correctamente y todos los datos y servicios están intactos.

---

## Paso 1: Gateway se reinició automáticamente

```bash
hermes gateway status
```

**Resultado esperado:** `running` con plataformas listadas.

**Si no se reinició automáticamente:**
```bash
sudo systemctl start hermes-gateway
# Verificar
sudo systemctl status hermes-gateway
```

**Si systemd no está disponible (sin root, en Docker, etc.):**
```bash
# Verificar si el proceso está corriendo
ps aux | grep "hermes.*gateway" | grep -v grep

# Si no está corriendo, iniciar
hermes gateway start
```

---

## Paso 2: Verificar Plataformas y Canales

El status del gateway debe listar las plataformas conectadas. Verifica:
- ¿Telegram aparece como `connected`?
- ¿Hubo algún error de autenticación en los logs?

```bash
# Revisar los últimos logs
tail -30 ~/.hermes/logs/gateway.log
```

**Errores comunes post-reboot:**
- Token de Telegram inválido → re-generar con @BotFather
- Timeout al reconectar → es unos minutos, se reintenta automáticamente

---

## Paso 3: Verificar Integridad de Base de Datos

```bash
# Tamaño coherente (no 0 bytes)
ls -lh ~/.hermes/state.db

# Verificar integridad si sqlite3 está disponible
sqlite3 ~/.hermes/state.db "PRAGMA integrity_check;" 2>/dev/null

# Verificar que no se corrompió durante el shutdown
```
**Nota:** El proceso de shutdown (`systemctl stop` o `hermes gateway stop`) garantiza que la SQLite cierre conexiones limpiamente. Pero en caso de kill brusco, puede haber WAL files huérfanos:

```bash
# Limpiar WAL files si los hay
rm -f ~/.hermes/state.db-wal ~/.hermes/state.db-shm
```

---

## Paso 4: Verificar Memoria Persistente

Las memorias (MEMORY.md, USER.md, MEMORY_KEYWORDS) viven en el system prompt de Hermes Agent. Si ves que no reconoce configuraciones previas:

1. Verificar que `~/.hermes/MEMORY.md` y `~/.hermes/USER.md` están en el system prompt
2. Si faltan, se inyecta desde `~/.hermes/state.db` al reiniciar (FTS5)
3. Si no se recuperan, el usuario debe indicar información de contexto para reconstruir

**Indicador de memoria exitosa:** El agente saluda por nombre y recuerda preferencias previas del usuario.

---

## Paso 5: Verificar Skills

```bash
# Cantidad de skills instalados
ls -d ~/.hermes/skills/*/ | wc -l

# Verificar que skills críticos están presentes
for skill in brida-it-services chatbot-appointment-automation ecommerce-dropshipping; do
  if [ -d ~/.hermes/skills/*/$skill ] || [ -d ~/.hermes/skills/*/*/$skill ]; then
    echo "✅ $skill - OK"
  else
    echo "❌ $skill - FALTA"
  fi
done
```

**Si falta un skill:**
```bash
# Restaurar desde backup
BACKUP=$(ls -t ~/.hermes/skills_backup_*.tar.gz | head -1)
tar -xzf $BACKUP -C ~/.hermes/
```

---

## Paso 6: Verificar Backups

```bash
echo "Backups DB: $(ls ~/.hermes/state.db.bak.* 2>/dev/null | wc -l)"
echo "Backups Skills: $(ls ~/.hermes/skills_backup_* 2>/dev/null | wc -l)"
echo "Backups Config: $(ls ~/.hermes/config.yaml.bak.* 2>/dev/null | wc -l)"
```

---

## Paso 7: Cron Jobs Restaurados

```bash
hermes cron list
```

Los cron jobs sobreviven al reboot porque están en SQLite. Pero verifica que los horarios no se desajustaron si el reloj del servidor se sincronizó diferente.

---

## Paso 8: Prueba de Comunicación

El usuario debe enviar un mensaje de prueba al agente para confirmar que todo fluye correctamente.

---

## Checklist Resumen

- [ ] Gateway corriendo
- [ ] Plataformas (Telegram) conectadas
- [ ] Base de datos íntegra
- [ ] Memoria persistente presente (saluda por nombre)
- [ ] Skills completos instalados
- [ ] Backups accesibles
- [ ] Cron jobs activos y correctos
- [ ] Prueba de comunicación exitosa
