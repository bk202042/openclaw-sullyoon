---
title: "progressive-disclosure-optimizes-agent-context.md"
description: "Explains the 3-level Progressive Disclosure mechanism (Level 1 Frontmatter, Level 2 Body, Level 3 References) to optimize agent token usage and context window management."
tags: [agent-architecture, prompt-engineering, anthropic, token-efficiency]
trigger: "AI 에이전트의 컨텍스트 윈도우 관리, 토큰 절약 전략, 대규모 지식 베이스 검색 설계 방법론"
---

## 점진적 공개 (Progressive Disclosure) 메커니즘

AI 에이전트(Claude 등)가 방대한 지식이나 복잡한 스킬을 다룰 때, 모든 정보를 한 번에 컨텍스트(Context)에 밀어 넣는 것은 비효율적이며 오염을 유발한다. 이를 방지하기 위한 아키텍처가 점진적 공개(Progressive Disclosure)다.

### 핵심 주장 (Core Claims)

1. **토큰 최적화는 계층적(Hierarchical) 접근에서 시작된다.**
   에이전트는 전체를 읽지 않고 메타데이터만으로 판단해야 한다.

2. **지식은 3단계로 분리되어야 한다.**
   - **Level 1 (Always Loaded / 식별)**: 에이전트의 시스템 프롬프트에 항상 로드되는 정보. YAML Frontmatter나 간략한 인덱스 형태로, "어떤 상황에 이 지식/스킬이 필요한가"만 알려준다.
   - **Level 2 (Loaded on Demand / 전개)**: 에이전트가 특정 스킬이나 지식이 필요하다고 판단했을 때(`memory_search` 등) 로드되는 본문. 작업 수행을 위한 핵심 지침과 워크플로우를 담는다.
   - **Level 3 (Deep Dive / 심층 탐색)**: 기본 본문에 포함되지 않는 방대한 레퍼런스나 코드 스니펫. 별도의 파일(`references/` 등)에 저장되며, Level 2 본문에 링크 형태로 존재하여 에이전트가 명시적으로 요청할 때만 접근한다.

### 시사점 및 적용

우리의 Vault 시스템은 이 메커니즘을 근간으로 작동한다. 이는 곧 지식이 코드베이스처럼 철저하게 모듈화되어 관리됨을 의미한다. 실제 운영에서는 [[skill-graphs-over-skill-md.md]]와 결합되어 탐색 경로를 만들고, 멀티 에이전트 실행 계층에서는 [[shared-brain-architecture-for-agents.md]]의 공용 컨텍스트 설계와 함께 써야 효과가 극대화된다.

### Related Nodes
- [[skill-graphs-over-skill-md.md]]
- [[shared-brain-architecture-for-agents.md]]
- [[anthropic_agent_architecture_insights.md]]

- **관련 레퍼런스**: Anthropic's Guide to Building Skills for Claude (2026.02)
