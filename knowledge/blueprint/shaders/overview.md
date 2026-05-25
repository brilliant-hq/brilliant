---
assumes: blueprint/paint
dsl: [uv, frozen]
---
# Shaders Overview

Four shaders simulate real materials, each a physical surface rather than
an abstract effect.

| Shader | Looks like |
|--------|-----------|
| `metaballs()` | organic blobs merging and parting, like a lava lamp |
| `metal()` | chrome with light-catching ridges and chromatic aberration |
| `irid()` | deep iridescent liquid crystal, shifting color bands |
| `steel()` | flowing mercury, smooth and reflective |

## Never put text on a shader

Shader patterns make text unreadable. Keep them apart: put the shader on
a **stroke** (solid fill for the text), or as a **background** with a
semi-transparent `solid()` stacked over it as a second fill, text in a
separate child. A shader background is a fill, never a child: put the
shader fill on the frame itself, never a separate
`r s(fill,fill) f[(shader(...))]`.

## Controls

`scale(N)` zoom, `uvx(N)`/`uvy(N)` pan, `uvrot(N)` rotate, `opacity(N)`,
`speed(N)` animation rate, `frozen` to stop animation,
`shape(none|circle|metaballs)` (metal, irid, steel). On small surfaces
like button strokes, `scale(2-4)` shows more detail than `scale(1)`. Keep
`speed` slow on backgrounds, faster on strokes.

## Colors and strokes

Shader colors are tokens like any other slot: brand stops for cohesive
accents, Tailwind stops for fixed meaning.

```
f[(metaballs($primary.subtle,$primary.mid,$primary.strong))]
f[(irid($pink.mid,$violet.mid,$indigo.mid))]
st[(steel($amber.mid,$amber.faint),w($stroke.width.mid))]
```

Strokes take every fill type, shaders included: a `metal()` chrome edge
or `irid()` shimmer border is one of the most underused looks. Metaballs
`size`/`count` density: see `blueprint/shaders/metaballs`.
