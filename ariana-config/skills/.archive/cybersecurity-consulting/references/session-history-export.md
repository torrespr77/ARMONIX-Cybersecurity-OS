# Exportar Historial de Sesión a Documento Word

## Cuándo usar
Cuando el usuario pida un "journal", "registro de instrucciones", "historial de mensajes" o similar — exportar mensajes del chat a un documento Word profesional.

## Fuente de datos
La base de datos SQLite de Hermes en `~/.hermes/state.db` contiene:
- Tabla `messages`: `id`, `session_id`, `role`, `content`, `timestamp`, `token_count`
- Tabla `sessions`: `id`, `source`, `started_at`, `title`

## Flujo de extracción

### 1. Extraer mensajes del usuario
```python
import sqlite3, os
from datetime import datetime

db_path = os.path.expanduser('~/.hermes/state.db')
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

cursor.execute("""
    SELECT m.id, m.content, m.timestamp
    FROM messages m
    WHERE m.role = 'user'
    ORDER BY m.timestamp ASC
""")

rows = cursor.fetchall()
messages = []
for msg_id, content, ts in rows:
    dt = datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')
    if content and len(content.strip()) > 5:
        messages.append({'id': msg_id, 'datetime': dt, 'content': content.strip()})
```

### 2. Filtrar mensajes del sistema
- Omitir mensajes que empiecen con `[CONTEXT COMPACTION` o `[OUT-OF-BAND`
- Omitir mensajes muy cortos (< 5 chars) que suelen ser saludos casuales
- Incluir TODAS las instrucciones sustantivas, incluso las breves

### 3. Generar documento Word
Usar `execute_code` con heredoc para evitar problemas de escape unicode:
```python
python3 << 'PYEOF'
from docx import Document
from docx.shared import Pt, Cm, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
# ... (ver docx-generation-pattern.md para estructura completa)
PYEOF
```

### 4. Estructura del documento exportado
1. **Portada:** Título, subtítulo, autor, fecha de generación
2. **Tabla resumen:** #, fecha, categoría, resumen de cada instrucción
3. **Instrucciones detalladas:** Una por una con número, fecha, categoría, contenido completo
4. **Footer:** Nota de generación automática

### 5. Categorización automática
Clasificar cada instrucción por categoría:
- **Verificación de Estado:** "are you alive?", "estas activa?"
- **Configuración de Sistema:** Scripts de inicio, instalación, servicios
- **Resolución de Errores:** Errores, bugs, problemas de configuración
- **Creación de Skills:** "Create a comprehensive... skill"
- **Generación de Documentos:** Threat Models, guías, reportes
- **Análisis:** OSINT, TLS, repositorios GitHub

## Limitaciones conocidas
- Los mensajes de sesiones compactadas NO están en la DB — solo los de la sesión actual y recientes
- El contenido de `system_prompt` y configuraciones iniciales no se almacena como mensaje de usuario
- Si el usuario pidió algo en una sesión compactada, puede que no aparezca

## Pitfalls
1. **No usar `write_file` para scripts con emojis unicode** — Usar `execute_code` con heredoc
2. **No asumir que todos los mensajes son instrucciones** — Filtrar saludos y mensajes del sistema
3. **Verificar que el archivo se generó** — Comprobar tamaño > 0 antes de enviar
4. **Enviar con MEDIA:** — `send_message` con `MEDIA:/ruta/archivo.docx`
