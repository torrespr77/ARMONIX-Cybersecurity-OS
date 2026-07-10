# GitHub Backup Procedure — Ariana Agent Config Sync

## Overview

Every Friday at 10:00 AM, the Weekly Health Check runs `~/scripts/sync-to-github.sh` 
to push ALL Ariana configuration to the private repo `torrespr77/Cybersecurity`.

## What Gets Backed Up

| Component | Source | Destination |
|---|---|---|
| SOUL.md | ~/.hermes/SOUL.md | ariana-config/SOUL.md |
| MEMORY.md | ~/.hermes/MEMORY.md | ariana-config/MEMORY.md |
| USER.md | ~/.hermes/USER.md | ariana-config/USER.md |
| memories/MEMORY.md | ~/.hermes/memories/MEMORY.md | ariana-config/memories-MEMORY.md |
| memories/USER.md | ~/.hermes/memories/USER.md | ariana-config/memories-USER.md |
| config.yaml | ~/.hermes/config.yaml | ariana-config/config.yaml.sanitized |
| cron/jobs.json | ~/.hermes/cron/jobs.json | ariana-config/cron-jobs.json |
| skills/ (130) | ~/.hermes/skills/ | ariana-config/skills/ |
| scripts/ (~6) | ~/scripts/ | ariana-config/scripts/ |

## What NEVER Gets Backed Up

- `.env` — contains live API tokens (Telegram, Tavily, OpenRouter)
- `auth.json` — contains provider authentication
- `state.db` — SQLite conversation history
- `logs/` — ephemeral operational logs
- `hermes-agent/` — framework source code (official Nous Research repo)

## Sanitization

The script applies 12 sed patterns to config.yaml before pushing:
- `api_key`, `token`, `password`, `secret` → `***REDACTED***`
- Known token formats: `sk-*`, `AKIA*`, `ghp_*`, Telegram tokens (`NNNN:AAAA...`)

## Script Location

```
~/scripts/sync-to-github.sh
```

## Manual Execution

```bash
bash ~/scripts/sync-to-github.sh
```

## Key Variables

- `REPO_DIR` = `~/brida-security-project`
- `HERMES_DIR` = `~/.hermes`
- Git identity: Roger Torres <torrespr77@users.noreply.github.com>
- Auth: SSH deploy key (~/.ssh/id_ed25519)

## Commit Format

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

If no changes since last sync, script exits silently without commit.

## Pitfalls

- **sed regex compatibility**: Use `[[:space:]]` instead of `\s` in sed patterns — some sed versions don't support `\s`.
- **Git identity**: Must be configured at repo level: `git config user.name "Roger Torres" && git config user.email "torrespr77@users.noreply.github.com"`. Without it, git commit fails with "Author identity unknown".
- **Bash IFS with multi-char delimiters**: `IFS='@@@'` does NOT work as a string delimiter in bash — bash treats each `@` as a separate single-char delimiter. Use Python instead for multi-field parsing.
- **Python subprocess `~` expansion**: `~` is NOT expanded by subprocess.run(shell=True). Use `$HOME` instead in commands passed to subprocess.
- **NEVER run `hermes gateway restart` from within the agent** — it auto-SIGTERMs the agent process. Run from a separate terminal.

## Verification Post-Sync

```bash
# Verify no secrets leaked
grep -iE "(api_key|token|password|secret)" \
    ~/brida-security-project/ariana-config/config.yaml.sanitized
# Should show only ***REDACTED***

# Verify .env not in repo
find ~/brida-security-project/ariana-config -name ".env" -o -name "auth.json"
# Should show nothing

# Verify skills count
find ~/brida-security-project/ariana-config/skills -name "SKILL.md" | wc -l
# Should be 130
```

## Disaster Recovery

See: Runbook_Respaldo_Ariana_GitHub_v1.0.0.docx (generated July 2026)
Full restore instructions in: `ariana-config/README.md` on GitHub.
