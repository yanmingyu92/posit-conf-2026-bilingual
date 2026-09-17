# 全书代码 QA 报告

验证日期：2026-09-17。范围：28 章，134 个静态 `r` 围栏（含四反引号 Markdown 示例内部的 R 围栏）。2.8 章没有 R 围栏。

## 方法与结果边界

- 先提取、编号与分类，再按章启动全新 R 4.6.0 进程；章内按顺序执行。每块 60 秒，动画 240 秒；章级进程上限 900 秒。
- 使用独立临时 R 库；CRAN 二进制安装成功，`polite` 二进制及源码安装均不可用，明确跳过。包由 R 4.6.1 构建的版本警告未影响已执行结果。
- 普通 ggplot 强制绘制以触发延迟错误；Shiny/HTML/profvis 对象不自动打开窗口。动画原示例 GIF/MP4 实际导出，并另测 7 种转场/残影变体。地图验证对象构建与 HTML 导出，未验证浏览器瓦片加载。
- `.qa/runs/` 保存每块源码、分类、逐块日志和结果。survey CSV 夹具含 2011–2014 年及 score 列；不存在的 2099 文件保持不存在。包开发/renv 在独立临时项目运行，未修改用户项目。
- 31/32/48 的包项目验证使用 `scripts/qa_book_projects.R`；已装包不重复安装，关闭自动打开 IDE/浏览器。快照先建立基线再复跑，coverage HTML 成功生成。IDE active-file 两行仍需人工验证。
- 01 与 27 的定向检查验证实际数值和 iris 模块输出；AI 章节对照本地工作坊 `_solutions`/`_exercises`，并核对已安装 ellmer 0.5.0 方法。未配置常见 LLM 凭据；不调用模型、不输出凭据。
- `OK` 代表该块在注明的上下文中执行成功；仅定义函数的块不意味着所有函数体均被调用。API 跳过不等于端到端通过。

结果：105 块 OK；2 块预期报错验证；2 块主体通过、IDE 行未执行；25 块跳过。未解决的执行失败：0。

## 逐章矩阵

| 章 | 块数 | OK | 预期报错 | 修改块数 | 部分/跳过及原因 |
|---|---:|---:|---:|---:|---|
| [01](chapters/01-functions.qmd) | 4 | 4 | 0 | 2 | 无 |
| [12](chapters/12-iteration.qmd) | 8 | 8 | 0 | 2 | 无 |
| [13](chapters/13-efficient-code.qmd) | 8 | 8 | 0 | 3 | 无 |
| [14](chapters/14-json-apis.qmd) | 7 | 5 | 0 | 3 | 14:06 SKIPPED-API; 14:07 SKIPPED-API |
| [15](chapters/15-web-scraping.qmd) | 4 | 3 | 0 | 0 | 15:04 SKIPPED-PKG |
| [16](chapters/16-great-tables.qmd) | 5 | 5 | 0 | 1 | 无 |
| [17](chapters/17-alt-geoms.qmd) | 6 | 6 | 0 | 1 | 无 |
| [18](chapters/18-styled-plots.qmd) | 8 | 8 | 0 | 3 | 无 |
| [21](chapters/21-interactive-graphics.qmd) | 4 | 4 | 0 | 0 | 无 |
| [22](chapters/22-animation.qmd) | 8 | 8 | 0 | 3 | 无 |
| [23](chapters/23-dashboards-static.qmd) | 7 | 7 | 0 | 0 | 无 |
| [24](chapters/24-dashboards-dynamic.qmd) | 5 | 5 | 0 | 0 | 无 |
| [25](chapters/25-maps-leaflet.qmd) | 8 | 8 | 0 | 0 | 无 |
| [26](chapters/26-ggplot-extensions.qmd) | 4 | 3 | 1 | 4 | 无 |
| [27](chapters/27-shiny-reactive.qmd) | 6 | 5 | 0 | 2 | 27:05 SKIPPED-CONTEXT |
| [28](chapters/28-pub-ready-reports.qmd) | 0 | 0 | 0 | 0 | 无 |
| [31](chapters/31-pkg-structure.qmd) | 4 | 4 | 0 | 1 | 无 |
| [32](chapters/32-unit-testing.qmd) | 5 | 3 | 0 | 1 | 32:03 PARTIAL-IDE; 32:05 PARTIAL-IDE |
| [33](chapters/33-debugging.qmd) | 4 | 1 | 1 | 1 | 33:03 SKIPPED-CONTEXT; 33:04 SKIPPED-CONTEXT |
| [34](chapters/34-code-speed.qmd) | 7 | 5 | 0 | 2 | 34:06 SKIPPED-CONTEXT; 34:07 SKIPPED-CONTEXT |
| [41](chapters/41-llm-basics.qmd) | 3 | 0 | 0 | 3 | 41:01 SKIPPED-API; 41:02 SKIPPED-API; 41:03 SKIPPED-API |
| [42](chapters/42-structured-output.qmd) | 5 | 0 | 0 | 1 | 42:01 SKIPPED-API; 42:02 SKIPPED-API; 42:03 SKIPPED-API; 42:04 SKIPPED-API; 42:05 SKIPPED-API |
| [43](chapters/43-agents.qmd) | 3 | 0 | 0 | 2 | 43:01 SKIPPED-API; 43:02 SKIPPED-API; 43:03 SKIPPED-API |
| [44](chapters/44-skills.qmd) | 1 | 0 | 0 | 1 | 44:01 SKIPPED-API |
| [45](chapters/45-rag-mcp.qmd) | 2 | 0 | 0 | 1 | 45:01 SKIPPED-API; 45:02 SKIPPED-API |
| [46](chapters/46-shinychat.qmd) | 3 | 0 | 0 | 2 | 46:01 SKIPPED-API; 46:02 SKIPPED-API; 46:03 SKIPPED-API |
| [47](chapters/47-clinical-reporting.qmd) | 3 | 3 | 0 | 1 | 无 |
| [48](chapters/48-regulated-gxp.qmd) | 2 | 2 | 0 | 0 | 无 |

