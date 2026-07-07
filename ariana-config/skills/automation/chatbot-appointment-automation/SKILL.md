---
name: chatbot-appointment-automation
description: >
  Automatización de chatbots para clínicas y consultorios médicos.
  Agenda citas automáticamente vía WhatsApp, Facebook Messenger e Instagram,
  sincronizando con Google Calendar. Incluye flujos de conversación,
  recordatorios, cancelaciones y reprogramaciones.
  Activado por: chatbot, cita, agendar, clínica, podología, WhatsApp,
  automatización de citas, recordatorio de cita, n8n, Make.com.
domain: automation
subdomain: chatbot-appointments
tags:
  - chatbot
  - whatsapp
  - google-calendar
  - n8n
  - make-com
  - citas
  - clinica
  - podologia
  - automatizacion
  - recordatorios
version: 1.0.0
author: Rogelio Torres Pimentel
license: Proprietary
---

# 🤖 Automatización de Chatbots para Clínicas — PieSanoGDL

## Descripción

Skill integral para crear y gestionar chatbots de agenda de citas para clínicas y consultorios médicos. Diseñado específicamente para la clínica **Pie Sano - Centro Integral Salud y Belleza** (podología), pero adaptable a cualquier clínica.

**Stack recomendado:** n8n (principal) + Make.com (alternativa) + Google Calendar + WhatsApp Business API

---

## 📋 Contexto de la Clínica

### Pie Sano - Centro Integral Salud y Belleza

| Dato | Detalle |
|---|---|
| **Nombre** | Pie Sano - Centro Integral Salud y Belleza |
| **Especialidad** | Podología |
| **Ubicación** | Guadalajara, Jalisco (GDL) |
| **Doctores** | 1 podólogo |
| **Horario** | Lunes a Sábado, 10:00 AM - 7:00 PM |
| **Duración de cita** | 45 minutos |
| **Email** | piesanogdl@gmail.com |
| **Cuentas n8n/Make** | Sí (piesanogdl@gmail.com) |
| **Google Calendar** | Sí (control de citas) |
| **Base de datos pacientes** | No (solo registros en papel) |

### Servicios Ofrecidos

| Servicio | Descripción | Duración |
|---|---|---|
| **Pedicure Clínico Preventivo** | Limpieza y cuidado preventivo de pies | 45 min |
| **Tratamiento Onicomicosis** | Tratamiento de hongos en uñas | 45 min |
| **Consulta General** | Evaluación podológica completa | 45 min |
| **Uñas Encarnadas** | Tratamiento de uña encarnada | 45 min |
| **Callosidades** | Eliminación de callos y durezas | 45 min |
| **Corrección de Corte** | Técnica correcta de corte de uñas | 45 min |

---

## 🏗️ Arquitectura del Chatbot

### Plataformas de Mensajería

| Plataforma | Prioridad | API/Integración |
|---|---|---|
| **WhatsApp** | 🔴 Alta | WhatsApp Business API (via Twilio, WATI, o Meta) |
| **Facebook Messenger** | 🟡 Media | Meta Graph API |
| **Instagram DMs** | 🟡 Media | Meta Graph API (misma cuenta de Facebook) |

### Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────┐
│                    PACIENTE                                  │
│  WhatsApp / Facebook Messenger / Instagram                  │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│              CAPA DE RECEPCIÓN                                │
│  ┌──────────┐  ┌──────────────┐  ┌───────────────┐          │
│  │ WhatsApp │  │ FB Messenger │  │ Instagram DM  │          │
│  │ Business │  │    API       │  │    API        │          │
│  └────┬─────┘  └──────┬───────┘  └───────┬───────┘          │
│       └───────────────┼──────────────────┘                   │
└───────────────────────┼──────────────────────────────────────┘
                        │
                        ▼
