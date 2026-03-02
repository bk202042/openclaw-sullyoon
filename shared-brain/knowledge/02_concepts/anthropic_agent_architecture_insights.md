---
title: "anthropic-agent-architecture-insights.md"
description: "Architectural insights and best practices for building scalable, long-running, multi-agent systems and their evaluation frameworks, based on Anthropic Engineering post-mortems."
tags: [agent-architecture, multi-agent, anthropic, prompt-engineering, evaluations]
trigger: "When designing multi-agent systems, dealing with long-running agent state, or building evaluation/grading infrastructure for agents."
---

# AI Agent Architecture Insights: Lessons from Anthropic Engineering

Based on a review of Anthropic Engineering blog posts (Late 2025 - Early 2026), here are the core architectural principles and lessons for building scalable, long-running, and multi-agent systems. These insights should guide our incoming project.

## 1. Multi-Agent Systems & Parallelization
- **Why Multi-Agent?** Complex, open-ended tasks (like research or compiling code) exceed single context windows and linear paths. Multi-agent systems scale token usage and allow for parallel exploration (breadth-first), reducing path dependency.
- **Orchestrator-Worker Pattern:** Use a "Lead Agent" (orchestrator) to analyze the query, develop a strategy, and spawn specialized "Subagents" (workers).
- **Parallel Tool Calling & Execution:** Speed is achieved by running subagents in parallel *and* allowing those subagents to use multiple tools concurrently.
- **Specialization:** Subagents should have distinct roles (e.g., searcher, tester, code cleaner, citation generator) with strict task boundaries to prevent duplicated effort.
- **Scaling Effort:** Embed rules so the orchestrator scales the number of subagents based on query complexity (e.g., 1 agent for simple facts, 10+ for deep research).

## 2. Managing Long-Running Agents (State & Context)
- **The Core Problem:** Agents forget previous sessions. Relying solely on context compaction isn't enough; agents might try to "one-shot" a complex app or declare victory too early.
- **The Two-Phase Approach:**
  1.  **Initializer Agent:** A specialized first session that sets up the environment (e.g., creating a `feature_list.json`, an `init.sh` script, and an initial git commit).
  2.  **Coding/Execution Agents:** Subsequent sessions that read the state, pick *one* feature, make incremental progress, and commit changes.
- **Environment Management:** 
  - Use structured formats (like JSON) for tracking progress/features, as models are less likely to overwrite them incorrectly compared to Markdown.
  - Rely on Git history and progress logs (`claude-progress.txt`) so new agent sessions can instantly understand the current state.
- **Long-Horizon Context:** For conversations spanning hundreds of turns, agents must summarize completed phases and store them in external memory, spawning fresh subagents with clean contexts that reference that memory.

## 3. Evaluation (Evals) Infrastructure
- **Evals are Not Optional:** Without automated evals, debugging is reactive and regressions go unnoticed. Build them early.
- **Types of Graders:**
  - *Code-based (Deterministic):* Fast, objective (unit tests, exact matches).
  - *Model-based (LLM-as-judge):* Good for nuance, open-ended outputs, and interaction quality. Requires careful calibration with human experts.
  - *Human Graders:* For gold-standard calibration and catching subtle biases.
- **Capability vs. Regression:**
  - *Capability Evals:* Test what the agent *can* do (start with low pass rates, aim to climb).
  - *Regression Evals:* Ensure the agent *still* does what it used to (aim for near 100% pass rates).
- **Evaluating Agents vs. Standard LLMs:** Agent evals must account for non-determinism, state changes, and multi-turn loops. Focus on *end-state outcomes* (did it fix the bug/book the flight?) rather than rigid path-following (did it use tool X then tool Y?).
- **Metrics:** Differentiate between `pass@k` (can it succeed at least once in k attempts?) and `pass^k` (does it succeed consistently across k attempts?).

## 4. Tool Design & Reliability
- **Tool Ergonomics:** Agent-tool interfaces are as critical as human-computer interfaces. Poorly described tools derail agents.
- **Self-Improving Tools:** Allow models to test tools and rewrite the tool descriptions based on failure modes to improve future agent efficiency.
- **Handling Failures:** Agents are stateful, and errors compound. Build deterministic safeguards (retry logic, checkpoints) but also allow the agent to gracefully handle tool failures dynamically.
- **Asynchronous Flow:** While synchronous execution (lead agent waits for all subagents) is easier to coordinate, moving toward asynchronous execution (subagents creating sub-subagents as needed) unlocks massive performance gains, albeit with higher state-management complexity.

## 5. Practical Implementation Hacks
- **"Think Like the Agent":** Use detailed simulation/tracing to watch the agent step-by-step.
- **Extended Thinking:** Use extended thinking (scratchpads) for planning, assessing tool fit, and evaluating intermediate results.
- **Start Wide, Narrow Down:** Prompt research agents to begin with broad queries before drilling into specifics.
- **Test End-to-End:** For coding, explicitly prompt agents to use browser automation tools (like Puppeteer MCP) to test features as a human would, rather than just relying on unit tests or `curl`.

## Related Nodes
- [[shared-brain-architecture-for-agents.md]]
- [[progressive-disclosure-optimizes-agent-context.md]]
- [[karpathy-llm-coding-guidelines.md]]
- [[skill-graphs-over-skill-md.md]]