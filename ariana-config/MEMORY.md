# MEMORY — Persistent Notes

## Actualización: Junio 2026

### Proyectos Activos

**1. Clínica PieSanoGDL (Podología)**
- **Estado:** Skill creado, pendiente implementación
- **Descripción:** Chatbot para agenda de citas (WhatsApp/Facebook Messenger/Instagram → Google Calendar)
- **Detalles:** 1 podólogo, Lun-Sab 10AM-7PM, 45 min por cita, 6 servicios (Pedicure Clínico, Onicomicosis, Consulta General, Uñas Encarnadas, Callosidades, Corrección de Corte)
- **Autenticación:** Cuentas n8n/Make.com: piesanogdl@gmail.com, Google Calendar activo
- **Skill:** chatbot-appointment-automation
- **Costo estimado:** ~$850 MXN/mes

**2. Tienda ARMONIX (Shopify Dropshipping)**
- **Estado:** Skill creado, pendiente implementación
- **Descripción:** Tienda Shopify dropshipping, salud y cuidado personal, proveedores locales México
- **Detalles:** Primera tienda, presupuesto $2,000 MXN/mes, solo México inicialmente
- **Proveedores:** locales de México (salud/cuidado personal)
- **Skill:** ecommerce-dropshipping
- **Costo estimado:** ~$1,130 MXN/mes

**3. BRIDA IT Services (Cybersecurity)**
- **Estado:** 21 skills creados (17 cybersecurity + 2 automatización + 2 raíz)
- **Skills:** brida-it-services, cybersecurity-BRIDA-consulting, cybersecurity-presentations, vulnerability-management-brida, penetration-testing-brida, incident-response-brida, network-security-brida, phishing-defense-brida, ransomware-defense-brida, zero-trust-architecture-brida, web-application-security-brida, security-operations-brida, ot-ics-security-brida, red-teaming-brida, endpoint-security-brida, mobile-security-brida, compliance-governance-brida, chatbot-appointment-automation, ecommerce-dropshipping
- **Sistema:** v0.17.0, Python 3.11, deepseek-r1-distill-qwen-32b

### Lecciones Aprendidas

**Telegram:** Para enviar archivos, usar `curl -F "chat_id=ID" -F "document=@/path" "https://api.telegram.org/bot<TOKEN>/sendDocument"`

**Seguridad:** Nunca guardar tokens en memoria persistente. Pedir credenciales al usuario cuando sea necesario.

**Memory:** Los skills NO se pierden en reboot. La DB de sesiones (SQLite) sobrevive si se hace stop limpio.

**Cuando usuario pide "reboot":** Ejecutar health check pre-reboot (skill references/health-check-pre-reboot.md), crear backups, detener gateway limpiamente, luego permitir reboot. Después ejecutar health check post-reboot (skill references/health-check-post-reboot.md).

### Estado del Sistema
- **Servidor:** Linux Ubuntu 26.04, systemd service hermes-gateway
- **Modelo:** deepseek/deepseek-r1-distill-qwen-32b
- **Canales:** Telegram (Roger 585583379, Berni 693441689)
- **Cron Jobs:** Ninguno activo
