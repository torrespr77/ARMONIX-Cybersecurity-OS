#!/usr/bin/env python3
"""
BRIDA Gmail Operations
Funciones de alto nivel para uso diario.
Uso: from gmail_operations import send_email, list_messages, get_message
"""
from pathlib import Path
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email import encoders
import mimetypes
import base64
from typing import List, Dict, Optional

# Importar autenticación
import sys
sys.path.append(str(Path(__file__).parent))
from gmail_oauth import get_gmail_service
from gmail_service_account import get_gmail_service_as_user


def create_message(
    to: str,
    subject: str,
    body_text: str,
    body_html: str = None,
    from_email: str = 'me',
    attachments: List[str] = None
) -> Dict:
    """
    Crea mensaje codificado para Gmail API.
    """
    msg = MIMEMultipart('alternative' if body_html else 'mixed')
    msg['To'] = to
    msg['Subject'] = subject
    msg['From'] = from_email
    
    # Texto plano
    msg.attach(MIMEText(body_text, 'plain', 'utf-8'))
    
    # HTML
    if body_html:
        msg.attach(MIMEText(body_html, 'html', 'utf-8'))
    
    # Adjuntos
    if attachments:
        for file_path in attachments:
            path = Path(file_path)
            if not path.exists():
                print(f"⚠️  Adjunto no encontrado: {file_path}")
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
    
    # Gmail API requiere base64url encoding
    raw = base64.urlsafe_b64encode(msg.as_bytes()).decode()
    return {'raw': raw}


def send_email(
    to: str,
    subject: str,
    body_text: str,
    body_html: str = None,
    attachments: List[str] = None,
    user_email: str = 'me',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> Dict:
    """
    Envía email via Gmail API.
    
    Args:
        to: Destinatario
        subject: Asunto
        body_text: Cuerpo texto plano
        body_html: Cuerpo HTML (opcional)
        attachments: Lista de rutas a archivos
        user_email: 'me' o email específico (OAuth)
        use_service_account: Si True, usa Service Account
        impersonate_user: Usuario a impersonar (requerido si use_service_account)
    
    Returns:
        Dict con 'id', 'threadId', 'labelIds'
    """
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
        service = get_gmail_service()
    
    message = create_message(to, subject, body_text, body_html, user_email, attachments)
    result = service.users().messages().send(
        userId=user_email,
        body=message
    ).execute()
    
    print(f"✅ Email enviado a {to} — ID: {result['id']}")
    return result


def list_messages(
    query: str = '',
    max_results: int = 50,
    label_ids: List[str] = None,
    user_email: str = 'me',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> List[Dict]:
    """
    Lista mensajes con query Gmail.
    
    Query examples:
        - 'is:unread'
        - 'from:cliente@empresa.com'
        - 'subject:reporte'
        - 'has:attachment'
        - 'newer_than:7d'
    """
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
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


def get_message(
    message_id: str,
    user_email: str = 'me',
    format: str = 'full',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> Dict:
    """Obtiene mensaje completo por ID."""
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
        service = get_gmail_service()
    
    return service.users().messages().get(
        userId=user_email,
        id=message_id,
        format=format
    ).execute()


def get_message_body(message: Dict) -> Dict:
    """
    Extrae cuerpo (texto plano y HTML) de mensaje Gmail.
    Retorna: {'text': str, 'html': str}
    """
    result = {'text': '', 'html': ''}
    
    def extract_parts(payload):
        if 'parts' in payload:
            for part in payload['parts']:
                extract_parts(part)
        else:
            mime_type = payload.get('mimeType', '')
            data = payload.get('body', {}).get('data', '')
            if data:
                decoded = base64.urlsafe_b64decode(data).decode('utf-8', errors='ignore')
                if mime_type == 'text/plain':
                    result['text'] += decoded
                elif mime_type == 'text/html':
                    result['html'] += decoded
    
    extract_parts(message.get('payload', {}))
    return result


def create_label(
    name: str,
    user_email: str = 'me',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> Dict:
    """Crea label en Gmail."""
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
        service = get_gmail_service()
    
    label_body = {
        'name': name,
        'labelListVisibility': 'labelShow',
        'messageListVisibility': 'show'
    }
    return service.users().labels().create(
        userId=user_email,
        body=label_body
    ).execute()


def apply_label(
    message_id: str,
    label_name: str,
    user_email: str = 'me',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> Dict:
    """Aplica label existente a mensaje."""
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
        service = get_gmail_service()
    
    # Buscar label ID
    labels = service.users().labels().list(userId=user_email).execute()
    label_id = next(
        (l['id'] for l in labels.get('labels', []) if l['name'] == label_name),
        None
    )
    if not label_id:
        raise ValueError(f"Label '{label_name}' no existe. Créala primero.")
    
    return service.users().messages().modify(
        userId=user_email,
        id=message_id,
        body={'addLabelIds': [label_id]}
    ).execute()


def archive_message(
    message_id: str,
    user_email: str = 'me',
    use_service_account: bool = False,
    impersonate_user: str = None
) -> Dict:
    """Archiva mensaje (quita INBOX)."""
    if use_service_account:
        service = get_gmail_service_as_user(impersonate_user or user_email)
    else:
        service = get_gmail_service()
    
    return service.users().messages().modify(
        userId=user_email,
        id=message_id,
        body={'removeLabelIds': ['INBOX']}
    ).execute()


# ===== EJEMPLOS =====
if __name__ == '__main__':
    # 1. Enviar email simple (OAuth interactivo)
    print("=== Test OAuth ===")
    send_email(
        to='roger@brida.it',
        subject='Test BRIDA Gmail API — OAuth',
        body_text='Funciona perfecto! 🚀\n\n— Roger',
        body_html='<h2>Test BRIDA</h2><p>Funciona perfecto! 🚀</p><p>— Roger</p>'
    )
    
    # 2. Buscar emails no leídos
    print("\n=== Buscar no leídos ===")
    msgs = list_messages(query='is:unread', max_results=5)
    for msg in msgs:
        full = get_message(msg['id'])
        body = get_message_body(full)
        print(f"  - {full['snippet'][:80]}...")
    
    # 3. Crear label y aplicar
    # create_label('BRIDA/Test')
    # apply_label(msgs[0]['id'], 'BRIDA/Test')