---
name: prd-writer
description: PRD 撰写助手，遵循标准 SOP 流程。用于撰写产品需求文档、功能需求、需求详情时触发。专注于 PRD 结构框架和内容规范，格式转换由 feishu-formatter skill 处理。
---

# PRD Writer

按照标准流程撰写产品需求文档 (PRD)。

## 流程概览（本地优先）

1. **历史文档参考** → 按优先级学习历史风格（见下方参考优先级）
2. **复习 SOP 规范** → 重温本 skill 的撰写风格和格式要求
3. **本地撰写/修改** → 在本地 Markdown 文件中完成 PRD，格式严格遵循本 skill 规范
4. **用户确认** → 用户审阅本地 PRD 内容，确认无误
5. **发布至飞书** → 使用 `lark-cli` 和 lark skill 发布到飞书文档
   - 飞书格式遵循 **[feishu-formatter](../feishu-formatter/SKILL.md)** 规范
   - 发布前整体做一遍缩进 review，确保全部使用空格（无 tab）
   - **仅使用 lark-cli 和 lark skill，忽略所有 MCP 工具**

> **重要**: 本地文件是 PRD 的 source of truth，飞书是发布渠道

### 历史文档参考优先级

撰写前参考已有文档，按以下优先级：

1. **ground-truth 文档**（`content/ground-truth/`）— 最高优先级，产品基准信息
2. **相关 PRD 中 lastModified 较近的版本** — 反映最新决策
3. **相关 PRD 中较早的版本** — 仅在必要时参考

### 参考链接归档

撰写过程中收到的参考链接，必须在对应 section 开头用引用块归档：

```markdown
## 需求详情

> - [fal.ai Extend Video](https://fal.ai/models/xai/grok-imagine-video/extend-video)
> - [xAI Video Generation Guide](https://docs.x.ai/docs/guides/video-generation)
```

### 文末「参考链接」章节（固定收尾，必写）

每篇 PRD 文末固定以 `## 参考链接` 收尾，归档本期实际依赖的上游/关联文档，**即使撰写过程中用户没有显式给链接也要写**——撰写时读过哪些历史 PRD / ground-truth / 埋点全集，就把它们的飞书链接归档进来。这是 Quokka 历史 PRD 的固定惯例（如 20260518、20260520、20260227 文末均有）。

收录范围（按相关性排，通常 2-5 条）：

1. 关联/上游 PRD（定义了本期沿用逻辑的版本）
2. 计费表 / 埋点全集等 ground-truth 飞书文档（本期口径基线）
3. 外部 API / 调研文档（如有）

格式同参考链接归档规则，blockquote + ul：

```markdown
## 参考链接

> - [【Quokka】陪伴创作Agent一期](<FEISHU_DOC_URL>)
> - [【Quokka】支持模型参数&计费表](<FEISHU_DOC_URL>)
```

### 接口参考章节格式

`## 接口参考` 是独立的章节（非需求详情内的说明），用 **blockquote 包裹无序列表**，发布至飞书后渲染为带左灰边的引用块，与正文需求形成视觉区分：

```markdown
## 接口参考

> - [产品介绍](https://docs.example.com/intro)
> - [商品创建](https://docs.example.com/product.create) · [商品修改](https://docs.example.com/product.modify)
> - [订阅创建](https://docs.example.com/subscription.create) · [订阅查询](https://docs.example.com/subscription.query)
```

**禁止**：

```markdown
<!-- ❌ 错误：纯文本连续 blockquote 没有 bullet，在飞书中折叠为一行 -->
> [产品介绍](url1)
> [商品创建](url2)
> [订阅创建](url3)

<!-- ❌ 错误：裸 ul 没有外层 blockquote，发布飞书会丢失引用块视觉 -->
- [产品介绍](url1)
- [商品创建](url2)
```

正确的关键：每行 `>` 后必须紧跟 `- `（blockquote 内嵌 ul），飞书会把它识别为 `<blockquote><ul><li>...</li></ul></blockquote>` 单一引用块。同类型接口可用 ` · ` 连接在同一行，不同类型（商品、价格、订阅）各占一行。

