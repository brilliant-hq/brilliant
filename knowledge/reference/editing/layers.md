---
name: "knowledge-editing-layers"
description: "Group, Frame Selection, Ungroup, Add Auto Layout, Rename Layer, Hide/Show, and Lock/Unlock."
assumes: reference/editing
---

# Editing: Groups, Names, Visibility, Lock

## Grouping and Framing

| Action | Shortcut | What it does |
|--------|----------|------|
| Group | Cmd+G | Wraps the selection in a group (hug sizing on both axes). Groups are structural only: not a reparent target, children cannot be dragged out. If the selection spans multiple parents, one group is created per parent. |
| Frame Selection | Cmd+F | Wraps the selection in a frame container (hug-sized initially, a valid reparent target). Sizing can be switched to fixed/fill afterward in the right toolbar. |
| Ungroup | Cmd+Shift+G | Removes the wrapping group/frame and moves children up to the parent |
| Add Auto Layout | Shift+A | Wraps the selection in an auto-layout frame with zero layout shift: direction, order, gap (negative for overlaps), and alignment are inferred so elements keep their exact canvas positions |

## Rename Layer

| Action | Shortcut |
|--------|----------|
| Rename Layer | Cmd+R |

Renames the selected element's layer name. You can also double-click a layer name in the Layers explorer.

## Hide / Show

| Action | Shortcut | What it does |
|--------|----------|------|
| Hide / Show | Cmd+Shift+H | Toggles visibility of the selected elements |

Hidden elements disappear from the canvas but stay in the document. Each layer in the Layers explorer (left toolbar) also has an eye toggle you can click to hide or show that element.

## Lock / Unlock

Lock an element from its layer row's hover **lock button** (next to the eye), the right-click context menu, or the **Toggle Lock** palette command (no default shortcut). A locked element, and everything inside it, stops responding on the canvas: clicks pass through to whatever sits beneath, and drags cannot select or move it. A locked frame is also never a landing spot: dragging, pasting, or duplicating something over it falls through to the next unlocked parent (or the canvas itself), and its auto layout never previews a gap for the drop. The lock button stays visible on the layer row while locked, so you can unlock it there any time; unlocking restores everything exactly as it was.
