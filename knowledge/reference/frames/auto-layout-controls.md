---
name: "knowledge-frames-auto-layout-controls"
description: "The auto layout controls in the Parent section: layout, direction, and the 3x3 alignment grid."
assumes: reference/frames
---

# Auto Layout Controls

## Right Toolbar (Parent Section)

The Layout section appears when the selection holds frames or auto layout frames (a group, a mask or a boolean shows none, and there is no parent type menu: see `reference/frames/nesting`). Auto-layout-specific controls appear only when **all** selected parents are auto layout.

```
Parent section
├─ Layout switch (None / Vertical / Horizontal)      [Clip-content scissors button]
└─ Auto layout controls (when all selected are auto layout):
   ├─ Row 1: 3x3 alignment grid │ Spacing field         │ Wrap toggle
   │                            │ (Cross-gap field, when wrap is on)
   │                            │ Spacing-mode dropdown │
   ├─ Row 2: All-padding field  [H/V toggle: square split in two]  [Individual toggle: square split in four]
   ├─ (H/V padding row, shown by default): left-and-right field, top-and-bottom field
   ├─ (Individual padding rows, if Individual mode is on): L,T then R,B
   └─ Row 3: Direction buttons (Horizontal / Vertical)
```

## Canvas stacking

Canvas stacking lives in the command palette, not the inspector: with an auto layout frame selected, run **Canvas stacking: Last on top** (default: children paint in layer order, the last child over the rest) or **Canvas stacking: First on top** (the first child paints over the rest, for avatar stacks and fanned cards with a negative spacing). It changes only what paints over what: the flow, the layers panel and the child order stay the same. The current value shows checked; with several frames selected that disagree, neither is checked, and running one applies it to all, in one undo step. Blueprint: `al(h,first-on-top)` or `#id first-on-top` / `#id last-on-top`. Figma's "Canvas stacking" imports onto it one for one.

The **W/H Sizing dropdowns** live in the **Element** section's sizing row (NOT the Parent section): the row sits between Dimensions and Rotation, and ends with a ruler-icon toggle for the min/max constraint rows. The **absolute-position pin button** sits in the Element section's position row, next to the Y field.

## Direction

| Button | Direction |
|--------|-----------|
| Arrow right | Horizontal (children flow left → right) |
| Arrow down | Vertical (children flow top → bottom) |

## Alignment (3×3 Grid)

The 3×3 grid sets main-axis and cross-axis alignment in one click.

| Direction | Columns | Rows |
|-----------|---------|------|
| Horizontal | Main axis (start/center/end) | Cross axis (start/center/end) |
| Vertical | Cross axis (start/center/end) | Main axis (start/center/end) |

**Single-click** a dot to set alignment (in Auto this leaves Auto). **Double-click** a dot to toggle the spacing mode: from a fixed alignment it switches Auto (space-between) on at that dot's cross position; in Auto it switches Auto off at that dot. The Gap menu's Auto row does the same.

**Main-axis options:** start, center, end, **Auto (space-between)**. With Auto and a **single child**, the child is centered (not pushed to start). With 2 children, they go to opposite edges with no middle gap.

**Cross-axis options:** start, center, end.
