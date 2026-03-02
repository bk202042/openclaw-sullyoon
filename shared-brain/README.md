# 🧠 Shared Brain (Conductor OS)

This is the **single shared context** for all agents.  
No agent-to-agent chat maze. Everyone reads/writes the same brain.

## Core Philosophy

- **Knowledge = Code**: structured, composable, maintainable.
- **Depth > Breadth**: fewer, better notes with clear claims.
- **Progressive Disclosure**: load minimal context first, drill deeper only when needed.

## Canonical Structure

- `priorities.md` — top active goals (highest priority truth)
- `agent-outputs/` — timestamped deliverables from each agent
- `feedback/` — human approval/rejection + lessons learned
- `handoffs/` — explicit next-step transfers between agents
- `knowledge/` — long-term knowledge graph
  - `00_inbox/` raw captures
  - `01_stack/` curated references/working notes
  - `02_concepts/` stable claim notes
  - `03_projects/` project-specific synthesis
  - `references/` deep docs, transcripts, large snippets
- `context/` — short-lived active execution context

## Progressive Disclosure (3 Levels)

1. **Level 1 — Identification (required YAML frontmatter)**
   - Every knowledge note starts with: `title`, `description`, `tags`, `trigger`.
2. **Level 2 — Core Claims**
   - Keep body concise and actionable.
   - Prefer claim-style filenames.
   - Use meaningful `[[wikilinks]]` in prose.
3. **Level 3 — Deep Dive**
   - Put long raw data in `knowledge/references/`.
   - Link from Level 2 notes instead of bloating them.

## Operating Loop (Mandatory)

When new info arrives in `knowledge/00_inbox/`:
1. **Analyze** the raw input.
2. **Scan** existing notes for overlap (`01_stack`, `02_concepts`, `03_projects`).
3. **Synthesize** into the right folder with YAML + links.
4. **Maintain** composability (split bloated notes, avoid dump files).

## Multi-Agent Contract

- Orchestrator reads `priorities.md` first.
- Specialists drop outputs in `agent-outputs/` as `YYYY-MM-DD-HHMM_<agent>_<topic>.md`.
- If work is blocked/needs transfer, create a handoff in `handoffs/`.
- Human decisions always go to `feedback/` so all agents learn from the same signal.

## Quality Bar

- No giant monolithic docs when modular notes are possible.
- No orphan notes without tags/trigger.
- No silent assumptions: write explicit success criteria in outputs.
