---
assumes: blueprint/paint
---
# Shaders Overview

Assumes: `blueprint/paint`

Four shader types simulate real-world materials. Each is a physical surface, not an abstract effect.

| Shader | Material | Mood | Best for |
|--------|----------|------|----------|
| `metaballs()` | Lava lamp, oil-in-water | Organic, playful | Creative tools, gaming, music |
| `metal()` | Chrome, brushed aluminum | Premium, luxury | Fashion, jewelry, fintech |
| `holo()` | Holographic foil | Futuristic, trendy | Web3, tech startups |
| `steel()` | Liquid mercury | Industrial, professional | SaaS, enterprise, automotive |

## CRITICAL: Never Place Text on Shaders

Shaders produce busy patterns that make text unreadable. Separate shader from text:

1. **Shader on stroke, solid fill for text** — `f[(#18181B)] st[(steel(),w(2))]`
2. **Shader as background with dim overlay** — stack shader + semi-transparent solid as fills on the SAME frame: `f[(metaballs(#0D1B3E,#1A3A5C)),(_,solid(#000,o(0.4)))]`
3. **Shader under solid fill** — `f[(#1C1917),(f2,steel(opacity(0.12)))]`
4. **Shader on decorative element** — accent bar beside text

**Shader backgrounds are fills, not child elements.** Never create a separate `r s(fill,fill) f[(shader(...))]` child as a background — put the shader fill directly on the frame. Add a dim overlay as a second fill layer, not a second child element.

## UV Controls (all types)

`scale(N)` zoom · `uvx(N)`/`uvy(N)` pan · `uvrot(N)` rotate pattern · `opacity(N)` shader opacity · `frozen` disable animation · `shape(none|circle|metaballs)` shape-aware (metal & holo)

## Speed Rule

Larger surface → slower speed. Small badge at `speed(2)` is fine. Full hero at `speed(2)` is nauseating.

| Context | Speed |
|---------|-------|
| Behind text | `0.2-0.4` |
| Hero background | `0.5-1.0` |
| Small accents | `1.0-2.0` |
| Atmospheric | `0.1-0.3` |
| Static export | `frozen` |

## Shader Strokes

Strokes support ALL fill types including shaders — one of the most underused capabilities:
- `st[(metal(),w(2))]` — chrome edge
- `st[(holo(intensity(0.5)),w(2))]` — rainbow shimmer border
- `st[(steel(#FFD700,#DAA520),w(2))]` — gold liquid steel border
