"""Build the code QA report from actual run evidence under .qa/."""
import collections
import json
from pathlib import Path
import re
import subprocess
from qa_book import extract, ROOT, QA

inventory = extract()
results = {r['id']: r for r in json.loads((QA/'results.json').read_text(encoding='utf-8'))}
assert set(results) == {b['id'] for b in inventory}, 'Incomplete block coverage'
assert not any(r['status'].startswith('FAIL') for r in results.values()), 'Unresolved failures'
baseline_file = QA/'code-fixes.json'
if baseline_file.exists():
    fixed = json.loads(baseline_file.read_text(encoding='utf-8'))
else:
    fixed = []
    for block in inventory:
        original = subprocess.check_output(['git','show',f"HEAD:{block['file']}"],cwd=ROOT).decode('utf-8')
        old_blocks = re.findall(r'^```r[^\S\n]*\n(.*?)^```[^\S\n]*$',original,re.M|re.S)
        if block['code'] not in old_blocks:
            fixed.append(block['id'])
    baseline_file.write_text(json.dumps(fixed),encoding='utf-8')
counts = collections.Counter(r['status'] for r in results.values())
lines = ['# 全书代码 QA 报告', '', '验证日期：2026-09-17。范围：28 章，134 个静态 `r` 围栏（含四反引号 Markdown 示例内部的 R 围栏）。2.8 章没有 R 围栏。', '',
         '## 方法与结果边界', '',
         '- 先提取、编号与分类，再按章启动全新 R 4.6.0 进程；章内按顺序执行。每块 60 秒，动画 240 秒；章级进程上限 900 秒。',
         '- 使用独立临时 R 库；CRAN 二进制安装成功，`polite` 二进制及源码安装均不可用，明确跳过。包由 R 4.6.1 构建的版本警告未影响已执行结果。',
         '- 普通 ggplot 强制绘制以触发延迟错误；Shiny/HTML/profvis 对象不自动打开窗口。动画原示例 GIF/MP4 实际导出，并另测 7 种转场/残影变体。地图验证对象构建与 HTML 导出，未验证浏览器瓦片加载。',
         '- `.qa/runs/` 保存每块源码、分类、逐块日志和结果。survey CSV 夹具含 2011–2014 年及 score 列；不存在的 2099 文件保持不存在。包开发/renv 在独立临时项目运行，未修改用户项目。',
         '- 31/32/48 的包项目验证使用 `scripts/qa_book_projects.R`；已装包不重复安装，关闭自动打开 IDE/浏览器。快照先建立基线再复跑，coverage HTML 成功生成。IDE active-file 两行仍需人工验证。',
         '- 01 与 27 的定向检查验证实际数值和 iris 模块输出；AI 章节对照本地工作坊 `_solutions`/`_exercises`，并核对已安装 ellmer 0.5.0 方法。未配置常见 LLM 凭据；不调用模型、不输出凭据。',
         '- `OK` 代表该块在注明的上下文中执行成功；仅定义函数的块不意味着所有函数体均被调用。API 跳过不等于端到端通过。', '',
         f"结果：{counts['OK']} 块 OK；{counts['EXPECTED-ERROR']} 块预期报错验证；{counts['PARTIAL-IDE']} 块主体通过、IDE 行未执行；{sum(v for k,v in counts.items() if k.startswith('SKIPPED'))} 块跳过。未解决的执行失败：0。", '',
         '## 逐章矩阵', '', '| 章 | 块数 | OK | 预期报错 | 修改块数 | 部分/跳过及原因 |', '|---|---:|---:|---:|---:|---|']
for path in sorted((ROOT/'book/chapters').glob('*.qmd')):
    ch = path.stem[:2]
    blocks = [b for b in inventory if b['chapter']==ch]
    rs = [results[b['id']] for b in blocks]
    c = collections.Counter(r['status'] for r in rs)
    skipped = '; '.join(f"{b['id']} {results[b['id']]['status']}" for b in blocks if results[b['id']]['status'] not in ('OK','EXPECTED-ERROR')) or '无'
    lines.append(f"| [{ch}](chapters/{path.name}) | {len(blocks)} | {c['OK']} | {c['EXPECTED-ERROR']} | {sum(b['id'] in fixed for b in blocks)} | {skipped} |")
