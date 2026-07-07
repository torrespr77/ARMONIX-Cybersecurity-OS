---
name: software-development
description: "Software development workflows — debugging, testing, code review, delegation, and coding agents. Use when developing, debugging, reviewing, or testing code."
version: 1.0.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [software-development, debugging, testing, code-review, delegation, coding-agents, quality]
    related_skills: [systematic-debugging, test-driven-development, requesting-code-review, simplify-code, spike, node-inspect-debugger, python-debugpy, claude-code, codex, opencode, jupyter-live-kernel, codebase-inspection]
---

# Software Development — Umbrella Skill

Covers the full software development workflow: debugging, testing, code review, delegation to coding agents, and parallel experimentation.

## Decision Tree

| Task | Sub-Skill | Trigger Keywords |
|---|---|---|
| Debug systematically (4-phase) | `systematic-debugging` | debug, bug, root cause, investigate, troubleshoot |
| Test-first development | `test-driven-development` | TDD, test first, red-green-refactor, write test |
| Pre-commit code review | `requesting-code-review` | review, verify, pre-commit, security scan, quality gate |
| Parallel code cleanup | `simplify-code` | simplify, cleanup, review changes, parallel review |
| Throwaway experiments | `spike` | spike, prototype, feasibility, proof of concept |
| Debug Node.js | `node-inspect-debugger` | node debug, inspect, CDP, breakpoints (Node) |
| Debug Python | `python-debugpy` | python debug, pdb, debugpy, breakpoints (Python) |
| Delegate to Claude Code | `claude-code` | claude code, anthropic, delegate coding |
| Delegate to Codex | `codex` | openai codex, codex CLI, delegate coding |
| Delegate to OpenCode | `opencode` | opencode, open code, delegate coding |
| Jupyter notebook REPL | `jupyter-live-kernel` | jupyter, notebook, iterative Python, data exploration |
| Inspect codebase (LOC) | `codebase-inspection` | LOC, codebase size, language breakdown, pygount |

## Debugging

### Systematic Debugging (4-Phase)

1. **Root Cause Investigation** — Read errors, reproduce, check changes, gather evidence
2. **Pattern Analysis** — Find working examples, compare, identify differences
3. **Hypothesis & Testing** — Form theory, test minimally, verify
4. **Implementation** — Create failing test, fix root cause, verify

**Iron law:** NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.

Full process: `skill_view(name="systematic-debugging")`

### Node.js Debugging

```bash
# Launch with debugger
node inspect script.js
node --inspect-brk script.js

# Attach to running process
kill -SIGUSR1 <pid>
node inspect -p <pid>
```

Full guide: `skill_view(name="node-inspect-debugger")`

### Python Debugging

```bash
# Quick breakpoint
breakpoint()  # in source, then run normally

# Launch under pdb
python -m pdb script.py

# Remote debug with debugpy
python -m debugpy --listen 127.0.0.1:5678 --wait-for-client script.py
```

Full guide: `skill_view(name="python-debugpy")`

## Testing

### Test-Driven Development

**Iron law:** NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.

1. **RED** — Write failing test
2. **GREEN** — Minimal code to pass
3. **REFACTOR** — Clean up while keeping tests green

Full process: `skill_view(name="test-driven-development")`

### Pre-Commit Review

1. Get diff (`git diff --cached`)
2. Static security scan
3. Baseline tests + linting
4. Self-review checklist
5. Independent reviewer subagent
6. Auto-fix loop (max 2 cycles)
7. Commit with `[verified]` prefix

Full pipeline: `skill_view(name="requesting-code-review")`

## Coding Agents

### Claude Code

```bash
# Print mode (preferred for single tasks)
claude -p "Add error handling to all API calls" --allowedTools "Read,Edit" --max-turns 10

# Interactive via tmux
tmux new-session -d -s claude-work -x 140 -y 40
tmux send-keys -t claude-work 'cd /project && claude' Enter
```

Full orchestration guide: `skill_view(name="claude-code")`

### Codex

```bash
# One-shot
codex exec "Add dark mode toggle" --full-auto

# Background
codex exec --full-auto "Refactor auth module" &
```

Full guide: `skill_view(name="codex")`

### OpenCode

```bash
# One-shot
opencode run "Add retry logic to API calls"

# Interactive
opencode  # TUI mode
```

Full guide: `skill_view(name="opencode")`

## Parallel Work

### Simplify Code (3-Agent Cleanup)

Three parallel reviewers: Code Reuse, Code Quality, Efficiency.

```python
delegate_task(tasks=[
    {"goal": "Review diff for code reuse issues", "toolsets": ["terminal", "file"]},
    {"goal": "Review diff for quality problems", "toolsets": ["terminal", "file"]},
    {"goal": "Review diff for efficiency problems", "toolsets": ["terminal", "file"]},
])
```

Full process: `skill_view(name="simplify-code")`

### Spike (Throwaway Experiments)

1. Decompose into 2-5 feasibility questions
2. Research approaches
3. Build minimal prototypes
4. Verdict: VALIDATED | PARTIAL | INVALIDATED

Full process: `skill_view(name="spike")`
