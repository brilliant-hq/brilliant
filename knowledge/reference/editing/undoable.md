---
name: "knowledge-editing-undoable"
description: "The list of element operations that are undoable."
assumes: reference/editing
---

# Editing: What Is Undoable

All element operations are undoable:

- Create, delete, duplicate, paste
- Move, resize, rotate, flip, scale, skew
- Color, fill, stroke, opacity changes
- Text edits and typography (font, size, line height, weight, italic, underline, alignment)
- Alignment and distribution
- Group, ungroup, reparent (both interactive drag and explorer drag)
- Auto layout changes
- Z-order changes
- Crop operations (image pan, resize, rotate within element)
- Boolean and mask operations (including type changes)
- Flatten and outline text
- Component create / detach / instance / reset / push overrides
- Effects (shadow / glow / blur add / remove / update)
- Vector node, edge, and handle edits
- Add / remove / swap fill or stroke

Rapid arrow-key nudges are combined into a single undo entry after 1 second of inactivity.
