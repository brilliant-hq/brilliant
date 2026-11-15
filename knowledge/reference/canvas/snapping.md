---
name: "knowledge-canvas-snapping"
description: "How snap guides work, the snap types, and what Brilliant offers as a snap target."
assumes: reference/canvas
---

# Canvas: Snap Guides

### How Snapping Works

While moving, resizing, or creating elements, snap guides render as:
- Solid lines: alignment snaps (edge or center aligned to a reference)
- Solid lines with a distance label: spacing and equidistant distribution snaps
- Dashed lines with a size label: size-match snaps

Guides are pink in both light and dark themes. The snap engine is per-axis: X and Y snap independently and the closest valid target wins per axis. Once a winning position is determined, all guide types active at that exact position render together, and they keep rendering for as long as the element sits there: a guide describes where the element actually is, not where the pointer is.

Every snap that moves the element shows why: when a spacing snap lands your gap on a gap that already exists (for example a row of slide frames 169px apart), the gap you made and the matching gap elsewhere both show their marker and distance label, even when the element has neighbors on both sides.

Once an axis snaps, it stays snapped until the pointer either leaves a widened release band or reaches a target that is strictly closer, so a small hand tremor never flips between two nearby targets. That is the same for every tool: moving, resizing, and drawing a new shape all hold the same way.

### Snap Types

| Type | Behavior |
|------|----------|
| Alignment | Snaps edges and centers to siblings' edges and centers |
| Spacing | Maintains an equal gap relative to a neighbor |
| Equidistant | Equal gaps between 3+ siblings in a row or column |
| Size matching | When resizing, snaps to match width or height of nearby siblings |
| Layout grid | Snaps to columns, rows, or grid lines on the parent frame |
| Ruler guides | Snaps to dragged-out ruler guides |
| Angle | Shift while drawing lines/arrows snaps to 45 degree increments; pen handle drag snaps to 15 degree |

### What Brilliant offers as a snap target

Snapping is deliberately selective: it offers fewer, better targets rather than pulling harder. Only these relationships capture the drag:

- **Left to left, center to center, right to right** (and top/middle/bottom on the other axis). These are the canonical alignments and always capture at the full snap distance.
- **Edge to the facing edge** (your left edge onto something's right edge) when the two elements are side by side. This is the flush, zero-gap placement, and it captures only when you aim at it: come within about 2px and it takes, drift past and it lets go. When the two elements are NOT side by side (different rows, different columns), the shared edge coordinate is treated as an ordinary alignment and captures at the full distance.
- **The frame you are inside**, and any ruler guide or layout-grid line you placed. Those are always on offer, whatever else is nearby.

An edge landing on something's *center* is not offered: it describes nothing you would ask for, and it used to turn a dense row of elements into a detent every few pixels.

When many elements compete on one axis, the nearest and most recently touched ones win the right to offer targets: elements you just created, selected, or dragged rank above stale ones, and elements far above or below the row you are dragging in rank below the ones beside you.
