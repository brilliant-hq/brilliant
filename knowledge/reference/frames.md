---
name: "knowledge-frames"
description: "Parent types (Frame, Group, Auto Layout, Mask, Boolean), nesting, sizing, drag reorder, parent properties, and component-style conversion."
---

# Parents (Containers)

In Brilliant, every container element is a **parent**. Parents come in 8 sub-types: **Frame**, **Group**, **Auto Layout**, **Mask**, and four **Boolean** variants (Union, Subtract, Intersect, Exclude). Group, Mask, and all Boolean types share three constraints: always Hug on both axes, NOT reparent targets, children cannot be dragged out during drag.

## Coming From Other Tools

### Figma / Sketch

| Figma / Sketch | Brilliant | Notes |
|----------------|-----------|-------|
| **Frame** | Parent (Frame) | Free-positioning container with fixed sizing by default |
| **Group** (Cmd+G) | Parent (Group) | Always Hug on both axes. NOT a drop target |
| **Auto Layout Frame** (Shift+A) | Parent (Auto Layout) | Flow layout, supports wrap |
| Component | Component | Masters and instances. See [components.md](./components.md) |
| Artboard | Canvas (separate page) or Frame (bounded area) | |
| **Mask** (Cmd+Option+M) | Mask (**Ctrl+Cmd+M**) | macOS reserves Cmd+Option+M for "Minimize All Windows" |
| Constraints (pin to edges) | Not available | Use auto layout with hug/fill/fixed |
| Absolute position | Pin button in the Element section position row | Same concept |
| Boolean ops | Boolean parents | Each op produces a re-editable parent (double-click to edit) |

**Frames, Groups, Masks, and Booleans are all parent elements** distinguished by their type. Convert between any of them via the **Type dropdown** in the right toolbar's Parent section.

### Adobe Illustrator

| Illustrator | Brilliant |
|-------------|-----------|
| Artboard | Canvas or Frame |
| Group (Cmd+G) | Parent (Group) |
| Clipping Mask | Mask (Ctrl+Cmd+M); or Frame + clip-content for rectangular clipping |
| Appearance panel (multiple fills) | Fills section in right toolbar |
| Symbols | Components |
| Pen tool (P) | Pen tool (P) |
| Direct Selection (white arrow) | Vector Edit Mode (Enter on selected element) |
| Pathfinder | Boolean ops: Union (Alt+Shift+U), Subtract (Alt+Shift+S), Intersect (Alt+Shift+I), Exclude (Alt+Shift+E) |
| Image Trace | Not available (vectorize externally, then import SVG) |
| Mesh Gradient | Not available (use linear/radial/angular gradients) |

**Canvas vs Frame:** A canvas is a separate page in the workspace. A frame is an element on a canvas that contains other elements. Many frames per canvas, many canvases per workspace.

## Parent Types

| Type | Sizing | Reparent Target? | Created By |
|------|--------|------------------|-----------|
| **Frame** | Any (Hug/Fill/Fixed). Default: Fixed | Yes | Cmd+F (wrap), F (frame tool), Type dropdown |
| **Group** | Always Hug both axes | No | Cmd+G |
| **Auto Layout** | Any. Default: Hug both axes | Yes | Shift+A |
| **Mask** | Always Hug both axes | No | Ctrl+Cmd+M |
| **Boolean Union** | Always Hug both axes | No | Alt+Shift+U |
| **Boolean Subtract** | Always Hug both axes | No | Alt+Shift+S |
| **Boolean Intersect** | Always Hug both axes | No | Alt+Shift+I |
| **Boolean Exclude** | Always Hug both axes | No | Alt+Shift+E |

### Shared Capabilities

All parent types support:
- Fill, stroke, corner radius (per-corner or uniform)
- Clip content toggle
- Effects (drop shadow, outer glow, element blur)
- Nesting (parents inside parents, any combination)
- Conversion to any other parent type via the dropdown

