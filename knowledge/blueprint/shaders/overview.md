---
assumes: blueprint/paint
---
# Shaders Overview

Assumes: `blueprint/paint`

Four shader types simulate real-world materials. Each is a physical surface, not an abstract effect.

| Shader | What it looks like |
|--------|--------------------|
| `metaballs()` | Organic blobs merging and separating, like a lava lamp or oil in water |
| `metal()` | Chrome surface with light-catching ridges and chromatic aberration |
| `irid()` | Deep iridescent liquid crystal with shifting color bands |
| `steel()` | Flowing mercury — smooth, reflective, industrial |

## CRITICAL: Never Place Text on Shaders

Shaders produce busy patterns that make text unreadable. Separate shader from text:

1. **Shader on stroke, solid fill for text** — `f[(#18181B)] st[(steel(),w(2))]`
2. **Shader as background with dim overlay** — stack shader + semi-transparent solid as fills on the SAME frame: `f[(metaballs(#0D1B3E,#1A3A5C)),(_,solid(#000,o(0.4)))]`
3. **Shader under solid fill** — `f[(#1C1917),(f2,steel(opacity(0.12)))]`
4. **Shader on decorative element** — accent bar beside text

**Shader backgrounds are fills, not child elements.** Never create a separate `r s(fill,fill) f[(shader(...))]` child as a background — put the shader fill directly on the frame. Add a dim overlay as a second fill layer, not a second child element.

## UV Controls (all types)

`scale(N)` zoom · `uvx(N)`/`uvy(N)` pan · `uvrot(N)` rotate pattern · `opacity(N)` shader opacity · `frozen` disable animation · `shape(none|circle|metaballs)` shape-aware (metal, irid & steel)

For button strokes, `scale(2-4)` often looks better than `scale(1)` — the zoomed pattern shows more detail on small surfaces.

## Speed Guide

| Shader | Background | Accents | Strokes |
|--------|-----------|---------|---------|
| `metaballs()` | `0.3-0.4` | `0.5-0.6` | `0.8-1.0` |
| `metal()` | `0.4-0.6` | `0.6-0.8` | `0.8-1.2` |
| `irid()` | `0.1-0.2` | `0.2-0.4` | `0.2-0.6` |
| `steel()` | `0.6-1.0` | `1.0-1.5` | `1.5-2.5` |

## Density (metaballs only)

Size and count are coupled — think in terms of density:

| Feel | Recipe |
|------|--------|
| Detailed, textured | `size(0.2),count(15)` |
| Balanced (default) | `size(0.5),count(7)` |
| Relaxed, organic | `size(0.7),count(5)` |
| Slow ambient | `size(0.85),count(4)` |

## Shader Strokes

Strokes support ALL fill types including shaders — one of the most underused capabilities:
- `st[(metal(),w(2))]` — chrome edge
- `st[(irid(),w(2))]` — iridescent shimmer border
- `st[(steel(#FFD700,#DAA520),w(2))]` — gold liquid steel border
