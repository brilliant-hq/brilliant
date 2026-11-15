---
name: "knowledge-canvas-pixel-snap"
description: "Snap to pixel grid: how it rounds, its priority, toggling it, and when to use it."
assumes: reference/canvas
---

# Canvas: Snap to Pixel Grid

Automatically rounds element positions and sizes to whole pixel (integer) values. This prevents sub-pixel rendering artifacts and ensures crisp, pixel-perfect designs.

### How It Works

When enabled (default), moving, resizing, or creating elements automatically snaps to whole pixel values:
- **Move:** Element position rounded to nearest pixel
- **Resize:** Element size rounded to nearest pixel
- **Create:** Start and end points rounded to nearest pixel

### Priority

**Element snap takes priority.** If an element snaps to another element's edge (alignment snap), pixel grid snap is skipped on that axis. This ensures alignment guides work correctly while still rounding the other axis.

### The grid wins for vector nodes

See `reference/vectors/node-snaps`.

### Toggle

Shift+Cmd+' toggles snap-to-pixel-grid on/off. Holding Cmd during a drag suspends it (along with all other snapping) just for that drag.

The snap setting is independent of the pixel grid overlay (visual only). Possible combinations:
- Overlay on, snap off: see the grid, allow sub-pixel positioning
- Overlay off, snap on: snap to pixels without rendering the grid
- Both on: full pixel-perfect workflow

The snap setting persists across app restarts.

### When pixel snap is useful

- UI design: keeps edges crisp on standard and retina displays
- Icon design: prevents sub-pixel blur
- Export: avoids anti-aliasing artifacts at element boundaries

### When to disable pixel snap

- Precise alignment requiring fractional positioning
- Artistic work where pixel-perfect is not a goal
