---
name: google-workspace-gmail-api
description: "Complete guide for Google Workspace Gmail API setup, authentication, and usage. Covers Google Cloud Console, OAuth 2.0, Service Accounts, scopes, Python implementation, and BRIDA-specific patterns."
version: 1.0.0
author: Hermes Agent (Ariana)
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [google, workspace, gmail, api, oauth, service-account, python, automation]
    related_skills: [productivity, cybersecurity-brida]
---

# Google Workspace Gmail API — Guía Completa BRIDA

Guía end-to-end para configurar y usar Gmail API en proyectos BRIDA IT Services.

---

## 1. Prerrequisitos

| Requisito | Detalle |
|-----------|---------|
| **Cuenta Google Workspace** | Admin access (super admin o groups admin) |
| **Google Cloud Project** | Nuevo o existente |
| **Facturación habilitada** | Requerida para APIs (aunque Gmail API tiene free tier generoso) |
| **Python 3.8+** | Con `google-auth`, `google-auth-oauthlib`, `google-auth-httplib2`, `google-api-python-client` |

---

## 2. Paso a Paso: Google Cloud Console

### 2.1 Crear/Seleccionar Proyecto

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Click en selector de proyecto (arriba a la izquierda) → **Nuevo proyecto**
3. Nombre: `brida-gmail-api` (o similar)
4. Organización: Selecciona tu org Workspace
5. **Crear**

### 2.2 Habilitar Gmail API

1. En el menú lateral: **APIs y servicios** → **Biblioteca**
2. Busca: `Gmail API`
3. Click en **Gmail API** → **Habilitar**

> **Nota:** También habilita **Google Workspace Admin SDK** si necesitas gestión de usuarios/grupos.

### 2.3 Configurar Pantalla de Consentimiento OAuth

1. **APIs y servicios** → **Pantalla de consentimiento OAuth**
2. **Tipo de usuario**: **Interno** (solo usuarios de tu org Workspace) — *Recomendado para BRIDA*
   - Si necesitas acceso externo: **Externo** + verificación de Google
3. Completa:
   - Nombre de la app: `BRIDA Gmail Automation`
   - Email de soporte: `roger@brida.it` (o tu email)
   - Logo: Opcional
   - Dominios autorizados: `brida.it` (tu dominio)
   - Email de contacto del desarrollador: `roger@brida.it`
4. **Guardar y continuar**

### 2.4 Scopes (Ámbitos) Requeridos

| Scope | Uso | Sensibilidad |
|-------|-----|--------------|
| `https://www.googleapis.com/auth/gmail.readonly` | Leer mensajes, labels, threads | Baja |
| `https://www.googleapis.com/auth/gmail.send` | Enviar emails | Media |
| `https://www.googleapis.com/auth/gmail.modify` | Leer + modificar (archivar, etiquetar, borrar) | Media |
| `https://www.googleapis.com/auth/gmail.compose` | Crear borradores | Media |
| `https://www.googleapis.com/auth/gmail.labels` | Gestionar labels | Baja |
| `https://www.googleapis.com/auth/gmail.settings.basic` | Config básica (firma, vacation) | Alta |
| `https://www.googleapis.com/auth/gmail.settings.sharing` | Config forwarding, delegación | Alta |
| `https://www.googleapis.com/auth/admin.directory.user` | Admin SDK - leer usuarios | Alta |
| `https://www.googleapis.com/auth/admin.directory.group` | Admin SDK - leer grupos | Alta |

**Para BRIDA (automatización emails + lectura):** Usa:
```
https://www.googleapis.com/auth/gmail.send
https://www.googleapis.com/auth/gmail.readonly
https://www.googleapis.com/auth/gmail.labels
```

### 2.5 Crear Credenciales

#### Opción A: OAuth 2.0 Client ID (User Delegation) — **Recomendado para scripts interactivos**

1. **Credenciales** → **Crear credenciales** → **ID de cliente OAuth**
2. Tipo: **Aplicación de escritorio** (Desktop app)
3. Nombre: `BRIDA Gmail Desktop Client`
4. **Crear** → Descarga `client_secret_XXXX.json`
5. Guarda en: `~/.config/brida/gmail/client_secret.json`

#### Opción B: Service Account (Domain-Wide Delegation) — **Para automatización server-side sin usuario**

