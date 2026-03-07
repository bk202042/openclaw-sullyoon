---
name: cli-docs
description: Search and fetch Google Workspace CLI docs/source context through MCP (cli-docs) via gitmcp.io.
version: 1.0.0
author: local
---

# CLI Docs Skill

Use this MCP server for Google Workspace CLI documentation and source lookups.

## Server

- Name: `cli-docs`
- Transport: remote MCP via `mcp-remote`
- URL: `https://gitmcp.io/googleworkspace/cli`

## Example (mcporter)

```bash
mcporter list cli-docs
mcporter call cli-docs.search_docs query="auth"
```
