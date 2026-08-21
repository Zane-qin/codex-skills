---
name: pm-brainstorm-prd-lark
description: Quokka/FayeMax PM 日常完整工作流：头脑风暴 → PRD 定稿 → 飞书落地。在用户说「按我日常流程写需求」「brainstorm 完写 PRD」「PRD 同步飞书」「聊完需求出文档再改飞书」时使用。
license: MIT
---

# PM Workflow: Brainstorm → PRD → Feishu

把「头脑风暴 → PRD 定稿 → 飞书落地」串成可重复流水线。

## 三阶段流程

| 阶段 | 技能 | 产出 |
|------|------|------|
| ① 发散与收敛 | brainstorming | 一页纸需求概要 |
| ② 成文 | pm-writing-style-fayemax + pm-prd-doc + prd-writer | 可评审的 Markdown PRD |
| ③ 飞书 | lark-shared + lark-doc + feishu-formatter | 飞书文档同步 |

## 阶段 ①：聊需求

**目标**：在写长 PRD 前收窄问题空间

必须对齐的条目：
- 目标用户/场景、非目标（不做什么）
- 约束（平台、合规、时间、依赖方）
- 成功标准/验收口径（可测的一句话）
- 开放问题清单

**进入 ② 的前置条件**：用户确认「可以开始写 PRD」

## 阶段 ②：写 PRD

1. 先用 pm-writing-style-fayemax 规范文风
2. 用 pm-prd-doc 骨架组织章节
3. 涉及模型/参数时用 pm-prd-requirement-details
4. 涉及页面/交互时用 pm-prd-product-solution
5. 必要时用 prd-writer 补充模板和质检

**进入 ③ 的前置条件**：用户确认 PRD 定稿

## 阶段 ③：同步飞书

1. lark-shared 确保认证可用
2. lark-doc 执行 fetch 看现状，再 update 精准修改
3. 复杂排版配合 feishu-formatter
4. 完成后回报修改了哪些段落

## 扩展位

后续可追加：④ 数据复盘 → pm-data-review-doc + lark-doc/lark-sheets
