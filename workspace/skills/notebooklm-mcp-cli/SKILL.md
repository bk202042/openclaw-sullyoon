---
name: notebooklm-mcp-cli
description: Use the NotebookLM CLI (`nlm`) to create/query notebooks, add sources, synthesize research, and build context-efficient workflows. Trigger when users ask to research with NotebookLM, query existing notebooks, onboard large codebases into NotebookLM, or automate NotebookLM pipelines.
---

# NotebookLM MCP CLI Skill

Use `nlm` for NotebookLM-first research and retrieval.

## Quick checks

Run before any workflow:

```bash
nlm --version
nlm notebook list
```

If these fail, stop and report setup/auth issue.

## Workflow 1: Second-brain debugging loop

Use when a user asks to fix an error or implement a feature from docs.

1. Find a relevant notebook:

```bash
nlm notebook list
```

2. Query it:

```bash
nlm query notebook <notebook-id> "How do I fix <error>?"
nlm query notebook <notebook-id> "Implementation pattern for <feature>?"
```

3. Apply result to code/task.
4. If a new reusable solution was found, save it back:

```bash
nlm note create <notebook-id> -t "Debug Note" -c "<short solution note>"
```

## Workflow 2: Deep research pipeline

Use when user wants topic research without bloating chat context.

1. Create notebook:

```bash
nlm notebook create "Research: <topic>"
```

2. Add sources (5-10 URLs):

```bash
nlm source add <notebook-id> --url "https://..."
```

3. Synthesize:

```bash
nlm query notebook <notebook-id> "Summarize key trends, technical details, and risks for <topic>. Separate facts vs assumptions."
```

4. Return concise summary + action items.

## Workflow 3: Codebase onboarding with repomix

Use when a repo is large and user wants architecture understanding via NotebookLM.

1. Pack repository:

```bash
repomix .
```

2. Upload packed file:

```bash
nlm source add <notebook-id> --file <packed-file> --wait
```

3. Build architecture view:

```bash
nlm mindmap create <notebook-id>
```

4. Query targeted flows/modules:

```bash
nlm query notebook <notebook-id> "Map request flow for <feature/module>."
```

## Output rules

- Keep outputs short and operational.
- Mark uncertain claims explicitly.
- If citations are shown, include only verifiable sources.
- If sources are missing/empty, say so directly and avoid fake citation brackets.
