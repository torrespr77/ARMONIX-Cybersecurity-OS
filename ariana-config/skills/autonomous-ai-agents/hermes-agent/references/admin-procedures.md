# Procedimientos de Administración de Hermes Agent

## Visión General

Hermes Agent es un activo valioso para BRIDA IT Services. Este documento establece los procedimientos de administración para garantizar su operación continua, evolución y preparación ante contingencias.

**Managers:**
- **Roger (Rogelio Torres Pimentel)** — Senior Cybersecurity Consultant / Architect
- **Berni (Bernardo Gomez)** — Gerente BRIDA IT Services

---

## 1. Inicio de Día (Daily Check)

Cada día, antes de iniciar operaciones:

```bash
# 1. Verificar que el gateway está corriendo
hermes gateway status

# 2. Verificar memoria persistente
ls -la ~/.hermes/USER.md ~/.hermes/MEMORY.md

# 3. Verificar espacio en disco
df -h /home

# 4. Verificar backups del día anterior
ls -lt ~/.hermes/state.db.bak.* | head -3

# 5. Revisar logs de errores
grep -i "error\|fatal" ~/.hermes/logs/gateway.log | tail -10
```

**Si algo falla:** Notificar a Roger inmediatamente antes de continuar operaciones.

---

## 2. Health Check Semanal (Cada Viernes o antes de cambios mayores)

```bash
# 1. Estado completo del sistema
hermes gateway status
sudo systemctl status hermes-gateway

# 2. Integridad de base de datos
sqlite3 ~/.hermes/state.db "PRAGMA integrity_check;"

# 3. Verificar que todos los skills están presentes
ls -d ~/.hermes/skills/*/ | wc -l

# 4. Verificar backups
echo "DB: $(ls ~/.hermes/state.db.bak.* 2>/dev/null | wc -l)"
echo "Skills: $(ls ~/.hermes/skills_backup_* 2>/dev/null | wc -l)"
echo "Config: $(ls ~/.hermes/config.yaml.bak.* 2>/dev/null | wc -l)"

# 5. Espacio en disco
df -h /home

# 6. Actualizar skills si hay disponibles
hermes skills check
```

---

## 3. Procedimiento de Reboot (Hardware o Servicio)

### Pre-Reboot
1. Ejecutar health check completo
2. Crear backup manual: `cp ~/.hermes/state.db ~/.hermes/state.db.bak.$(date +%Y%m%d_%H%M%S)`
3. Detener limpiamente: `sudo systemctl stop hermes-gateway`
4. Confirmar stop: `hermes gateway status` → "not running"

### Post-Reboot
1. Verificar auto-start: `hermes gateway status`
2. Si no auto-inició: `sudo systemctl start hermes-gateway`
3. Verificar memoria persistente (saluda por nombre)
4. Verificar skills completos
5. Prueba de comunicación con Roger

---

## 4. Expansión de Skills

Cuando se requiera una nueva capacidad:

1. **Investigar:** Buscar en el skills hub si existe
2. **Crear:** Usar `skill_manage(action='create')` con frontmatter correcto
3. **Documentar:** Agregar propósito, triggers y pasos al SKILL.md
4. **Probar:** Verificar que carga correctamente con `/skill <name>`
5. **Backup:** El skill queda automáticamente respaldado en próximo backup

**Categorías actuales:**
- `cybersecurity/` — Skills de ciberseguridad BRIDA
- `automation/` — Automatización (chatbots, flujos)
- `ecommerce/` — Comercio electrónico
- `autonomous-ai-agents/` — Configuración de Hermes

---

## 5. Restauración en Caso de Desastre

### Si la base de datos se corrompe:
```bash
# Detener gateway
sudo systemctl stop hermes-gateway

# Restaurar backup más reciente
BACKUP=$(ls -t ~/.hermes/state.db.bak.* | head -1)
cp "$BACKUP" ~/.hermes/state.db

# Reiniciar
sudo systemctl start hermes-gateway
hermes gateway status
```

### Si faltan skills:
```bash
BACKUP=$(ls -t ~/.hermes/skills_backup_*.tar.gz | head -1)
tar -xzf "$BACKUP" -C ~/.hermes/
```

### Si se pierde la memoria persistente:
```bash
# Los archivos USER.md y MEMORY.md son el respaldo físico
cat ~/.hermes/USER.md
cat ~/.hermes/MEMORY.md
# Si no existen, reconstruir desde el contexto de los managers
```

---

## 6. Mejora Continua

### Después de cada proyecto importante:
1. Documentar lecciones aprendidas en `~/.hermes/MEMORY.md`
2. Actualizar `~/.hermes/USER.md` con nuevos proyectos/preferencias
3. Crear skill si se descubrió un patrón reutilizable
4. Compactar memoria si supera el 85% de uso

### Auto-mantenimiento:
- El sistema curator automático gestiona skills creados por el agente
- Los backups de config se limpian automáticamente (máximo 3)
- Los backups de DB y Skills se limpian manualmente cada mes

---

## 7. Responsabilidades de los Managers

### Roger:
- Definir nuevos proyectos y requerimientos
- Aprobar cambios de configuración
- Proporcionar tokens/credenciales cuando se necesiten
- Validar que las mejoras implementadas funcionen correctamente

### Berni:
- Supervisar la operación desde perspectiva de negocio
- Aprobar gastos en herramientas/cloud
- Coordinar con equipo de BRIDA IT Services

### Hermes (yo):
- Ejecutar los procedimientos documentados
- Notificar anomalías inmediatamente
- Mantener mis propios backups y health checks
- Evolucionar mis skills según las necesidades del negocio

---

## 8. Contacto de Emergencia

| Canal | Detalle |
|---|---|
| **Telegram Roger** | 585583379 |
| **Telegram Berni** | 693441689 |
| **Email Roger** | rogelio.torres.pimentel@gmail.com |
| **Servidor** | systemctl {start\|stop\|restart\|status} hermes-gateway |

---

*Documento creado: Junio 2026 — BRIDA IT Services — Hermes Agent v0.17.0*