修改块数统计源码发生变化的块（包括补依赖、澄清注释和拆分故意错误示例），不是独立缺陷数量。12:01 为故意的年份复制逻辑错误，夹具断言验证重复年份后计入 OK。

## 修复清单

- 01/12/13：补完整函数体、数据与依赖；纠正词法作用域说明；循环 benchmark 显式返回结果。
- 14：修正 bearer 方法名、错误检查调用；ReqRes 现需 API key，避免虚构免密钥保证。Open-Meteo 的字符串 `"true"` 保持并实测通过。
- 16/17/18：补 tidyr/dplyr 引用，修正 thematic 的 `fg` 参数与图注样本量/结论。
- 22：添加 country 分组，GIF/MP4 显式判断 gifski/av；缺后端提供说明或逐帧输出。
- 26/27：修正 facet_zoom 参数和 patchwork 依赖；故意错误移入独立块；Shiny 模块列选择随输入数据变化。
- 31/32/34：填全 roxygen 函数体并修正文档语法；factor 断言保持类型/levels；benchmark 成绩范围与边界一致，rowwise 结果解除分组后保持默认一致性检查。
- 33：保留调试错误，仅把预期输出说明改成实际 tibble 越界错误。
- 41–46：统一 chat_posit / set_system_prompt / chat_structured；删除未经证实的方法；修正 vitals solver_chat、工具注册和编辑器接线；gregexpr 零匹配判断通过夹具回归。
- 47：8 行 clinical tribble 与 admiral/cards/gtsummary 实测成功，AGE/BMIBL 显式设为连续变量。

发生修改的代码块位置（最终文件行号）：