**Clip content is off by default** for all parent types. Toggle it with the scissors button next to the Type dropdown in the right toolbar's Parent section.

**Resize to fit** snaps a plain frame (or group or mask parent) to exactly wrap its children, shrinking or expanding as needed. Children keep their positions on the canvas: only the frame border moves. Use the wrap button left of the scissors in the Parent section, or Option+Shift+Cmd+R. On an auto layout frame it sets both axes to hug, so the frame fits now and keeps fitting. Boolean parents and empty parents are skipped.

### Type-Specific Differences

- **Frame** and **Auto Layout** support all sizing modes and accept reparenting (drag elements in/out).
- **Group** is always Hug on both axes. Changing sizing from Hug on either axis auto-converts it to a **Frame**. Groups are NOT reparent targets; children cannot be dragged out during drag.
- **Mask** is always Hug on both axes. The **topmost child** (last in z-order) defines the clip path, is invisible in normal mode, and includes stroke geometry in the clip. Other children are clipped to the mask shape. Only Vector masking is selectable in the UI.
- **Boolean** is always Hug on both axes. The combined path is rendered. Double-click to enter edit mode (children become editable; Subtract is z-order sensitive: front shapes subtract from the back).

## Frames

### Creating a Frame

| Action | Result |
|--------|--------|
| **Cmd+F** with selection | Wrap selection in a Frame parent. **Default sizing: fixed** (combined bounds of children). Reparent target |
| **F**, then drag on canvas | Frame tool: draws a new Frame. Elements **fully inside** the drawn rectangle are auto-reparented as children |
| Type dropdown → Frame | Convert any parent to Frame |

### Frame Properties

- **W Sizing / H Sizing dropdowns** in the right toolbar's **Element** section (between Dimensions and Rotation rows): Hug, Fill, Fixed
- **Fill, Stroke, Corner radius, Effects, Opacity, Blend mode**: like any element
- **Clip content** toggle: scissors button next to the Type dropdown in the Parent section
- **Layout guides** (column / row / grid): Layout Guides section. See [layout-guides.md](./layout-guides.md)
- **Frame label**: double-click a frame's label on canvas to rename inline (Escape cancels, Enter commits)

## Groups

### Creating a Group

1. Select 2+ elements
2. Press **Cmd+G**
3. A Group parent wraps the selection (one group per source parent: per-parent grouping)

**Group properties at creation:**
- Hug on both axes (forced)
- Clip content off, no fill, no stroke
- Z-order: inserted at the backmost selected element's position

### Sizing

Groups are **always Hug on both axes** (auto-resize to fit children). **Changing sizing from Hug on either axis auto-converts the group to a Frame.**

### Ungrouping (Cmd+Shift+G)

| Action | Effect |
|--------|--------|
| Cmd+Shift+G, right-click → Ungroup, or palette | Reparent children to group's parent, transform coordinates, delete group, preserve z-order |

If the group is a component master, its component relationship is cleaned up first. If it's an instance, it is detached first. If the group's parent is auto layout, the parent re-layouts.

### Editing Inside a Group

1. Click the group's label to select it
2. Press **Enter** to drill in (selects first child)
3. Click children individually
4. Press **Shift+Enter** to select the parent (go up)

### Group Properties

- **Fill** (Shift+F), **Stroke** (Shift+S), **Corner radius**, **Effects**
- **Clip content** off by default
- **Sizing**: always Hug (changing it converts the group to a Frame)
- **Rename**: Cmd+R, or double-click the group label on canvas

## Masks (Ctrl+Cmd+M)

A mask uses one element to clip others, like a cookie cutter. The **topmost element** (last in z-order) becomes the clip shape; everything below is clipped to it.

### Creating a Mask

1. Select 2+ elements
2. Press **Ctrl+Cmd+M** (or right-click → Mask, or palette → "Mask")
3. A Mask parent wraps the selection (per-parent: one mask per source parent)

