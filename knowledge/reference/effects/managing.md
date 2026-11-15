---
name: "knowledge-effects-managing"
description: "Managing effects on the Effects section and Fills section rows, plus effect tips."
assumes: reference/effects
---

# Managing Effects

## Effects section (Drop Shadow / Outer Glow / Element Blur)

The effect row's controls, left to right: a color swatch (drop shadow and outer glow only; tap to open the color picker) or blur icon, an inline opacity % field, an expand toggle, and a remove (minus) button.

| Action | How |
|--------|-----|
| Remove | Click the minus button on the row |
| Toggle visibility | Expand the row, then click the eye icon in the expanded body |
| Expand properties | Click the expand (sliders) toggle on the row to show/hide the property fields |
| Change type | Use the type dropdown on the row (Drop Shadow / Outer Glow / Element Blur) |
| Edit color | Tap the color swatch on the row, or use the hex/token field in the expanded body (drop shadow and outer glow only) |
| Set blend mode | Use the inline blend-mode dropdown in the expanded body (drop shadow and outer glow only) |
| Reorder | When 2+ effects exist, drag a row to reorder. The list is shown topmost-first; the top row is the highest in render order |

With 2 or more effects, the rows become drag-reorderable; a single effect has no drag handle. When multiple elements are selected, the Effects section displays the **first selected element's** effects, but edits apply across the whole selection.

## Fills section (Inner Shadow / Inner Glow / Background Blur)

| Action | How |
|--------|-----|
| Remove | Click the delete button on the fill row |
| Edit color | Tap the color swatch on the row, or use the hex/token field in the expanded body (inner shadow and inner glow only; background blur has no color) |
| Edit parameters | Expand the fill row, then adjust the numeric fields. Background blur shows only a radius field |
| Set blend mode | Inline blend-mode field beside the color in the expanded body (inner shadow and inner glow only) |
| Change type | Use the fill type dropdown (shared with solid/gradient/image/shader/filter types) |
| Reorder | Drag the fill row to change z-order relative to other fills |

## Tips

- **Subtle UI shadows:** small Y offset (2) and small blur (4) with low opacity (10-20%).
- **Elevation hierarchy:** stack multiple drop shadows with increasing offset and blur for material depth.
- **Frosted glass:** a Background Blur fill plus a semi-transparent solid fill above it (white at 30-50%).
- **Neon glow:** Outer Glow with a bright color, high blur (12+), and Screen blend mode.
- **Inset / pressed look:** Inner Shadow with a small Y offset and low opacity.
- **Custom depth:** place an Inner Shadow between two solid fills to control where the inset appears in the stack.
