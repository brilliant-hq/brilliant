---
assumes: effects/glass
---
# Effect: Liquid Glass Params

| Param | Default | Range | Effect |
|---|---|---|---|
| `frost` | 0 | ≥0 | backdrop blur sigma (0 = crisp pane) |
| `thickness` | 64 | 0..64 | slab depth; how far light bends (0 = plain blur, no refraction) |
| `bevel` | 60 | 0..120 | rim band width where the lens rises |
| `ior` | 3 | 1..3 | index of refraction; higher bends more |
| `chroma` | 0.8 | 0..3 | chromatic fringe at the rim (1 = strong; >1 = extreme dispersion) |
| `glow` | 0 | 0..1 | luminous rim glow (light added: over a dark backdrop it lifts the rim, a clear pane keeps it 0) |
| `edge` | 0 | 0..1 | specular rim highlight (light added, same note as glow) |
| `angle` | 135 | degrees | light direction (135 = top-left) |
| `sat` | 1.05 | 0..2 | backdrop saturation remix (vibrancy) |
| `tint` | clear | - | `$token`/`#hex` + `o($visibility.*)` |

Out-of-range values clamp with a diagnostic; unknown params are dropped and
surfaced. Glass is fill-only, `glass` in `st[...]` is an error.

Tint takes a `$token` (resolved at create time) or `#hex`, with opacity as a
`$visibility.*` token, its alpha is the tint strength (clear by default):

```
f[(glass(tint($color.surface,o($visibility.soft)),frost(12)))]   light frosted tint
```

## Scene

Glass card over a shader backdrop. The card carries the `glass` fill and a
faint bright edge; text lives in children with their own solid fills (never
draw text directly onto the refraction).

```
fr s(640,400) clip f[(metaballs($violet.mid,$pink.mid,$amber.mid,$primary.mid))] rd($radius.lg) "Hero"
  al(v,y(c),x(c),g($spacing.sm),pad($spacing.lg)) p(c,c) s(360,hug) f[(glass(frost(8),chroma(0.4)))] st[(solid($color.glow,o($visibility.subtle)),w($stroke.width.subtle))] rd($radius.lg) "Card"
    t("Liquid Glass",$font.family,$font.size.xl,sb) f[($color.glow)] "Title"
    t("Refracts the backdrop through a real glass slab.",$font.family,$font.size.sm,r) s(fill,hug) f[(solid($color.glow,o($visibility.firm)))] "Sub"
```

## Notes

- **Backdrop matters.** More texture and contrast under the glass = more
  visible refraction. Add `shadow(...)` under the card to float it.
- **`o()` fades the whole pane** like any element: `o(0)` is absent, `o(0.5)`
  is half the pane over the backdrop. Tween it in motion like any opacity.
- **Dark scenes:** use `$color.glow` (mode-immune near-white) for the edge
  stroke and text; a low-opacity dark `tint` deepens the smoke look.