1. **Credenciales** → **Crear credenciales** → **Cuenta de servicio**
2. Nombre: `brida-gmail-automation`
3. ID: `brida-gmail-automation@brida-gmail-api.iam.gserviceaccount.com`
4. **Crear y continuar**
5. Roles: **Sin roles** (usamos domain-wide delegation)
6. **Listo**
7. En la cuenta de servicio creada → **Claves** → **Agregar clave** → **Crear nueva clave** → **JSON**
8. Descarga: `service_account_XXXX.json`
9. Guarda en: `~/.config/brida/gmail/service_account.json`

#### Configurar Domain-Wide Delegation (Solo Service Account)

1. En la cuenta de servicio → **Detalles** → Copia **ID único** (número largo)
2. Ve a **Admin Console** de Google Workspace: `admin.google.com`
3. **Seguridad** → **Acceso y control de datos** → **Controles de API** → **Delegación de todo el dominio**
4. **Administrar delegación de todo el dominio** → **Agregar nuevo**
   - ID de cliente: *Pega el ID único de la service account*
   - Scopes OAuth: *Pega los scopes separados por comas*
     ```
     https://www.googleapis.com/auth/gmail.send,https://www.googleapis.com/auth/gmail.readonly,https://www.googleapis.com/auth/gmail.labels
     ```
5. **Autorizar**

---

## 3. Instalación Python

```bash
# En tu venv del proyecto
uv pip install \
  google-auth \
  google-auth-oauthlib \
  google-auth-httplib2 \
  google-api-python-client \
  googleapis-common-protos
```

---

## 4. Implementación Python — Patrones BRIDA

### 4.1 Autenticación OAuth (User) — `gmail_oauth.py`

```python
#!/usr/bin/env python3
"""
BRIDA Gmail OAuth Authentication
Uso: from gmail_oauth import get_gmail_service
"""
import os
import json
from pathlib import Path
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

# Scopes BRIDA
SCOPES = [
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/gmail.labels',
]

CONFIG_DIR = Path.home() / '.config' / 'brida' / 'gmail'
TOKEN_FILE = CONFIG_DIR / 'token.json'
CLIENT_SECRET_FILE = CONFIG_DIR / 'client_secret.json'


def get_credentials() -> Credentials:
    """Obtiene credenciales válidas (refresh automático)."""
    creds = None
    
    if TOKEN_FILE.exists():
        creds = Credentials.from_authorized_user_file(str(TOKEN_FILE), SCOPES)
    
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            if not CLIENT_SECRET_FILE.exists():
                raise FileNotFoundError(
                    f"Falta {CLIENT_SECRET_FILE}. Descárgalo de Google Cloud Console."
                )
            flow = InstalledAppFlow.from_client_secrets_file(
                str(CLIENT_SECRET_FILE), SCOPES
            )
            creds = flow.run_local_server(port=0)
        
        # Guardar token para próxima vez
        CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        with open(TOKEN_FILE, 'w') as f:
            f.write(creds.to_json())
    
    return creds


def get_gmail_service():
    """Retorna servicio Gmail API autenticado."""
    creds = get_credentials()
    return build('gmail', 'v1', credentials=creds)


# Test rápido
if __name__ == '__main__':
    service = get_gmail_service()
    profile = service.users().getProfile(userId='me').execute()
    print(f"✅ Conectado como: {profile['emailAddress']}")
    print(f"   Messages total: {profile['messagesTotal']}")
    print(f"   Threads total: {profile['threadsTotal']}")
```

### 4.2 Autenticación Service Account — `gmail_service_account.py`

```python
#!/usr/bin/env python3
"""
BRIDA Gmail Service Account Authentication
Para automatización server-side (cron, workers, etc.)
Uso: from gmail_service_account import get_gmail_service_as_user
"""
from pathlib import Path
from google.oauth2 import service_account
from googleapiclient.discovery import build

SCOPES = [
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/gmail.labels',
]

SERVICE_ACCOUNT_FILE = Path.home() / '.config' / 'brida' / 'gmail' / 'service_account.json'
ADMIN_USER = 'roger@brida.it'  # Usuario que delega acceso (super admin)


def get_gmail_service_as_user(user_email: str = None):
    """
    Retorna servicio Gmail API actuando como `user_email` (domain-wide delegation).
    Requiere: Service Account con Domain-Wide Delegation configurado en Admin Console.
    """
    if not SERVICE_ACCOUNT_FILE.exists():
        raise FileNotFoundError(
            f"Falta {SERVICE_ACCOUNT_FILE}. Configura Service Account + Domain-Wide Delegation."
        )
    
    target_user = user_email or ADMIN_USER
    
    credentials = service_account.Credentials.from_service_account_file(
        str(SERVICE_ACCOUNT_FILE),
        scopes=SCOPES,
        subject=target_user  # ¡Clave! Impersona a este usuario
    )
    
    return build('gmail', 'v1', credentials=credentials)


if __name__ == '__main__':
    # Test como admin
    service = get_gmail_service_as_user('roger@brida.it')
    profile = service.users().getProfile(userId='me').execute()
    print(f"✅ Service Account actuando como: {profile['emailAddress']}")
```

