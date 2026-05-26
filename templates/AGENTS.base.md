# AGENTS.md

> 本文件为 AI 编程助手提供项目开发指引，请严格遵守以下规范。
>
> **项目**：{{PROJECT_NAME}} — {{ONE_LINE_PURPOSE}}
>
> **仓库**：{{REPO_LAYOUT_LABEL}}（当前仓：{{CURRENT_REPO_ROLE_LABEL}}）
>
> 每次会话开始必须加载 `PROGRESS.md`
>
> **每次实质变更**写 `DETAIL.md`（末尾、统一模板）；**commit / 大变更 / 能力变化**时按规则更新 `PROGRESS.md`（{{MAINTENANCE_RULES_REF}}）

{{AI_TOOLS_MAINTENANCE_SECTION}}

> 修改架构或目录结构时同步修改 `ARCHITECTURE.md`

## PROGRESS.md / DETAIL.md 维护（摘要）

| 时机 | 动作 |
|------|------|
| 会话开始 | 只读 `PROGRESS.md` §1、§2；结构查 `ARCHITECTURE.md` |
| 每次实质变更 | `DETAIL.md` 末尾追加（模板：commit / 路径 / 说明） |
| commit 或大变更 | `PROGRESS.md` §3 **一行**；勿与 commit 重复两行 |
| 能力增删或状态变化 | 同步 `PROGRESS.md` §1（不等 commit） |
| 会话结束 | 确认 `DETAIL.md` 已记全；若命中大变更标准则补 §3 |

**分工**：`DETAIL.md` = 每次变更；`PROGRESS.md` = 快照 + 里程碑。**细则**：{{MAINTENANCE_RULES_REF}}

## 项目概述

**技术栈**：{{TECH_STACK}}

**数据源 / 外部依赖**（`frontend` / `library` 或 `data_sources`=无 时删除本节及表格）：

| 名称 | 类型 | 用途 | 代码位置 |
|------|------|------|----------|
| {{DS_NAME}} | {{DS_TYPE}} | {{DS_PURPOSE}} | {{DS_CODE_PATH}} |

## 仓库与协作

{{REPO_COLLABORATION}}

## 本地联调

{{LOCAL_DEV}}

## 接口契约

{{API_CONTRACT}}

## 鉴权

{{AUTH}}

## 环境与配置

{{ENVIRONMENT}}

## 前端工程（无前端时删除本节）

{{FRONTEND_ENGINEERING}}

## 测试与代码质量

{{QUALITY}}

## 其它约定（无 P2 内容时删除本节）

{{OPTIONAL_NOTES}}

**核心约束**：

{{CORE_CONSTRAINTS_LIST}}

**目录结构**（摘要，细节见 `ARCHITECTURE.md`）：

{{DIRECTORY_STRUCTURE_LIST}}

**大变更判定**（本项目补充，未列则沿用维护规则默认）：

{{MAJOR_CHANGE_CRITERIA}}

---

## 常用命令

```bash
{{COMMON_COMMANDS}}
```
