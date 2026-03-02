---
name: summarize
description: Summarize links, files, and media into sharp summaries. CLI + Chrome Extension. Supports URLs, PDFs, images, audio/video, YouTube, and podcasts.
version: 1.0.0
author: steipete (https://github.com/steipete/summarize)
---

# Summarize Skill

Summaries that live where you work. Summarize turns links, files, and media into sharp summaries with a real extraction pipeline.

## Features

- **URLs** - Extract and summarize web articles
- **PDFs** - Summarize PDF documents
- **Images** - OCR + summarize image content
- **Audio/Video** - Transcribe and summarize media
- **YouTube** - Summarize videos with auto-transcript
- **Podcasts** - Summarize audio content
- **Firecrawl fallback** - Robust extraction when needed
- **Local, paid & free models** - Flexible model options

## Installation

```bash
npm i -g @steipete/summarize
```

## Quick Start

```bash
# Summarize a URL
summarize "https://example.com/article"

# Summarize with specific length
summarize "https://example.com" --length long

# Summarize YouTube video
summarize "https://youtu.be/..." --youtube auto

# Summarize PDF
summarize "/path/report.pdf" --model google/gemini-3-flash-preview

# JSON output for scripting
summarize "https://example.com" --json

# Extract only (no summary)
summarize "https://example.com" --extract
```

## Options

| Option | Description |
|--------|-------------|
| `--length short\|medium\|long` | Summary length |
| `--model <model>` | Model to use (e.g., `google/gemini-3-flash-preview`) |
| `--json` | Output as JSON |
| `--extract` | Extract text only, no summary |
| `--metrics` | Include processing metrics |
| `--youtube auto\|transcript` | YouTube handling mode |

## Chrome Extension

1. Install CLI + daemon
2. Load unpacked extension
3. Open Side Panel and connect with token
4. Auto-summarizes active tab on navigation

## Model Support

- Local models (via Ollama, etc.)
- Paid APIs (OpenAI, Anthropic, Google)
- Free models (Gemini Flash, etc.)

## Examples

```bash
# Short summary
summarize "https://news.ycombinator.com/item?id=..." --length short

# Long technical summary
summarize "/path/to/paper.pdf" --length long --model google/gemini-3-flash-preview

# Podcast episode
summarize "https://podcast.example.com/episode.mp3"

# Image with OCR
summarize "/path/to/screenshot.png"
```
