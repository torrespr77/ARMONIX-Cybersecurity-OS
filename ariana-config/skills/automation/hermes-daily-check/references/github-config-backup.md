# GitHub Config Backup Reference

## Overview

The Hermes Weekly Health Check ( Fridays 10 AM) includes a full configuration backup 
to the private GitHub repo `torrespr77/Cybersecurity` under `ariana-config/`.

## Script: ~/scripts/sync-to-github.sh

### Architecture
```
~/.hermes/ (source) → /tmp/staging/ (sanitized) → ~/brida-security-project/ (git) → GitHub
```

### What gets backed up
- SOUL.md, MEMORY.md, USER.md (identity)
- memories/MEMORY.md, memories/USER.md (persistent stores)
- config.yaml (SANITIZED — 12 sed patterns replace secrets with ***REDACTED***)
- cron/jobs.json (cron job definitions)
- skills/ (ALL: 20 active + 110 .archive = 130 total)
- scripts/ (~6 operational scripts)
- README.md (auto-generated with stats + restore instructions)

### Sanitization Patterns (12 total)
| Pattern | Regex | Replacement |
|---|---|---|
| api_key | `s/(api_key\s*:\s*).+/\1***REDACTED***/` | api_key: ***REDACTED*** |
| api-key | `s/(api[-_]?key\s*:\s*).+/\1***REDACTED***/` | api-key: ***REDACTED*** |
| token | `s/(token\s*:\s*).+/\1***REDACTED***/` | token: ***REDACTED*** |
| password | `s/(password\s*:\s*).+/\1***REDACTED***/` | password: ***REDACTED*** |
| secret | `s/(secret\s*:\s*).+/\1***REDACTED***/` | secret: ***REDACTED*** |
| API_KEY (env) | `s/(API_KEY\s*[:=]\s*).+/\1***REDACTED***/` | API_KEY=***REDACTED*** |
| TOKEN (env) | `s/(TOKEN\s*[:=]\s*).+/\1***REDACTED***/` | TOKEN=***REDACTED*** |
| OpenAI (sk-) | `s/(sk-[A-Za-z0-9]{20,})/***REDACTED***/` | ***REDACTED*** |
| AWS (AKIA) | `s/(AKIA[A-Z0-9]{16})/***REDACTED***/` | ***REDACTED*** |
| GitHub (ghp_) | `s/(gh[pousr]_[A-Za-z0-9]{36})/***REDACTED***/` | ***REDACTED*** |
| Telegram token | `s/([0-9]{8,10}:[A-Za-z0-9_-]{30,})/***REDACTED***/` | ***REDACTED*** |

**Important:** Use `[[:space:]]` in sed regex, NOT `\s` — some sed implementations don't support `\s`.

### What is NEVER backed up
- `.env` — contains live tokens (Telegram, Tavily, provider keys)
- `auth.json` — provider authentication
- `state.db` — conversation history (SQLite)
- `logs/`, `backups/`, `*_cache.json` — ephemeral/regenerable
- `hermes-agent/` — framework source (official Nous Research repo)

### Commit Format
```
backup: ariana-config weekly sync

- Skills: 20 active, 110 archived (130 total)
- Memory store: N chars
- User store: N chars
- Scripts: N files
- Config: sanitized (secrets redacted)
- Changed files: N
- Generated: YYYY-MM-DD HH:MM:SS
```

If no changes since last sync → silent exit (no commit).

### Git Setup
- Repo: `git@github.com:torrespr77/Cybersecurity.git` (SSH, deploy key)
- Local: `~/brida-security-project/`
- Identity: `git config user.name "Roger Torres"` / `git config user.email "torrespr77@users.noreply.github.com"` (per-repo, not global)
- Deploy key: `~/.ssh/id_ed25519`

### Disaster Recovery (9 steps)
1. `git clone git@github.com:torrespr77/Cybersecurity.git ~/brida-security-project`
2. `cp ariana-config/SOUL.md ~/.hermes/` (+ USER.md, MEMORY.md)
3. `cp ariana-config/memories-*.md ~/.hermes/memories/`
4. `rsync -av ariana-config/skills/ ~/.hermes/skills/`
5. `cp ariana-config/scripts/* ~/scripts/ && chmod +x`
6. `cp ariana-config/config.yaml.sanitized ~/.hermes/config.yaml` → **manually fill in secrets**
7. Recreate cron jobs from `cron-jobs.json`
8. Recreate `.env` manually (NOT in backup)
9. `hermes gateway restart`

### Verification Post-Sync
```bash
# Check no secrets leaked
grep -iE "(api_key|token|password|secret)" ariana-config/config.yaml.sanitized
# Should show only ***REDACTED***

# Check .env not in repo
find ariana-config -name ".env" -o -name "auth.json"
# Should show nothing

# Check last commit
cd ~/brida-security-project && git log --oneline -3
```

## Tool Version Check: ~/scripts/check-tool-versions.py

### Overview
Compares 15 critical pentest tools' local versions vs GitHub latest releases.

### Tools Monitored
nuclei, sqlmap, nmap, nikto, whatweb, testssl, hydra, gobuster, ffuf, wpscan, httpx, subfinder, amass, waybackurls, assetfinder

### How it works
1. Runs local version command (e.g., `nuclei -version`)
2. Queries GitHub API: `releases/latest` endpoint
3. Falls back to `tags` endpoint if no release found
4. Compares normalized versions (strips `v` prefix)
5. Reports: ✅ up-to-date | ⚠️ update available | ℹ️ API unavailable

### Known Quirks
- **testssl.sh**: `--version` is interactive, may not return parseable output. Script tries `$HOME/tools/testssl.sh/testssl.sh`.
- **httpx**: The binary in `~/.local/bin/httpx` may be Python httpx, not ProjectDiscovery httpx. Check with `httpx -version` — if it shows "Usage" instead of version, it's the wrong binary.
- **waybackurls/assetfinder**: Go tools that don't implement `-version` flag. Script uses `which` to verify installation.
- **GitHub API rate limiting**: 60 req/hour without authentication. If rate-limited, tool shows ℹ️.
- **nmap**: No GitHub releases (uses SVN). API may return empty.

### Port 9119 — Hermes Dashboard (SAFE)
Port 9119 is the Hermes Dashboard, manually started by Roger. Marked as safe — no alert in health checks.
