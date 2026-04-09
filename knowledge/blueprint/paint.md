---
assumes: blueprint/core
---
# Blueprint Paint

**Fills are your compositing system.** The fill stack works like a layer compositor — each fill renders in order. Tint, blur, glow, inner shadow, gradient warmth, shaders, dim overlays — these are all fill layers on the element itself. **NEVER create a separate child rectangle for a background, overlay, or tint — use a fill layer instead.** For positioned decorative content (badges, floating elements) inside auto layout, use `abs` on the child. For positioned content outside auto layout, use a group (`gr`). Neither is for backgrounds — those are always fills.

**WRONG — separate child elements for backgrounds:**
```text
fr s(340,480) rd($radius.lg) clip "Widget"
  r s(fill,fill) f[(metaballs(...))] "ShaderBG"          ← WRONG: should be a fill
  r s(fill,fill) f[(solid(#000,o(0.4)))] "DimOverlay"   ← WRONG: should be a fill
  al(...) "Content"
```
**RIGHT — fills stacked on the frame itself:**
```text
fr s(340,480) rd($radius.lg) clip f[(metaballs(...)),(f2,solid(#000,o(0.4)))] "Widget" #widget
  al(...) "Content" #content
```
This applies to shaders, solid tints, gradient backgrounds, dim overlays — anything that covers the full element. Fewer elements, cleaner hierarchy, correct semantics.

## Fills: `f[(spec),...]` — stack multiple, render in order

```
f[(#E11D48)]                                          ← solid hex
f[(solid(#F97316,o(0.5)))]                            ← solid with opacity
f[(linear(135,#8B5CF6,#EC4899))]                      ← linear gradient (angle,start,end)
f[(linear(180,stop(#09090B,0),stop(#1E1B4B,1)))]      ← multi-stop
f[(radial(#FFF,#000))]                                ← radial (center,edge)
f[(angular(#F59E0B,#EF4444))]                         ← angular/conic
f[(img(https://picsum.photos/id/42/800/400))]          ← image
f[(#F8FAFC),(f2,solid(#10B981,o(0.04)))]              ← multi-fill stacking
```

Fills are a compositing system — tint, blur, glow, shader, gradient stacked on one element:
```
al(v,g(10),pad(64)) s(hug,hug) f[(metaballs(#000,#FF3377,#FF9900,#FFDD00,#0080FF,count(10),size(0.30),speed(1)))] rd(16) clip "Backdrop"
  al(v,a(c,c),g(8),pad(24,32)) s(280,hug) f[(solid(#FFF,o(0.12))),(f2,blur(16)),(f3,glow(#FFF,o(0.15),blur(8)))] st[(linear(135,solid(#FFF,o(0.25)),solid(#FFF,o(0.05))),w(1))] rd(16) shadow(#000,o(0.08),y(8),blur(24)) "Glass Card"
    t("Glass Card",Inter,18,sb) f[(#FFF)]
    t("Five fill layers, one element",Inter,13) f[(solid(#FFF,o(0.6)))]
```

Radial positioning: `radial(cx(25),cy(15),r(50),#hex,#hex)`. Elliptical: `radial(rx(80),ry(40),#hex,#hex)`.
Avatars: `img(https://i.pravatar.cc/150?img={n})`. Shaders: `metaballs()`, `metal()`, `irid()`, `steel()`.

## Strokes: `st[(paint,w(N)),...]`

Strokes support ALL fill types — solid, gradients, shaders.

```
st[(#E5E7EB,w(1))]                                    ← solid 1px
st[(linear(90,#EC4899,#F59E0B),w(2))]                 ← gradient stroke
st[(metal(),w(2))]                                     ← shader stroke
```

Position: `pos(c|i|o)` center/inside/outside. Caps are per-node (on vector path endpoints) and per-circle (on arc endpoints), not per-stroke — set via the `cap` field on vector nodes: `n` none, `r` round, `sq` square, `ar` arrow.

## Region fills (vectors)

Vectors with multiple closed regions show `vr()` lines in blueprint output. Modify by region ID only — no geometry needed: `vr(rN) f[...]`.

## SVG icons
`svg(icon:house)` bundled Phosphor (kebab-case) · `svg(https://...)` URL · `svg(/tmp/file.svg)` local · `svg(<svg>...</svg>)` inline.
Fills on SVG lines override imported fills. **SVG fills are creation-only** — recolor after with `recolor_children` command.
