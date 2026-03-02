---
title: "ADK multi-agent patterns aligned to OpenClaw quality gates"
description: "Operational pattern note that maps Google ADK orchestration/communication models to our researcher-worker-conductor execution rules."
tags: [adk, multi-agent, orchestration, quality-gate, openclaw, researcher-worker-conductor]
trigger: "When designing or auditing ADK-based agent systems that must meet evidence-backed completion standards"
---

## Core Claim
Google ADK’s hierarchy + workflow-agent model becomes production-safe only when paired with strict execution discipline: **evidence-backed completion gates, explicit verification, uncertainty disclosure, and role-standardized handoffs**.

## Why it matters
- ADK explains *how agents collaborate*; our OpenClaw standard defines *when output is actually done*.
- This prevents the classic failure mode: polished agent chatter without validated outcomes.
- It gives one portable contract across roles (researcher/worker/conductor), reducing prompt drift.

## ADK Pattern Mapping to Our R/W/C Standard

### 1) Role architecture
- **Researcher (evidence producer):** gathers sources, confidence labels, and gaps.
- **Worker (execution specialist):** implements/changes with runnable verification.
- **Conductor (synthesizer/decider):** merges outputs, resolves uncertainty, sets next action.

ADK fit:
- Researcher/Worker can be sub-agents or AgentTools.
- Conductor is typically parent coordinator (LLM-driven delegation or workflow parent).

### 2) Workflow selection rule
- Use **SequentialAgent** when steps depend on prior artifacts (research → implement → synthesize).
- Use **ParallelAgent** for independent exploration/execution branches.
- Use **LoopAgent** only with explicit stop criteria (quality threshold, max retries, timeout).

### 3) Communication rule
- **Shared session state:** canonical for intermediate artifacts (facts, constraints, test results).
- **LLM-driven delegation:** good for dynamic routing, but must still pass completion gate.
- **Explicit invocation (AgentTool):** use for deterministic specialist calls (calculator, parser, executor).

### 4) Completion gate (Definition of Done)
A task is done only if all are present:
1. **Evidence** (source, trace, or verification artifact)
2. **Confidence** (high/medium/low + reason)
3. **Implication** (what changes decision/operation)
4. **Next Action** (clear follow-up or closure)

If any is missing, status = **in progress / blocked**, not complete.

### 5) Tool-routing discipline (research side)
Escalate minimally and stop when evidence is sufficient:
1. Tavily
2. Exa
3. Firecrawl
4. Stealth browser

### 6) Data/Python discipline
- Python/ipython only for computation, dataset analysis, charts.
- If preview/lookup is enough, do not invoke Python as fallback.

### 7) Memory safety discipline
- Never claim memory update without actual action.
- Strict command contract (`add/remove/replace` params).
- No minors data storage.
- Never expose internal memory IDs in user-facing output.

## Execution Template (copy/paste)
- Objective
- Actions taken
- Verification (proof)
- Risks / open questions
- Next action

## Anti-patterns to reject
- “Looks done” without verification artifacts.
- Confident wording with weak/no evidence.
- Endless tool escalation after sufficiency threshold.
- Role bleed (researcher shipping unverified execution; worker inventing evidence).

## Related Nodes
- [[MOC-agent-architecture.md]]
- [[openclaw-orchestrator-worker-patterns.md]]
- [[anthropic_agent_architecture_insights.md]]
- [[AGENT_ONBOARDING.md]]
- [[2026-02-28-0932_google-cloud_adk_multi-agent-guide.md]]

## References
- Google Cloud ADK blog: https://cloud.google.com/blog/topics/developers-practitioners/building-collaborative-ai-a-developers-guide-to-multi-agent-systems-with-adk?hl=en
- ADK docs: https://google.github.io/adk-docs/
- ADK workflow agents: https://google.github.io/adk-docs/agents/workflow-agents/
