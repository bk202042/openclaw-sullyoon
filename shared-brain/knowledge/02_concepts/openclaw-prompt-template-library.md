---
title: "OpenClaw Prompt Template Library"
description: "Template system for reusable OpenClaw prompts (cron, morning brief, orchestration) with clear routing and cost boundaries."
tags: [openclaw, prompt-template, automation, cron]
trigger: "재사용 가능한 프롬프트 템플릿을 만들거나, 자동화 프롬프트 표준이 필요할 때"
---

## 언제 쓰는가
- 팀/개인 운영에서 반복 프롬프트를 표준화할 때
- cron 기반 자동 실행 시나리오를 설계할 때

## 입력
- 작업 유형(리서치/요약/실행/브리프)
- 실행 주기(cron)
- 비용/지연 한도

## 출력
- 템플릿화된 프롬프트 세트
- 실행 조건(Use when / Don’t use when)
- 서브에이전트 스폰 규칙

## 실패 패턴
- 템플릿 과설계로 실제 적용성이 떨어짐
- 비용 가드레일 없이 고성능 모델 남용
- 템플릿 버전 관리 부재

## Related Nodes
- [[openclaw-orchestrator-worker-patterns.md]]
- [[openclaw-configuration-and-cost-optimization.md]]
- [[openclaw-business-operating-model.md]]

## Source Inbox
- [[2026-02-26-2237_notion_openclaw-prompt-template.md]]
- [[2026-02-26-2237_notion_openclaw-prompts-use-case.md]]