参考链接归档（见上文）也使用同样的 blockquote+ul 模式，规则一致。

### 待确认问题标注

每个 section 中需要用户确认的问题，在该 section 开头用 `[!warning]` callout 标注：

```markdown
## 需求详情

> [!warning] 待确认问题
> 1. Extend 模式是否需要独立的分辨率参数？
> 2. 参考图计费是每张还是总共？
```

### 飞书格式转换规则维护

在对话过程中如发现新的、值得记录的本地 ↔ 飞书格式转换规则，应向用户确认是否需要补充到 **[feishu-formatter](../feishu-formatter/SKILL.md)** 中

---

## 最高优先级：内容收敛原则

**绝对禁止自主扩展未提及内容**

### 核心禁令

1. **禁止添加未提及的模块** - 需求方没有明确要求的章节，**一律不写**
2. **按需组合原则** - 从以下模块中根据需求方实际要求选择（无固定必选项）：
   - `## 背景` — 几乎必有
   - `## 设计稿链接` — 有设计稿时添加，无则不加
   - `## 技术选型` — 涉及技术决策时添加
   - `## 需求详情` — 核心章节，几乎必有
   - `## [API/技术] 接口参考` — 涉及外部 API 接入时添加
   - `## 会员权益变更` — 涉及会员体系时添加
   - `## Reference` — 需要附加技术参考资料时添加
   - `## 参考链接` — **文末固定收尾章节，必写**（归档关联/上游 PRD 与口径基线文档，见「文末『参考链接』章节」规则）
3. **禁止清单** - 以下章节非必要不出现：
   - ❌ 埋点需求 / 数据追踪
   - ❌ 上线计划 / 项目排期
   - ❌ 风险评估 / 风险分析
   - ❌ 目标用户 / 用户画像
   - ❌ 竞品分析
   - ❌ 成功指标 / 效果验证
   - ❌ 技术方案细节（除非有独立的技术选型章节）
   - ❌ 运营策略
   - ❌ 附录 / 术语表

> **违反后果**: 添加未提及模块会导致 PRD 冗余、重点分散，必须删除后重写。

### 产品特定的废弃维度

- **PixVerse Mini-App PRD 不写「分类归属」**：入口位置只写「Mini-Apps 列表页」，不要再写「分类归属：Audio & Finishing」之类信息。Mini-Apps 列表页的分类体系已废弃，未来不再存在分类维度；继续写「分类归属 TBD」会留下过时假设让设计/开发误以为还要决策。读旧 PRD 改写时也顺手把分类信息删掉。

---

## 禁止清单（统一收口）

完成 PRD 后做一次 grep 式自检，以下任何一条出现就必须修正。**这一节是「写完先看一眼」用的，不要分散查阅各 section**：

### 结构 & 标题

- ❌ Markdown 正文出现 H1（飞书 H1 在文档标题块，正文从 H2 起）
- ❌ H2 带序号（H2 不编号）
- ❌ H3+ 没序号（必须 `### 1. xxx` / `#### 1.1 xxx`）
- ❌ H2 章节之间缺少 `---` 水平线

### 表格 & 单元格

- ❌ 表格内 `![[name.png|200]]` 未转义为 `![[name.png\|200]]`（`|` 必须 `\|`，否则被 Markdown 当列分隔符切碎）
- ❌ 「功能/页面」列单元格写 `2.1` / `5.3` 章节序号前缀（编号只在 H3+ 章节标题里）
- ❌ 表格内小标题后直接接纯文本段落、裸 blockquote / code / callout（默认写 `**小标题**<br>• ...`，富格式块作为 bullet 子项）
- ❌ 单元格整格只堆纯文本段落（必须至少有一组 `**小标题** + bullet` 或 bullet，极简一句话事实可例外但仍建议 bullet）
- ❌ 数据字段逐字段拆行（字段名一行、类型一行、取值一行）→ 应归纳为业务概念在同一单元格

