# PROJECT_BRIEF.md 结构

> 输出：`{PROJECT_ROOT}/PROJECT_BRIEF.md`  
> 占位符：[`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md) · 合并：[`MERGE_POLICY.md`](MERGE_POLICY.md) · 安全：[`../SECURITY.md`](../SECURITY.md)

---

## meta

| 字段 | 说明 |
|------|------|
| `project_type` | `frontend` / `backend` / `fullstack` / `data` / `library` / `other` |
| `repo_layout` | `split` / `monorepo` / `single` |
| `current_repo_role` | `frontend` / `backend`；`monorepo` / `single` 可省略 |
| `project_name` | |
| `one_line_purpose` | |
| `ai_tools` | 数组：`cursor` / `claude-code` / `trae` / `other`（可多选）；**空数组生成时视为 `["cursor"]`** |
| `ai_tool_primary` | 主用工具，与上项之一对应 |
| `ai_tool` | （兼容）等于 `ai_tool_primary` 的展示名 |
| `trae.include_agents_md` | `yes` / `no` / `tbd` |
| `merge.agents` | `新建` / `合并-保留原概述` / `跳过` |
| `merge.claude` | 同 merge.agents，针对 `CLAUDE.md`；未答则同 agents |
| `merge.default` | `新建` / `仅缺失` / `覆盖` |
| `notes` | 可选 |

---

## tech（批次 B1～B3）

| 字段 | 说明 |
|------|------|
| `language` | 语言与版本 |
| `framework` | 框架与主库 |
| `build` | Maven / pnpm 等 |

---

## integration（批次 B4～B5）

| 字段 | 说明 |
|------|------|
| `data_sources` | 表格或「无」；`frontend`/`library` 固定「无」 |
| `constraints` | 编号列表或「无」 |

---

## structure（批次 B6～B7）

| 字段 | 说明 |
|------|------|
| `root_package` | 根包或主源码目录 |
| `entry` | 启动类 / `main.ts` 等 |
| `layers` | 编号列表，目录分工 |

---

## collaboration（P0 · 批次 E）

| 字段 | 说明 |
|------|------|
| `sibling_repo.name` | 仅 `split` |
| `sibling_repo.path_or_url` | |
| `sibling_repo.notes` | |
| `brief_source_of_truth` | `current` / `sibling` / `both`（**E10**） |
| `local_dev.processes[]` | `{ name, command, port }` |
| `local_dev.notes` | 如须先起后端 |
| `fe_to_be.mode` | `proxy` / `env` / `direct` / `n/a` |
| `fe_to_be.detail` | proxy 规则或 env 变量名 |
| `cors` | 谁处理、配置位置 |

---

## api_contract（P0 · 批次 E6～E7）

| 字段 | 说明 |
|------|------|
| `location` | 文件路径（可指另一仓） |
| `style` | `openapi` / `controller-only` / `shared-package` / `none` |
| `response_format` | 示例 JSON 或说明 |
| `error_convention` | 错误码/消息字段 |

无 FE↔BE API 时整节写「无」。

---

## auth（P0 · 批次 E8）

| 字段 | 说明 |
|------|------|
| `mechanism` | `jwt` / `session` / `oauth` / `none` |
| `header` | 如 `Authorization: Bearer` |
| `token_storage` | 前端存放方式；后端 `n/a` |
| `login_entry` | 登录 API 路径（可选） |
| `notes` | 刷新 Token、401 处理 |

---

## environment（P1 · 批次 F）

| 字段 | 说明 |
|------|------|
| `profiles[]` | `{ name, config_files[] }` |
| `fe.env_prefix` | `VITE_` 等；无前端 → `n/a` |
| `fe.env_files[]` | |
| `be.profile_names` | 无后端 → `n/a` |
| `be.config_notes` | |
| `secrets.forbidden_paths[]` | **勿写真实密钥**（见 SECURITY.md） |

---

## frontend（P1 · 批次 G）

| 字段 | 说明 |
|------|------|
| `router.mode` / `router.base` | |
| `state` | |
| `ui` | |
| `styling` | 可选 |

无前端：省略本节。

---

## quality（P1 · 批次 H）

| 字段 | 说明 |
|------|------|
| `unit.dir` / `unit.command` | |
| `integration.dir` / `integration.command` | 可选 |
| `e2e.tool` / `e2e.command` | 可选 |
| `lint.tools` / `lint.command` / `lint.pre_commit` | |

---

## progress（批次 C）

| 字段 | 说明 |
|------|------|
| `goal` | PROGRESS §1 目标段 |
| `domains[]` | `{ name, path, status }` **3～6 条** |
| `gaps[]` | `{ item, location }`；可无 |
| `milestones[]` | `{ date, summary }` |

---

## agents

| 字段 | 说明 |
|------|------|
| `major_change_criteria` | 编号列表 |
| `commands[]` | 开发 + 联调 + test + lint，去重 |

---

## architecture

| 字段 | 说明 |
|------|------|
| `tree` | 目录树 fenced block |
| `conventions` | 分层、命名、异常等 |
| `subdocs[]` | `{ title, path, note }` 可选 |

---

## optional（P2 · 批次 I）

| 字段 | 说明 |
|------|------|
| `i18n` / `ssr` / `realtime` / `infra` / `ci` / `glossary` / `observability` | 无则省略整节 |

---

## 占位符与批次顺序

- 占位符全集：[`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md)  
- 顺序：`A1` → `A2` → `B` → `E` → `F` → `G` → `H` → `C` → `I` → `D`  
- 分仓：[`../docs/SPLIT_REPO_GUIDE.md`](../docs/SPLIT_REPO_GUIDE.md)
