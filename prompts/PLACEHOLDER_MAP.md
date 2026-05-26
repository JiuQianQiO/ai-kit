# 模板占位符对照表（生成时唯一权威）

> 生成 `AGENTS.md`、`PROGRESS.md`、`ARCHITECTURE.md` 等时**必须**替换本表全部适用占位符。  
> 禁止将 `<!-- AI：... -->` 注释写入交付物。  
> 完整简报字段见 [`PROJECT_BRIEF.schema.md`](PROJECT_BRIEF.schema.md)。

---

## 仓库角色标签（`AGENTS.md` 文首）

| `meta.repo_layout` | `meta.current_repo_role` | `{{REPO_LAYOUT_LABEL}}` | `{{CURRENT_REPO_ROLE_LABEL}}` |
|--------------------|--------------------------|---------------------------|-------------------------------|
| `split` | `frontend` | 前后端分仓 | 前端仓 |
| `split` | `backend` | 前后端分仓 | 后端仓 |
| `monorepo` | （可不填） | 全栈单仓 | 全栈（同仓） |
| `single` | （可不填） | 仅本仓 | 本仓 |

---

## AGENTS.md（`templates/AGENTS.base.md`）

| 占位符 | 来源字段 | 说明 |
|--------|----------|------|
| `{{PROJECT_NAME}}` | `meta.project_name` | |
| `{{ONE_LINE_PURPOSE}}` | `meta.one_line_purpose` | |
| `{{REPO_LAYOUT_LABEL}}` | 上表 | |
| `{{CURRENT_REPO_ROLE_LABEL}}` | 上表 | |
| `{{TECH_STACK}}` | `tech.language` + `tech.framework` + `tech.build` 合并一行 | |
| `{{DS_NAME}}` … `{{DS_CODE_PATH}}` | `integration.data_sources` 表行 | 多行则拆表；无则**删整节「数据源」** |
| `{{REPO_COLLABORATION}}` | `meta.repo_layout`、`collaboration.sibling_repo`、`collaboration.brief_source_of_truth` | 分仓写明另一仓与契约主仓 |
| `{{LOCAL_DEV}}` | `collaboration.local_dev` | 进程/命令/端口列表 |
| `{{API_CONTRACT}}` | `api_contract.*` | 不适用时写「本仓不适用，见 {另一仓}」 |
| `{{AUTH}}` | `auth.*` | 无鉴权写「无」 |
| `{{ENVIRONMENT}}` | `environment.*` | |
| `{{FRONTEND_ENGINEERING}}` | `frontend.*` | 无前端则**删除「前端工程」整节** |
| `{{QUALITY}}` | `quality.*` | |
| `{{OPTIONAL_NOTES}}` | `optional.*` 摘要 | 无 P2 则**删除「其它约定」整节** |
| `{{CORE_CONSTRAINTS_LIST}}` | `integration.constraints` + 关键禁止项编号列表 | |
| `{{DIRECTORY_STRUCTURE_LIST}}` | `structure.layers` | |
| `{{MAJOR_CHANGE_CRITERIA}}` | `agents.major_change_criteria` | 无则写「沿用维护规则默认」 |
| `{{COMMON_COMMANDS}}` | `agents.commands` + `quality.*.command` + `collaboration.local_dev` 命令 | 去重，每行一条 |
| `{{MAINTENANCE_RULES_REF}}` | `meta.ai_tools[]` | 一句：指向 `AGENTS.md`「AI 工具与维护规则」表中**主用**工具对应行；仅 `other` 时写「以本文件维护摘要为准」 |
| `{{AI_TOOLS_MAINTENANCE_SECTION}}` | `meta.ai_tools[]`、`meta.ai_tool_primary` | 见下节「AI 工具与维护规则」整节 Markdown |

### `{{AI_TOOLS_MAINTENANCE_SECTION}}` 生成规则

- `meta.ai_tools` **为空** → 视为 `["cursor"]`。  
- 文首列出团队选用工具（中文标签：Cursor / Claude Code / Trae / 其它）与**主用**一项。  
- 表格列：**工具 | 维护规则位置 | 说明**；仅包含 `ai_tools` 中的行：

| 工具键 | 维护规则位置 | 说明（摘要） |
|--------|----------------|--------------|
| `cursor` | `.cursor/rules/progress-auto-update.mdc` | 权威细则；项目根 `alwaysApply: true` |
| `claude-code` | `CLAUDE.md` + `.claude/rules/progress-maintenance.md` | 前者宜短，后者与 `ai-kit/rules/` 同文 |
| `trae` | `.trae/rules/progress-maintenance.md` | 建议开启 Include AGENTS.md |
| `other` | （无专属文件） | 以 `AGENTS.md` 本节与 DETAIL/PROGRESS 为准 |

