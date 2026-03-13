---
title: Google Agent Development Kit (ADK) for Multi-Agent Systems
description: Foundational concepts and architecture for building collaborative multi-agent systems using Google's ADK.
tags: [ai, multi-agent, adk, google, architecture]
trigger: "building-collaborative-ai-a-developers-guide-to-multi-agent-systems-with-adk"
---

# Google Agent Development Kit (ADK) for Multi-Agent Systems

## Core Philosophy of MAS
Multi-Agent Systems (MAS) solve complex problems through:
- **Decentralized Control**: No single boss; each agent acts on local rules.
- **Local Views**: Agents perceive and react to immediate environments, not the global state.
- **Emergent Behavior**: Complex intelligence arises from simple, local interactions.

## ADK Architecture
Google's ADK structures MAS through specific agent roles and a strict hierarchy:

### Agent Types
- **LLM Agents**: The "brains" (e.g., using Gemini) that reason and decide actions.
- **Workflow Agents**: The "managers" that orchestrate execution without doing the core work.
- **Custom Agents**: "Specialists" written in Python (inheriting from `BaseAgent`) for custom logic.

### Hierarchy & Orchestration
Agents are organized in a strict Parent/Sub-Agent hierarchy (Single Parent Rule). Workflow flow is controlled via pre-built orchestrators:
- **SequentialAgent**: Runs sub-agents sequentially (pipelines).
- **ParallelAgent**: Runs sub-agents concurrently (independent tasks).
- **LoopAgent**: Runs sub-agents repeatedly until a condition is met.

### Communication Mechanisms
- **Shared Session State**: A common state object (digital whiteboard) that agents read/write to.
- **LLM-Driven Delegation**: A parent LLM agent dynamically routes tasks to specialized sub-agents based on the request.
- **Explicit Invocation (AgentTool)**: Wrapping a target agent as a "tool" so another agent can call it like a function (acts as an external consultant, unlike a permanent sub-agent).

## References
- [Blog Post: Building Collaborative AI: A Developer's Guide to Multi-Agent Systems with ADK](https://cloud.google.com/blog/topics/developers-practitioners/building-collaborative-ai-a-developers-guide-to-multi-agent-systems-with-adk?hl=en)
- [ADK Docs](https://google.github.io/adk-docs/)
- [ADK Codelab/Examples](https://github.com/google/adk-samples)