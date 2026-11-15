---
name: "knowledge-effects-fill-properties"
description: "Inner shadow, inner glow and background blur fill properties, ranges and defaults."
assumes: reference/effects
---

# Effect Fill Properties

## Inner Shadow (fill)

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 2 |
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 100% | 50% |
| Blend Mode | Any | Normal |

## Inner Glow (fill)

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 100% | 60% |
| Blend Mode | Any | Screen |

Inner glow has no offset fields (unlike inner shadow). Use spread for size and blur for softness.

## Background Blur (fill)

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 8 |

Background blur has no color, no opacity, and no blend mode. The radius field is the only control. Pair it with a low-alpha solid fill above it for the standard frosted-glass look.
