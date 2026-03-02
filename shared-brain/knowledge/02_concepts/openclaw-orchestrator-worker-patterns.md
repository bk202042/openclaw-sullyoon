---
title: "OpenClaw Orchestrator-Worker Patterns"
description: "Operational pattern for splitting complex work into orchestrator planning + specialist worker execution with artifact-based sync."
tags: [openclaw, multi-agent, orchestration, execution]
trigger: "복잡한 작업을 멀티 에이전트로 분해해야 할 때, 오케스트레이터/워커 설계를 할 때"
---

## 언제 쓰는가
- 작업 범위가 크고 병렬 처리 이득이 큰 경우
- 한 에이전트 컨텍스트 오염/과부하가 발생하는 경우

## 입력
- 목표 정의(완료 조건 포함)
- 역할 분리(Orchestrator, Workers)
- 공유 아티팩트 경로(shared-brain, git, task lock)

## 출력
- 분해된 작업 계획 + 워커별 할당
- 워커 산출물(검증 포함)
- 통합 결과 + 실패 원인 로그

## 실패 패턴
- 역할 중복으로 같은 일 두 번 함
- 아티팩트 동기화 없이 메시지로만 전달해 정보 왜곡
- 성공 기준이 모호해 "끝난 척" 발생

## Related Nodes
- [[openclaw-prompt-template-library.md]]
- [[openclaw-configuration-and-cost-optimization.md]]
- [[openclaw-dashboard-as-mission-control.md]]
- [[openclaw-business-operating-model.md]]

## Source Inbox
- [[2026-02-26-2237_notion_multi-agents.md]]
- [[2026-02-26-2237_notion_openclaw-prompts-use-case.md]]