---
title: "Symphony: 자율 에이전트 오케스트레이션 시스템"
description: "OpenAI Symphony의 핵심 개념, 자율 실행 파이프라인, 작업 증명(Proof of Work) 기반 관리 체계 정리"
tags: [symphony, agent-orchestration, autonomous-systems, harness-engineering]
trigger: "에이전트 오케스트레이션, 에이전트 감독 자동화, 작업 증명, 자율 실행 파이프라인"
---

# Symphony: 자율 에이전트 오케스트레이션 시스템

## Core Claim
Symphony는 AI 코딩 에이전트를 개별적으로 관리(Supervising)하는 단계에서, 프로젝트의 목표(Goal)를 중심으로 에이전트들이 스스로 Org Chart를 구성해 작업 단위(Issue)를 완수하게 만드는 **'자율 경영(Management)'** 시스템이다.

---

## 1. 문제 정의
- **AI 도구의 병목:** 현재의 AI 코딩 도구는 개발자의 세밀한 감독(micro-management)이 필수적.
- **Cognitive Load:** 에이전트 작업이 복잡해질수록 코드 리뷰와 프롬프트 최적화에 드는 개발자의 시간이 증가함.
- **필요성:** 단순 코딩 보조를 넘어, 스스로 판단하고 작업을 완수하는 자율적 시스템(Autonomous Implementation Runs) 필요.

## 2. 주요 아키텍처 원칙

### 자율적 실행 파이프라인 (Autonomous Implementation Runs)
- **작업 단위 격리:** 이슈 트래커(Linear 등)를 모니터링하여 작업이 할당되면 독립적인 워크스페이스를 생성.
- **데몬 워크플로우:** 사람이 수동으로 명령을 내리는 대신, 시스템이 24/7 백그라운드에서 작업을 처리.

### 작업 증명 (Proof of Work)
에이전트가 코드를 병합(Land)하기 전에 관리자가 신뢰할 수 있는 다각적인 증거를 생성:
- **CI 상태:** 테스트 통과 여부 및 빌드 결과.
- **코드 리뷰:** 피드백 반영 사항 및 복잡도 분석 리포트.
- **워크스루 비디오:** 코드 동작을 시각적으로 설명하는 가이드.

---

## 3. Symphony 적용 요구 사항 (Harness Engineering)
Symphony는 단순히 에이전트만 있다고 돌아가지 않으며, 다음 환경이 선행되어야 함:
- **테스트 스위트:** 에이전트가 작성한 코드를 자동 검증할 수 있는 강력한 테스트 환경.
- **CI 환경:** 작업 증명을 자동으로 생성할 수 있는 연동된 CI 시스템.

---

## 4. 실전 가이드

### 구현 방식
1. **커스텀 구현:** [Symphony Spec](https://github.com/openai/symphony/blob/main/SPEC.md)을 참조하여 원하는 언어로 런타임 구축.
2. **참조 구현체:** [Elixir 기반 구현체](https://github.com/openai/symphony/blob/main/elixir/README.md)를 활용하여 즉시 구성.

### 에이전트 프롬프트 템플릿
```text
Implement Symphony according to the following spec: https://github.com/openai/symphony/blob/main/SPEC.md

Set up Symphony for my repository based on https://github.com/openai/symphony/blob/main/elixir/README.md
```

---
## References
- [Symphony GitHub](https://github.com/openai/symphony)
- [Symphony Specification](https://github.com/openai/symphony/blob/main/SPEC.md)