- `01:02` — `book/chapters/01-functions.qmd:84`
- `01:03` — `book/chapters/01-functions.qmd:115`
- `12:01` — `book/chapters/12-iteration.qmd:37`
- `12:06` — `book/chapters/12-iteration.qmd:152`
- `13:02` — `book/chapters/13-efficient-code.qmd:52`
- `13:03` — `book/chapters/13-efficient-code.qmd:64`
- `13:04` — `book/chapters/13-efficient-code.qmd:93`
- `14:05` — `book/chapters/14-json-apis.qmd:139`
- `14:06` — `book/chapters/14-json-apis.qmd:158`
- `14:07` — `book/chapters/14-json-apis.qmd:181`
- `16:01` — `book/chapters/16-great-tables.qmd:57`
- `17:05` — `book/chapters/17-alt-geoms.qmd:163`
- `18:01` — `book/chapters/18-styled-plots.qmd:49`
- `18:06` — `book/chapters/18-styled-plots.qmd:174`
- `18:08` — `book/chapters/18-styled-plots.qmd:202`
- `22:01` — `book/chapters/22-animation.qmd:60`
- `22:06` — `book/chapters/22-animation.qmd:156`
- `22:07` — `book/chapters/22-animation.qmd:175`
- `26:01` — `book/chapters/26-ggplot-extensions.qmd:59`
- `26:02` — `book/chapters/26-ggplot-extensions.qmd:88`
- `26:03` — `book/chapters/26-ggplot-extensions.qmd:107`
- `26:04` — `book/chapters/26-ggplot-extensions.qmd:146`
- `27:01` — `book/chapters/27-shiny-reactive.qmd:49`
- `27:04` — `book/chapters/27-shiny-reactive.qmd:136`
- `31:04` — `book/chapters/31-pkg-structure.qmd:144`
- `32:01` — `book/chapters/32-unit-testing.qmd:55`
- `33:02` — `book/chapters/33-debugging.qmd:106`
- `34:01` — `book/chapters/34-code-speed.qmd:43`
- `34:02` — `book/chapters/34-code-speed.qmd:80`
- `41:01` — `book/chapters/41-llm-basics.qmd:47`
- `41:02` — `book/chapters/41-llm-basics.qmd:66`
- `41:03` — `book/chapters/41-llm-basics.qmd:125`
- `42:05` — `book/chapters/42-structured-output.qmd:165`
- `43:01` — `book/chapters/43-agents.qmd:38`
- `43:03` — `book/chapters/43-agents.qmd:144`
- `44:01` — `book/chapters/44-skills.qmd:92`
- `45:01` — `book/chapters/45-rag-mcp.qmd:80`
- `46:01` — `book/chapters/46-shinychat.qmd:52`
- `46:02` — `book/chapters/46-shinychat.qmd:120`
- `47:03` — `book/chapters/47-clinical-reporting.qmd:146`

## 逐块证据

