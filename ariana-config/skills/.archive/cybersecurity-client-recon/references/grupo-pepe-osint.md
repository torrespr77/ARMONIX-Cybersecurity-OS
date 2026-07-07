# Grupo Pepe — OSINT Profile & Engagement Status

> **Última actualización:** Junio 2026
> **Consultor:** Roger (BRIDA IT Services)
> **Estado:** Threat Model v0.2 entregado | Pendiente: VA results, network diagram, asset inventory

## Perfil Corporativo

| Dato | Valor |
|---|---|
| **Grupo** | Grupo Pepe |
| **Industria** | Restaurantes/cadena de comida rápida |
| **Marcas** | Pollo Pepe, Pipinos Pizza, El Pollo Bronco, Barbacos |
| **Presencia** | México (190+ sucursales, principalmente Jalisco/occidente) + USA (San Antonio, TX) |
| **Empleados** | ~1,700 MX + ~254 USA |
| **Dominio principal** | pollopepe.com |
| **E-commerce** | ordena.pollopepe.com (next.js / delitech.app) |
| **Facturación** | facturacion.pollopepe.com |
| **Email** | hola@pollopepe.com |
| **CDN/WAF** | Cloudflare |
| **Email Provider** | Google Workspace |
| **RRSS** | Facebook 211K followers, LinkedIn 254 empleados |
| **Presencia USA** | us.pollopepe.com |

## Infraestructura Conocida

| Componente | Estado |
|---|---|
| Hosting | Datacenter local (no cloud) |
| Active Directory | ❌ No tiene |
| Antivirus corporativo | ❌ No tiene |
| Firewall enterprise | ❌ No confirmado |
| SPF/DKIM/DMARC | ❌ No tiene |
| CISO | ❌ No identificado públicamente |
| VPN | ❓ Desconocido |
| WiFi segmentación | ❓ Desconocido |

## Gaps de Seguridad Críticos (Confirmados)

1. 🔴 Sin SPF/DKIM/DMARC — spoofing/phishing vulnerable
2. 🔴 Sin CISO — sin gobernanza de seguridad
3. 🔴 Sin antivirus corporativo — endpoints expuestos
4. 🔴 Sin Active Directory — sin gestión centralizada de identidades
5. 🟠 Hosting local — sin redundancia/cloud
6. 🟠 Madurez de seguridad MUY BAJA

## Plan de Trabajo

1. ✅ OSINT completado
2. ✅ Threat Model v0.2 entregado (8 escenarios STRIDE+DREAD)
3. ✅ Guía SPF/DKIM/DMARC entregada
4. ⏳ Vulnerability Assessment (pendiente resultados)
5. ⏳ Network diagram (pendiente del cliente)
6. ⏳ Asset inventory (pendiente del cliente)
7. ⏳ Integrar VA results al Threat Model → v0.3
8. ⏳ Pentest (solo después de VA y con madurez suficiente)

## Amenazas Principales (Top 5 del Threat Model)

1. Phishing → Ransomware → Paro operativo (190+ sucursales)
2. Magecart en e-commerce (robo de tarjetas PCI)
3. Compromiso de POS (scraping de datos de tarjetas)
4. Insider threat (robo de datos de clientes)
5. DDoS contra e-commerce (pérdida de ventas)

## Notas
- Roger confirmó: VA antes de Pentest por madurez muy baja
- Cliente no tiene capacidad de respuesta a incidentes
- Prioridad: Quick wins (SPF/DKIM/DMARC, MFA, inventario)
