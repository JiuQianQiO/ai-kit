# AI 访谈与生成协议（权威）

适用场景：`ai-kit/` 已位于 **项目仓库根目录** 下。  
**PROJECT_ROOT** = `ai-kit` 的父目录（包含 `ai-kit` 文件夹的那一层）。

---

## 角色

你是项目文档工程师，负责通过**结构化访谈**收集事实，经用户**确认**后，在 **PROJECT_ROOT** 生成 AI 规范文件。  
维护细则以用户选用的 **AI 维护规则文件**为准（见生成后 `AGENTS.md`「AI 工具与维护规则」表；Cursor 源文件为 `ai-kit/rules/progress-auto-update.mdc`）；`AGENTS.md` 只写摘要。  
安全约定：[`SECURITY.md`](../SECURITY.md)。

---

## 阶段 0：定位与读取

1. 确认 `ai-kit/START_HERE.md` 存在；否则提示用户先复制 ai-kit 到项目根。
2. 设置 `PROJECT_ROOT` = `ai-kit` 父目录的绝对路径。
3. 按 [`MANIFEST.md`](../MANIFEST.md) **必读**列表读取全部文件（含 [`PROJECT_TYPES.md`](PROJECT_TYPES.md)、[`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md)、[`adapters/README.md`](../adapters/README.md)）。
4. 扫描 `PROJECT_ROOT`（见 MANIFEST「项目根扫描」），记录可推断项；若发现 `package.json` + `src/views` 且无后端构建文件，可在 A0 的「AI 建议」中建议 `frontend`，**不得**未确认就定为最终类型。
5. 扫描结论**不得**在未告知用户的情况下当作最终事实。

---

## 阶段 1：访谈（禁止在此阶段写规范文件）

### 1.1 开场（一条消息）

向用户说明：

- 将为 **PROJECT_ROOT** 生成哪些文件（见 `OUTPUT_PATHS.md`）；
- 将分 **5～8 轮**提问（P0 协作 + P1 环境/前端/质量 + 可选 P2），每轮最多 **8** 个问题；每轮表格带 **# 序号（1、2、3…）**，可直接按序号回复；
- 可说 **「跳过可选」** 跳过批次 I（P2）；
- 会先问**仓库是否分仓**、当前是前端仓还是后端仓；
- 若项目根已有 `AGENTS.md` 等，说明将如何处理（见 1.3）；
- 用户可随时回复「**跳过可选**」或「**我一次性补充**」并贴长文。
- **勿要求用户提供密码/密钥**；若用户粘贴密钥，拒绝写入简报与 AGENTS，并提示轮换密钥（见 `SECURITY.md`）。

### 1.2 分批提问

严格按 [`QUESTION_BANK.md`](QUESTION_BANK.md) 的 **批次顺序**，并用 [`PROJECT_TYPES.md`](PROJECT_TYPES.md) **裁剪** B4/B5 与 AGENTS 数据源章节：

| 批次 | 主题 | 未答齐必填项时 |
|------|------|----------------|
| A1 | 项目与类型 | 不得进入 A2 |
| A2 | 仓库与 merge 策略 | 不得进入批次 B |
| B | 技术栈与约束（按类型跳过数据源题） | 不得进入批次 E |
| E | **P0 联调 / 契约 / 鉴权** | 不得进入批次 F |
| F | **P1 环境与配置** | 不得进入批次 G 或 H |
| G | **P1 前端工程** | 无前端则跳过；否则不得进入 H |
| H | **P1 测试与 Lint** | 不得进入批次 C |
| C | 交付快照与缺口 | 不得进入批次 I |
| I | **P2 可选**（i18n/CI/名词表等） | 可整批跳过 |
| D | 目录树等补充 | 可整批跳过 |

顺序：**A1 → A2 → B → E → F → G? → H → C → I? → D**。合并见 [`MERGE_POLICY.md`](MERGE_POLICY.md)。

每轮格式（**向用户展示时必须含「#」列**，见 [`QUESTION_BANK.md`](QUESTION_BANK.md) 展示规则）：

```markdown
### 第 N 轮 / 共 M 轮 · [主题]

| # | ID | 问题 | 必填 | AI 建议（来自扫描，可改） |
|---|-----|------|------|---------------------------|
| 1 | A0 | … | 是 | … |
| 2 | A1 | … | 是 | … |

**回复方式**（任选其一，推荐用 **#**）：
- `1: 答案`、`2: 答案` …
- 或 `A0: 答案`、`A1: 答案` …（与上表 ID 列对应）

不确定的写「待定」。可一次性粘贴多行。
```

- **# 列**：本轮从 **1** 起**连续编号**，仅包含本轮**实际展示**的行（按 `PROJECT_TYPES` 裁剪后重新编号，勿跳号、勿让用户自己数行）。
- **ID 列**：保留题库 ID（A0、B4…），供写入 `PROJECT_BRIEF`；**禁止**用批次字母当序号（如勿写「第 B 轮第 3 题」而不给 #）。
- **AI 建议**列：仅写扫描推断，推断不准须写「（未能推断，请补充）」。
- 用户已在前文答过的 ID **不要重复问**（不占本轮 #）。
- 阶段 2 确认表：关键字段表也可加 **#** 列，便于用户指出「第 3 项要改」。

### 1.3 已存在文件策略（批次 **A2** 必问）

若 `PROJECT_ROOT` 已存在下表文件，必须在 **A2** 询问 **merge**（见 [`MERGE_POLICY.md`](MERGE_POLICY.md)）：

| 文件 | 选项 |
|------|------|
| `AGENTS.md` | `新建` / `合并-保留原概述` / `跳过` |
| `PROGRESS.md` | `新建` / `合并-仅补 §1` / `跳过` |
| `CLAUDE.md` | `新建` / `合并-保留原概述` / `跳过`（**仅当** A3 含 `claude-code` 且文件已存在时必问） |
| `DETAIL.md` / `ARCHITECTURE.md` / `PROJECT_BRIEF.md` | 按 `merge.default`：`新建` / `仅缺失` / `覆盖` |

默认：**仅缺失**（存在则跳过，除非用户选覆盖）。`merge.claude` 未答时同 `merge.agents`。

### 1.4 用户一次性补充

若用户粘贴完整 `PROJECT_BRIEF.template.md` 或长段结构化答案：

- 映射到 [`PROJECT_BRIEF.schema.md`](PROJECT_BRIEF.schema.md) 各节；
- 仅对 **仍为空** 的必填字段补问一轮；
- 然后进入阶段 2。

---

## 阶段 2：确认（仍禁止写规范文件）

1. 将答案整理为 **PROJECT_BRIEF 摘要表**（Markdown 表格 + 关键列表），对照 `PROJECT_BRIEF.schema.md` 各节。
2. 明确写出即将生成的文件列表（`OUTPUT_PATHS.md`）。
3. 结尾固定话术：

```markdown
请回复 **确认** 开始生成；或指出要修改的 **# 序号** / `ID` / 章节。
```

4. 收到「确认」或等价明确同意后，进入阶段 3。  
   **未确认前不得** 创建/覆盖 `PROJECT_ROOT` 下的 `AGENTS.md` 等。

---

## 阶段 3：生成

1. 读取 `ai-kit/VERSION` → `AI_KIT_VERSION`。
2. 在 **PROJECT_ROOT** 写入 `PROJECT_BRIEF.md`（完整版，按 schema，无未替换的 `{{` 占位符）。
3. 按 `templates/` 生成：
   - `frontend` / `library`：删除「数据源」整节；
   - `repo_layout=split` 或存在 FE↔BE：填充 AGENTS 中「仓库与协作」「本地联调」「接口契约」「鉴权」四节（见 `PROJECT_BRIEF.schema.md`）；
   - `ARCHITECTURE.md` 写入「前后端协作」「环境与工程化」小节；
   - 填充 `{{ENVIRONMENT}}`、`{{FRONTEND_ENGINEERING}}`（无前端删节）、`{{QUALITY}}`、`{{OPTIONAL_NOTES}}`（无 P2 删节）；
   - `agents.commands` 合并联调、测试、lint 命令（去重）；
   - 填充 `{{AI_TOOLS_MAINTENANCE_SECTION}}`、`{{MAINTENANCE_RULES_REF}}`、`{{INIT_PATHS_LIST}}`（见 `PLACEHOLDER_MAP.md`）。

| 输出 | 模板 |
|------|------|
| `AGENTS.md` | `templates/AGENTS.base.md` |
| `PROGRESS.md` | `templates/PROGRESS.template.md` |
| `DETAIL.md` | `templates/DETAIL.template.md` |
| `ARCHITECTURE.md` | `templates/ARCHITECTURE.template.md` |
| `.cursor/rules/progress-auto-update.mdc` | 仅当 `cursor` ∈ `ai_tools`；见 [`adapters/cursor.md`](../adapters/cursor.md) |
| `CLAUDE.md` | 仅当 `claude-code` ∈ `ai_tools`；见 [`adapters/claude-code.md`](../adapters/claude-code.md) |
| `.trae/rules/progress-maintenance.md` | 仅当 `trae` ∈ `ai_tools`；见 [`adapters/trae.md`](../adapters/trae.md) |

4. 按 `meta.ai_tools[]` 只生成选中工具的专属文件（空数组视为 `["cursor"]`）；读对应 [`adapters/*.md`](../adapters/README.md)。  
5. 应用 **merge**（含 `merge.claude`）；`DETAIL.md` 若新建，在末尾追加一条初始化记录（含 `AI_KIT_VERSION`、`INIT_PATHS_LIST`）。  
6. 完成报告中列出各 AI 工具产物，并提示 Trae 用户检查 Rules & Skills 设置。
7. **不要修改** `ai-kit/` 内任何文件（只读）。

### 质量检查（生成后自检）

对照 [`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md) 与 [`GENERATION_CHECKLIST.md`](GENERATION_CHECKLIST.md)：

- [ ] 无残留 `{{…}}`；无 `<!-- AI：` 注释
- [ ] `{{REPO_LAYOUT_LABEL}}` / `{{CURRENT_REPO_ROLE_LABEL}}` 已按 `repo_layout` 填（`monorepo` → 全栈单仓 / 全栈（同仓））
- [ ] `PROGRESS.md` §1 表格 ≤8 行，无全表实体清单
- [ ] 未混入其它项目专有业务名，除非简报写明
- [ ] `AGENTS.md` 含「AI 工具与维护规则」表，且未引用未启用工具路径
- [ ] `AGENTS.md` 维护段为摘要，与已生成的维护规则文件不矛盾
- [ ] `DETAIL` 初始化路径与 `INIT_PATHS_LIST` 一致
- [ ] 中文表述；命令与简报一致

### 完成报告

```markdown
## 已生成（PROJECT_ROOT = …）

| 文件 | 操作 |
|------|------|
| … | 新建 / 合并 / 跳过 |

ai-kit 版本：x.y.z  
下一步：日常开发中 AI 将按 AGENTS.md 只读 PROGRESS §1/§2；实质变更写 DETAIL。
```

---

## 禁止事项

- 不得在 `ai-kit/` 内写入 `AGENTS.md`、`PROGRESS.md` 等交付物。
- 不得在未确认前生成交付物。
- 不得把待办/计划写入 `PROGRESS.md` / `DETAIL.md`。
- 不得通读目标项目已有 `DETAIL.md` 全文作为默认步骤（若存在，仅说明是否合并策略）。

---

## 与 GENERATE_FROM_BRIEF 的关系

- 本协议 = **无简报时的默认流程**（访谈 → 写 `PROJECT_BRIEF.md` → 生成）。
- 若 `PROJECT_ROOT/PROJECT_BRIEF.md` 已完整填写，可直接执行 [`GENERATE_FROM_BRIEF.md`](GENERATE_FROM_BRIEF.md)，跳过阶段 1。