| ID | 分类 | 结果 | 最终行 | 限制/错误详情 |
|---|---|---|---:|---|
| 01:01 | NEEDS-PKG | OK | 57 | — |
| 01:02 | NEEDS-PKG | OK | 84 | — |
| 01:03 | RUNNABLE | OK | 115 | — |
| 01:04 | RUNNABLE | OK | 133 | — |
| 12:01 | INTENTIONALLY-BROKEN | OK | 37 | Wrong-year copy/paste example: verify duplicated data, not an exception. |
| 12:02 | NEEDS-PKG | OK | 73 | — |
| 12:03 | RUNNABLE | OK | 101 | — |
| 12:04 | RUNNABLE | OK | 122 | — |
| 12:05 | NEEDS-PKG | OK | 132 | — |
| 12:06 | NEEDS-PKG | OK | 152 | — |
| 12:07 | NEEDS-PKG | OK | 166 | — |
| 12:08 | DEPENDS-ON-FILES | OK | 189 | Minimal survey/scorekit fixture documented in runner. |
| 13:01 | RUNNABLE | OK | 38 | — |
| 13:02 | RUNNABLE | OK | 52 | — |
| 13:03 | NEEDS-PKG | OK | 64 | — |
| 13:04 | NEEDS-PKG | OK | 93 | — |
| 13:05 | RUNNABLE | OK | 130 | — |
| 13:06 | NEEDS-PKG | OK | 160 | — |
| 13:07 | RUNNABLE | OK | 191 | — |
| 13:08 | RUNNABLE | OK | 224 | — |
| 14:01 | NEEDS-PKG | OK | 50 | — |
| 14:02 | NEEDS-PKG | OK | 70 | — |
| 14:03 | NEEDS-PKG | OK | 89 | — |
| 14:04 | NEEDS-NETWORK | OK | 101 | — |
| 14:05 | NEEDS-NETWORK | OK | 139 | — |
| 14:06 | NEEDS-API | SKIPPED-API | 158 | Credential template uses example.com; never transmit credentials to placeholder host. |
| 14:07 | NEEDS-API | SKIPPED-API | 181 | REQRES_API_KEY absent; authenticated third-party pagination reviewed statically. |
| 15:01 | RUNNABLE | OK | 48 | — |
| 15:02 | NEEDS-PKG | OK | 69 | — |
| 15:03 | RUNNABLE | OK | 86 | — |
| 15:04 | NEEDS-NETWORK | SKIPPED-PKG | 141 | there is no package called 'polite' |
| 16:01 | NEEDS-PKG | OK | 57 | — |
| 16:02 | NEEDS-PKG | OK | 92 | — |
| 16:03 | RUNNABLE | OK | 125 | — |
| 16:04 | RUNNABLE | OK | 146 | — |
| 16:05 | RUNNABLE | OK | 182 | — |
| 17:01 | NEEDS-PKG | OK | 56 | — |
| 17:02 | NEEDS-PKG | OK | 81 | — |
| 17:03 | NEEDS-PKG | OK | 107 | — |
| 17:04 | NEEDS-PKG | OK | 139 | — |
| 17:05 | NEEDS-PKG | OK | 163 | — |
| 17:06 | NEEDS-PKG | OK | 196 | — |
| 18:01 | NEEDS-PKG | OK | 49 | — |
| 18:02 | NEEDS-PKG | OK | 76 | — |
| 18:03 | RUNNABLE | OK | 104 | — |
| 18:04 | RUNNABLE | OK | 117 | — |
| 18:05 | RUNNABLE | OK | 148 | — |
| 18:06 | NEEDS-PKG | OK | 174 | — |
| 18:07 | RUNNABLE | OK | 195 | — |
| 18:08 | NEEDS-PKG | OK | 202 | — |
| 21:01 | NEEDS-PKG | OK | 60 | — |
| 21:02 | NEEDS-PKG | OK | 88 | — |
| 21:03 | NEEDS-PKG | OK | 119 | — |
| 21:04 | NEEDS-PKG | OK | 144 | — |
| 22:01 | NEEDS-PKG | OK | 60 | — |
| 22:02 | RUNNABLE | OK | 95 | — |
| 22:03 | NEEDS-PKG | OK | 107 | — |
| 22:04 | RUNNABLE | OK | 132 | — |
| 22:05 | RUNNABLE | OK | 143 | — |
| 22:06 | RUNNABLE | OK | 156 | — |
| 22:07 | RUNNABLE | OK | 175 | — |
| 22:08 | RUNNABLE | OK | 207 | — |
| 23:01 | NEEDS-PKG | OK | 64 | — |
| 23:02 | RUNNABLE | OK | 69 | — |
| 23:03 | RUNNABLE | OK | 101 | — |
| 23:04 | RUNNABLE | OK | 111 | — |
| 23:05 | RUNNABLE | OK | 118 | — |
| 23:06 | RUNNABLE | OK | 143 | — |
| 23:07 | NEEDS-PKG | OK | 165 | — |
| 24:01 | NEEDS-PKG | OK | 83 | — |
| 24:02 | RUNNABLE | OK | 93 | — |
| 24:03 | RUNNABLE | OK | 103 | — |
| 24:04 | RUNNABLE | OK | 112 | — |
| 24:05 | RUNNABLE | OK | 122 | — |
| 25:01 | RUNNABLE | OK | 44 | — |
| 25:02 | NEEDS-PKG | OK | 64 | — |
| 25:03 | RUNNABLE | OK | 85 | — |
| 25:04 | RUNNABLE | OK | 103 | — |
| 25:05 | RUNNABLE | OK | 127 | — |
| 25:06 | NEEDS-PKG | OK | 154 | — |
| 25:07 | RUNNABLE | OK | 185 | — |
| 25:08 | NEEDS-PKG | OK | 210 | — |
| 26:01 | NEEDS-PKG | OK | 59 | — |
| 26:02 | NEEDS-PKG | OK | 88 | — |
| 26:03 | INTENTIONALLY-BROKEN | EXPECTED-ERROR | 107 | Can't add `scales::label_percent()` to a <ggplot> object i Did you forget to add parentheses, as in `scales::label_percent()()`? |
| 26:04 | NEEDS-PKG | OK | 146 | — |
| 27:01 | NEEDS-PKG | OK | 49 | — |
| 27:02 | RUNNABLE | OK | 88 | — |
| 27:03 | RUNNABLE | OK | 116 | — |
| 27:04 | NEEDS-PKG | OK | 136 | — |
| 27:05 | DEPENDS-ON-FILES | SKIPPED-CONTEXT | 192 | Interactive IDE/project lifecycle example; static review only; no user project mutated. |
| 27:06 | NEEDS-PKG | OK | 213 | — |
| 31:01 | DEPENDS-ON-FILES | OK | 56 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 31:02 | RUNNABLE | OK | 65 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 31:03 | DEPENDS-ON-FILES | OK | 113 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 31:04 | RUNNABLE | OK | 144 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 32:01 | DEPENDS-ON-FILES | OK | 55 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 32:02 | DEPENDS-ON-FILES | OK | 89 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 32:03 | DEPENDS-ON-FILES | PARTIAL-IDE | 107 | Isolated project fixture; see scripts/qa_book_projects.R. IDE active-file command not executed. |
| 32:04 | DEPENDS-ON-FILES | OK | 127 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 32:05 | DEPENDS-ON-FILES | PARTIAL-IDE | 148 | Isolated project fixture; see scripts/qa_book_projects.R. IDE active-file command not executed. |
| 33:01 | RUNNABLE | OK | 85 | Function definition evaluated; interactive browser breakpoint not invoked. |
| 33:02 | INTENTIONALLY-BROKEN | EXPECTED-ERROR | 106 | Can't extract columns past the end. i Location 99 doesn't exist. i There are only 8 columns. |
| 33:03 | DEPENDS-ON-FILES | SKIPPED-CONTEXT | 137 | Unspecified exercise functions/data; no invented implementations. |
| 33:04 | DEPENDS-ON-FILES | SKIPPED-CONTEXT | 152 | Unspecified exercise functions/data; no invented implementations. |
| 34:01 | NEEDS-PKG | OK | 43 | — |
| 34:02 | NEEDS-PKG | OK | 80 | — |
| 34:03 | DEPENDS-ON-FILES | OK | 93 | Minimal survey/scorekit fixture documented in runner. |
| 34:04 | RUNNABLE | OK | 120 | — |
| 34:05 | NEEDS-PKG | OK | 136 | — |
| 34:06 | DEPENDS-ON-FILES | SKIPPED-CONTEXT | 173 | Requires learner scorekit package / scores_big.csv or heavy_parse implementation. |
| 34:07 | DEPENDS-ON-FILES | SKIPPED-CONTEXT | 197 | Requires learner scorekit package / scores_big.csv or heavy_parse implementation. |
| 41:01 | NEEDS-API | SKIPPED-API | 47 | No configured LLM credentials; upstream static review; no provider request executed. |
| 41:02 | NEEDS-API | SKIPPED-API | 66 | No configured LLM credentials; upstream static review; no provider request executed. |
| 41:03 | NEEDS-API | SKIPPED-API | 125 | No configured LLM credentials; upstream static review; no provider request executed. |
| 42:01 | NEEDS-API | SKIPPED-API | 40 | No configured LLM credentials; upstream static review; no provider request executed. |
| 42:02 | NEEDS-API | SKIPPED-API | 80 | No configured LLM credentials; upstream static review; no provider request executed. |
| 42:03 | NEEDS-API | SKIPPED-API | 97 | No configured LLM credentials; upstream static review; no provider request executed. |
| 42:04 | NEEDS-API | SKIPPED-API | 137 | No configured LLM credentials; upstream static review; no provider request executed. |
| 42:05 | NEEDS-API | SKIPPED-API | 165 | No configured LLM credentials; upstream static review; no provider request executed. |
| 43:01 | NEEDS-API | SKIPPED-API | 38 | No configured LLM credentials; upstream static review; no provider request executed. |
| 43:02 | NEEDS-API | SKIPPED-API | 93 | No configured LLM credentials; upstream static review; no provider request executed. |
| 43:03 | NEEDS-API | SKIPPED-API | 144 | No configured LLM credentials; upstream static review; no provider request executed. |
| 44:01 | NEEDS-API | SKIPPED-API | 92 | No configured LLM credentials; upstream static review; no provider request executed. |
| 45:01 | NEEDS-API | SKIPPED-API | 80 | No configured LLM credentials; upstream static review; no provider request executed. |
| 45:02 | NEEDS-API | SKIPPED-API | 139 | No configured LLM credentials; upstream static review; no provider request executed. |
| 46:01 | NEEDS-API | SKIPPED-API | 52 | No configured LLM credentials; upstream static review; no provider request executed. |
| 46:02 | NEEDS-API | SKIPPED-API | 120 | No configured LLM credentials; upstream static review; no provider request executed. |
| 46:03 | NEEDS-API | SKIPPED-API | 219 | No configured LLM credentials; upstream static review; no provider request executed. |
| 47:01 | NEEDS-PKG | OK | 71 | — |
| 47:02 | NEEDS-PKG | OK | 108 | — |
| 47:03 | NEEDS-PKG | OK | 146 | — |
| 48:01 | DEPENDS-ON-FILES | OK | 91 | Isolated project fixture; see scripts/qa_book_projects.R. |
| 48:02 | RUNNABLE | OK | 107 | Isolated project fixture; see scripts/qa_book_projects.R. |

