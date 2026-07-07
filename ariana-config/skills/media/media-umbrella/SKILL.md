---
name: media
description: "Media content — GIF search, audio analysis, music generation, YouTube transcripts. Use when working with GIFs, audio, music, or YouTube content."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [media, gif, audio, music, youtube, video, transcription]
    related_skills: [gif-search, heartmula, songsee, youtube-content, audiocraft-audio-generation]
---

# Media — Umbrella Skill

Covers media content: GIF search, audio analysis, music generation, and YouTube content extraction.

## Decision Tree

| Task | Sub-Skill | Trigger Keywords |
|---|---|---|
| Search/download GIFs | `gif-search` | GIF, reaction GIF, tenor, search GIF |
| Generate songs from lyrics | `heartmula` | heartmula, generate song, local music generation |
| Audio spectrograms/features | `songsee` | spectrogram, mel, chroma, MFCC, audio analysis |
| YouTube transcripts | `youtube-content` | YouTube, transcript, summarize video, video to text |
| Text-to-music (AudioCraft) | `audiocraft-audio-generation` | audiocraft, musicgen, text-to-music |

## GIF Search (from gif-search)

```bash
# Set API key (free at https://developers.google.com/tenor/guides/quickstart)
export TENOR_API_KEY=your_key

# Search
curl -s "https://tenor.googleapis.com/v2/search?q=thumbs+up&limit=5&key=${TENOR_API_KEY}" | jq -r '.results[].media_formats.gif.url'

# Download
URL=$(curl -s "https://tenor.googleapis.com/v2/search?q=celebration&limit=1&key=${TENOR_API_KEY}" | jq -r '.results[0].media_formats.gif.url')
curl -sL "$URL" -o celebration.gif
```

Full guide: `skill_view(name="gif-search")`

## Audio Analysis (from songsee)

```bash
# Install
go install github.com/steipete/songsee/cmd/songsee@latest

# Basic spectrogram
songsee track.mp3

# Multi-panel visualization
songsee track.mp3 --viz spectrogram,mel,chroma,hpss,selfsim,loudness,tempogram,mfcc,flux
```

Full guide: `skill_view(name="songsee")`

## Music Generation (from heartmula)

```bash
# Install
git clone https://github.com/HeartMuLa/heartlib.git
cd heartlib && uv venv --python 3.10 .venv && . .venv/bin/activate && uv pip install -e .

# Generate
python ./examples/run_music_generation.py \
  --model_path=./ckpt --version="3B" \
  --lyrics="./assets/lyrics.txt" --tags="./assets/tags.txt" \
  --save_path="./output.mp3" --lazy_load true
```

Full guide: `skill_view(name="heartmula")`

## YouTube Content (from youtube-content)

```bash
# Install
uv pip install youtube-transcript-api

# Fetch transcript
uv run python3 scripts/fetch_transcript.py "https://youtube.com/watch?v=VIDEO_ID"

# Plain text
uv run python3 scripts/fetch_transcript.py "URL" --text-only --timestamps
```

Full guide: `skill_view(name="youtube-content")`
