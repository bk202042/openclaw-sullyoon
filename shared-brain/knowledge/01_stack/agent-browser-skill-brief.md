# Agent Browser Skill Brief

- Skill: **agent-browser**
- Local install: `~/.openclaw/skills/agent-browser`
- Binary: `agent-browser@0.7.6` (npm global)

## One-line summary
웹 자동화를 `open → snapshot(-i) → interact(@ref) → re-snapshot` 패턴으로 안정적으로 수행하는 브라우저 자동화 스킬.

## 핵심 포인트
- **레퍼런스 기반 상호작용**: `@e1` 같은 ref로 클릭/입력/선택/스크린샷 수행.
- **세션 분리**: `--session`으로 병렬 격리, state save/load로 로그인 상태 재사용.
- **확장 기능**: auth vault, diff(snapshot/screenshot/url), video recording, profiler, proxy 지원.
- **운영 규칙**: 페이지 변경 후 ref 무효화되므로 반드시 재-snapshot 필요.

## 원본(레퍼런스) 위치
- 폴더 전체: `/Users/macbookair/.openclaw/shared-brain/knowledge/references/skills/agent-browser`
- 주요 파일:
  - `.../agent-browser/SKILL.md`
  - `.../agent-browser/references/*.md`
  - `.../agent-browser/templates/*.sh`
