---
title: "Anthropic: effective context engineering for AI agents"
description: "Core principles from Anthropic on context engineering, context rot, token-efficient tools, and just-in-time retrieval for autonomous tool-using agents."
tags: [anthropic, context-engineering, ai-agents, prompt-engineering, retrieval, tool-design]
trigger: "When improving agent reliability over long loops, pruning context, or redesigning prompts/tools for token efficiency"
---

## Core Claim
For capable agents, performance depends less on clever prompt wording and more on **context engineering**: continuously curating the smallest high-signal context set that preserves desired behavior across multi-turn tool loops.

## Why it matters
- Long-running agents degrade under context bloat (“context rot”), so token budget must be treated as a finite resource.
- Better outcomes come from **tight, structured context** plus clear tool contracts, not giant prompts.
- Runtime “just-in-time” retrieval (load only what’s needed now) outperforms dumping all relevant data up front.

## Workflow / Application
1. Keep system prompt at “right altitude”: specific enough to guide behavior, flexible enough to avoid brittle if-else logic.
2. Structure prompt sections clearly (background/instructions/tools/output) and iterate from minimal viable prompt.
3. Minimize tool overlap; make parameter semantics unambiguous and token-efficient.
4. Use canonical few-shot examples (small, diverse set) rather than exhaustive edge-case dumps.
5. Prefer agentic retrieval: keep lightweight references (paths/queries/links), fetch details only at decision time.
6. Continuously prune low-signal history/context to maintain attention quality.

## Fit with Our Researcher/Worker/Conductor Standard
- Reinforces our quality gate principle: **no verification artifact, no completion**.
- Supports our routing discipline: minimal-effective tool escalation and stop at sufficiency.
- Justifies strict handoff artifacts (evidence/confidence/implication/next action) to keep context compact and actionable.

## Related Nodes
- [[anthropic_agent_architecture_insights.md]]
- [[adk-multi-agent-patterns-aligned-to-openclaw-quality-gates.md]]
- [[openclaw-orchestrator-worker-patterns.md]]
- [[MOC-agent-architecture.md]]

## References
- Original post: https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Prompt engineering overview: https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview
- Building effective AI agents: https://www.anthropic.com/research/building-effective-agents
- Writing tools for AI agents: https://www.anthropic.com/engineering/writing-tools-for-agents
