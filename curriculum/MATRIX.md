# Competency Matrix · 能力矩阵（课程骨架与素材映射）

> 本矩阵是课程的**分类核心**：5 个能力域 × 3 个水平，把 27 个上游仓库（三届 posit::conf
> 材料）全部归位，并标注每个格子要写的**原创单元**与**压轴项目**。
> 约定：一个仓库可跨格出现（工作坊本身是综合体）；`※` = 该格主力素材。

## 图例

- `L1 奠基`（记忆·理解·应用）→ `L2 实践`（应用·分析）→ `L3 工程师`（评价·创造）
- 原创单元命名：`<层级>-<域><序号>-<slug>`，如 `L2-D2-pub-ready-reports`
- `(镜)` = 已镜像于 `content/en/`；`(链)` = 上游链接见 ARCHIVE-CATALOG.md

---

## A · 计算与工具 Compute & Tooling
*会配环境、会写代码、会自我排错、能治理生产环境*

| | L1 奠基 | L2 实践 | L3 工程师 |
|---|---|---|---|
| **上游素材** | r-programming(+exercises)※(链) · positron※(镜) | modern-r-workflow※(镜) | r-in-production(链) · reproducible-environments(链) |
| **原创单元** | **L1-A1-first-repo**（R+Positron+第一个项目，已建示例） | L2-A1-modern-workflow（AI 反馈循环+AGENTS.md） | L3-A1-prod-environments（快照/锁/验证） |
| **压轴项目** | 端到端跑通并发布一个分析 | 为真实项目写 AGENTS.md 并量化 AI 提效 | 搭建可审计的团队 R 环境 |

## B · 数据获取与加工 Data Engineering
*能把脏数据变成可信分析表，小到 CSV 大到分布式*

| | L1 | L2 | L3 |
|---|---|---|---|
| **上游素材** | r-programming 数据结构部分(链) | databases(DuckDB)※(链) · arrow(链) · modern-ds-python 的 Polars(镜) | arrow 高阶(链) · databricks(备查) |
| **原创单元** | L1-B1-import-clean（导入·清洗·整洁数据） | L2-B1-beyond-csv（SQL/Arrow/列存思维） | L3-B1-data-pipelines（大数据管线设计） |
| **压轴项目** | 清洗一份真实脏数据集 | DuckDB+Arrow 重写一条慢查询并基准测试 | 设计 PB 级取数管线的决策文档 |

## C · 分析与推断 Analysis & Inference
*从描述到预测到因果，知道每种结论的证据边界*

| | L1 | L2 | L3 |
|---|---|---|---|
| **上游素材** | r-programming 统计部分(链) | tidymodels※(链) · scikit-learn(链) | causal※(链) |
| **原创单元** | L1-C1-eda-intuition（描述统计+图形直觉） | L2-C1-modeling-workflow（重抽样/调参/评估） | L3-C1-causal-inference（因果设计与敏感性分析） |
| **压轴项目** | 一份 EDA 报告 | 一份含模型比较的建模报告（Quarto 渲染） | 一份因果分析的评审式答辩 |

## D · 沟通与出版 Communication & Publishing
*图表、表格、文档——让别人看懂并信任你的结果*

| | L1 | L2 | L3 |
|---|---|---|---|
| **上游素材** | quarto-intro(链) | practical-quarto(+exercises)※(镜) · quarto-brand(链) · ggplot2※(链) · great-tables(镜) | quarto-extend(+exercises)(链) |
| **原创单元** | L1-D1-first-quarto（第一个可复现报告） | **L2-D2-pub-ready-reports**（品牌/模板/Typst）· L2-D1-ggplot2-mastery | L3-D1-quarto-extensions（Lua/过滤器开发） |
| **压轴项目** | R Markdown→Quarto 迁移一份旧报告 | 出版级「brand+partials+Typst」三件套 | 写一个团队可复用的 Quarto 扩展 |

## E · 交付与治理 Delivery & Governance
*把分析变成应用与服务，并对其质量负责（含受监管场景）*

| | L1 | L2 | L3 |
|---|---|---|---|
| **上游素材** | shiny-r※(链) · shiny-py(MIT)(链) | level-up-shiny(链) · llms 的 shinychat/querychat(镜) | vetiver(链) · pharmaverse※(镜) · r-pharma-regulated(镜) |
| **原创单元** | L1-E1-first-shiny（第一个交互应用） | L2-E1-shiny-in-anger（模块化/golem/性能） | **L3-E2-clinical-reporting**（SDTM→ADaM→TFL）· L3-E1-mlops（vetiver 上线） |
| **压轴项目** | 一个部署上线的迷你应用 | 重构一个失控的 Shiny 应用 | 跑通带验证痕迹的临床报告链路 |

---

## F · AI 增强实践（横切线索，织入而非单列）

| 织入点 | 所用素材 | 说明 |
|---|---|---|
| L1 各模块「报错自救」 | positron AI Client(镜) | 第一次报错就教「问 AI 前先读报错」 |
| L1-A/L2-A 反馈循环 | modern-r-workflow 模块 03–07(镜) | AGENTS.md、skills、人机协作规范 |
| L2-D 讲义协作 | practical-quarto 模块 01(镜) | Air 格式化 + LLM 辅助写作 |
| **L2-F 独立短课程** | llms 全仓(镜)：ellmer/chatlas、structured output、agents、skills、RAG、MCP | 差异化主打；练习梯度直接沿用 `_exercises` 重编 |
| L3-E 受监管 AI | r-pharma-regulated AI 节(镜) | AI 在 GxP 下的边界 |

## 画像 → 矩阵路径

```
P1 小林   : L1-A1→L1-B1→L1-D1→L1-C1→L2-B1→L2-D2
P2 陈医生 : （免修 L1 前半）L1-D1→L1-C1→L2-D1→L2-D2        ← 报告与出版直达
P3 阿伟   : L2-A1→L2-F→L2-E1→L3-A1                          ← 现代栈+AI 主线
P4 老周   : L1-A1 快速通道→L2-C1→L2-E1→L3-E2                 ← 合规临床主线
```

## 空缺审计（诚实声明）

以下格子**上游没有现成素材**，必须 100% 原创或外部补充：
- L1-B1（真实脏数据清洗——需自建数据集）
- L2-C1 的医学统计桥接（tidymodels 无临床示例——我们的差异化机会）
- L3-B1（生态里缺系统化大数据课程）
