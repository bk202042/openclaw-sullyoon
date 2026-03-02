---
title: "MOC-agent-architecture.md"
description: "Map of Content for multi-agent architecture, context design, and execution quality in Shared Brain."
tags: [moc, agent-architecture, shared-brain, skill-graph]
trigger: "멀티 에이전트 설계 전체 지도를 보고 싶을 때, 어떤 노트부터 읽어야 할지 결정할 때"
---

## Agent Architecture MOC

이 MOC는 Shared Brain의 에이전트 운영 지식을 한 번에 탐색하기 위한 엔트리 포인트다.

### Foundation (먼저 읽기)
- [[progressive-disclosure-optimizes-agent-context.md]] — 컨텍스트/토큰 효율의 기본 규칙
- [[skill-graphs-over-skill-md.md]] — 단일 문서 대신 그래프형 지식 구조

### System Design (구조 설계)
- [[shared-brain-architecture-for-agents.md]] — 공용 컨텍스트 기반 멀티 에이전트 운영
- [[anthropic_agent_architecture_insights.md]] — 오케스트레이션, 상태, eval, 툴 신뢰성

### Execution Discipline (실행 품질)
- [[karpathy-llm-coding-guidelines.md]] — 과설계 방지, 수술식 수정, 검증 루프
- [[context-engineering-for-long-running-agents.md]] — 장기 실행에서 컨텍스트 예산 관리, JIT retrieval, 품질 게이트 정렬

### Operating Standard (운영 기준)
- [[../../context/AGENT_ONBOARDING.md]] — v2 공통 운영 표준 (품질 게이트, 스크래치패드, Lessons Ledger, 커뮤니케이션/환경/보안/Git 규율)

### Recommended Reading Path
1. [[progressive-disclosure-optimizes-agent-context.md]]
2. [[skill-graphs-over-skill-md.md]]
3. [[shared-brain-architecture-for-agents.md]]
4. [[anthropic_agent_architecture_insights.md]]
5. [[karpathy-llm-coding-guidelines.md]]