### 内容收敛

- ❌ Mini-App PRD 出现「分类归属：xxx」（分类体系已废弃）
- ❌ 出现未被需求方提到的章节：埋点 / 数据追踪 / 上线计划 / 排期 / 风险评估 / 目标用户 / 用户画像 / 竞品分析 / 成功指标 / 运营策略 / 附录
- ❌ 描述字号 / 颜色 / 间距 / 组件风格等视觉细节（设计稿是唯一来源）

### 格式规范

- ❌ 列表项末尾带句号
- ❌ 全文出现 tab 缩进（必须空格）
- ❌ 参考链接归档 / 接口参考用裸 `- [...]` 或纯文本连续 `>`（必须 `> - [text](url)`，blockquote + ul）
- ❌ Front matter 出现中文 tag、自创 status 取值、PRD 已发布但缺 `feishu` 字段

---

## 核心原则

- **渐进式丰富**: 按需求方要求逐步丰富，避免过度详细
- **内容收敛**: 不增加未提及的模块，严格按需求范围输出
- **格式规范**: 列表项末尾不用句号；使用 `→` 代替连接词
- **不写样式细节**: PRD 不描述字号、颜色、组件风格等视觉样式，设计稿是样式的唯一来源
- **合并关联子模块**: 逻辑紧密相关的子模块（如 UI 规格 + 适用页面）不拆成多个 H3 + 多个表格，应合并为同一表格同一行，默认用 `**小标题**<br>• ...` 在单元格内分隔
- **字段按业务语义收敛**: 数据字段描述不逐字段拆行（字段名一行、类型一行、取值一行），应归纳为一个业务概念（如「用户属性上报」）在同一单元格内组织
- **表格单元格默认结构化**: 「需求详情」等单元格默认采用 `**小标题**<br>• ...` + bullet points 组织内容，优先保证 Obsidian 表格预览像云文档；只有确实需要语义层级时才用 `##### 小标题`。可以混用 code block / blockquote / callout 等富格式块。**禁止整格直接堆纯文本段落**，单元格内必须至少有一个加粗分组标题或一组 bullet。极简内容（一句话事实）可例外，但仍优先用 bullet 收敛
- **小标题之后必跟 bullet**: `**小标题**<br>` 或 `##### 小标题` 下一行**不允许**直接接纯文本段落，表格 cell 内必须以 `• ` bullet 开头；即便只有一条内容也写成单条 bullet。富格式块（code / blockquote / callout）也应作为 bullet 的子项嵌入，而非裸贴在小标题下方

---

## PRD 结构框架

### Front Matter

```yaml
---
title: "[前缀] 功能名称"
description: 一两句话概述 PRD 范围
tags:
  - PixVerse
  - tapfiliate
  - affiliate
  - commercialization
  - web
date: YYYY-MM-DD
lastModified: YYYY-MM-DD
status: 待评审          # 待评审 / 开发中 / 已上线 / 已挂起，四选一
feishu: <飞书文档 URL>  # 发布至飞书后回填，未发布则不写该字段
demo: <Demo 页面路径>   # 有配套 demo 时填写相对路径（如 /demo/xxx.html），无则不写
---
```

#### 字段语义

- `title` — `[前缀] 功能名称`，前缀见下方「文档命名 → 标题前缀」
- `description` — 1-2 句概述 PRD 范围（会被 `scripts/sync-kanban.sh` 同步到 kanban-overview）
- `tags` — **4-8 个小写英文关键词**，至少包含「产品名 + 功能领域 + 子模块」；不要混入中文 tag（与 search index / kanban 风格保持一致）。示例见上方
- `date` — 首次创建日期，**写定后不再更新**
- `lastModified` — 每次实质性内容变更都要更新
- `status` — `待评审` / `开发中` / `已上线` / `已挂起` 四选一，不要自创取值
- `feishu` — 发布后回填，URL 形如 `<FEISHU_DOC_URL>>`
- `demo` — 有配套 demo 页面时填相对路径（如 `/demo/erase.html`）；`pnpm prd:feishu-links` 会自动在发布版本顶部插入「Demo 预览」callout（仅注入到 stdout，本地 `.md` 不动）

