# ai-kit 交互式接入（从这里开始）

> **给人类**：把整个 `ai-kit/` 复制到**新项目仓库根目录**后，在 Cursor 里 **@ 本文件**（或 @ `ai-kit` 文件夹），发送文末「一键话术」。  
> **给 AI**：严格按 [`prompts/INTERVIEW_PROTOCOL.md`](prompts/INTERVIEW_PROTOCOL.md) 执行。  
> **安全**：勿在简报中写入密钥，见 [`SECURITY.md`](SECURITY.md)。  
> **分仓**：见 [`docs/SPLIT_REPO_GUIDE.md`](docs/SPLIT_REPO_GUIDE.md)。

当前套件版本：[`VERSION`](VERSION)（变更见 [`CHANGELOG.md`](CHANGELOG.md)）。

---

## 复制后的目录关系

```text
your-project/                         ← PROJECT_ROOT
├── ai-kit/
│   ├── START_HERE.md
│   ├── SECURITY.md
│   ├── rules/          adapters/        ← Cursor 规则源 / 多工具说明
│   ├── templates/  prompts/  docs/
│   └── …
├── PROJECT_BRIEF.md                  ← 生成
├── AGENTS.md  PROGRESS.md  DETAIL.md  ARCHITECTURE.md
├── .cursor/rules/…                     ← 若选 Cursor
├── CLAUDE.md                           ← 若选 Claude Code
└── .trae/rules/…                       ← 若选 Trae
```

**禁止**把交付物写入 `ai-kit/` 内部。

---

## 三步流程

| 步骤 | 说明 |
|------|------|
| 1 读取 | [`MANIFEST.md`](MANIFEST.md) 必读列表 + 扫描 PROJECT_ROOT |
| 2 访谈 | **A1→A2→B→E→F→G?→H→C→I?→D**；可说「跳过可选」 |
| 3 生成 | 确认后按 [`OUTPUT_PATHS.md`](prompts/OUTPUT_PATHS.md)、[`PLACEHOLDER_MAP.md`](prompts/PLACEHOLDER_MAP.md)、[`MERGE_POLICY.md`](prompts/MERGE_POLICY.md) 写入项目根 |

**init 脚本**仅生成带 `{{占位符}}` 的骨架 + **Cursor** `.mdc`（不生成 `CLAUDE.md`/Trae 规则），**不能**代替访谈。

---

## 一键话术（复制到任意 AI IDE）

```
请 @ai-kit/START_HERE.md，严格按 ai-kit/prompts/INTERVIEW_PROTOCOL.md 执行，并遵守 ai-kit/SECURITY.md：

1. 读取 MANIFEST 与 adapters/README；
2. 扫描本项目根（ai-kit 的上一级），预填「AI 建议」；
3. 按 QUESTION_BANK 顺序 A1→A2→B→E→F→G→H→C→I→D 提问；每轮表格首列 # 从 1 编号，我可用「1: 答案」回复；A3 问 AI 工具（可多选）；
4. 汇总 PROJECT_BRIEF 草案，等我回复「确认」；
5. 在项目根生成通用五件套 + 按我选择的工具生成专属文件（见 adapters/：Cursor→.cursor/rules/、Claude→CLAUDE.md、Trae→.trae/rules/）。

不要修改 ai-kit/ 内源文件；已存在文件按 merge 策略处理。
```

---

## 其它入口

| 方式 | 说明 |
|------|------|
| 已手写简报 | @ [`prompts/GENERATE_FROM_BRIEF.md`](prompts/GENERATE_FROM_BRIEF.md) |
| 仅要骨架 | [`scripts/init-ai-docs.ps1`](scripts/init-ai-docs.ps1) `-UseProjectRoot` → 再跑本流程 |

更多说明：[`README_CN.md`](README_CN.md) · [`README_EN.md`](README_EN.md)
