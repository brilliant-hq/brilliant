---
name: "knowledge-effects-adding"
description: "Adding drop shadow, outer glow, element blur, and the inner effect fills, from the inspector or the palette."
assumes: reference/effects
---

# Adding Effects

## Drop Shadow, Outer Glow, Element Blur

Click the **+** button on the Effects section header in the right toolbar. The first add inserts a **drop shadow** with default settings (the + button is not a type chooser). To change the type, use the type dropdown on the effect row (Drop Shadow / Outer Glow / Element Blur). Switching type resets the effect to that type's defaults.

## Inner Shadow, Inner Glow, Background Blur

These are fill types, so add them through the Fills section. They are fill-only: a stroke's type dropdown has no Effect or Filter group.

1. Click **+** in the Fills section to add a fill.
2. Open the fill row's type dropdown and select the effect type. The "Effect" group lists Liquid Glass, Inner Shadow, Inner Glow, and Background Blur, in that order.

## Via palette

Open the palette (Cmd+Shift+P) and run any of these by name:

| Command |
|---------|
| Add Drop Shadow |
| Add Outer Glow |
| Add Element Blur |
| Add Inner Shadow |
| Add Inner Glow |
| Add Background Blur |
| Add Color Adjust |

> For Blueprint DSL authoring of effects (the compact syntax of a `bl` fence), see the blueprint knowledge files. Do not author DSL from this reference.
