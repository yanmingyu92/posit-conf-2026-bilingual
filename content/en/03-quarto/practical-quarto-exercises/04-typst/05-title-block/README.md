# Not an exercise: the title block, rebuilt with partials

A raw Typst block styles what is already in the document. It cannot change the
title block, because the title block is built by the template before your
content arrives. For that you replace a **partial**.

This folder is the result of copying Quarto's own Typst partials in unedited,
then asking an assistant to rebuild the title block. It is here to read, not
to work through.

## What is in it

| File | Change |
|---|---|
| `page.typ` | Removes the automatic logo placement. |
| `typst-show.typ` | Passes the logo, period, region, status and brand colour into `article()`. |
| `typst-template.typ` | Accepts those parameters and lays out the whole title block. |

All three are registered in `report.qmd`:

```yaml
format:
  typst:
    template-partials:
      - page.typ
      - typst-show.typ
      - typst-template.typ
```

The body raw block that drew the badge is gone — the title block carries the
status now. `date-format: long` is set, so the date reads the way the HTML one
did.

The layout follows the HTML title block from module 03: title and subtitle at
the left with the logo at the right, then the reference period and region in
small letter-spaced capitals, the status badge, and the author and date in
labelled columns above a brand-coloured rule.

## The prompt

```
page.typ, typst-show.typ and typst-template.typ are unedited copies of
Quarto's Typst partials, already registered in report.qmd. Rebuild the title
block: the brand logo, then the reference period and region, then the release
status as a badge, above a left-aligned title and subtitle. Edit the partials
in place.
```

Seeding it with the unedited partials matters. The field names are not
guessable, and from scratch an assistant will drop the machinery behind
cross-references, footnotes and the bibliography.

## What the first pass got wrong

**`page.typ` had to change too.** Quarto places the brand logo as a page
background whenever a logo is set. Without overriding that, the mark appears
twice — once behind the page, once in the new title block. The change is a
*deletion*, which is a fair reminder that editing a partial is as often about
removing default behaviour as adding to it.

**The logo comes from the brand, not a document key.** There is no `logo:` in
`report.qmd`. Quarto normalises `_brand.yml` into a `logo` object the partials
read as `$logo.path$`, `$logo.alt$`, `$logo.location$`, `$logo.width$` and
`$logo.inset$`. Bare `$logo$` renders the string `true`, and Typst then fails
with `file not found`.

**Brand colours are not Pandoc variables.** Only `brand.typography.*` is
exposed to the template. The first pass guarded the accent colour with
`$if(brand.color.primary)$`, which never fires, so the badge came out black.
`brand-color` *is* a Typst variable, defined above `typst-show.typ` in the
assembled file, so the fix is to pass `accent: brand-color.primary` straight
through. Do not reach for it from `typst-template.typ` — that runs earlier.

**It only rewrote the title.** The author and date came out still centred,
under a left-aligned title and subtitle, because only the title portion of
`article()` was touched. Everything below it kept the default layout.

None of these four stopped the render. Three produced output that looked
plausible and was wrong, and the fourth produced output that was merely
inconsistent. Reading what an assistant hands you is the whole job.
