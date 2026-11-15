---
name: "knowledge-styling-blend-opacity"
description: "Blend modes at the element, fill, stroke and effect levels, pass through vs normal on containers, and opacity."
assumes: reference/styling
---

# Blend Mode and Opacity

Blend modes control how elements, fills, strokes, and effects composite against content below them. Available at four independent levels:

| Level | Where | Default |
|-------|-------|---------|
| **Element** | Right toolbar, Element section ("more" expandable subsection) | Normal |
| **Fill** | Right toolbar, per-fill row (expanded config) | Normal |
| **Stroke** | Right toolbar, per-stroke row (expanded config) | Normal |
| **Effect** | Right toolbar, per-effect row (expanded config) | Normal (Screen for glow) |

**18 blend modes:** Normal, Darken, Multiply, Color Burn, Plus Darker, Lighten, Screen, Color Dodge, Plus Lighter, Overlay, Soft Light, Hard Light, Difference, Exclusion, Hue, Saturation, Color, Luminosity. Plus Darker (Figma's Linear Burn) and Plus Lighter (Linear Dodge) sit with the darken/lighten families; in the Blueprint DSL they are `blend(plusDarker)` / `blend(plusLighter)`.

**Element-level** wraps the entire element (fills + strokes + effects) as a unit, then blends against the canvas. **Fill/stroke-level** blends each individual fill or stroke independently. Exactly like Figma, a blended fill reads everything already beneath it: the canvas plus the fills below it in the same element. Only an element with opacity below 100% or a non-Normal element blend flattens its own fills first, so there its fill blends see only the element's own fills.

## Groups and frames: Pass through vs Normal

Containers (groups, frames, auto layout) work like Figma. Their blend dropdown has one extra entry, **Pass through**, and it is the default:

- **Pass through** (default): the container does not flatten. A child with Multiply blends against everything beneath the container, and container opacity fades the composited result without breaking that interaction.
- **Normal**: the container is isolated. Its own fill plus all children flatten into one layer first, then that layer composites once against the canvas. A Multiply child only sees content inside the container.
- **Any other mode** (Multiply, Screen, ...): also isolated. The flattened container blends with the backdrop using that mode.

In the Blueprint DSL, the bare `isolate` flag on a `fr`/`gr`/`al()` line sets Normal (isolated); `no-isolate` returns to Pass through. An explicit `blend(mode)` on a container isolates it implicitly, exactly like Figma.

Blend modes are preserved across copy/paste, undo/redo, and all export formats (PNG, SVG, PDF). Copy to Figma and Figma import both keep the Pass through / Normal / blend-mode state of every container.

## Opacity

### Shortcuts

| Action | Shortcut |
|--------|----------|
| 0%–90% transparency | Cmd+Shift+0 through 9 |
| Increase transparency | Cmd+Shift+= |
| Decrease transparency | Cmd+Shift+- |

### UI

**Element-level opacity** is in the Element section of the right toolbar, on the same row as the rotation field. Drag or type a percentage (0%–100%).

**Fill/stroke opacity** is controlled by the opacity track in the color picker (affects the alpha of the focused fill or stroke color).
