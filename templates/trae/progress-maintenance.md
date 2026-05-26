---
description: 每次变更写 DETAIL.md；满足条件时更新 PROGRESS.md
alwaysApply: true
---

# PROGRESS.md / DETAIL.md 自动维护（Trae 项目规则）

> **权威细则**：与项目根 `.cursor/rules/progress-auto-update.mdc` 及 `AGENTS.md` 摘要一致。  
> **部署**：本文件位于 `.trae/rules/`，由 ai-kit 生成。

## 会话开始

- **只读** `PROGRESS.md` §1、§2（勿通读 `DETAIL.md`）。
- 查具体改动：在 `DETAIL.md` 内按日期/关键词检索，或 `git log`。
- 目录以 `ARCHITECTURE.md` 为准；能力现状以 `PROGRESS.md` §1 为准。

## 每次实质变更后（必须写 DETAIL）

范围：业务源码、配置、项目文档（见 `ARCHITECTURE.md`）。

在 `DETAIL.md` **末尾**追加一条，**禁止**修改或删除已有条目。标题时刻为 **北京时间（UTC+8）**。

```markdown
## YYYY-MM-DD HH:mm:ss

- **commit**：`<hash>` 或 `—`
- **路径**：`...`
- **说明**：...
```

## 何时更新 PROGRESS.md

- **§3**：每 commit 或大变更**一行**（文首追加）。  
- **§1**：能力增删或状态变化时必更。  
- **§2**：缺口已实现则删行，新缺口则追加。

## 禁止

- 待办不得写入 `PROGRESS.md` / `DETAIL.md`。  
- 不得改删 `DETAIL.md` 历史。  
- 不得通读 `DETAIL.md` 作为默认步骤。
