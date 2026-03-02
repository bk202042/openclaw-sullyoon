# AGENT_ONBOARDING (Shared Brain) — v2

## Start protocol (all agents)
1. Read `shared-brain/priorities.md`
2. Read `shared-brain/VAULT_RULES.md`
3. If domain work: open `shared-brain/knowledge/02_concepts/MOC-agent-architecture.md`
4. Read target files before editing (`read -> edit -> verify`)
5. Execute task, then write output to `shared-brain/agent-outputs/`
6. If blocked/transfer needed, write `shared-brain/handoffs/`
7. Apply human decisions from `shared-brain/feedback/`

## Output format (required)
- Objective
- Actions taken
- Verification (how success was checked)
- Risks/open questions
- Next action

## Note quality rules
- Use YAML frontmatter (`title/description/tags/trigger`)
- Keep claims concise (Level 2)
- Move bulky raw material to `knowledge/references/` (Level 3)
- Prefer `[[wikilinks]]` to connect related nodes

## Cross-agent Quality Gate (required)
- No fabricated facts, sources, or confidence levels.
- No fake completion: if not verified, it is not done.
- If evidence is weak/blocked, state uncertainty and propose next best action.
- Keep tool usage efficient: default 0–3 calls; hard cap 10 steps per turn when feasible.
- Completion gate must include: **Evidence + Confidence + Implication + Next Action**.

## Shared Tool Routing Standard
Use minimum-effective escalation:
1. Tavily (breadth / fresh discovery)
2. Exa (precision / deep context)
3. Firecrawl (extraction / crawling)
4. Stealth browser (dynamic/hard-protected pages)
Stop escalating when evidence quality is sufficient.

## Data + Python Rule
- Use Python/ipython only for computation, dataset analysis, charts, or batch transforms.
- Do not use Python as a general fallback if shell/file tools are enough.
- If datasource preview is complete and user only needs lookup, avoid Python.
- Keep debug information separated from primary output (clean result channel, debug channel/log).

## Memory Safety Standard
- Never claim “I’ll remember” without actual memory action.
- Command params are strict: `add` needs content, `remove` needs id, `replace` needs id+content.
- Prefer `replace` over duplicate `add` for corrections.
- Never store information about minors (<18).
- If memory intent is unclear, ask clarification.
- Never expose internal memory identifiers in user-facing output.

## Presentation Standard (for demos/UI outputs)
- Prefer functional, working demonstrations over placeholders.
- Include motion/micro-interactions by default when UI output is requested.
- Avoid generic AI-slop aesthetics; use context-specific visual direction.
- Bold choices are welcome only when usability remains strong.
- For UI/browser tasks: include at least one visual verification artifact (e.g., screenshot).

## Communication Trigger Standard
Communicate with user immediately when:
- Environment/tool/runtime issues block normal flow
- Deliverables are ready for review/hand-off
- Critical info cannot be accessed with current resources
- Permission, credentials, or keys are required
Use the user’s language.

## Environment-Issue Handling
- Diagnose before concluding root cause; do not guess.
- Do not spend cycles “repairing environment” unless explicitly requested.
- Continue via alternative validation path when possible (CI/remote/indirect checks).
- Do not modify tests to pass failures unless test changes are explicitly requested.

## Coding Discipline
- Follow local file conventions before changing code.
- Verify library/framework availability before introducing usage.
- Prefer existing utilities/patterns over new abstractions.
- Run lint/tests for non-trivial changes when commands are available.
- Avoid unnecessary comments unless requested or genuinely needed for complexity.

## Planning + Scratchpad Protocol
Maintain a lightweight Scratchpad for active tasks:
- Task statement (1–2 lines)
- Plan steps with checkboxes (`[ ]` / `[x]`)
- Current blockers/risks
- Milestone reflection (what changed, what failed, next constraint)
Clear stale items when task context shifts.

## Lessons Ledger (anti-repeat)
Record reusable lessons from execution:
- Mistake/correction
- Root cause
- Preventive rule
- Reusable version/model/tooling facts
Use this to prevent repeated errors across sessions.

## Git & PR Discipline
- Never force push.
- Never use `git add .`; stage explicit files only.
- Do not change git config unless explicitly requested.
- Use multiline commit messages via file (`git commit -F <file>`) when needed.
- Prefix commit messages with `[Cursor]` when operating under Cursor-derived workflow.
- If iterating on CI and failing repeatedly (3 attempts), escalate to human review.
