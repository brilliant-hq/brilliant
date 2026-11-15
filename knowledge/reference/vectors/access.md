---
name: "knowledge-vectors-access"
description: "How to reach the Pen tool, the Pencil tool, and vector edit mode, and what entering edit mode converts."
assumes: reference/vectors
---

# Vectors: Access

## How to Access Vector Tools

### Pen Tool (Create New Paths)

Press **P** to activate the Pen tool. Also accessible via:
- **Bottom toolbar:** open the drawing-tools dropdown and select "Pen".
- **Palette:** open it (Cmd+Shift+P) and search "Pen".

The Pen tool stays active while you place nodes. Press **Escape** to finish the path; the tool returns to Move. Press **P** again to start another path.

### Pencil Tool (Freehand)

Press **Shift+P** to activate the Pencil tool, or pick "Pencil" from the bottom toolbar's drawing-tools dropdown / palette.

### Vector Edit Mode (Edit Existing Paths)

To edit an existing vector element's nodes:
1. Select the vector element.
2. Press **Enter** (or double-click the selected element) to enter vector edit mode.
3. Edit nodes, handles, and edges (see sections below).
4. Press **Escape** to exit. Entering selects no node, so one Escape exits; if you selected nodes or handles, the first Escape clears them and the next exits. Escape while you are still dragging a point cancels that drag (the point goes back where it started; your earlier edits stay) and exits.

A rectangle or circle/ellipse/arc entered this way shows as an editable path while you are in vector edit mode, but it only becomes a vector with your first real edit (moving a node, bending a handle, adding or deleting a point), and one Undo reverts that edit and the conversion together. Escape (or Undo) without an edit gives the shape back exactly as it was (type, corner radius, arc settings), with nothing added to the undo history. Paths that drop below 2 nodes are deleted entirely (undo restores).

Pencil-drawn elements are already vectors and need no conversion. Text cannot enter vector edit mode directly: use **Outline Text** (Cmd+Ctrl+O) or **Flatten Text** (palette; no default shortcut) first to convert it to vector geometry (see `reference/editing/outline-text`).
