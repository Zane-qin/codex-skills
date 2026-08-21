---
name: pm-prd-doc
description: "按 FayeMax/Quokka 规范撰写或修改产品需求文档（PRD/执行类需求）：功能需求、新用户承接、模型接入等。含基础信息表、影响范围表、埋点独立章节、展示条件与兜底逻辑。触发词：PRD、需求文档、产品需求、功能说明、埋点方案、影响范围、需求评审材料。"
metadata:
  version: 1.0.0
  requires: []
---

# pm-prd-doc

## 前置强制步骤（文风）

**MUST**：在开始写作或修改前，读取并遵守：

1. [`../pm-writing-style-fayemax/SKILL.md`](../pm-writing-style-fayemax/SKILL.md)
2. [`../pm-writing-style-fayemax/references/part1-canonical.md`](../pm-writing-style-fayemax/references/part1-canonical.md)

适用场景：具体功能需求、新用户承接、模型接入等执行类文档（飞书文档「常规需求文档」口径）。

## 标准结构（须按此骨架组织）

```markdown
# 【产品线】功能名称

## 基础信息
| 时间 | 变更人 | 主要变更内容 |

## 需求影响范围
| 需求范围 | 海外 | 国内 | Web | App |
（用表格 + ✅/❌ 或同等明确符号）

## 需求背景
- 前置梳理（链接上游规划/数据文档）
- 方案概览（1-2 句话说明做什么）

## 需求详情
### 产品方案
（核心逻辑按 `pm-prd-product-solution` 写：功能/页面 | 需求详情 | 参考图）

**「需求详情」专项写法**（模型清单 + 可验收方案表）：见 [`../pm-prd-requirement-details/SKILL.md`](../pm-prd-requirement-details/SKILL.md)。
**「产品方案」专项写法**（Quokka/FayeMax PRD 的功能/页面 + 需求详情 + 参考图表）：见 [`../pm-prd-product-solution/SKILL.md`](../pm-prd-product-solution/SKILL.md)。

### 设计方案
（Figma 等设计稿链接）

### 埋点方案
| Platform | 事件名 | 属性 | 枚举值 | 备注 |
（标注每条为「新增 / 修改 / 沿用」）

## 运营后台（如有）
字段说明、兜底逻辑、权限与频控

## 参考链接
（文末固定收尾章节，必写：归档关联/上游 PRD、计费表/埋点全集等口径基线文档，格式 `> - [标题](飞书链接)`，blockquote + ul）
```

## 写作要点（与原文 Part 1.2.B 对齐）

- **基础信息表**与**需求影响范围表**为必选项，便于评审快速对齐。
- 逻辑写全：展示条件、触发频控、异常与兜底必须可执行、可测试。
- 埋点独立成节，且标明新增/修改，避免与产品方案混写。
- 交互与流程用线性描述：`上游路径 → 操作 → 下游逻辑`，避免跳跃。
- 文末固定 `## 参考链接`：撰写时实际依赖的关联/上游 PRD 与口径基线文档（计费表、埋点全集等）都要归档，即使用户未显式提供链接。

## 交付自检

- [ ] 背景段是否已链上游 + 一句话方案摘要
- [ ] 每条需求点是否可映射到验收标准或埋点
- [ ] 全文语气符合 `pm-writing-style-fayemax`（结论前置、术语直接、表格化并列）
- [ ] 文末是否有 `## 参考链接` 章节，归档关联/上游 PRD 与口径基线文档
