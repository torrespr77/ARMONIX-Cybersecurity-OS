---
name: ecommerce-dropshipping
description: >
  Automatización integral de e-commerce con modelo dropshipping en Shopify.
  Cubre importación de productos, gestión de inventario, notificación de pedidos
  a proveedores, seguimiento de envíos, atención al cliente y publicación en redes.
  Diseñado para tienda ARMONIX (salud y cuidado personal, proveedores locales México).
  Activado por: dropshipping, shopify, ecommerce, armONIX, importar productos,
  automatizar tienda, proveedores, envíos, atención al cliente.
domain: ecommerce
subdomain: dropshipping
tags:
  - dropshipping
  - shopify
  - ecommerce
  - automatizacion
  - importacion-productos
  - gestion-inventario
  - atencion-cliente
  - redes-sociales
  - proveedores
  - mexico
version: 1.0.0
author: Rogelio Torres Pimentel
license: Proprietary
---

# 🛒 E-commerce Dropshipping — ARMONIX

## Descripción

Skill integral para crear, configurar y automatizar una tienda de e-commerce con modelo dropshipping en Shopify. Diseñado específicamente para **ARMONIX** (salud y cuidado personal, proveedores locales de México), pero adaptable a cualquier nicho.

**Stack recomendado:** Shopify + n8n + Make.com + WhatsApp Business + Instagram/Facebook

---

## 📋 Contexto de la Tienda

### ARMONIX

| Dato | Detalle |
|---|---|
| **Nombre** | ARMONIX |
| **Nicho** | Salud y cuidado personal |
| **Plataforma** | Shopify |
| **Proveedores** | Locales de México |
| **Mercado** | Solo México (inicial) |
| **Experiencia** | Primera tienda |
| **Presupuesto mensual** | $2,000 MXN |
| **Marketplaces** | No (solo tienda propia) |
| **Email** | piesanogdl@gmail.com (misma cuenta) |

### Productos: Salud y Cuidado Personal

| Categoría | Ejemplos | Margen esperado |
|---|---|---|
| **Cuidado de pies** | Cremas, plantillas, separadores | 40-60% |
| **Cuidado personal** | Aceites esenciales, jabones naturales | 35-50% |
| **Bienestar** | Suplementos, vitaminas, té | 30-45% |
| **Accesorios** | Masajeadores, rodillos, bandas | 50-70% |

---

## 🏗️ Arquitectura del E-commerce

### Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────────────────────┐
│                    CLIENTE                                       │
│  Shopify Store / WhatsApp / Instagram / Facebook                │
└──────────────────────┬──────────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────────┐
│              TIENDA SHOPIFY (ARMONIX)                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────────┐    │
│  │ Catálogo │  │ Carrito  │  │ Checkout │  │  Dashboard   │    │
│  │Productos │  │ Compras  │  │ Pago     │  │  Admin       │    │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └──────┬───────┘    │
│       └──────────────┴─────────────┴───────────────┘             │
└──────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────────┐
│              MOTOR DE AUTOMATIZACIÓN                              │
│  ┌──────────────────────────────────────────────────────────┐    │
│  │                    n8n + Make.com                         │    │
│  │  ┌────────────┐ ┌────────────┐ ┌────────────┐            │    │
│  │  │ Importación│ │ Gestión    │ │ Notific.   │            │    │
│  │  │ Productos  │ │ Inventario │ │ Pedidos    │            │    │
│  │  └────────────┘ └────────────┘ └────────────┘            │    │
│  │  ┌────────────┐ ┌────────────┐ ┌────────────┐            │    │
│  │  │ Seguimiento│ │ Atención   │ │ Redes      │            │    │
│  │  │ Envíos     │ │ Cliente    │ │ Sociales   │            │    │
│  │  └────────────┘ └────────────┘ └────────────┘            │    │
│  └──────────────────────────────────────────────────────────┘    │
└──────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────────┐
│              CAPA DE DATOS Y SERVICIOS                            │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐   │
│  │ Proveedores│ │ Google     │ │ WhatsApp   │ │ Instagram/ │   │
│  │ (Locales   │ │ Sheets     │ │ Business   │ │ Facebook   │   │
│  │  México)   │ │ (Control)  │ │ API        │ │ API        │   │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

