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