# 多中心数据质量与分析交付 · Analysis Handoff

作者：**Jaime Yan**。原创综合实验，建议 90–120 分钟；需要 R ≥ 4.1，使用 base R，无额外包依赖。

你是分析交付负责人。三个中心提交了一份质量评分观测表，接收方要求：能够追踪哪些行被排除、清楚解释均值分母，并在全新 R 会话中重建图与汇总表。业务团队可把中心理解为门店或运营站点；研究分析人员可将此作为多中心数据接收与质量核查的技术练习。

**数据全部人工构造。quality_score 是模拟业务质量评分，不是临床终点、患者记录或治疗效果。图形仅作描述，中心均值差异不能解释为因果或疗效差异。**

## 文件与数据契约

| 文件 | 用途 |
|---|---|
| `synthetic-observations.csv` | 31 行人工模拟输入，含 1 行完全重复、2 行越界值、3 行缺失评分 |
| `starter.R` | 可直接执行的初始检查与待实现函数接口 |
| `solution.R` | 可直接运行的参考交付实现 |
| `check.R` | 验收脚本，可对参考解答或你自己的实现执行 |

输入列顺序为 `record_id, site, observed_on, quality_score`。ID 为 `SYN` 前缀人工编号；site 必须为 North、Central、South；日期严格采用 `YYYY-MM-DD`；评分为 0–100（**包含两端**），空值表示缺失。

本实验采用以下明确规则：

1. 缺列/列顺序变化、缺 ID、未知中心、非法日期及非数值评分让导入失败，并给出可定位的错误。
2. 完全相同的重复 ID 只保留第一行；同一 ID 若内容冲突，应停止并请求数据责任人裁定。不能静默挑一个版本。
3. 越界值排除并记录原因；缺失评分的记录保留，计入 `n_records` 与 `n_missing`，不计入均值分母 `n_observed`。
4. 始终输出三个中心；无记录或评分全缺失时，均值和中位数为 `NA`，不能伪装成零。
5. 审计表 `source_row` 按输入数据行计数（不含 CSV 表头），每一输入行均对应一个处置记录。

## Copy → Adapt → Create

**前 60 分钟禁用 AI，也不要打开 solution.R。** 可以查询 R 内置帮助；先写预期，再运行检查。

1. **Copy，15 分钟**：运行 starter，检查列与类型。手写评分 0、100、空值、-1、101 各应如何处置；解释为什么读入时先保留字符类型。定位一个重复 ID。
2. **Adapt，30 分钟**：在你自己的 `learner.R` 中实现 starter 的四个函数。按规则导入、清洗并汇总，保证 `n_records = n_observed + n_missing`。保留原始数据，输出逐行审计；对内容冲突的重复 ID 返回错误。
3. **Create，30–45 分钟**：完成 `run_handoff(input, output_dir)`；输出汇总 CSV、审计 CSV、一张标明观测数与缺失数的图。图必须写明模拟数据性质。写一页交付说明：数据契约、排除理由、分母、可复跑命令、限制。
4. **开放 AI 审阅，15 分钟**：先保存自己的版本与检查结果，再让 AI 找边界漏洞。记录一条真实发现及验证证据；若没有发现，也应如实记录。不能只提交 AI 的意见文本。

## 从仓库根目录运行

Windows PowerShell 下若 `Rscript` 不在 PATH，可将命令替换为本机 Rscript.exe 的完整路径。

```powershell
Rscript training/analysis-handoff/starter.R
Rscript training/analysis-handoff/solution.R .qa/analysis-handoff
Rscript training/analysis-handoff/check.R .qa/analysis-handoff-check
```

检查自己的实现：

```powershell
Rscript training/analysis-handoff/check.R .qa/analysis-handoff-learner training/analysis-handoff/learner.R
```

`learner.R` 应只定义四个函数，或用 `if (sys.nframe() == 0L)` 保护直接运行入口；被 `source()` 时不启动交付流程。四个函数的参数与返回结构沿用 starter/solution 契约：清洗返回 `list(data, audit)`；汇总列为 `site, n_records, n_observed, n_missing, mean_score, median_score`；审计处置值为 `retained, exact_duplicate, out_of_range`。

运行产物是 `site-summary.csv`、`row-audit.csv`、`site-quality.png`，写入指定 `.qa/` 子目录。正式提交你的函数源码、一页交付说明和验收结果；图表从输出目录取用，勿覆盖模拟输入。

## 验收与评分

本数据清洗后应保留 28 行，25 个评分可用于均值；North/Central/South 的有效评分数分别为 7/9/9。中心均值分别为 50、530/9、485/9。自动检查还覆盖：0 与 100 保留、全缺失中心、空数据、冲突重复、非法数值、非法日期、未知中心及导出回读。

| 维度 | 达到：1 分 | 良好：2 分 | 卓越：3 分 |
|---|---|---|---|
| 输入与边界 | 常规输入可导入 | 必检边界全部通过 | 错误信息能定位问题并有新增有效边界证据 |
| 清洗可追踪 | 排除与汇总结果正确 | 每行处置可追溯、分母清楚 | 冲突规则与变更影响有清晰解释 |
| 函数与复跑 | 四个函数可运行 | 新 R 会话一条命令重建产物 | 输出路径可配置、无隐藏对象依赖 |
| 交付表达 | CSV 与图齐全 | 模拟性质、缺失数、分母标注清楚 | 接收人无需口头补充即可复跑并理解限制 |

总分 12，达到建议为每项至少 1 分且验收通过；评价重点是可解释与可追踪，不是图形复杂度。自动验收不是对真实生产数据规则的穷尽证明。

## 延伸（可选，不影响核心验收）

增加一个新中心或第二批文件时，先列出哪些契约应配置化；设计两条防止跨批重复累积的测试。临床/制药读者可以讨论实际数据流程还需要哪些独立审批与追溯信息，但不要把模拟评分换名成疗效变量后进行疗效推断。
