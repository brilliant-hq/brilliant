---
name: "knowledge-shaders-colors-transform"
description: "Shader colors and the Transform section that maps the pattern inside the element."
assumes: reference/shaders
---

# Shader Colors and Transform

## Colors

- Each shader takes a set of colors (2 to 5 depending on the type), shown as swatches in a Colors section of the expanded view.
- Click a swatch to edit it in the color picker. Under its color area the picker shows the shader menu (hover a shader to preview it, click to apply), and below it the shader's colors on their own row: click a color to edit it. A dashed **+** after the colors adds one (it is the color being edited next); the dashed **−** after it removes the selected color (it dims when only one color is left). The count on the right reads like "3 / 5" (colors used / the shader's maximum), and "5 / 5 · max" at the limit, where the **+** is gone. Each add or remove is one undo step.
- In the right toolbar, add or remove colors with the +/- controls. Either way a shader keeps between 1 color and its maximum.
- A shader color can be bound to a design system color token, so it follows mode/brand changes. See `reference/design-systems`.

## Transform (UV Mapping)

Every shader fill or stroke has a **Transform** section that adjusts how the pattern maps inside the element, independent of the element's own position, size, and rotation. The element boundary stays put; only the procedural texture inside it moves.

| Control | Range | Default | Effect |
|---------|-------|---------|--------|
| **Scale** | 0.01–4.0 | 1.0 | Zoom the pattern in/out |
| **Offset X** | -1.0–1.0 | 0.0 | Pan the pattern horizontally |
| **Offset Y** | -1.0–1.0 | 0.0 | Pan the pattern vertically |
| **Rotation** | 0–360° | 0° | Rotate the pattern |

**Where Rotation appears:** every shader has Scale, Offset, and Rotation. Rotation lives in the Transform section, except for the shape-bearing shaders (Liquid Metal, Iridescent, Liquid Stainless Steel, and Dithering, all of which carry a Shape parameter), where it appears among the parameter sliders instead.

**Cmd-resize / Ctrl-resize compensation:** when you resize an element while holding Command (macOS) or Ctrl (Windows), the shader pattern stays fixed in world space. The element boundary reveals more or less of the pattern instead of stretching it, mirroring image crop compensation. During a normal resize the pattern distorts with the element.
