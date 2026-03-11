---
assumes: blueprint/paint
---
# Gradients: Angular

Assumes: `blueprint/paint`

Colors sweep around a center point (conic/sweep). Like a color wheel or light refracting through a prism.

## Syntax

```
(angular())                                    — default: centered, black→white
(angular(#start,#end))                         — two-color
(angular(cx,cy,ax,ay,stop(#hex,pos),...))       — full control
(angular(cx,cy,ax,ay,w(wx,wy),stop(#hex,pos),...))  — elliptical
```

## Use Cases

**Progress rings** — angular gradients naturally follow circular paths:
```
st[(angular(#3B82F6,#8B5CF6),w(4),cap(r,r))] arc(90,84) ratio(1)
```

**Metallic/holographic sheen** — close hues create brushed-metal look:
```
f[(angular(stop(#C0C0C0,0),stop(#E8E8E8,0.25),stop(#A0A0A0,0.5),stop(#D0D0D0,0.75),stop(#C0C0C0,1)))]
```

**Badge accents** — small angular on circular elements creates gem-like refraction:
```
al(h,a(c,c)) s(32,32) f[(angular(#3B82F6,#8B5CF6,#EC4899,#3B82F6))] rd(9999) "Badge"
```

## When to Reach for Angular

- Progress rings and gauges
- Metallic/holographic sheen on circular shapes
- Color wheel / spectrum displays
- Badge and icon accents on circular elements
