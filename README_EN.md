# ai-kit

**Portable AI project governance kit**

[![Version](VERSION)](CHANGELOG.md) · [中文](README_CN.md)

---

## Overview

**ai-kit** is a copy-paste folder you drop at the **root of any repository**. An AI assistant runs a **structured interview** (or reads a hand-written brief) and generates consistent governance docs at **PROJECT_ROOT**—not inside `ai-kit/` itself.

Use it when onboarding a repo, aligning Cursor / Claude Code / Trae, supporting split frontend/backend repos, multi-datasource backends, or teams that want maintainable `PROGRESS` + `DETAIL` changelogs.

## What you get

| Artifact | Purpose |
|----------|---------|
| `AGENTS.md` | Cross-IDE instructions for AI coding agents |
| `PROGRESS.md` | Capability snapshot, gaps, milestones (short session entry) |
| `DETAIL.md` | Append-only log of substantive changes |
| `ARCHITECTURE.md` | Layout and architecture conventions |
| `PROJECT_BRIEF.md` | Machine-readable source of truth (optional in git) |
| **IDE-specific extras** | See table below |

| Tool | Extra paths |
|------|-------------|
| Cursor | `.cursor/rules/progress-auto-update.mdc` |
| Claude Code | `CLAUDE.md` + `.claude/rules/progress-maintenance.md` |
| Trae | `.trae/rules/progress-maintenance.md` |

## Features

- **Interview-driven**: batched question flow (A1→A2→B→E→F→G→H→C→I→D), ≤8 questions per round; tables use **`#` row numbers**—reply with `1: answer` or `A1: answer`
- **Type-aware trimming**: skip irrelevant blocks for frontend-only, libraries, split repos, monorepos, etc.
- **Multi-IDE**: generate only files for selected `meta.ai_tools[]`
- **Merge policies**: merge, skip, or overwrite existing `AGENTS.md` / `CLAUDE.md`
- **Security**: no secrets in briefs or generated docs ([`SECURITY.md`](SECURITY.md))
- **Timestamps**: `DETAIL` entries use **Beijing time (UTC+8)**, aligned with `git log +0800` when linked to commits

## Quick start

1. Copy the entire **`ai-kit/`** folder to your **repository root**.
2. In your AI IDE, **@ `ai-kit/START_HERE.md`** and paste the one-shot prompt at the bottom of [START_HERE.md](START_HERE.md).
3. Answer each round (prefer `#` numbered replies).
4. Reply **confirm** (or **「确认」**) to generate files at **PROJECT_ROOT** (parent of `ai-kit/`). Nothing is written inside `ai-kit/`.

```text
your-project/                    ← PROJECT_ROOT
├── ai-kit/                      ← keep; read-only kit
├── PROJECT_BRIEF.md             ← generated
├── AGENTS.md  PROGRESS.md  DETAIL.md  ARCHITECTURE.md
├── .cursor/rules/…              ← if Cursor selected
├── CLAUDE.md                    ← if Claude Code selected
└── .trae/rules/…                ← if Trae selected
```

## Three ways to onboard

| Mode | Entry | When |
|------|-------|------|
| **Interactive (recommended)** | [`START_HERE.md`](START_HERE.md) | Greenfield or discovery |
| **Written brief** | [`prompts/PROJECT_BRIEF.template.md`](prompts/PROJECT_BRIEF.template.md) → @ [`prompts/GENERATE_FROM_BRIEF.md`](prompts/GENERATE_FROM_BRIEF.md) | You already know the answers |
| **Init skeleton** | `scripts/init-ai-docs.ps1 -UseProjectRoot` or `init-ai-docs.sh --use-project-root` | Placeholders only—**still run the interview** |

> Init copies the four core docs + Cursor rule only. For Claude / Trae artifacts, use the interview or `GENERATE_FROM_BRIEF`.

## Layout

```text
ai-kit/
├── START_HERE.md          # Human entry
├── README.md              # Language index
├── README_CN.md           # Chinese readme
├── README_EN.md           # English readme (this file)
├── VERSION / CHANGELOG.md
├── MANIFEST.md            # AI required reading list
├── SECURITY.md
├── adapters/              # Cursor / Claude / Trae / generic
├── docs/
│   └── SPLIT_REPO_GUIDE.md
├── prompts/               # Protocol, question bank, placeholders, merge policy
├── rules/                 # Cursor rule source (alwaysApply: true at project root)
├── scripts/               # init-ai-docs.ps1 | .sh
├── snippets/
└── templates/             # AGENTS / PROGRESS / DETAIL / ARCHITECTURE templates
```

## Doc index

| Doc | Audience |
|-----|----------|
| [`START_HERE.md`](START_HERE.md) | Humans · first run |
| [`prompts/INTERVIEW_PROTOCOL.md`](prompts/INTERVIEW_PROTOCOL.md) | AI · interview & generate |
| [`prompts/QUESTION_BANK.md`](prompts/QUESTION_BANK.md) | AI · questions |
| [`prompts/PROJECT_TYPES.md`](prompts/PROJECT_TYPES.md) | AI · trimming rules |
| [`adapters/README.md`](adapters/README.md) | Humans / AI · multi-tool paths |
| [`CHANGELOG.md`](CHANGELOG.md) | Release notes |

## Maintaining the kit

- Rule text: edit [`rules/progress-auto-update.mdc`](rules/progress-auto-update.mdc) only; sync Trae/Claude per [`rules/README.md`](rules/README.md)
- Flow / questions: edit `prompts/`, bump [`VERSION`](VERSION), update [`CHANGELOG.md`](CHANGELOG.md)
- Do **not** create `ai-kit/.cursor/rules/`; rule source is only [`rules/progress-auto-update.mdc`](rules/progress-auto-update.mdc) (see [`rules/README.md`](rules/README.md))

## License

Distributed under the parent repository’s license; add a `LICENSE` file if you publish ai-kit as a standalone repo.
