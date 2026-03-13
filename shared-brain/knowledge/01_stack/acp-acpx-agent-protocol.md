## Level 6 — 콘텐츠 발행 에이전트 (Publisher) 오케스트레이션

### 목표
'콘텐츠 팩토리'의 최종 단계인 소셜 미디어 배포를 acpx로 자동화하여, 리서치/에디팅된 원고를 링크드인/X에 즉시 발행.

### Publisher 에이전트 설정 및 실행 예시

```bash
# 1. 콘텐츠 발행 전용 세션 생성
acpx claude sessions new --name publisher

# 2. 기획된 콘텐츠 발행 작업 위임 (Provenance 추적 포함)
acpx claude --provenance meta+receipt -s publisher "
  1. memory/briefs/openclaw_x_brief.md 내용을 읽어라.
  2. 링크드인 포맷에 맞춰 본문 250자 이내로 재작성하라.
  3. 관련 해시태그를 추가하여 포스팅 초안을 생성하라.
  4. 최종 승인 대기 단계까지 수행하라.
"
```

### 작업 흐름(Workflow)
1. **리서처(Research)**: `bird` 스킬로 데이터 수집.
2. **에디터(Editor)**: `summarize` 스킬로 본문 작성.
3. **발행자(Publisher)**: 위 `acpx claude` 세션으로 넘겨 최종 배포.


## Core Claim

ACP(Agent Client Protocol)는 에이전트 간 표준 통신 프로토콜이고,
acpx는 이 프로토콜을 headless CLI에서 구조적으로 사용하기 위한 실전 도구다.
PTY 터미널 스크래핑 없이 Codex, Claude Code, Pi, OpenClaw를 단일 인터페이스로 제어한다.

---

## Level 1 — 한 줄 요약 (빠른 참조)

| 도구 | 역할 |
|------|------|
| `openclaw acp` | OpenClaw 게이트웨이 ↔ IDE/외부 ACP 클라이언트 브릿지 |
| `openclaw acp client` | 브릿지 디버그용 인터랙티브 테스트 클라이언트 |
| `acpx` | 모든 ACP 에이전트를 headless CLI로 제어하는 범용 클라이언트 |

---

## Level 2 — ACP 개념 상세

### ACP란?

Agent Client Protocol. 에이전트 간 또는 에이전트-도구 간 표준 메시지 프로토콜.

- 에이전트→에이전트 위임 (sub-agent spawn, 핸드오프)
- 에이전트→IDE 연결 (Cursor, VS Code 등)
- 에이전트→툴/스킬 실행

### OpenClaw 3.8 — ACP Provenance Tracking

3.8에서 추가된 핵심 기능. 에이전트 대화에 "출처 추적 영수증" 부착.

```
before: A → B → C (블랙박스, 누가 뭘 했는지 불명)
after:  A → B → C (각 단계에 trace ID + lineage 기록)
```

**provenance 모드 3가지:**

| 모드 | 설명 |
|------|------|
| `off` | 추적 없음 (기본) |
| `meta` | 출처 메타데이터만 부착 |
| `meta+receipt` | 메타데이터 + 수신 확인까지 |

**사용법:** config 저장 불가 → CLI 플래그로만 사용

```bash
openclaw acp --provenance meta+receipt --session agent:main:main
```

---

## Level 3 — openclaw acp 실전 활용

### 세션 타겟팅

```bash
# conductor 직접
openclaw acp --session agent:main:main

# researcher 직접
openclaw acp --session agent:researcher:main

# kimi 인스턴스 (포트 19001)
openclaw acp --url ws://127.0.0.1:19001 --session agent:main:main

# 기존 세션에 붙기 (라벨 기반)
openclaw acp --session-label "support inbox"
```

### 인스턴스 간 크로스 연동

```bash
# default → kimi 인스턴스 프롬프트 전달 (provenance 추적 포함)
openclaw acp \
  --url ws://127.0.0.1:19001 \
  --provenance meta+receipt \
  --session agent:main:main
```

### 호환성 매트릭스

| 기능 | 상태 |
|------|------|
| 기본 프롬프트/세션 | ✅ 완전 지원 |
| 세션 목록/slash commands | ✅ 완전 지원 |
| 스트리밍 도구 호출 | ⚠️ 부분 지원 |
| loadSession (히스토리 재생) | ⚠️ 텍스트만 (툴 히스토리 미복원) |
| per-session MCP 서버 | ❌ 미지원 |
| 파일시스템 메서드 | ❌ 미지원 |
| 터미널 스트리밍 | ❌ 미지원 |

