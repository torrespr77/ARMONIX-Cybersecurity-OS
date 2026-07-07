#!/usr/bin/env python3
"""
Send a document via Telegram Bot API.
Usage: python3 send_document_telegram.py <document_path> [chat_id] [caption]
If chat_id not provided, uses default from .env (TELEGRAM_HOME_CHANNEL or 585583379)
If caption not provided, uses default.
"""
import os
import subprocess
import sys

def get_env_var(var_name, default=None):
    env_path = os.path.expanduser('~/.hermes/.env')
    try:
        with open(env_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line.startswith(f'{var_name}=') and not line.startswith('#'):
                    return line.split('=', 1)[1]
    except FileNotFoundError:
        pass
    return default

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 send_document_telegram.py <document_path> [chat_id] [caption]")
        sys.exit(1)
    
    document_path = sys.argv[1]
    if not os.path.exists(document_path):
        print(f"Error: Document not found at {document_path}")
        sys.exit(1)
    
    chat_id = sys.argv[2] if len(sys.argv) > 2 else get_env_var('TELEGRAM_HOME_CHANNEL', '585583379')
    caption = sys.argv[3] if len(sys.argv) > 3 else "Documento enviado por Hermes Agent"
    
    token = get_env_var('TELEGRAM_BOT_TOKEN')
    if not token:
        print("Error: TELEGRAM_BOT_TOKEN not found in ~/.hermes/.env")
        sys.exit(1)
    
    # Send document
    cmd = [
        'curl', '-s', '-X', 'POST',
        f'https://api.telegram.org/bot{token}/sendDocument',
        '-F', f'chat_id={chat_id}',
        '-F', f'caption={caption}',
        '-F', f'document=@{document_path}'
    ]
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        if result.returncode == 0:
            print("Success! Response:")
            print(result.stdout)
        else:
            print("Error:")
            print(result.stderr)
            sys.exit(result.returncode)
    except subprocess.TimeoutExpired:
        print("Error: Timeout sending document")
        sys.exit(1)

if __name__ == '__main__':
    main()