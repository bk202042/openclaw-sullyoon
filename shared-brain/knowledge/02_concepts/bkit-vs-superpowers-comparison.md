---
title: "Comparison: bkit (Gemini CLI) vs. Superpowers (obra)"
description: "Deep dive comparison of the bkit development framework and the Superpowers agentic skills framework."
tags: bkit, superpowers, comparison, frameworks, ai-agents, coding
trigger: bkit vs superpowers comparison
---

# Comparison: bkit vs. Superpowers

## 1. Overview

| Feature | **bkit (Gemini CLI)** | **Superpowers (obra)** |
| :--- | :--- | :--- |
| **Philosophy** | **PDCA-Centric (Process)** | **TDD-Centric (Evidence)** |
| **Core Loop** | Plan → Design → Do → Check → Act | Red → Green → Refactor |
| **Agent Model** | Multi-Agent Orchestration (CTO, PM, etc.) | Single-Agent with Composible Skills |
| **Strength** | Comprehensive Documentation & Lifecycle | Fast, Test-Driven Iteration |
| **Validation** | Design-to-Code Gap Analysis (90% target) | Test Case Success (Pass/Fail) |

---

## 2. Structural Breakdown

### bkit: The "Corporate Architect"
- **Focus**: High-level alignment between intent (Design) and execution (Code).
- **Key Mechanism**: `gap-detector` (Evaluator-Optimizer pattern). It measures how closely the code matches the design docs.
- **Complexity**: High. Requires multiple JSON/Markdown docs to track state.
- **Ideal For**: Large-scale projects, Enterprise/Dynamic apps where documentation is as critical as the code.

### Superpowers: The "Silicon Valley Hacker"
- **Focus**: Eliminating fluff and proving correctness via tests.
- **Key Mechanism**: `test-driven-development` & `subagent-driven-development`. It forces a "tests first" mindset.
- **Complexity**: Lean. Skills trigger automatically based on intent.
- **Ideal For**: Rapid prototyping, feature-based development, and teams that prioritize automated testing over documentation.

---

## 3. Workflow Comparison

### Feature Implementation Cycle
1. **bkit**:
   - `Plan` (Goal) → `Design` (Schema/API) → `Do` (Implementation) → `Check` (Gap Analysis) → `Act` (Fix & Report).
   - Iterates using `pdca-iterator` until 90% match rate.
2. **Superpowers**:
   - `Brainstorming` → `Writing Plans` → `TDD` (Write failing test) → `Executing Plans` → `Code Review`.
   - Iterates task-by-task (2-5 min chunks).

---

## 4. Synthesis: Which to Choose?

- **Use bkit if**: You need a rigid, documented process that mimics a full engineering team (CTO, QA, PM). Excellent for "thinking before doing" in complex architectures.
- **Use Superpowers if**: You want to move fast with high confidence. It is better for "proving it works" through code rather than "verifying it matches the plan" through documents.

## 5. Integration Opportunity
A "Super-bkit" hybrid could use **bkit's Design-First** approach to define the architecture, but swap the `Do` phase with **Superpowers' TDD & Subagent** execution for superior code quality.

## Links
- [[master-plan-sub-agent-management]]
- [[karpathy-llm-coding-guidelines]]