**At creation:**
- The mask shape includes **stroke geometry** in the clip (a circle with a thick stroke masks a wider area than its fill alone)
- The mask shape is invisible in normal mode
- Mask defaults: Hug on both axes, no fill, no stroke, clip content off (clipping is done by the mask shape, not by bounds)

### Editing the Mask Shape

- **Double-click** the mask to enter edit mode: the mask shape becomes visible and editable
- Modify it (resize, change arc, edit vector nodes, etc.); the clip path updates live
- **Escape** or click outside to exit

### Mask Types

| Type | Description |
|------|-------------|
| Vector (default) | Clip via the mask shape's vector outline including stroke geometry |
| Alpha | Not selectable in the UI |
| Luminance | Not selectable in the UI |

The active masking type is always Vector. Alpha and Luminance round-trip through saved files but cannot be selected via the right toolbar.

### Mask Properties

- **Sizing**: always Hug on both axes
- **Fill, stroke, corner radius, effects**: fills/strokes are painted on the combined result shape
- **Tip**: any element type can be the mask shape (rectangle, circle, vector, text). Reorder children in the layers explorer to change which is the mask shape (last/topmost = mask).

## Boolean Operations

Boolean parents combine child paths. Always Hug on both axes. Not reparent targets.

| Operation | Shortcut |
|-----------|----------|
| Union | Alt+Shift+U |
| Subtract | Alt+Shift+S |
| Intersect | Alt+Shift+I |
| Exclude | Alt+Shift+E |

**Editing:** Double-click to enter edit mode (children individually editable). Escape exits. Subtract is z-order sensitive: front shapes subtract from the back.

**Type conversion:**
- Boolean ↔ Boolean (or Boolean ↔ Mask): preserves fills/strokes (both paint them on the combined result shape) and renames
- Boolean → non-Boolean / non-Mask: standard conversion, keeps fills/strokes
- Non-Boolean/Non-Mask → Boolean or Mask: clears fills/strokes, forces hug, renames (Mask → "Mask"; booleans → e.g. "Union")

## Auto Layout (Shift+A)

Auto layout frames flow children in a row or column, with optional wrap.

### Creating Auto Layout

1. Select elements
2. Press **Shift+A**
3. Direction, spacing, padding, and cross-axis alignment are inferred from element positions

**Defaults applied at creation:**

| Field | With 2+ elements | With a single element |
|-------|------------------|-----------------------|
| Direction | Horizontal if the selection spreads wider than tall, else Vertical | Horizontal |
| Main-axis alignment | Start | Start |
| Cross-axis alignment | Inferred from positions | Start |
| Spacing | Rounded average gap between consecutive elements, floored at 0 (a negative gap, which overlaps children, can be typed into the spacing field later) | 10 |
| Padding (all four sides) | 0 | 0 |
| Wrap | Off | Off |

The new auto layout frame is created Hug on both axes.

### Single-Frame In-Place Conversion

When **Shift+A** is pressed with a **single non-auto-layout parent (Frame / Group / Mask / Boolean)** selected, that parent is converted to Auto Layout in place instead of being wrapped in a new frame. Children are sorted by spatial position along the inferred main axis. Padding is computed from the existing frame bounds. A single non-parent selection (a lone rectangle, vector, etc.) is wrapped in a new auto layout frame instead.

### Right Toolbar (Parent Section)

The Parent section appears whenever any parent is selected. Auto-layout-specific controls appear only when **all** selected parents are auto layout.

```
Parent section
├─ Type row: Type dropdown      [Clip-content scissors button]
└─ Auto layout controls (when all selected are auto layout):
   ├─ Row 1: 3x3 alignment grid │ Spacing field         │ Wrap toggle
   │                            │ (Cross-gap field, when wrap is on)
   │                            │ Spacing-mode dropdown │
   ├─ Row 2: All-padding field  [H/V mode toggle]  [Individual mode toggle]
   ├─ (H/V padding row, if H/V mode is on): H field, V field
   ├─ (Individual padding rows, if Individual mode is on): L,T then R,B
   └─ Row 3: Direction buttons (Horizontal / Vertical)
```

