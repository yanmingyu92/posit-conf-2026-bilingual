# Curriculum Design · 课程总体设计

> 编写者：**Jaime Yan**。本文件维护《现代 R 进阶》及其训练配套的教学设计。
> 课程围绕学习成果组织；posit::conf 工作坊、经典教材和官方文档按知识需求提供支撑，
> 来源目录不决定课程边界。当前主要读者是已有 R 基础的分析人员，以及临床研究和制药领域使用者。
> 独立训练见 [training/](https://github.com/yanmingyu92/posit-conf-2026-bilingual/tree/main/training)，教材化扩充计划见 [EDITORIAL-PLAN.md](https://github.com/yanmingyu92/posit-conf-2026-bilingual/blob/main/book/EDITORIAL-PLAN.md)。

---

## 1. Design Philosophy · 设计理念

### 1.1 Three commitments · 三个承诺

1. **Backward design（逆向设计）**：每个模块先定「学员要能做成什么」（可评估的成果），
   再定证据（练习/作品），最后才写讲义。绝不从"讲什么知识点"出发。
2. **Competency over tools（能力先于工具）**：分类的骨架是**能力域与水平**，不是软件名。
   工具会过时（RStudio→Positron，LaTeX→Typst），能力域稳定。工具只是能力域的"实例"。
3. **AI as a thread, not a chapter（AI 是线不是章）**：AI 辅助实践贯穿每一级，
   而不是孤立一章。这是 2026 年材料最核心的信号。

### 1.2 Taxonomy · 分类法（本课程的骨架）

**双视图原则**：课程同时保持两种组织方式，各司其职——

- **能力矩阵视图**（[MATRIX.md](MATRIX.md)）：5 能力域 × 3 水平（布鲁姆修订版思想），
  用于检索、诊断与画像个性化路径；**工具会过时，能力域稳定**。
- **单元交付视图**（[UNIT-STRUCTURE.md](UNIT-STRUCTURE.md)）：参照 STAT 541
  *Advanced R*（Bodwin & Theobold, CC-BY-SA 4.0）的三单元弧线
  （复杂分析 → 专业交付物 → 包开发）+ 我们扩展的第四单元（AI 与领域应用），
  用于开班/成书的线性交付。

两视图通过 UNIT-STRUCTURE §4 交叉表互通；讲义写作语法统一采用其 9 类教学标注
体系（[CALLOUTS.md](CALLOUTS.md)）。

```
                    L1 奠基 Foundations      L2 实践 Practitioner     L3 工程师 Engineer
                    (记忆·理解·应用)          (应用·分析)              (评价·创造)
A 计算与工具        ▢                        ▢                        ▢
B 数据获取与加工    ▢                        ▢                        ▢
C 分析与推断       ▢                        ▢                        ▢
D 沟通与出版       ▢                        ▢                        ▢
E 交付与治理       ▢                        ▢                        ▢
─────────────────────────────────────────────────────────────────────
F AI 增强实践（横切线索，织入 A–E 每一格，不单设章节）
```

完整映射（每格放哪些上游材料、写哪些原创单元）见 **[MATRIX.md](MATRIX.md)**。

### 1.3 What is "ours" vs "adapted" · 原创与改编的边界

| 类型 | 判定 | 许可 |
|---|---|---|
| 原创课程设计（本文件、MATRIX、模块蓝图、练习、评分量规、画像） | 我们从头写的 | 项目自有，对外 CC-BY-SA 4.0 统一发布 |
| 改编内容（翻译、摘编、引用上游片段） | 内容实质来自上游 | 必须 CC-BY-SA 4.0 + 署名头（同 CONTRIBUTING 规则） |
| 上游镜像 | 逐字复制 | 上游协议，见 ATTRIBUTION.md |

**写作纪律**：原创讲义可以"参考上游的教学顺序与例子设计"，但文字必须自己写；
直接搬用句子/图 = 改编，需署名。每个模块的 `SOURCES.md` 声明两者边界。

---

## 2. Learner Personas · 学员画像（4 类）

| 画像 | 描述 | 入口评估 | 目标路径 | 关键痛点 |
|---|---|---|---|---|
| **P1 小林** | 研究生，零编程，用过 SPSS/GraphPad | L0 → L1 | L1 全域 → L2 B/D | 术语恐惧、环境配置劝退 |
| **P2 陈医生** | 临床医生，会一点 R 拼 dplyr，要出可复现报告+出版级图表 | 免 L1-A 前半 | L1 D → L2 B/D 直通 | 时间碎片化、统计报告合规 |
| **P3 阿伟** | 生信/数据分析，R 熟练，要升级现代栈 + AI 工作流 | 免 L1 | L2 全域 → L3 A/E | 工作流陈旧、AI 工具不会用 |
| **P4 老周** | 药企生物统计，SAS 背景，转向 R 且受 GxP 约束 | L1-A 快速通道 | L2 C/E → L3 E | 验证、可追溯、合规 |

**画像驱动取舍**：一个模块若对 4 类画像都没命中"痛点"，就砍掉。P2/P4 是我们的
差异化定位（医学/制药人群），也是市面课程空白。

---

## 3. Module Anatomy · 模块解剖（每课的固定骨架）

每个模块 = `curriculum/modules/<层级>-<域><序号>-<slug>/` 目录，含：

```
DESIGN.md      ← 设计文档（先写这个，评审通过才写讲义）
lesson/        ← 双语讲义（zh 为教学主语言，en 对照）
exercises/     ← 三档练习：copy · adapt · create（刻意练习梯度）
capstone.md    ← 压轴小项目：真实任务 + 评分量规（rubric）
SOURCES.md     ← 原创声明 + 上游材料映射表（协议合规）
```

`DESIGN.md` 必填字段（模板见 `modules/TEMPLATE.md`）：

1. **Big idea & essential questions**（大观念与核心问题：学完三年后还记得住的那句话）
2. **Objectives**（可测目标，动词用布鲁姆层级：L1 用 describe/execute；L2 用
   diagnose/design；L3 用 justify/architect）
3. **Prereq check**（5 分钟自测，不合格给出回补模块链接）
4. **Concept ladder**（概念阶梯：每个概念 = 解释 → 演示 → 练习 → 常见误区）
5. **Assessment evidence**（练习 + capstone 如何证明目标达成）
6. **AI integration point**（本模块哪里织入 F 线：如用 Assistant 解释报错）
7. **Time budget**（按画像给 2–3 档时长）

---

## 4. Authoring Workflow · 创作流程

```
① 立项：在 MATRIX 里认领一格 → 建 issue（模块 ID）
② 设计：写 DESIGN.md → PR 评审（教学设计过关吗？目标可测吗？）
③ 内容：讲义双语 + 练习 + capstone + SOURCES.md
④ 试用：找一个真实画像学员走一遍，记录卡点
⑤ 修订 → 发布到 website 课程页（capstone 作品库沉淀学员成果）
```

**优先级规则 v1**（按画像价值 × 素材成熟度）：
1. `L1-A1` R 与 Positron 起步（示例模块已建，见 modules/L1-A1-foundations/）
2. `L2-D2` Quarto 出版级报告（P2 陈医生主线，素材最厚）
3. `L2-F` LLM 编程实务（差异化最强，直接基于 llms 2026）
4. `L3-E2` pharmaverse 临床报告（P4 老周主线）
