---
title: "skill-graphs-over-skill-md.md"
description: "Advocates replacing monolithic SKILL.md files with Skill Graphs—networks of small, interlinked markdown nodes using Map of Content (MOC) and recursive progressive disclosure."
tags: [agent-architecture, knowledge-graph, skills, arscontexta, openclaw]
trigger: "고급 에이전트 스킬 구축, 복잡한 도메인 지식 처리, 스킬 간의 연결 및 구조화, MOC(Map of Content)"
---

## Skill Graphs > SKILL.md (단일 파일 스킬의 한계 극복)

현재 에이전트 생태계의 스킬은 대부분 단일 파일(`SKILL.md`)에 특정 기능(예: 요약, 코드 리뷰)을 담는 형태다. 하지만 심리학, 트레이딩, 법률처럼 방대하고 복잡한 도메인 지식은 하나의 파일에 담을 수 없다. 이를 해결하는 것이 **스킬 그래프(Skill Graphs)**다.

### 핵심 주장 (Core Claims)

1. **스킬 그래프란 무엇인가?**
   단일 파일 대신, 완결된 생각이나 테크닉을 담은 수많은 작은 마크다운 파일(노드)들이 `[[위키 링크]]`로 연결된 네트워크다.

2. **재귀적 점진적 공개 (Recursive Progressive Disclosure)**
   이전에 정의한 [[progressive-disclosure-optimizes-agent-context]] 패턴이 그래프 내부에서도 재귀적으로 작동한다.
   * `Index(MOC)` → `Descriptions(YAML)` → `Links` → `Sections` → `Full Content`
   * 에이전트는 본문을 다 읽기 전에 메타데이터와 링크의 문맥만으로 어떤 파일을 열지 결정한다.

3. **의미를 가지는 링크 (Prose-woven Wikilinks)**
   단순한 참조(footnote)가 아니라 문장 안에 링크를 엮어 넣는다. (예: "단순 참조가 아니라 [[의미를 가지는 위키 링크]]를 사용해야 에이전트가 그 이유를 이해하고 따라간다.")

### MOC (Map of Content)의 활용

스킬 그래프가 커지면 **인덱스 파일(MOC)**이 핵심 엔트리 포인트가 된다. MOC는 단순한 목록이 아니라, 에이전트의 '주의력(Attention)'을 올바른 방향으로 이끄는 지도 역할을 한다. MOC 내의 각 링크는 독립적인 방법론/주장(즉, 하나의 스킬)으로 연결된다.

### 시사점 및 적용

우리의 `memory/vault`는 단순한 저장소가 아니라 거대한 **Skill Graph**로 작동해야 한다. 단순히 데이터를 쌓아두는 것(`00_inbox`)을 넘어, 각 노드들이 `[[링크]]`를 통해 유기적으로 연결되어 에이전트(나)가 상황에 맞춰 필요한 지식의 경로를 탐색(Traverse)할 수 있게 만들어야 한다. 그래프를 토큰 효율적으로 운용하려면 [[progressive-disclosure-optimizes-agent-context.md]] 구조를 강제하고, 멀티 에이전트 실행은 [[shared-brain-architecture-for-agents.md]]와 결합해야 한다.

### Related Nodes
- [[progressive-disclosure-optimizes-agent-context.md]]
- [[shared-brain-architecture-for-agents.md]]
- [[anthropic_agent_architecture_insights.md]]

- **관련 레퍼런스**: [Heinrich (@arscontexta) - Skill Graphs > SKILL.md (2026.02)](https://x.com/arscontexta/status/2023957499183829467)
