# AI 工具适配层

> **通用文档**（任何工具都应生成）：`AGENTS.md`、`PROGRESS.md`、`DETAIL.md`、`ARCHITECTURE.md`、`PROJECT_BRIEF.md`  
> **工具专属**：见下表，按 `meta.ai_tools[]` 生成。

| 工具 ID | 适配说明 | 额外生成路径 |
|---------|----------|----------------|
| `cursor` | [`cursor.md`](cursor.md) | `.cursor/rules/progress-auto-update.mdc` |
| `claude-code` | [`claude-code.md`](claude-code.md) | `CLAUDE.md` + `.claude/rules/progress-maintenance.md`（默认二者） |
| `trae` | [`trae.md`](trae.md) | `.trae/rules/progress-maintenance.md` |
| `other` | [`generic.md`](generic.md) | 仅通用文档；在 AGENTS 注明实际工具名 |

访谈 **A3** 收集 `meta.ai_tools`（可多选；**空则生成时视为 `cursor`**）。生成时读对应适配器 + [`../prompts/PLACEHOLDER_MAP.md`](../prompts/PLACEHOLDER_MAP.md)。

## 原则

1. **单一真相源**：细节以 `AGENTS.md` + `PROJECT_BRIEF.md` 为准；`CLAUDE.md` 为摘要（宜 <200 行）。  
2. **维护规则一致**：Cursor `.mdc`、Trae `.trae/rules/*.md`、Claude `.claude/rules/*.md` 正文与 `ai-kit/rules/progress-auto-update.mdc` 同步，仅 frontmatter/路径不同。  
3. **Trae + Cursor 并存**：可共存；Trae 设置中可开启「Include AGENTS.md」减少重复。

## 版本

随 `ai-kit/VERSION`；变更见 [`../CHANGELOG.md`](../CHANGELOG.md)。
