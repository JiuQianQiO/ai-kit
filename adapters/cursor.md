# Cursor 适配

## 生成文件

| 路径 | 源 |
|------|-----|
| `{PROJECT_ROOT}/.cursor/rules/progress-auto-update.mdc` | `ai-kit/rules/progress-auto-update.mdc` |

## 部署

- 复制后 frontmatter：**`alwaysApply: true`**（源文件为 `false`）。  
- 源文件 `ai-kit/rules/` 保持 `alwaysApply: false`；仅在**项目根** `.cursor/rules/` 启用（`alwaysApply: true`）。

## 与 AGENTS.md

- `AGENTS.md` 为摘要；细则以项目根 `.mdc` 为准（与 Cursor 默认行为一致）。  
- 会话开始读 `PROGRESS.md` §1、§2 — 已在 `.mdc` 中写明。

## init 脚本

`init-ai-docs.ps1` 会复制 `.mdc` 并改 `alwaysApply: true`（仅 frontmatter 第一处）。
