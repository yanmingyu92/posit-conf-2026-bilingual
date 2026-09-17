# Your turn 1: write a brand by hand

`report.qmd` renders with Quarto's default look. The agency has a look of its
own, and nobody has written it down yet.

The agency style guide says:

| | |
|---|---|
| Forest | `#1B5E4F` |
| Slate | `#3D4A54` |
| Sand | `#EFE9DD` |
| Ink | `#1F2A2E` |
| Typeface | Atkinson Hyperlegible |

1. Render `report.qmd` first, so you have something to compare against.

2. Create a file named `_brand.yml` in this folder. Name the four colors:

   ```yaml
   color:
     palette:
       forest: "#1B5E4F"
       slate: "#3D4A54"
       sand: "#EFE9DD"
       ink: "#1F2A2E"
   ```

3. Render again. Nothing changed. Naming a color does not use it.

4. Give the colors jobs, in the same `color:` block, below `palette:`:

   ```yaml
     foreground: ink
     background: white
     primary: forest
     secondary: slate
   ```

5. Render. The body text and the link to the methodology notes both moved.

6. Add the typeface:

   ```yaml
   typography:
     fonts:
       - family: Atkinson Hyperlegible
         source: google
     base: Atkinson Hyperlegible
     headings:
       family: Atkinson Hyperlegible
       weight: 600
   ```

7. Render. Compare with the first render.
