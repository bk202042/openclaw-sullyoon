# Gemini Embedding 2 — Multimodal RAG PoC (OpenClaw)

## 목적
Gemini Embedding 2로 텍스트/이미지/오디오/영상/PDF를 **단일 임베딩 공간 + 단일 인덱스**로 통합해, 멀티모달 RAG/검색 데모를 빠르게 구현한다.

---

## 1) PoC 범위 (Scope)
**데이터 샘플 (최소 실행 세트)**
- 텍스트: 문서 20개
- 이미지: 스크린샷 50장
- 오디오: 음성 메모 10개
- 비디오: 30~60초 클립 10개
- PDF: 10개 (6페이지 이하)

**질의 시나리오 (데모 포함)**
1. 텍스트 → 이미지/영상 검색
2. 이미지 → 텍스트 검색
3. 오디오 → 이미지/텍스트 검색
4. PDF → 텍스트/이미지 검색
5. 멀티파트(텍스트+이미지) → 통합 임베딩 검색
6. 비디오 구간(짧은 클립) 검색

---

## 2) 모델/임베딩 사양
- 모델: **gemini-embedding-2-preview**
- 기본 차원: **1536** (MRL)
- 비교 옵션: 3072 (품질/정밀도 필요 시)

---

## 3) 모달별 Chunking 규칙
- 텍스트: 300~800 tokens
- 이미지: 1장=1 chunk
- 오디오: 20~40초
- 비디오: 15~30초
- PDF: 1~2페이지 단위 (6페이지 제한 고려)

---

## 4) 아키텍처 개요
### 4-1. 파이프라인
```
[Raw Input]
  → [Chunking]
  → [Embedding (Gemini Embedding 2)]
  → [Vector DB 저장]
  → [검색/리트리벌]
  → [응답 렌더링]
```

### 4-2. 저장 스키마 (예시)
- id
- vector
- metadata: { modality, source, timestamp, chunk_id, mime_type }

---

## 5) 구현 체크리스트 (실행 순서)
### A. 환경 준비
- [ ] Gemini API 키 준비
- [ ] Google GenAI SDK 설치
- [ ] Vector DB 선택 (Chroma / Qdrant)

### B. 임베딩 유틸
- [ ] `embed_text()`
- [ ] `embed_image()`
- [ ] `embed_audio()`
- [ ] `embed_video()`
- [ ] `embed_pdf()`
- [ ] `embed_multimodal(parts=[text, image])`

### C. 인덱싱
- [ ] 모달별 chunking 스크립트
- [ ] metadata 포함 저장
- [ ] 1536 차원 기준 인덱스 구축

### D. 검색/리트리벌
- [ ] 쿼리 타입 자동 감지 (텍스트/이미지/오디오)
- [ ] 단일 인덱스에서 Top-K 검색
- [ ] 결과 렌더링 (modality별)

### E. 데모 UI
- [ ] Streamlit/Gradio로 간단 UI
- [ ] 입력: 텍스트/이미지/오디오
- [ ] 출력: 텍스트/이미지/영상/PDF

### F. 품질/성능 평가
- [ ] 1536 vs 3072 성능 비교
- [ ] Latency/정확도 측정
- [ ] 대표 질의 6개 정성 평가

---

## 6) OpenClaw 적용 시나리오
- 고객 PoC 시연: **멀티모달 검색 데모**
- 콘텐츠/케이스 스터디 검색 강화 (문서 + 스샷 + 음성)
- RAG 기반 지식 검색을 멀티모달로 확장

---

## 7) 다음 단계 (옵션)
- 실제 OpenClaw 워크플로우에 연결
- 자동 수집 파이프라인 연동 (Drive/Notion/Slack 등)
- 멀티모달 질의 템플릿 제작