### 标题层级

- **H2** 作为主章节（不带序号）：`## 背景`、`## 需求详情`、`## 技术选型`
- **H3** 带数字序号：`### 1. 功能模块A` 或 `### 3.1 功能模块A`
- **H4+** 继承上级编号：`#### 3.2.1 子模块`
- H2 章节之间用 `---` 水平线分隔
- Markdown 正文**不包含** H1 标题

### 背景章节

1-3 段，简明扼要：当前状态 → 为什么做 → 本 PRD 范围

```markdown
## 背景

PixVerse 当前仅支持个人用户使用，缺乏团队协作能力。

本方案为 Team Plan 的功能架构设计，目标客群为小型创意工作室 / Agency（2-15 人），定位轻量协作，不涉及审批流等企业级功能。
```

参考链接放在对应章节标题下方（详见「参考链接归档」规则）。

### 设计稿链接章节

有设计稿时放置链接，暂无则标注 TBD：

```markdown
## 设计稿链接

TBD
```

---

## 需求详情撰写

### 表格类型选择

根据需求类型选择合适的表格结构：

#### 类型 A：非 UI 功能（无参考图需求）

两列表格，适用于 CLI 命令、API 接口、后端逻辑等：

```markdown
| 功能/页面 | 需求详情 |
| :--- | :--- |
| 功能名称 | 详细描述 |
```

#### 类型 B：UI 功能（有参考图需求）

三列表格，适用于页面交互、UI 改动等：

```markdown
| 功能/页面 | 需求详情 | 参考图 |
| :--- | :--- | :--- |
| 功能名称 | 详细描述 | ![[image-name.png\|200]] |
```

- 列名可用 `详情` 或 `需求详情`，保持同一文档内统一
- 参考图无则标注 `TBD` 或留空，不写 `-`
- **禁止拆分关联子模块**：一个完整功能的 UI 规格、适用页面、交互规则等应在同一行的同一单元格内用 `**小标题**<br>• ...` 组织，不要拆成多个 H3 章节 + 多个表格
- **禁止写样式细节**：不要描述字号、颜色、间距、组件风格等，这些由设计稿定义
- **「功能/页面」列禁止写章节序号**：左列只放短功能名（如「首次进入」「切换 L1 大类」），**不要**写 `2.1 首次进入` / `5.3 上传组件` 之类前缀。编号只能出现在 H3+ 章节标题（`### 2. 默认选中与状态记忆`），表格行内冗余编号会破坏信息架构、在飞书也会渲染出多余前缀
- **表格内 wiki-image 的 `|` 必须转义为 `\|`**：写 `![[name.png\|200]]`，**不能**写裸 `![[name.png|200]]`。裸 `|` 会被 Markdown 表格当列分隔符切碎，本地 Obsidian / Next.js 渲染都会崩。单元格外的 wiki-image 也可以统一写 `\|`，一种写法不会出错

### 单元格内容组织

#### 默认结构：加粗小标题 + bullet points

「需求详情」单元格的**默认形态**是 `**小标题**<br>• ...` 配 bullet list，避免单元格只塞一段纯文本，也让 Obsidian 表格预览接近云文档里的加粗分组。不要在表格 cell 里写 `<br>- ...`，Obsidian 会把它当普通横杠文本：

```markdown
**包含的二级 Tab**<br>• Generate Video（默认选中）<br>• Template<br>• Reference<br>• Transition<br>• Modify
```

允许在 bullet 内嵌入 code block / blockquote（UI 文案）/ callout 等富格式块，例如：

```markdown
**模型信息**<br>• 模型名：`Kling O3`<br>• Slogan
  > 15s intelligent multi-shot · universal reference lock
```

**禁止**整格直接写纯文本段落：

