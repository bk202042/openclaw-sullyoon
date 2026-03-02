---
title: "Research task routing: Tavily for question-based search, Firecrawl for URL-based extraction"
description: "Standard operating procedure for web search and data extraction. Core principle: Tavily is search-first (discovery), Firecrawl is extraction-first (known URL)."
tags: ["research", "tavily", "firecrawl", "exa", "stealth-browser", "workflow", "sop"]
trigger: "User asked to update system research task standard procedure"
date: "2026-03-02"
updated: "2026-03-02"
---

## Core Principle

**Tavily = Search-first**, **Firecrawl = Extraction-first**

- **Tavily**: Starts with a search query → hunts across multiple sources → returns synthesized factual summary (best for discovery, real-time questions)
- **Firecrawl**: Starts with a URL/domain → deep scrapes → returns pristine structured Markdown/JSON (best for known sources, documentation)

---

## Tool Priority Chain (Revised)

### 1순위: Tavily (Question-based Search)
**Use when:** User asks a question and needs to discover answers from multiple sources

**Best for:**
- Real-time chatbots and conversational agents
- Dynamic RAG pipelines
- Questions about recent events or unknown topics
- Multi-source synthesis with citations

**Key strengths:**
- Speed: p50 latency ~180ms
- All-in-one: searches, scrapes, synthesizes in one call
- `/research` endpoint for deep multi-hop queries

**Examples:**
- "What are the latest AI models released this week?"
- "Explain quantum computing in simple terms"
- "Latest news on OpenAI"

---

### 2순위: Firecrawl (URL-based Extraction)
**Use when:** You already know WHERE the data is (specific URL/domain)

**Best for:**
- Building knowledge bases from documentation
- Deep-crawling specific sites
- PDF, complex tables, SPA extraction
- Dataset curation

**Key strengths:**
- Deep extraction with custom browser stack
- Handles JS-heavy pages, SPAs, PDFs
- Actions & navigation (clicks, scrolls, waits)
- Open source (AGPL-3.0) for self-hosting

**Examples:**
- "Extract docs from https://docs.firecrawl.dev"
- "Crawl this documentation site and give me markdown"
- "Map all URLs on example.com"

---

### 3순위: Exa-mcp (Deep Code & People Research)
**Use when:** Specialized research on code or individuals

**Best for:**
- Development documentation
- Code context and implementation patterns
- Specific person/author research

---

### Last Resort: Stealth-browser
**Use when:** Direct UI interaction is required

**Best for:**
- Login-required pages
- Clicking, form filling before extraction
- Complex multi-step navigation

---

## Routing Decision Tree

```
리서치 요청
    ↓
질문 기반? ("최신 AI 뉴스", "모르는 주제")
    ├─ YES ──→ Tavily (search-first: discovery + synthesis)
    ↓ NO
특정 URL/도메인? ("docs.openclaw.ai 추출")
    ├─ YES ──→ Firecrawl (extraction-first: deep scraping)
    ↓ NO
코드/인물 관련?
    ├─ YES ──→ Exa-mcp
    ↓ NO
UI 상호작용 필요?
    └─ YES ──→ Stealth-browser
```

---

## Comparison Table

| Feature | Tavily | Firecrawl |
|---------|--------|-----------|
| **Primary Workflow** | Search Query → Factual Context | URL → Clean Markdown/JSON |
| **Core Endpoints** | /search, /extract, /research | /scrape, /crawl, /map, /extract |
| **JS Rendering & Actions** | Basic extraction | Yes (clicks, scrolls, SPAs) |
| **Output Formats** | Markdown, Text summaries | Markdown, JSON, HTML, Screenshots |
| **Free Tier** | 1,000 searches/month | 500 credits/month |
| **Pricing Model** | Pay-As-You-Go ($0.008/search) | Fixed monthly tiers |
| **Best For** | Discovery, real-time grounding | Data collection, pipeline ingestion |

---

## Examples by Tool

| Task | Tool | Reason |
|------|------|--------|
| "최신 AI 뉴스 정리" | Tavily | Discovery needed, multi-source |
| "OpenClaw 공식 문서 요약" | Firecrawl | Known URL (docs.openclaw.ai) |
| "React 19 새로운 기능" | Firecrawl | docs.react.dev scraping |
| "이 라이브러리 누가 만들었나" | Exa | People/code search |
| "로그인 후 대시보드 추출" | Stealth-browser | UI interaction required |

---

## Related Nodes
- [[tavily-search-pro]]
- [[firecrawl-mcp-server]]
- [[exa-mcp-server]]
- [[stealth-browser]]

## References
- Original decision: 2026-03-02
- Comparison source: Tavily vs Firecrawl feature analysis
- Tavily: https://tavily.com
- Firecrawl: https://firecrawl.dev
