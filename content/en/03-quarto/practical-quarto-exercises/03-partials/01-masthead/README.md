# Your turn 1: add the agency masthead

A statistical release must carry the mark of the agency that published it.

The `title-block.html` file in this folder is an unedited copy of Quarto's own
partial, already registered in `report.qmd`. Add the masthead to it.

1. Add this key to the YAML of `report.qmd`:

   ```yaml
   masthead: _brand/brs-logo.svg
   ```

2. Open `title-block.html`. Add this line directly after the `<header>` tag:

   ```html
   <img src="$masthead$" alt="Bureau of Regional Statistics" class="report-masthead">
   ```

3. Render `report.qmd`. The masthead shows above the title.

4. Challenge: Provide the `alt` text via metadata too.
