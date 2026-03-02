---
title: "OpenClaw Dashboard as Mission Control"
description: "Use dashboard as command center for agent status, workflow visibility, and operational control across OpenClaw systems."
tags: [openclaw, dashboard, mission-control, observability]
trigger: "에이전트 운영을 시각적으로 통제하거나 모니터링 대시보드가 필요할 때"
---

## 언제 쓰는가
- 멀티 에이전트 운영에서 상태 가시성이 부족할 때
- 작업 병목/실패 원인 추적이 필요할 때

## 입력
- 모니터링 대상 에이전트/워크플로우
- 실시간 지표 요구사항(상태/지연/비용/실패)
- 배포 방식(로컬/클라우드)

## 출력
- 미션컨트롤 대시보드 구성
- 경보/관찰 지표
- 운영자 액션 루프(감지→조치→회고)

## 실패 패턴
- UI만 있고 운영 의사결정 지표가 없음
- 워크플로우 상태와 실제 결과가 분리됨
- 관측 데이터는 있는데 조치 프로세스가 없음

## Related Nodes
- [[openclaw-orchestrator-worker-patterns.md]]
- [[openclaw-configuration-and-cost-optimization.md]]
- [[openclaw-business-operating-model.md]]

## Source Inbox
- [[2026-02-26-2237_notion_openclaw-dashboard.md]]