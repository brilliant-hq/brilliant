---
assumes: blueprint/paint
---
# Gradients: Linear

Assumes: `blueprint/paint`

Directional sweep across a surface. Simulates tilted plane of light.

## Syntax

```
(linear())                          — default: 180°, black→white
(linear(angle,#start,#end))         — two-color with angle
(linear(#start,#end))               — default 180°
(linear(angle,stop(#hex,pos),...))   — multi-stop with positions
```

## Angle Conventions

| Angle | Direction | Feeling |
|-------|-----------|---------|
| `180` | Top → bottom | Grounding, stable |
| `135` | Top-left → bottom-right | Energizing, dynamic |
| `0` | Bottom → top | Uplifting, aspirational |
| `90` | Left → right | Progressive, flow |

## Multi-Stop Gradients

Two stops feel flat. Three stops create depth with a "knee":

```
f[(linear(180,stop(#09090B,0),stop(#18181B,0.6),stop(#312E81,1)))]
```

**Dark hero with late color accent:**
```
f[(linear(135,stop(#09090B,0),stop(#09090B,0.5),stop(#1E1B4B,1)))]
```

## Per-Stop Opacity

Essential for overlays and fades:

```
f[(linear(180,stop(#000,0,o(0.4)),stop(#000,1,o(0.85))))]
```

Semi-transparent top, dark bottom — specify opacity on BOTH stops.

## Sparkline Area Fill Gradient

```
f[(linear(180,stop(#3B82F6,0,o(0.15)),stop(#3B82F6,1,o(0))))]
```

Same color, fades from 15% to 0% — polished chart fill.
