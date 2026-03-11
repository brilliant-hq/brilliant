---
assumes: blueprint/paint
---
# Design Gradients

For gradient syntax, see `blueprint/paint` and `blueprint/gradients/*`.

## When to Use

Gradient CTAs = **never** (solid only — gradient CTAs are the #1 AI tell). Hero bg = maybe (subtle tonal shift). Card accent bar = maybe (small surface). Sparkline fill = yes (fading to transparent). Every surface = no (modern design = solid + whitespace).

## Direction = Mood

`180` grounding · `135` energizing · `0` uplifting · `90` progressive

## Multi-Stop Knee

Two stops feel flat. Three create depth — the middle stop shifts character:
```
f[(linear(180,stop(#09090B,0),stop(#18181B,0.6),stop(#312E81,1)))]
```

## Gradient + Effect Stacking

Gradient base + low-opacity shader for organic texture:
```
f[(linear(135,#831843,#9F1239)),(f2,metaballs(#9F1239,#BE185D,opacity(0.15),speed(0.2)))]
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

Subtle depth `linear(180,#F8FAFC,#E2E8F0)` · premium dark `linear(180,#0F172A,#1E293B)` · warm energy `linear(135,#F59E0B,#F43F5E)` · ocean calm `linear(90,#14B8A6,#3B82F6)` · tech depth `linear(180,#0F172A,#334155)`.
