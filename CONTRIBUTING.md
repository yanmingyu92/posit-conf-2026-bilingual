# Contributing: Translation Workflow / 参与贡献：翻译工作流

感谢参与翻译！本仓库的翻译层有一套固定流程，保证**可追溯、可审查、协议合规**。
Thank you for contributing! Follow this workflow to keep translations traceable,
reviewable, and license-compliant.

## Principles / 原则

1. **Never edit upstream copies / 不改动镜像原文**：`content/en/` 下是上游镜像，
   任何修改只能通过 `scripts/sync-from-upstream.ps1` 重新同步。
2. **Translate module by module / 按模块翻译**：一个 upstream 文件对应一个 zh 文件，
   命名与目录结构完全镜像（见下）。
3. **Every translated file carries an attribution header / 每个译文必须带署名头**。
4. **Code stays English, prose is translated / 代码不译，正文翻译**；术语首次出现时
   保留英文原文括注，如「技能包（skills）」。
5. **Terminology consistency / 术语一致**：以 `translations/zh/GLOSSARY.md` 为准
   （尚未建立？欢迎第一个提交它）。

## File layout / 文件对应规则

```
content/en/04-llms/llms/outline.md
                      └──→ translations/zh/modules/04-llms/llms/outline.zh.md
```

规则：路径逐级镜像，文件名加 `.zh` 后缀（`xxx.qmd` → `xxx.zh.md`）。

## Attribution header template / 署名头模板

每个译文文件开头必须包含（直接复制 `translations/zh/TEMPLATE.module.zh.md`）：

```markdown
---
title: "<模块标题>"
source: https://github.com/posit-conf-2026/llms/blob/main/outline.md
source_sha: 165cb237684b42d6bf33ae347ba0c61aad88dba4
license: CC-BY-SA 4.0
translators: ["@your-github-handle"]
status: draft | review | final
---

> 本页是 posit::conf(2026) 工作坊材料的中文翻译。
> 原作 © Garrick Aden-Buie & Sara Altman，采用 CC-BY-SA 4.0 协议发布。
> This is a Chinese translation of openly licensed posit::conf(2026) materials.
```

## Workflow / 流程

1. 在 [issues](https://github.com/yanmingyu92/posit-conf-2026-bilingual/issues) 的翻译看板认领一个模块（`translation: <repo>/<file>`）。
2. 复制 `TEMPLATE.module.zh.md`，按对应规则建文件并翻译。
3. 提 PR，标题 `zh: translate <repo>/<file>`。
4. 审查要点：术语一致、代码块未译、frontmatter 的 source/sha 正确、状态标 `review`。
5. 合并后状态改 `final`，学习计划与网站索引自动可引用。

## Non-translation contributions / 非翻译贡献

- 修复目录、链接、清单错误：直接提 PR。
- 新增往届仓库编目：先读 `ARCHIVE-CATALOG.md` 的 backlog 节，开 issue 讨论。
- 学习心得/本地化案例：放 `translations/zh/notes/`，不与译文混放。

## Book QA & rendering / 书籍 QA 与渲染

书籍（`book/` 中文版、`book-en/` 英文版）有独立的检查与渲染流程：

```bash
python scripts/qa_book_structure.py    # 书籍结构检查
python scripts/qa_book_english.py      # 英文版完整性与中英结构一致性
python scripts/qa_book.py              # 执行全部静态 R 代码块并生成 QA 报告
```

`qa_book.py` 默认检查中文版；用环境变量选择版本与证据目录，如
`QA_BOOK_DIR=book-en QA_EVIDENCE_DIR=.qa/en python scripts/qa_book.py`。
依赖模型服务的示例在没有凭据时会跳过，属预期行为。

本地渲染与构建：

```bash
quarto render book                      # 中文版
quarto render book-en                   # 英文版
quarto render website                   # 中心站点
python scripts/build_training_download.py  # 配套实验下载包
```

推送到 `main` 分支会触发 GitHub Actions 自动重新渲染并部署到 GitHub Pages，
无需提交生成的 HTML。
