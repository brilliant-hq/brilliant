---
assumes: blueprint/effects
---
# Design Shadows

Assumes: `blueprint/effects`

## Rules

Every shadow needs two layers — key light (directional, tight, with offset) + ambient (soft spread, little offset). Single `shadow()` looks fake. Never pure black — use 0.04-0.10 opacity. Consistent direction throughout design. If you can obviously see the shadow, it's too strong. Higher elevation = more important = more interactive.

## Elevation Scale

**Low** (resting cards, inputs):
```
shadow(#000,o(0.04),y(1),blur(2)) shadow(#000,o(0.06),blur(12))
```

**Medium** (active cards, modals):
```
shadow(#000,o(0.05),y(2),blur(4)) shadow(#000,o(0.08),y(8),blur(24))
```

**High** (popovers, dropdowns, floating):
```
shadow(#000,o(0.06),blur(6)) shadow(#000,o(0.10),y(12),blur(32)) shadow(#000,o(0.05),y(20),blur(48))
```

## Colored Shadows

Tint shadow to match element's fill — looks like colored light cast onto surface:
```
shadow(#3B82F6,o(0.10),y(2),blur(4)) shadow(#3B82F6,o(0.08),y(8),blur(20))
```

On dark backgrounds, colored shadows double as ambient glow — increase opacity (0.12-0.20).
