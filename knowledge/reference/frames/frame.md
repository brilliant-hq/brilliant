---
name: "knowledge-frames-frame"
description: "Creating a frame, frame properties, the properties every parent type shares, and layout guides on frames."
assumes: reference/frames
---

# Frames

## Creating a Frame

| Action | Result |
|--------|--------|
| **Cmd+F** with selection | Wrap selection in a Frame parent. **Default sizing: fixed** (combined bounds of children). Reparent target |
| **F**, then drag on canvas | Frame tool: draws a new Frame. Elements **fully inside** the drawn rectangle are auto-reparented as children |
| **Convert to Frame** (right-click menu or command palette) | Convert a selected group to a Frame |

## Frame Properties

- **W Sizing / H Sizing dropdowns** in the right toolbar's **Element** section (between Dimensions and Rotation rows): Hug, Fill, Fixed
- **Fill, Stroke, Corner radius, Effects, Opacity, Blend mode**: like any element
- **Clip content** toggle: scissors button in the Layout section
- **Layout guides** (column / row / grid): Layout Guides section. See `reference/layout-guides`
- **Frame label**: double-click a frame's label on canvas to rename inline (Escape cancels, Enter commits)

## Parent Properties (All Types)

| Property | Description |
|----------|-------------|
| Clip content | Clip children to parent bounds. Default: **off** for all types. Toggle: scissors button in the Layout section |
| Corner radius | Per-corner or uniform; supports radius tokens |
| Fill | Color, gradient, image, or shader |
| Stroke | Border |
| Effects | Drop shadow, outer glow, element blur (inner shadow / inner glow / background blur are fill types in the Fills list) |
| Sizing | Frame and Auto Layout: Hug/Fill/Fixed per axis. Group, Mask, Boolean: locked to Hug on both axes |
| Opacity, Blend mode | Element-level (in Element section) |

## Layout Guides

Frames support column, row, and grid layout guides. These are snap targets that also draw as guide lines over the frame whenever layout grids are shown and the grid is visible, kept inside the frame and any clipping parent. They are view chrome, so they never appear in exports. See `reference/layout-guides`.

- **Shift+G** toggles global visibility of all layout guides
- Add guides via the Layout Guides section's **+** button (default type: Grid)
- Grid command alone, no separate type-picker button on the toolbar; pick the type after creation via the row's Type dropdown
