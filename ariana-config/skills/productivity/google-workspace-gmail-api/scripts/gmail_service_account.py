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