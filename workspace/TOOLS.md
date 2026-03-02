# TOOLS.md

Local environment notes only (not general instructions).

## Add here
- Device/camera nicknames
- Host aliases / SSH shortcuts
- Preferred voices / speakers
- Channel-specific defaults (recipient IDs, routing notes)

Keep this file short and practical.

## OpenClaw 운영 런북 (멀티 프로필 + QMD 분리)

### 프로필 규칙
- default 프로필: `openclaw ...`
- kimi 프로필: `openclaw --profile kimi ...`
- `config set`, `gateway restart`, `memory status/index`는 반드시 프로필 명시.

### QMD 분리 확인
```bash
openclaw memory status --json
openclaw --profile kimi memory status --json
```
확인 포인트:
- `backend: "qmd"`
- `dbPath`가 서로 다름 (`~/.openclaw/...` vs `~/.openclaw-kimi/...`)

### 워크스페이스 분리 원칙
- default: `~/.openclaw/workspace`
- kimi: `~/.openclaw/workspace-kimi`
- `MEMORY.md`, `memory/*.md`를 두 워크스페이스 사이에서 섞어 쓰지 않기.

### 채널 담당 원칙
- Telegram ↔ default 프로필
- Discord ↔ kimi 프로필
- 같은 채널을 두 프로필이 동시에 담당하지 않기.

### 주간 점검 (권장)
```bash
openclaw doctor
openclaw --profile kimi doctor
openclaw memory status
openclaw --profile kimi memory status
```

## Skill Routing Guide

| Priority | Task Type | Tool | Location |
|----------|-----------|------|----------|
| 1순위 | Question-based search (질문 → 답변) | `tavily-search-pro` | `skills/tavily-search-pro/` |
| 2순위 | URL-based extraction (특정 사이트) | `firecrawl-mcp` | `mcporter` |
| 3순위 | Deep code & people research | `exa-mcp` | (via mcporter) |
| 최후 수단 | UI interaction (login, click) | `stealth-browser` | `skills/stealth-browser/` |
| — | Browser automation (general) | `agent-browser` | `skills/agent-browser/` |
| — | NotebookLM | `notebooklm-mcp-cli` | `skills/notebooklm-mcp-cli/` |
| — | Shared Brain ops | `shared-brain-manager` | `skills/shared-brain-manager/` |
| — | Quality guard | `skill-guard` | `skills/skill-guard/` |
| — | Quarto docs | `qmd` | `skills/qmd/` |
| — | ADHD daily planner | `adhd-daily-planner` | `skills/adhd-daily-planner/` |

## Research Tool Routing Standard (Updated 2026-03-02)

**Core Principle:** Tavily = Search-first (discovery), Firecrawl = Extraction-first (known URL)

```
리서치 요청
    ↓
질문 기반? (최신 뉴스, 모르는 주제)
    ├─ YES ──→ Tavily (search-first: multi-source + synthesis)
    ↓ NO
특정 URL/도메인? (문서, 사이트)
    ├─ YES ──→ Firecrawl (extraction-first: deep scraping)
    ↓ NO
코드/인물 관련?
    ├─ YES ──→ Exa-mcp
    ↓ NO
UI 상호작용 필요?
    └─ YES ──→ Stealth-browser
```

**Examples:**
| Query Type | Tool | Reason |
|------------|------|--------|
| "최신 AI 뉴스" | Tavily | Discovery needed |
| "OpenAI API 문서 정리" | Firecrawl | Known URL extraction |
| "Next.js 15 새 기능" | Firecrawl | docs.nextjs.io scraping |
| "누가 이 기술 만들었나" | Exa | People/code search |
| "로그인 후 데이터 추출" | Stealth-browser | UI interaction |

## Tool Output Rules (ACI)
- **Filter before context**: Never dump raw tool output into the conversation. Pipe through `head`, `grep`, or `jq` first.
- **Filesystem offload**: If a tool returns >100 lines, save to a temp file and reference the path instead of pasting inline.
- **Semantic identifiers**: When referencing files or resources, use descriptive names — not raw UUIDs or cryptic IDs.
- **Paginate**: For list commands, always limit results (`--limit`, `-n`, `head`). Request more only if needed.