┌──────────────────────────────────────────────────────────────┐
│              MOTOR DE AUTOMATIZACIÓN                          │
│  ┌─────────────────────────────────────────────────────┐     │
│  │                    n8n / Make.com                    │     │
│  │  ┌─────────────┐  ┌──────────────┐  ┌───────────┐  │     │
│  │  │  Flujo de   │  │  Lógica de   │  │ Notific.  │  │     │
│  │  │Conversación │  │  Negocio     │  │           │  │     │
│  │  └─────────────┘  └──────────────┘  └───────────┘  │     │
│  └─────────────────────────────────────────────────────┘     │
└──────────────────────┬───────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│              CAPA DE DATOS                                    │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐   │
│  │ Google Calendar│  │ Google Sheets  │  │  Base Datos  │   │
│  │   (Citas)      │  │  (Pacientes)   │  │  (Futuro)    │   │
│  └────────────────┘  └────────────────┘  └──────────────┘   │
└──────────────────────────────────────────────────────────────┘
```

---

## 💬 Flujo de Conversación del Chatbot

### Flujo Principal: Agendar Cita

```
INICIO
  │
  ▼
┌─────────────────────────────────────┐
│ 1. SALUDO INICIAL                   │
│ "¡Hola! 👋 Bienvenido/a a Pie Sano │
│  - Centro Integral Salud y Belleza. │
│  Soy tu asistente virtual. ¿En qué  │
│  puedo ayudarte?"                    │
│                                     │
│ Opciones:                           │
│ [Agendar Cita] [Info Servicios]     │
│ [Cancelar/Reprogramar] [Ubicación]  │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 2. DESCRIPCIÓN DEL PROBLEMA         │
│ "Cuéntame, ¿qué molestia o          │
│  problema tienes en tus pies?"      │
│                                     │
│ [El paciente describe su problema]  │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 3. EXPLICACIÓN DE SERVICIOS         │
│ "Entiendo. En Pie Sano ofrecemos    │
│  los siguientes servicios:"         │
│                                     │
│ 🩺 Pedicure Clínico Preventivo      │
│ 🍄 Tratamiento Onicomicosis         │
│ 👨‍⚕️ Consulta General                │
│ 💅 Uñas Encarnadas                  │
│ 🦶 Callosidades                     │
│ ✂️ Corrección de Corte              │
│                                     │
│ ¿Cuál te interesa?                  │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 4. SELECCIÓN DE SERVICIO            │
│ [Paciente elige servicio]           │
│                                     │
│ "Excelente elección. El servicio    │
│  de [SERVICIO] dura aprox.         │
│  45 minutos."                       │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 5. SELECCIÓN DE FECHA Y HORA        │
│ "¿Qué día te gustaría agendar?"    │
│                                     │
│ [Mostrar calendario disponible]     │
│ Horarios: 10:00 AM - 7:00 PM       │
│ (Lunes a Sábado)                    │
│ [Cada slot = 45 min]                │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 6. DATOS DEL PACIENTE               │
│ "Para agendar necesito tus datos:"  │
│                                     │
│ 📝 Nombre completo                  │
│ 📱 Teléfono (con WhatsApp)          │
│ 📧 Email (opcional)                 │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ 7. CONFIRMACIÓN                     │
│ "Confirma tu cita:"                 │
│                                     │
│ 📅 Fecha: [DD/MM/AAAA]             │
│ 🕐 Hora: [HH:MM]                    │
│ 🩺 Servicio: [SERVICIO]             │
│ 👤 Paciente: [NOMBRE]               │
│ 📱 Teléfono: [TELEFONO]             │
│                                     │
│ [✅ Confirmar] [❌ Cancelar]        │
└──────────────────┬──────────────────┘
                   │
          ┌────────┴────────┐
          │                 │
          ▼                 ▼
   ┌─────────────┐   ┌─────────────┐
   │ CONFIRMA    │   │ NO CONFIRMA │
   │             │   │             │
   │ → Agenda en │   │ → Libera    │
   │   Google    │   │   horario   │
   │   Calendar  │   │ → Mensaje:  │
   │ → Envía     │   │   "Tu hora  │
   │   confirm.  │   │   fue       │
   │   por WA    │   │   liberada" │
   └─────────────┘   └─────────────┘
```

### Flujo de Recordatorios

```
RECORDATORIO 24 HORAS ANTES
  │
  ▼
