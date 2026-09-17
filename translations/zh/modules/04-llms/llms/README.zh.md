---
title: "用 R 和 Python 编程调用大语言模型 / Programming with LLMs in R and Python"
source: https://github.com/posit-conf-2026/llms/blob/main/README.md
source_sha: 165cb237684b42d6bf33ae347ba0c61aad88dba4
license: CC-BY-SA 4.0
translators: ["@placeholder"]
status: draft
---

> 本页是 posit::conf(2026) 工作坊材料的中文翻译。原作 © Garrick Aden-Buie & Sara Altman，
> 采用 CC-BY-SA 4.0 协议发布。
> This is a Chinese translation of openly licensed posit::conf(2026) materials,
> © Garrick Aden-Buie & Sara Altman, licensed CC-BY-SA 4.0.

# 用 R 和 Python 编程调用大语言模型

### posit::conf(2026) · 讲师：Garrick Aden-Buie、Sara Altman

🗓️ 2026 年 9 月 14 日 · 09:00–17:00 · 官网：<https://posit-conf-2026.github.io/llms/>

## 工作坊简介

大语言模型（LLM）为开发者提供了前所未有的编程能力。本工作坊介绍 ellmer（R 包）与
chatlas（Python 包）——两个 Posit 出品的包，它们简化了 LLM API 的集成，处理会话管理
的复杂性，让与 AI 模型的交互无缝融入数据分析代码。你将获得对两个生态的概念性理解，
并可在实操环节自选语言（R 或 Python）。

学员将探索系统提示词（system prompt）设计、token（词元）管理与工具调用（tool
calling），逐步建立对当前 AI 技术的熟悉度。本工作坊想传达三个观点：

- 用代码调用 LLM 能解锁标准工具之外的可能性；
- 不需要任何高级 AI 背景即可上手；
- 实现 AI 应用既触手可及也充满乐趣。

本工作坊同时面向 AI 新手与有经验的开发者，内容涵盖 LLM 集成、Shiny 网页应用开发，
并触及动态信息检索（RAG）、上下文工程（context engineering）与智能体工作流
（agentic workflows）等进阶主题。作为双语工作坊，学员可自选 R 或 Python 实操。

[译注: 以上为 README「Description」一节的完整翻译；练习与答案在仓库 `_exercises/`
与 `_solutions/` 目录，`outline.md` 为完整教学大纲，可按 CONTRIBUTING 流程逐个翻译。]

## 日程

| 时间 | 内容 |
|---|---|
| 09:00–10:30 | 💬 会话的解剖（Anatomy of a Conversation） |
| 10:30–11:00 | ☕ 茶歇 |
| 11:00–12:30 | 💻 用代码编程 LLM |
| 12:30–13:30 | 🍽️ 午餐 |
| 13:30–15:00 | 🔍 智能体（Agents） |
| 15:00–15:30 | ☕ 茶歇 |
| 15:30–17:00 | 🚀 querychat、shinychat 与未来展望 |

## 讲师

**Garrick Aden-Buie** — Posit Shiny 团队高级软件工程师，长期 R 用户与教育者，
开源项目包括 epoxy、xaringanExtra、tidyexplain。主页 <https://garrickadenbuie.com>。

**Sara Altman** — [译注: 原文此节为空，待上游补充后同步。]

助教：Kristin Bott、Alex Chisholm、Carson Sievert
