---
name: "knowledge-layout-guides-setup"
description: "Adding a layout guide, the header row controls, and the Grid type fields."
assumes: reference/layout-guides
---

# Layout Guides: Setup

## Adding Layout Guides

1. Select a parent element
2. Right toolbar -> **Layout Guides** section
3. Click the **+** button. The new guide starts as a uniform **Grid**
4. To switch type, change the **Type dropdown** in the new guide's header row to Grid / Columns / Rows (switching between Columns and Rows shrinks a section size that no longer fits, so the guide stays inside the frame: see `reference/layout-guides/columns`)
5. Click the **expand button** (slider icon, to the left of the remove button) to reveal the guide's property fields

Adding always inserts a Grid-type guide; switch to Columns or Rows via the row's Type dropdown afterwards. There is **no default keyboard shortcut** for adding a guide. The enable/disable-all keyboard shortcut is **Shift+G**.

The palette exposes one command, **"Add Layout Grid"** (it adds a Grid-type guide; change the type on the row afterwards). There is no separate "Add Columns", "Add Rows", or "Add Grid" command.

## Header Row Controls

Every guide displays a compact header row. Layout (left to right):

| Control | Description |
|---------|-------------|
| **Drag handle** | Always present, but only draggable when 2+ guides exist. Drag to reorder. |
| **Type dropdown** | Grid / Columns / Rows. The dropdown's prefix is a color swatch (tap to open the color picker). |
| **Opacity field (%)** | Color opacity, 0 to 100. |
| **Expand button** (slider icon) | Show/hide the guide's property fields and eye toggle. |
| **Remove button** (minus) | Delete the guide. |

## Per-Guide Properties (Expanded)

Field layout depends on the guide type. The **eye toggle** lives in the expanded fields, NOT the header row.

### Grid Type

| Field | Description |
|-------|-------------|
| Size | Cell size in pixels. Default **10** |
| Eye toggle | Enable/disable this guide as a snap source individually |

A 10px grid places snap lines at 10, 20, 30, ... (skipping the frame edges).
