---
assumes: blueprint/core
dsl: [solid, metaballs, metal, irid, steel]
---
# Blueprint Paint

`f[(...)]` is a compositing stack: list multiple fills and they render in
order (tints, gradients, blurs, glows, shaders, dim overlays are all fill
layers). Never make a separate child rectangle for a background or
overlay; stack it as another fill on the frame itself.

## Fills

```
f[($color.primary)]                                 semantic role, mode-flips
f[(solid($color.secondary,o($visibility.mid)))]     role + opacity
f[(linear(135,$violet.mid,$pink.mid))]              linear gradient
f[(radial($color.surface,$color.on-surface))]       radial gradient
f[(angular($amber.mid,$red.mid))]                   angular gradient
f[(metaballs($primary.soft,$primary.mid,$primary.bold))]  shader
f[(img(https://picsum.photos/id/42/800/400))]       image
f[($neutral.intense),(f2,solid($primary.mid,o($visibility.soft)))]  stacked
```

Every color slot takes a `$token` (solid fills, gradient stops, shader
colors, effect colors); token-bound stops follow brand and mode, and bare
hex is rejected (see `design-systems/core`). Radial accepts placement:
`radial(cx(25),cy(15),r(50),$primary.mid,$primary.intense)`.

## Strokes

`st[(paint,w(N)),...]` takes every fill type (solids, gradients, shaders)
with token stops, exactly like `f[]`.

```
st[($color.outline.variant,w($stroke.width.subtle))]
st[(linear(90,$pink.mid,$amber.mid),w($stroke.width.mid))]
st[(metal($amber.mid,$amber.faint),w($stroke.width.mid))]
```

`pos(c|i|o)` aligns the stroke center / inside / outside. Caps are set
per node (vector endpoints) and per circle, not on the stroke.

## SVG icons & region fills

`svg(icon:house)` bundled Phosphor (kebab-case), `svg(https://...)` URL,
`svg(/path)` local, `svg(<svg>...)` inline. A fill on the `svg` line
overrides imported fills (creation-only; recolor later with the
`recolor_children` command). On a vector with multiple closed regions,
`vr(rN) f[...]` fills one region by ID.
