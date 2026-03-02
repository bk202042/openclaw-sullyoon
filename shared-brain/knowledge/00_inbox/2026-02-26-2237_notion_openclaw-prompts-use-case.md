---
title: OpenClaw Prompts & Use Cases
description: Comprehensive collection of OpenClaw prompt patterns including multi-agent setups, Kimi K2.5 agent swarm, Exa framework, and Orchestrator Worker Model
tags:
  - openclaw
  - prompts
  - multi-agent
  - orchestrator
  - kimi
  - openclaw
trigger:
  - keywords: ["orchestrator", "agent swarm", "kimi k2.5", "exa framework", "mission control"]
  - context: "When designing agent architectures or looking for established prompt patterns"
---

## Core Claims

A curated reference of production-ready prompt patterns and agent architectures for OpenClaw deployments. These patterns enable complex multi-agent workflows with proper orchestration, evaluation, and synchronization.

## Prompt Categories

### 1. Multi-Agent Setup ([[OpenClaw Dashboard]])
- Centralized configuration for distributed agent teams
- [[OpenClaw Config]] integration for environment management

### 2. Kimi K2.5 Agent Swarm
- Optimized for Moonshot's Kimi K2.5 model capabilities
- Parallel processing with shared context windows
- Best for research and analysis tasks

### 3. Exa Multi-Agent Framework
- **Shared Memory Architecture**: All agents reference unified project database (Notion API or vector DB)
- **Agent Names**: SKYNET, FRIDAY, TURING, ELON, ORACLE
- **Key Principle**: Connect agents to shared context for consistent information access

### 4. Orchestrator Worker Model (Mission Control HQ)
Based on Anthropic research combining parallel agent teams and multi-agent research systems:

#### Architecture Components
- **Lead Researcher (Orchestrator)**: Analyzes high-level goals, formulates strategy, delegates to sub-agents
- **Specialized Sub-agents (Workers)**: Coding, research, documentation, performance optimization - each with independent context windows working in parallel
- **Artifact-Centric Sync**: Shared filesystem/Git repository instead of direct agent communication (prevents "telephone game" information distortion)
- **Git Worktree Management**: Essential for parallel development workflows

#### Harness Design for Long-Running Agents
- **Agent Role Separation**: Clear distinction between Planner and Executor roles
- **Feature Tracking**: JSON-managed feature lists (200+ items) with real-time pass/fail status to prevent "I think I'm done" failure modes

#### Parallel Processing & Synchronization
- **Task Locking**: Lock files in `current_tasks/` folder prevent duplicate work
- **Oracle-Based Verification**: Use "Known-good Oracle" (e.g., GCC) for selective comparison when full system validation is expensive

#### Evaluation System (Swiss Cheese Model)
- **Multi-Layer Evaluation**: LLM-as-Judge → Static Analysis → Unit/Integration Tests → E2E Verification
- **Key Metrics**: Pass@1 (one-shot success rate), Cost per Task, Latency, Iteration Count

## Implementation Guide

1. Define Feature List as JSON before building
2. Force Git commit logs and README updates in harness prompts
3. Build automated graders (Puppeteer, unit tests) for agent-written code
4. Regularly review failed transcripts to adjust evaluation strictness

## Actions

- [ ] Implement feature tracking JSON schema
- [ ] Set up bare-git synchronization
- [ ] Configure task locking mechanism
- [ ] Design evaluation layers for specific use case

## Source Traceability

- **Original Notion URL**: https://www.notion.so/OpenClaw-prompts-use-case-309d1ae943c9814cb415c055ca1f98a5
- **Retrieved**: 2026-02-26T22:37:00+09:00
- **Page ID**: 309d1ae9-43c9-814c-b415-c055ca1f98a5
- **Type**: Workplace / Use Case: openclaw

## Related Notes

- [[Multi-Agents]] - Practical use cases for these patterns
- [[Openclaw Prompt Template]] - Ready-to-use prompt templates
- [[Business with Openclaw]] - Commercial applications
- [[OpenClaw Dashboard]] - Control interface
