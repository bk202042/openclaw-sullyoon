---
name: gemini-cli-docs
description: Search and fetch Google Gemini CLI docs/source context through MCP (gemini-cli-docs) via gitmcp.io.
version: 1.0.0
author: local
---

# Gemini CLI Docs Skill

Use this MCP server for Gemini CLI documentation and source lookups.

## Server

- Name: `gemini-cli-docs`
- Transport: remote MCP via `mcp-remote`
- URL: `https://gitmcp.io/google-gemini/gemini-cli`

## Example (mcporter)

```bash
mcporter list gemini-cli-docs
mcporter call gemini-cli-docs.search_docs query="authentication"
```
