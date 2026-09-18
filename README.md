# 现代 R 进阶 · 书籍、训练与参考资料库

**《现代 R 进阶》作者：Jaime Yan。** 面向已有 R 基础、需要提升分析与交付能力的读者，并提供临床研究与制药领域的阅读路径。

本仓库维护三个独立入口：[书籍](https://yanmingyu92.github.io/posit-conf-2026-bilingual/book/)、[配套训练](https://yanmingyu92.github.io/posit-conf-2026-bilingual/training.html)与[会议资料库](https://yanmingyu92.github.io/posit-conf-2026-bilingual/catalog.html)。书籍按学习成果组织，训练按交付任务组织，资料库按原始来源检索。

*Modern R in Practice*, by Jaime Yan, combines an authored learning narrative with practice labs. The posit::conf archive remains a separate source catalog; further reading also draws on established R books and official documentation.

Read the [English edition](https://yanmingyu92.github.io/posit-conf-2026-bilingual/book/en/) or [中文版](https://yanmingyu92.github.io/posit-conf-2026-bilingual/book/). Both contain the same 28 chapters, with a language switch on each page.

> 📚 中文版说明见下方 [中文简介](#中文简介)。

---

## English

### What's inside

| Layer | Location | Description |
|---|---|---|
| **The Book** 📖 | `book/` | **《现代 R 进阶》**：Jaime Yan，四单元 28 章，含封面、前言、阅读指南和多来源阅读地图 |
| **English book** | `book-en/` | *Modern R in Practice*, by Jaime Yan: all 28 chapters, cover, preface, reading paths, sources, and companion practice |
| **Practice labs** | `training/` | 独立任务、模拟数据、起始脚本、参考实现与自动验收；当前 1 套完整综合实验 |
| **Original curriculum** | `curriculum/` | **Our own course system** built on the corpus: 5-domain × 3-level competency matrix, learner personas, module blueprints (start with `curriculum/MATRIX.md`) |
| Mirrored 2026 materials | `content/en/` | Verbatim copies of all 8 official 2026 workshop repos, organized by track, with provenance manifest |
| Prior-year catalog | `ARCHIVE-CATALOG.md` | Topic map of 19 curated 2024/2025 workshops that fill gaps 2026 didn't cover (Shiny, pkg-dev, ggplot2, tidymodels, causal, databases, …) |
| Chinese translations | `translations/zh/` | Bilingual learning plan + per-module Chinese translations (in progress, contributions welcome) |
| Website | `website/` | Quarto site rendering the hub, auto-deployed to GitHub Pages |

### Source library: the 9 tracks

1. R Language Foundations · R 语言基础
2. IDE & Tooling (Positron, production) · 开发环境
3. Quarto & Publishing · 文档出版
4. Data Engineering (DuckDB, Arrow, Polars) · 数据工程
5. Visualization & Tables (ggplot2, plotnine, Great Tables) · 可视化与表格
6. Shiny & Interactive Apps · 交互应用
7. Statistics & Machine Learning (tidymodels, scikit-learn, causal, vetiver) · 统计与机器学习
8. LLM & AI Programming (ellmer, agents, skills, MCP) · 大模型编程
9. Pharma & Regulated (pharmaverse, GxP) · 制药与合规

### Quick start

Read the [English book](https://yanmingyu92.github.io/posit-conf-2026-bilingual/book/en/) or start the [English practice lab](training/en/analysis-handoff/README.md). To build locally:

```bash
python scripts/build_training_download.py
quarto render book
quarto render book-en
quarto render website
```

Generated HTML stays outside version control; GitHub Actions rebuilds the book, training download and website from source.

For code QA, `QA_BOOK_DIR=book-en` and `QA_EVIDENCE_DIR=.qa/en` select English sources and separate evidence in the `qa_book` scripts; defaults retain the Chinese edition. Run `python scripts/qa_book_english.py` for edition completeness and structural parity. Model-service examples retain their credential and execution limitations.

```bash
git clone https://github.com/yanmingyu92/posit-conf-2026-bilingual.git
# Read the plan: translations/zh/LEARNING-PLAN.zh.md (中文) — or start from ARCHIVE-CATALOG.md (EN)
```

### Update from upstream

```powershell
powershell -File scripts/sync-from-upstream.ps1   # re-mirrors 2026 repos + refreshes manifests
```

### License & attribution

All adapted workshop materials are [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/),
© their original instructors (Hadley Wickham, Jenny Bryan, Mine Çetinkaya-Rundel, Garrick
Aden-Buie, Daniel D. Sjoberg, and others — full list in [ATTRIBUTION.md](ATTRIBUTION.md)).
This repository is not affiliated with Posit, PBC. See [ATTRIBUTION.md](ATTRIBUTION.md) for
per-repository credits, licenses, and snapshot SHAs.

---

## 中文简介

### 这是什么？

posit::conf 是 Posit 公司（RStudio、Shiny、Quarto、Positron 的缔造者）的年度数据科学大会，
其工作坊材料全部开源开放。本仓库把这些散落在 3 届、30+ 个仓库的材料按主题重组为 9 条学习
轨道，并提供中文学习计划与逐模块中文翻译（翻译进行中，欢迎参与）。

### 适合谁？

- 想系统学习现代 R / Python 数据科学栈的医学生物统计、临床研究从业者
- 想跟进 2026 最新主题（Positron、AI 辅助工作流、LLM 编程、pharmaverse）的 R 用户
- 需要英文原文 + 中文讲解双语对照的学习者

### 怎么开始？

1. 想系统学：读 [原创课程体系](curriculum/CURRICULUM-DESIGN.md)——基于全部材料设计的
   「5 能力域 × 3 水平」课程矩阵 + 4 类学员画像 + 逐模块教学设计
2. 想自己找材料：[ARCHIVE-CATALOG.md](ARCHIVE-CATALOG.md) 轨道总目录
3. 想按周打卡：[中文学习计划](translations/zh/LEARNING-PLAN.zh.md)
4. 想参与翻译：规范见 [CONTRIBUTING.md](CONTRIBUTING.md)；想写课：见
   [curriculum/modules/TEMPLATE.md](curriculum/modules/TEMPLATE.md)

### 许可与署名

所有改编的工作坊材料均为 [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
协议，© 原讲师所有；本仓库与 Posit, PBC 无官方关联。完整署名清单、各仓库协议与快照 SHA
见 [ATTRIBUTION.md](ATTRIBUTION.md)。

### Star History / 走势

如果这个仓库对你有帮助，欢迎 Star ⭐ / 推荐 / 参与翻译，让更多中文用户受益。
