---
assumes: blueprint/core
---
# Blueprint Paint

**Fills are your compositing system.** The fill stack works like a layer compositor — each fill renders in order. Tint, blur, glow, inner shadow, gradient warmth — these are all fill layers on the element itself. If you find yourself creating a separate element behind another to add a visual effect, stop — it's almost certainly a fill layer. Group Overlay (`gr`) is for positioned content that needs independent size/rotation, not for backgrounds or effects.

## Fills: `f[(spec),...]` — stack multiple, render in order

```
f[(#3B82F6)]                                          ← solid hex
f[(solid(#3B82F6,o(0.5)))]                            ← solid with opacity
f[(linear(135,#8B5CF6,#EC4899))]                      ← linear gradient (angle,start,end)
f[(linear(180,stop(#09090B,0),stop(#1E1B4B,1)))]      ← multi-stop
f[(radial(#FFF,#000))]                                ← radial (center,edge)
f[(angular(#3B82F6,#8B5CF6))]                         ← angular/conic
f[(img(https://picsum.photos/id/42/800/400))]          ← image
f[(#F8FAFC),(f2,solid(#3B82F6,o(0.04)))]              ← multi-fill stacking
```

Complete elements with various fills:
```
al(v,g(8)) s(240,hug) "Fills"
  r s(fill,36) f[(linear(135,#8B5CF6,#EC4899))] rd(8) "Gradient"
  r s(fill,36) f[(#F1F5F9),(f2,solid(#3B82F6,o(0.08)))] st[(#3B82F6,w(1))] rd(8) "Multi-fill + stroke"
```

Radial positioning: `radial(cx(25),cy(15),r(50),#hex,#hex)`. Elliptical: `radial(rx(80),ry(40),#hex,#hex)`.
Avatars: `img(https://i.pravatar.cc/150?img={n})`. Shaders: `metaballs()`, `metal()`, `holo()`, `steel()`.

## Strokes: `st[(paint,w(N)),...]`

Strokes support ALL fill types — solid, gradients, shaders.

```
st[(#E5E7EB,w(1))]                                    ← solid 1px
st[(linear(90,#3B82F6,#8B5CF6),w(2))]                 ← gradient stroke
st[(metal(),w(2))]                                     ← shader stroke
```

Caps: `cap(start,end)` — `n` none · `r` round · `sq` square · `ar` arrow. Position: `pos(c|i|o)` center/inside/outside.

## Region fills (vectors)

Vectors with multiple closed regions show `vr()` lines in blueprint output. Modify by region ID only — no geometry needed: `vr(rN) f[...]`.

## SVG icons
`svg(icon:house)` bundled Phosphor (kebab-case) · `svg(https://...)` URL · `svg(/tmp/file.svg)` local.
Fills on SVG lines override imported fills. **SVG fills are creation-only** — recolor after with `recolor_children` command.