lines += ['', '修改块数统计源码发生变化的块（包括补依赖、澄清注释和拆分故意错误示例），不是独立缺陷数量。12:01 为故意的年份复制逻辑错误，夹具断言验证重复年份后计入 OK。', '',
          '## 修复清单', '',
          '- 01/12/13：补完整函数体、数据与依赖；纠正词法作用域说明；循环 benchmark 显式返回结果。',
          '- 14：修正 bearer 方法名、错误检查调用；ReqRes 现需 API key，避免虚构免密钥保证。Open-Meteo 的字符串 `"true"` 保持并实测通过。',
          '- 16/17/18：补 tidyr/dplyr 引用，修正 thematic 的 `fg` 参数与图注样本量/结论。',
          '- 22：添加 country 分组，GIF/MP4 显式判断 gifski/av；缺后端提供说明或逐帧输出。',
          '- 26/27：修正 facet_zoom 参数和 patchwork 依赖；故意错误移入独立块；Shiny 模块列选择随输入数据变化。',
          '- 31/32/34：填全 roxygen 函数体并修正文档语法；factor 断言保持类型/levels；benchmark 成绩范围与边界一致，rowwise 结果解除分组后保持默认一致性检查。',
          '- 33：保留调试错误，仅把预期输出说明改成实际 tibble 越界错误。',
          '- 41–46：统一 chat_posit / set_system_prompt / chat_structured；删除未经证实的方法；修正 vitals solver_chat、工具注册和编辑器接线；gregexpr 零匹配判断通过夹具回归。',
          '- 47：8 行 clinical tribble 与 admiral/cards/gtsummary 实测成功，AGE/BMIBL 显式设为连续变量。', '',
          '发生修改的代码块位置（最终文件行号）：', '']
for b in inventory:
    if b['id'] in fixed:
        lines.append(f"- `{b['id']}` — `{b['file']}:{b['line']}`")
lines += ['', '## 逐块证据', '', '| ID | 分类 | 结果 | 最终行 | 限制/错误详情 |', '|---|---|---|---:|---|']
for b in inventory:
    r=results[b['id']]
    detail=r.get('detail','').replace('|','/').replace('\n',' ')
    lines.append(f"| {b['id']} | {b['category']} | {r['status']} | {b['line']} | {detail or '—'} |")
lines += ['', '## AI 静态 API 证据', '',
          '路径相对于上游 `learn-posit-conf-2026/llms/`；与本机安装的 ellmer 0.5.0 导出/Chat 方法交叉核对。', '',
          '| 章 | 权威工作坊源码 |', '|---|---|',
          '| 41 | `_solutions/02_conversation/02_conversation.R`、`10_structured-output/10_structured-output.R`、`24_shinychat-1/_agent.R` |',
          '| 42 | `_solutions/10_structured-output/`、`11_parallel/11_parallel.R`、`15_evals/15_evals.R` 与 `_cases.R`、`17_quiz-game-2/` |',
          '| 43 | `_solutions/17_quiz-game-2/17_quiz-game-2-app.R`、`19_agent-1/19_agent-1.R`、`20_agent-2/20_agent-2.R` |',
          '| 44 | `_solutions/21_skills-1/21_skills-1.R` 与 `_tools.R`、`22_skills-2/` |',
          '| 45 | `_solutions/51_rag/51_rag.R` |',
          '| 46 | `_solutions/24_shinychat-1/24_shinychat-1-app.R`、`25_shinychat-2/25_shinychat-2-app.R`、`26_querychat/26_querychat.R` |', '',
          '`scripts/qa_book_ai.R` 已验证 17 块语法、42:02 schema、43:01 工具定义与 43:03 文本替换的唯一/零/重复匹配边界。为避免将局部离线验证误称端到端通过，主矩阵仍保留整块 SKIPPED-API。', '',
          '## 需人工判断或补充环境', '',
          '- 14:06 是凭据/示例域模板；14:07 缺 REQRES_API_KEY，未向 ReqRes 发认证请求。15:04 缺 polite。',
          '- 27:05 需真实 myapp 与交互式 reactlog；32:03/05 的 IDE 当前文件命令未执行。',
          '- 33:03/04 的 scores/clean_scores/step_* 业务实现未提供；34:06/07 需 scores_big.csv、已安装 scorekit 或 heavy_parse，未杜撰实现。33:01 仅定义 browser 调试函数。',
          '- 41–46 未验证模型可用性、费用、真实输出、工具循环和浏览器交互；45 需 LM Studio 嵌入服务。离线 schema/工具定义及文本替换边界已验证，但不替代线上请求。',
          '- 46 引用工作坊 `_agent.R`，其 edit_file 仍有上游零匹配判断问题；本书 43 已修复。未改上游仓库，也未将教学工具描述为生产级文件沙箱。', '',
          '## 复跑', '',
          '先设置 `QA_R_LIB` 为独立测试库并安装依赖，再依次运行：', '',
          '```text', 'Rscript scripts/qa_book_install.R', 'Rscript scripts/qa_book_projects.R', 'python scripts/qa_book.py --rscript <Rscript绝对路径> --library <测试库>', 'Rscript scripts/qa_book_focused.R', 'Rscript scripts/qa_book_ai.R', 'python scripts/qa_book_report.py', 'python scripts/qa_book_structure.py', '```', '',
          '报告由实际 `.qa/results.json` 与当前章节位置生成；原始临时产物不纳入版本控制。']
(ROOT/'book/QA-CODE-REPORT.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
print(dict(counts))
