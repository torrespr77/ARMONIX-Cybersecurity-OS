---
name: security-awareness-training
description: Security Awareness Training
category: cybersecurity
---# Skill: Security Awareness Training

## Descripción
Programa de capacitación en conciencia de seguridad para empleados de clientes de BRIDA IT Services, incluyendo contenido, metodología, simulaciones de phishing y métricas de efectividad.

## Cuándo Usar
- Implementación de programa de seguridad awareness para un cliente nuevo
- Capacitación post-incidente (phishing, data breach)
- Programa trimestral/semestral de entrenamiento
- Onboarding de nuevos empleados
- Preparación para auditoría de compliance

## Programa de Capacitación

### Nivel 1: Fundamentos (Todos los empleados)
**Duración:** 60-90 minutos | **Frecuencia:** Anual + reforzamiento trimestral

#### Módulo 1: Introducción a la Ciberseguridad (15 min)
- ¿Por qué la seguridad importa para TODOS
- El eslabón más débil: el factor humano
- Estadísticas de ataques en México y LATAM
- Consecuencias reales: multas, pérdida de datos, reputación

#### Módulo 2: Phishing y Social Engineering (20 min)
- ¿Qué es el phishing? (email, SMS, llamadas, redes sociales)
- Cómo identificar un correo de phishing:
  - Remitente sospechoso
  - Urgencia artificial ("¡Verifique su cuenta AHORA!")
  - Links que no coinciden con la URL real
  - Adjuntos inesperados
  - Errores gramaticales
- Ejemplos reales de phishing en empresas mexicanas
- Qué hacer si sospechas de un phishing: REPORTE, no hacer clic
- Demostración en vivo de un ataque de phishing

#### Módulo 3: Contraseñas y Autenticación (15 min)
- Contraseñas fuertes: longitud > complejidad
- Gestores de contraseñas (recomendación: Bitwarden, 1Password)
- MFA (Multi-Factor Authentication): por qué es crítico
- NUNCA compartir contraseñas
- NUNCA reutilizar contraseñas entre servicios

#### Módulo 4: Seguridad Física y de Escritorio (10 min)
- Clean desk policy
- Bloquear pantalla al levantarse (Win+L / Ctrl+Cmd+Q)
- No dejar dispositivos sin supervisión
- USB desconocidos: NUNCA conectar
- Tailgating: no dejar pasar a desconocidos

#### Módulo 5: Uso Seguro de Internet y Redes Sociales (10 min)
- WiFi público: riesgos y VPN
- Descargas seguras: solo fuentes oficiales
- Redes sociales: qué NO compartir
- Ingeniería social en LinkedIn/Facebook

#### Módulo 6: Reporte de Incidentes (10 min)
- A quién reportar (helpdesk, seguridad, gerente)
- Qué reportar (correos sospechosos, comportamiento extraño, pérdida de dispositivos)
- No hay reporte "tonto" — mejor reportar de más
- Proceso de reporte interno del cliente

### Nivel 2: Intermedio (IT Staff, Gerentes)
**Duración:** 2-3 horas | **Frecuencia:** Semestral

- Todo lo de Nivel 1, más:
- Seguridad en desarrollo de software (OWASP Top 10 básico)
- Manejo de datos sensibles (PII, financial)
- Seguridad en dispositivos móviles
- VPN y acceso remoto seguro
- Procedimientos de backup y recuperación
- Introducción a incident response

### Nivel 3: Avanzado (IT Security, Admins)
**Duración:** 4-8 horas | **Frecuencia:** Trimestral

- Todo lo anterior, más:
- Análisis de logs y detección de anomalías
- Hardening de sistemas
- Respuesta a incidentes (hands-on)
- Threat intelligence básico
- Forensics fundamentals
- Tabletop exercises

## Simulaciones de Phishing

