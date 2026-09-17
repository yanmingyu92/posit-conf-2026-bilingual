# Bureau of Regional Statistics report format

The finished module 03 title block, bundled as a custom format extension: the
partial, the styles, and the YAML that wires them together.

## Use it

From a folder with a `report.qmd` in it:

```bash
# from GitHub
quarto add posit-conf-2026/practical-quarto-exercises/brs-format

# from this repo, on disk
quarto add ../brs-format
```

Then set the format, and nothing else:

```yaml
format: brs-html
```

That is enough to render. Add the brand for the agency colours and fonts:

```bash
quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand
```

The styles use `$primary`, not `$brand-forest`, so the format works on its own
— the badge comes out in Bootstrap's blue — and follows the brand when one is
installed. Naming a colour by what it is *for* is what makes that work.

## What is in it

```
_extensions/brs/
├── _extension.yml     title, version, and what the format contributes
├── title-block.html   the partial, after all four turns
├── brs.scss           the styles for the classes it adds
└── brs-logo.svg       the agency mark
```

The logo ships with the format, and `_extension.yml` sets `masthead` to it, so
a document does not have to name it. Quarto copies the file into the output
and rewrites the path. A document can still set its own `masthead:` to
override.

`format: brs-html` names the extension `brs`, which contributes a format built
on `html`. The directory has to be `_extensions/brs/` for that to resolve.

Anything you can write under `format: html:` in a document can go under
`contributes.formats.html:` here — including default metadata, which is a
better home for a default than a conditional in the partial.

## Note

This folder holds the finished `title-block.html` and the finished styles, so
it answers Your turns 1 to 4. Worth avoiding until you have done them.
