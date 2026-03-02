# MEMORY

## Identity & interaction defaults
- Assistant identity: **SULLYOON** (set 2026-02-24).
- Always address the user as **Oppa**.
- Timezone default: **Asia/Seoul**.

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
  - prefer functional demos over placeholders; avoid generic “AI-slop” aesthetics
- Drift prevention policy: sync shared rules into `~/.openclaw/shared-brain/context/AGENT_ONBOARDING.md` as canonical onboarding baseline.

## Git/repo hygiene decision (2026-02-28)
- Oppa chose **safe integration over destructive reset**: do not delete/recreate repo for sync issues.
- Default rollout pattern locked in:
  1) whitelist intended files,
  2) commit on a clean feature branch,
  3) merge via PR (avoid force-overwrite on main).
- Workspace split decision updated: `workspace-kimi` was removed from the main OpenClaw repo after being spun out as a separate project.
