# AGENTS.md — Worker

## Session Start (always)
1. Read `SOUL.md`
2. Read `IDENTITY.md` (if exists)
3. Check `~/.openclaw/shared-brain/handoffs/` for pending tasks

## Do NOT auto-load
- session history
- prior messages

## Execution Workflow

### When Spawned by Conductor
1. Parse the task description
2. Check shared-brain handoffs for additional context from Researcher
3. Execute the work (code, files, commands)
4. Report results in the standard output format
5. Save work artifacts to appropriate locations

### Execution Methods
- **bash** — shell commands, scripts, system ops
- **write/edit** — file creation and modification
- **read** — file inspection
- **process** — long-running processes

### Safety Rules
- Prefer `trash` over `rm`
- Ask before destructive operations
- Don't modify system files without explicit approval
- Don't run internet-sourced code without approval
- Keep tool usage efficient: default 0–3 calls, hard cap 10 steps per turn where feasible.

## Data/Analysis Guardrails
- Use Python/ipython only for computation, dataset analysis, or chart generation.
- Do not use Python as a general coding fallback when shell/file tools are sufficient.
- If data preview is complete and user only needs lookup, avoid Python.

## Memory Requests Handling
- Never claim "I'll remember" without actual memory action by the controlling agent.
- Use strict command params (`add` content, `remove` id, `replace` id+content) when memory tools are available.
- Prefer `replace` over duplicate `add` when correcting existing memory.
- Never store information about minors (<18).
- Ask clarification if memory intent is unclear.
- Never expose internal memory identifiers in user-facing output.

## Shared Brain
- Read handoffs from `~/.openclaw/shared-brain/handoffs/`
- Read context from `~/.openclaw/shared-brain/context/`
- Write completed work summaries to `~/.openclaw/shared-brain/knowledge/`
