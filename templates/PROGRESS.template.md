# {{PROJECT_NAME}} 开发进度

> **最后更新**：{{LAST_UPDATED}}  
> **用途**：能力快照 + 缺口 + **提交/大变更**里程碑（会话入口，宜短）。  
> **维护**：每次实质变更 → `DETAIL.md` 末尾；§3/§1/§2 条件见 {{MAINTENANCE_RULES_REF}}  
> **回溯**：逐次改动搜 `DETAIL.md` 或 `git log`；目录结构见 `ARCHITECTURE.md`

---

## 1. 交付快照（会话开始只读本节 + §2）

**目标**：{{PROJECT_GOAL}}

| 域 | 位置/包路径 | 状态 |
|----|-------------|------|
| {{DOMAIN_1_NAME}} | {{DOMAIN_1_PATH}} | {{DOMAIN_1_STATUS}} |
| {{DOMAIN_2_NAME}} | {{DOMAIN_2_PATH}} | {{DOMAIN_2_STATUS}} |
| {{DOMAIN_3_NAME}} | {{DOMAIN_3_PATH}} | {{DOMAIN_3_STATUS}} |
| {{DOMAIN_4_NAME}} | {{DOMAIN_4_PATH}} | {{DOMAIN_4_STATUS}} |
| {{DOMAIN_5_NAME}} | {{DOMAIN_5_PATH}} | {{DOMAIN_5_STATUS}} |
| {{DOMAIN_6_NAME}} | {{DOMAIN_6_PATH}} | {{DOMAIN_6_STATUS}} |

（生成时按 `progress.domains` **3～6 行**保留，多余行删除，不足则删空行；见 PLACEHOLDER_MAP。）

{{OPTIONAL_DETAIL_PARAGRAPH}}

---

## 2. 已知缺口

| 项 | 位置 |
|----|------|
| {{GAP_1}} | {{GAP_1_LOCATION}} |

---

## 3. 里程碑（一行 = 一次 commit 或一次大变更；细则见维护规则）

| 时间 | 摘要 |
|------|------|
| {{LAST_UPDATED}} | 初始化 AI 项目规范（`ai-kit` {{AI_KIT_VERSION}}） |
