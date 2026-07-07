# Skill: Email Security — SPF/DKIM/DMARC & Anti-Phishing

## Descripción
Guía de implementación de seguridad de correo electrónico incluyendo autenticación (SPF/DKIM/DMARC), configuración anti-phishing, y hardening de Google Workspace para clientes de BRIDA IT Services.

## Cuándo Usar
- Implementación inicial de seguridad de correo
- Configuración de SPF/DKIM/DMARC en nuevos dominios
- Respuesta a incidentes de phishing/spoofing
- Configuración de Google Workspace para nuevos clientes
- Auditoría de seguridad de correo existente

## Componentes de Email Security

### 1. Autenticación de Correo (SPF/DKIM/DMARC)
Ver guía detallada en: `Guia_Tecnica_SPF_DKIM_DMARC_Grupo_Pepe.docx`

Resumen rápido:

| Registro | Tipo | Propósito | Prioridad |
|---|---|---|---|
| SPF | TXT | Autoriza servidores de envío | 🔴 Crítica |
| DKIM | TXT | Firma digital de integridad | 🔴 Crítica |
| DMARC | TXT | Política + reportes | 🔴 Crítica |

### 2. Google Workspace — Configuración de Seguridad

#### Gmail Admin Console
**Admin Console > Apps > Google Workspace > Gmail > Safety**

| Configuración | Valor Recomendado | Razón |
|---|---|---|
| SPF | Enforce | Rechazar correos sin SPF válido |
| DKIM | Enforce | Requerir firma DKIM |
| DMARC | Enforce (tras fase monitoreo) | Aplicar política DMARC |
| Attachment protection | Enable | Bloquear adjuntos peligrosos |
| Links and external images | Enable | Escanear URLs en links |
| Spam | Enhanced | Usar filtros avanzados |
| Impersonation protection | Enable | Proteger contra spoofing interno |

#### Advanced Protection
**Admin Console > Apps > Google Workspace > Gmail > Advanced Settings**

```
# Habilitar:
- SMTP MTA-STS (para cifrado obligatorio)
- DANE (si el DNS lo soporta)
- BIMI (Brand Indicators for Message Identification) - opcional
```

#### OAuth y API Access
```
# Restringir acceso de terceros:
Admin Console > Security > API Controls > App Access Control
- Bloquear apps no verificadas
- Auditar apps conectadas trimestralmente
- Requerir aprobación admin para nuevas apps
```

### 3. Anti-Phishing — Configuración

#### Reglas de Detección de Phishing
```
Admin Console > Apps > Google Workspace > Gmail > Compliance

# Regla 1: Sensitive content detection
If: Subject or body contains "urgente", "verificar cuenta", "contraseña", "banco"
Action: Quarantine + Alert admin

# Regula 2: Attachment type filtering
If: Attachment type is .exe, .js, .vbs, .scr, .bat, .cmd, .ps1
Action: Block + Replace with warning

# Regla 3: SPF/DKIM failure
If: SPF fails OR DKIM fails
Action: Mark as spam + Add header [SUSPECT]

# Regla 4: External sender warning
If: Sender is external AND contains internal links
Action: Add banner warning "CAUTION: External email"
```

#### User Training (Google Workspace)
- **Phishing alerts in Gmail:** Los usuarios ven advertencias automáticas
- **Report Phishing button:** Habilitar el botón "Report phishing" en Gmail
- **Regular simulations:** Programar simulaciones de phishing trimestrales

### 4. Configuración de Protección Adicional con Cloudflare Email Security
Si el cliente usa Cloudflare como DNS:
```
Cloudflare > Email > Email Security
- Enable DMARC management
- Configure email routing
- Set up anti-spoofing rules
- Enable domain spoofing protection
```

### 5. Monitoreo y Alertas

#### DMARC Reports
- Crear cuenta en dmarcian.com o Postmark DMARC
- Configurar `rua=mailto:dmarc-reports@clientdomain.com`
- Revisar informes semanalmente
- Identificar fuentes no autorizadas

#### Google Workspace Alerts
```
Admin Console > Rules > Alert Center
- Create alert for: Phishing attempts
- Create alert for: Suspicious login attempts
- Create alert for: Email forwarding rule changes
- Create admin activity alerts
```

### 6. Incident Response — Phishing Attack

Cuando se detecta un ataque de phishing:

1. **Contención inmediata**
   - Eliminar el correo de TODOS los buzones (Gmail Admin > Investigation)
   - Bloquear el dominio/remitente del atacante
   - Revocar sesiones de usuarios comprometidos
   - Forzar reset de contraseñas si hay credenciales robadas

2. **Investigación**
   - ¿Quién hizo clic en el enlace/phishing?
   - ¿Se ingresaron credenciales?
   - ¿Se descargaron archivos adjuntos?
   - Usar Google Investigation Tool para análisis

3. **Erradicación**
   - Eliminar reglas de reenvío maliciosas
   - Revocar tokens OAuth de apps no autorizadas
   - Verificar que no hay persistencia

4. **Comunicación**
   - Notificar a los usuarios afectados
   - Documentar el incidente
   - Reportar al equipo de seguridad del cliente

## Checklist de Seguridad de Correo
- [ ] SPF configurado y verificado
- [ ] DKIM activado y publicando
- [ ] DMARC en fase de monitoreo (mínimo)
- [ ] Google Workspace spam filters: Enhanced
- [ ] Attachment protection habilitado
- [ ] Impersonation protection habilitado
- [ ] OAuth apps auditadas y restringidas
- [ ] Email forwarding rules revisadas
- [ ] MFA habilitado para todos los usuarios
- [ ] DMARC reports siendo monitoreados
- [ ] Incident response plan para phishing documentado
- [ ] Capacitación anti-phishing programada
- [ ] Simulaciones de phishing trimestrales

## Terminología de Email Security
| Término | Definición |
|---|---|
| SPF | Sender Policy Framework — Autoriza servidores de envío |
| DKIM | DomainKeys Identified Mail — Firma digital de integridad |
| DMARC | Domain-based Message Authentication — Política + reportes |
| S/MIME | Cifrado de correo con certificados digitales |
| TLS | Transport Layer Security — Cifrado en tránsito |
| MTA-STS | Mail Transfer Agent Strict Transport Security |
| BIMI | Brand Indicators for Message Identification |
| SPAM | Correo no deseado |
| Phishing | Suplantación de identidad por email |
| Spear Phishing | Phishing dirigido a una persona/especie específica |
| Whaling | Phishing dirigido a ejecutivos de alto nivel |
| BEC | Business Email Compromise |
| VEC | Vendor Email Compromise |
| Spoofing | Falsificación del remitente |
| Harvesting | Recolección de direcciones de correo |
