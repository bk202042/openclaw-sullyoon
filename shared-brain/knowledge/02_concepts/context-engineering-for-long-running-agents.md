---
title: "Context engineering for long-running agents"
description: "Operational concept note: how to keep agent performance stable by curating high-signal context, minimizing tool ambiguity, and using just-in-time retrieval."
tags: [context-engineering, long-running-agents, attention-budget, retrieval, quality-gates, anthropic]
trigger: "When agent quality drops over long sessions, outputs become noisy, or prompts/tools need pruning for reliability"
---

## Core Claim
In multi-turn agent systems, reliability comes from **context curation discipline** (what to include now) more than prompt verbosity (what to say once).

## Why it matters
- Context is a finite attention budget; more tokens can reduce recall precision (context rot).
- Overgrown prompts and overlapping tools create ambiguous decisions and degraded outcomes.
- Just-in-time retrieval keeps context small while preserving access to large knowledge surfaces.

## Practical Pattern (R/W/C aligned)
1. Start with minimal, structured system instructions (clear sections + explicit output contract).
2. Keep tools narrow, non-overlapping, and parameter semantics explicit.
3. Route tasks with minimal escalation; stop when evidence suffices.
4. Retrieve details at runtime from references (paths/queries/links) instead of preloading everything.
5. Enforce completion gate before synthesis:
   - evidence,
   - confidence,
   - implication,
   - next action.
6. Prune stale/low-signal context each loop.

## Failure Modes to prevent
- Giant “catch-all” prompts that hardcode brittle logic.
- Bloated toolboxes where no clear tool choice exists.
- Reporting completion without verification artifacts.
- Carrying full history when only current decision context is needed.

## Integration with OpenClaw operating standard
- Researcher: produce compact evidence packets (facts + confidence + gaps).
- Worker: execute only against validated constraints and prove outcomes.
- Conductor: synthesize with uncertainty disclosure, reject fake-complete outputs.

## Related Nodes
- [[MOC-agent-architecture.md]]
- [[anthropic_agent_architecture_insights.md]]
- [[adk-multi-agent-patterns-aligned-to-openclaw-quality-gates.md]]
- [[openclaw-orchestrator-worker-patterns.md]]
- [[2026-02-28-1033_anthropic_effective-context-engineering-for-ai-agents.md]]

## References
- https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- https://www.anthropic.com/research/building-effective-agents
- https://www.anthropic.com/engineering/writing-tools-for-agents