---

## ⚙️ Procesos a Automatizar

### 1. Importación de Productos del Proveedor a la Tienda

**Objetivo:** Automatizar la carga de productos desde los proveedores locales de México al catálogo de Shopify.

#### Opciones según tipo de proveedor:

| Tipo de proveedor | Método de importación | Herramienta |
|---|---|---|
| **Proveedor con API** | Conexión directa API → Shopify | n8n + Shopify API |
| **Proveedor con catálogo CSV/Excel** | Importación por archivo | n8n + Google Sheets + Shopify |
| **Proveedor con página web** | Web scraping ético | n8n + HTTP Request + Shopify |
| **Proveedor manual (WhatsApp/Email)** | Proceso semi-automatizado | n8n + Gmail/WhatsApp + Shopify |

#### Workflow n8n: Importación de Productos

```json
{
  "name": "ARMONIX - Importar Productos",
  "nodes": [
    {
      "name": "Trigger Manual o Programado",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "item": [{"hour": 8, "minute": 0}]
        }
      }
    },
    {
      "name": "Obtener Catálogo Proveedor",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "method": "GET",
        "url": "={{$env.PRODUCTOS_API_URL}}",
        "authentication": "genericCredentialType"
      }
    },
    {
      "name": "Transformar Datos",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "const productos = $input.first().json.products;\nreturn productos.map(p => ({\n  json: {\n    title: p.nombre,\n    body_html: p.descripcion,\n    vendor: p.proveedor,\n    product_type: p.categoria,\n    tags: [p.categoria, 'salud', 'cuidado-personal'],\n    variants: [{\n      price: p.precio_venta,\n      compare_at_price: p.precio_venta * 1.3,\n      sku: p.sku,\n      inventory_quantity: p.stock,\n      weight: p.peso,\n      weight_unit: 'g'\n    }],\n    images: p.imagenes.map(img => ({ src: img }))\n  }\n}));"
      }
    },
    {
      "name": "Crear en Shopify",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "operation": "create",
        "resource": "product",
        "title": "={{$json.title}}",
        "bodyHtml": "={{$json.body_html}}",
        "vendor": "={{$json.vendor}}",
        "productType": "={{$json.product_type}}",
        "tags": "={{$json.tags}}",
        "options": {
          "variants": "={{$json.variants}}",
          "images": "={{$json.images}}"
        }
      }
    }
  ]
}
```

#### Plantilla Google Sheets: Control de Productos

| Columna | Descripción |
|---|---|
| A | SKU |
| B | Nombre del producto |
| C | Descripción |
| D | Categoría |
| E | Proveedor |
| F | Costo (MXN) |
| G | Precio venta (MXN) |
| H | Margen (%) |
| I | Stock disponible |
| J | Imagen URL |
| K | Estado (activo/inactivo) |
| L | Shopify Product ID |
| M | Última actualización |

---

### 2. Actualización de Precios e Inventario

**Objetivo:** Mantener precios y stock sincronizados entre proveedores y Shopify.

#### Estrategia de Precios

| Regla | Descripción |
|---|---|
| **Margen mínimo** | 30% sobre costo |
| **Margen objetivo** | 40-50% sobre costo |
| **Precio psicológico** | Terminar en .99 o .90 (ej: $199.99) |
| **Envío** | Gratis en compras > $499 MXN |
| **Descuentos** | 10% primera compra (código: ARMONIX10) |

#### Workflow n8n: Actualización de Inventario

```json
{
  "name": "ARMONIX - Actualizar Inventario",
  "nodes": [
    {
      "name": "Cron Cada 4 Horas",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "item": [
            {"hour": 8}, {"hour": 12}, {"hour": 16}, {"hour": 20}
          ]
        }
      }
    },
    {
      "name": "Obtener Stock Proveedores",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "getAll",
        "sheetId": "{{$env.SHEET_PRODUCTOS_ID}}",
        "range": "Productos!A:N"
      }
    },
    {
      "name": "Actualizar Shopify",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "operation": "update",
        "resource": "product",
        "productId": "={{$json.shopify_id}}",
        "options": {
          "variants": [{
            "id": "={{$json.variant_id}}",
            "inventory_quantity": "={{$json.stock}}",
            "price": "={{$json.precio_venta}}"
          }]
        }
      }
    },
    {
      "name": "Alerta Stock Bajo",
      "type": "n8n-nodes-base.if",
      "parameters": {
        "conditions": {
          "number": [{"value1": "={{$json.stock}}", "operation": "smallerEqual", "value2": 5}]
        }
      }
    }
  ]
}
```