The **W/H Sizing dropdowns** live in the **Element** section's sizing row (NOT the Parent section): the row sits between Dimensions and Rotation, and ends with a ruler-icon toggle for the min/max constraint rows. The **absolute-position pin button** sits in the Element section's position row, next to the Y field.

### Direction

| Button | Direction |
|--------|-----------|
| Arrow right | Horizontal (children flow left → right) |
| Arrow down | Vertical (children flow top → bottom) |

### Alignment (3×3 Grid)

The 3×3 grid sets main-axis and cross-axis alignment in one click.

| Direction | Columns | Rows |
|-----------|---------|------|
| Horizontal | Main axis (start/center/end) | Cross axis (start/center/end) |
| Vertical | Cross axis (start/center/end) | Main axis (start/center/end) |

**Single-click** a dot to set alignment. **Double-click** a dot to toggle the spacing mode between Fixed and Auto (space-between). When Auto is active, only the cross-axis dot remains adjustable (the main axis is locked to space-between).

**Main-axis options:** start, center, end, **Auto (space-between)**. With Auto and a **single child**, the child is centered (not pushed to start). With 2 children, they go to opposite edges with no middle gap.

**Cross-axis options:** start, center, end.

### Spacing

Gap between children, in pixels. Modes:

| Mode | Behavior |
|------|----------|
| Fixed | The entered value is used directly |
| Auto | Equivalent to space-between main-axis alignment. The spacing field becomes read-only and shows the *computed* gap |

Spacing can be bound to a design system spacing token via the spacing-tokens menu next to the field.

### Padding

Three editing modes, switched via the two buttons next to the all-padding field:

| Mode | Layout |
|------|--------|
| **Uniform** (default) | Single field for all four sides |
| **H/V** | Horizontal (left+right) and Vertical (top+bottom) fields |
| **Individual** | Left/Top then Right/Bottom fields (two rows) |

The all-padding field accepts comma-separated input even in uniform mode: typing "16,8" sets H/V; "16,8,24,8" sets Left/Top/Right/Bottom. Padding values can be bound to design system spacing tokens.

### Wrap

Wrap toggle button (rightmost in the alignment+spacing row). When enabled, overflowing children flow to the next row (horizontal) or column (vertical). CSS `flex-wrap: wrap` equivalent.

- Wrap only takes effect when the frame has **fixed or fill** sizing on the **main axis** (need a constraint to wrap against)
- The gap between rows/columns defaults to the item spacing; a **cross-gap field** appears under the Spacing field while wrap is on to set it independently (leave it empty to inherit the item spacing)
- Fill children inside a wrapped row fill that row's main axis, not the frame's
- Drag-reorder uses 2D cursor position to find the right row/column first, then position within it

### Child Sizing Modes

Set via **W Sizing** and **H Sizing** dropdowns in the right toolbar's **Element** section.

| Mode | Description |
|------|-------------|
| Hug | Use natural content size |
| Fill | Expand to fill remaining space |
| Fixed | Use explicit size |

**Hug** is offered when all selected elements are frames or text. **Fill** is offered when any selected element is inside a frame parent. Otherwise only Fixed is offered.

**Auto-conversion to Fixed:** Manually resizing or rotating a child converts it to **Fixed** at its current dimensions. **Fill also freezes to Fixed (at the current rendered size) when an element leaves auto-layout:** moved or reparented to the canvas, a plain Frame, Group, Mask, or Boolean, or dragged within a plain Frame. Only the Fill axes change; Hug/Fixed axes are kept. Fill is preserved **only** when the destination is another Auto Layout frame. So do not assume a Fill element stays Fill after it leaves an auto-layout parent; change the dropdown back to Fill if needed.

