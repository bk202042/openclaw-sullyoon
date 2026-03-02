---
name: qmd
description: Local search engine for markdown documents - combines BM25, vector search, and LLM re-ranking for your notes, docs, and knowledge bases
version: 1.0.0
author: tobi (https://github.com/tobi/qmd)
---

# QMD Skill - Query Markup Documents

An on-device search engine for everything you need to remember. Index your markdown notes, meeting transcripts, documentation, and knowledge bases.

## Features

- **BM25 Full-text search** - Fast keyword-based search via SQLite FTS5
- **Vector semantic search** - Find conceptually similar content
- **LLM Re-ranking** - Fine-tuned models for best results
- **Query expansion** - Automatically generates search variations
- **MCP Server** - Model Context Protocol integration
- **All local** - No cloud dependencies, runs via node-llama-cpp

## Requirements

- Bun >= 1.0.0
- macOS: `brew install sqlite` (for extension support)

## Installation

```bash
# Install globally with bun
bun install -g https://github.com/tobi/qmd

# Or use the skill installer
qmd-install
```

## Quick Start

```bash
# Create collections for your notes
qmd collection add ~/notes --name notes
qmd collection add ~/Documents/meetings --name meetings

# Add context to help search
qmd context add qmd://notes "Personal notes and ideas"

# Generate embeddings
qmd embed

# Search!
qmd search "project timeline"      # Fast keyword search
qmd vsearch "how to deploy"        # Semantic search
qmd query "quarterly planning"     # Hybrid + reranking (best quality)
```

## Commands

| Command | Description |
|---------|-------------|
| `qmd collection add <path> --name <name>` | Index a directory |
| `qmd collection list` | List all collections |
| `qmd embed` | Generate vector embeddings |
| `qmd search <query>` | BM25 keyword search |
| `qmd vsearch <query>` | Vector semantic search |
| `qmd query <query>` | Hybrid search with re-ranking |
| `qmd get <file>` | Retrieve a document |
| `qmd status` | Check index health |

## MCP Server

For AI agent integration:

```bash
# Start MCP server
qmd mcp

# Or HTTP mode (shared, long-lived)
qmd mcp --http
```

Claude Code configuration (~/.claude/settings.json):
```json
{
  "mcpServers": {
    "qmd": {
      "command": "qmd",
      "args": ["mcp"]
    }
  }
}
```

## Models Used

| Model | Purpose | Size |
|-------|---------|------|
| embeddinggemma-300M-Q8_0 | Vector embeddings | ~300MB |
| qwen3-reranker-0.6b-q8_0 | Re-ranking | ~640MB |
| qmd-query-expansion-1.7B-q4_k_m | Query expansion | ~1.1GB |

Models auto-download on first use to `~/.cache/qmd/models/`.

## Data Storage

- Index: `~/.cache/qmd/index.sqlite`
- Models: `~/.cache/qmd/models/`
