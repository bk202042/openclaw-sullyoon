# Larry Skill Brief (ClawHub)

- Skill: **Larry**
- URL: https://clawhub.ai/OllieWazza/larry
- Author: **OliverHenry** (@OllieWazza)
- Version: **v1.0.0**
- Snapshot: ⭐ 101 · 7.1k · 15 current installs · 15 all-time installs

## One-line summary
TikTok 슬라이드쇼 마케팅 파이프라인(리서치 → 이미지 생성 → 텍스트 오버레이 → Postiz 게시/분석 → 일일 피드백 루프) 자동화 스킬.

## 핵심 포인트
- **운영 방식**: 초반 온보딩 대화형 진행 + 단계별(계정 워밍업, 앱 이해, 경쟁사 분석, 콘텐츠 전략, 자동 리포트) 실행.
- **콘텐츠 생성**: OpenAI `gpt-image-1.5` 권장(명시적으로 1.0 비권장), 9:16 포맷, 6슬라이드 구조, 반복 개선 루프.
- **배포/분석**: Postiz 기반 초안 게시(SELF_ONLY), 수동 사운드 추가 후 발행, 3일 윈도우 분석.
- **수익 최적화**: RevenueCat 연동 시 뷰/참여가 아닌 **전환·매출 중심** 최적화 가능.
- **주의사항**: TikTok release-id 연결은 2시간 이상 대기 후 수행(오연결 시 사실상 되돌리기 어려움).

## 보안/운영 메모
- ClawHub 보안 스캔: **OpenClaw Suspicious (medium confidence)**
- 이유: 스킬 목적과 동작은 일치하나, 메타데이터에 비해 자격증명/설정 의존도가 큼(API key/경로 관리 주의).
- 권장: 샌드박스/격리 환경에서 먼저 검증 후 본 운영 투입.

## 파일 구조(페이지 표기 기준)
- `SKILL.md`
- `references/analytics-loop.md`
- `references/app-categories.md`
- `references/competitor-research.md`
- `references/revenuecat-integration.md`
- `references/slide-structure.md`
- `scripts/add-text-overlay.js`
- `scripts/check-analytics.js`
- `scripts/competitor-research.js`
- `scripts/daily-report.js`
- `scripts/generate-slides.js`
- `scripts/onboarding.js`
- `scripts/post-to-tiktok.js`

## 원본 위치
- `/Users/macbookair/.openclaw/shared-brain/knowledge/references/clawhub/clawhub-olliewazza-larry.firecrawl.md`
- `/Users/macbookair/.openclaw/shared-brain/knowledge/references/clawhub/clawhub-olliewazza-larry.firecrawl.json`
- `/Users/macbookair/.openclaw/shared-brain/knowledge/references/clawhub/clawhub-olliewazza-larry.md`
