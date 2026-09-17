# Your turn 3: a second format, and a logo

The release now has to be presented as well as read. Same numbers, same brand, a deck instead of a page.

Two SVGs arrived from the agency's design team and are sitting in this folder, unused: `brs-logo.svg` and `brs-logo-white.svg`.

1. Add slides as a second format in `report.qmd` and set a different output file name for it:

   ```yaml
   format:
     html:
       respect-user-color-scheme: true
     revealjs:
       output-file: slides.html
   ```

2. Preview each format and discuss with your neighbor how brand is applied to each.

3. Register `brs-logo.svg` in `_brand.yml` as `mark`, and set `small` and `medium` to it. 

4. Preview each format, do both show the logo? Discuss with your neighbor.

5. Explicitly insert the logo it in the report, above `## Summary`:

   ```markdown
   ::: {.content-hidden when-format="revealjs"}
   {{{< brand logo medium >}}}
   :::
   ```

6. In dark mode the mark is ink on ink. Register `brs-logo-white.svg` too, and give both sizes a `light`/`dark` pair.
