---
name: "knowledge-styling-colors"
description: "Quick color shortcuts, the color formats, and typing hex values."
assumes: reference/styling
---

# Colors

## Quick Color Shortcuts

| Color | Shortcut |
|-------|----------|
| Red | Ctrl+R |
| Green | Ctrl+G |
| Blue | Ctrl+B |
| Yellow | Ctrl+Y |
| Orange | Ctrl+O |
| Purple | Ctrl+P |
| White | Ctrl+W |
| Black | Ctrl+K |
| Dark gradient | Ctrl+D |
| Light gradient | Ctrl+L |

These quick color chords are macOS-only. On Windows they are disabled: the Ctrl chords collide with the standard editing commands (Ctrl+B Bold, Ctrl+G Group, Ctrl+R Rename, and so on), so set color via the inspector or the palette instead.

## Color Formats

The value field's Format menu offers these formats:

| Format | Example | Description |
|--------|---------|-------------|
| Hex | `FF5733` | 6-digit uppercase hex (no `#` shown; typing one is fine). |
| RGB | `255  87  51` | Red, green, blue (0 to 255). |
| HSL | `11  100  60` | Hue (0 to 360), saturation and lightness (0 to 100). |
| HSB | `11  80  100` | Hue (0 to 360), saturation and brightness (0 to 100). |
| OKLCH | `68.0  0.210  33.7` | Lightness (percent), chroma (0 to 0.4, three decimals) and hue (0 to 360), the perceptual space design tokens are built in. A color outside what screens show is brought inside by lowering its chroma, keeping its lightness and hue; the field then shows the color you got. |
| CSS | `rgb(255 87 51 / 50%)` | One CSS color: `rgb()` / `rgba()`, `hsl()`, `oklch()` or `#hex`. An alpha written in it sets the opacity (so this format has no separate opacity cell). Enter applies. |

Each number is typed (Enter applies, one undo step) or stepped with the arrow keys; the numbers have no leading symbol, so a drag in them selects text rather than scrubbing. A value the field cannot read is ignored and the field shows the color again.

**Typing a hex value** works the same in the picker's Hex field and in every hex field of the right toolbar (fills, strokes, gradient stops, shader colors, the canvas background, effects): 6 digits (`FF5733`), or 8 digits with the alpha last (`FF573380` sets 50% opacity); the CSS 3-digit shorthand (`F80` is `FF8800`); 1 or 2 characters repeat (`F` is white, `AB` is `ABABAB`). A leading `#` is optional and case does not matter. Any other length (4 or 5 digits) is ignored and the field keeps its value. Without a typed alpha the opacity stays as it was. A percent field (any opacity) reads `50%` as 50%.

The picker always shows the color as it renders in the current mode and brand: a token-bound color opens on its resolved color, and an open picker follows a mode switch, an undo or an AI edit. A gray, black or white opens with the hue thumb at the left (0 degrees). Selecting elements with different colors while the picker is open closes it; selecting elements that share one color moves it to them.

Color tokens are resolved at render time; the picker always shows the resolved color in the chosen format.
