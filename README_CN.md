# ai-kit

**跨项目 AI 工程规范生成器**

[![Version](VERSION)](CHANGELOG.md) · [English](README_EN.md)

---

## 简介

**ai-kit** 是一套可复制的文件夹，放进任意代码仓库根目录后，由 AI 通过**结构化访谈**（或手写简报）在项目根生成统一的 AI 协作文档，而不是把规范散落在聊天里。

适合：新仓库接入、团队统一 Cursor / Claude Code / Trae 约定、前后端分仓、多数据源后端、需要可维护的 `PROGRESS` / `DETAIL` 变更日志的项目。

## 你将得到什么

| 产物 | 说明 |
|------|------|
| `AGENTS.md` | AI 编程助手总指引（跨 IDE 通用） |
| `PROGRESS.md` | 能力快照 + 缺口 + 里程碑（会话入口，宜短） |
| `DETAIL.md` | 每次实质变更的追加日志（仅末尾追加） |
| `ARCHITECTURE.md` | 目录与架构约定 |
| `PROJECT_BRIEF.md` | 机器可读的访谈/配置真相源（可选入库） |
| **按所选 IDE 额外生成** | 见下表 |

| 工具 | 额外路径 |
|------|----------|
| Cursor | `.cursor/rules/progress-auto-update.mdc` |
| Claude Code | `CLAUDE.md` + `.claude/rules/progress-maintenance.md` |
| Trae | `.trae/rules/progress-maintenance.md` |

## 特性

- **访谈驱动**：分批题库（A1→A2→B→E→F→G→H→C→I→D），每轮 ≤8 题；问题表带 **`#` 序号**，可用 `1: 答案` 或 `A1: 答案` 回复
- **类型裁剪**：纯前端 / 库 / 分仓 / monorepo 等自动跳过无关题（如数据源、前端工程）
- **多 IDE**：一次访谈，按 `meta.ai_tools[]` 只生成选中工具的文件
- **合并策略**：已有 `AGENTS.md` / `CLAUDE.md` 时可合并、跳过或覆盖
- **安全**：[`SECURITY.md`](SECURITY.md) 禁止把密钥写入简报与生成物
- **北京时间**：`DETAIL` 时间戳与 `git log +0800` 对齐（见维护规则）

## 快速开始

1. 将 **`ai-kit/` 整个文件夹**复制到目标仓库根目录（与 `src/`、`pom.xml` 等同级）。
2. 在 AI IDE 中 **@ `ai-kit/START_HERE.md`**，发送文末 [一键话术](START_HERE.md)。
3. 按轮回答表格中的问题（推荐用 `#` 序号）。
4. 回复 **「确认」** 后，AI 在 **项目根**（`ai-kit` 的上一级）生成文件；**不会**写入 `ai-kit/` 内部。

```text
your-project/                    ← PROJECT_ROOT
├── ai-kit/                      ← 保留，只读使用
├── PROJECT_BRIEF.md             ← 生成
├── AGENTS.md  PROGRESS.md  DETAIL.md  ARCHITECTURE.md
├── .cursor/rules/…              ← 若选 Cursor
├── CLAUDE.md                    ← 若选 Claude Code
└── .trae/rules/…                ← 若选 Trae
```

## 三种接入方式

| 方式 | 入口 | 适用 |
|------|------|------|
| **交互式（推荐）** | [`START_HERE.md`](START_HERE.md) | 从零梳理项目 |
| **手写简报** | 填 [`prompts/PROJECT_BRIEF.template.md`](prompts/PROJECT_BRIEF.template.md) → @ [`prompts/GENERATE_FROM_BRIEF.md`](prompts/GENERATE_FROM_BRIEF.md) | 已清楚项目信息 |
| **init 骨架** | `scripts/init-ai-docs.ps1 -UseProjectRoot` 或 `init-ai-docs.sh --use-project-root` | 先要模板占位符，**仍须访谈**补全 |

> init 仅复制通用四文档 + Cursor 规则，**不**生成 `CLAUDE.md` / Trae 规则；多工具请走访谈或 `GENERATE_FROM_BRIEF`。

## 目录结构

```text
ai-kit/
├── START_HERE.md          # 人类入口
├── README.md              # 语言入口
├── README_CN.md           # 中文说明（本文件）
├── README_EN.md           # English readme
├── VERSION / CHANGELOG.md
├── MANIFEST.md            # AI 必读清单
├── SECURITY.md
├── adapters/              # Cursor / Claude / Trae / generic
├── docs/
│   └── SPLIT_REPO_GUIDE.md
├── prompts/               # 访谈协议、题库、占位符、合并策略
├── rules/                 # Cursor 规则源（复制到项目根后 alwaysApply: true）
├── scripts/               # init-ai-docs.ps1 | .sh
├── snippets/
└── templates/             # AGENTS / PROGRESS / DETAIL / ARCHITECTURE 模板
```

## 文档索引

| 文档 | 读者 |
|------|------|
| [`START_HERE.md`](START_HERE.md) | 人类 · 第一次接入 |
| [`prompts/INTERVIEW_PROTOCOL.md`](prompts/INTERVIEW_PROTOCOL.md) | AI · 访谈与生成流程 |
| [`prompts/QUESTION_BANK.md`](prompts/QUESTION_BANK.md) | AI · 分批问题 |
| [`prompts/PROJECT_TYPES.md`](prompts/PROJECT_TYPES.md) | AI · 裁剪规则 |
| [`adapters/README.md`](adapters/README.md) | 人/AI · 多工具路径 |
| [`CHANGELOG.md`](CHANGELOG.md) | 版本变更 |

## 维护本套件

- 改维护规则正文：只改 [`rules/progress-auto-update.mdc`](rules/progress-auto-update.mdc)，再同步 Trae/Claude 生成说明（见 [`rules/README.md`](rules/README.md)）
- 改流程/题库：改 `prompts/`，递增 [`VERSION`](VERSION) 并写 [`CHANGELOG.md`](CHANGELOG.md)
- **勿**在 `ai-kit/` 下创建 `.cursor/rules/`；规则源文件仅 [`rules/progress-auto-update.mdc`](rules/progress-auto-update.mdc)（见 [`rules/README.md`](rules/README.md)）

## 许可

随所在仓库许可证分发；单独拆仓时请由维护者补充 `LICENSE`。
