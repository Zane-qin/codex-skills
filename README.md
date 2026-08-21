# Codex Skills

Zane 的可公开 Codex Skill 源码仓库。

## Skills

- [`rent-ops`](skills/rent-ops/)：AI 租房助手，支持房源扫描、评估、去重、地图展示、风险检查和看房准备。
- [PRD Skill 套件](PRD_SKILLS.md)：8 个覆盖通用 PRD、团队规范、专项章节和飞书工作流的 Skill。

## 安全说明

仓库只保存可移植源码、模板和静态资产，不包含以下本地运行内容：

- API Key、MCP Key 和 `.mcp.json`
- 租房偏好、个人画像及 `config/profile.yml`
- 房源数据、抓取结果、浏览器会话和报告
- `.venv`、`__pycache__` 及其他可再生成依赖

安装后根据各 Skill 的说明在本地创建配置和运行环境。
