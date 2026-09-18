# English Edition QA Report

Date: 2026-09-17. Author of the book: **Jaime Yan**.

## Scope and method

The English edition contains 28 complete chapters and 14 front/back matter pages, following the Chinese edition's learning objectives, explanations, examples, three exercise levels, AI-off practice, capstones, rubrics, and source attribution. It includes an English cover, preface, reading guide, further reading, acknowledgments, and an English companion-lab download. Both languages share the same training R code and simulated CSV; only the lab guides differ.

Every static R block was extracted and parsed. Runnable blocks were executed in fresh chapter sessions using R 4.6.0 and a dedicated package library. Package and renv examples used isolated fixtures. Additional checks covered function results, Shiny module behavior, animation fallback paths, offline AI schemas/tools, and the extracted English training ZIP. No model-provider requests were made. A code-token comparison checks the same program structure in both editions while allowing translated comments and string literals; runtime tests and translation review supplement that limited structural comparison.

## R code results

Total static R blocks: **134**. Status totals: **EXPECTED-ERROR: 2**, **OK: 105**, **PARTIAL-IDE: 2**, **SKIPPED-API: 19**, **SKIPPED-CONTEXT: 5**, **SKIPPED-PKG: 1**.

| Chapter | Blocks | OK | Expected error | Partial IDE | Skipped |
|---|---:|---:|---:|---:|---:|
| 01-functions | 4 | 4 | 0 | 0 | 0 |
| 12-iteration | 8 | 8 | 0 | 0 | 0 |
| 13-efficient-code | 8 | 8 | 0 | 0 | 0 |
| 14-json-apis | 7 | 5 | 0 | 0 | 2 |
| 15-web-scraping | 4 | 3 | 0 | 0 | 1 |
| 16-great-tables | 5 | 5 | 0 | 0 | 0 |
| 17-alt-geoms | 6 | 6 | 0 | 0 | 0 |
| 18-styled-plots | 8 | 8 | 0 | 0 | 0 |
| 21-interactive-graphics | 4 | 4 | 0 | 0 | 0 |
| 22-animation | 8 | 8 | 0 | 0 | 0 |
| 23-dashboards-static | 7 | 7 | 0 | 0 | 0 |
| 24-dashboards-dynamic | 5 | 5 | 0 | 0 | 0 |
| 25-maps-leaflet | 8 | 8 | 0 | 0 | 0 |
| 26-ggplot-extensions | 4 | 3 | 1 | 0 | 0 |
| 27-shiny-reactive | 6 | 5 | 0 | 0 | 1 |
| 28-pub-ready-reports | 0 | 0 | 0 | 0 | 0 |
| 31-pkg-structure | 4 | 4 | 0 | 0 | 0 |
| 32-unit-testing | 5 | 3 | 0 | 2 | 0 |
| 33-debugging | 4 | 1 | 1 | 0 | 2 |
| 34-code-speed | 7 | 5 | 0 | 0 | 2 |
| 41-llm-basics | 3 | 0 | 0 | 0 | 3 |
| 42-structured-output | 5 | 0 | 0 | 0 | 5 |
| 43-agents | 3 | 0 | 0 | 0 | 3 |
| 44-skills | 1 | 0 | 0 | 0 | 1 |
| 45-rag-mcp | 2 | 0 | 0 | 0 | 2 |
| 46-shinychat | 3 | 0 | 0 | 0 | 3 |
| 47-clinical-reporting | 3 | 3 | 0 | 0 | 0 |
| 48-regulated-gxp | 2 | 2 | 0 | 0 | 0 |

## Execution limits

- Chapters 4.1–4.6: model-service examples remain skipped without provider credentials. Parsing, API-surface review, and offline schema/tool checks do not establish end-to-end provider behavior.
- Chapter 1.4: the credential template uses a placeholder host and was not sent; authenticated ReqRes pagination was not executed without its key. The Open-Meteo examples ran.
- Chapter 1.5: the `polite` example was skipped because that package is unavailable in the test library.
- Chapters 2.7, 3.2, and 3.3: IDE viewers and interactive debugging behavior were not exercised through a live IDE. Non-IDE testing and coverage commands ran in an isolated package.
- Chapters 3.3–3.4: unspecified learner files/functions remain contextual examples, rather than invented fixtures claimed as successful execution.
- Intentionally failing examples in Chapters 2.6 and 3.3 produced the expected errors; the wrong-year example in 1.2 was checked for its intentional logical defect.
- Chapter 2.8 contains document templates but no static R fences. Quarto book rendering checks publication, not execution of every reader-created report or dashboard.