## AI 静态 API 证据

路径相对于上游 `learn-posit-conf-2026/llms/`；与本机安装的 ellmer 0.5.0 导出/Chat 方法交叉核对。

| 章 | 权威工作坊源码 |
|---|---|
| 41 | `_solutions/02_conversation/02_conversation.R`、`10_structured-output/10_structured-output.R`、`24_shinychat-1/_agent.R` |
| 42 | `_solutions/10_structured-output/`、`11_parallel/11_parallel.R`、`15_evals/15_evals.R` 与 `_cases.R`、`17_quiz-game-2/` |
| 43 | `_solutions/17_quiz-game-2/17_quiz-game-2-app.R`、`19_agent-1/19_agent-1.R`、`20_agent-2/20_agent-2.R` |
| 44 | `_solutions/21_skills-1/21_skills-1.R` 与 `_tools.R`、`22_skills-2/` |
| 45 | `_solutions/51_rag/51_rag.R` |
| 46 | `_solutions/24_shinychat-1/24_shinychat-1-app.R`、`25_shinychat-2/25_shinychat-2-app.R`、`26_querychat/26_querychat.R` |

`scripts/qa_book_ai.R` 已验证 17 块语法、42:02 schema、43:01 工具定义与 43:03 文本替换的唯一/零/重复匹配边界。为避免将局部离线验证误称端到端通过，主矩阵仍保留整块 SKIPPED-API。