---

### 3. Notificación de Pedidos al Proveedor

**Objetivo:** Enviar automáticamente los pedidos de clientes a los proveedores para su preparación y envío.

#### Flujo de Notificación

```
CLIENTE COMPRA EN SHOPIFY
  │
  ▼
[Shopify dispara webhook: order/create]
  │
  ▼
[n8n recibe webhook]
  │
  ▼
[Extraer datos del pedido]
  - Productos
  - Cantidades
  - Dirección de envío
  - Datos del cliente
  │
  ▼
[Identificar proveedor por producto]
  │
  ▼
┌─────────────────────────────────┐
│  ENVIAR AL PROVEEDOR            │
│  Opción A: Email con formato   │
│  Opción B: WhatsApp            │
│  Opción C: Google Form         │
│  Opción D: API del proveedor   │
└─────────────────────────────────┘
  │
  ▼
[Registrar en Google Sheets: Pedidos]
  │
  ▼
[Enviar confirmación al cliente]
```

#### Plantilla de Notificación al Proveedor (WhatsApp/Email)

```
📦 NUEVO PEDIDO ARMONIX
━━━━━━━━━━━━━━━━━━━━━
Pedido: #ARM-{fecha}-{id}
Fecha: {fecha}

📋 PRODUCTOS:
{cantidad}x {producto} - SKU: {sku}
{cantidad}x {producto} - SKU: {sku}

👤 CLIENTE:
Nombre: {nombre}
Teléfono: {teléfono}
Email: {email}

📍 ENVÍO:
Dirección: {dirección}
Ciudad: {ciudad}, {estado}
CP: {código_postal}

💬 NOTAS: {notas_cliente}

Por favor confirmar recepción y tiempo estimado de entrega.
```

#### Plantilla Google Sheets: Pedidos

| Columna | Descripción |
|---|---|
| A | Pedido ID |
| B | Fecha |
| C | Cliente |
| D | Teléfono |
| E | Email |
| F | Productos |
| G | Total (MXN) |
| H | Proveedor |
| I | Estado (pendiente/enviado/entregado) |
| J | Número de guía |
| K | Fecha envío |
| L | Fecha entrega |

---

### 4. Seguimiento de Envíos

**Objetivo:** Mantener informado al cliente sobre el estado de su paquete.

#### Integraciones de Envío (México)

| Paquetería | API Discomentario | Costo aprox. |
|---|---|---|
| **Estafeta** | Sí (API REST) | $80-150 MXN |
| **DHL México** | Sí (API REST) | $120-250 MXN |
| **FedEx México** | Sí (API REST) | $130-280 MXN |
| **Redpack** | Sí | $70-120 MXN |
| **99 Minutos** | Sí (solo CDMX) | $50-80 MXN |
| **Correos de México** | Limitada | $60-100 MXN |

**Recomendación para ARMONIX:** Estafeta o Redpack (mejor cobertura-precio para envíos nacionales).

#### Flujo de Seguimiento

```
PROVEEDOR ENVÍA PEDIDO
  │
  ▼
[Proveedor comparte número de guía]
  │
  ▼
[n8n registra guía en Google Sheets]
  │
  ▼
[Cron diario: consulta API de paquetería]
  │
  ▼
[Detecta cambio de estado]
  │
  ▼
[Envía actualización al cliente por WhatsApp]
  │
  ▼
Estados: En preparación → En tránsito → En reparto → Entregado
```

#### Mensajes de Seguimiento

```
🚚 Tu pedido ARMONIX está en camino!

📦 Pedido: #ARM-{id}
📍 Estado: {estado}
🚛 Paquetería: {paquetería}
🔍 Guía: {numero_guía}

Puedes rastrear tu paquete en: {link_seguimiento}

¡Gracias por tu compra! 💚
```

