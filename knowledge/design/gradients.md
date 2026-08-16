---
assumes: blueprint/paint
---
# Design Gradients

For gradient syntax, see `blueprint/paint` and `blueprint/gradients/*`.

## When to Use

Gradient CTAs = **never** (solid only, gradient CTAs are the #1 AI tell). Hero bg = maybe (subtle tonal shift). Card accent bar = maybe (small surface). Sparkline fill = yes (fading to transparent). Every surface = no (modern design = solid + whitespace).

## The Four Kinds

Linear is the default and the safe one. The other three are for specific moods; reach for them sparingly. Syntax for each is in `blueprint/gradients/*`.

- **Radial**: a point-source glow (spotlight, orb, focal gravity). Off-center by default.
- **Angular** (sweep): progress rings, gauges, and metallic/holographic sheen on round shapes.
- **Diamond**: a hard-edged, four-point rhombus falloff for a faceted, gem-like radiate where a radial reads too soft. A crystal, a jewel badge, a sparkle. A first-class kind now, so it survives Figma import and round-trips losslessly (no more silent flattening to a solid color).

**Linear shear.** Linear carries an optional third handle (`w(wx,wy)`) that skews the color bands off perpendicular. Rare in original work, but it imports faithfully from Figma now (a sheared linear no longer straightens on the way in). Use it only to match a source, or for a deliberate skew on a large surface.

## Direction = Mood

`180` grounding · `135` energizing · `0` uplifting · `90` progressive

## Multi-Stop Knee

Two stops feel flat. Three create depth, the middle stop shifts character.
Use design tokens so the gradient follows brand + mode switches:
```
f[(linear(180,stop($zinc.intense,0),stop($zinc.intense,0.6),stop($indigo.intense,1)))]
```

## Gradient + Effect Stacking

Gradient base + low-opacity shader for organic texture. Stops are tokens like every other slot, see `design-systems/core` "Modes":
```
f[(linear(135,$pink.intense,$rose.intense)),(f2,metaballs($rose.intense,$pink.bold,opacity(0.15),speed(0.2)))]
```

## Rules

1. **Default is no gradient.** Only add when it genuinely improves.
2. **Never gradient a CTA.** Solid dark or solid accent.
3. **Never blue-purple.** The most recognizable AI gradient.
4. **One good color, shifted.** Blue-to-slightly-more-purple always beats blue-to-orange.
5. **One gradient per visual group.** Don't compete.
6. **Per-stop opacity for overlays.** Specify on BOTH stops.
7. **Angle matches reading direction.**

## By Mood

Subtle depth `linear(180,$slate.hint,$slate.subtle)` · premium dark
`linear(180,$slate.intense,$slate.strong)` · warm energy
`linear(135,$amber.mid,$rose.mid)` · ocean calm
`linear(90,$teal.mid,$blue.mid)` · tech depth
`linear(180,$slate.intense,$slate.bold)`.
