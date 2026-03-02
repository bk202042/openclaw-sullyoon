# exa-research

## Purpose
High-signal web, company, people, and deep research using the Exa MCP.

This skill wraps the Exa MCP (https://mcp.exa.ai/mcp) and provides structured,
source-grounded research capabilities inside OpenClaw.

## When to Use
Use this skill when the user asks for:
- Web or market research
- Company or startup analysis
- People background research
- Codebase or technical context lookup
- Crawling-based answers
- Deep, multi-step research tasks

## Available MCP Tools
- web_search_exa
- web_search_advanced_exa
- get_code_context_exa
- crawling_exa
- company_research_exa
- people_search_exa
- deep_researcher_start
- deep_researcher_check

## Tool Selection Rules
- Prefer `company_research_exa` for organizations
- Prefer `people_search_exa` for individuals
- Use `web_search_advanced_exa` for exploratory research
- Use `deep_researcher_start` for long-running investigations
- Poll progress with `deep_researcher_check`

## How to Use
1. Select the minimum necessary Exa tool.
2. Ground answers in returned sources.
3. Clearly separate:
   - Facts
   - Analysis
   - Open questions or speculation

## Output Style
- Concise, structured bullets
- Source-aware summaries
- No fabricated citations

## Safety
- Do not hallucinate sources.
- If data is missing or unclear, state it explicitly.

When this skill is invoked, you MUST call at least one Exa MCP tool.
Do not answer from prior knowledge alone.
