# ai-kit 文件清单（AI 接入时必须读取）

> 会话开始时通读下列文件（路径均相对于 `ai-kit/`），再扫描 **项目根** `PROJECT_ROOT`（`ai-kit` 的父目录）。

## 必读（流程与输出）

| 优先级 | 路径 | 用途 |
|--------|------|------|
| P0 | `START_HERE.md` | 人类入口、三步流程 |
| P0 | `VERSION` | 套件版本号 |
| P0 | `prompts/INTERVIEW_PROTOCOL.md` | 访谈与生成权威步骤 |
| P0 | `prompts/QUESTION_BANK.md` | 分批提问清单 |
| P0 | `prompts/PROJECT_TYPES.md` | 项目类型与跳过数据源等裁剪规则 |
| P0 | `prompts/OUTPUT_PATHS.md` | 生成文件的目标路径 |
| P0 | `prompts/PLACEHOLDER_MAP.md` | 模板 `{{占位符}}` 与简报字段对照（生成必读） |
| P0 | `prompts/MERGE_POLICY.md` | 合并/覆盖已有 AGENTS 等 |
| P1 | `prompts/PROJECT_BRIEF.schema.md` | 访谈结果 `PROJECT_BRIEF.md` 的结构 |
| P1 | `templates/*.md` | 生成文稿的结构与占位符 |
| P0 | `adapters/README.md` | 多 AI 工具（Cursor / Claude Code / Trae）生成路径 |
| P0 | `SECURITY.md` | 简报/生成物禁止写入密钥；`PROJECT_BRIEF` 入库建议 |
| P1 | `rules/progress-auto-update.mdc` | 复制到**项目根** `.cursor/rules/` 的源文件 |
| P0 | `prompts/GENERATION_CHECKLIST.md` | 生成后逐项自检 |

## 选读（按需）

| 路径 | 用途 |
|------|------|
| `README.md` | 语言入口 |
| `README_CN.md` / `README_EN.md` | 人类使用说明（中/英） |
| `prompts/GENERATE_FROM_BRIEF.md` | 已有完整简报时的一次性生成 |
| `prompts/PROJECT_BRIEF.template.md` | 人类可手写简报（与 schema 等价） |
| `scripts/init-ai-docs.ps1` | 非 AI 的机械初始化 |
| `snippets/gitignore.project-brief.txt` | 可选 `.gitignore` 片段 |
| `docs/SPLIT_REPO_GUIDE.md` | 前后端分仓双仓接入 |
| `CHANGELOG.md` | 版本变更 |

**勿读/勿用**：`ai-kit/.cursor/`（已移除；v1.4.2 起无此目录）。Cursor 规则源仅用 `ai-kit/rules/`，部署到 **项目根** `.cursor/rules/`。

## 项目根扫描建议（PROJECT_ROOT）

在提问前或第一轮提问时，尽量查看：

- 构建：`pom.xml`、`build.gradle*`、`package.json`、`go.mod`、`Cargo.toml` 等
- 配置：`application*.yml`、`*.properties`、`docker-compose*.yml`、`.env*`、`vite.config.*`、`nuxt.config.*`
- 契约：`openapi.yaml`、`swagger.json`、`**/api/**/*.ts`（前端 api 层）
- 已有文档：根目录 `README.md`、`AGENTS.md`、`ARCHITECTURE.md`
- 源码顶层：`src/`、`app/`、主包名下的 `common/`、`core/` 等

扫描结果用于各批次「AI 建议」列，例如：

| 扫描线索 | 建议填入 |
|----------|----------|
| `vite.config` `server.proxy` | E5 |
| `VITE_` / `.env*` | F2 |
| `application-*.yml`、`spring.profiles` | F1/F3 |
| `eslint.config.*`、`husky` | H4 |
| `vitest`/`jest`、`cypress`/`playwright` | H1/H3 |
| `pinia`/`vuex`、`vue-router` `base` | G1/G2 |
| `element-plus`/`ant-design` | G3 |
| `.github/workflows` | I5 |

**排除**：`ai-kit/`、`.git/`、`node_modules/`、`target/`、`dist/`、`build/`、`.idea/`

扫描结论写入访谈中的「AI 建议」列，供用户确认或改正。
