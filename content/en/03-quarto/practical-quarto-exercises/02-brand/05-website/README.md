# Your turn 5: brand the website

The agency is standing up a small website for its quarterly releases, and it has to look like the same organization that published the report and the deck.

A starter website project sits in this folder: a `_quarto.yml`, an `index.qmd`, and no brand at all. 
It renders with Quarto's default look — the same default look you replaced in Your turn 1.

1. Change the directory to the exercise folder, bring the shared brand into the website project, then render the site:

   ```{.bash .wrap}
   quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand
   ```

2. Set the navbar to the brand color:

   ```yaml
   website:
     navbar:
       background: primary
   ```

3. Render again and find everywhere the brand shows up: navbar, links, headings, favicon.

4. Give the site a light/dark toggle with `theme: light: brand, dark: brand`, and flip it.

5. Does the navbar logo stay readable in both modes? Remember: don't edit the copy in `_brand/` — what would you ask the brand owner for instead?

**Stretch goal:** Add a page that doesn't exist yet — how much branding work does the new page take?
