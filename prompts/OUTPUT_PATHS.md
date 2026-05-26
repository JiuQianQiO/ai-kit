# 生成文件路径约定

设 **PROJECT_ROOT** = 含 `ai-kit/` 文件夹的项目仓库根目录。

| 产物 | 绝对路径规则 | 来源 |
|------|----------------|------|
| `PROJECT_BRIEF.md` | `{PROJECT_ROOT}/PROJECT_BRIEF.md` | 访谈结果，按 `PROJECT_BRIEF.schema.md` |
| `AGENTS.md` | `{PROJECT_ROOT}/AGENTS.md` | `ai-kit/templates/AGENTS.base.md` |
| `PROGRESS.md` | `{PROJECT_ROOT}/PROGRESS.md` | `ai-kit/templates/PROGRESS.template.md` |
| `DETAIL.md` | `{PROJECT_ROOT}/DETAIL.md` | `ai-kit/templates/DETAIL.template.md` |
| `ARCHITECTURE.md` | `{PROJECT_ROOT}/ARCHITECTURE.md` | `ai-kit/templates/ARCHITECTURE.template.md` |
| Cursor 规则 | `{PROJECT_ROOT}/.cursor/rules/progress-auto-update.mdc` | 见 [`adapters/cursor.md`](../adapters/cursor.md) |

### 按 `meta.ai_tools[]` 额外生成

| 工具 | 路径 | 源 |
|------|------|-----|
| `cursor` | `.cursor/rules/progress-auto-update.mdc` | `ai-kit/rules/progress-auto-update.mdc` → `alwaysApply: true` |
| `claude-code` | `CLAUDE.md` | `templates/CLAUDE.template.md` |
| `claude-code` | `.claude/rules/progress-maintenance.md` | **默认生成**（与 `rules/` 同文，见 adapters） |
| `trae` | `.trae/rules/progress-maintenance.md` | `templates/trae/progress-maintenance.md` |
| `other` | — | 仅通用文档，见 [`adapters/generic.md`](../adapters/generic.md) |

未选中的工具**不生成**对应文件（已存在则按 merge 策略）。

## 禁止写入的路径

- `{PROJECT_ROOT}/ai-kit/**` 下的上述交付物（模板目录保持只读）
- 构建产物目录内的规范文件

## 合并策略（与访谈 A4/A5 一致）

| 策略 | 行为 |
|------|------|
| `新建` | 目标不存在则创建；存在则按用户是否选覆盖决定 |
| `仅缺失` | `Test-Path` / 等价：文件已存在则跳过并记入完成报告 |
| `覆盖` | 整文件替换（`AGENTS` 选「合并」时见协议：保留原「项目概述」段） |
| `跳过` | 不写入该文件 |

## init 脚本等价路径

`scripts/init-ai-docs.ps1 -TargetPath` 的 `TargetPath` 应等于 **PROJECT_ROOT**（不是 `ai-kit` 目录）。

**注意**：init **始终**复制 Cursor `.mdc` 与通用四模板，**不**生成 `CLAUDE.md` / Trae 规则；多工具须走访谈或 `GENERATE_FROM_BRIEF`。init 后 `DETAIL` 初始化路径默认含 `.cursor/rules/…`。
