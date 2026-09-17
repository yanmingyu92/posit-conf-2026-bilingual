# Unit Structure · 单元式课程结构（参照 STAT 541 Advanced R）

> 本课程的**交付结构**参照 [Advanced R](https://atheobold.github.io/advanced-R-website/)
> （STAT 541, Cal Poly · Drs. Kelly Bodwin & Allison Theobold · CC-BY-SA 4.0）的三单元
> 分类法重新设计，并与其 9 种教学标注体系（见 [CALLOUTS.md](CALLOUTS.md)）对齐。
> 我们在其骨架上做了两处适配：① 各章素材全部锚定 posit::conf 矿藏；② 追加第四单元
> 承载我们的差异化（AI 与领域应用）。

---

## 0. Dual views · 双视图原则

- **MATRIX.md（能力矩阵）= 图书馆的书架**：按能力域×水平组织，用于检索、诊断、
  个性化路径（画像用这个视图）。
- **UNIT-STRUCTURE.md（本文件）= 学期的课表**：按成果弧线组织，用于线性交付
  （开班、出书、付费课用这个视图）。
- 两视图通过**交叉表（§4）**互通：每个 Unit 章节都标注矩阵坐标。

## 1. The arc · 三单元弧线（成果导向，直接沿用其命名）

```
Unit 1 复杂分析        Unit 2 专业交付物          Unit 3 包开发
Complex Analyses  →   Professional Deliverables → Package Development
"驯服混乱的真实数据"    "把结果变成可交互的产品"     "把代码变成可维护的资产"
        ↓                    ↓                        ↓
  函数·迭代·效率        仪表盘·地图·Shiny          测试·调试·性能
        └──────────────── Unit 4 AI 与领域应用（我们的扩展）────────────────┘
                      "让 AI 放大以上一切，并落到专业领域"
```

## 2. Unit 章节设计（每章标注：素材来源 / 矩阵坐标 / 状态）

### Unit 1 · Complex Analyses 复杂分析
*心智主线：从"会用函数"到"会造函数"，再到"数据不在 CSV 里怎么办"*

| 章 | 内容 | 素材锚点 | 矩阵 | 状态 |
|---|---|---|---|---|
| 1.1 | Writing Functions 函数 | r-programming(2025链) | B-L1 | 素材齐 |
| 1.2 | Iterating Over Functions 迭代（purrr/map） | r-programming 后半(链) | B-L1 | 素材齐 |
| 1.3 | Efficient Code 效率与中间对象 | 参照其讲义结构原创 | B-L2 | **100% 原创** |
| 1.4 | JSON Data & APIs | — | B-L2 | **空缺（机会）** |
| 1.5 | Web Scraping | — | B-L2 | **空缺（机会）** |
| 1.6 | Great Tables with gt | modern-ds-python 的 great-tables(镜) | D-L2 | 素材齐 |
| 1.7 | Non-Standard Geometries | ggplot2(2025链) 中后段 | D-L2 | 素材齐 |
| 1.8 | Professionally Styled Plots | ggplot2(2025链) + quarto-brand(链) | D-L2 | 素材齐 |

### Unit 2 · Professional Deliverables 专业交付物
*心智主线：从"讲一个故事"到"给读者一个探索工具"*

| 章 | 内容 | 素材锚点 | 矩阵 | 状态 |
|---|---|---|---|---|
| 2.1 | Interactive Graphics（plotly 等） | — | D-L2 | **空缺（机会）** |
| 2.2 | Animation（gganimate） | — | D-L2 | **空缺（机会）** |
| 2.3 | Quarto Dashboards 静态 | 2024 quarto-dashboards（backlog→**提升**） | D-L2 | 编目即可用 |
| 2.4 | Quarto Dashboards 动态 | 同上 + shiny-r(链) | D-L2/E-L2 | 素材齐 |
| 2.5 | Maps with leaflet | — | D-L2 | **空缺（机会）** |
| 2.6 | ggplot Extensions | ggplot2(链)+quarto-extend(链) 思想 | D-L3 | 素材齐 |
| 2.7 | Shiny Reactive 设计 | shiny-r(链)+level-up-shiny(链) | E-L1→L2 | 素材最厚 |
| 2.8 | Quarto 出版级报告（合流章） | practical-quarto(镜)+quarto-brand(链) | D-L2 | 素材最厚 |

### Unit 3 · Package Development 包开发
*心智主线：从"脚本能跑"到"代码可被他人信任"*

| 章 | 内容 | 素材锚点 | 矩阵 | 状态 |
|---|---|---|---|---|
| 3.1 | R Package Structure | pkg-dev(2025链) | A-L2 | 素材齐 |
| 3.2 | Unit Testing | pkg-dev(链) | A-L2 | 素材齐 |
| 3.3 | Debugging | modern-r-workflow 模块01(镜)+positron 的 debug.R(镜) | A-L2 | 素材齐 |
| 3.4 | Code Speed & Benchmarking | databases/arrow(链) 旁证 | A-L3 | **半空缺（机会）** |

### Unit 4 · AI & Domain Applications（我们的扩展单元）
*心智主线：AI 放大前三单元的一切；领域决定材料深度*

| 章 | 内容 | 素材锚点 | 矩阵 | 状态 |
|---|---|---|---|---|
| 4.1 | LLM 编程基础（ellmer） | llms 01–11(镜) | F | 素材齐 |
| 4.2 | 结构化输出与评测 | llms 10/15(镜) | F | 素材齐 |
| 4.3 | Agents 与工具调用 | llms 19–20(镜) | F | 素材齐 |
| 4.4 | Agent Skills 工程化 | llms 21–22 + .agents/skills(镜) | F/A-L3 | 素材齐 |
| 4.5 | RAG 与 MCP | llms 51–52(镜) | F/B-L3 | 素材齐 |
| 4.6 | shinychat 数据对话应用 | llms 24–26(镜) | E-L2 | 素材齐 |
| 4.7 | 临床报告（pharmaverse） | pharmaverse(镜) | E-L3 | 素材齐 |
| 4.8 | 受监管环境（GxP） | r-pharma-regulated(镜)+reproducible-environments(链) | E-L3 | 素材齐 |

## 3. 配套件（沿用其课程构件，全部本地化）

- **Review 章**（对应其 STAT 331 Review）：我们的 `L1-A1-first-repo` 担任入门前测
- **Weekly In-Class Activity**：每章配 1 个 90 分钟活动（写入模块 exercises/）
- **Practice Exam**：每单元一份模拟卷（capstone 前置）
- **Projects**：每单元末 capstone（沿用我们已有的 rubric 制度）

## 4. Crosswalk · 单元↔矩阵交叉表（双视图互通）

| Unit | 覆盖矩阵格 | 主要画像 |
|---|---|---|
| Unit 1 | B-L1/L2 · D-L2 · C-L1 | P1 全修；P2 选 1.6–1.8 |
| Unit 2 | D-L2/L3 · E-L1/L2 | P2 全修；P3 选 2.4–2.8 |
| Unit 3 | A-L2/L3 | P3/P4 |
| Unit 4 | F · E-L2/L3 · B-L3 | P3 全修；P4 选 4.7–4.8 |

## 5. Gap audit（其分类暴露的空缺 = 我们的原创清单）

他们的分类像一面镜子，照出 posit::conf 素材（会议工作坊基因）**不覆盖学期课刚需**的
五处空白：**JSON/APIs、Web Scraping、plotly 交互、gganimate 动画、leaflet 地图**，
外加 Code Speed 半空白。这 5.5 章就是我们 100% 原创内容的机会清单——市面上恰好
也缺用现代栈（Positron+Quarto+AI 线）写的这些章节。
