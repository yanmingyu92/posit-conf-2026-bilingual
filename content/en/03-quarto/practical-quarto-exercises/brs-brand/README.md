# Bureau of Regional Statistics brand

The brand for the fictional agency used through these exercises. It holds the
colors, the fonts, and the logo, so every render looks like one organization
published it.

## Use it

Run one of these commands from inside an exercise folder:

```bash
# from GitHub
quarto use brand posit-conf-2026/practical-quarto-exercises/brs-brand

# from this repo, on disk
quarto use brand ../../brs-brand
```

Both commands copy `_brand.yml` and `brs-logo.svg` into a `_brand/` folder.
Quarto finds the brand there with no other configuration.

## What is in it

| Key | Value |
|---|---|
| `primary` | `forest`, `#1B5E4F` |
| `secondary` | `slate`, `#3D4A54` |
| Palette | `forest`, `slate`, `sand`, `ink` |
| Fonts | Atkinson Hyperlegible, Source Code Pro |
| Logo | `brs-logo.svg` |

In a `.scss` theme file, the semantic colors are `$primary` and `$secondary`.
The palette colors are `$brand-forest`, `$brand-slate`, `$brand-sand`, and
`$brand-ink`. A bare palette name such as `$forest` is not defined.