#### When to Use Each Mode

| Use Case | Width | Height |
|----------|-------|--------|
| Label / value text (numbers, metrics, units, dates, nav items, section headers) | Hug | Hug |
| Prose / body / descriptions (should wrap) | Fill | Hug |
| Button | Hug | Hug |
| Icon / avatar | Fixed | Fixed |
| Input field | Fill | Fixed |
| Sidebar | Fixed | Fill |
| Content area | Fill | Fill or Hug |
| Full-width section | Fill | Hug |
| Siblings that should match dimension | Fill | Fill (cross-axis Fill stretches to match tallest/widest sibling) |

Text on Hug width does not wrap (it renders at its natural single-line width). Set width to Fill for text that should wrap. With multiple text elements in a horizontal row (label + value, bullet + item), put only the expanding text on Fill width; short labels stay Hug.

#### Min / Max Size Constraints

Auto layout frames and their direct children can carry minimum and maximum width/height constraints (Figma parity). A ruler-icon toggle at the right end of the Element section's W/H sizing row (shown whenever the selection is an auto layout frame or a direct child of one) reveals two rows: Min W + Min H, then Max W + Max H. Unset shows "None". To clear a constraint, pick "None" from the field's dropdown, or type 0, or drag below 0.

How they behave:

| Sizing | Effect |
|--------|--------|
| Hug | The hugged result clamps: the frame stops growing at its max (content overflows, clipped if Clip Content is on) and never shrinks below its min |
| Fill | The child fills up to its max / at least its min. Excess space freed by a capped child goes to the other Fill siblings; a floored child forces siblings smaller |
| Fixed | The size clamps to the min/max range. Manually resizing a constrained element snaps to the bound live during the drag |

If min is set above max, min wins. Constraints survive manual resize and rotation (only the sizing mode converts to Fixed, as usual). Blueprint: `min(w,h)` and `max(w,h)` after `s()`, empty slot skips an axis. Constraints round-trip through Figma import and Send to Figma.

#### Flex Factor

When several Fill children share an axis, they divide the remaining space proportionally by their **flex factor** (default 1.0). A flex of 3 next to a flex of 1 yields a 75% / 25% split.

The **Flex** field appears in the Element section's corner-radius row, prefixed with "F", and is shown only when a Fill child on the parent's main axis is selected. When the corner smoothing toggle is also visible (nonzero radius), Flex moves to its own row above the radius row. If fixed/hug siblings consume all available space, fill children collapse to 0 (clamped, never negative).

#### Fill Inside Hug Frames

**Auto layout frames:**

| Scenario | Behavior |
|----------|----------|
| Fill on **main axis** + frame Hug | Collapses to content size (acts like Hug). Avoids a circular dependency: the frame sizes to its children, but Fill wants the frame size to compute against |
| Fill on **cross axis** + frame Hug | Works normally. Fill children are excluded from the cross-axis hug calculation; non-fill siblings determine the cross-axis size; fill children stretch to match |
| Fill + frame Fixed | Works normally |

**All-fill cross-axis edge case:** When every child has Fill on the cross axis (no non-fill anchor), Brilliant measures each child's natural content size and uses the largest as the cross-axis size. Common in pricing grids and multi-column layouts.

**Accent-bar pattern:** A thin rectangle with Fixed width and Fill height inside a horizontal auto layout does not affect the parent's hug height; its siblings determine the height and the bar stretches to match.

**Plain frames and groups (non-auto-layout):** Fill collapses to content size on **both** axes (no main/cross distinction). A Fill-width text inside a hug-width plain frame will not wrap; it renders at its natural single-line width.

### Frame Axis Sizing

| Mode | Description |
|------|-------------|
| Hug | Frame fits children + padding |
| Fill | Frame expands to fill available space |
| Fixed | Frame keeps explicit size |

