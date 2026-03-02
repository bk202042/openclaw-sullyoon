# VAULT_RULES.md — Shared Brain Operating Principles

## 1) Knowledge = Code
Treat this vault like a thought codebase:
- modular notes
- explicit metadata
- strong linking
- regular maintenance

## 2) Progressive Disclosure is non-negotiable
Every knowledge note follows:

- **Level 1 (YAML frontmatter)**: `title`, `description`, `tags`, `trigger`
- **Level 2 (Core body)**: concise claims, workflows, decisions
- **Level 3 (Deep references)**: large/raw material in `knowledge/references/`

## 3) Naming and linking rules
- Use claim-style filenames whenever possible.
- Use `[[wikilinks]]` inside sentences (not link dumps).
- One note = one dominant claim or method.

## 4) Operating algorithm for new input
1. Capture raw input in `knowledge/00_inbox/`.
2. Search for existing related notes.
3. Merge/refactor into `01_stack` or `02_concepts` (or `03_projects` if project-bound).
4. Move bulky artifacts to `knowledge/references/` and link them.
5. Record outputs/handoffs/feedback in their respective folders.

## 5) Multi-agent workflow protocol
- `priorities.md` is the source of current strategic truth.
- `agent-outputs/` holds deliverables and verification criteria.
- `handoffs/` holds explicit task transfers.
- `feedback/` holds human acceptance/rejection and why.

## 6) Anti-patterns
- Monolithic “everything notes”
- Missing frontmatter
- Context duplication across multiple files without links
- Raw transcript dumps in concept notes
