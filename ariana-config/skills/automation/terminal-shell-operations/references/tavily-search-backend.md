# Tavily Search Backend Configuration

## Overview

Hermes Agent supports **Tavily** as a web search backend. When `web.search_backend` is configured, the `web_search` tool routes queries through Tavily's API instead of Hermes's built-in search.

## Prerequisites

- Tavily API key (https://app.tavily.com — free tier: 1000 searches/month)
- Key format: `tvly-xxxxxxxxxxxxxxxx`

## Configuration Steps

### 1. Set API Key in `.env`

```bash
# Add or update the key in .env
python3 -c "
import re
path = '/home/hermes/.hermes/.env'
with open(path, 'r') as f:
    content = f.read()
new_content = re.sub(
    r'^(TAVILY_API_KEY=)(.*)$',
    r'\1tvly-NEW_KEY_HERE',
    content,
    flags=re.MULTILINE
)
with open(path, 'w') as f:
    f.write(new_content)
print('TAVILY_API_KEY updated')
"
```

### 2. Configure Search Backend

```bash
# Set Tavily as the search backend
hermes config set web.search_backend tavily

# Verify
hermes config get web.search_backend
```

### 3. Restart Gateway

```bash
# From a SEPARATE terminal (not from within the agent session)
hermes gateway restart
```

**Critical:** Do NOT run `hermes gateway restart` from within your own session — it causes a SIGTERM to the current agent process.

### 4. Verify

```bash
# Check config
hermes config get web.search_backend
# Expected output: tavily

# Test search (from a new session after restart)
hermes chat -q "test search query"
```

## Troubleshooting

### "Unauthorized: missing or invalid API key"

**Cause:** The API key in `.env` is invalid, revoked, or not set.

**Fix:**
```bash
# Verify key exists in .env
grep "^TAVILY_API_KEY=" ~/.hermes/.env

# Test key directly against Tavily API
curl -s -X POST "https://api.tavily.com/search" \
  -H "Content-Type: application/json" \
  -d '{"api_key":"tvly-YOUR_KEY","query":"test","max_results":1}'
```

If this returns `{"detail":{"error":"Unauthorized"}}`, the key is invalid — Roger needs to generate a new one at https://app.tavily.com.

### `hermes status` shows Tavily key but search returns 404/401

**Cause:** The key loaded by Hermes may be stale/revoked. Hermes reads the key from `.env` at startup. If Roger rotated the key but didn't restart the gateway, the old key is still in memory.

**Fix:** Update `.env` with the new key, then restart gateway from a separate terminal.

### `web_search` works but returns Hermes results, not Tavily

**Cause:** `web.search_backend` is set to `''` (empty string), which means Hermes uses its built-in search, not Tavily.

**Fix:**
```bash
hermes config set web.search_backend tavily
# Then restart gateway
```

### Config check shows empty values

If `hermes config` shows:
```yaml
web:
  backend: ''
  search_backend: ''
  extract_backend: ''
```
This means no external search backend is configured. The `web_search` tool uses Hermes's own search (which may use a different internal mechanism).

## Key Config Reference

| Config Key | Value | Effect |
|------------|-------|--------|
| `web.search_backend` | `tavily` | Route all web_search through Tavily API |
| `web.search_backend` | `''` (empty) | Use Hermes built-in search |
| `web.backend` | `tavily` | Legacy key — may also work |
| `TAVILY_API_KEY` | `tvly-xxx` | API key in .env, read at gateway startup |

## Pitfalls

1. **Key rotation requires gateway restart** — Hermes loads the key at startup, not on every request
2. **Secret redaction masks the key** — `cat ~/.hermes/.env` shows `tvly-***`. Use Python or `source` to read the real value
3. **Tavily free tier limit** — 1000 searches/month. For heavy usage, upgrade or use Hermes built-in search as fallback
4. **Gateway restart from agent = SIGTERM** — always ask Roger to restart from a separate terminal