```markdown
<!-- ❌ 错误：单元格只有一段纯文本 -->
当前 Image 无子模式，不渲染 L2 Tab Bar，L1 选中 Image 后直接展示 Image 创作表单

<!-- ✅ 正确：用 bullet 收敛，必要时配 **小标题** -->
**规则**<br>• 当前 Image 无子模式，**不渲染 L2 Tab Bar**<br>• L1 选中 Image 后直接展示 Image 创作表单
```

例外：一句话即可说清的极简事实可以裸写一行 bullet，仍不允许多行散文段。

**额外强制规则**：`**小标题**<br>` 或 `##### 小标题` 后必须是 `• ` bullet，不允许直接接纯文本：

```markdown
<!-- ❌ 错误：小标题下直接接段落 -->
**包含的二级 Tab**<br>
Generate Video（默认选中）、Template、Reference、Transition、Modify

<!-- ❌ 错误：小标题下裸贴 blockquote / code block -->
**Slogan**<br>
> 15s intelligent multi-shot

<!-- ✅ 正确：小标题后首个内容就是 bullet，富格式块作为 bullet 子项 -->
**Slogan**<br>• 主标语
  > 15s intelligent multi-shot
```

#### 子标题分隔

复杂功能在单元格内用 `**小标题**<br>• ...` 分隔逻辑块；只有确实需要语义层级时才用 `##### 小标题`：

```markdown
**模型信息**<br>• 模型名：Kling O3
  > 15s intelligent multi-shot · universal reference lock

**参数**<br>• 时长：3-15s 之间任意整数（默认 5s）<br>• 画幅比：16:9 / 9:16 / 1:1

**支持模式 & 能力**<br>• ✅ T2V & I2V<br>• ✅ Multi-shot 多镜头开关
```

#### UI 文案引用

页面上实际展示的文案用 blockquote 格式：

```markdown
- 标题
  > Join {workspace_name}
- 副标题
  > You've been invited to collaborate on PixVerse
- 按钮
  > Accept Invitation
  > Decline
```

#### 多行内容

同一单元格内用 `<br>` 换行：

```markdown
纯视频：$0.084/s<br>含音频：$0.112/s
```

#### 分步流程

在单元格内描述多步骤交互：

```markdown
**第一步，完成 Workspace 命名**<br>• 标题
  > Give your Team Workspace a name
- 输入框
  > Enter a name for the Team Workspace
- 按钮
  > Confirm

**第二步，邀请团队成员**<br>• 标题
  > Invite members to your workspace
```

#### 场景分支

用 `**Scenario X：场景描述**<br>` 组织多场景：

```markdown
**Scenario A：已登录，邮箱匹配**<br>1. 解析 token → 校验邮箱与当前登录账号一致<br>2. 展示邀请确认页<br>3. 点击 Accept → 加入团队 → Toast 提示

**Scenario B：未登录，已有账号**<br>1. 跳转登录页，邮箱预填写并锁定<br>2. 登录成功 → 自动跳回邀请确认页
```

---

## 特殊表格类型

### 功能支持状态表

```markdown
| CLI 命令 | Web UI 命名 | API 端点 | 支持状态 |
| :--- | :--- | :--- | :--- |
| `create video` | Video | `/video/t2v` | ✅ 已实现 |
| `create template` | Template | `/video/t2v` with `template_id` | 🟡 后续迭代 |
| ~~`create restyle`~~ | ~~Restyle~~ | ~~`/video/restyle`~~ | ❌ 不支持 |
```

- ✅ 已实现 / 🟡 后续迭代 / ❌ 不支持
- 不支持的项用 `~~strikethrough~~` 标记

### 权限矩阵表

布尔/状态列居中对齐，能力描述列左对齐：

```markdown
| 能力 | Owner | Admin | Member | Guest |
| :--- | :---: | :---: | :---: | :---: |
| 账单管理 | ✅ | ❌ | ❌ | ❌ |
| 邀请/移除成员 | ✅ | ✅ | ❌ | ❌ |
```

### 计费/定价表