### 4.3 Operaciones Comunes — `gmail_operations.py`

```python
#!/usr/bin/env python3
"""
BRIDA Gmail Operations — Funciones listas para usar.
"""
from typing import List, Dict, Optional
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders
import base64
import mimetypes
from pathlib import Path

# Importa Path
from gmail_oauth import get_gmail_service  # o gmail_service_account


def create_message(
    to: str,
    subject: str,
    body_text: str,
    body_html: str = None,
    attachments: List[str] = None,
    from_email: str = 'me'
) -> Dict:
    """Crea mensaje MIME codificado en base64url para Gmail API."""
    msg = MIMEMultipart('alternative')
    msg['To'] = to
    msg['Subject'] = subject
    msg['From'] = from_email
    
    # Parte texto plano
    msg.attach(MIMEText(body_text, 'plain'))
    
    # Parte HTML (opcional)
    if body_html:
        msg.attach(MIMEText(body_html, 'html'))
    
    # Adjuntos
    if attachments:
        for file_path in attachments:
            path = Path(file_path)
            if not path.exists():
                continue
            
            ctype, _ = mimetypes.guess_type(str(path))
            if ctype is None:
                ctype = 'application/octet-stream'
            maintype, subtype = ctype.split('/', 1)
            
            with open(path, 'rb') as f:
                part = MIMEBase(maintype, subtype)
                part.set_payload(f.read())
            encoders.encode_base64(part)
            part.add_header(
                'Content-Disposition',
                f'attachment; filename="{path.name}"'
            )
            msg.attach(part)
    
    # Codificar para Gmail API
    raw = base64.urlsafe_b64encode(msg.as_bytes()).decode()
    return {'raw': raw}


def send_email(
    to: str,
    subject: str,
    body_text: str,
    body_html: str = None,
    attachments: List[str] = None,
    user_email: str = 'me'
) -> Dict:
    """Envía email via Gmail API."""
    service = get_gmail_service()
    message = create_message(to, subject, body_text, body_html, attachments)
    return service.users().messages().send(userId=user_email, body=message).execute()


def list_messages(
    query: str = '',
    max_results: int = 50,
    label_ids: List[str] = None,
    user_email: str = 'me'
) -> List[Dict]:
    """Lista mensajes con query Gmail (ej: 'is:unread from:cliente@empresa.com')."""
    service = get_gmail_service()
    params = {
        'userId': user_email,
        'maxResults': max_results,
        'q': query
    }
    if label_ids:
        params['labelIds'] = label_ids
    
    results = service.users().messages().list(**params).execute()
    return results.get('messages', [])


def get_message(message_id: str, user_email: str = 'me', format: str = 'full') -> Dict:
    """Obtiene mensaje completo por ID."""
    service = get_gmail_service()
    return service.users().messages().get(
        userId=user_email, id=message_id, format=format
    ).execute()


def create_label(name: str, user_email: str = 'me') -> Dict:
    """Crea label en Gmail."""
    service = get_gmail_service()
    label_body = {
        'name': name,
        'labelListVisibility': 'labelShow',
        'messageListVisibility': 'show'
    }
    return service.users().labels().create(userId=user_email, body=label_body).execute()


def apply_label(message_id: str, label_name: str, user_email: str = 'me') -> Dict:
    """Aplica label existente a mensaje."""
    service = get_gmail_service()
    # Buscar label ID
    labels = service.users().labels().list(userId=user_email).execute()
    label_id = next((l['id'] for l in labels.get('labels', []) if l['name'] == label_name), None)
    if not label_id:
        raise ValueError(f"Label '{label_name}' no existe")
    
    return service.users().messages().modify(
        userId=user_email,
        id=message_id,
        body={'addLabelIds': [label_id]}
    ).execute()


def archive_message(message_id: str, user_email: str = 'me') -> Dict:
    """Archiva mensaje (quita INBOX)."""
    service = get_gmail_service()
    return service.users().messages().modify(
        userId=user_email,
        id=message_id,
        body={'removeLabelIds': ['INBOX']}
    ).execute()


# ===== EJEMPLOS DE USO =====
if __name__ == '__main__':
    # 1. Enviar email simple
    result = send_email(
        to='cliente@empresa.com',
        subject='Reporte de Seguridad BRIDA - Julio 2026',
        body_text='Hola,\n\nAdjunto reporte...\n\nSaludos,\nRoger',
        body_html='<h2>Reporte de Seguridad</h2><p>Hola,<br>Adjunto reporte...</p>'
    )
    print(f"✅ Enviado: {result['id']}")
    
    # 2. Buscar emails no leídos de un dominio
    messages = list_messages(query='is:unread from:@pollopepe.com', max_results=10)
    for msg in messages:
        full = get_message(msg['id'])
        print(f"  - {full['snippet'][:80]}...")
    
    # 3. Crear y aplicar label
    create_label('BRIDA/Reportes')
    apply_label(messages[0]['id'], 'BRIDA/Reportes')
```

