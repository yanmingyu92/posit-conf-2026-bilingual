# posit::conf 三届材料系统学习计划（中文版）

> 覆盖 2024–2026 三届官方工作坊，重组为 9 条轨道。原计划基于 2026 材料制定，
> 现已用往届材料补齐 Shiny、包开发、ggplot2、统计建模、因果推断、数据库等空白。
> 配套英文索引见 [ARCHIVE-CATALOG.md](../../ARCHIVE-CATALOG.md)。

## 总览：9 条轨道与依赖

```
轨道1 R 语言基础 ──→ 轨道2 IDE与工具 ──→ 轨道3 Quarto 出版
      │                                      │
      ├──→ 轨道4 数据工程 ──→ 轨道5 可视化    │
      │                                      ↓
      └──→ 轨道6 Shiny ──→ 轨道8 LLM 编程（2026 新增）
             │
             └──→ 轨道7 统计与机器学习 ──→ 轨道9 制药与合规
```

## 第一阶段：R 语言基础（1–2 周，可按水平跳过）

| 内容 | 材料 | 来源 |
|---|---|---|
| R 编程入门 ⭐ | r-programming + 配套练习 | 2025 镜像链接 |
| 自助排错与文档 | modern-r-workflow 模块 01 | 2026 `content/en/` |
| R 包开发 | pkg-dev | 2025 链接 |

**验收**：写一个有文档、有测试、可安装的小 R 包。

## 第二阶段：工具链（1 周）

| 内容 | 材料 | 来源 |
|---|---|---|
| Positron 速成 ⭐ | positron（PDF 讲义 + debug.R） | 2026 `content/en/` |
| 现代 R 工作流 × AI | modern-r-workflow 全部 8 模块 | 2026 `content/en/` |

**验收**：给自己的项目写 `AGENTS.md`，在 Positron 完成一次「解释→修改→验证」AI 循环。

## 第三阶段：文档出版（1 周）

| 内容 | 材料 | 来源 |
|---|---|---|
| Quarto 入门（零基础） | quarto-intro | 2024 链接 |
| Quarto 实战模式 ⭐ | practical-quarto + exercises | 2026 `content/en/` |
| 品牌化 brand.yml | quarto-brand | 2025 链接 |
| 扩展开发（Lua） | quarto-extend + exercises | 2025 链接 |

**验收**：产出「brand.yml + partials + Typst PDF」三件套小项目。

## 第四阶段：数据工程与可视化（1–2 周）

| 内容 | 材料 | 来源 |
|---|---|---|
| 数据库 in R（DuckDB）⭐ | databases | 2024 链接 |
| Apache Arrow | arrow | 2024 链接 |
| ggplot2 精通 ⭐ | ggplot2 | 2025 链接 |
| polars / plotnine / great-tables | modern-ds-python | 2026 `content/en/` |

**验收**：用 DuckDB + ggplot2 重做一次真实数据的取数→清洗→出版级图表。

## 第五阶段：Shiny 交互应用（1–2 周）

| 内容 | 材料 | 来源 |
|---|---|---|
| Shiny for R 全程 ⭐ | shiny-r | 2025 链接 |
| Shiny 进阶 | level-up-shiny | 2024 链接 |
| Shiny for Python | shiny-py | 2025 链接 |

**验收**：做一个部署可用的多页 Shiny 应用（含模块化 + golem 或同类结构）。

## 第六阶段：LLM 编程（1–2 周，重点）

| 内容 | 材料 | 来源 |
|---|---|---|
| 会话解剖/结构化输出/评测 | llms 练习 01–18 | 2026 `content/en/` |
| Agents 与工具调用 ⭐ | llms 练习 19–20 | 2026 `content/en/` |
| Agent skills | llms 练习 21–22 + `.agents/skills/` | 2026 `content/en/` |
| shinychat / querychat | llms 练习 24–26 | 2026 `content/en/` |
| RAG 与 MCP | llms 练习 51–52 | 2026 `content/en/` |

**验收**：用 ellmer 做一个「对 CSV 提问 → 结构化返回 → shinychat 界面」的小应用。

## 第七阶段：统计与机器学习（2 周，可选）

| 内容 | 材料 | 来源 |
|---|---|---|
| tidymodels ⭐ | tidymodels | 2025 链接 |
| 因果推断（医研刚需）⭐ | causal | 2025 链接 |
| scikit-learn | scikit-learn | 2025 链接 |
| MLOps / vetiver | vetiver | 2024 链接 |

**验收**：完成一个含重抽样、调参、评估的 tidymodels 建模报告（Quarto 渲染）。

## 第八阶段：制药与合规（1–2 周，方向选修）

| 内容 | 材料 | 来源 |
|---|---|---|
| 临床报告流水线 ⭐ | pharmaverse（SDTM→ADaM→ARD→TFL） | 2026 `content/en/` |
| 受监管环境（GxP） | r-pharma-regulated | 2026 `content/en/` |
| 可复现受监管环境 | reproducible-environments | 2025 链接 |

**验收**：从模拟数据跑通一条带验证痕迹的 ADaM→TFL 链路。

## 学习方法

1. **练习优先**：材料都是「讲义+练习+答案」结构，先自己做，卡 15 分钟再看答案。
2. **用 AI 学 AI**：第六阶段的内容本身就是 AI 工具链教程，边学边用。
3. **每周输出**：把所学应用到自己的真实项目一次。
4. **进度打勾**：

- [ ] 阶段一 R 基础
- [ ] 阶段二 工具链
- [ ] 阶段三 Quarto
- [ ] 阶段四 数据工程与可视化
- [ ] 阶段五 Shiny
- [ ] 阶段六 LLM 编程
- [ ] 阶段七 统计与 ML
- [ ] 阶段八 制药与合规
