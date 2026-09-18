# Promotion Playbook · 推广手册（双语）

> Launch plan for the bilingual hub. Execute in order; each channel has a ready-to-use
> template. 双语中心发布方案：按顺序执行，每个渠道都有现成模板。

## 0. Launch checklist · 发布前检查

- [x] ~~替换 README/_quarto.yml 中的 `yanmingyu92` 为真实 GitHub 用户名~~（已完成：仓库已以 `yanmingyu92` 上线）
- [ ] `gh repo create <name> --public --source . --push` 推送
- [ ] 仓库 Settings → Pages → Source: GitHub Actions
- [ ] 本地 `quarto preview website` 确认站点正常，Actions 部署成功
- [ ] 星标自己的仓库，置顶到 profile（pin）

## 1. English channels · 英文渠道

### 1.1 Posit Community（最重要，官方论坛）
发帖版块：`#general` 或 `#educators`。模板：

> **Subject:** A bilingual (EN/中文) study hub organizing posit::conf workshop materials from 2024–2026
>
> Hi everyone! I built a community learning hub that combines the openly licensed
> posit::conf workshop materials (2024–2026) into 9 topic tracks with guided learning
> paths, plus a Chinese translation layer (work in progress, contributions welcome).
>
> - Track catalog: Shiny, Quarto, Positron, LLM programming (ellmer/chatlas),
>   tidymodels, causal inference, pharmaverse, databases, and more
> - All materials CC-BY-SA 4.0 © the original instructors, full attribution +
>   snapshot SHAs in ATTRIBUTION.md
> - Not affiliated with Posit — built with gratitude for the openly licensed materials
>
> Would love feedback, especially from instructors if anything needs correction!

### 1.2 X/Twitter + LinkedIn（一条内容两用）
> I organized 3 years of posit::conf workshop materials (2024–2026) into 9 bilingual
> learning tracks — Shiny, Quarto, LLM programming with ellmer, pharmaverse, causal
> inference... with a Chinese translation layer. Openly licensed, full attribution.
> 🔗 <repo-url> · #rstats

### 1.3 其他
- RWeekly.org 提交（issue 或 PR，格式见其仓库）
- r/rstats 版块（注意规则：周六 Self-Promo 或以"资源分享"口吻）
- mastodon.social #rstats

## 2. Chinese channels · 中文渠道

### 2.1 知乎（长文，SEO 主力）
标题候选：《posit::conf 2024–2026 全部工作坊材料：我整理成了 9 条中英双语学习轨道》
结构：为什么值得学 → 9 轨道总览图 → 2026 三大新主题解读（Positron/LLM 编程/pharmaverse）
→ 学习计划表 → 仓库链接。文末注明 CC-BY-SA 署名与"与 Posit 无关联"。

### 2.2 微信公众号 / 生信/统计类社群
短文模板（300 字内 + 目录截图）：
> Posit 年会工作坊材料全部开源，但散在 30+ 个仓库、三年时间里。我把它重组为 9 条
> 学习轨道并开始做中文翻译：R 基础 → Positron/AI 工作流 → Quarto → Shiny →
> tidymodels/因果推断 → LLM 编程 → pharmaverse。附 7 周中文学习计划，医学生统人
> 直连轨道 8/9。链接见评论区。

### 2.3 统计之都（cosx.org）投稿 / R-Ladies China / 校园 R 社群
长文投稿优先级最高（权威社区背书）。

## 3. Cadence & metrics · 节奏与指标

| 时间 | 动作 | 目标 |
|---|---|---|
| D0 | GitHub 发布 + 全渠道首发 | 100 stars / 周 |
| D+3 | 转完 llms 工作坊 README+outline 中文版，发第二篇（内容营销） | 知乎 50 赞 |
| D+7 | Posit Community 若有回应，互动并记录讲师反馈 | 修正问题 |
| D+14 | 发布「首个月学习成果」内容 + 翻译贡献者招募 | 3+ 外部贡献者 |
| M+1 | 复盘：stars/issue/PR/翻译完成率，决定下阶段（见 OPPORTUNITIES.md 路线） | — |

## 4. Etiquette red lines · 礼仪红线

1. **Always credit instructors by name** in every post; link the upstream repo first.
2. Never imply official Posit endorsement; state "not affiliated" in long posts.
3. Never paste full translated materials into social posts — link to the repo
   (translation files carry the required attribution headers).
4. If an instructor requests correction/removal, comply within 48h and document it.
