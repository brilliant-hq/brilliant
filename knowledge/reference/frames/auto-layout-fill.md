---
name: "knowledge-frames-auto-layout-fill"
description: "How Fill children share space by flex factor, and how Fill behaves inside Hug frames."
assumes: reference/frames
---

# Fill and Flex

## Flex Factor

When several Fill children share an axis, they divide the remaining space proportionally by their **flex factor** (default 1.0). A flex of 3 next to a flex of 1 yields a 75% / 25% split.

The **Flex** field appears in the Element section's corner-radius row, prefixed with "F", and is shown only when a Fill child on the parent's main axis is selected. When the corner smoothing toggle is also visible (nonzero radius), Flex moves to its own row above the radius row. If fixed/hug siblings consume all available space, fill children collapse to 0 (clamped, never negative).

## Fill Inside Hug Frames

**Auto layout frames:**

| Scenario | Behavior |
|----------|----------|
| Fill on **main axis** + frame Hug | Collapses to content size (acts like Hug). Avoids a circular dependency: the frame sizes to its children, but Fill wants the frame size to compute against |
| Fill on **cross axis** + frame Hug | Works normally. Fill children are excluded from the cross-axis hug calculation; non-fill siblings determine the cross-axis size; fill children stretch to match |
| Fill + frame Fixed | Works normally |

**All-fill cross-axis edge case:** When every child has Fill on the cross axis (no non-fill anchor), Brilliant measures each child's natural content size and uses the largest as the cross-axis size. Common in pricing grids and multi-column layouts.

**Accent-bar pattern:** A thin rectangle with Fixed width and Fill height inside a horizontal auto layout does not affect the parent's hug height; its siblings determine the height and the bar stretches to match.

**Plain frames and groups (non-auto-layout):** Fill collapses to content size on **both** axes (no main/cross distinction). A Fill-width text inside a hug-width plain frame will not wrap; it renders at its natural single-line width.
