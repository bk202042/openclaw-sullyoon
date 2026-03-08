# Excalidraw Skill Brief

- Skill: **excalidraw-skill**
- Local install: `~/.openclaw/skills/excalidraw-skill`
- Purpose: Excalidraw 캔버스 요소 CRUD/정렬/그룹/스냅샷/내보내기/가져오기 자동화

## One-line summary
MCP 우선(REST fallback)으로 Excalidraw 다이어그램을 코드처럼 생성·수정·검증하는 캔버스 자동화 스킬.

## 핵심 포인트
- **모드 감지**: MCP 툴 가능 여부 확인 → 안 되면 REST API fallback.
- **핵심 기능**: element CRUD, batch 생성, 정렬/분배/그룹, snapshot/restore, 이미지/scene export.
- **품질 게이트**: 텍스트 잘림/겹침/화살표 충돌/가독성 체크를 반복 루프로 강제.
- **실무 포인트**: 화살표 바인딩(MCP: `startElementId/endElementId`, REST: `start/end{id}`) 형식 차이 주의.

## 원본(레퍼런스) 위치
- 폴더 전체: `/Users/macbookair/.openclaw/shared-brain/knowledge/references/skills/excalidraw-skill`
- 주요 파일:
  - `.../excalidraw-skill/SKILL.md`
  - `.../excalidraw-skill/references/cheatsheet.md`
  - `.../excalidraw-skill/scripts/*.cjs`
