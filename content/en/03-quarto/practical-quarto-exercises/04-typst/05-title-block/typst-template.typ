
#let article(
  title: none,
  subtitle: none,
  logo-path: none,
  logo-alt: "",
  release-period: none,
  release-region: none,
  status: none,
  accent: black,
  muted: luma(110),
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none or logo-path != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        // Title and subtitle at the left, logo at the right.
        #grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          column-gutter: 1.5em,
          {
            set par(leading: heading-line-height) if heading-line-height != none
            set text(font: heading-family) if heading-family != none
            set text(style: heading-style) if heading-style != "normal"
            set text(fill: heading-color) if heading-color != black
            text(size: title-size, weight: heading-weight)[#title #if thanks != none {
              footnote(thanks, numbering: "*")
              counter(footnote).update(n => n - 1)
            }]
            if subtitle != none {
              parbreak()
              text(size: subtitle-size, weight: "regular")[#subtitle]
            }
          },
          if logo-path != none {
            image(logo-path, width: 1.5in, alt: logo-alt)
          },
        )

        // Reference period and region, small and letter-spaced.
        #if release-period != none {
          block(above: 1em, below: 0.6em)[
            #text(size: 0.78em, fill: muted, tracking: 0.09em)[
              #upper(release-period)#if release-region != none [ · #upper(release-region)]
            ]
          ]
        }

        // Release status badge.
        #if status != none {
          block(below: 1.2em)[
            #box(fill: accent, radius: 3pt, inset: (x: 8pt, y: 5pt))[
              #text(fill: white, weight: "bold", size: 0.7em, tracking: 0.09em)[#upper(status)]
            ]
          ]
        }

        // Author and date in labelled columns, as the HTML title block does.
        #{
          let cols = ()
          if authors != none and authors != () {
            let label = if authors.len() > 1 { "Authors" } else { "Author" }
            cols.push((label, authors.map(a => a.name).join(", ")))
          }
          if date != none {
            cols.push(("Published", date))
          }
          if cols.len() > 0 {
            block(below: 0.9em)[
              #grid(
                columns: (1fr,) * cols.len(),
                column-gutter: 1.5em,
                row-gutter: 0.35em,
                ..cols.map(c => [
                  #text(size: 0.7em, fill: muted, tracking: 0.09em)[#upper(c.at(0))] \
                  #c.at(1)
                ])
              )
            ]
          }
        }

        #line(length: 100%, stroke: (paint: accent, thickness: 2pt))

        #if abstract != none {
          block(inset: (top: 1em))[
          #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
          ]
        }
      ]
    )
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
