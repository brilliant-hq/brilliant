---
name: "knowledge-frames"
description: "Parent types (Frame, Group, Auto Layout, Mask, Boolean), nesting, sizing, drag reorder, parent properties, and component-style conversion."
---

# Parents (Containers)

In Brilliant, every container element is a **parent**. Parents come in 8 sub-types: **Frame**, **Group**, **Auto Layout**, **Mask**, and four **Boolean** variants (Union, Subtract, Intersect, Exclude). Group, Mask, and all Boolean types share three constraints: always Hug on both axes, NOT reparent targets, children cannot be dragged out during drag.

- `reference/frames/from-other-tools`: Figma, Sketch and Illustrator terms mapped to Brilliant, canvas vs frame
- `reference/frames/parent-types`: the 8 parent types, shared capabilities, clip content, resize to fit, type differences
- `reference/frames/frame`: creating a frame, frame properties, properties of every parent, layout guides
- `reference/frames/groups`: Cmd+G, group sizing, ungrouping, editing inside a group
- `reference/frames/masks`: Ctrl+Cmd+M, the mask shape, mask types and properties
- `reference/frames/booleans`: Union, Subtract, Intersect, Exclude, editing, type conversion
- `reference/frames/nesting`: nesting, reparenting by drag, converting between parent types
- `reference/frames/auto-layout`: Shift+A, zero layout shift, what is inferred at creation
- `reference/frames/auto-layout-in-place`: Shift+A on a single frame converts it in place
- `reference/frames/auto-layout-controls`: the Parent section, direction, the 3x3 alignment grid
- `reference/frames/auto-layout-spacing`: spacing, padding, wrap
- `reference/frames/auto-layout-sizing`: Hug, Fill and Fixed for children and frames, when to use each
- `reference/frames/auto-layout-fill`: flex factor, Fill inside Hug frames
- `reference/frames/constraints`: min/max size constraints, pin constraints
- `reference/frames/auto-layout-absolute`: absolute position children
- `reference/frames/auto-layout-reorder`: drag and keyboard reorder, what operations do
- `reference/frames/troubleshooting`: auto layout symptoms, causes and fixes

## Creating Parents (Quick Reference)

| Shortcut | Result |
|----------|--------|
| **Cmd+F** | Frame from selection (default fixed sizing, reparent target) |
| **F**, drag | Frame tool: draws frame, captures elements fully inside |
| **Cmd+G** | Group (always Hug on both axes) |
| **Shift+A** | Auto Layout (or in-place convert if a single non-auto-layout parent is selected) |
| **Ctrl+Cmd+M** | Mask |
| **Alt+Shift+U / S / I / E** | Boolean Union / Subtract / Intersect / Exclude |

> **See also:** `reference/editing`, `reference/layout-guides`, `reference/components`, `reference/vectors`, `reference/crop`
