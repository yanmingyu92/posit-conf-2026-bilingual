# Your turn 2: add the period and region

A statistical release reports on a period of time and an area. A reader must be
able to see both without opening the tables.

Both values are already in the YAML of `report.qmd`, and have been since the
start of the module:

```yaml
brs-release:
  period: "Q3 2026"
  region: Oregon
```

Nothing shows them yet. The template has never asked for them.

1. Copy, then complete, this line in `title-block.html`, below the `$endif$`
   that closes the subtitle:

   ```html
   <p class="report-period">______ &middot; ______</p>
   ```

   Each blank becomes a reference to one of the values above. To reach a key
   that sits inside another key, join the names with a dot.

2. Render. The period and the region show below the subtitle.

3. What happens when you remove `brs-release` from `report.qmd`?
