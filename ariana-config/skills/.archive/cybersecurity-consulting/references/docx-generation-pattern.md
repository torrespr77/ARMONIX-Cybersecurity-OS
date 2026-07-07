# Patrón de Generación de Documentos Word (.docx)

## Estandarizado para documentos de consultoría

### Pitfalls críticos actualizados

1. **NUNCA** acceder a `t.rows[X]` sin asegurar que la fila existe. Siempre construir con `rows=1+len(data)`.
2. **NUNCA** asignar texto a una celda vacía con `cell.text = ''` y luego intentar agregar runs.
3. **SIEMPRE** verificar el archivo generado antes de enviar.
4. **SIEMPRE** enviar por Telegram con `MEDIA:/ruta/archivo.docx`.
5. **SIEMPRE usar listas `[]` para filas de datos, NUNCA tuplas `()`.** Mezclar tuplas y listas causa `SyntaxError`.
6. **Colores hex:** Usar siempre 6 caracteres (ej: `'1A3C6E'`). Colores de 3 chars causan `ValueError`.
7. **Pitfall unicode en f-strings (Jun 2026):** Al generar scripts Python con `write_file`, los emojis unicode como `\U0001f49c` + `\uU0001f510` causan `SyntaxError: truncated \uXXXX escape`. **Solución:** Usar `execute_code` con heredoc (`python3 << 'PYEOF'`) o evitar emojis unicode en strings generados. Si se necesita emoji, definir como variable: `PURPLE_HEART = "\U0001f49c"` y usar la variable.
8. **Pitfall f-string con diccionarios JSON:** Al incluir datos JSON en f-strings, los `{}` del JSON confunden el parser. **Solución:** Construir el JSON como variable separada y pasarla al f-string, o usar string concatenation en lugar de f-strings.

### Método preferido para generar documentos

1. **Script inline con `execute_code`:** Escribir todo el script Python directamente en un `python3 << 'PYEOF'` heredoc. Esto evita problemas de escape de `write_file`.
2. **Archivo temporal con `write_file`:** Si el script es complejo, escribir a `/tmp/gen_doc.py` y ejecutar con `terminal("python3 /tmp/gen_doc.py")`. Verificar que no haya emojis unicode problemáticos en strings.
3. **Verificación:** Después de generar, verificar con `os.path.exists()` y `os.path.getsize() > 0`.
4. **Envío:** Usar `send_message` con `MEDIA:/ruta/archivo.docx`.

### Colores corporativos (personal brand)
- Morado principal: `#4A154B`
- Azul: `#1A3C6E`
- Rojo acento: `#E74C3C`
- Gris texto: `#666666`
- Gris claro filas alternadas: `#F2F2F2`

### Estructura estándar de documento
1. Portada | 2. Índice | 3. Introducción | 4. Estado Actual | 5. Secciones técnicas | 6. Plan de Implementación | 7. Anexos

### Tablas profesionales
- Header: fondo morado `#4A154B`, texto blanco, bold, tamaño 9-10pt
- Filas alternadas: blanco / gris claro `#F2F2F2`
- Cuerpo: Calibri 9-10pt
- Usar `table.style = 'Table Grid'` para bordes
- Centrar tabla con `table.alignment = WD_TABLE_ALIGNMENT.CENTER`
