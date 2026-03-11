---
assumes: blueprint/effects
---
# Effect: Glass

Assumes: `blueprint/effects`

Glass is a **material that communicates spatial relationships** — it separates layers while maintaining visual connection. NOT decoration to slap on panels.

## Three Ingredients

| Ingredient | Job | Light mode | Dark mode |
|---|---|---|---|
| **Tint** (semi-transparent fill) | Materiality | `solid(#FFF,o(0.08-0.15))` | `solid(#000,o(0.25-0.50))` |
| **Blur** | Distance between layers | `blur(8-12)` lightweight | `blur(12-20)` frosted |
| **Edge** (stroke or inner glow) | Where glass ends | `st[(solid(#FFF,o(0.08-0.20)),w(1))]` | `glow(#FFF,o(0.08),blur(6))` |

## When to Use / When Not

**Use:** Over rich/colorful backgrounds. Floating elements connected to content below. 1-2 elevated premium elements.

**Don't:** Over solid/plain backgrounds (no depth to reveal). Every panel (hierarchy collapses). Minimal designs where space IS the effect.

## Basic Glass

```
f[(solid(#FFF,o(0.10))),(f2,blur(12))] st[(solid(#FFF,o(0.12)),w(1))]
```

## Glass + Inner Shadow (Thickness)

```
f[(solid(#FFF,o(0.10))),(f2,blur(12)),(f3,inner(#000,o(0.08),y(1),blur(3)))]
  st[(solid(#FFF,o(0.15)),w(1))] rd(16)
  shadow(#000,o(0.06),y(8),blur(24))
```

## Liquid Glass (Full Expression)

Every ingredient: tint + blur + inner glow for edge refraction + layered shadows for float:

```
f[(solid(#FFF,o(0.15))),(f2,blur(16)),(f3,glow(#FFF,o(0.12),blur(6)))]
  st[(solid(#FFF,o(0.20)),w(1))] rd(20)
  shadow(#000,o(0.04),y(2),blur(4)) shadow(#000,o(0.08),y(8),blur(24))
```

## Glass Over Shader (Signature Premium)

Animated shader underneath, frosted glass card on top:
```
fr s(1280,600) f[(#000),(f2,metal(...))] clip "Hero"
  al(v,a(c,c)) s(fill,fill)
    al(v,a(c,c),g(20),pad(40)) s(480,hug)
      f[(inner(#B6B6B6,o(0.40),y(2),blur(32))),(f2,blur(16))]
      st[(solid(#FFF,o(0.10)),w(1))] rd(9999) "Glass Card"
```

## Dark Mode Glass

Lower tint opacity (dark bg does contrast work):
```
f[(solid(#FFF,o(0.06))),(f2,blur(16))] st[(solid(#FFF,o(0.08)),w(1))]
```

Inner glow replaces border on dark surfaces:
```
f[(solid(#FFF,o(0.06))),(f2,blur(16)),(f3,glow(#FFF,o(0.08),blur(8)))]
```
