---
name: pm-workflow-brainstorm-prd-lark
description: "Quokka/FayeMax PM 日常：先用 brainstorming 与 AI 聊需求并收敛，再用 pm-* + prd-writer 产出 PRD，最后用 lark-doc 写入或修改飞书文档。在用户说「按我日常流程写需求」「brainstorm 完写 PRD」「PRD 同步飞书」「聊完需求出文档再改飞书」或连续执行聊需求→PRD→飞书时使用。"
metadata:
  version: 1.0.0
  requires:
    bins: ["lark-cli"]
---

# pm-workflow-brainstorm-prd-lark

本 skill 把「**头脑风暴 → PRD 定稿 → 飞书落地**」串成一条可重复的流水线；各阶段仍由对应专项 skill 承担细节，本文件只负责**顺序、交接标准与自检**。

## 参与技能（按阶段）

| 阶段 | 技能 | 说明 |
|------|------|------|
| ① 发散与收敛 | **brainstorming**（[obra/superpowers](https://skills.sh/obra/superpowers/brainstorming)） | 已安装时路径：`${AGENT_SKILLS_ROOT}/brainstorming/SKILL.md`；Hermes 仓库同步副本：`${AGENT_SKILLS_ROOT}/brainstorming/`。若不存在，用下方「无 brainstorming 时的替代」 |
| ② 成文 | **pm-writing-style-fayemax** + **pm-prd-doc**（主骨架） | 文风与章节结构；可与 **prd-writer** 叠加补模板/质检 |
| ③ 飞书 | **lark-shared**（认证）+ **lark-doc**（读/改） | 创建或 `docs +update`；复杂排版可再配合 **feishu-formatter** |

## 阶段 ①：与 AI 聊需求（Brainstorm）

**目标：** 在写任何长 PRD 之前，把问题空间收窄到「可写进文档的一页纸」。

**执行：**

1. 若磁盘上存在 `brainstorming/SKILL.md`：**必须先 Read 并严格按该 skill** 与用户对话。
2. 若不存在：与用户显式对齐至少以下条目（可用对话列表，不必成文）：
   - 目标用户 / 场景、**非目标**（不做什么）
   - 约束（平台、合规、时间、依赖方）
   - 成功标准 / 验收口径（可测的一句话）
   - 开放问题清单（留给 PRD 或评审）

**阶段完成标准（进入 ② 前必须满足）：**

- [ ] 用户口头或书面确认「可以开始写 PRD」或等价意思
- [ ] 没有未解决的**阻塞级**矛盾（例如目标与资源明显冲突）；若有，在 PRD「风险 / 待决」中单列

## 阶段 ②：用 Skill 写 PRD

**目标：** 产出可评审、可开发的 Markdown 或等价正文（用户本地 `*.md` 或聊天内全文）。

**执行顺序：**

1. Read **`pm-writing-style-fayemax`** 与 **`references/part1-canonical.md`**（文风）。
2. Read **`pm-prd-doc`**，按其中标准结构起草；需要长模板或质检清单时，再 Read **`prd-writer`**。
3. 全文自检：`pm-prd-doc` 文末清单 + 文风（结论前置、影响范围表、埋点节、兜底与频控）。

**阶段完成标准（进入 ③ 前必须满足）：**

- [ ] 含「基础信息 / 影响范围 / 背景 / 需求详情」等 `pm-prd-doc` 要求块
- [ ] 用户确认一版「可作为飞书真源」或「以此版同步飞书」

## 阶段 ③：用 Lark 改飞书 PRD

**目标：** 把已定稿内容与飞书 docx 对齐（新建或增量修改）。

**执行：**

1. Read **`lark-shared/SKILL.md`**，确保认证与 scope 可用。
2. 按 **`lark-doc`** 要求 Read `lark-doc-fetch.md` / `lark-doc-xml.md`（或更新 workflow）再执行 `lark-cli`。
3. 用户提供 **文档 URL 或 token**；优先 **`docs +fetch`** 看现状，再 **`docs +update`**（`str_replace` / `block_insert_after` 等）或整段 `append`/`overwrite`（仅当用户明确要求整篇替换时）。

**阶段完成标准：**

- [ ] 飞书侧关键块（标题、范围表、核心方案）与本地定稿一致
- [ ] 向用户回报：修改了哪些大段、是否需对方在飞书里人工过一遍样式

## 与「其他日常工作」的扩展位

后续若你补充更多日常（例如：数据复盘、立项、会议纪要），在本 skill 末尾**追加一节**即可，例如：

- `④ 数据复盘` → `pm-data-review-doc` + `lark-doc` / `lark-sheets`
- 保持 **①②③** 为默认主线，新阶段用「触发词 + 前置完成标准」描述，避免和主线混淆。

## 无 brainstorming skill 时的替代

用 10～15 轮以内对话完成：**背景 → 痛点 → 方案方向（2～3 个）→ 推荐方案 + 理由 → 风险与待决 → 用户确认进入 PRD**。仍须在进入阶段 ② 前拿到用户明确确认。

## 可选：补装 brainstorming

官方页：[skills.sh/obra/superpowers/brainstorming](https://skills.sh/obra/superpowers/brainstorming)。安装命令（与官方一致）：

```bash
npx skills add https://github.com/obra/superpowers --skill brainstorming -g -y
```

安装后应出现 `${AGENT_SKILLS_ROOT}/brainstorming/SKILL.md`，阶段 ① 即可改为强制 Read。Hermes 源码树中的同步副本：`${AGENT_SKILLS_ROOT}/brainstorming/`（与 `npx skills` 安装同源；上游 `obra/superpowers` 更新后请对该目录重新 rsync 或重装本 skill）。
