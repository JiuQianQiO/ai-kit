# 文件合并策略（生成阶段执行）

> 访谈批次 **A2** 收集 `meta.merge.*`；生成前必须向用户确认（见 INTERVIEW_PROTOCOL 阶段 2）。

## AGENTS.md（`meta.merge.agents`）

| 策略 | 行为 |
|------|------|
| `新建` | 不存在则创建；存在且 `merge.default=覆盖` 则整文件替换 |
| `合并-保留原概述` | 保留原文中 **「项目概述」至下一级 `##` 标题之前** 的正文；用模板替换「PROGRESS/DETAIL 维护」及之后各节；P0～P1 新节从 PROJECT_BRIEF 写入 |
| `跳过` | 不修改已有 `AGENTS.md`；若缺维护段，在完成报告中警告用户手工补 |

## PROGRESS.md（`merge.default` + 访谈）

| 策略 | 行为 |
|------|------|
| `新建` / `仅缺失` | 不存在则按模板生成；存在则跳过 |
| `覆盖` | 整文件替换 |
| 用户曾选「合并-仅补 §1」 | **只改** §1 与文首日期；§2/§3 保留 |

## DETAIL.md / ARCHITECTURE.md / PROJECT_BRIEF.md

| 文件 | 默认（`merge.default`） |
|------|-------------------------|
| `DETAIL.md` | `仅缺失` 则新建；已存在则**仅在末尾追加**初始化条（若本次接入），不改历史 |
| `ARCHITECTURE.md` | `仅缺失` 或 `覆盖` 按用户选择；合并时不删已有「文档索引」行，可追加行 |
| `PROJECT_BRIEF.md` | 本次访谈则**覆盖**为完整新版（简报为机器可读真相源） |

## CLAUDE.md（`meta.merge.claude` 或同 `merge.agents`）

| 策略 | 行为 |
|------|------|
| `新建` / `覆盖` | 按 `CLAUDE.template.md` 生成 |
| `合并-保留原概述` | 保留原 `CLAUDE.md` 概述段，拼接 ai-kit 维护摘要与命令 |
| `跳过` | 不修改已有 `CLAUDE.md` |

## `.cursor/rules/progress-auto-update.mdc`

- 从 `ai-kit/rules/progress-auto-update.mdc` 复制到项目根。  
- 复制后 frontmatter **必须**为 `alwaysApply: true`（源文件为 `false`）。  
- 已存在且用户选 `仅缺失`：跳过。

## 完成报告

对每个文件标注：`新建` / `覆盖` / `合并` / `跳过`。
