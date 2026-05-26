# AI 提示词：根据 PROJECT_BRIEF 生成规范（跳过访谈）

适用：`{PROJECT_ROOT}/PROJECT_BRIEF.md` **已完整**（人工填写或访谈已结束）。  
**PROJECT_ROOT** = 含 `ai-kit/` 的仓库根目录。

若尚无简报，请改走 [`INTERVIEW_PROTOCOL.md`](INTERVIEW_PROTOCOL.md)（@ `ai-kit/START_HERE.md`）。

---

## 路径

| 变量 | 值 |
|------|-----|
| `KIT_ROOT` | `{PROJECT_ROOT}/ai-kit` |
| 输出路径 | 见 [`OUTPUT_PATHS.md`](OUTPUT_PATHS.md) |

**禁止**写入 `ai-kit/` 内（除只读读取模板）。

---

## 执行步骤

1. 读取 `{PROJECT_ROOT}/PROJECT_BRIEF.md` 与 `ai-kit/VERSION`、`ai-kit/templates/*`、`ai-kit/rules/progress-auto-update.mdc`、`SECURITY.md`。
2. 按 [`PROJECT_BRIEF.schema.md`](PROJECT_BRIEF.schema.md) 校验必填；缺项则列出并停止。  
   **必查**：`meta.ai_tools[]`（空数组视为 `["cursor"]`）、`meta.ai_tool_primary`（须为 `ai_tools` 之一）、`meta.merge.*`（含 `merge.claude` 当 `claude-code` ∈ `ai_tools` 时）。
3. 按 [`MERGE_POLICY.md`](MERGE_POLICY.md) 与 [`OUTPUT_PATHS.md`](OUTPUT_PATHS.md) 写入各文件。
4. 按 [`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md) 替换**全部**占位符；并按 [`PROJECT_TYPES.md`](PROJECT_TYPES.md) 删节：
   - 删除或保留数据源节；
   - 填充 `{{REPO_COLLABORATION}}`、`{{LOCAL_DEV}}`、`{{API_CONTRACT}}`、`{{AUTH}}`、`{{COLLABORATION_ARCHITECTURE}}`（来自 `collaboration` / `api_contract` / `auth`）；
   - `repo_layout` 映射：`split`→「前后端分仓」、`monorepo`→「全栈单仓」、`single`→「仅本仓」；
   - P1：`{{ENVIRONMENT}}`、`{{FRONTEND_ENGINEERING}}`（无 `frontend` 节则删除）、`{{QUALITY}}`；
   - P2：`{{OPTIONAL_NOTES}}`（`optional` 空则删除）；`{{ENV_QUALITY_ARCHITECTURE}}`；
   - `{{COMMON_COMMANDS}}` 合并 `collaboration.local_dev`、`quality.*.command`、`agents.commands`；
   - `{{AI_TOOLS_MAINTENANCE_SECTION}}`、`{{MAINTENANCE_RULES_REF}}`、`{{INIT_PATHS_LIST}}`（见 PLACEHOLDER_MAP）。
   - `{{CLAUDE_COLLABORATION_SUMMARY}}` / `{{CLAUDE_CONSTRAINTS_SUMMARY}}`：从 P0/P1 摘要 3～8 行。
5. 按 `meta.ai_tools[]` 与 [`adapters/`](../adapters/README.md) **仅**生成选中工具的专属文件（未选中不得创建对应路径）。
6. 若含 `cursor`：复制 `.mdc` 后 frontmatter **`alwaysApply: true`**（仅第一处 `false→true`）。  
   若含 `claude-code`：默认同时生成 `CLAUDE.md` 与 `.claude/rules/progress-maintenance.md`（见 [`adapters/claude-code.md`](../adapters/claude-code.md)）。  
   若含 `trae`：生成 `.trae/rules/progress-maintenance.md`。
7. 自检：[`GENERATION_CHECKLIST.md`](GENERATION_CHECKLIST.md)（含安全项与各工具项）。
8. 输出完成报告表格（含各文件操作与 `ai_tools` 列表）。

---

## 一键话术

```
请阅读 ai-kit/prompts/GENERATE_FROM_BRIEF.md，根据项目根目录的 PROJECT_BRIEF.md，
在 PROJECT_ROOT（ai-kit 的上一级）生成或更新：

- 通用：PROJECT_BRIEF.md、AGENTS.md、PROGRESS.md、DETAIL.md、ARCHITECTURE.md
- 按 meta.ai_tools[]（空则视为 cursor）：
  - cursor → .cursor/rules/progress-auto-update.mdc（alwaysApply: true）
  - claude-code → CLAUDE.md + .claude/rules/progress-maintenance.md
  - trae → .trae/rules/progress-maintenance.md

占位符对照 PLACEHOLDER_MAP.md；合并策略 MERGE_POLICY.md；遵守 SECURITY.md。
不要修改 ai-kit/ 内模板。完成后列出文件操作摘要与 ai-kit 版本号。
```
