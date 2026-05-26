# Claude Code 适配

参考：[Claude Code Memory / CLAUDE.md](https://code.claude.com/docs/en/memory)

## 生成文件

| 路径                                                   | 源                                                           | 默认                         |
| ------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------- |
| `{PROJECT_ROOT}/CLAUDE.md`                             | `ai-kit/templates/CLAUDE.template.md` + 由 `AGENTS.md` 派生  | **是**                       |
| `{PROJECT_ROOT}/.claude/rules/progress-maintenance.md` | `ai-kit/rules/progress-auto-update.mdc` 正文（去 `alwaysApply`） | **是**（与 Cursor 规则同文） |

用户明确要求「仅 CLAUDE.md、不要 .claude/rules」时，在完成报告中注明并跳过 rules 目录。

## CLAUDE.md 写法

- **宜短**（建议 <200 行）：项目概述、常用命令、目录要点、维护摘要。  
- **指向完整文档**：`详见 AGENTS.md`、`PROGRESS.md` §1/§2、`ARCHITECTURE.md`。  
- **勿重复**整份 AGENTS；勿写密钥（见 `SECURITY.md`）。  
- 文首注明：`由 ai-kit 生成，套件版本 {{AI_KIT_VERSION}}`。

## .claude/rules

生成 `progress-maintenance.md` 时建议 frontmatter：

```markdown
---
paths:
  - "**/*"
---
```

正文从 `ai-kit/rules/progress-auto-update.mdc` 复制，**去掉** YAML 中 `alwaysApply`（Claude 不用该字段）。**勿**在 `ai-kit/` 内启用该规则。

## 合并

- 已有 `CLAUDE.md`：按 `meta.merge.claude`（未答则同 `merge.agents`）。  
- `合并-保留原概述`：保留原文至首个 `##` 项目概述段之后的内容，再拼接 ai-kit 维护段。  
- `CLAUDE.local.md`：不自动生成（个人本地偏好由用户自建）。

## 用户可选

- 运行 `/init` 仅作参考，**以 ai-kit 访谈结果为准**。  
- 团队共享：提交 `CLAUDE.md`；敏感项放 `CLAUDE.local.md` 并 gitignore。
