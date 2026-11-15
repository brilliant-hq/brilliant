---
name: "knowledge-frames-booleans"
description: "Boolean parents (Union, Subtract, Intersect, Exclude): shortcuts, editing, and type conversion."
assumes: reference/frames
---

# Boolean Operations

Boolean parents combine child paths. Always Hug on both axes. Not reparent targets.

| Operation | Shortcut |
|-----------|----------|
| Union | Alt+Shift+U |
| Subtract | Alt+Shift+S |
| Intersect | Alt+Shift+I |
| Exclude | Alt+Shift+E |

**Editing:** Double-click into it to enter edit mode with the shape under the cursor selected (children individually editable). Escape exits. Subtract is z-order sensitive: front shapes subtract from the back.

**Type conversion:**
- Boolean ↔ Boolean (or Boolean ↔ Mask): preserves fills/strokes (both paint them on the combined result shape) and renames
- Boolean → non-Boolean / non-Mask: standard conversion, keeps fills/strokes
- Non-Boolean/Non-Mask → Boolean or Mask: clears fills/strokes, forces hug, renames (Mask → "Mask"; booleans → e.g. "Union")
