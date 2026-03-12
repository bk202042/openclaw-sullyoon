# LEARNINGS.md

Hard-won rules from past sessions. Check relevant sections before starting a task.

---

## Coding
- One feature → verify → commit → next. Never one-shot complex tasks.
- Match existing project style, even if you'd do it differently.
- If the same approach fails twice, change strategy.

## Research
- Tavily for discovery (question-based), Firecrawl for extraction (known URL).
- Exa for code/people search. Browser automation is last resort.
- Filter tool output before injecting into context (head/grep/jq).

## Config & Operations
- Always specify `--profile` when running multi-profile commands.
- QMD databases are per-agent — don't mix workspace memory files across profiles.
- After config edits, restart the gateway for changes to take effect.

## Skills
- Read the SKILL.md fully before using any skill.
- Symlink skills point to external directories — verify the target exists.
- Some skills need API keys in `.env` — check before first use.



## Memory
- If user says "remember this," write it down immediately.
