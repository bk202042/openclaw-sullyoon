# OpenClaw Agent System — 점검 & 업그레이드 Cheat Sheet

> 이 문서는 2026-02-28 세션에서 수행한 OpenClaw Kimi 에이전트 점검→수리→업그레이드 전 과정을 재현 가능한 치트시트로 정리한 것입니다.

---

## Phase 0: 사전 준비

```bash
# 환경 변수
export OPENCLAW_HOME=/Users/macbookair/.openclaw-kimi
export WORKSPACE=$OPENCLAW_HOME/workspace
```

### 핵심 파일 맵

| 파일 | 역할 |
|------|------|
| $OPENCLAW_HOME/openclaw.json | 메인 설정 (모델, 채널, 보안) |
| $OPENCLAW_HOME/.env | API 키 (Groq, Tavily, Discord, Gateway) |
| $OPENCLAW_HOME/openclaw.json.bak | 설정 백업 (diff 비교용) |
| $OPENCLAW_HOME/logs/gateway.err.log | 에러 로그 (진단 핵심) |
| $OPENCLAW_HOME/logs/config-audit.jsonl | 설정 변경 이력 |
| $OPENCLAW_HOME/cron/jobs.json | 크론 작업 정의 |
| $WORKSPACE/AGENTS.md | 에이전트 행동 규칙 |
| $WORKSPACE/SOUL.md | 페르소나 & 성격 |
| $WORKSPACE/IDENTITY.md | 실행 알고리즘 |
| $WORKSPACE/TOOLS.md | 환경 설정 & 스킬 라우팅 |
| $WORKSPACE/memory/vault/MOC.md | 지식 그래프 엔트리포인트 |

---

## Phase 1: 진단 (Health Check)

### 1-1. 에러 로그 확인

```bash
# 최근 에러만 확인 (전체 로드 금지!)
tail -50 $OPENCLAW_HOME/logs/gateway.err.log
```

주요 에러 패턴과 대응:

| 에러 패턴 | 원인 | 대응 |
|----------|------|------|
| Config validation (timeFormat/exec.ask) | onboard 중 일시적 | 스키마 확인 후 무시 가능 |
| getaddrinfo ENOTFOUND | DNS 장애 | 네트워크 확인 → gateway restart |
| SlowListener exceeded 30s | 모델 cold start / 네트워크 지연 | 모니터링, 반복 시 maxConcurrent 조정 |
| ENOENT: .openclaw/workspace-kimi/... | 이전 경로 참조 잔존 | Phase 2에서 경로 수정 |

### 1-2. 설정 파일 검증

```bash
# JSON 구문 확인
cat $OPENCLAW_HOME/openclaw.json | python3 -m json.tool > /dev/null && echo "✅ Valid" || echo "❌ Invalid"

# 백업과 diff
diff $OPENCLAW_HOME/openclaw.json $OPENCLAW_HOME/openclaw.json.bak
```

### 1-3. 채널 상태 확인

```bash
OPENCLAW_HOME=$OPENCLAW_HOME openclaw channels status
```

---

## Phase 2: 수리 (Fix)

### 2-1. 경로 불일치 수정

이전 경로 `.openclaw/workspace-kimi` → 현재 경로 `.openclaw-kimi/workspace`

```bash
# 경로 참조 검색
grep -r "\.openclaw/workspace-kimi" $OPENCLAW_HOME --include="*.json" --include="*.md" --include="*.sh" --include="*.py" -l
grep -r "workspace-kimi" $WORKSPACE --include="*.md" --include="*.sh" --include="*.py" -l
```

수정 대상 (이번 세션에서 발견):

| 파일 | 수정 내용 |
|------|----------|
| cron/jobs.json | git-sync cron 경로 |
| workspace/skills/vault-manager/SKILL.md | new_vault_note.sh 경로 x2 |
| workspace/new_vault_note.sh | TARGET_DIR |
| workspace/summarize_notes.py | source_dir, output_file |

> ⚠️ sessions.json의 이전 경로는 Gateway restart 시 자동 갱신됨 — 수동 수정 불필요

### 2-2. 누락 스크립트 확인

```bash
# git-sync.sh 존재 여부
ls -la $WORKSPACE/git-sync.sh

# 없으면: GitHub에서 복원 or 새로 작성 or cron 비활성화
```

### 2-3. Gateway 재시작

```bash
OPENCLAW_HOME=$OPENCLAW_HOME openclaw gateway restart
```

---

## Phase 3: 업그레이드 (Upgrade)

### 3-1. 지식 수집 (2가지 소스)

**A. Vault 기존 지식 확인:**

```bash
ls $WORKSPACE/memory/vault/02_concepts/
cat $WORKSPACE/memory/vault/MOC.md
```

**B. NotebookLM 쿼리 (외부 최신 지식):**

```bash
# 핵심 3개 쿼리
nlm notebook query <ID> "Top 5 architectural principles for AI agents" -p <profile>
nlm notebook query <ID> "Common failure modes and guardrails" -p <profile>
nlm notebook query <ID> "Long-running task workflow structure" -p <profile>
```

### 3-2. 적용할 원칙 체크리스트

- [ ] **Context Budget Protocol** — 50%/75% 토큰 임계점 준수
- [ ] **Tool Output Discipline** — 100줄 이상은 파일로 offload
- [ ] **Memory Safety** — add/remove/replace 패턴 사용
- [ ] **Evidence Gates** — "완료" 전 end-to-end 검증
- [ ] **Anti-Patterns** — no one-shotting, no premature completion
- [ ] **Critique Protocol** — 작업 후 자체 리뷰