## 需人工判断或补充环境

- 14:06 是凭据/示例域模板；14:07 缺 REQRES_API_KEY，未向 ReqRes 发认证请求。15:04 缺 polite。
- 27:05 需真实 myapp 与交互式 reactlog；32:03/05 的 IDE 当前文件命令未执行。
- 33:03/04 的 scores/clean_scores/step_* 业务实现未提供；34:06/07 需 scores_big.csv、已安装 scorekit 或 heavy_parse，未杜撰实现。33:01 仅定义 browser 调试函数。
- 41–46 未验证模型可用性、费用、真实输出、工具循环和浏览器交互；45 需 LM Studio 嵌入服务。离线 schema/工具定义及文本替换边界已验证，但不替代线上请求。
- 46 引用工作坊 `_agent.R`，其 edit_file 仍有上游零匹配判断问题；本书 43 已修复。未改上游仓库，也未将教学工具描述为生产级文件沙箱。

## 复跑

先设置 `QA_R_LIB` 为独立测试库并安装依赖，再依次运行：

```text
Rscript scripts/qa_book_install.R
Rscript scripts/qa_book_projects.R
python scripts/qa_book.py --rscript <Rscript绝对路径> --library <测试库>
Rscript scripts/qa_book_focused.R
Rscript scripts/qa_book_ai.R
python scripts/qa_book_report.py
python scripts/qa_book_structure.py
```

报告由实际 `.qa/results.json` 与当前章节位置生成；原始临时产物不纳入版本控制。
