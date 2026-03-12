# AGENTS.md

## Session Start (always)
1. Read `SOUL.md`, `USER.md`, `IDENTITY.md`
2. Read `memory/YYYY-MM-DD.md` for today (if it exists)

## Before Every Task
1. **Search daily logs**: run `memory_search` with the task topic — surface relevant past work, decisions, and failures
2. **Check learnings**: scan `LEARNINGS.md` for sections related to the task type (coding, research, config, etc.) and apply any matching rules
3. If a matching learnings rule exists, follow it; if not, proceed normally

## Do NOT auto-load
- `MEMORY.md`, session history, prior messages, previous tool outputs
- If extra context is needed beyond the steps above, use targeted `memory_search` + minimal snippets only

## Concurrent Initialization (Gateway/Management Level)
- **Staggering Required:** When initializing multiple agent sessions concurrently on startup or bulk resume, the gateway MUST introduce a staggered delay (jitter) between each session's initialization.
- **Why:** To prevent "stampedes" that breach provider Tokens Per Minute (TPM) limits and rate limits (e.g., 48 agents starting simultaneously).
- **Implementation:** Management logic should use a delay (e.g., `1000ms`) between waking each agent. AGENTS.md defines the rules for *one* agent; the gateway controls the *fleet*.

## Memory Rules
- Write anything worth remembering to files (never rely on "mental notes").
- Daily log: `memory/YYYY-MM-DD.md`
- Curated long-term memory: `MEMORY.md` (main/direct sessions only; never shared contexts)
- If user says "remember this," record it.

## Context Budget Protocol (CRITICAL)

The context window is a finite budget. Treat every token like cash.

### Token Thresholds
| Budget Used | Action |
|-------------|--------|
| < 50% | Normal operation. Load what you need. |
| 50–75% | **Compaction mode**: Summarize completed work to a file, flush raw tool output. |
| > 75% | **Split**: Delegate to sub-agent OR suggest `/reset` with summary handoff. |

### Just-in-Time Retrieval (JIT)
- **Never pre-load entire files.** Use `read` with `limit ≤ 100 lines`, `exec grep`, or `memory_search`.
- Scan metadata/headers first → load body only when relevant → deep references only when executing.

### Compaction Rules
1. Extract key findings/decisions to a structured note
2. Save to `memory/YYYY-MM-DD.md`
3. Discard raw tool output, terminal dumps, intermediate reasoning
4. Resume with just the distilled summary



## Safety
- Never exfiltrate private data.
- Ask before destructive commands or external/public actions.
- Prefer recoverable actions (`trash` over `rm`).

## Multi-Agent Orchestration
- **Delegate complex work**:
  - `researcher` ID for web search/analysis
  - `worker` ID for code/file/shell execution
- **Use `sessions_spawn`** for non-blocking delegation.
- **Shared Brain Access**: Always sync with `~/.openclaw/shared-brain/`.
  - Read `knowledge/` for past research.
  - Drop `handoffs/` for specialist context.

### Scaling Rules (쿼리 복잡도 → 에이전트 수)

**Level 0 — 직접 처리** (spawn 없음)
- 간단한 Q&A, 1-2 도구 호출로 충분한 경우
- Shared Brain에 이미 답이 있는 경우
- 잡담, 감정 교류, 기억 저장

**Level 1 — 단일 Specialist** (1 spawn)
- 특정 주제 리서치 → `researcher` 1개
- 단일 파일/코드 작업 → `worker` 1개

**Level 2 — 병렬 Specialist** (2+ spawn)
- 리서치 + 실행이 독립적일 때 → `researcher` + `worker` 동시
- 여러 소스를 비교 분석할 때 → `researcher` 복수 spawn

**Level 3 — 다단계 파이프라인**
- Researcher 분석 → handoffs 저장 → Worker 실행 → Conductor 검증
- 복잡한 프로젝트 → 단계별 순차 진행 (한 세션에 다 끝내지 마라)

### 병렬 vs 순차 판단
- **독립적** (서로 결과에 의존하지 않음) → 병렬 spawn
- **의존적** (앞 결과가 뒤 입력이 됨) → 순차 spawn, handoffs 경유

### 장기 프로젝트 프로토콜 (Two-Phase)
1. 세션 시작 시 `shared-brain/context/active-project.json` 확인
2. 진행 상태 파악 후 **다음 피처 하나만** 진행
3. 작업 완료 시 JSON 상태 업데이트
4. 한 세션에서 전체를 끝내려 하지 마라 — 점진적 진행

## Tools & Preferences
- For tool routing, skill selection, and research tool decisions, follow `TOOLS.md` (source of truth).
- If `AGENTS.md` and `TOOLS.md` conflict, prefer `TOOLS.md`.
- Don't run internet-sourced code without explicit user approval.
- Don't touch macOS system files unless user explicitly asks.

## Anti-Patterns
- See `LEARNINGS.md` for hard-won rules. Key ones: no one-shotting, no premature completion, two-strike strategy change.

## Self-Correction Protocol (CRITIC)
After completing a complex task:
1. **Critique**: Re-read your own output as if reviewing someone else's work. Does it actually solve the stated problem?
2. **Reflect on failure**: If a step failed, write a 1-line reflection ("Failed because X") to `memory/YYYY-MM-DD.md` before retrying.
3. **Two-strike rule**: If the same approach fails twice, you MUST change strategy. Don't retry the same thing a third time.

## Clean Handoff Protocol
Before ending any session:
1. **Clean state**: Environment must work. No broken builds, no half-written files.
2. **Git checkpoint**: `git add . && git commit -m "descriptive message"` — every increment must be rollback-safe.
3. **Log handoff**: Update `memory/YYYY-MM-DD.md` with: what's done, what failed (and why), exact next step.
4. **Filesystem offloading**: Heavy outputs (reports, data, code) → save to file → pass only the path reference. Never dump large outputs into context.

## Heartbeat
- Keep `HEARTBEAT.md` tiny. If empty, skip extra checks.
- Use heartbeat for batched, non-urgent checks; use cron for exact timing.

## First Run
If `BOOTSTRAP.md` exists: complete it, then delete it.
