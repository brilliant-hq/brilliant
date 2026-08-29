---
assumes: blueprint/text
---
# Design Typography

For text syntax, see `blueprint/text`. For DS architecture, see `design-systems/core`.

## Type Scale (Body = 16px)

The catalog covers the scale. Always reach for `$font.size.X` rather than typing raw pixels:

```
$font.size.xs   = 12   (overlines, captions, micro-labels)
$font.size.sm   = 14   (secondary body, dense UI)
$font.size.md   = 16   (body)
$font.size.lg   = 20   (subheadings)
$font.size.xl   = 24   (section headings)
$font.size.2xl  = 32   (page headings)
$font.size.3xl  = 36   (small heroes)
$font.size.4xl  = 40   (heroes)
$font.size.5xl  = 48   (large heroes)
$font.size.6xl  = 64   (display)
$font.size.7xl  = 80, 8xl = 96, 9xl = 128 (oversize watermarks / display)
```

Jump rule: heading = 150-200% of body.

## Font Families

Use the active DS's font tokens, `$font.family` (workhorse sans) and `$font.family.serif` (editorial accent, when the DS provides one). Most designs need only these: same-family pairing is safest; `$font.family.serif` as a single editorial heading + `$font.family` body is the high-contrast move.

The default DS also answers `$font.family.sans`, an alias of `$font.family` on the same face, for when you want to name the sans out loud beside `$font.family.serif`. A DS the project authored itself may not define it: an unknown font token refuses and names the family tokens that DS does carry.

Specific Google Fonts override the DS, `t("...",Playfair Display,...)` works inline and auto-loads. Reach for this only when the active DS doesn't fit the mood; switching DS is usually the better move (see `design-systems/core`).

Importing from Figma: a commercial font that isn't bundled, on Google Fonts, or installed on your machine can't be served, so its text imports as pixel-true glyph outlines (not editable text) and the migration report lists it under Missing fonts. To get editable text back, install the `.ttf`/`.otf` with the Install Font Files command, then re-import the file from the Figma plugin. Brilliant never downloads commercial fonts for you.

## Hierarchy

Use 2-3 levers simultaneously: **Size** + **Weight** + **Color**. Pair heavy headings (`$font.weight.bold` or `.strong`) with `.soft` or `.faint` body. Use semantic text aliases, `$color.text.primary`, `$color.text.secondary`, `$color.text.disabled`, so the hierarchy auto-flips in dark mode. Max 2 font families. Tighter tracking on large type (24px+), open tracking on small-caps or labels below 13px.

## Anchor Principle

Every screen has ONE focal element sized 2-3x body, hero headline, primary metric, key callout. Don't equally weight multiple "biggest things", one dominates, the rest support.
