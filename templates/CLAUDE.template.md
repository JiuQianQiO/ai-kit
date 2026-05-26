# CLAUDE.md

> 由 ai-kit {{AI_KIT_VERSION}} 生成。完整约束见 [`AGENTS.md`](AGENTS.md)；进度见 [`PROGRESS.md`](PROGRESS.md)；目录见 [`ARCHITECTURE.md`](ARCHITECTURE.md)。

## 项目

**{{PROJECT_NAME}}** — {{ONE_LINE_PURPOSE}}

**仓库**：{{REPO_LAYOUT_LABEL}}（{{CURRENT_REPO_ROLE_LABEL}}）

## 常用命令

```bash
{{COMMON_COMMANDS}}
```

## 会话必读

1. 先读 `PROGRESS.md` **§1、§2**（不要通读 `DETAIL.md`）。  
2. 结构以 `ARCHITECTURE.md` 为准。

## 变更记录（摘要）

- 每次**实质变更**后，在 `DETAIL.md` **末尾追加**一条（格式见 `AGENTS.md` 或 `.cursor/rules` / `.trae/rules`）。  
- **commit 或大变更**时更新 `PROGRESS.md` §3（每轮一行）；能力变化时更新 §1。  
- 细则以项目内维护规则文件为准（Cursor: `.cursor/rules/`；Trae: `.trae/rules/`；Claude: `.claude/rules/` 若存在）。

## 协作与约束（摘要）

{{CLAUDE_COLLABORATION_SUMMARY}}

{{CLAUDE_CONSTRAINTS_SUMMARY}}

## 工具共存

| 工具 | 本项目文件 |
|------|------------|
| Cursor | `.cursor/rules/progress-auto-update.mdc` |
| Claude Code | 本文件 `CLAUDE.md` |
| Trae | `.trae/rules/progress-maintenance.md`；建议在 Trae 中开启 Include AGENTS.md |

---

*保持本文件简短；细节、环境、契约、鉴权见 `AGENTS.md`。*