---

### 5. Atención al Cliente (Chatbot para Estado de Pedidos)

**Objetivo:** Chatbot que responde consultas frecuentes sobre pedidos.

#### Flujo del Chatbot de Atención

```
CLIENTE ESCRIBE POR WHATSAPP
  │
  ▼
┌─────────────────────────────────────┐
│ "Hola! 👋 Soy el asistente de      │
│  ARMONIX. ¿En qué puedo ayudarte?" │
│                                     │
│ [📦 Estado de pedido]               │
│ [🔄 Cambiar dirección]              │
│ [❌ Cancelar pedido]                │
│ [💬 Hablar con humano]              │
│ [🛍️ Ver productos]                  │
└──────────────────┬──────────────────┘
                   │
                   ▼
┌─────────────────────────────────────┐
│ ESTADO DE PEDIDO                    │
│                                     │
│ "Ingresa tu número de pedido       │
│  (ej: ARM-202606-001) o tu         │
│  teléfono registrado"               │
└──────────────────┬──────────────────┘
                   │
                   ▼
[Busca en Google Sheets: Pedidos]
  │
  ▼
"Tu pedido #ARM-{id} está: {estado}
 📦 {productos}
 🚛 {paquetería}
 🔍 Guía: {guía}
 
 ¿Algo más en qué pueda ayudarte?"
```

#### Preguntas Frecuentes (FAQ)

| Pregunta | Respuesta |
|---|---|
| "¿Cuánto tarda mi envío?" | "Los envíos dentro de México tardan de 3 a 7 días hábiles dependiendo de tu ubicación." |
| "¿Cuánto cuesta el envío?" | "El envío es GRATIS en compras mayores a $499 MXN. Para compras menores, el costo es de $89 MXN." |
| "¿Puedo cambiar mi dirección?" | "Sí, siempre que el pedido aún no haya sido enviado. Indícanos tu número de pedido y la nueva dirección." |
| "¿Tienen garantía?" | "Sí, todos nuestros productos tienen garantía de 30 días. Si no estás satisfecho, te devolvemos tu dinero." |
| "¿Cómo puedo pagar?" | "Aceptamos tarjeta de crédito/débito, transferencia bancaria, OXXO Pay y PayPal." |

---

### 6. Publicación en Redes Sociales

**Objetivo:** Automatizar la publicación de productos y contenido en Instagram y Facebook.

#### Calendario de Contenido Semanal

| Día | Tipo de contenido | Plataforma |
|---|---|---|
| **Lunes** | Producto destacado de la semana | Instagram + Facebook |
| **Martes** | Tip de salud/bienestar | Instagram Stories + Reel |
| **Miércoles** | Testimonio o reseña de cliente | Instagram + Facebook |
| **Jueves** | Behind the scenes / Preparación de pedidos | Instagram Stories |
| **Viernes** | Promoción o descuento de fin de semana | Instagram + Facebook |
| **Sábado** | Contenido educativo (salud/cuidado personal) | Instagram Reel + Facebook |
| **Domingo** | Descanso o contenido ligero | Instagram Stories |

#### Workflow n8n: Publicación Automática

