---
name: "knowledge-canvas-rulers"
description: "Rulers and ruler guides, dimension labels, and the pixel grid overlay."
assumes: reference/canvas
---

# Canvas: Rulers, Dimension Labels, Pixel Grid

## Rulers

Shift+U toggles rulers along the canvas edges.

### Ruler Guides

Drag from the ruler bar onto the canvas to create persistent horizontal or vertical guide lines. Ruler guides:

- Are snap targets during move, resize, and create
- Are selectable: click a guide to select it
- Are deletable: select and press Delete, or use "Clear All Ruler Guides" via the palette
- Are per-canvas: each canvas has its own set
- Are saved with the canvas: adding, moving, deleting or clearing a guide is a document change, so guides come back exactly where you left them

## Dimension Labels

When enabled, dimension labels show width/height during creation, resize, and during snap interactions. Toggled via "Toggle Dimension Labels" in the palette.

## Pixel Grid

A 1-pixel grid overlay for pixel-perfect work at high zoom levels.

### Visibility

- **Appears from 5000% zoom** (50x and above)
- **Fades in smoothly** between 5000% and 6000% zoom (fully faded in by 6000%)
- **Adaptive contrast:** each line reads the content beneath it and shifts its
  luminance away from the local backdrop (darker on light content, lighter on
  dark), so the grid stays visible on any background, including photos and
  gradients, and never dominates. It is not a flat theme color.
- Shown on all platforms (macOS, Windows, Linux).

### Toggle

Cmd+' toggles the pixel grid overlay.

The pixel grid state persists across app restarts.
