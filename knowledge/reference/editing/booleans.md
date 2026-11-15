---
name: "knowledge-editing-booleans"
description: "Boolean operations (union, subtract, intersect, exclude) and masks: creating them, editing their children, switching their type."
assumes: reference/editing
---

# Editing: Booleans and Masks

## Boolean Operations

Select 2+ elements and apply a boolean operation. The result is a boolean parent that combines the children into one shape. Children remain editable: double-click a shape inside the boolean parent to enter boolean edit mode with that shape selected, then modify the individual shapes; **Escape** exits.

If a single boolean **or** mask parent is already selected when you run a boolean command, its type switches (e.g., union → subtract, mask → intersect) instead of wrapping it in another parent.

Operations are non-destructive: the boolean parent stores the operands and re-renders on every change.

Discovery: right-click context menu, Boolean submenu (Union, Subtract, Intersect, Exclude), shown with 2+ elements selected. The shortcuts fire on a 2+ selection or on a single parent (frame, group, boolean, or mask).

| Operation | Shortcut | Effect |
|-----------|----------|--------|
| Union | Alt+Shift+U | Sum of all shapes |
| Subtract | Alt+Shift+S | First shape minus the rest |
| Intersect | Alt+Shift+I | Region common to all shapes |
| Exclude | Alt+Shift+E | Symmetric difference (XOR) |
| Flatten | Cmd+Enter | Bake the boolean (or any group) into a single editable vector path (context menu: Flatten) |

## Mask

| Action | Shortcut | Effect |
|--------|----------|--------|
| Use as mask | Cmd+Ctrl+M | Wraps selection so the topmost element (last in z-order) clips the others below |
| Mask edit mode | Double-click into the mask | Edit the mask shape; Escape exits |

Select 2+ elements. The topmost element becomes the clip shape, and the elements below are clipped to it. The result is a mask parent. Applying a boolean command to a mask parent switches its type to that boolean (e.g., mask → intersect); applying Mask to a boolean parent switches it back to a mask. Children of a mask cannot be dragged out: they stay clipped.

Discovery: right-click context menu, "Use as Mask".

Mask parents clip by vector geometry (the default geometric clip). The data model also defines alpha and luminance mask types, but the right toolbar has no picker to switch among them yet.
