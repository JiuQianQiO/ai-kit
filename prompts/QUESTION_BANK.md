# 访谈题库（AI 按批提问）

回答写入 `PROJECT_BRIEF.md`（[`PROJECT_BRIEF.schema.md`](PROJECT_BRIEF.schema.md)）。裁剪：[`PROJECT_TYPES.md`](PROJECT_TYPES.md)。

**规则**：每轮 ≤8 题；必填未齐不得进入下一批。用户可说 **「跳过可选」** 跳过批次 **I**。

## 向用户展示（必读）

访谈时发给用户的表格**必须**比本题库多一列 **`#`**（见 [`INTERVIEW_PROTOCOL.md`](INTERVIEW_PROTOCOL.md)）：

| 列 | 说明 |
|----|------|
| **#** | 本轮 **1、2、3…** 连续编号（裁剪后重排；跳过的题不展示、不占号） |
| **ID** | 题库 ID，写入 `PROJECT_BRIEF` 用 |
| 问题 / 必填 / AI 建议 | 同下表 |

下表「参考 #」供 AI 对照；**实际展示以裁剪后重排的 # 为准**。用户回复优先解析 **`#: 答案`**，其次 `ID: 答案`。

---

## 批次 A1 · 项目与类型（第 1 轮，≤8 题）

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | A0 | 项目类型？ | 是 | `meta.project_type` |
| 2 | A1 | 项目名称？ | 是 | `meta.project_name` |
| 3 | A2 | 一句话目标？ | 是 | `meta.one_line_purpose` |
| 4 | A3 | 团队使用哪些 AI？（**可多选**：Cursor / Claude Code / Trae / 其它） | 是 | `meta.ai_tools[]` |
| 5 | A3b | 主用哪个？（生成文档默认口吻，单选） | 是 | `meta.ai_tool_primary` |
| 6 | A3c | 若选 Trae：是否在设置中开启「Include AGENTS.md」？（是/否/待定） | 条件 | `meta.trae.include_agents_md` |

---

## 批次 A2 · 仓库与合并（第 2 轮，≤8 题）

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | A6 | 仓库协作？（前后端分仓 / 全栈单仓 / 仅本仓） | 是 | `meta.repo_layout` |
| 2 | A7 | 当前是前端仓还是后端仓？（仅 **分仓**） | 条件 | `meta.current_repo_role` |
| 3 | A8 | 另一仓库名称与路径/URL？（仅 **分仓**） | 条件 | `collaboration.sibling_repo` |
| 4 | A4 | 已有 `AGENTS.md`？（新建 / 合并-保留原概述 / 跳过） | 是 | `meta.merge.agents` |
| 5 | A4b | 已有 `CLAUDE.md`？（新建 / 合并-保留原概述 / 跳过） | 条件 | `meta.merge.claude` |
| 6 | A5 | 其它规范文件？（新建 / 仅缺失 / 覆盖） | 是 | `meta.merge.default` |

**A4b**：仅当 A3 含 **Claude Code** 且项目根已存在 `CLAUDE.md` 时必问；否则写入简报时 `merge.claude` 同 `merge.agents`。

先 **A1** 再 **A2**，然后进入批次 B。合并细则见 [`MERGE_POLICY.md`](MERGE_POLICY.md)。

---

## 批次 B · 技术栈与约束

`frontend`/`library` **不问** B4、B5。

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | B1 | 语言与版本？（如 Java 17、TypeScript 5） | 是 | `tech.language` |
| 2 | B2 | 框架与主要库？（如 Spring Boot 2.7、Vue 3） | 是 | `tech.framework` |
| 3 | B3 | 构建/包管理？（Maven、pnpm …） | 是 | `tech.build` |
| 4 | B4 | 多个数据源或外部系统？无则「无」 | 条件 | `integration.data_sources` |
| 5 | B5 | 跨库/跨服务约束？（编号；B4=无时自动「无」） | 条件 | `integration.constraints` |
| 6 | B6 | 入口与主源码位置？（措辞见 PROJECT_TYPES） | 是 | `structure.entry` 等 |
| 7 | B7 | 顶层/源码目录分工？ | 是 | `structure.layers` |
| 8 | B8 | 大变更补充判定？ | 否 | `agents.major_change_criteria` |