- 表后一行：**共通** — 会话开始读 PROGRESS §1/§2；实质变更写 DETAIL；commit/大变更按上表更新 PROGRESS。  
- **未**出现在 `ai_tools` 中的工具**不得**写入表或暗示已生成对应目录。

---

## PROGRESS.md（`templates/PROGRESS.template.md`）

| 占位符 | 来源 |
|--------|------|
| `{{PROJECT_NAME}}` | `meta.project_name` |
| `{{LAST_UPDATED}}` | 当天 `YYYY-MM-DD`（**北京时间** / `Asia/Shanghai`） |
| `{{AI_KIT_VERSION}}` | `ai-kit/VERSION` |
| `{{PROJECT_GOAL}}` | `progress.goal` |
| `{{DOMAIN_1..6_*}}` | `progress.domains[]`：**保留 3～6 行**；`domains` 不足 6 条时删除多余 `{{DOMAIN_N}}` 行；超过 6 条则合并或拆入 `OPTIONAL_DETAIL_PARAGRAPH` |
| `{{OPTIONAL_DETAIL_PARAGRAPH}}` | `progress` 补充段；无则删除整段 |
| `{{GAP_1}}` / `{{GAP_1_LOCATION}}` | `progress.gaps[]`；无缺口则表内写一行「无」 |

---

## ARCHITECTURE.md（`templates/ARCHITECTURE.template.md`）

| 占位符 | 来源 |
|--------|------|
| `{{PROJECT_NAME}}` | `meta.project_name` |
| `{{ONE_LINE_PURPOSE}}` | `meta.one_line_purpose` |
| `{{OPTIONAL_SUB_ARCHITECTURE_ROWS}}` | `architecture.subdocs[]` 表格行；无则删占位整行 |
| `{{PROJECT_ROOT_TREE}}` | `architecture.tree` |
| `{{LAYERING_AND_CONVENTIONS}}` | `architecture.conventions` |
| `{{COLLABORATION_ARCHITECTURE}}` | P0 协作 + 契约主仓说明 |
| `{{ENV_QUALITY_ARCHITECTURE}}` | `environment` + `quality` 摘要 |

---

## DETAIL.md（`templates/DETAIL.template.md`）

| 占位符 | 来源 |
|--------|------|
| `{{INIT_DATETIME}}` | 生成时刻（**北京时间** `YYYY-MM-DD HH:mm:ss`） |
| `{{AI_KIT_VERSION}}` | `ai-kit/VERSION` |
| `{{MAINTENANCE_RULES_REF}}` | 同 AGENTS | PROGRESS 文首与 AGENTS 一致 |
| `{{INIT_PATHS_LIST}}` | 本次实际生成的文件 | 反引号包裹、顿号分隔；**必含** `PROJECT_BRIEF.md`、`AGENTS.md`、`PROGRESS.md`、`DETAIL.md`、`ARCHITECTURE.md`；再按 `ai_tools` 追加专属路径（见 OUTPUT_PATHS）；init 骨架默认含 `.cursor/rules/progress-auto-update.mdc` |

---

## CLAUDE.md（`templates/CLAUDE.template.md`）

| 占位符 | 来源 |
|--------|------|
| `{{CLAUDE_COLLABORATION_SUMMARY}}` | P0 协作 + 契约一行摘要 |
| `{{CLAUDE_CONSTRAINTS_SUMMARY}}` | `integration.constraints` + 关键禁止项 |

## init 脚本（`scripts/init-ai-docs.*`）

仅自动替换：`{{PROJECT_NAME}}`、`{{LAST_UPDATED}}`、`{{INIT_DATETIME}}`、`{{AI_KIT_VERSION}}`。  
其余占位符保留 → 须走 [`START_HERE.md`](../START_HERE.md) 访谈生成。

---

## 生成后自检

- [ ] 无残留 `{{`（除用户刻意保留的示例）
- [ ] 无 `<!-- AI：` 注释
- [ ] `REPO_LAYOUT_LABEL` / `CURRENT_REPO_ROLE_LABEL` 已按上表填写
- [ ] `monorepo` 未误写「前端仓/后端仓」除非 `current_repo_role` 有值
- [ ] `ai_tools` 未选中的工具无对应路径引用；`INIT_PATHS_LIST` 与本次生成一致
