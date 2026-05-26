# ai-kit 变更记录

## 1.5.4（2026-05-26）

### 文档

- 拆分 `README.md` 为 [`README_CN.md`](README_CN.md) 与 [`README_EN.md`](README_EN.md)；根 `README.md` 为语言入口

## 1.5.3（2026-05-26）

### 清理

- 移除 `ai-kit/.cursor/` 目录（仅含废弃说明，无规则文件；Cursor 不加载该路径）
- 维护说明 Consolidate 至 `rules/README.md`

## 1.5.2（2026-05-26）

### 优化 · 访谈表格序号

- 向用户展示的每轮问题表增加 **`#` 列**（1、2、3… 连续编号）
- 支持 `1: 答案` 或 `A1: 答案` 两种回复方式
- `QUESTION_BANK` 各批次增加「参考 #」列；裁剪后由 AI 重排展示序号

## 1.5.1（2026-05-26）

### 修复（P0+P1 · 多工具一致性）

- `AGENTS`/`PROGRESS` 维护规则引用改为工具中立（`MAINTENANCE_RULES_REF`、`AI_TOOLS_MAINTENANCE_SECTION`）
- `GENERATE_FROM_BRIEF` 修正步骤编号；一键话术按 `ai_tools[]` 列出产物
- `PROJECT_TYPES` / `GENERATION_CHECKLIST` 明确按工具生成/跳过；`ai_tools` 空默认 `cursor`
- 访谈 A2 增加 `CLAUDE.md` merge（A4b）；`INTERVIEW_PROTOCOL` §1.3 改为 A2
- `DETAIL` 初始化路径改为 `INIT_PATHS_LIST`；`OUTPUT_PATHS` / `claude-code` 默认生成 `.claude/rules`
- init 脚本说明仅 Cursor 骨架；`rules/README` 单一正文源说明

## 1.5.0（2026-05-26）

### 新增 · 多 AI 工具适配

- `adapters/`：Cursor、Claude Code、Trae、generic
- 访谈 A3 可多选工具；生成 `CLAUDE.md`、`.trae/rules/progress-maintenance.md`
- `templates/CLAUDE.template.md`（短摘要，指向 AGENTS）
- Trae 用户提示：Rules & Skills / Include AGENTS.md

## 1.4.2（2026-05-26）

### 修复（P0+P1）

- 删除 `ai-kit/.cursor/rules/*.mdc`，规则源文件仅保留 `ai-kit/rules/`；复制到项目根时 `alwaysApply: true`
- 补全 `PROJECT_BRIEF.schema.md`（tech、api_contract、auth、progress 等，去除「同前」）
- 访谈批次拆为 **A1 / A2**（每轮 ≤8 题）
- 新增 `MERGE_POLICY.md`、`docs/SPLIT_REPO_GUIDE.md`
- `START_HERE` / 简报模板链到 `SECURITY.md`；修正模板中的版本示例
- `PLACEHOLDER_MAP` 补充 PROGRESS 多域行生成规则
- init 脚本复制规则时仅改 frontmatter 的 `alwaysApply: true`（不误改正文说明）

## 1.4.1

- P0：恢复 QUESTION_BANK 批次 E/C；`PLACEHOLDER_MAP`；monorepo 标签
- init 占位符警告横幅

## 1.4.0

- P1 环境 / 前端工程 / 测试 Lint；P2 可选批次 I

## 1.3.0

- P0 分仓、批次 E、协作四节

## 1.2.0

- `project_type` 裁剪数据源题

## 1.1.0

- 交互式 START_HERE、INTERVIEW_PROTOCOL

## 1.0.0

- 初始模板与 init 脚本
