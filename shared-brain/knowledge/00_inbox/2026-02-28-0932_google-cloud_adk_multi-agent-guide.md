---
title: "Google ADK guide: collaborative multi-agent system patterns"
description: "Google Cloud developer guide summarizing ADK multi-agent architecture, workflow orchestrators, and communication mechanisms."
tags: ["google-adk", "multi-agent", "architecture", "workflow", "communication", "google-cloud"]
trigger: "When designing ADK-based multi-agent systems or comparing orchestration/communication patterns."
---

## Core Claim
Google ADK frames multi-agent systems as **hierarchical teams** of specialized agents, with workflow orchestrators (Sequential/Parallel/Loop) and three collaboration channels (shared state, LLM delegation, explicit tool invocation) to turn complex tasks into reliable pipelines.

## Why it matters
- Gives a practical mental model for role design: **LLM = brain, Workflow = manager, Custom = specialist**.
- Clarifies when to use each orchestration mode:
  - **Sequential** for dependency chains,
  - **Parallel** for independent fan-out,
  - **Loop** for retry/poll/iterative refinement.
- Distinguishes permanent hierarchy members (sub-agents) vs on-demand specialist calls (AgentTool), which helps prevent over-coupled architectures.

## Workflow / Application
1. Define root objective and decompose into specialist sub-tasks.
2. Build a parent-child hierarchy (single parent per agent).
3. Choose execution controller per phase:
   - Sequential for staged transforms,
   - Parallel for concurrent evidence gathering,
   - Loop for convergence criteria.
4. Select communication mode deliberately:
   - Shared session state for common context,
   - LLM-driven delegation for dynamic routing,
   - AgentTool invocation for explicit specialist calls.
5. Add completion gates (verification + uncertainty handling) before final synthesis.

## Related Nodes
- [[MOC-agent-architecture.md]]
- [[openclaw-orchestrator-worker-patterns.md]]
- [[anthropic_agent_architecture_insights.md]]
- [[2026-02-26-2237_notion_multi-agents.md]]

## References
- Original article: https://cloud.google.com/blog/topics/developers-practitioners/building-collaborative-ai-a-developers-guide-to-multi-agent-systems-with-adk?hl=en
- ADK docs: https://google.github.io/adk-docs/
- ADK samples: https://github.com/google/adk-samples
- ADK codelab: https://codelabs.developers.google.com/onramp/instructions#0
