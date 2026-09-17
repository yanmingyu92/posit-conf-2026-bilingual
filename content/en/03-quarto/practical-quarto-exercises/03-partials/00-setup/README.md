# Setup: replace a partial with a copy of itself

Your instructor drives this part. Follow along if you want to.

1. Pull the workshop brand into this folder:

   ```bash
   quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand
   ```

2. Copy Quarto's own [`title-block.html`](https://github.com/quarto-dev/quarto-cli/blob/main/src/resources/formats/html/templates/title-block.html)
   into this folder.

3. Register the partial in the YAML of `report.qmd`:

   ```yaml
   format:
     html:
       template-partials:
         - title-block.html
   ```

4. Render `report.qmd`.