---

## 5. Estructura de Archivos BRIDA

```
~/.config/brida/gmail/
├── client_secret.json      # OAuth Client ID (desktop app)
├── service_account.json    # Service Account key (si usas DW delegation)
└── token.json              # Auto-generado tras primer OAuth flow
```

**Permisos:**
```bash
chmod 700 ~/.config/brida/gmail
chmod 600 ~/.config/brida/gmail/*.json
```

---

## 6. Testing & Verificación

### Test OAuth (interactivo):
```bash
python3 gmail_oauth.py
# Debería abrir browser → autorizar → mostrar perfil
```

### Test Service Account:
```bash
python3 gmail_service_account.py
# Debería mostrar perfil del usuario impersonado
```

### Test Envío Real:
```bash
python3 -c "
from gmail_operations import send_email
send_email(
    to='roger@brida.it',
    subject='Test BRIDA Gmail API',
    body_text='Funciona! 🚀'
)
"
```

---

## 7. Troubleshooting Común

| Error | Causa | Solución |
|-------|-------|----------|
| `invalid_grant: Bad Request` | Token expirado/revocado | Borra `token.json` y re-autentica |
| `access_denied` | Usuario no autorizado en consent screen | Añade usuario en "Usuarios de prueba" (si app Externa) |
| `insufficient_permissions` | Scopes faltantes | Añade scopes en OAuth consent + re-autentica |
| `delegation_not_allowed` | Service Account sin DW delegation | Configura en Admin Console → Seguridad → Controles API |
| `user_not_found` | Email incorrecto en `subject` | Verifica email existe en Workspace |
| `quotaExceeded` | Límite diario API | Gmail API: 1B reads/día, 100 sends/usuario/seg. Implementa backoff exponencial |

---

## 8. Límites y Cuotas (Gmail API)

| Límite | Valor |
|--------|-------|
| **Lecturas/día** | 1,000,000,000 (1B) |
| **Envíos/usuario/segundo** | 100 |
| **Envíos/día/usuario** | ~10,000 (variable) |
| **Adjuntos/email** | 25 MB total |
| **Batch requests** | 100 calls/batch |

> **Best Practice BRIDA:** Implementa rate limiting local (ej: `time.sleep(0.1)` entre sends) y exponential backoff en errores 429/5xx.

---

## 9. Seguridad BRIDA

- **NUNCA** commitees `client_secret.json`, `service_account.json`, `token.json` a Git
- Añade a `.gitignore`:
  ```
  ~/.config/brida/gmail/
  *.json
  token.json
  ```
- Usa **Secret Manager** (AWS/GCP/Azure) o variables de entorno en producción
- Rota service account keys cada 90 días
- Audita domain-wide delegation trimestralmente

---

## 10. Referencias

- [Gmail API Reference](https://developers.google.com/gmail/api/reference/rest)
- [OAuth 2.0 for Desktop Apps](https://developers.google.com/identity/protocols/oauth2/native-app)
- [Domain-Wide Delegation](https://developers.google.com/identity/protocols/oauth2/service-account#domain-wide-delegation)
- [Python Client Library](https://github.com/googleapis/google-api-python-client)
- [Scopes Gmail](https://developers.google.com/gmail/api/auth/scopes)

---

## 11. Checklist Rápido BRIDA

- [ ] Proyecto GCP creado
- [ ] Gmail API habilitada
- [ ] Pantalla consentimiento OAuth configurada (Interno)
- [ ] Scopes añadidos
- [ ] OAuth Client ID (Desktop) creado → `client_secret.json` guardado
- [ ] **O** Service Account + Domain-Wide Delegation configurado
- [ ] Python deps instaladas
- [ ] `gmail_oauth.py` probado → token generado
- [ ] Envío de prueba exitoso
- [ ] Credenciales en `.gitignore`
- [ ] Documentado en runbook del proyecto