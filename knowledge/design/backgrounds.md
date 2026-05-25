---
assumes: blueprint/paint
---
# Design Backgrounds

## Section alternation

The first move for a multi-section page: alternate 2-3 surface tones so
no two adjacent sections match. Most sections are `$color.surface`; lift
some with `$color.surface.container`; an occasional dark section
(`$zinc.intense`, `$slate.intense`) breaks the rhythm. The page frame
uses `g($spacing.none)`; each section owns its vertical padding.

## Solid and gradient

80%+ of sections are a solid or a gradient. A dark solid between light
sections creates rhythm with no decoration; keep one tonal family (zinc
neutral, stone warm, slate cool). Gradient angle: `180` grounds, `135`
energizes, `0` lifts.

## Decorative treatments

One or two per page, matched to brand personality (most sections need
none): a faint diagonal stripe (rotated rect, `clip`, low opacity), a dot
grid, corner shapes, floating shapes, or glass cards over a rich
background.

A full-size uniform background is a fill on the section frame, never a
child rect (see `blueprint/paint`). Only a layer that needs independent
position or rotation becomes a real element: a `gr` overlay (outside
auto layout) or an `abs` child (inside it).

```
fr s(W,H) clip f[($color.surface)] "Section"
  gr s(W,H) "BG Effects"
    r s(W,H) f[(radial(cx(20),cy(15),$primary.soft,$color.surface))] "Glow"
  al(v,y(c),x(c),g($spacing.lg),pad($spacing.3xl)) s(W,H) "Content"
```

## Avoid

Large low-opacity circles behind content are the #1 AI background
cliché; the only exception is a single ambient glow in a dark or premium
hero, never repeated across sections.

## Presentation treatments

For showcasing a UI: flat, tilted (`rot(-3)`), a stack of 2-3 offset
rotated frames, browser chrome (a top bar with dots and a URL), or a
`clip`-ped preview with `rd($radius.lg)`.
