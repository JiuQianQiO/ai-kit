# 项目简报（填写后供 AI 生成规范文档）

> 保存为 **项目根** `PROJECT_BRIEF.md`（与 `ai-kit/` 同级），填齐 `【】`。  
> **安全**：禁止写入密码、API Key、Token；见 [`../SECURITY.md`](../SECURITY.md)。  
> 推荐：@ `ai-kit/START_HERE.md` 由 AI 访谈生成。  
> 已填齐：@ `ai-kit/prompts/GENERATE_FROM_BRIEF.md`。  
> 字段结构：[`PROJECT_BRIEF.schema.md`](PROJECT_BRIEF.schema.md)。

---

## 元信息

| 项 | 填写 |
|----|------|
| 目标项目根路径（通常为 ai-kit 的上一级） | 【例：D:/work/my-app】 |
| 项目类型 | 【纯前端 / 后端 / 全栈 / 数据迁移 / 库或SDK / 其它】 |
| 仓库协作形态 | 【前后端分仓 / 全栈单仓 / 仅本仓】 |
| 当前是哪个仓（分仓时） | 【前端仓 / 后端仓】 |
| 另一仓库 | 【名称 + 路径如 `../xxx-api` 或 Git URL】 |
| 项目名称 | 【例：MyApp】 |
| 一句话目标 | 【例：将旧系统订单同步到新 ERP】 |
| 是否已存在 AGENTS.md | 【无 / 有-合并维护段 / 有-跳过】 |
| 是否已存在 CLAUDE.md（选 Claude Code 时） | 【无 / 有-合并 / 有-跳过】 |
| 初始化策略 | 【覆盖 / 仅缺失文件 / 跳过已存在】 |
| 使用的 AI（可多选） | 【Cursor / Claude Code / Trae / 其它】 |
| 主用 AI | 【与团队日常主 IDE 一致的一项】 |
| Trae：Include AGENTS.md | 【是 / 否 / 待定】（仅选 Trae 时） |
| ai-kit 版本（可选，默认读 ai-kit/VERSION） | 【1.5.1】 |

---

## 技术栈

- 语言与运行时：【例：Java 17】
- 框架：【例：Spring Boot 2.7 + MyBatis-Plus】
- 构建工具：【例：Maven】
- 测试：【例：JUnit 5】

---

## 数据源与集成

> **纯前端 / 库或 SDK**：本节写「无」，不必填表。  
> **后端 / 全栈 / 数据迁移**：按下表填写。

| 名称 | 类型 | 用途 | Mapper/访问层路径 |
|------|------|------|-------------------|
| 【master】 | 【达梦 DM8】 | 【主库】 | 【com.example.app.mapper】 |

**跨源/集成约束**（编号列表；纯前端可写「无」）：

1. 【例：Mapper 必须使用 @DS 声明数据源】
2. 【】

---

## P0 · 前后端协作（分仓或全栈单仓必填）

### 本地联调

| 进程 | 启动命令 | 端口 |
|------|----------|------|
| 【前端 dev】 | 【pnpm dev】 | 【5173】 |
| 【后端 API】 | 【mvn spring-boot:run】 | 【8080】 |

补充说明：【须先起后端 / 无】

### 前端访问后端

- 方式：【vite proxy / 环境变量 / 直连】
- 细节：【例：`/api` → `http://localhost:8080` 或 `VITE_API_BASE_URL`】

### 接口契约

- 位置：【例：后端仓 `docs/openapi.yaml` 或本仓 `src/api/swagger.json`】
- 风格：【OpenAPI / 仅 Controller / 共享 npm 包】
- 响应示例：【例：`{"code":0,"data":{},"message":""}` 或 无统一封装】
- 错误约定：【例：code≠0 为业务错误】

### 鉴权

- 机制：【JWT / Session / 无】
- Header：【Authorization: Bearer …】
- 前端存 Token：【localStorage / Cookie / 不适用】
- 登录入口：【`POST /api/auth/login` / 无】

### 跨域

【后端 CORS / 仅 dev 用 proxy / 网关】

### 契约主仓（分仓必填 E10）

【OpenAPI 以当前仓 / 另一仓 ../xxx-api 为准 / 各仓各写一份】

---

## P1 · 环境与配置

| 环境名 | 配置文件 |
|--------|----------|
| 【dev】 | 【application-dev.yml / .env.development】 |

- 前端 env 前缀：【VITE_ / n/a】
- 前端 env 文件：【.env.development, .env.production】
- 后端 profile：【dev,prod / n/a】
- 配置中心说明：【无 / Nacos】
- 禁止 AI 修改：【.env.local, secrets/ / 无】

---

## P1 · 前端工程（无前端整节删）

- 路由：【history + base `/`】
- 状态管理：【Pinia / 无】
- UI 库：【Element Plus】
- 样式：【Tailwind / scoped】

---

## P1 · 测试与代码质量

| 类型 | 目录 | 命令 |
|------|------|------|
| 单测 | 【src/__tests__】 | 【pnpm test:unit】 |
| 集成 | 【可选】 | 【】 |
| E2E | 【cypress/】 | 【pnpm test:e2e】 |
| Lint | 【ESLint+Prettier】 | 【pnpm lint】 |

- pre-commit：【husky+lint-staged / 无】

---

## P2 · 可选（不需要可整节删）

- i18n：【locales/ + vue-i18n / 无】
- SSR：【Nuxt 3 / 无】
- WebSocket：【无】
- Redis/MQ/多租户：【无】
- CI：【.github/workflows/ci.yml】
- 领域名词：【个案=case, …】
- 日志/Trace：【logback + MDC traceId / 无】

---

## 目录结构

根包/主目录：【例：com.example.app】

启动类或入口：【例：com.example.app.Application】

分层说明（编号列表）：

1. 【例：common/ 工具与配置】
2. 【例：core/ 业务代码】
3. 【】

**工程目录树**（粘贴 `tree` 或手写，3 层内即可）：

```
【
my-app/
├── src/
└── pom.xml
】
```

---

## 当前交付快照（写入 PROGRESS §1）

**业务目标**：【与一句话目标可展开】

| 域 | 位置 | 状态 |
|----|------|------|
| 【启动/配置】 | 【路径】 | 【已齐/进行中/占位】 |
| 【】 | 【】 | 【】 |

补充说明（可选）：【】

---

## 已知缺口（写入 PROGRESS §2）

| 项 | 位置 |
|----|------|
| 【例：XXService 未实现】 | 【类名或路径】 |

---

## 里程碑种子（写入 PROGRESS §3，可只留初始化一行）

| 时间 | 摘要 |
|------|------|
| 【YYYY-MM-DD】 | 【工程初始化 / 从 ai-kit 接入规范】 |

---

## 大变更判定（写入 AGENTS，补充 .mdc 默认）

1. 【例：新增一整张业务表对应的 Entity+Mapper 算大变更】
2. 【】

---

## 常用命令（写入 AGENTS，每行一条，AI 会包进 bash 代码块）

```
【
mvn spring-boot:run -Dspring-boot.run.profiles=dev
mvn test
】
```

---

## 子架构文档（可选，写入 ARCHITECTURE 文档索引表）

| 文档标题 | 相对路径 | 说明 |
|----------|----------|------|
| 【Common】 | 【docs/arch/common.md】 | 【】 |

---

## 分层与命名约定（写入 ARCHITECTURE）

【自由叙述：命名规范、禁止事项、日志/异常约定等】

---

## 其他说明（可选）

【团队习惯、分支策略、禁止使用的工具等】
