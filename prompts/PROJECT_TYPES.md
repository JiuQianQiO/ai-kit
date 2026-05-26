# 项目类型与题库裁剪

先定 `meta.project_type`、`meta.repo_layout`，再按表裁剪。  
- **P0**：批次 E → [`QUESTION_BANK`](QUESTION_BANK.md)  
- **P1**：批次 F / G / H  
- **P2**：批次 I（可选）

---

## 类型与仓库（A0 / A6）

（同 v1.3：frontend、backend、fullstack、data、library、other；split / monorepo / single）

分仓时必填 `current_repo_role`、`sibling_repo`、`collaboration.brief_source_of_truth`（批次 **E10**）。

### `monorepo` 时

- **不问** A7、A8、E10（另一仓）。  
- `meta.current_repo_role` 可留空。  
- 生成标签见 [`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md)：`全栈单仓` / `全栈（同仓）`。

---

## B4 / B5 · 数据源

| 类型 | B4 | B5 |
|------|----|----|
| frontend、library | 不问 | 不问 |
| 其它 | 按前表 | B4≠无 时问 B5 |

---

## 批次 E · P0

| 条件 | 行为 |
|------|------|
| library | 跳过 |
| split / monorepo / 有 API | 按 [`QUESTION_BANK`](QUESTION_BANK.md) 问 E1、E4～E10 |
| split | E10 必填（契约主仓） |

---

## 批次 F · P1 环境

| 条件 | 行为 |
|------|------|
| library | 跳过 |
| 有前端 | 必问 F2 |
| 有后端 | 必问 F3 |
| 全部 | F1、F4 必填 |

---

## 批次 G · P1 前端工程

| 条件 | 行为 |
|------|------|
| 无前端（纯后端仓、且无 UI） | **整批跳过** |
| frontend / split 前端仓 / monorepo 含 FE | G1～G3 必填，G4 可选 |

生成：写入 AGENTS「前端工程」；否则**删除该节**。

---

## 批次 H · P1 测试与质量

| 条件 | 行为 |
|------|------|
| library | 仅在有单测时问 H1/H4，否则跳过 |
| 其它 | H1、H4 必填；H2/H3 可选 |

---

## 批次 I · P2 可选

用户未说「跳过可选」时，在 **C 之前或 D 之前** 用一轮（≤8 题）速问 I1～I7，或让用户勾选需要的 ID。

未答的 I* 不写入 `PROJECT_BRIEF.optional` 或标 `无`。

---

## `meta.ai_tools[]` · 生成裁剪（P0）

| `ai_tools` 含 | 生成 | 不生成 |
|---------------|------|--------|
| `cursor` | `.cursor/rules/progress-auto-update.mdc`（`alwaysApply: true`） | — |
| `claude-code` | `CLAUDE.md`、`.claude/rules/progress-maintenance.md`（默认二者都生成） | — |
| `trae` | `.trae/rules/progress-maintenance.md` | — |
| `other` | 仅通用五件套 + `AGENTS` 维护表 | 上述专属路径 |
| **空数组** | 视为 `["cursor"]` | 其它工具专属文件 |

- `AGENTS.md` / `PROGRESS.md` / `DETAIL.md`：**始终**生成（通用，跨工具）。  
- 维护细则引用：用 [`PLACEHOLDER_MAP`](PLACEHOLDER_MAP.md) 的 `{{MAINTENANCE_RULES_REF}}` / `{{AI_TOOLS_MAINTENANCE_SECTION}}`，**禁止**在仅选 Trae/Claude 时写死 `.cursor/rules/…`。  
- 批次 **A2**：若 `claude-code` ∈ `ai_tools`，必问 `CLAUDE.md` 合并策略（`meta.merge.claude`）。

---

## 生成 AGENTS.md

| 节 | 条件 |
|----|------|
| **AI 工具与维护规则** | 始终（由 `ai_tools` 填表） |
| 数据源 | frontend/library 删除 |
| P0 四节（协作/联调/契约/鉴权） | split 或 有 API；**保留标题**，不适用项注明并指向主仓 |
| **环境与配置** | 非 library |
| **前端工程** | 有前端 |
| **测试与代码质量** | 非 library |
| **可观测 / 领域词汇** | 仅当 optional 有内容时追加小节或并入 ARCHITECTURE |

`agents.commands` = 联调命令 + F/H 中的 test/lint 命令（去重）。

---

## AI 自检

- [ ] 顺序 A1→A2→B→E→F→G?→H→C→I?→D  
- [ ] 每轮 ≤8 题  
- [ ] 纯后端仓未问 G1～G3  
- [ ] PROJECT_BRIEF 含 `environment`、`quality`；有前端含 `frontend`  
- [ ] `meta.ai_tools[]` 已填；仅生成选中工具的专属文件  
- [ ] `ai_tools` 为空时已按 `["cursor"]` 处理  
- [ ] AGENTS/PROGRESS 无误导性的未启用工具路径  
- [ ] `DETAIL` 初始化路径 `INIT_PATHS_LIST` 与本次生成一致
