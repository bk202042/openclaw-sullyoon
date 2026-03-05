---
title: OpenClaw Agent System Guide & Cheat Sheet
description: Comprehensive technical guide for OpenClaw system health checks, path migrations, config validation, and agent operational protocols (Karpathy Rule, Context Budget, ACI).
tags: openclaw, guide, cheat-sheet, architecture, devops, health-check
trigger: OpenClaw configuration, troubleshooting, or system upgrade tasks
---

# OpenClaw Agent System Guide & Cheat Sheet

## Core System Architecture (Phase 0)
- **Home**: `/Users/macbookair/.openclaw-kimi`
- **Workspace**: `/Users/macbookair/.openclaw-kimi/workspace`
- **Key Files**:
  - `openclaw.json`: Main configuration (Auth, Models, Tools).
  - `.env`: API Keys (Groq, Tavily, Discord, Gateway).
  - `logs/gateway.err.log`: Critical troubleshooting log.
  - `cron/jobs.json`: Scheduled task definitions.

## Operational Protocols (Phase 3)
### 1. Karpathy Rule
"Keep the base clean, do not create temporary files or junk. Speed is okay, but mess is not."

### 2. Context Budget Protocol
- **50% Used**: Enter Compaction mode (Summarize).
- **75% Used**: Split/Delegate or Reset with handoff summary.
- **JIT Retrieval**: Use Progressive Disclosure. Do not pre-load files.

### 3. Session Lifecycle (Two-Phase)
- **Init**: Load Soul/User/Identity + Memory + Search for in-progress tasks.
- **Execute**: Pick ONE goal per session. Incremental progress only.

### 4. ACI Tool Output Rules
- Filter outputs before adding to context (`head`, `grep`, `jq`).
- Offload long outputs (>100 lines) to filesystem and reference the path.

## System Maintenance & Health Checks (Phase 1 & 2)
### Path Migration
Strictly migrate all references from legacy `.openclaw/workspace-kimi` to current `.openclaw-kimi/workspace`.
- Check: `cron/jobs.json`, `new_vault_note.sh`, `summarize_notes.py`.

### Validation
- **Config**: `cat openclaw.json | python3 -m json.tool > /dev/null`
- **Gateway**: `openclaw gateway restart`
- **Channels**: `openclaw channels status`

## Links & References
- [[progressive-disclosure-optimizes-agent-context]]
- [[ultimate-openclaw-secure-setup]]
- [[AGENTS.md]]
- [[IDENTITY.md]]
- [[TOOLS.md]]