```markdown
| 类型 | 模型 | 档位 | Fal 定价 | 积分定价 |
| --- | --- | --- | --- | --- |
| 视频 | Kling O3 | Standard | 纯视频：$0.084/s<br>含音频：$0.112/s | 纯视频：25<br>含音频：35 |
```

### API 参数参考表

```markdown
| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `prompt` | string | - | 正向提示词，最多 2500 字符 |
| `duration` | string | `"5"` | `"3"`-`"15"` 秒 |
```

多模型对比时扩展列：

```markdown
| 参数 | 类型 | 默认值 | 说明 | Kling O3 | Kling 3.0 |
| --- | --- | --- | --- | --- | --- |
| `negative_prompt` | string | - | 负向提示词 | ❌ 不支持 | ✅ 支持 |
```

### 技术选型表

```markdown
| 类别 | 选型 |
| :--- | :--- |
| 运行时 | Node.js (npm 分发) |
| CLI 框架 | Commander.js |
```

### 会员权益变更表

```markdown
| 权益项 | Basic | Standard | Pro | Premium | Ultra |
| --- | --- | --- | --- | --- | --- |
| 功能使用权限 | ❌ | ❌ | TBD | TBD | TBD（40% OFF） |
```

### 默认值对比表

```markdown
| 参数 | `create video` | `create image` | `create template` |
| :--- | :--- | :--- | :--- |
| model | `v5.6` | `qwen-image` | — |
| quality | `720p` | `1080p` | — |
```

---

## Callout / 备注 用法

### 待确认问题 Callout

每个 section 中需要用户确认的问题，放在该 section 标题下方：

```markdown
> [!warning] 待确认问题
> 1. Extend 模式是否需要独立的分辨率参数？
> 2. 参考图计费是每张还是总共？
```

### 架构说明 Callout

在需求表格前用 callout 说明核心架构或关键规则：

```markdown
> [!info] 核心结构：Account → Workspace → Content
> - 每个用户对应一个 Account
>     - 支持手动切换 Workspace
> - **Personal Workspace 与 Team Workspace 完全隔离**

| 功能/页面 | 详情 | 参考图 |
```

### 注意事项 Callout

```markdown
> [!note]
> - Web 端需要前端交互的功能（如画笔涂抹、区域选择等），本期 CLI 不支持
> - 模板 Template 的信息复杂度较高，先暂缓，后续迭代支持
```

### API 提供方说明

```markdown
> **API 提供方**：[fal.ai](https://fal.ai)
```

### 后续迭代标注

```markdown
> **后续迭代**：`--style`、`--camera` 等参数将在后续版本支持
```

---

## 图片引用

使用 Obsidian wiki-link 格式，统一宽度 200。**在 Markdown 表格单元格内，`|` 必须转义为 `\|`**，否则被当列分隔符切碎：

```markdown
![[image-name.png\|200]]
```

参考图列中多张图时用 `<br><br>` 分隔，并加文字标注：

```markdown
创建流程第一步<br>![[step1.png\|200]]<br><br>创建流程第二步<br>![[step2.png\|200]]
```

表格外（独立行、列表项）的 wiki-image 也建议统一写 `\|`，保持仓库内一种写法。

---

## 发布至飞书

格式转换、`<title>` 硬约束、图片上传 SOP、列宽规则、callout 反向映射、回读验证等**全部按 [feishu-formatter](../feishu-formatter/SKILL.md) skill 执行**。本 skill 不再平行维护一份发布步骤，避免两套规则漂移。

本地 PRD 完成后的交接点：

1. **缩进 review** → 全文 tab → 空格
2. **禁止清单自检** → 见下方「禁止清单」一节
3. **跑 `pnpm prd:feishu-links <本地 PRD>`** → 解析内部 wiki-link / 相对路径为飞书 URL；目标 PRD 无 `feishu` 时降级为文本但必须 warning，不允许静默发布
4. **调用 feishu-formatter skill** → 由其负责格式转换、`<title>` 验证、`<colgroup>` 列宽、图片上传、回读
5. **回填 feishu URL** → 发布成功后将 `doc_url` 写入本地 front matter