## Translation and consistency

- API names, function names, data columns, numeric constants, and paths retain their source contracts. Human-facing comments, labels, and messages are translated. Leaflet layer names and matching controls were translated together.
- A Chapter 4.1 exercise explicitly asks the model to respond in Chinese; the English wording preserves that task requirement.
- Chapter 1.2's explanation of `map2()` recycling was corrected in both editions after an R check: length-one inputs can recycle, while incompatible lengths such as two and three error.
- Attribution remains with Jaime Yan as the book author, while original workshop authors and licenses remain in chapter SOURCES sections. The conference catalog remains a separate reference library.

## Reproduction

Local publication checks passed with Quarto 1.10.18: both 42-page editions and the website rendered with zero errors. All 42 English pages passed local link and fragment checks. Browser checks covered the cover and author byline, same-chapter switching in both directions, clinical reading-path anchors, the English ZIP download, portal links, and a 390-pixel mobile viewport. English tables scroll within their own area on small screens rather than forcing the page to overflow. The ZIP's three R scripts and CSV are byte-identical to the Chinese package; its English guides were checked separately.

Run `python scripts/build_training_download.py`, `python scripts/qa_book_structure.py`, and `python scripts/qa_book_english.py`. Set `QA_BOOK_DIR=book-en` and `QA_EVIDENCE_DIR=.qa/en` for `qa_book.py` and the projects, focused, and AI R scripts. Run `Rscript scripts/qa_book_code_parity.R` for code structure comparison. Supply `--rscript` and `--library` to the Python runner as documented in that script.

Render `book`, `book-en`, and `website` with Quarto. The English deployment path is `/book/en/`; chapter filenames match the Chinese edition so language switching preserves the chapter. Generated output and raw evidence stay outside version control.

## Addendum: 2026-09-18 content review and visual restyle

A full five-way editorial review of all 42 English pages found 16 issues; all were fixed in both editions (code-token changes applied identically to preserve parity):

- Dead URLs replaced: profvis (2), jsonlite, httr2 (13-efficient-code, 14-json-apis, both editions).
- Chapter 1.4: `req_throttle(rate = 1)` updated to the current httr2 token-bucket API `req_throttle(capacity = 1, fill_time_s = 1)`, with the comment corrected (the legacy `rate` argument permits bursts, so "one request per second" was inaccurate).
- Chapter 2.5: quakes longitude description corrected (166–188, crossing the antimeridian).
- Chapter 2.6: explanation realigned with the `p1` boxplot code.
- Chapter 2.7: deprecated `shiny::reactlogShow()` replaced with `reactlog::reactlog_show()`.
- Chapter 2.8: brand YAML example fixed (`brand: <path>`, not a nested key); Typst `margin` changed from an invalid array to the `{x:, y:}` mapping.
- Chapter 3.4: prerequisite `tracemem()` question reordered so the traced object is the one modified.
- Chapters 4.4/4.8: wrong chapter cross-references corrected (rule of three → 1.1; git prerequisites → R Packages / Happy Git; branch-protection bullet no longer cites 3.1–3.2).
- Product naming standardized on **Posit Assistant** throughout (Positron Assistant is superseded per the posit::conf 2026 workshop materials).

Visual restyle (both editions): new `assets/book.css` (Fraunces/Inter/JetBrains Mono typography, gradient title banner, styled code blocks, callouts, tables, sidebar, buttons, language-switch pill), added `assets/favicon.svg` and the `favicon:` book option.

Re-verification: `qa_book_structure.py` and `qa_book_english.py` report zero errors; `qa_book_code_parity.R` compared 134 blocks with 0 structural differences; both editions and the website re-rendered with Quarto 1.10.18 with zero errors. Browser checks on the nested production layout covered the title banner, chapter pages, callouts, same-chapter switching in both directions, the ZIP download (HTTP 200), and a 390-pixel viewport with no horizontal overflow. The full `qa_book.py` R-block harness was re-run against the English edition; results are recorded in `.qa/en`.
