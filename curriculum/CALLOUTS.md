# Callout Authoring Standard · 教学标注写作标准

> 采纳自 STAT 541 Advanced R 的 9 类 callout 体系（© Kelly Bodwin & Allison
> Theobold, CC-BY-SA 4.0），作为我们所有 `lesson/` 讲义的**强制写作语法**。
> Quarto 原生支持 callout，语法见每节代码块，直接复制使用。

## 使用总则

1. 每个概念阶梯（concept ladder）的「解释→演示→练习→误区」四件套，分别对应
   `Example`、`Check In`、`Practice Exercise`、`Warning` 四类标注——**四件套不齐
   不许进 lesson**（与 TEMPLATE.md 红线一致）。
2. 翻译上游内容时，原文若无 callout 结构，译者按本标准**重新装填**，不得平铺直叙。
3. `Opinion` 与 `Learn More` 默认折叠（`collapse="true"`），避免干扰主线阅读。

## 9 类标注速查

### 1. Warning · 当心
```{markdown}
::: {.callout-warning}
## 常见错误标题
踩坑描述与规避方法。
:::
```
用途：常见报错、易错点。对应阶梯第 4 件套「常见误区」。

### 2. Example · 示例
```{markdown}
::: {.callout-example}
可运行的代码与说明，不许跳过。
:::
```
用途：代码演示。对应阶梯「演示」。

### 3. Note · 澄清
```{markdown}
::: {.callout-note}
“注意……”类澄清点，防误解。
:::
```

### 4. Required Reading · 必读
```{markdown}
::: {.callout-important}
## Required Reading
外部必读材料链接（多为上游原文，注明出处与协议）。
:::
```

### 5. Required Video · 必看
同上语法，标题改为 Required Video。视频链接 + 时长 + 看什么。

### 6. Check In · 随堂小检
```{markdown}
::: {.callout-important}
## Check In：<题号>
小任务正文（不评分但视为必做）。对应阶梯「练习」的轻量版。
:::
```

### 7. Practice Exercise · 练习
```{markdown}
::: {.callout-practice?}（无原生 practice，用 important + 标题约定）
## Practice Exercise：<编号>
较长的动手练习，copy/adapt/create 三档之一，需提交。
:::
```

### 8. Learn More · 延伸
```{markdown}
::: {.callout-tip collapse="true"}
## Learn More
可选阅读/资源。
:::
```

### 9. Opinion · 作者观点
```{markdown}
::: {.callout-caution collapse="true"}
## Just Our Opinion
带主观色彩的经验之谈，读者自行取舍。
:::
```

## 与双语排版的关系

- zh 版：callout 标题译中文，类型词保留英文括注（如「当心（Warning）」）
- en 版：保持原文标题
- 代码块内注释：zh 版可加中文行内注释，代码本身不改