---

## Level 4 — acpx 완전 가이드

### 설치

```bash
npm install -g acpx@latest

# skill 설치 (레퍼런스 포함)
npx acpx@latest --skill install acpx
```

### 지원 에이전트

| 명령어 | 에이전트 | 비고 |
|--------|---------|------|
| `acpx codex` | OpenAI Codex CLI | 기본 에이전트 |
| `acpx claude` | Claude Code | Anthropic |
| `acpx pi` | Pi Coding Agent | github.com/mariozechner/pi |
| `acpx openclaw` | OpenClaw ACP 브릿지 | 로컬 게이트웨이 |
| `acpx --agent <cmd>` | 커스텀 에이전트 | escape hatch |

### 핵심 명령어

```bash
# 기본 프롬프트
acpx codex "fix the failing tests"
acpx claude "refactor auth module"
acpx openclaw exec "summarize active session state"

# 세션 관리
acpx codex sessions new              # 새 세션 생성
acpx codex sessions new --name api   # 이름 있는 세션
acpx codex sessions list             # 세션 목록
acpx codex sessions history          # 최근 히스토리
acpx codex status                    # 현재 세션 상태

# 병렬 작업 (같은 repo)
acpx codex -s bugfix "isolate flaky test"
acpx codex -s release "draft release notes"

# 비동기/파이프
acpx codex --no-wait "draft migration plan"    # fire-and-forget
acpx codex --file prompt.md                    # 파일에서 프롬프트
echo "fix tests" | acpx codex                  # stdin

# one-shot (세션 저장 없음)
acpx codex exec "what does this repo do?"

# 취소
acpx codex cancel
```

### 권한 제어

```bash
acpx --approve-all codex "apply patch and run tests"   # 모든 툴 자동 승인
acpx --approve-reads codex "inspect repo structure"    # 읽기만 자동 승인 (기본)
acpx --deny-all codex "explain capabilities"           # 툴 접근 없음
```

### 출력 포맷

```bash
acpx --format text codex "summarize findings"   # 기본
acpx --format json codex exec "review files"    # JSON
acpx --format quiet codex "final answer only"   # 최종 출력만
```

### config 파일

```json
// ~/.acpx/config.json 또는 .acpxrc.json (프로젝트)
{
  "defaultAgent": "codex",
  "defaultPermissions": "approve-reads",
  "ttl": 300,
  "format": "text"
}
```

---

## Level 5 — Oppa 시스템 통합 아키텍처

```
SULLYOON (conductor) — Telegram 인터페이스
    │
    ├── sessions_spawn (현재 방식)
    │       └── researcher / worker 서브에이전트
    │
    └── acpx (신규 추가 권장)
            ├── acpx codex -s <task> "코딩 작업"
            ├── acpx claude -s <task> "리팩터링"
            └── acpx openclaw "kimi 인스턴스 위임"
                    └── ws://127.0.0.1:19001
```

**acpx + provenance 조합:**

```bash
# SULLYOON이 Codex에 위임 + 전체 추적
acpx codex --provenance meta+receipt "fix auth bug"
```

### 언제 acpx vs sessions_spawn?

| 상황 | 추천 |
|------|------|
| 코딩 작업 (파일 수정, 테스트) | `acpx codex` or `acpx claude` |
| 리서치/분석 위임 | `sessions_spawn` (researcher) |
| 장기 세션 유지 필요 | `acpx` (persistent sessions) |
| 단발성 one-shot | `acpx exec` |
| 인스턴스 간 크로스 연동 | `acpx openclaw --url ws://127.0.0.1:19001` |

---

## Why it matters

- PTY 스크래핑의 불안정성 제거 → 구조적 ACP 메시지로 대체
- 에이전트 체인 전체 추적 가능 (provenance)
- Codex/Claude Code/Pi/OpenClaw를 단일 인터페이스로 통합
- 병렬 named sessions → 복잡한 멀티태스킹 가능
- fire-and-forget + queue → 비동기 에이전트 오케스트레이션

---

## References
- [OpenClaw ACP CLI docs](https://docs.openclaw.ai/cli/acp)
- [acpx GitHub](https://github.com/openclaw/acpx)
- [ACP Spec](https://agentclientprotocol.com)
- [acpx SKILL.md](https://raw.githubusercontent.com/openclaw/acpx/main/skills/acpx/SKILL.md)
- [acpx CLI 전체 레퍼런스](https://raw.githubusercontent.com/openclaw/acpx/main/docs/CLI.md)
