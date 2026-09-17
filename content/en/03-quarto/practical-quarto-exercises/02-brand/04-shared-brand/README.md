# Your turn 4: stop writing the brand

You wrote this brand by hand. Four other teams at the agency did the same, and
five hand-written brands are five slightly different brands.

The agency now publishes one:
[`brs-brand`](https://github.com/posit-conf-2026/practical-quarto-exercises/tree/main/brs-brand).

1. Delete the brand you wrote, and both SVGs.

2. Preview the report without the brand to remind yourself what it looks like without it.

3. Take the agency's brand — with `--dry-run` first, then without:

   ```{.bash .wrap}
   quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand --dry-run
   ```

   ```bash
   quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand
   ```

4. Look at what landed in `_brand/`, preview both formats.

5. Switch your system appearance to dark, what happens?