**B4 若有数据源**：每源追问一行——名称、类型、用途、代码路径。

---

## 批次 E · P0 前后端协作（在 F 之前）

`library` **整批跳过**。`single` 且无 HTTP API：只问 **E1**，E4～E9 标 N/A。  
裁剪细则见 [`PROJECT_TYPES.md`](PROJECT_TYPES.md)；生成见 [`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md)。

| 参考 # | ID | 问题 | 必填 | 何时 |
|--------|-----|------|------|------|
| 1 | E1 | 协作形态是否与 A6 一致？本地联调是否要多进程？ | 是 | 非 library |
| 2 | E4 | 本仓要启动什么？命令与端口？（可多行） | 是 | 非 library |
| 3 | E5 | 前端如何访问后端？（`vite.proxy` / `VITE_*` / 直连 URL） | 条件 | 有前端或 monorepo 含 FE |
| 4 | E6 | 接口契约在哪？（OpenAPI 路径 / 无契约看 Controller / 共享包） | 条件 | 有 FE↔BE API |
| 5 | E7 | 统一响应格式？一行 JSON 示例或「无统一封装」 | 条件 | 有 FE↔BE API |
| 6 | E8 | 鉴权？机制、Header、前端 Token 存放？ | 条件 | 需登录或带 Token |
| 7 | E9 | 跨域谁处理？（后端 CORS / 网关 / 仅 dev proxy） | 条件 | 浏览器访问 API |
| 8 | E10 | **契约/简报以哪仓为准？**（当前仓 / 另一仓 / 各写各仓） | 条件 | `split` 时必填 |

### 分仓 · **前端仓**

- **必问**：E4、E5、E6、E7、E8、E9、E10  
- E6 若契约在后端仓：写明 `../另一仓路径/openapi.yaml`

### 分仓 · **后端仓**

- **必问**：E4、E6、E7、E8、E10；E5 写「供前端 proxy/env 访问本服务」；E9 注明 CORS 或「仅 dev proxy」

### 全栈单仓（`monorepo`）

- **不问** E10 的「另一仓」；E10 可写「本仓为准」  
- **必问**：E4～E9（每轮 ≤8，可拆两轮）

---

## 批次 F · P1 环境与配置

`library` **跳过**。

| 参考 # | ID | 问题 | 必填 | 何时 |
|--------|-----|------|------|------|
| 1 | F1 | 有哪些环境？（local/dev/staging/prod）各用哪个配置文件？ | 是 | 非 library |
| 2 | F2 | 前端环境变量前缀？`.env*` 文件路径？（无前端则 N/A） | 条件 | 有前端：见下 |
| 3 | F3 | 后端 `spring.profiles` / 配置中心？（无后端则 N/A） | 条件 | 有后端 |
| 4 | F4 | 禁止提交或禁止 AI 修改的文件？（如 `.env.local`、`secrets/`；**勿提供真实密钥**，见 SECURITY.md） | 是 | 非 library；无则写「无」 |

**有前端**：`project_type=frontend`，或 `current_repo_role=frontend`，或 `monorepo` 且扫描到 `vite`/`vue`/`react`。

**有后端**：`backend`/`fullstack`/`data`，或 `current_repo_role=backend`，或 monorepo 有 `pom.xml`/`build.gradle`。

---

## 批次 G · P1 前端工程化

**仅在有前端时**整批问；纯后端仓 **跳过**。

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | G1 | 路由模式与 `base`？（history/hash、部署子路径） | 是 | `frontend.router` |
| 2 | G2 | 状态管理？（Pinia/Vuex/Redux/Zustand/无） | 是 | `frontend.state` |
| 3 | G3 | UI 库与设计规范？（Element Plus、Ant Design…） | 是 | `frontend.ui` |
| 4 | G4 | 样式方案？（Tailwind、CSS Modules、scoped） | 否 | `frontend.styling` |

---

## 批次 H · P1 测试与代码质量

`library` **默认跳过**；用户声明有单测时再问 H1、H4。

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | H1 | 单元测试目录与命令？（无则「无」） | 是 | `quality.unit` |
| 2 | H2 | 集成测试？目录与命令？ | 否 | `quality.integration` |
| 3 | H3 | E2E？工具与命令？（Cypress/Playwright…） | 否 | `quality.e2e` |
| 4 | H4 | Lint/Format 工具？是否 pre-commit/husky？ | 是 | `quality.lint` |

---

## 批次 I · P2 可选（可整批跳过）

| 参考 # | ID | 问题 | 映射 |
|--------|-----|------|------|
| 1 | I1 | 国际化 i18n？目录与用法 | `optional.i18n` |
| 2 | I2 | SSR/SSG？（Nuxt/Next 等） | `optional.ssr` |
| 3 | I3 | WebSocket / SSE？ | `optional.realtime` |
| 4 | I4 | Redis / MQ / 多租户？ | `optional.infra` |
| 5 | I5 | CI 配置路径？（GitHub Actions、Jenkinsfile） | `optional.ci` |
| 6 | I6 | 领域名词表 3～5 条？ | `optional.glossary` |
| 7 | I7 | 日志与 TraceId 约定？ | `optional.observability` |

---

## 批次 C · 进度快照

| 参考 # | ID | 问题 | 必填 | 映射 |
|--------|-----|------|------|------|
| 1 | C1 | 当前业务目标？（可比 A2 展开） | 是 | `progress.goal` |
| 2 | C2 | 交付快照 3～6 行：域 / 路径 / 状态？（AI 可先据扫描填建议） | 是 | `progress.domains[]` |
| 3 | C3 | 已知缺口？无则「无」 | 是 | `progress.gaps[]` |
| 4 | C4 | 是否加一条初始化里程碑？（默认：今天 + 接入 ai-kit） | 否 | `progress.milestones[]` |

**状态枚举**：`已齐` / `进行中` / `占位` / `未实现`  
**分仓前端域示例**：页面路由、组件、api 层、构建发布。**后端域示例**：controller、service、持久层、鉴权。

---

## 批次 D · 可选补充

| 参考 # | ID | 问题 | 映射 |
|--------|-----|------|------|
| 1 | D1 | 工程目录树（3～4 层）？ | `architecture.tree` |
| 2 | D2 | 命名/分层/异常等约定？ | `architecture.conventions` |
| 3 | D3 | 常用命令？（与 H、E4 合并去重写入 `agents.commands`） | `agents.commands[]` |
| 4 | D4 | 子级 ARCHITECTURE 索引？ | `architecture.subdocs[]` |
| 5 | D5 | 其它禁忌？ | `meta.notes` |

**D3 与 H 关系**：`agents.commands` 应合并 **开发 + 测试 + lint** 命令（去重）。

---

## 批次顺序

```text
A1 → A2 → B → E → F → G → H → C → I → D
         ↑   ↑   ↑   ↑
        P0  P1  P1  P1  ；I=P2 可选
```

`G` 无前端时跳过；`I` 用户说「跳过可选」时跳过。

---

## 确认前自检

- [ ] 向用户展示的每轮表均含 **#** 列且从 1 连续编号；已说明可用 `#` 或 `ID` 回复  
- [ ] A1、A2 已完成；P0：E1/E4 已填；有 API 则 E6～E10；`split` 已填 E10  
- [ ] P1：F1/F4、H1/H4 已填；有前端则 G1～G3  
- [ ] P2：仅当未跳过 I 时写入 `optional.*`  
- [ ] AGENTS 将含环境、前端工程（或删除）、测试质量三节  
