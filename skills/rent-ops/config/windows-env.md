# Windows 环境说明

本机已安装：

- Git for Windows / Git Bash
- rent-ops `.venv`
- Playwright / playwright-stealth / PyYAML
- Playwright Chromium

注意：Playwright 1.60 默认 headless 模式会查找 `chromium_headless_shell`。当前网络下载该组件多次超时，但完整 Chromium 已可用：

`C:\Users\17841\AppData\Local\ms-playwright\chromium-1223\chrome-win64\chrome.exe`

在 Windows 上做自动化检查时，可显式传入 `executable_path` 使用该浏览器。豆瓣爬虫脚本当前使用 `headless=False`，通常不会触发 headless shell 问题。
