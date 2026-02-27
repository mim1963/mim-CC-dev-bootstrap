# dev-env-bootstrap

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/mim1963/mim-CC-dev-bootstrap/releases/tag/v1.0.0)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-orange)](https://claude.ai)
[![Agents](https://img.shields.io/badge/agents-18-purple)](.claude/agents/)

A [Claude Code](https://claude.ai) skill that deploys a complete multi-agent dev environment in a new project with **a single sentence**: 18 agents, 14 slash commands, 4 hooks, spec-driven pipeline + parallel review.

---

## Quick Start

```bash
# 1. Install the skill
git clone https://github.com/mim1963/mim-CC-dev-bootstrap.git ~/.claude/skills/dev-env-bootstrap
```

```
# 2. In any Claude Code session, just say:
"Create a new project my-api in C:\Users\YourName\Documents\Projects\my-api"
```

```
# 3. Claude bootstraps everything — start immediately with:
/init-project    → fill in project vision, stack, structure
/new-feature "…" → first spec-driven development
```

---

## Demo

> *GIF coming soon — record with [Terminalizer](https://terminalizer.com/) or [asciinema](https://asciinema.org/)*

What Claude outputs at the end of the bootstrap:

```
✅ Environment deployed: my-api
📁 Location: C:\Users\YourName\Documents\Projects\my-api

Deployed:
  • 18 agents    (.claude/agents/)
  • 14 commands  (.claude/commands/)
  • 4 hooks      (.claude/settings.json)
  • Steering     (.claude/steering/ — blank templates)
  • Docs         (docs/state/, docs/specs/)
  • .gitignore   (session state, bugs, settings.local, worktrees, build)
  • Git          (repo initialized, initial commit created)   ← if enabled

Next steps:
  1. Open the folder in Claude Code
  2. /init-project          → configure steering files
  3. /new-feature "..."     → start first development
```

---

## How it works

3 automatic phases:

1. **Interview** — project name, destination path, optional description, git Y/N
2. **Deployment** — copy from embedded reference, personalized statusline, pre-filled steering, git init if enabled
3. **Summary** — deployment report + getting-started instructions

---

## Deployed architecture

| Component | Count | Role |
|-----------|-------|------|
| Spec-driven agents | 9 | orchestrator, analyst, architect, developer, tester, tdd + 3 validators |
| Review agents | 5 | architect-reviewer, code-reviewer, security-auditor, jenny, pragmatist |
| Support agents | 4 | challenger, karen, coherence-checker, guardian |
| Slash commands | 14 | /new-feature, /review, /bug-*, /save-state, /challenge… |
| Hooks | 4 | PreCompact, PostToolUse, Stop, SubagentStop |

### Included pipelines

```
/new-feature "description"
  → requirements.md → [user validation] → design.md + tasks.md → [user validation]
  → atomic implementation (1 task → STOP) → unit tests → /review

/bug-create → /bug-analyze → /bug-fix → /bug-verify

/review  →  5 agents running in parallel
```

---

## Usage

From any Claude Code session, phrase the request naturally:

- `"Create a new project my-api-rest in C:\Users\YourName\Documents\Projects\my-api-rest"`
- `"Bootstrap my dev environment for dashboard-rh"`
- `"New project cli-converter in ~/projects/cli-converter"`

Claude triggers the skill, asks 4 questions in a single block, then deploys everything automatically.

---

## Self-contained reference

The skill is **fully autonomous**: the complete reference is embedded in `~/.claude/skills/dev-env-bootstrap/reference/`. No external directory required.

**Update templates**: edit files in `reference/`. Every new bootstrapped project benefits from the updates.

**Sync from a master environment**: after improving agents or commands in your dev env, copy the modified files into `reference/` manually.

---

## Requirements

- [Claude Code](https://claude.ai) installed
- Git (to clone the skill)
- Windows, macOS or Linux

---

## License

[MIT](LICENSE)
