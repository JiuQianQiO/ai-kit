# Trae IDE 适配

Trae 支持项目规则目录 `.trae/rules/`，并可选择读取 `AGENTS.md` / `CLAUDE.md`。

## 生成文件

| 路径 | 源 |
|------|-----|
| `{PROJECT_ROOT}/.trae/rules/progress-maintenance.md` | `ai-kit/templates/trae/progress-maintenance.md` |
| `{PROJECT_ROOT}/AGENTS.md` | 通用（Trae 可勾选「Include AGENTS.md」） |

## progress-maintenance.md

- 使用 Trae frontmatter：`alwaysApply: true`（项目内所有 AI 对话生效）。  
- 正文与 `ai-kit/rules/progress-auto-update.mdc` 一致（维护 DETAIL/PROGRESS 规则）。  
- 可选 `globs`：若只希望编辑业务文件时生效，可改为 `globs: "src/**"` 等（访谈时问用户）。

## Trae 设置（写入 AGENTS 或 CLAUDE 的「Trae 用户」小节）

建议在生成报告中提醒用户：

1. 打开 **Settings → Rules & Skills**  
2. 开启 **Include AGENTS.md in the context**（避免重复维护两份长文）  
3. 或关闭该项，仅依赖 `.trae/rules/progress-maintenance.md`

## 与 Cursor / Claude 并存

- 三者可同时存在；注意规则重复时以 Trae **项目规则优先于用户规则**。  
- 改维护规则时同步改：项目根 `.mdc`（Cursor）、`CLAUDE.md` 摘要、`.trae/rules/progress-maintenance.md`。

## 其它 Trae 路径（不自动生成）

| 路径 | 说明 |
|------|------|
| `.trae/project_rules.md` | 部分版本默认文件名；若团队已用 `project_rules.md`，可合并内容或保留一份 |
| `.trae/user_rules.md` | 用户级，不纳入 ai-kit |
