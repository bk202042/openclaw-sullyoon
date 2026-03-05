---
title: "OpenClaw Agent Swarm: The One-Person Dev Team"
description: "X post by Elvis describing his orchestration setup. He uses OpenClaw as the central orchestrator (named Zoe) instead of using Codex or Claude Code directly. The orchestrator spawns agents, writes prompts, and selects the optimal model per task."
tags: [openclaw, orchestration, multi-agent, codex, claude-code]
trigger: "agent orchestration setup, elvis, swarm"
---

# OpenClaw Agent Swarm: The One-Person Dev Team


## Core Insight: OpenClaw as the Orchestration Layer

Elvis (@elvissun) described his "One-Person Dev Team" setup on X (URL: https://x.com/elvissun/status/2025920521871716562).

Instead of interacting with coding agents like Codex or Claude Code directly, he uses OpenClaw as a central orchestration layer.

### Workflow & Mechanics
1. **The Lead Orchestrator**: He runs a central OpenClaw agent named "Zoe".
2. **Automated Spawning**: The orchestrator is responsible for spawning sub-agents, writing their prompts, and assigning tasks.
3. **Model Selection**: The orchestrator dynamically picks the right model for each task (e.g., fast models for routing, heavy models for complex coding).

This validates the **Orchestrator-Worker Pattern** outlined in our existing notes on [[anthropic_agent_architecture_insights]]. It is also a practical application of building a [[shared-brain-architecture-for-agents]], where the orchestrator acts as the command center managing the context and output of specialized worker agents.

### Why this matters
By decoupling the "manager" from the "worker," you eliminate the bottleneck of manually prompting and context-loading coding agents. The human operator sets the high-level objective, and the orchestrator handles the sub-agent lifecycle.
