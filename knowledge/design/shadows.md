---
assumes: blueprint/effects
---
# Design Shadows

Assumes: `blueprint/effects`

## Rules

Every shadow needs two layers, key light (directional, tight, with offset) + ambient (soft spread, little offset). Single `shadow()` looks fake. Never pure black, use 0.04-0.10 opacity. Consistent direction throughout design. If you can obviously see the shadow, it's too strong. Higher elevation = more important = more interactive.

## Elevation Scale

**Low** (resting cards, inputs):
```
shadow($neutral.intense,o($visibility.faint),y(1),blur(2)) shadow($neutral.intense,o($visibility.faint),blur(12))
```

**Medium** (active cards, modals):
```
shadow($neutral.intense,o($visibility.faint),y(2),blur(4)) shadow($neutral.intense,o($visibility.subtle),y(8),blur(24))
```

**High** (popovers, dropdowns, floating):
```
shadow($neutral.intense,o($visibility.faint),blur(6)) shadow($neutral.intense,o($visibility.subtle),y(12),blur(32)) shadow($neutral.intense,o($visibility.faint),y(20),blur(48))
```

## Colored Shadows

Tint shadow to match element's fill, looks like colored light cast onto surface:
```
shadow($violet.mid,o($visibility.faint),y(2),blur(4)) shadow($violet.mid,o($visibility.faint),y(8),blur(20))
```

On dark backgrounds, colored shadows double as ambient glow, increase opacity (0.12-0.20).
