---
title: Gemini Embedding 2 - Multimodal RAG 도입 검토
description: 구글 딥마인드의 첫 네이티브 멀티모달 임베딩 모델(Gemini Embedding 2)을 OpenClaw 및 Contents Factory의 코어 임베딩 엔진으로 도입할 수 있는지에 대한 PoC(Proof of Concept) 검토.
tags: [embedding, gemini, multimodal, rag, qmd, contents-factory]
trigger: QMD 임베딩 모델 교체, 새로운 데이터 소스(음성/비디오/이미지) 인덱싱 방안을 고민할 때.
---

# Gemini Embedding 2 도입 검토 보고서

## 1. 모델 개요
**Gemini Embedding 2**는 Google DeepMind가 2026년 3월 10일 발표한 첫 '완전 멀티모달(Natively Multimodal)' 임베딩 모델입니다.
- **핵심 특징:** 텍스트, 이미지, 비디오, 오디오, 문서(PDF)를 **단일 임베딩 공간(Unified Embedding Space)**으로 매핑합니다.
- **다국어 지원:** 100개 이상의 언어를 지원하여, 한국어 검색 품질이 비약적으로 상승할 수 있습니다.
- **유연한 차원(Matryoshka Representation Learning):** 성능과 저장 비용을 타협할 수 있도록 3072, 1536, 768 차원 등으로 다운스케일링이 가능합니다.

## 2. Contents Factory에 주는 압도적 이점 (Pros)

### A. 멀티모달 자산의 '검색 가능화'
현재 우리의 `qmd`는 **마크다운(텍스트)**만 검색 가능합니다. 하지만 이 모델을 도입하면 캡틴의 모든 지식 자산 형태를 검색할 수 있습니다.
- **음성 메모:** 캡틴이 산책 중 남긴 음성 메모(`voice-message.ogg`)를 텍스트 변환(STT) 없이 직접 임베딩하여 "어제 아이디어 낸 음성 찾아줘"가 가능해집니다.
- **이미지/도식:** `contents_factory_architecture.png` 같은 아키텍처 이미지를 "콘텐츠 팩토리 도식화된 이미지"라는 텍스트로 검색할 수 있습니다.
- **비디오/PDF:** 긴 설명 없이 비디오(최대 120초)나 PDF(최대 6페이지) 자체를 벡터 공간에 집어넣습니다.

### B. 교차 모달리티(Interleaved Modality) 이해
텍스트와 이미지가 섞여 있는 입력(예: 스크린샷이 첨부된 디스코드 질문)을 하나의 맥락으로 이해하고 임베딩하여, 더 정확한 답변 생성이 가능합니다.

## 3. 우리 시스템(OpenClaw + QMD) 도입 시 제약 사항 (Cons)

### A. QMD 구조와의 충돌 (완전 로컬 vs 클라우드 API)
- 현재 우리가 쓰는 `tobi/qmd` 엔진은 비용과 프라이버시를 위해 **'로컬 GGUF 모델'**(`embeddinggemma-300M` 등)을 사용합니다.
- Gemini Embedding 2는 **Gemini API** 또는 **Vertex AI**를 통해 호출해야 하는 클라우드 기반 모델입니다.
- **문제점:** `qmd`의 기본 철학(All Local)과 충돌하며, 방대한 마크다운과 디스코드 데이터를 인덱싱할 때마다 구글 API 비용이 발생합니다.

### B. 비용 및 속도 트레이드오프
로컬 모델은 초기 인덱싱 시간만 들고 유지비가 0원이며, 오프라인에서도 작동합니다. 반면 이 모델은 강력한 멀티모달 성능을 얻는 대신 API 종속성이 생깁니다.

## 4. 최종 제안 및 실행 계획 (Execution Plan)

지금 당장 `qmd`의 기본 엔진을 이것으로 통째로 갈아치우는 것은 구조적으로 맞지 않습니다. 대신 **'투 트랙(Two-Track)' 하이브리드 전략**을 제안합니다.

1. **텍스트 기반 지식 (현재):**
   - 기존의 `qmd` 시스템은 캡틴의 요청대로 **한국어 지원이 강력한 로컬 텍스트 모델(`Qwen3-Embedding-0.6B-GGUF`)**로 교체하여 프라이버시와 속도를 유지합니다.
2. **멀티모달 에셋 풀 (신규 구축):**
   - 이미지, 음성, 비디오, PDF 등은 `Gemini Embedding 2`를 사용하여 벡터 DB(예: ChromaDB 또는 Qdrant)에 별도로 인덱싱하는 **'미디어 전용 RAG 파이프라인'**을 구축합니다.
   - 캡틴이 "이 음성 메모 바탕으로 글 써줘"라고 하면, 에이전트가 Gemini API를 호출해 해당 미디어를 불러옵니다.

이 방향으로 투 트랙을 타는 것이 캡틴의 비즈니스(Contents Factory)에 가장 강력한 무기가 될 것입니다. 동의하시면 먼저 `qmd` 텍스트 엔진을 `Qwen3`로 교체하는 작업부터 시작할까요?