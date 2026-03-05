---
title: Master Plan: Specialized Sub-Agent Orchestration
description: Plan for managing specialized sub-agents for Gemini CLI, Discord Operations, and SNS Content via OpenClaw.
tags: orchestration, sub-agents, strategy, automation, discord, sns
trigger: Master plan for sub-agent management
---

# Master Plan: Specialized Sub-Agent Orchestration

## 1. Vision: "The One-Person AI Agency"
Maximize Captain's leverage by deploying specialized, autonomous sub-agents that handle deep execution while OpenClaw (Elon) maintains strategic control and quality assurance.

## 2. Agent Core Specializations

### Agent A: Gemini CLI Operations (The Engineer)
- **Role**: Backend infrastructure, script management, MCP health.
- **Tasks**:
  - Fix `Invalid tool name` errors in `bkit` extensions.
  - Automate MCP server reconnections (`notebooklm`, `github`).
  - Execute complex PDCA cycles (Plan → Design → Do → Check → Act).
- **Tools**: `exec`, `gemini-cli`, `mcporter`.

### Agent B: Discord Community Manager (The Moderator)
- **Role**: Community growth, engagement, and automated moderation.
- **Tasks**:
  - Analyze member sentiment and engagement metrics.
  - Automate welcome flows and documentation delivery via Discord.
  - Coordinate `#showcase` channel content harvesting.
- **Tools**: `message`, `sessions_spawn (acp)`, `discord-mcp`.

### Agent C: SNS Content Strategist (The Creator)
- **Role**: Multi-platform content distribution and trend analysis.
- **Tasks**:
  - Search X/LinkedIn for AI transformation trends (`x-research-skill`).
  - Draft blog/Thread posts based on session logs (`summarize`).
  - Generate visual assets (DALL-E) and schedule posts.
- **Tools**: `web_search`, `tavily-search-pro`, `canvas`.

## 3. Operational Infrastructure

### Layer 1: Strategic Command (Main Agent: Elon)
- Receives high-level intent from Captain.
- Deploys Sub-Agents via `sessions_spawn`.
- Performs "Karpathy Rule" quality checks on all outputs.

### Layer 2: Memory & Context (The Vault)
- All sub-agents must read/write to `memory/vault/` using Progressive Disclosure.
- Centralized `MOC.md` serves as the source of truth for all agents.

### Layer 3: Automation (Cron & Heartbeat)
- **Daily 09:00**: Agent C reports overnight SNS trends.
- **Hourly**: Agent A checks MCP server status.
- **Event-driven**: New Discord join triggers Agent B's welcome flow.

## 4. Implementation Roadmap (Phase 1)
- [ ] Fix Gemini CLI `bkit` extension errors (Path/Tool name validation).
- [ ] Connect `notebooklm` MCP to Vault for deep research.
- [ ] Create Discord interaction sub-agent with `message` tool permissions.
