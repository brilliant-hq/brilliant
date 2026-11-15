---
name: "knowledge-canvas-snap-toggles"
description: "Per-parent snapping, holding Cmd to place freely, and the snap toggles."
assumes: reference/canvas
---

# Canvas: Snap Scope and Toggles

### Per-Parent Snapping

Snapping operates within the primary parent's coordinate space. Elements snap to siblings, never across frame boundaries. Frames themselves are valid snap targets when they are siblings. Elements scrolled out of view are never snap targets.

### Hold Cmd to place freely

Hold **Cmd** (Ctrl on Windows/Linux) while dragging and snapping switches off for as long as you hold it: no guides, no capture, and no pixel-grid rounding either. The element goes exactly where your hand goes. Let go mid-drag and snapping comes straight back, on the very next movement.

This works on every drag: moving, resizing, drawing a new shape, and dragging vector nodes or pen handles. Cmd keeps its other meanings while you hold it (Cmd+click still selects into a group, Cmd+resize still holds an image's crop in place); those just happen unsnapped.

### Toggling Snaps

| Action | How |
|--------|-----|
| Suspend snapping for one drag | Hold Cmd (Ctrl on Windows/Linux) while dragging |
| Toggle snap guides | Cmd+Shift+; |
| Toggle dimension labels | Palette: "Toggle Dimension Labels" (no default shortcut) |
| Toggle snap to pixel grid | Cmd+Shift+' |
