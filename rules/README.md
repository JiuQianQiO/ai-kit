# Cursor 规则源文件（勿在此目录启用）

本目录中的 `*.mdc` 是**模板源**，供复制到 **项目根**：

```text
{PROJECT_ROOT}/.cursor/rules/progress-auto-update.mdc
```

## 重要

- **不要**在 `ai-kit/rules/` 源文件中写 `alwaysApply: true`，也**不要**在 `ai-kit/` 下新建 `.cursor/rules/`——Cursor 只应在**项目根**加载规则，避免与项目根规则重复或误触发维护义务。
- 接入方式：访谈生成（推荐）或 `scripts/init-ai-docs.*` 复制到项目根。

## alwaysApply

- **源文件**（本目录）：`alwaysApply: false`  
- **项目根**（复制后）：必须为 `alwaysApply: true`（init 脚本会自动改；AI 生成时须检查）

## 单一正文源（Trae / Claude 同步）

- **权威正文**：本目录 `progress-auto-update.mdc`（改维护规则只改此文件，再递增 `VERSION` / `CHANGELOG`）。  
- **Trae**：复制/同步到 `templates/trae/progress-maintenance.md`，生成时写入 `.trae/rules/`。  
- **Claude**：生成 `.claude/rules/progress-maintenance.md` 时复制正文（去掉 `alwaysApply`）。  
- 三处语义须一致；Trae 模板不宜长期比 `.mdc` 更短而无说明。

## 历史路径

v1.4.1 及以前：`ai-kit/.cursor/rules/`（v1.4.2 删除 `.mdc`；v1.5.3 移除 `ai-kit/.cursor/` 目录）
