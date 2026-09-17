# Your turn 3: set and show rules

`report.typ` is already full of rules that nobody typed — `#set` from your
YAML, `#show` from your brand:

```typst
#set page(
  paper: "us-letter",
  margin: (x: 1.25in, y: 1.25in),
  numbering: "1",
  columns: 1,
)

#set text(fill: brand-color.foreground)
#show heading: set text(font: ("Atkinson Hyperlegible",), weight: 600, )
#show link: set text(fill: rgb("#1b5e4f"), )
```

Typst's names for these: `#set f(arg: value)` is a **set rule**, and
`#show f: set g(...)` is a **show-set rule** — the `show` keyword, a
**selector**, a colon, then a set rule.
[Typst: styling](https://typst.app/docs/reference/styling/)

Write your own in **`report.qmd`**, in a new raw Typst block above the badge,
so they apply to everything below.

`report.typ` is generated on every render — read it, but do not edit it.

1. Write a **set rule** to loosen the paragraphs. `par` has a `leading`
   argument. [`par`](https://typst.app/docs/reference/model/par/)

2. Write a **show-set rule** to centre the section headings.
   [`align`](https://typst.app/docs/reference/layout/align/)

## Bonus

3. Step 2 centred `### Manufacturing` too. Narrow the selector to the
   top-level sections only.

   Quarto shifts heading levels down by one, so your `##` sections are Typst
   level **1** and `### Manufacturing` is level **2**. `heading` can be
   narrowed with `.where()`.