### Absolute Position

Children of auto layout frames can opt out of layout flow with **absolute positioning**. An absolute child stays nested (clipping, coordinate space, z-order) but does not participate in positioning, spacing, or hug sizing. It moves and resizes freely.

**Toggle:**
- Pin button in the right toolbar's **Element** section position row (next to the Y field), or
- Command palette → "Toggle Ignore Auto Layout"

The pin button only appears when at least one selected element is inside an auto layout frame.

**Use cases:** badges, notification dots, floating buttons, watermarks, decorative overlays.

**Behavior:**
- Excluded from gap, spacing, and hug calculations
- Excluded from drag reorder and arrow-key reorder (arrow keys nudge them like normal elements)
- Toggling back to flow re-inserts at the element's z-order position
- Absolute flag is **stripped automatically** when the parent is converted to a non-auto-layout type

### Reordering Children Inside Auto Layout

Inside auto layout, children are reordered rather than freely positioned (for non-absolute children only).

**Drag reorder:**
1. Select and drag a flow child
2. An insertion indicator (line perpendicular to main axis) shows placement
3. Release to drop, siblings reflow

In wrapped layouts, the insertion index is computed in 2D (find the row/column first, then position within it). Hold **Space** to prevent reparenting during drag (works across all parent types).

**Keyboard reorder** (arrow keys with auto layout child selected):
- Horizontal layout: ← move earlier, → move later
- Vertical layout: ↑ move earlier, ↓ move later
- Cross-axis arrow keys are ignored
- Absolute children get nudged like normal elements (no reorder)

### What Happens On Operations

| Operation | Effect on auto layout frame |
|-----------|----------------------------|
| Resize a child | Converts to Fixed sizing, re-layouts |
| Rotate a child | Converts to Fixed sizing, re-layouts |
| Delete a child | Siblings reflow |
| Add a child | Re-layouts automatically |
| Arrow keys | Reorders flow children along main axis (absolute children nudge normally) |
| Drag within frame | Drag-reorder for flow children, free move for absolute children |
| Drag to different frame | Reparents both, both re-layout |
| Toggle absolute position | Removes from / re-inserts into flow |

### Converting Between Types

The Type dropdown in the right toolbar Parent section lists all 8 types: Frame, Group, Auto Layout, Union, Subtract, Intersect, Exclude, Mask.

Common conversions:

| From → To | Effect |
|-----------|--------|
| Frame → Group | Forces Hug on both axes, clears auto layout settings |
| Frame → Auto Layout | Infers direction, spacing, alignment, padding from current child positions; sorts children spatially along the main axis |
| Frame → Boolean | Forces Hug, clears auto layout settings, **clears fills/strokes** (only when the source is not already a Boolean or Mask), renames |
| Frame → Mask | Forces Hug, clears auto layout settings, clears fills/strokes (only when the source is not already a Boolean or Mask), renames to "Mask" |
| Group → Frame | Unlocks sizing |
| Group → Auto Layout | Infers layout, unlocks sizing |
| Auto Layout → Frame | Clears auto layout settings, children keep current positions |
| Auto Layout → Group | Clears auto layout settings, forces Hug on both axes |
| Boolean ↔ Boolean | Preserves fills/strokes, renames |
| Boolean ↔ Mask | Preserves fills/strokes |
| Mask → non-mask non-boolean | Standard conversion, keeps fills/strokes |

**Auto-conversion:** Changing a Group's sizing from Hug on either axis automatically converts it to a Frame.

**Side effect:** Converting an auto layout parent to any non-auto-layout type **removes the absolute-position flag** from all children.

## Parent Properties (All Types)

