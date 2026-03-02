---
title: Openclaw Prompt Template
description: Curated prompt templates from Matt Berman, Ray Fernando, and community contributors for OpenClaw automation workflows
tags:
  - openclaw
  - prompts
  - templates
  - cron
  - automation
  - openclaw
trigger:
  - keywords: ["prompt template", "cron job", "morning brief", "matt berman", "ray fernando"]
  - context: "When looking for ready-made prompt templates or automation scripts"
---

## Core Claims

A collection of battle-tested prompt templates from the OpenClaw community, optimized for specific automation scenarios including scheduled tasks, morning briefings, and workflow orchestration.

## Template Sources

### 1. Matt Berman Prompts
- **Source**: https://gist.github.com/mberman84/885c972f4216747abfb421bfbddb4eba
- **Content**: Comprehensive prompt library covering various OpenClaw use cases
- **Pattern**: Modular prompts with clear task decomposition

### 2. Ray Fernando Cron Job Prompt
- **Purpose**: Automated recurring task execution
- **Use Case**: Scheduled maintenance, periodic checks, background processing
- **Integration**: Works with [[OpenClaw Config]] cron scheduling

### 3. Ray Fernando Morning Brief
- **Purpose**: Daily automated summary and planning
- **Components**:
  - Calendar review and preparation
  - Priority task identification
  - Context-aware recommendations
- **Output**: Structured daily brief delivered via preferred channel

## Subagent Best Practices (Grok Analysis)

### Pattern 1: Task Decomposition with Parallel Spawning (Orchestrator Pattern)
- Decompose large tasks into independent subtasks
- Spawn specialized subagents in parallel
- Main agent acts as orchestrator, integrating results
- **Benefits**: More efficient than sequential processing, prevents context pollution

### Pattern 2: Multi-Agent Debate/Collaboration (Roundtable Pattern)
- Spawn 3-5 specialized subagents for complex problem-solving
- **Example Roles**: Scholar (academic), Engineer (technical), Muse (creative)
- Cross-examination across perspectives for robust solutions

### Pattern 3: Recursive Decomposition with Cost Management (Deep/Recursive Agent Pattern)
- Subtasks spawn sub-subagents for multi-stage work
- **Example Flow**: Research → Fact-checking → Citation verification
- **Cost Control**: Budget limits per agent level, timeout enforcement

## Implementation Tips

### Context Management
- Delegate to subagents to keep main agent context clean
- Use strong models (Opus) for external content to prevent prompt injection

### Tool Integration
- Leverage OpenClaw skills (agent-orchestrator, pi-orchestration)
- Use "Use when / Don't use when" rules for routing logic

### Cost Optimization
- Cron jobs for periodic tasks
- Minimize heartbeat messages (keep under 20 lines)
- Parallel spawning where possible

### Testing
- Start with examples from awesome-openclaw-skills repository
- Iterate based on transcript reviews

## Actions

- [ ] Adapt Matt Berman prompts for specific use case
- [ ] Set up Ray Fernando cron job for morning brief
- [ ] Configure subagent spawning rules
- [ ] Implement cost tracking per workflow

## Source Traceability

- **Original Notion URL**: https://www.notion.so/Openclaw-Prompt-Template-312d1ae943c9804dbd51c426ecbd1572
- **Retrieved**: 2026-02-26T22:37:00+09:00
- **Page ID**: 312d1ae9-43c9-804d-bd51-c426ecbd1572
- **Type**: Workplace / Use Case: openclaw

## Related Notes

- [[OpenClaw Prompts Use Case]] - Architecture patterns for these templates
- [[Multi-Agents]] - Use cases requiring template orchestration
- [[Business with Openclaw]] - Commercial deployment of templates
- [[OpenClaw Dashboard]] - Template management interface
