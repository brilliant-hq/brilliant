---
name: "knowledge-frames-auto-layout-sizing"
description: "Hug, Fill and Fixed sizing for auto layout children and frames, auto-conversion to Fixed, and when to use each mode."
assumes: reference/frames
---

# Auto Layout Sizing

## Child Sizing Modes

Set via **W Sizing** and **H Sizing** dropdowns in the right toolbar's **Element** section.

| Mode | Description |
|------|-------------|
| Hug | Use natural content size |
| Fill | Expand to fill remaining space |
| Fixed | Use explicit size |

**Hug** is offered when all selected elements are frames or text. **Fill** is offered when any selected element is inside a frame parent. Otherwise only Fixed is offered.

**Auto-conversion to Fixed:** Manually resizing or rotating a child converts it to **Fixed** at its current dimensions. **Fill also freezes to Fixed (at the current rendered size) when an element leaves auto-layout:** moved or reparented to the canvas, a plain Frame, Group, Mask, or Boolean, or dragged within a plain Frame. Only the Fill axes change; Hug/Fixed axes are kept. Fill is preserved **only** when the destination is another Auto Layout frame. So do not assume a Fill element stays Fill after it leaves an auto-layout parent; change the dropdown back to Fill if needed.

### When to Use Each Mode

| Use Case | Width | Height |
|----------|-------|--------|
| Label / value text (numbers, metrics, units, dates, nav items, section headers) | Hug | Hug |
| Prose / body / descriptions (should wrap) | Fill | Hug |
| Button | Hug | Hug |
| Icon / avatar | Fixed | Fixed |
| Input field | Fill | Fixed |
| Sidebar | Fixed | Fill |
| Content area | Fill | Fill or Hug |
| Full-width section | Fill | Hug |
| Siblings that should match dimension | Fill | Fill (cross-axis Fill stretches to match tallest/widest sibling) |

Text on Hug width does not wrap (it renders at its natural single-line width). Set width to Fill for text that should wrap. With multiple text elements in a horizontal row (label + value, bullet + item), put only the expanding text on Fill width; short labels stay Hug.

## Frame Axis Sizing

| Mode | Description |
|------|-------------|
| Hug | Frame fits children + padding |
| Fill | Frame expands to fill available space |
| Fixed | Frame keeps explicit size |
