---
name: hermes-backup
description: "Procedures for backing up and restoring Hermes Agent configuration, skills, tools, and environment. Includes scripted backups, cron jobs, and restoration steps."
version: 1.3.0
author: Hermes Agent
license: MIT
platforms: [linux]
---
# Hermes Backup & Restore Procedures

This skill provides a complete, repeatable process for backing up the Hermes Agent environment and restoring it on a new or rebuilt system. It covers the critical data identified in the Hermes documentation: configuration, state database, skills, plugins, cron jobs, memories, profiles, sessions, logs, user scripts, tools, shell environment, and SSH keys.

## 📦 What Is Backed Up

| Category | Paths Included | Purpose |
|----------|----------------|---------|
| Hermes Core | `~/.hermes/config.yaml`, `~/.hermes/state.db` | Agent configuration and runtime state |
| Skills & Plugins | `~/.hermes/skills/`, `~/.hermes/plugins/` | Custom skills and desktop/plugins |
| Automation | `~/.hermes/cron/` | Scheduled jobs (health‑check, backup, cleanup, quarterly review) |
| Memory & Profiles | `~/.hermes/memories/`, `~/.hermes/profiles/` | Persistent user data, multiple profiles |
| Session & Logs | `~/.hermes/sessions/`, `~/.hermes/logs/` | Conversation history and debug logs |
| User Scripts | `~/scripts/` | Custom helper scripts (e.g., web‑recon‑v2.sh, osint‑complete.sh) |
| User Tools | `~/tools/` | Manually installed pentesting utilities |
| User Binaries | `~/.local/bin/`, `~/go/bin/`, `~/.cargo/bin/` | Wrappers and binaries installed via uv, Go, Cargo |
| Shell Environment | `~/.bashrc`, `~/.zshrc`, `~/.profile`, `~/.bash_profile`, `~/.zprofile` | Environment variables, aliases, PATH |
| SSH Keys | `~/.ssh/` | Private/public keys for Git and remote access |

## 🛠️ Backup Script

The canonical backup script is located at:

```
~/scripts/backup_Completo.sh
```

It creates a timestamped tarball in `~/.hermes/backups/`:

```
hermes_backup_YYYYMMDD_HHMMSS.tar.gz
```

**Key improvements (v1.3.0):**

- **Lockfile** (`/tmp/hermes_backup.lock`) prevents concurrent runs.
- **Dynamic include list**: only existing paths are added, so missing directories (e.g., `~/.hermes/profiles`) are safely skipped.
- **Parallel compression**: uses `pigz` if available, otherwise falls back to `gzip` for speed.
- **Retention policy**: keeps only the most recent `$RETENTION` backups (default 3) and deletes older ones automatically.
- **Logging**: each run appends a line to `~/.hermes/backup.log` with timestamp, status (OK/ERROR), and file size.
- **Nice/ionice**: the script can be prefixed with `nice -n 10 ionice -c2 -n7` to reduce system impact during backups.
- **Robust error handling**: checks that the archive was created successfully before logging size; removes partial/invalid archives on failure.

**Script invocation (manual or via cron):**

```bash
bash /home/hermes/scripts/backup_Completo.sh
```

## ⏰ Cron Job

A weekly cron job executes the backup script:

- **ID:** `f93a5953e431` (Hermes Weekly Backup)
- **Schedule:** `0 9 * * 5` (every Friday at 09:00 local time)
- **Command:** `backup_Completo.sh` (relative to `~/.hermes/scripts/`)

You can view or modify it with:

```bash
hermes cronjob list
hermes cronjob update --job_id f93a5953e431 --schedule "0 9 * * 5"
```

## 🔁 Restoration Procedure

To restore Hermes on a fresh system:

1. **Install Hermes Agent** (same version or latest stable) following the official installation guide.
2. **Create the base directory** if it does not exist:
   ```bash
   mkdir -p "$HOME/.hermes"
   ```
3. **Copy the latest backup** to the target host and extract it **over the home directory** (preserving paths):
   ```bash
   tar -xzf /path/to/hermes_backup_YYYYMMDD_HHMMSS.tar.gz -C "$HOME"
   ```
   This will restore:
   - `~/.hermes/` (config, state.db, skills, plugins, cron, memories, profiles, sessions, logs)
   - `~/scripts/`
   - `~/tools/`
   - `~/.local/bin/`, `~/go/bin/`, `~/.cargo/bin/`
   - Shell rc files (`.bashrc`, `.zshrc`, etc.)
   - `~/.ssh/`
4. **Reload the shell** to pick up restored environment variables:
   ```bash
   source ~/.bashrc   # or source ~/.zshrc
   ```
5. **Verify Hermes is operational**:
   ```bash
   hermes version
   hermes skills list
   ```
6. **Optional – Re‑install any system‑level dependencies** (e.g., Java, Rust, Go) if they were not installed via the backup. The backup includes the binaries but not the JDK/Golang/Rust runtimes themselves; ensure they are present:
   ```bash
   # Example: restore JAVA_HOME if using a custom JDK
   export JAVA_HOME="$HOME/tools/java/jdk-21.0.12"
   export PATH="$JAVA_HOME/bin:$PATH"
   ```

## ⚠️ Pitfalls & Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| `tar: Cannot stat: …/profiles: No such file or_directory` | The `~/.hermes/profiles` directory does not exist yet. | The script safely ignores missing paths; ensure the directory exists after first Hermes run or create it manually: `mkdir -p ~/.hermes/profiles`. |
| Backup file is unexpectedly large (>4 GB) | Accidentally includes caches, logs, or large wordlists stored under `~/tools/` or `~/scripts/`. | Review the backup contents: `tar -tzf <archive> | head`. If you see `cache/`, `*.log`, or massive wordlists, consider adding exclusion patterns to the script (e.g., `--exclude='*/cache/*'`). |
| After restore, `hermes` command not found | Hermes package not installed or PATH not updated. | Install Hermes (`pip install --user hermes-agent` or per‑distro method) and ensure `~/.local/bin` is in your `$PATH`. |
| SSH authentication fails after restore | Private key permissions are too open. | Fix permissions: `chmod 700 ~/.ssh && chmod 600 ~/.ssh/*`. |
| Cron job does not run after restore | Cron daemon not running or job missing. | Verify cron service: `systemctl status cron` (or `crond`). Re‑import the job if needed: `hermes cronjob list` should show the backup job. If missing, recreate with `hermes cronjob create …`. |

## 📋 References

- `references/backup_script.md` – annotated version of `backup_Completo.sh` with explanation of each section.
- `references/cron_job_example.md` – sample cron‑job definition for reference.

## 🔄 Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0   | 2026-07-27 | Initial release – covers full backup/restore workflow, script, cron job, and restoration steps. |
| 1.1.0   | 2026-07-27 | Updated script to: use lockfile, dynamic include list, pigz/gzip piping, retention policy, logging; improved error handling; added notes about nice/ionice. |
| 1.2.0   | 2026-07-27 | Refined script: added explicit nice/ionice recommendation, clarified retention logic, improved logging format, and updated documentation to match final script. |
| 1.3.0   | 2026-07-27 | Retention reduced to 3 backups; enhanced error handling to verify archive size and clean up on failure; updated documentation to reflect current script behavior. |

---

*This skill is intended to be used alongside the Hermes Agent core skills. Keep it updated whenever you add new directories (e.g., additional tool chains) to the backup set.*