```json
{
  "name": "ARMONIX - Publicar en Redes",
  "nodes": [
    {
      "name": "Cron Calendario",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "item": [{"hour": 10, "minute": 0, "weekday": 1}]
        }
      }
    },
    {
      "name": "Obtener Producto Destacado",
      "type": "n8n-nodes-base.googleSheets",
      "parameters": {
        "operation": "get",
        "sheetId": "{{$env.SHEET_CONTENIDO_ID}}",
        "range": "Calendario!A:G"
      }
    },
    {
      "name": "Generar Caption",
      "type": "n8n-nodes-base.function",
      "parameters": {
        "functionCode": "const p = $input.first().json;\nreturn [{\n  json: {\n    caption: `${p.titulo}\\n\\n${p.descripcion}\\n\\n💰 Precio: $${p.precio} MXN\\n🛒 Link en bio\\n\\n#Armonix #Salud #CuidadoPersonal #Bienestar #Mexico #SaludYBelleza`,\n    imagen: p.imagen_url\n  }\n}];"
      }
    },
    {
      "name": "Publicar Instagram",
      "type": "n8n-nodes-base.facebookGraphApi",
      "parameters": {
        "operation": "create",
        "node": "ig-user-media",
        "binaryData": true,
        "binaryPropertyName": "imagen",
        "caption": "={{$json.caption}}"
      }
    }
  ]
}
```

---

## 💰 Presupuesto de Herramientas ($2,000 MXN/mes)

| Herramienta | Plan | Costo mensual (MXN) |
|---|---|---|
| **Shopify** | Basic | ~$580 MXN |
| **n8n** | Self-hosted (VPS básico) | ~$200 MXN |
| **Make.com** | Free tier | $0 MXN |
| **WhatsApp Business API** | Twilio (pay-per-msg) | ~$300 MXN |
| **Google Workspace** | Business Starter | ~$150 MXN |
| **Dominio .com.mx** | Anual (prorrateado) | ~$50 MXN |
| **Canva Pro** (diseño) | Monthly | ~$200 MXN |
| **Buffer/Hootsuite** (redes) | Free tier | $0 MXN |
| **Reserva/Contingencia** | - | ~$520 MXN |
| **TOTAL** | | **~$2,000 MXN** |

---

## 🚀 Roadmap de Implementación

### Fase 1: Tienda Base (Semana 1-2)
- [ ] Crear cuenta Shopify (plan Basic)
- [ ] Configurar dominio (armonix.mx o similar)
- [ ] Diseñar tema/tienda (theme gratuito o económico)
- [ ] Configurar métodos de pago (Stripe, PayPal, OXXO)
- [ ] Configurar zonas de envío (todo México)
- [ ] Cargar primeros 20-50 productos manualmente

### Fase 2: Automatización de Productos (Semana 3-4)
- [ ] Identificar proveedores y método de conexión
- [ ] Crear Google Sheets de control de productos
- [ ] Implementar workflow de importación en n8n
- [ ] Configurar actualización automática de inventario
- [ ] Probar flujo completo: proveedor → Shopify

### Fase 3: Pedidos y Envíos (Semana 5-6)
- [ ] Configurar webhook de Shopify → n8n (nuevos pedidos)
- [ ] Crear sistema de notificación a proveedores
- [ ] Configurar Google Sheets de pedidos
- [ ] Integrar API de paquetería (Estafeta/Redpack)
- [ ] Implementar seguimiento automático

### Fase 4: Atención al Cliente (Semana 7-8)
- [ ] Configurar WhatsApp Business API
- [ ] Implementar chatbot de estado de pedidos
- [ ] Crear flujo de FAQ automático
- [ ] Configurar escalamiento a humano

### Fase 5: Redes Sociales (Semana 9-10)
- [ ] Crear calendario de contenido
- [ ] Diseñar templates en Canva
- [ ] Configurar publicación automática
- [ ] Implementar respuesta automática a comentarios/DMs

### Fase 6: Optimización (Semana 11-12)
- [ ] Analizar métricas de ventas
- [ ] Optimizar precios y márgenes
- [ ] A/B testing de productos y descripciones
- [ ] Email marketing (Klaviyo o Mailchimp)
- [ ] Programa de fidelización

---

## 📊 KPIs y Métricas

| KPI | Meta (mes 1) | Meta (mes 3) | Meta (mes 6) |
|---|---|---|---|
| **Visitas/mes** | 500 | 2,000 | 5,000 |
| **Tasa de conversión** | 1% | 2% | 3% |
| **Pedidos/mes** | 5 | 40 | 150 |
| **Ticket promedio** | $300 | $400 | $500 |
| **Ingresos mensuales** | $1,500 | $16,000 | $75,000 |
| **Margen neto** | 20% | 30% | 35% |
| **Clientes recurrentes** | 0% | 10% | 25% |

---

## 📞 Soporte

Para consultas sobre la implementación:
- **Consultor:** Rogelio Torres Pimentel
- **LinkedIn:** https://www.linkedin.com/in/rogeliotorres/
- **Email:** rogelio.torres.pimentel@gmail.com
- **Movil:** +52 33 1486 9253

---

*Documento propiedad de Rogelio Torres Pimentel. Version 1.0.0 - Junio 2026*
