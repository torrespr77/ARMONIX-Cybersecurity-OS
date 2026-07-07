---
name: research
description: "Academic research — paper discovery, literature review, knowledge bases, prediction markets. Use when searching papers, building knowledge bases, or doing research."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
    hermes:
    tags: [research, papers, arxiv, knowledge-base, prediction-markets, literature-review]
    related_skills: [arxiv, blogwatcher, llm-wiki, polymarket, research-paper-writing]
---

# Research — Umbrella Skill

Covers academic research: paper discovery, literature review, knowledge base construction, and prediction market data.

## Decision Tree

| Task | Sub-Skill | Trigger Keywords |
|---|---|---|
| Search arXiv papers | `arxiv` | arxiv, paper, academic, research paper, find paper |
| Monitor blogs/RSS feeds | `blogwatcher` | RSS, blog, feed, monitor, subscribe |
| Build knowledge base | `llm-wiki` | wiki, knowledge base, notes, interlinked markdown |
| Prediction market data | `polymarket` | polymarket, prediction market, odds, betting |
| Write research papers | `research-paper-writing` | write paper, NeurIPS, ICML, ICLR, LaTeX |

## Paper Discovery (from arxiv)

```bash
# Search
curl -s "https://export.arxiv.org/api/query?search_query=all:GRPO+reinforcement+learning&max_results=5"

# Get specific paper
curl -s "https://export.arxiv.org/api/query?id_list=2402.03300"

# Read abstract
web_extract(urls=["https://arxiv.org/abs/2402.03300"])

# Read full paper
web_extract(urls=["https://arxiv.org/pdf/2402.03300"])
```

Full guide: `skill_view(name="arxiv")`

## Blog Monitoring (from blogwatcher)

```bash
# Install
go install github.com/JulienTant/blogwatcher-cli/cmd/blogwatcher-cli@latest

# Add blog
blogwatcher-cli add "My Blog" https://example.com

# Scan for updates
blogwatcher-cli scan

# List unread
blogwatcher-cli articles
```

Full guide: `skill_view(name="blogwatcher")`

## Knowledge Base (from llm-wiki)

Karpathy's LLM Wiki pattern — build persistent, compounding knowledge base as interlinked markdown.

```
wiki/
├── SCHEMA.md           # Conventions, structure rules
├── index.md            # Sectioned content catalog
├── log.md              # Chronological action log
├── raw/                # Layer 1: Immutable source material
├── entities/           # Layer 2: Entity pages
├── concepts/           # Layer 2: Concept pages
├── comparisons/        # Layer 2: Side-by-side analyses
└── queries/            # Layer 2: Filed query results
```

Full guide: `skill_view(name="llm-wiki")`

## Prediction Markets (from polymarket)

```bash
# Search markets
curl -s "https://gamma-api.polymarket.com/markets?active=true&closed=false&limit=10"

# Get prices
curl -s "https://gamma-api.polymarket.com/markets?slug=will-x-happen"
```

Full guide: `skill_view(name="polymarket")`
