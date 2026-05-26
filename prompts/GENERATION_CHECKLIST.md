# 生成后检查清单（AI 在阶段 3 / GENERATE 末尾逐项自检）

> 与 [`INTERVIEW_PROTOCOL.md`](INTERVIEW_PROTOCOL.md) 阶段 3、「质量检查」配合使用。  
> 占位符细则：[`PLACEHOLDER_MAP.md`](PLACEHOLDER_MAP.md)

## 路径与套件

- [ ] 所有交付物在 **PROJECT_ROOT**（`ai-kit` 的上一级），未写入 `ai-kit/`
- [ ] 未修改 `ai-kit/templates`、`ai-kit/rules` 源文件
- [ ] `PROJECT_BRIEF.md` 已生成/更新（若本次为访谈接入）
- [ ] `meta.ai_tools[]` 已记录；空数组已按 `["cursor"]` 处理

## 占位符与格式

- [ ] 无残留 `{{…}}`
- [ ] 无 `<!-- AI：` HTML 注释
- [ ] `{{REPO_LAYOUT_LABEL}}` / `{{CURRENT_REPO_ROLE_LABEL}}` 符合 PLACEHOLDER_MAP（`monorepo` → 全栈单仓）
- [ ] `{{AI_TOOLS_MAINTENANCE_SECTION}}`、`{{MAINTENANCE_RULES_REF}}` 已填且与 `ai_tools` 一致
- [ ] `{{INIT_PATHS_LIST}}` 与本次实际生成的文件一致

## AGENTS.md

- [ ] 含「AI 工具与维护规则」表，且**仅**列出已选工具
- [ ] 文首/维护摘要**未**引用未启用的 `.cursor/rules` 等路径
- [ ] `frontend` / `library`：已删「数据源」节
- [ ] `split` 或存在 API：P0 四节标题在，内容或「不适用」说明完整
- [ ] 无前端：已删「前端工程」节
- [ ] 无 P2：已删「其它约定」节
- [ ] `常用命令` 含 dev/build/test/lint（与简报去重）
- [ ] 无真实密码/Token/密钥（见 [`SECURITY.md`](../SECURITY.md)）

## AI 工具专属（按 `meta.ai_tools`）

- [ ] `cursor`：项目根 `.cursor/rules/progress-auto-update.mdc` 且 `alwaysApply: true`
- [ ] `claude-code`：`CLAUDE.md` 简短，指向 `AGENTS.md`；`.claude/rules/progress-maintenance.md` 已生成；无密钥
- [ ] `trae`：`.trae/rules/progress-maintenance.md` 存在；报告中提示 Trae「Include AGENTS.md」设置
- [ ] **未选**工具：对应路径**未新建**；AGENTS/PROGRESS 未误导引用

## PROGRESS / DETAIL / ARCHITECTURE

- [ ] `PROGRESS.md` §1 ≤8 行；无全表实体清单；维护引用为 `MAINTENANCE_RULES_REF` 而非写死 `.mdc` 路径（除非仅 cursor）
- [ ] `DETAIL` 新建时有一条初始化记录（路径含 `INIT_PATHS_LIST`）
- [ ] `ARCHITECTURE` 含「前后端协作」「环境与工程化」（或标不适用）

## 合并策略

- [ ] 已按用户 `merge` 选择：跳过/覆盖/合并（含 `merge.claude` 当适用）
- [ ] 完成报告中列出各文件操作

## 报告

- [ ] 已输出完成报告表（文件路径 + 新建/覆盖/跳过）
- [ ] 已注明 `ai-kit` 版本号（读 `VERSION`）与 `ai_tools` 列表
