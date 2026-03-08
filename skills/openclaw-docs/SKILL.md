---
name: openclaw-docs
description: Search and fetch OpenClaw official docs and source context through MCP (`openclaw-docs`) via gitmcp.io.
---

# openclaw-docs

Use this skill when the user asks about OpenClaw behavior, config, commands, architecture, or code-level implementation details.

## Server
- MCP server name: `openclaw-docs`
- Transport: stdio (`npx mcp-remote https://gitmcp.io/openclaw/openclaw`)

## Quick usage with mcporter

```bash
mcporter list openclaw-docs --schema
mcporter call openclaw-docs.search_openclaw_documentation query="gateway restart"
mcporter call openclaw-docs.fetch_openclaw_documentation path="/docs/gateway.md"
mcporter call openclaw-docs.search_openclaw_code query="session_status"
```

## Notes
- Prefer local docs first when available (`/Users/macbookair/.openclaw/workspace/docs`).
- Use this server for targeted retrieval from OpenClaw docs/repo when local docs are insufficient or for cross-checking latest source behavior.
