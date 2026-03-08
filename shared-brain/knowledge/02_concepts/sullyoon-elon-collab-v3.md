---
title: "SULLYOON × ELON 협업 아키텍처 v3.0 (확정)"
description: "두 에이전트(SULLYOON/Claude + ELON/Kimi)의 협업 모델. Thin Orchestrator, Async Mail Protocol, ALFRED Improve Agent, Adversarial Verifier 포함."
tags: [multi-agent, orchestration, sullyoon, elon, architecture, v3]
trigger: "SULLYOON-ELON 협업 설계, 멀티 에이전트 운영, 역할 분리"
updated: "2026-03-08"
---

# SULLYOON × ELON 협업 아키텍처 v3.0

## 핵심 원칙
- **Thin Orchestrator**: SULLYOON은 분해·라우팅·합성만. 직접 실행 X.
- **Spec-as-Artifact**: 메시지 누적 금지. 파일 경유 핸드오프.
- **경로만 전달**: 파일 내용 X, 경로(path)만 넘겨 컨텍스트 보호.
- **Learning Separation**: 실행 에이전트는 지식 베이스 직접 수정 금지.

---

## 에이전트 구성

| Agent | 모델 | 채널 | 역할 | 권한 |
|---|---|---|---|---|
| **SULLYOON** | Claude Sonnet | Telegram | Conductor / Orchestrator | 전체 R/W, spawn, synthesize |
| **ELON** | Kimi Moonshot | Discord | Specialist / Scout | read + web_search + write to research/ |
| **ALFRED** | flash 3 | cron (새벽) | Improve Agent / Curator | read feedback/, write expertise.yaml |
| **Researcher** | flash 3 | 일회성 | 웹 리서치 | web_search, read only |
| **Builder** | Sonnet | 일회성 | 실행/생성 | read, write (지정 경로), exec |
| **Verifier** | flash 3 | 일회성 | 품질 게이트 수문장 | read only |

---

## 메모리 레이어 구조

```
Drive (진실의 원천 — 영구 저장):
  Shared-Workspace/
  ├── specs/              ← SULLYOON → ELON 핸드오프 스펙
  ├── research/           ← ELON 산출물
  ├── deliverables/       ← 최종 검증 산출물
  ├── feedback/           ← Verifier/Oppa 피드백 누적
  ├── mail/inbox/         ← 비동기 TASK_COMPLETE 페이로드
  ├── expertise.yaml      ← ALFRED 독점 관리 지식 베이스
  └── active-project.json ← 머신-리더블 상태

Discord (알림 레이어 — 영구 저장 금지):
  #active-tasks     ← SULLYOON이 스레드 생성, ELON 상태 알림
  #memory-decisions ← ALFRED 분석용 의사결정 로그
  (STATE는 Drive에 있고 Discord는 신호만 전달)
```

---

## 핸드오프 프로토콜 (Async Mail)

```
1. SULLYOON → specs/task-NNN-spec.json 작성
   {
     "task_id": "task-NNN",
     "assigned_to": "ELON",
     "objective": "...",
     "output_path": "research/task-NNN-result.md",
     "quality_gate": ["출처 URL", "confidence 표기", "implication 명시"],
     "deadline": "YYYY-MM-DD"
   }

2. SULLYOON → background spawn ELON (non-blocking, 다른 업무 계속)

3. ELON → 작업 완료 → research/task-NNN-result.md 저장
          → mail/inbox/TASK_COMPLETE_NNN.json 드롭
          → Discord #active-tasks 알림

4. Verifier → 자동 트리거 → 4가지 품질 게이트 검사
   ✅ Pass → deliverables/ 이동 → SULLYOON 통보
   ❌ Fail → ELON에 Re-work 지시 (최대 2회)
   ❌❌ 2회 실패 → SULLYOON 에스컬레이션

5. SULLYOON → 최종 합성 → Oppa 보고
```

---

## 품질 게이트 (Definition of Done)

산출물이 "완료"이려면 4가지 모두 충족:

| 항목 | 내용 |
|---|---|
| **Evidence** | 소스 URL 또는 검증 아티팩트 |
| **Confidence** | high/medium/low + 이유 |
| **Implication** | 이 결과가 의사결정에 미치는 영향 |
| **Next Action** | 명확한 후속 조치 또는 "종료" 선언 |

**2-Strike Rule**: Verifier가 동일 산출물 2회 Re-work 지시 시 → SULLYOON 에스컬레이션 (무한 루프 방지)

---

## ELON 내부 병렬 리서치 패턴

claw-swarm 스킬 불필요. OpenClaw 네이티브 sessions_spawn으로 구현:

```python
# ELON이 단일 task를 받아 내부에서 병렬 분해
task = read("specs/task-NNN-spec.json")
subtasks = decompose(task)  # 3-5개 독립 하위 태스크

# 병렬 spawn
sessions_spawn(researcher_A, subtask[0])  # 동시 실행
sessions_spawn(researcher_B, subtask[1])  # 동시 실행
sessions_spawn(researcher_C, subtask[2])  # 동시 실행

await_all() → synthesize() → write("research/task-NNN-result.md")
```

모델: Researcher는 flash 3 (빠름·저렴), 합성은 ELON/Kimi

---

## ALFRED (Improve Agent)

- **실행 주기**: 매일 새벽 3시 (cron)
- **입력**: `feedback/` 누적 파일 + Discord `#memory-decisions`
- **출력**: `expertise.yaml` 업데이트 (독점 소유권)
- **모델**: flash 3 (저비용)
- **원칙**: 실행 에이전트들은 expertise.yaml 읽기 전용. 쓰기는 ALFRED만.

```yaml
# expertise.yaml 구조
domain_knowledge:
  competitive_analysis:
    best_sources: [...]
    avoid: [...]
  korean_sme_market:
    key_insights: [...]
failure_patterns:
  - pattern: "..."
    fix: "..."
    date: "2026-03-08"
```

---

## 확장성 규칙

```
Level 0 (ELON 직접): 간단한 검색, 1-2 도구
Level 1 (1 Researcher): 단일 주제 딥리서치
Level 2 (3 Researchers 병렬): 비교 분석, 멀티소스
Level 3 (Researchers → Builder 파이프): 리서치 후 문서 생성
```

---

## v2 → v3 변경 요약

| 구분 | v2.0 | v3.0 |
|---|---|---|
| 상태 관리 | Drive STATE.md 수동 | Drive(영구) + Discord(알림) 분리 |
| ELON 형태 | 단일 순차 실행 | 내부 병렬 Researcher 스웜 |
| 지식 업데이트 | feedback/ 단순 누적 | ALFRED가 새벽 cron으로 expertise.yaml 자동화 |
| 검수 방식 | SULLYOON 직접 검증 | Verifier 1차 필터 → 2-strike → SULLYOON |
| 핸드오프 | 동기식 대기 | 비동기 mail/inbox/ + TASK_COMPLETE |

---

## Related Nodes
- [[adk-multi-agent-patterns-aligned-to-openclaw-quality-gates.md]]
- [[shared-brain-architecture-for-agents.md]]
- [[anthropic_agent_architecture_insights.md]]
- [[master-plan-sub-agent-management.md]]
- [[context-engineering-for-long-running-agents.md]]
