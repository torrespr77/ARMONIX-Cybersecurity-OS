# STT Whisper Installation — Local Speech-to-Text for Hermes Agent

**Date:** 2026-07-01  
**Status:** PENDING — Whisper module not installed, STT non-functional  
**Goal:** Enable `stt.local.provider=local` with `model=base`, `language=es`

## Problem

Hermes Agent STT is configured for local Whisper (`stt.provider=local`, `model=base`, `language=es`) but the Python module `whisper` (openai-whisper) is not installed in the environment. Attempting to import fails:

```python
ImportError: No module named 'torch'  # whisper dependency
```

The system has **no GPU** (Intel HD 510, no OpenCL), so we must install **CPU-only** PyTorch to avoid downloading multi-GB CUDA packages.

## Solution: CPU-Only Installation (No Sudo)

### Prerequisites
- `uv` available at `~/.local/bin/uv`
- Python 3.14 at `/usr/bin/python3.14`
- Target site-packages: `~/.local/lib/python3.11/site-packages/`
- Hermes venv site-packages: `~/.hermes/hermes-agent/venv/lib/python3.11/site-packages/`

### Installation Commands (Run from SSH)

```bash
# 1. Stable setuptools (includes pkg_resources needed for whisper build)
~/.local/bin/uv pip install --target ~/.local/lib/python3.11/site-packages "setuptools==65.5.0"

# 2. Whisper without build isolation (avoids pkg_resources build error seen with 20231117 version)
~/.local/bin/uv pip install --target ~/.local/lib/python3.11/site-packages \
  --no-build-isolation --no-deps openai-whisper

# 3. Core dependencies (CPU-only, no CUDA)
~/.local/bin/uv pip install --target ~/.local/lib/python3.11/site-packages "numpy>=1.21.0"
~/.local/bin/uv pip install --target ~/.local/lib/python3.11/site-packages \
  torch==2.3.0+cpu -f https://download.pytorch.org/whirl/torch_stable.html
~/.local/bin/uv pip install --target ~/.local/lib/python3.11/site-packages \
  "ffmpeg-python>=0.2.0" "tiktoken>=0.5.0" "tqdm>=4.65.0"

# 4. Verify installation
/usr/bin/python3.14 -c "
import sys
sys.path.insert(0, '/home/hermes/.hermes/hermes-agent/venv/lib/python3.11/site-packages')
sys.path.insert(0, '/home/hermes/.local/lib/python3.11/site-packages')
import whisper
model = whisper.load_model('tiny.en')  # Fast test with small model
print('✅ STT ready - whisper module loaded, model loads successfully')
"

# 5. Restart gateway (MUST be from separate SSH session, NOT from agent)
hermes gateway restart
```

### Why This Approach

| Issue | Solution |
|-------|----------|
| `pkg_resources` missing during build | `setuptools==65.5.0` installed first + `--no-build-isolation` |
| CUDA packages huge (4+ GB) | `torch==2.3.0+cpu` from official PyTorch CPU index |
| No sudo / no root | `--target ~/.local/lib/python3.11/site-packages` |
| Version pinning errors with `==20231117` | Install latest `openai-whisper` without version constraint |

### Expected Outcome

After restart:
- Voice notes sent to Telegram by user → transcribed by Hermes STT → processed as text
- Config in `config.yaml` already correct:
```yaml
stt:
  enabled: true
  provider: local
  local:
    model: base
    language: es
```
- TTS already working with `es-MX-DaliaNeural` (verified 2026-07-01)

## Verification Checklist

- [ ] `whisper` module imports in Python 3.14 with both site-packages paths
- [ ] `whisper.load_model('base')` completes without error
- [ ] Gateway restart completes, Telegram connection re-established
- [ ] User sends "Prueba" voice note → transcribed → agent responds in text

## Fallback Options (If CPU Install Fails)

1. **whisper.cpp** — C++ implementation, compile from source (already tested, works but more complex integration)
2. **OpenAI Whisper API** — Requires API key, not local, privacy consideration
3. **Vosk** — Offline STT, smaller models, different API
4. **Smaller Whisper model** — `tiny.en` (39 MB) vs `base` (142 MB) for faster testing