| Property | Description |
|----------|-------------|
| Clip content | Clip children to parent bounds. Default: **off** for all types. Toggle: scissors button next to the Type dropdown in the Parent section |
| Corner radius | Per-corner or uniform; supports radius tokens |
| Fill | Color, gradient, image, or shader |
| Stroke | Border |
| Effects | Drop shadow, outer glow, element blur (inner shadow / inner glow / background blur are fill types in the Fills list) |
| Sizing | Frame and Auto Layout: Hug/Fill/Fixed per axis. Group, Mask, Boolean: locked to Hug on both axes |
| Opacity, Blend mode | Element-level (in Element section) |

## Nesting

Parents nest in any combination:
- **Enter** to drill into a parent
- **Shift+Enter** to select the parent
- Layers explorer (Cmd+Shift+R) shows hierarchy

## Reparenting

Drag elements over a parent to auto-reparent:
- **Frame** and **Auto Layout** parents are reparent targets. Auto Layout shows an insertion indicator
- **Group**, **Mask**, **Boolean** parents are NOT reparent targets
- Children inside Group/Mask/Boolean cannot be dragged out (use the layers explorer or convert to Frame first)
- Coordinates auto-transform to target's local space
- Hold **Space** during drag to prevent reparenting

## Creating Parents (Quick Reference)

| Shortcut | Result |
|----------|--------|
| **Cmd+F** | Frame from selection (default fixed sizing, reparent target) |
| **F**, drag | Frame tool: draws frame, captures elements fully inside |
| **Cmd+G** | Group (always Hug on both axes) |
| **Shift+A** | Auto Layout (or in-place convert if a single non-auto-layout parent is selected) |
| **Ctrl+Cmd+M** | Mask |
| **Alt+Shift+U / S / I / E** | Boolean Union / Subtract / Intersect / Exclude |

## Layout Guides

Frames support column, row, and grid layout guides. These are snap targets and inspector configuration only; they do not render on the canvas or in exports. See [layout-guides.md](./layout-guides.md).

- **Shift+G** toggles global visibility of all layout guides
- Add guides via the Layout Guides section's **+** button (default type: Grid)
- Grid command alone, no separate type-picker button on the toolbar; pick the type after creation via the row's Type dropdown

## Troubleshooting Auto Layout

| Symptom | Cause | Fix |
|---------|-------|-----|
| Element not stretching to fill width | Sizing is Fixed or Hug | Change to Fill in W Sizing dropdown (Element section) |
| Element stopped stretching after resize | Resize converts to Fixed | Change back to Fill |
| Fill child has 0 width (invisible) | Fixed/hug siblings consume all space | Make parent larger or reduce siblings |
| Fill not working on main axis | Parent is hug (circular dependency) | Use Fixed parent, or accept hug behavior |
| Children overlapping | Parent is Group, not Auto Layout; or absolute-positioned children | Convert to Auto Layout (Shift+A), or toggle off the pin button |
| Children overflow horizontally | Wrap not enabled, too many hug children | Enable wrap; or shrink children; or grow container |
| Wrap toggle has no effect | Frame hugs on main axis | Set main-axis sizing to Fixed or Fill |
| Auto spacing not pushing items to edges | Only one child | Auto centers a single child; add children or use Fixed alignment |
| Text wrapping when it should not | Text has Fill width | Change W Sizing to Hug |
| Text not wrapping when it should | Text has Hug width in a horizontal layout | Set W Sizing to Fill, H Sizing to Hug |
| Siblings not equal height in a row | Cross-axis (height) is Hug | Set H Sizing to Fill; cross-axis Fill stretches to match the tallest sibling |
| Nested parent not stretching | Auto layout default is hug | Set Fill on the nested parent explicitly |
| Children inside Group/Mask/Boolean cannot be dragged out | Intentional, those types are not reparent targets | Use the layers explorer, or convert to Frame |
| Layout looks wrong after undo | Normal | Re-apply changes if needed |

> **See also:** [editing.md](./editing.md), [layout-guides.md](./layout-guides.md), [components.md](./components.md), [vectors.md](./vectors.md), [crop.md](./crop.md)
