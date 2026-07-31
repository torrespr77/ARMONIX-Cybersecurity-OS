# Session Reset Configuration Guide

## Overview
This document explains how to configure session reset behavior in Hermes Agent to prevent unwanted session resets.

## Configuration Location
Session reset settings are configured in `~/.hermes/config.yaml` under the `gateway.session_reset` section.

## Session Reset Modes
Hermes supports four reset modes:

| Mode    | Description                                                                 |
|---------|-----------------------------------------------------------------------------|
| `none`  | **Never auto-reset** (recommended for persistent conversations)             |
| `idle`  | Reset after N minutes of inactivity                                         |
| `daily` | Reset at a specific hour each day (local time)                              |
| `both`  | Reset when either condition is met first                                    |

## Recommended Configuration
To prevent automatic session resets (as requested in this session):

```yaml
gateway:
  session_reset:
    mode: "none"        # Never auto-reset
    at_hour: 4          # Ignored when mode is "none"
    idle_minutes: 1440  # Ignored when mode is "none" (24 hours)
    notify: true        # Notifications won't trigger with mode: "none"
    bg_process_max_age_hours: 24
```

## Verification Commands
Check current configuration:
```bash
hermes config get gateway.session_reset.mode
```
Should return: `none`

To set the configuration:
```bash
hermes config set gateway.session_reset.mode none
hermes config set gateway.session_reset.at_hour 4
hermes config set gateway.session_reset.idle_minutes 1440
```

## Important Notes
1. When `mode: "none"`:
   - Sessions persist until manually reset (`/reset` or `/new`)
   - Context management relies solely on prompt compression
   - The `at_hour` and `idle_minutes` settings are ignored
   - Reset notifications are suppressed (since no reset occurs)

2. Related settings that exist but are inactive with `mode: "none"`:
   - `notify`: Would trigger notifications on reset (inactive)
   - `notify_exclude_platforms`: Platforms excluded from reset notifications
   - `bg_process_max_age_hours`: Age threshold for background processes that block reset

3. The configuration change takes effect immediately for new sessions.
   Existing sessions will continue with their current reset policy until next reset.

## Troubleshooting
If you observe unexpected session resets:
1. Verify `gateway.session_reset.mode` is set to `none`
2. Check for overriding configuration in platform-specific sections
3. Ensure no external process is issuing `/reset` or `/new` commands
4. Review gateway logs for reset events: `grep -i "session.*reset" ~/.hermes/logs/gateway.log`

## Related Documentation
- [Daily Health Check Procedure](references/daily-check-procedure.md) - Includes session reset verification
- [Gateway Configuration Reference](https://hermes-agent.nousresearch.com/docs/gateway-config) - Official documentation