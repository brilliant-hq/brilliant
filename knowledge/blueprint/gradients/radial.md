---
assumes: blueprint/paint
---
# Gradients: Radial

Assumes: `blueprint/paint`

Point-source light — spotlights, glowing orbs. Creates focal gravity that linear cannot.

## Syntax

```
(radial())                              — default: centered, white→black
(radial(#center,#edge))                 — two-color
(radial(solid(#hex,o(0.3)),solid(#hex,o(0))))  — with opacity
(radial(cx(25),cy(15),r(50),#hex,#hex)) — positioned (cx/cy: 0=left/top, 50=center; r: 50=edge)
(radial(rx(80),ry(40),#hex,#hex))       — elliptical
(radial(cx,cy,rx,ry,stop(#hex,pos),...)) — positional with stops
```

## Key Patterns

**Ambient glow** — off-center, low opacity, brand-tinted. Layer 2-3 for simulated mesh:
```
f[(radial(-0.5,-0.5,0.5,0.5,stop(#312E81,0,o(0.25)),stop(#312E81,1,o(0))))]
```

**Vignette** — transparent center, dark edges:
```
f[(radial(0,0,1,1,stop(#000,0,o(0)),stop(#000,0.6,o(0)),stop(#000,1,o(0.7))))]
```

**Elliptical accent** — wider-than-tall using `w()`:
```
f[(radial(0,0,0,-1,w(1,0),stop(#3B82F6,0,o(0.3)),stop(#3B82F6,1,o(0))))]
```

**Radial + linear stack** — linear sets mood, radial adds highlight:
```
f[(linear(135,#09090B,#1E1B4B)),(f2,radial(0.3,-0.3,0,-1,stop(#6366F1,0,o(0.15)),stop(#6366F1,1,o(0))))]
```

## Instincts

- **Off-center by default.** Centering every radial is an amateur tell.
- **Elliptical over circular.** Real light pools stretch. Use `w()`.
- **Layer, don't overload.** Two at 15% > one at 30%.
