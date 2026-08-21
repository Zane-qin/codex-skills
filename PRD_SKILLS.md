# PRD Skill 套件

仓库包含 8 个本地 PRD 相关 Skill。它们不是简单重复，而是按“通用写作—团队规范—专项章节—工作流编排”分层。

## 能力分层

| 层级 | Skill | 用途 |
|---|---|---|
| 通用写作 | [`prd-writing`](skills/prd-writing/) | 完整 PRD 写作规范，尤其覆盖 Skill 类产品需求与多模态 good case 交付 |
| 通用写作 | [`prd-writer`](skills/prd-writer/) | 中文 PRD 主写作器，提供本地优先 SOP、标准骨架、表格与飞书交付约束 |
| 团队规范 | [`pm-writing-style-fayemax`](skills/pm-writing-style-fayemax/) | FayeMax/Quokka 文风和排版基线：结论前置、假设显性化、并列信息表格化 |
| 全文骨架 | [`pm-prd-doc`](skills/pm-prd-doc/) | FayeMax/Quokka PRD 总体结构、影响范围、埋点、兜底和交付自检 |
| 专项章节 | [`pm-prd-product-solution`](skills/pm-prd-product-solution/) | 生成可评审的“产品方案”章节，覆盖交互、入口、生成流程、会员拦截和兼容逻辑 |
| 专项章节 | [`pm-prd-requirement-details`](skills/pm-prd-requirement-details/) | 将“需求详情”整理为范围、冻结事实与可验收规则 |
| 流程编排 | [`pm-brainstorm-prd-lark`](skills/pm-brainstorm-prd-lark/) | 精简的“头脑风暴 → PRD 定稿 → 飞书落地”三阶段流程 |
| 流程编排 | [`pm-workflow-brainstorm-prd-lark`](skills/pm-workflow-brainstorm-prd-lark/) | 依赖感知的完整编排版，串联 brainstorming、PM Skill、prd-writer 与 lark-doc |

## 推荐调用关系

```text
需求发散与收敛
  └─ pm-workflow-brainstorm-prd-lark
       ├─ pm-writing-style-fayemax
       ├─ pm-prd-doc
       ├─ prd-writer / prd-writing
       ├─ pm-prd-product-solution（按需）
       ├─ pm-prd-requirement-details（按需）
       └─ lark-doc / feishu-formatter（目标环境已安装时）
```

## 选择建议

- 从零完成一篇团队 PRD：`pm-workflow-brainstorm-prd-lark`。
- 只写或重构全文：`pm-prd-doc` + `pm-writing-style-fayemax` + `prd-writer`。
- 只补产品方案：`pm-prd-product-solution`。
- 需求详情太散、无法验收：`pm-prd-requirement-details`。
- 编写 Skill 类产品需求：优先 `prd-writing`。
- 需要更短的三阶段引导：`pm-brainstorm-prd-lark`。

## 可移植性说明

公开版本已将本机绝对路径和内部飞书文档地址替换为占位符：

- `${PM_WORKSPACE_ROOT}`：PM / Quokka 项目工作区。
- `${AGENT_SKILLS_ROOT}`：共享 Agent Skill 根目录。
- `${CODEX_SKILLS_ROOT}`：Codex 用户 Skill 根目录。
- `<FEISHU_DOC_URL>`：由使用者提供的飞书文档地址。

涉及飞书同步的能力依赖目标环境已安装并授权 `lark-doc`、`feishu-formatter` 等相关 Skill；未安装时仍可完成本地 Markdown PRD。