### Metodología
1. **Baseline test** — Enviar phishing simulado sin previo aviso
2. **Medir resultados** — % de apertura, % de clic, % de ingreso de credenciales
3. **Capacitación** — Entrenamiento basado en resultados
4. **Re-test** — Enviar nuevo phishing simulado 30 días después
5. **Comparar** — Medir mejora

### Plataformas de Simulación
| Plataforma | Tipo | Costo |
|---|---|---|
| GoPhish | Open-source (self-hosted) | Gratis |
| KnowBe4 | SaaS comercial | $$ |
| Cofense | SaaS comercial | $$$ |
| Google Workspace Phishing Simulation | Incluido en Google Workspace | Incluido |

### Métricas de Simulación
| Métrica | Descripción | Meta |
|---|---|---|
| **Click Rate** | % que hizo clic en el link malicioso | < 5% |
| **Credential Submission** | % que ingresó credenciales | < 2% |
| **Report Rate** | % que reportó el phishing | > 50% |
| **Time to Report** | Tiempo promedio de reporte | < 1 hora |

### Plantillas de Phishing para Simulación
1. **Password Reset** — "Su contraseña expiró, haga clic para renovarla"
2. **Package Delivery** — "Tiene un paquete pendiente de entrega"
3. **IT Support** — "Soporte técnico necesita verificar su cuenta"
4. **CEO Fraud** — "Necesito que hagas un pago urgente" (desde email del CEO)
5. **HR Notification** — "Actualización de política de beneficios"
6. **Cloud Storage** — "Alguien compartió un documento contigo"

## Materiales de Capacitación

### Para Grupo Pepe (ejemplo personalizado)
- **Escenario 1:** Phishing como "Pollo Pepe Soporte Técnico" pidiendo credenciales del sistema POS
- **Escenario 2:** Email falso de "Google Workspace" pidiendo verificar la cuenta de hola@pollopepe.com
- **Escenario 3:** Llamada de "banco" pidiendo información de la empresa
- **Escenario 4:** USB encontrado en el estacionamiento con etiqueta "Nómina 2026"

### Formato de Entrega
| Formato | Ventaja | Desventaja |
|---|---|---|
| **Presencial** | Mayor engagement, Q&A en vivo | Logística, costo |
| **Virtual (Teams/Zoom)** | Escalable, grabable | Menor engagement |
| **E-learning (LMS)** | Self-paced, trackable | Requiere plataforma |
| **Microlearning (videos 5min)** | Fácil de consumir | Menor profundidad |
| **Carteles/Flyers** | Refuerzo visual | Solo awareness básico |

## Programa Anual Recomendado

| Mes | Actividad | Audiencia |
|---|---|---|
| Enero | Capacitación anual (Nivel 1) | Todos |
| Febrero | Simulación phishing #1 (baseline) | Todos |
| Marzo | Resultados + reforzamiento | Todos |
| Abril | Capacitación Nivel 2 (IT/Gerentes) | IT + Gerentes |
| Mayo | Simulación phishing #2 | Todos |
| Junio | Microlearning: seguridad en vacaciones | Todos |
| Julio | Tabletop exercise (incident response) | IT + Gerentes |
| Agosto | Simulación phishing #3 | Todos |
| Septiembre | Capacitación Nivel 3 (Security team) | IT Security |
| Octubre | Cyber Security Month — campaña especial | Todos |
| Noviembre | Simulación phishing #4 | Todos |
| Diciembre | Análisis anual + plan siguiente | IT + Gerentes |

## Checklist de Implementación
- [ ] Programa de capacitación aprobado por el cliente
- [ ] Contenido desarrollado (personalizado por cliente)
- [ ] Plataforma de simulación configurada (GoPhish o similar)
- [ ] Baseline phishing test ejecutado
- [ ] Calendario anual de capacitaciones programado
- [ ] Métricas baseline establecidas
- [ ] Proceso de reporte de phishing comunicado a todos
- [ ] Materiales de refuerzo (carteles, flyers) distribuidos
- [ ] Reporte trimestral de métricas preparado
- [ ] Presupuesto aprobado para plataforma y contenido