---

## Quick Reference

### 자주 쓰는 명령어

```bash
# 상태 확인
openclaw status
openclaw memory status
openclaw channels status

# Gateway 관리
openclaw gateway restart
openclaw gateway stop

# 로그 확인
tail -f $OPENCLAW_HOME/logs/gateway.log
tail -f $OPENCLAW_HOME/logs/gateway.err.log

# 설정 백업
cp $OPENCLAW_HOME/openclaw.json $OPENCLAW_HOME/openclaw.json.bak.$(date +%Y%m%d)
```

### 위험 신호 (즉시 점검 필요)

1. Gateway 로그에 `FATAL` 또는 `panic` 발생
2. `openclaw channels status`에서 채널 disconnected
3. `.env` 파일 누락 또는 API 키 만료
4. 세션 파일 크기 비정상 증가 (>100MB)
5. QMD 인덱스 corruption (검색 결과 없음)

---

*Source: 2026-02-28 OpenClaw Kimi Agent Maintenance Session*
*Location: shared-brain/knowledge/02_concepts/openclaw-maintenance-cheatsheet.md*

---

## Phase 3 상세: 파일별 업그레이드 체크리스트

### Round 1 — 기본 아키텍처 (Vault 기반)

- [ ] **AGENTS.md**: Context Budget Protocol (50/75% 임계값)
- [ ] **AGENTS.md**: Two-Phase Session (Init → Execute)
- [ ] **AGENTS.md**: JIT Retrieval (Progressive Disclosure)
- [ ] **AGENTS.md**: Compaction Rules
- [ ] **AGENTS.md**: Sub-Agent Delegation
- [ ] **IDENTITY.md**: 각 Algorithm 단계에 → verify: 포인트
- [ ] **IDENTITY.md**: Extended Thinking, Start Wide, Test E2E
- [ ] **TOOLS.md**: 환경 설정 + 스킬 라우팅 테이블
- [ ] **SOUL.md**: Think Before Leaping, Start Wide Then Focus
- [ ] **MOC.md**: Vault Skill Graph 엔트리포인트

### Round 2 — NLM 인사이트 (델타)

- [ ] **AGENTS.md**: Anti-Patterns (One-Shot/조기완료/연쇄오류 금지)
- [ ] **AGENTS.md**: Self-Correction (CRITIC 패턴)
- [ ] **AGENTS.md**: Clean Handoff (Git checkpoint + filesystem offloading)
- [ ] **IDENTITY.md**: One Feature at a Time
- [ ] **TOOLS.md**: ACI Tool Output Rules

### 수정 원칙

> **Karpathy Rule**: 기존 내용은 건드리지 말고, 새 섹션만 추가. 섹션 번호 재정렬은 OK.

---

## Phase 4: 검증 (Verify)

```bash
# 1. Gateway 재시작
OPENCLAW_HOME=$OPENCLAW_HOME openclaw gateway restart

# 2. 채널 상태 확인
OPENCLAW_HOME=$OPENCLAW_HOME openclaw channels status

# 3. Discord에서 테스트 질문
# → "vault에 어떤 지식이 있어?" (MOC.md 인식 확인)
# → 복잡한 작업 요청 (Anti One-Shot 작동 확인)
# → 세션 종료 시 handoff 기록 확인

# 4. 에러 로그 모니터링
tail -f $OPENCLAW_HOME/logs/gateway.err.log
```

---

## Quick Reference: AGENTS.md 최종 구조

| 섹션 | 내용 |
|------|------|
| §1 | Session Lifecycle (Two-Phase) ← Init → Execute |
| §2 | Context Budget Protocol ← 50/75% 임계값, JIT, Compaction |
| §3 | Model Routing ← Flash vs Pro |
| §4 | Memory ← daily log + MEMORY.md |
| §5 | Sub-Agent Delegation ← coding-agent 활용 |
| §6 | Anti-Patterns ← One-Shot/조기완료/연쇄오류 금지 |
| §7 | Self-Correction (CRITIC) ← 비판→반영→2-strike 전략변경 |
| §8 | Clean Handoff Protocol ← Git commit + 로그 + offloading |
| §9 | Vault Writes ← VAULT_RULES + MOC + wikilinks |
| §10 | Safety ← trash > rm |
| §11 | Groups ← 직접 요청 시만 응답 |
| §12 | Heartbeat ← HEARTBEAT.md 기반 |

---

## 세션 타임라인 템플릿

| 시간 | 단계 | 작업 |
|------|------|------|
| 15:00 | Phase 1 | 에러 로그 분석, 설정 검증, 스키마 교차 확인 |
| 15:10 | Phase 2 | 경로 불일치 4개 파일 수정, git-sync.sh 누락 발견 |
| 15:15 | Phase 3a | Vault 6개 문서 읽기 → Round 1 (5개 파일 생성/수정) |
| 15:40 | Phase 3b | NLM 3개 쿼리 → Gap Analysis → Round 2 (3개 파일 보강) |
| 15:50 | Phase 4 | 검증 대기 (Gateway restart 필요) |

---

*Last Updated: 2026-03-02*
*Source: OpenClaw Agent Maintenance Session*
