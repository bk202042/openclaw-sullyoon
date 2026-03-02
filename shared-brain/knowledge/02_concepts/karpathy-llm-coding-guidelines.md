---
title: "Karpathy LLM Coding Guidelines"
description: "Behavioral guidelines to reduce common LLM coding mistakes based on Andrej Karpathy's observations (simplicity, surgical changes, goal-driven execution)."
tags: [coding-guidelines, prompt-engineering, karpathy, agent-behavior]
trigger: "When an agent writes, reviews, or refactors code to avoid overcomplication and ensure surgical precision."
---

# Karpathy LLM Coding Guidelines


Based on [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876), LLMs tend to make specific, predictable mistakes when coding (e.g., over-engineering, refactoring unrelated code, failing to verify).

To counter this, agents should adhere to the following four core behavioral constraints when writing or modifying code. These constraints bias toward caution and precision over raw speed.

## 1. Think Before Coding (Surface Tradeoffs)
- **Do not assume.** If the prompt is ambiguous, present the possible interpretations rather than silently picking one.
- **Push back.** If a simpler approach exists, propose it before blindly executing a complex request.
- **Acknowledge confusion.** If something is unclear, stop and name the confusion explicitly.

## 2. Simplicity First (No Speculative Code)
- **Minimum viable code.** Write the exact code needed to solve the current problem, nothing more.
- No unrequested abstractions, no speculative "configurability", and no error handling for impossible edge cases.
- *Heuristic:* "Would a senior engineer say this is overcomplicated?" If yes, rewrite it to be shorter.

## 3. Surgical Changes (Clean Your Own Mess)
- **Touch only what you must.** Do not reformat, comment, or "improve" adjacent code that isn't broken.
- Match the existing codebase's style exactly, even if it differs from your default preferences.
- If your change orphans existing imports or variables, delete them. But **do not** delete pre-existing dead code unless explicitly asked.
- *The Test:* Every changed line must trace directly back to the user's prompt.

## 4. Goal-Driven Execution (Verifiable Loops)
- **Define success criteria immediately.** Transform vague tasks ("add validation") into verifiable goals ("write tests for invalid inputs, then make them pass").
- For multi-step tasks, state a brief plan with verification steps: `1. [Step] → verify: [check]`.
- This approach is critical for [[anthropic_agent_architecture_insights.md]] (specifically the Execution Agents), as strong success criteria allow the agent to loop independently without constant human clarification.

## Related Nodes
- [[anthropic_agent_architecture_insights.md]]
- [[progressive-disclosure-optimizes-agent-context.md]]
