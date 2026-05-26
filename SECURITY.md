# ai-kit 安全与隐私约定

## PROJECT_BRIEF.md

访谈生成的 `PROJECT_BRIEF.md` 位于**项目根**，可能包含：

- 环境变量**名**、配置文件路径  
- API 基址、鉴权 **Header 名称**（非密钥本身）  
- 内网地址、仓库路径  

### 禁止写入（AI 与人工均遵守）

- 密码、API Key、JWT Secret、私钥、连接串中的口令  
- 生产环境真实 Token 样本  

访谈中若用户提供密钥，AI 应：

1. 拒绝写入 `PROJECT_BRIEF.md` / `AGENTS.md`；  
2. 改为记录「使用环境变量 `XXX`，值不入库」；  
3. 建议用户轮换已泄露的密钥。

### 版本库建议

按需将简报排除出版本控制（团队统一即可）：

```gitignore
# 可选：含联调地址与内部路径的访谈简报
PROJECT_BRIEF.md
```

或提交删减版 `PROJECT_BRIEF.redacted.md`（去掉内网 IP、绝对路径）。

模板片段见 [`snippets/gitignore.project-brief.txt`](snippets/gitignore.project-brief.txt)。

## 生成文件

- `AGENTS.md` / `ARCHITECTURE.md`：只写**约定与路径**，不写密钥。  
- `DETAIL.md`：变更记录中**不要**粘贴 `.env` 内容或密钥。

## ai-kit 套件本身

- `ai-kit/` 可提交 Git；不含项目密钥。  
- 勿在 `ai-kit/` 内提交真实项目的 `PROJECT_BRIEF.md`。
