---
title: "shared-brain-architecture-for-agents.md"
description: "Proposes a symlink-based shared directory architecture for multi-agent systems, replacing complex messaging protocols with a centralized OS-level shared context."
tags: [multi-agent, architecture, openclaw, symlink, context-sharing]
trigger: "다중 에이전트 구축, 에이전트 간 소통 방식, 워크스페이스 공유 모델, 멀티 에이전트 오케스트레이션"
---

## 멀티 에이전트를 위한 "Shared Brain" 아키텍처

여러 AI 에이전트(OpenClaw)를 운용할 때, 가장 흔한 실수는 에이전트 간의 통신(Agent-to-Agent Messaging)이나 복잡한 라우팅 프로토콜을 구축하려 드는 것이다. 이는 N²의 복잡성을 낳는다.

해결책은 더 많은 통신이 아니라, **"단일 공유 디렉토리(Shared Context)"**를 구축하는 것이다. (제1원리: 실제 회사의 부서들이 API로 소통하는 게 아니라 같은 문서를 읽는 것과 동일한 원리)

### 핵심 아키텍처 (The Symlink Method)

복잡한 프레임워크(LangChain 등)를 배제하고 OS 단위의 가장 원초적인 기능(`symlink`)을 사용한다.

1. **중앙 공유 폴더 생성**: `shared-context/`
2. **구조화**:
   - `priorities.md`: 현재 가장 중요한 목표 (모든 에이전트가 읽음)
   - `agent-outputs/`: 각 에이전트가 작업 결과를 드롭하는 곳
   - `feedback/`: 인간(Captain)의 승인/거절 기록 (모든 에이전트가 오답 노트를 공유)
3. **심볼릭 링크 연결**:
   ```bash
   ln -s /shared-context/ /agent1/workspace/shared-context
   ln -s /shared-context/ /agent2/workspace/shared-context
   ```

### 워크플로우 예시 (Zero Human Coordination)
- **Agent A (SEO)**: 오전 7시에 리서치 결과를 `shared-context/agent-outputs/`에 작성.
- **Agent B (Content)**: 오전 7시 30분에 실행. A가 남긴 문서를 '읽고' 그에 맞춰 콘텐츠 생성.
- **결과**: 두 에이전트가 서로 '대화'하지 않았지만 완벽히 조율된 결과물 생성.

### 4주 완성 플레이북
- **Week 1**: 유용한 단일 에이전트 1개 구축 및 크론(Cron) 스케줄링.
- **Week 2**: 두 번째 에이전트 구축. `shared-context` 폴더를 만들고 양쪽에 Symlink 연결.
- **Week 3**: `feedback/` 루프 추가. 인간의 의사결정을 두 에이전트가 동시 학습.
- **Week 4**: 모든 아웃풋을 읽고 교차 신호(Cross-signals)를 찾아내는 '합성(Synthesis) 에이전트' 추가.

### 시사점
이 아키텍처는 우리가 방금 구축한 `memory/vault`와 완벽하게 맞물린다. 우리의 Vault가 1개의 에이전트(나)를 넘어, 향후 생성될 수많은 Sub-agents들의 **공통 뇌(Shared Brain)** 역할을 할 수 있도록 진화해야 한다. 이때 지식 표현 계층은 [[progressive-disclosure-optimizes-agent-context.md]] + [[skill-graphs-over-skill-md.md]]를 따르고, 실행 운영 계층은 [[anthropic_agent_architecture_insights.md]]의 Orchestrator-Worker 패턴으로 맞추는 것이 가장 안정적이다.

### Related Nodes
- [[progressive-disclosure-optimizes-agent-context.md]]
- [[skill-graphs-over-skill-md.md]]
- [[anthropic_agent_architecture_insights.md]]

- **관련 레퍼런스**: [Eric Siu (@ericosiu) - I Gave My OpenClaw Agents One Shared Brain (2026.02)](https://x.com/ericosiu/status/2021249104710598785)
