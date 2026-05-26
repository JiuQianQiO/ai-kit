# 变更明细

> **规则**：**仅追加**在文件末尾，**禁止**修改或删除已有条目；纠错用新条「更正：…」。  
> **时区**：标题 `## YYYY-MM-DD HH:mm:ss` 为 **北京时间（UTC+8）**；有 commit 时与 `git log +0800` 一致。  
> **范围**：每一次实质代码/配置/资源变更一条。  
> **回溯**：优先 `git log` + 本文件按日期/关键词搜索，勿要求 AI 通读全文。  
> **对照**：`PROGRESS.md` 仅 commit/大变更里程碑；能力快照见 PROGRESS §1，目录见 `ARCHITECTURE.md`。

### 新条目模板

```markdown
## YYYY-MM-DD HH:mm:ss

- **commit**：`<hash>` 或 `—`
- **路径**：`...`
- **说明**：...
```

---

## {{INIT_DATETIME}}

- **commit**：`—`
- **路径**：`{{INIT_PATHS_LIST}}`
- **说明**：由 `ai-kit` {{AI_KIT_VERSION}} 接入 AI 项目规范（含 P0/P1 访谈生成或 init 骨架）。

---
