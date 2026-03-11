---
assumes: blueprint/paint
---
# Blueprint Effects

Two systems — don't mix them up.

## Element-level (standalone properties)
```
shadow(#000,o(0.06),y(2),blur(8))                          ← drop shadow
shadow(#000,o(0.04),blur(4)) shadow(#000,o(0.10),y(8),blur(24))  ← layered
outerglow(#3B82F6,o(0.3),blur(16))                         ← outer glow
eblur(4)                                                    ← element blur
```

Params (all optional): `#hex` color · `o(N)` opacity · `x(N)` · `y(N)` offsets · `blur(N)` · `sp(N)` spread · `blend(mode)`. Stack multiple on one element.
Defaults — `shadow()`: #000 o(0.25) y(4) blur(8). `outerglow()`: #FFF o(0.6) blur(8).

Complete card with layered elevation:
```
al(v,g(12),pad(20)) s(300,hug) f[(#FFF)] rd(12) shadow(#000,o(0.04),y(1),blur(2)) shadow(#000,o(0.08),y(8),blur(24))
  t("Elevation",Inter,16,sb) f[(#0F172A)]
  t("Two-layer shadow creates realistic depth",Inter,14) s(fill,hug) f[(#64748B)]
```

## Fill-type (inside `f[...]` array)
```
f[(#F1F5F9),(f2,inner(#000,o(0.06),y(1),blur(2)))]         ← inner shadow
f[(#1E1E2E),(f2,glow(#3B82F6,o(0.7),blur(8)))]             ← inner glow
f[(solid(#FFF,o(0.10))),(f2,blur(12))]                      ← background blur (glass)
```

Fill-type effects stack with other fills in z-order. If you're tempted to create a separate element for a visual effect, it's almost certainly a fill layer instead.
