# MEMORY

## Durable operating decisions
- Obsidian vault `kepano-obsidian-claw` now follows a strict OS-style workflow:
  - `CLAUDE.md` defines mission, folder semantics, start protocol, writing/linking principles, and guardrails.
  - `VAULT_INDEX.md` is the active high-signal index.
  - Agents boot by reading `CLAUDE.md` + `VAULT_INDEX.md` + relevant MOC first.
- Naming convention is now claim-style for both `Notes/` and `Clippings/` (first-pass standardization completed).
- Promotion policy established: strategic/operational clippings are promoted into `Notes/`; inbox/triage/archive/reference material stays in `Clippings/`.

## Monetization pattern to reuse
- Highest-signal creator monetization loop observed:
  1) ship paid artifact updates,
  2) add conversion support (e.g., buyer email support),
  3) open distribution channels (short-form/TikTok/reels),
  4) enforce deterministic QA/automation for repeatable delivery.

## Business asset direction
- Oppa plans to use Moltbot-related notes as core source material for a one-person business.
- This was reaffirmed on 2026-02-26 as an execution priority (not just an idea).
- Operational implication: prioritize indexability, consolidation, and long-term retrievability of Moltbot notes for reuse in offerings/content/operations.

## Agent operating standardization (2026-02-27)
- Oppa approved full prompt/protocol upgrades across **researcher / worker / conductor**.
- Durable cross-agent standard established:
  - tool routing escalation: Tavily → Exa → Firecrawl → Stealth
  - evidence + quality gates before marking tasks complete
  - strict memory safety rules (`add/remove/replace` params, no minors, no memory-id exposure)
  - prefer functional demos over placeholders; avoid generic "AI-slop" aesthetics
- Drift prevention policy: sync shared rules into `~/.openclaw/shared-brain/context/AGENT_ONBOARDING.md` as canonical onboarding baseline.

## Git/repo hygiene decision (2026-02-28)
- Oppa chose **safe integration over destructive reset**: do not delete/recreate repo for sync issues.
- Default rollout pattern locked in:
  1) whitelist intended files,
  2) commit on a clean feature branch,
  3) merge via PR (avoid force-overwrite on main).
- Workspace split decision updated: `workspace-kimi` was removed from the main OpenClaw repo after being spun out as a separate project.

## Security posture decision (2026-03-02)
- Identified CRITICAL: Telegram `groupPolicy="open"` + elevated tools = prompt injection risk
- Recommended fix: `allowlist` policy + `workspaceOnly=true` for filesystem tools
- kimi profile has ongoing Discord latency issues (30s-10min timeouts) and Google AI API timeouts - needs root cause analysis, not just symptom tracking
- Durable ops pattern: `openclaw status` can look healthy while severe security misconfigurations remain; always pair health checks with `openclaw security audit`.
- Carryover state reaffirmed (2026-03-03): security mitigation is still pending; treat posture as unresolved-high-risk until allowlist + workspace-only controls are actually applied.

## Operational hygiene pattern (2026-03-05)
- Night checkpoint surfaced missing same-day daily log file; this is a repeatable execution risk.
- Durable fix: create/update `memory/YYYY-MM-DD.md` early in the day (not only at night) so nightly distillation has source-of-truth input.
- Reconfirmed on 2026-03-07 and 2026-03-08: if today's log is missing at checkpoint time, treat it as a process failure and create a minimal dated entry immediately.

## SULLYOON × ELON Architecture v3.0 (finalized 2026-03-08)
Full spec: `shared-brain/knowledge/02_concepts/sullyoon-elon-collab-v3.md`. Key decisions: Drive = state store (not Discord), ALFRED nightly reflection agent, async mail protocol, Flash 3 adversarial verifier, native `sessions_spawn` for parallelism.

## Config / tooling decisions (2026-03-08)
- Eraser MCP added to mcporter (`~/.mcporter/mcporter.json`). `ERASER_API_TOKEN` is a placeholder — needs real token.
- Claude models (Anthropic): Oppa adding Sonnet 4.6 (primary) + Opus 4.6 (fallback). Syntax fix: use `agents.defaults.model.fallbacks` (array), not `model.fallback`.
- iMessage `groupAllowFrom` is empty while `groupPolicy="allowlist"` → all iMessage group messages silently dropped. Low priority but worth fixing.

## Cross-instance skill/config parity pattern (2026-03-09)
- Oppa is actively enforcing **name parity + install parity** between `openclaw` and `openclaw-kimi` instances.
- Durable convention: align identical capabilities under the same server/skill key names across instances (example adopted: mcporter key normalized to `google-cli-docs`).
- `google-cli-docs` and `gemini-cli-docs` were installed into default OpenClaw skills to reduce profile drift.
- Integration decision: when importing external skills with strong vendor-CLI assumptions (e.g., Anthropic `skill-creator`), prefer **side-by-side install under a distinct name first**, validate in OpenClaw, then promote.
- Kimi skills root is strict: **symlinks resolving outside the configured root are skipped**. Fix by installing skills directly into `workspace-kimi/skills` or aligning skills root; **AUTH_TOKEN/CT0 env vars are profile-specific**.

## Tooling reliability (2026-03-12)
- `memory_search` currently fails because Gemini embedding API key is missing/invalid; restore provider config to re-enable recall.

## Backup operations (2026-03-09)
- Daily backup workflow reaffirmed for both instances (`openclaw`, `openclaw-kimi`) with same-day upload to Google Drive `OpenClaw/01_Backup/YYYY-MM-DD`.
- Durable value: keep dual-instance restore points synchronized by date to simplify rollback and incident recovery.
