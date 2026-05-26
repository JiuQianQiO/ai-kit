# {{PROJECT_NAME}} 架构总览

> 项目根目录索引文档。子模块/分层细节可在下文「文档索引」中追加链接。

## 文档索引

| 文档 | 路径 | 说明 |
|------|------|------|
| **开发进度** | [`PROGRESS.md`](PROGRESS.md) | 已交付能力快照与缺口 |
| **AI 指引** | [`AGENTS.md`](AGENTS.md) | 开发约束与常用命令 |
| **变更流水** | [`DETAIL.md`](DETAIL.md) | 逐次实质变更（仅追加） |

{{OPTIONAL_SUB_ARCHITECTURE_ROWS}}

## 一句话

{{ONE_LINE_PURPOSE}}

## 工程结构

```
{{PROJECT_ROOT_TREE}}
```

## 分层与约定

{{LAYERING_AND_CONVENTIONS}}

## 前后端协作

<!-- AI：repo_layout 为 split 或 monorepo 且存在 API 时保留；否则写「不适用」 -->

{{COLLABORATION_ARCHITECTURE}}

## 环境与工程化

{{ENV_QUALITY_ARCHITECTURE}}

## 维护约定

- 修改包结构、数据源、分层规则时，**同步更新**本文件及子级 `ARCHITECTURE.md`（若有）
- 功能交付记录写入 `PROGRESS.md`，不在架构文档中维护待办