"Hola [NOMBRE] 👋 Te recordamos tu cita mañana en Pie Sano:
 📅 Fecha: [FECHA]
 🕐 Hora: [HORA]
 🩺 Servicio: [SERVICIO]
 
 ¿Confirmas tu asistencia?"
 [✅ Sí, confirmo] [❌ Cancelar] [🔄 Reprogramar]

RECORDATORIO 2 HORAS ANTES
  │
  ▼
"Hola [NOMBRE] 👋 Tu cita en Pie Sano es en 2 horas:
 🕐 Hora: [HORA]
 🩺 Servicio: [SERVICIO]
 
 ¡Te esperamos! 📍 [Dirección]"
```

### Flujo de Cancelación/Reprogramación

```
CANCELAR/REPROGRAMAR
  │
  ▼
"Para cancelar o reprogramar, necesito:
 📱 Tu teléfono registrado"
  │
  ▼
[Busca cita por teléfono en Google Calendar]
  │
  ▼
"Encontramos tu cita:
 📅 [FECHA] a las [HORA]
 🩺 [SERVICIO]
 
 ¿Qué deseas hacer?"
 [❌ Cancelar] [🔄 Reprogramar]
  │                    │
  ▼                    ▼
[Cancela en Calendar] [Muestra nuevo calendario]
[Envía confirmación]  [Reagenda]
```

---

## ⚙️ Implementación con n8n

### Workflow 1: Recepción y Procesamiento de Mensajes

```json
{
  "name": "PieSanoGDL - Chatbot Citas",
  "nodes": [
    {
      "name": "Webhook WhatsApp",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "piesano-whatsapp",
        "httpMethod": "POST"
      }
    },
    {
      "name": "Parsear Mensaje",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "const body = $input.first().json.body;\nreturn [{\n  json: {\n    from: body.from,\n    message: body.message,\n    timestamp: new Date().toISOString(),\n    platform: 'whatsapp'\n  }\n}];"
      }
    },
    {
      "name": "Estado de Conversación",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "get",
        "sheetId": "{{$env.GOOGLE_SHEET_ID}}",
        "range": "Conversaciones!A:F"
      }
    },
    {
      "name": "Lógica del Chatbot",
      "type": "n8n-nodes-base.switch",
      "parameters": {
        "rules": {
          "rules": [
            {"outputKey": "saludo", "conditions": {"string": [{"value1": "={{$json.message.toLowerCase()}}", "operation": "contains", "value2": "hola"}]}},
            {"outputKey": "servicio", "conditions": {"string": [{"value1": "={{$json.message.toLowerCase()}}", "operation": "contains", "value2": "servicio"}]}},
            {"outputKey": "agendar", "conditions": {"string": [{"value1": "={{$json.message.toLowerCase()}}", "operation": "contains", "value2": "agendar"}]}},
            {"outputKey": "cancelar", "conditions": {"string": [{"value1": "={{$json.message.toLowerCase()}}", "operation": "contains", "value2": "cancelar"}]}}
          ]
        }
      }
    }
  ]
}
```

### Workflow 2: Agendar Cita en Google Calendar

```json
{
  "name": "PieSanoGDL - Agendar Cita",
  "nodes": [
    {
      "name": "Crear Evento",
      "type": "n8n-nodes-base.googleCalendar",
      "parameters": {
        "operation": "create",
        "calendar": {
          "__rl": true,
          "value": "piesanogdl@gmail.com"
        },
        "start": "={{$json.fechaHoraInicio}}",
        "end": "={{$json.fechaHoraFin}}",
        "additionalFields": {
          "summary": "Cita PieSano - {{$json.servicio}} - {{$json.paciente}}",
          "description": "Paciente: {{$json.paciente}}\\nTeléfono: {{$json.telefono}}\\nServicio: {{$json.servicio}}",
          "reminders": {
            "useDefault": false,
            "overrides": [
              {"method": "popup", "minutes": 120},
              {"method": "popup", "minutes": 30}
            ]
          }
        }
      }
    },
    {
      "name": "Enviar Confirmación",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "method": "POST",
        "url": "https://graph.facebook.com/v17.0/{{$env.WA_PHONE_ID}}/messages",
        "authentication": "genericCredentialType",
        "genericAuthType": "httpHeaderAuth",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {"name": "messaging_product", "value": "whatsapp"},
            {"name": "to", "value": "={{$json.telefono}}"},
            {"name": "type", "value": "text"},
            {"name": "text[body]", "value": "✅ ¡Cita confirmada!\\n\\n📅 {{$json.fecha}}\\n🕐 {{$json.hora}}\\n🩺 {{$json.servicio}}\\n\\nTe enviaremos recordatorios. ¡Te esperamos! 👋"}
          ]
        }
      }
    },
    {
      "name": "Registrar Paciente",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "append",
        "sheetId": "{{$env.GOOGLE_SHEET_PACIENTES_ID}}",
        "range": "Pacientes!A:E",
        "options": {
          "valueInputMode": "USER_ENTERED"
        },
        "columns": {
          "mappingMode": "defineBelow",
          "value": {
            "Fecha": "={{$now.format('dd/MM/yyyy')}}",
            "Nombre": "={{$json.paciente}}",
            "Telefono": "={{$json.telefono}}",
            "Email": "={{$json.email}}",
            "Servicio": "={{$json.servicio}}"
          }
        }
      }
    }
  ]
}
```

### Workflow 3: Recordatorios Automáticos

```json
{
  "name": "PieSanoGDL - Recordatorios",
  "nodes": [
    {
      "name": "Cron Diario 9AM",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "item": [{"hour": 9, "minute": 0}]
        }
      }
    },
    {
      "name": "Buscar Citas del Día Siguiente",
      "type": "n8n-nodes-base.googleCalendar",
      "parameters": {
        "operation": "getAll",
        "calendar": {
          "__rl": true,
          "value": "piesanogdl@gmail.com"
        },
        "returnAll": true,
        "options": {
          "timeMin": "={{$now.plus({days: 1}).startOf('day').toISO()}}",
          "timeMax": "={{$now.plus({days: 1}).endOf('day').toISO()}}"
        }
      }
    },
    {
      "name": "Enviar Recordatorio 24h",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "method": "POST",
        "url": "https://graph.facebook.com/v17.0/{{$env.WA_PHONE_ID}}/messages",
        "sendBody": true,
        "bodyParameters": {
          "parameters": [
            {"name": "messaging_product", "value": "whatsapp"},
            {"name": "to", "value": "={{$json.telefono}}"},
            {"name": "type", "value": "text"},
            {"name": "text[body]", "value": "👋 Hola {{$json.paciente}}! Te recordamos tu cita mañana en Pie Sano:\\n\\n📅 {{$json.fecha}}\\n🕐 {{$json.hora}}\\n🩺 {{$json.servicio}}\\n\\n¿Confirmas tu asistencia?\\n✅ Sí, confirmo\\n❌ Cancelar\\n🔄 Reprogramar"}
          ]
        }
      }
    }
  ]
}
```

---

## ⚙️ Implementación con Make.com (Alternativa)

### Escenario Principal: Agendar Cita

| Módulo | Configuración |
|---|---|
| **Webhook** | Recibe mensaje de WhatsApp (via Twilio/WhatsApp Business) |
| **Router** | Dirige según estado de conversación |
| **Google Sheets** | Lee/actualiza estado del paciente |
| **Google Calendar** | Crea/elimina/modifica eventos |
| **WhatsApp** | Envía mensajes de respuesta |
| **Filter** | Valida horarios disponibles (10AM-7PM, Lun-Sab) |

### Comparativa n8n vs Make.com

| Característica | n8n | Make.com |
|---|---|---|
| **Costo** | Self-hosted: gratuito | Desde $9 USD/mes |
| **Facilidad** | Media (requiere setup) | Alta (más visual) |
| **WhatsApp** | Requiere Twilio/API directa | Integración nativa |
| **Google Calendar** | Nativo | Nativo |
| **Flexibilidad** | Alta (código JS) | Media |
| **Recomendación** | ✅ **Recomendado** para PieSanoGDL | Alternativa si n8n es complejo |

**Recomendación para PieSanoGDL:** Usar **n8n** como plataforma principal porque:
1. Ya tienen cuenta configurada
2. Es más económico (self-hosted)
3. Mayor flexibilidad para flujos complejos
4. Mejor integración con Google Workspace

---

## 📊 Google Sheets — Estructura de Datos

### Hoja: Conversaciones

| Columna | Descripción |
|---|---|
| A | Timestamp |
| B | Teléfono |
| C | Nombre |
| D | Estado (saludo/seleccionando/confirmando/confirmado) |
| E | Servicio elegido |
| F | Fecha/Hora cita |

### Hoja: Pacientes

| Columna | Descripción |
|---|---|
| A | Fecha registro |
| B | Nombre completo |
| C | Teléfono |
| D | Email |
| E | Servicio frecuente |

### Hoja: Citas

| Columna | Descripción |
|---|---|
| A | Fecha cita |
| B | Hora inicio |
| C | Hora fin |
| D | Paciente |
| E | Teléfono |
| F | Servicio |
| G | Estado (confirmada/cancelada/completada/no-asistio) |

---

## 🔧 Configuración Inicial

### Paso 1: Google Workspace
1. Crear Google Sheet con 3 hojas: Conversaciones, Pacientes, Citas
2. Configurar Google Calendar compartido para la clínica
3. Habilitar API de Google (Calendar + Sheets)

### Paso 2: WhatsApp Business API
1. Crear cuenta de Meta Business
2. Configurar WhatsApp Business API (via Twilio, WATI, o 360dialog)
3. Verificar número de teléfono de la clínica
4. Configurar webhook para recibir mensajes

### Paso 3: n8n
1. Instalar n8n (self-hosted o cloud)
2. Configurar credenciales de Google (OAuth2)
3. Configurar credenciales de WhatsApp/Twilio
4. Importar workflows del skill
5. Configurar variables de entorno

### Paso 4: Pruebas
1. Enviar mensaje de prueba por WhatsApp
2. Verificar flujo completo: saludo → servicio → fecha → confirmación
3. Verificar creación de evento en Google Calendar
4. Verificar envío de recordatorios

---

## 📈 Métricas y Monitoreo

| Métrica | Descripción |
|---|---|
| **Citas agendadas/día** | Número de citas confirmadas |
| **Tasa de confirmación** | % de pacientes que confirman |
| **Tasa de cancelación** | % de citas canceladas |
| **No-show** | % de pacientes que no asisten |
| **Tiempo promedio de agenda** | Minutos desde primer mensaje hasta confirmación |
| **Satisfacción** | Encuesta post-cita (opcional) |

---

## 🚀 Roadmap de Implementación

### Fase 1: MVP (Semana 1-2)
- [ ] Configurar Google Calendar y Sheets
- [ ] Configurar WhatsApp Business API
- [ ] Implementar flujo básico: saludo → servicio → fecha → confirmación
- [ ] Agenda en Google Calendar

### Fase 2: Recordatorios (Semana 3)
- [ ] Recordatorio 24 horas antes
- [ ] Recordatorio 2 horas antes
- [ ] Confirmación de asistencia

### Fase 3: Gestión de Citas (Semana 4)
- [ ] Cancelación de citas
- [ ] Reprogramación de citas
- [ ] Liberación automática de horarios no confirmados

### Fase 4: Multi-plataforma (Semana 5-6)
- [ ] Facebook Messenger
- [ ] Instagram DMs
- [ ] Unificación de conversaciones

### Fase 5: Optimización (Semana 7-8)
- [ ] Base de datos de pacientes
- [ ] Historial de citas por paciente
- [ ] Métricas y reportes
- [ ] Encuesta de satisfacción post-cita

---

## 📞 Soporte

Para consultas sobre la implementación:
- **Consultor:** Rogelio Torres Pimentel
- **LinkedIn:** https://www.linkedin.com/in/rogeliotorres/
- **Email:** rogelio.torres.pimentel@gmail.com
- **Movil:** +52 33 1486 9253

---

*Documento propiedad de Rogelio Torres Pimentel. Version 1.0.0 - Junio 2026*
