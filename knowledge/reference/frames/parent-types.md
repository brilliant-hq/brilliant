---
name: "knowledge-frames-parent-types"
description: "The eight parent types, their sizing and reparenting rules, shared capabilities, clip content, resize to fit, and type-specific differences."
assumes: reference/frames
---

# Parent Types

| Type | Sizing | Reparent Target? | Created By |
|------|--------|------------------|-----------|
| **Frame** | Any (Hug/Fill/Fixed). Default: Fixed | Yes | Cmd+F (wrap), F (frame tool), Convert to Frame (from a group) |
| **Group** | Always Hug both axes | No | Cmd+G |
| **Auto Layout** | Any. Default: Hug both axes | Yes | Shift+A |
| **Mask** | Always Hug both axes | No | Ctrl+Cmd+M |
| **Boolean Union** | Always Hug both axes | No | Alt+Shift+U |
| **Boolean Subtract** | Always Hug both axes | No | Alt+Shift+S |
| **Boolean Intersect** | Always Hug both axes | No | Alt+Shift+I |
| **Boolean Exclude** | Always Hug both axes | No | Alt+Shift+E |

## Shared Capabilities

All parent types support:
- Fill, stroke, corner radius (per-corner or uniform)
- Clip content toggle
- Effects (drop shadow, outer glow, element blur)
- Nesting (parents inside parents, any combination)

**Clip content is off by default** for all parent types. Toggle it with the scissors button in the right toolbar's Layout section (frames and auto layout frames) or its command.

**Resize to fit** snaps a plain frame (or group or mask parent) to exactly wrap its children, shrinking or expanding as needed. Children keep their positions on the canvas: only the frame border moves. Use the wrap button left of the scissors in the Parent section, or Option+Shift+Cmd+R. On an auto layout frame it sets both axes to hug, so the frame fits now and keeps fitting. Boolean parents and empty parents are skipped.

## Type-Specific Differences

- **Frame** and **Auto Layout** support all sizing modes and accept reparenting (drag elements in/out).
- **Group** is always Hug on both axes. Changing sizing from Hug on either axis auto-converts it to a **Frame**. Groups are NOT reparent targets; children cannot be dragged out during drag.
- **Mask** is always Hug on both axes. The **topmost child** (last in z-order) defines the clip path, is invisible in normal mode, and includes stroke geometry in the clip. Other children are clipped to the mask shape. If that topmost child is a group, a boolean, or a frame with no fill of its own, the clip is the UNION of everything its subtree draws, not the group's bounding box, so gaps between the group's children stay masked out. Clicking and SVG/PDF export follow that same shape: a click lands on masked content only where the mask shows it (a click in a gap falls through), and an export clips to the real silhouette, not the bounding box. Only Vector masking is selectable in the UI.
- **Boolean** is always Hug on both axes. The combined path is rendered. Double-click into it to enter edit mode with the shape under the cursor selected (children become editable; Subtract is z-order sensitive: front shapes subtract from the back).
