---
assumes: blueprint/paint
---
# Design Backgrounds

## Section Background Alternation

The #1 technique for multi-section pages. Alternate 2-3 tones. No two adjacent sections share the same background:

```
Navbar    f[(#FFFFFF)]
Hero      f[(#FFFFFF)]
Logos     f[(#FAFAFA)]       ← tinted (zinc-50)
Features  f[(#FFFFFF)]
Stats     f[(#F4F4F5)]       ← deeper tint (zinc-100)
CTA       f[(#18181B)]       ← dark accent
Footer    f[(#FAFAFA)]
```

Parent frame uses `g(0)` — sections manage their own vertical padding.

## Solid & Gradient (80%+ of sections)

**Solid:** A dark solid between white sections creates rhythm without decoration. Vary tonal family: zinc (neutral), stone (warm), slate (cool).

**Gradient sweep:** `180` grounds, `135` energizes, `0` lifts. Same tonal family.

## Decorative Treatments (1-2 per page max)

Match to brand personality. Most sections don't need these.
Diagonal stripe (bold, SaaS — rotated rect in group overlay with `clip`, -8° to -12°, 0.04-0.08 opacity) · dot grid (technical — 4x4px circles, 40-60px apart, 0.06-0.15 opacity) · corner shapes (luxury — 1-3 shapes tucked into corners, 0.03-0.06 filled) · floating shapes (dev tools, SaaS) · glassmorphism (cards over rich backgrounds).

## Backgrounds Are Fills, Not Child Elements

**Solid colors, gradients, shaders, and dim overlays belong in the fill stack** — never as separate child rectangles. Stack multiple fills on the frame itself:
```
fr s(W,H) f[(metaballs(...)),(f2,solid(#000,o(0.4)))] clip "Section"
  al(...) "Content"
```

## Positioned Decorative Layers (glow, texture)

Decorative elements that need **independent positioning** (off-center radial glows, positioned texture rects, rotated shapes) use a group overlay — but only when a fill can't express the effect:

```
fr s(W,H) f[(bg)] clip "Section"
  gr p(0,0) s(W,H) "BG Effects"        ← group: free positioning, no layout flow
    r p(0,0) s(W,H) f[(radial(...))]    ← decorative layer 1 — needs custom position
    r p(0,0) s(W,H) f[(radial(...))]    ← decorative layer 2 — needs custom position
  al(v,a(c,c),g(N),pad(...)) p(0,0) s(W,H) "Content"  ← content overlaps group
    ...structured content...
```

**Rule of thumb:** if the "background" is full-size and uniform → fill layer. If it needs position/rotation/size independent from the frame → group overlay child.

## DO NOT

**No ambient glow circles.** Large low-opacity circles behind content is the #1 AI background cliche. Exception: single ambient touch in dark/premium hero — never repeated across sections.

## Presentation Treatments

Flat · tilted `rot(-3)` or `skew(-8,0)` · stacked 2-3 offset frames with rotation · browser chrome (top bar with dots + URL) · clipped preview `clip` + `rd(12)`.
