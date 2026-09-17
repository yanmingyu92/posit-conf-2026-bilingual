# Module TEMPLATE · 模块设计模板

> 复制本目录为 `curriculum/modules/<层级>-<域><序号>-<slug>/`，
> 逐字段填写 DESIGN.md，评审通过后再写讲义。全部字段必填。

```
modules/<ID>/
├── DESIGN.md      ← 本模板填写
├── lesson/        ← zh.md（教学主语言）+ en.md（对照）
├── exercises/     ← copy/ adapt/ create/ 三档
├── capstone.md    ← 压轴项目 + 评分量规
└── SOURCES.md     ← 原创声明 + 上游映射
```

---

## DESIGN.md 模板

```markdown
# <模块 ID 与标题>

## 0. 一句话定位
（学员学完后能做到的那件事，动词开头）

## 1. Big idea & Essential questions
- 大观念：学完三年后还记得住的一句话
- 核心问题 ×2–3（不要求课内回答完，但要持续追问）

## 2. 目标学员与画像命中
（P1/P2/P3/P4 谁来学、谁可以跳过）

## 3. Learning objectives（可测目标）
按布鲁姆层级写，每条以可观察动词开头：
- L1 级：describe / identify / execute / use
- L2 级：diagnose / compare / design / implement
- L3 级：justify / architect / evaluate / refactor
目标数量：3–6 条。多了拆模块。

## 4. Prereq check（前置自测，≤5 分钟）
3–5 道自测题；不合格 → 指向回补模块链接。

## 5. Concept ladder（概念阶梯）
| # | 概念 | 解释 | 演示 | 练习 | 常见误区 |
|---|------|------|------|------|----------|
每个概念必须四件套齐全，缺一就降级为"阅读材料"。

## 6. AI integration point（F 线织入点）
本模块哪一步用 AI、怎么用、以及**何时禁用 AI**（防止认知外包）。

## 7. Time budget（按画像分档）
P1: __h · P2: __h · P3: __h

## 8. Assessment evidence
练习梯度如何覆盖目标 + capstone 如何综合检验。

## 9. Capstone（压轴项目）
真实任务描述 + 交付物清单 + 评分量规（3–4 维 × 3 档：达到/良好/卓越）。

## 10. SOURCES 映射
| 讲义节 | 上游素材（仓库/路径） | 性质：原创/改编/翻译 |
```

---

## 写作红线

1. 目标不可测 → 重写目标，不删测试。
2. 概念阶梯出现"解释"没有"练习" → 不许进入 lesson 阶段。
3. capstone 没有 rubric → 视为未完成。
4. SOURCES.md 有空行 → PR 直接打回（协议风险）。
5. 全程禁用 AI 的环节要显式标注（至少每模块一处）。
