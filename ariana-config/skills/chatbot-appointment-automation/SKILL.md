---
name: chatbot-appointment-automation
description: Diseño e implementación de chatbots automatizados para agenda de citas
  en clínicas y consultorios, usando n8n, Make.com o similares. Incluye flujos de
  conversación, integración con calendarios, recordatorios y gestión de cancelaciones.
category: automation
---

# Skill: Chatbot de Citas para Clínicas

## Descripción
Automatización de chatbots para agenda de citas médicas/de servicio en clínicas y consultorios. Cubre diseño de flujos de conversación, integración con calendarios, recordatorios automáticos y gestión de cancelaciones.

## Plataformas soportadas
- **n8n** (recomendado para auto-hospedaje y control total)
- **Make.com** (antes Integromat, más visual)
- **Zapier** (alternativa sencilla)
- **Chatfuel / ManyChat** (para Facebook/Instagram Messenger)
- **WhatsApp Business API** (vía proveedores como WATI, Twilio, etc.)

## Flujos estándar

### Flujo 1: Agenda de citas básica
```
Saludo → Seleccionar servicio → Seleccionar doctor → Elegir fecha/hora → Confirmar datos → Confirmar cita → Enviar recordatorio
```

### Flujo 2: Recordatorio de cita
```
Trigger: 24h antes → Consultar calendario → Enviar recordatorio (WhatsApp/SMS/Email) → Opción de cancelar/posponer
```

### Flujo 3: Cancelación
```
Paciente solicita cancelar → Verificar identidad → Liberar horario → Confirmar cancelación → Ofrecer reprogramar
```

### Flujo 4: Confirmación de asistencia
```
Trigger: 1h antes → Enviar mensaje de confirmación → Paciente confirma o cancela → Actualizar calendario
```

## Integraciones necesarias
- **Calendario:** Google Calendar, Outlook, Calendly
- **Comunicación:** WhatsApp Business, SMS (Twilio), Email (Gmail/SMTP)
- **Base de datos:** Google Sheets, Airtable, Notion, o base de datos propia
- **Notificaciones:** Push, SMS, Email

## Preguntas clave para personalizar (consultar al cliente)
1. ¿Nombre de la clínica?
2. ¿Cuántos doctores/profesionales atienden?
3. ¿Horarios de atención?
4. ¿Qué servicios ofrece?
5. ¿Duración de cada tipo de cita?
6. ¿Plataforma preferida para el chatbot? (WhatsApp, Messenger, Instagram, web)
7. ¿Debe enviar recordatorios? (cuántas horas antes)
8. ¿Permitir cancelar/reprogramar?
9. ¿Usa algún calendario actualmente?
10. ¿Tiene base de datos de pacientes?

## Notas técnicas
- Para n8n: referirse a los skills oficiales de n8n-io/skills para mejores prácticas
- Para WhatsApp Business API: requiere proveedor externo (WATI, Twilio, 360dialog)
- Cumplimiento de privacidad: obtener consentimiento para almacenar datos de pacientes