工具选择：仅使用 `lark-cli` 与 lark-* skill（`lark-doc`、`lark-drive` 等），**禁止使用 MCP 工具**。

飞书 → 本地归档：拉取后同样调用 feishu-formatter skill 的「飞书 → 本地 PRD 归档规范」反向转换，更新 `lastModified`，跑一次 `pnpm build` 验证。

---

## 文档命名

### 文件格式

```
YYYYMMDD_产品-功能关键词.md
```

示例：`20260313_kling-o3-kling3.md`、`20260308_pixverse-team-plan.md`

### 飞书文档标题 & Front Matter title

```
[产品/模块] 功能名称
```

示例：`[PixVerse] Team Plan 产品设计方案`、`[Web] Kling O3 & Kling 3.0 视频 & 图片生成能力接入`

### 标题前缀

标题前缀分为两类：**产品名**和**平台/模块**。

#### 产品

| 前缀 | 说明 |
| :--- | :--- |
| **[PixVerse]** | AI 视频生成（Web: 专业创作者 / App: 娱乐模板） |
| **[Quokka]** | 移动端 AI 特效工具 |

#### 平台 / 模块

| 前缀 | 说明 |
| :--- | :--- |
| **[Web]** | Web 端功能（模型接入、页面改动等） |
| **[PixVerse App]** | PixVerse 移动端 App 功能 |
| **[国内]** | 国内版本差异化功能 |
| **[Analytics]** | 埋点 / 数据字段变更 |
| **[Galaxy Store]** | Galaxy Store 上架相关 |
| **[商业化]** | 跨产品商业化模块（支付、分销等） |
| **[运营后台]** | 运营管理系统 |

---

## 质量检查

完成 PRD 后，参考以下清单进行验证：

### 结构检查

- [ ] H2 无序号，H3+ 有序号
- [ ] H2 章节之间有 `---` 水平线
- [ ] 需求表格类型正确（两列 vs 三列）
- [ ] 列表项无句号

### 内容检查

- [ ] 背景 1-3 段，简明扼要
- [ ] 需求详情表格内容结构清晰（子标题分隔、UI 文案引用、场景分支）
- [ ] 无未提及的多余章节
- [ ] 功能状态使用 ✅ / 🟡 / ❌ 标记
- [ ] 逻辑紧密的子模块在同一行同一单元格内，未拆分为多个 H3 + 多个表格
- [ ] 表格单元格默认使用 `**小标题**<br>• ...` + bullet 组织，未整格堆纯文本段落
- [ ] 每个 `**小标题**<br>` / `##### 小标题` 下方第一行都是 `• ` bullet，未直接接纯文本或裸贴 code/blockquote/callout
- [ ] 无样式细节描述（字号、颜色、间距、组件风格等）
- [ ] 数据字段按业务语义归纳为一个概念行，未逐字段拆行

### 表格检查

- [ ] 权限/对比表布尔列居中对齐 `:---:`
- [ ] 定价表多维度用 `<br>` 组织
- [ ] API 参数表包含：参数、类型、默认值、说明
- [ ] 不支持的功能用 `~~strikethrough~~` 标记
- [ ] 「功能/页面」列单元格不带 `2.1 / 5.3` 之类章节序号前缀
- [ ] PixVerse Mini-App PRD 入口表未写「分类归属」（分类体系已废弃）

### 格式检查

- [ ] 全文缩进使用空格，无 tab
- [ ] 参考链接已在对应 section 开头归档
- [ ] 文末有 `## 参考链接` 收尾章节，已归档关联/上游 PRD 与口径基线文档（blockquote + ul）
- [ ] 待确认问题已用 `[!warning]` callout 标注
- [ ] 所有表格内 wiki-image 都写成 `![[name.png\|200]]`（`|` 已转义为 `\|`）

> 飞书表格和 Callout 的格式规范，请参考 **[feishu-formatter](../feishu-formatter/SKILL.md)** skill
