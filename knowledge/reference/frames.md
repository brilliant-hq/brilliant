---
name: "knowledge-frames"
description: "Parent types (Frame, Group, Auto Layout, Mask, Boolean), nesting, sizing, drag reorder, parent properties, and component-style conversion."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Parents (Containers)

In Brilliant, every container element is a **parent** (`ElementType.parent`). Parents come in 8 sub-types stored in `ParentData.type`: **Frame**, **Group**, **Auto Layout**, **Mask**, and four **Boolean** variants (Union, Subtract, Intersect, Exclude). Group, Mask, and all Boolean types share three constraints: always w:hug h:hug, NOT reparent targets, children cannot be dragged out during drag.

## Coming From Other Tools

### Figma / Sketch

| Figma / Sketch | Brilliant | Notes |
|----------------|-----------|-------|
| **Frame** | Parent (Frame) | Free-positioning container with fixed sizing by default |
| **Group** (Cmd+G) | Parent (Group) | Always w:hug h:hug. NOT a drop target |
| **Auto Layout Frame** (Shift+A) | Parent (Auto Layout) | Flow layout, supports wrap |
| Component | Component | Masters and instances. See [components.md](./components.md) |
| Artboard | Canvas (separate page) or Frame (bounded area) | |
| **Mask** (Cmd+Option+M) | Mask (**Ctrl+Cmd+M**) | macOS reserves Cmd+Option+M for "Minimize All Windows" |
| Constraints (pin to edges) | Not available | Use auto layout with hug/fill/fixed |
| Absolute position | `abs` keyword / pin button in Element section | Same concept |
| Boolean ops | Boolean parents | Each op produces a re-editable parent (double-click to edit) |

**Frames, Groups, Masks, and Booleans are all parent elements** distinguished by `ParentType`. Convert between any of them via the **Type dropdown** in the right toolbar's Parent section.

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
| **Frame** | Any (hug/fill/fixed). Default: fixed | Yes | Cmd+F (wrap), F (frame tool), Type dropdown |
| **Group** | Always w:hug h:hug | No | Cmd+G |
| **Auto Layout** | Any. Default: hug | Yes | Shift+A |
| **Mask** | Always w:hug h:hug | No | Ctrl+Cmd+M |
| **Boolean Union** | Always w:hug h:hug | No | Alt+Shift+U |
| **Boolean Subtract** | Always w:hug h:hug | No | Alt+Shift+S |
| **Boolean Intersect** | Always w:hug h:hug | No | Alt+Shift+I |
| **Boolean Exclude** | Always w:hug h:hug | No | Alt+Shift+E |

### Shared Capabilities

All parent types support:
- Fill, stroke, corner radius (per-corner or uniform)
- Clip content toggle
- Effects (drop shadow, outer glow, element blur)
- Nesting (parents inside parents, any combination)
- Conversion to any other parent type via the dropdown

**Default `clipContent: false`** for all parent types. Toggle with the scissors button next to the Type dropdown, or the `clip` / `no-clip` keywords in blueprint format.

### Type-Specific Differences

- **Frame** and **Auto Layout** support all sizing modes and accept reparenting (drag elements in/out).
- **Group** is always w:hug h:hug. Changing sizing from hug on either axis auto-converts to **Frame**. Groups are NOT reparent targets.
- **Mask** is always w:hug h:hug. The **topmost child** (last in z-order) defines the clip path, is invisible in normal mode, and includes stroke geometry in the clip. Other children are clipped to the mask shape.
- **Boolean** is always w:hug h:hug. The combined path is rendered. Double-click to enter edit mode (children become editable; Subtract is z-order sensitive).

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
- `widthSizing: hug, heightSizing: hug` (forced)
- `clipContent: false`, no fill, no stroke
- Z-order: inserted at the backmost selected element's position

### Sizing

Groups are **always w:hug h:hug** (auto-resize to fit children). **Changing sizing from hug on either axis auto-converts to Frame.**

### Ungrouping (Cmd+Shift+G)

| Action | Effect |
|--------|--------|
| Cmd+Shift+G, right-click → Ungroup, or palette | Reparent children to group's parent, transform coordinates, delete group, preserve z-order |

If the group is a component master, its component relationship is cleaned up first. If it's an instance, it is detached first. If the group's parent is auto layout, the parent re-layouts.

### Editing Inside a Group

1. Click the group's frame label to select it
2. Press **Enter** to drill in (selects first child)
3. Click children individually
4. Press **Shift+Enter** to select the parent (go up)

### Group Properties

- **Fill** (Shift+F), **Stroke** (Shift+S), **Corner radius**, **Effects**
- **Clip content** off by default
- **Sizing**: always hug (changing → Frame)
- **Rename**: Cmd+R, or double-click the frame label on canvas

## Masks (Ctrl+Cmd+M)

A mask uses one element to clip others, like a cookie cutter. The **topmost element** (last in z-order) becomes the clip shape; everything below is clipped to it.

### Creating a Mask

1. Select 2+ elements
2. Press **Ctrl+Cmd+M** (or right-click → Mask, or palette → "Mask")
3. A Mask parent wraps the selection (per-parent: one mask per source parent)

**At creation:**
- The mask shape includes **stroke geometry** in the clip (a circle with a thick stroke masks a wider area than its fill alone)
- The mask shape is invisible in normal mode
- Frame defaults: w:hug h:hug, no fill, no stroke, `clipContent: false` (clipping is via mask shape, not bounds)

### Editing the Mask Shape

- **Double-click** the mask to enter edit mode: the mask shape becomes visible and editable
- Modify it (resize, change arc, edit vector nodes, etc.); changes update the clip path live via `shapeNeedsUpdateCounter` invalidation
- **Escape** or click outside to exit

### Mask Types

| Type | Description |
|------|-------------|
| Vector (default, `MaskType.vector`) | Clip via the mask shape's vector outline including stroke geometry |
| Alpha (`MaskType.alpha`) | Defined in the data model and serialized; not exposed in the UI |
| Luminance (`MaskType.luminance`) | Defined in the data model and serialized; not exposed in the UI |

The active type is always Vector. Alpha/Luminance round-trip in the file format but cannot be selected via the right toolbar.

### Mask Properties

- **Sizing**: always w:hug h:hug
- **Fill, stroke, corner radius, effects**: rendered on the mask result shape (same overlay path used by booleans)
- **Tip**: any element type can be the mask shape (rectangle, circle, vector, text). Reorder children in the layers explorer to change which is the mask shape (last/topmost = mask).

## Boolean Operations

Boolean parents combine child paths. Always w:hug h:hug. Not reparent targets.

| Operation | Shortcut |
|-----------|----------|
| Union | Alt+Shift+U |
| Subtract | Alt+Shift+S |
| Intersect | Alt+Shift+I |
| Exclude | Alt+Shift+E |

**Editing:** Double-click to enter edit mode (children individually editable). Escape exits. Subtract is z-order sensitive: front shapes subtract from the back.

**Type conversion:**
- Boolean ↔ Boolean (or Boolean ↔ Mask): preserves fills/strokes (both render them on the result shape via post-children overlay) and renames
- Boolean → non-Boolean / non-Mask: standard conversion, keeps fills/strokes
- Non-Boolean/Non-Mask → Boolean or Mask: clears fills/strokes, forces hug, renames (Mask → "Mask"; booleans → e.g. "Union")

## Auto Layout (Shift+A)

Auto layout frames flow children in a row or column, with optional wrap.

### Creating Auto Layout

1. Select elements
2. Press **Shift+A**
3. Direction, spacing, padding, and cross-axis alignment are inferred from element positions

**Defaults applied at creation** (vs `AutoLayoutData()` constructor defaults):

| Field | At creation (`addAutoLayoutToElements`) | Constructor default |
|-------|----------------------------------------|---------------------|
| `direction` | inferred (horizontal if spread is wider than tall; **horizontal for 0–1 elements**) | vertical |
| `mainAxisAlignment` | start | start |
| `crossAxisAlignment` | inferred from positions | start |
| `itemSpacing` | inferred from average gap | 10 |
| padding (all four) | **0** | 10 |
| `wrap` | false | false |

The frame's `LayoutBehavior` is forced to `widthSizing: hug, heightSizing: hug` at creation.

### Single-Frame In-Place Conversion

When **Shift+A** is pressed with a **single non-auto-layout parent** selected, that parent is converted in-place via `setParentType(autoLayout)` instead of being wrapped. Children are sorted by spatial position along the inferred main axis. Padding is computed from the existing frame bounds.

### Right Toolbar (Parent Section)

The Parent section appears whenever any parent is selected. Auto-layout-specific controls appear only when **all** selected parents are auto layout.

```
Parent section
├─ Type row: Type dropdown      [Clip-content scissors button]
└─ Auto layout controls (when all selected are auto layout):
   ├─ Row 1: 3x3 alignment grid │ Spacing field         │ Wrap toggle
   │                            │ Spacing-mode dropdown │
   ├─ Row 2: All-padding field  [H/V mode toggle]  [Individual mode toggle]
   ├─ (H/V padding row, if H/V mode is on): H field, V field
   ├─ (Individual padding rows, if Individual mode is on): L,T then R,B
   └─ Row 3: Direction buttons (Horizontal / Vertical)
```

The **W/H Sizing dropdowns** and **absolute-position pin button** live in the **Element** section's sizing row (NOT the Parent section): the row sits between Dimensions and Rotation. The pin button is the rightmost button in that sizing row.

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

**Single-click** a dot to set alignment. **Double-click** a dot to toggle the spacing mode between Fixed and Auto (`spaceBetween`). When Auto is active, only the cross-axis dot remains adjustable (the main axis is locked to spaceBetween).

**Main-axis options:** start, center, end, **spaceBetween (Auto spacing)**. With spaceBetween + a **single child**, the child is centered (not pushed to start). With 2 children, they go to opposite edges with no middle gap.

**Cross-axis options:** start, center, end.

### Spacing

Gap between children, in pixels. Modes:

| Mode | Behavior |
|------|----------|
| Fixed | The entered value is used directly |
| Auto | Equivalent to `spaceBetween` main-axis alignment. The spacing field becomes read-only and shows the *computed* gap (stored on `AutoLayoutData.computedItemSpacing`) |

Spacing supports design system tokens via the spacing-tokens menu.

### Padding

Three editing modes, switched via the two buttons next to the all-padding field:

| Mode | Layout | Toggle button |
|------|--------|---------------|
| **Uniform** (default) | Single field for all four sides | (none active) |
| **H/V** | H (left+right) and V (top+bottom) fields | `arrow.left.arrow.right` |
| **Individual** | L/T then R/B fields (two rows) | `square.dashed` |

The all-padding field accepts comma-separated input even in uniform mode: `"16,8"` sets H/V; `"16,8,24,8"` sets L/T/R/B. Padding supports design system tokens.

### Wrap

Wrap toggle button (rightmost in the alignment+spacing row). When enabled, overflowing children flow to the next row (horizontal) or column (vertical). CSS `flex-wrap: wrap` equivalent.

- Wrap only takes effect when the frame has **fixed or fill** sizing on the **main axis** (need a constraint to wrap against)
- Row/column gap equals the item spacing
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

**Auto-conversion:** Manually resizing or rotating a child converts it to **Fixed** sizing with current dimensions. Change the dropdown back to Fill if needed.

#### When to Use Each Mode

| Use Case | Width | Height | Notes |
|----------|-------|--------|-------|
| Label / value text (numbers, metrics, units, dates, nav items, section headers) | Hug | Hug | Must not wrap. Omit `s()` only if the smart default produces hug,hug; otherwise set `s(hug,hug)` explicitly. In **vertical** auto layout the smart default is `fill,hug` for text: override |
| Prose / body / descriptions | Fill | Hug | Should wrap. `s(fill,hug)` |
| Text in horizontal layout (expanding) | Fill (set explicitly) | Hug | |
| Non-text in vertical layout | Fill *(auto)* |  | |
| Non-text in horizontal layout |  | Fill *(auto)* | |
| Button | Hug | Hug | |
| Icon / avatar | Fixed | Fixed | |
| Input field | Fill | Fixed (e.g., 40) | |
| Sidebar | Fixed (e.g., 240) | Fill | |
| Content area | Fill | Fill or Hug | |
| Full-width section | Fill | Hug | |
| Siblings that should match dimension | Fill | Fill | Cross-axis fill stretches to match tallest/widest sibling |
| Proportional siblings (e.g., 3:1 split) | Fill:N | varies | `fill:3`+`fill:1` = 75%/25% |

**Horizontal layout text rule:** With multiple text elements in a horizontal auto layout (label + value, bullet + item), only the expanding text gets `fill` width. Short labels/bullets stay `hug`.

#### Flex Factor

Multiple Fill children divide remaining space proportionally by their **flex factor** (`LayoutBehavior.flex`, default `1.0`).

```
Frame: 400 wide, 16px padding each side → content = 368
Children: [Fixed 80] [Fill] [Fill] [Fixed 80], 8px spacing × 3 = 24
Remaining = 368 − 160 − 24 = 184
Each Fill (flex 1) = 184 / 2 = 92
```

`fill:3` + `fill:1` → first gets 138, second gets 46 (75%/25%).

The **Flex** field appears in the Element section's **corner-radius row** (not the Rotation row), prefixed with "F", when a Fill child on the parent's main axis is selected. Plain `fill` = flex 1.0.

If fixed/hug children consume all available space, fill children get 0 width (clamped, never negative).

#### Fill Inside Hug Frames

**Auto layout frames:**

| Scenario | Behavior |
|----------|----------|
| Fill on **main axis** + frame Hug | **Collapses to content size** (acts like Hug). Avoids circular dependency: frame size = sum of children, but fill wants frame size to compute |
| Fill on **cross axis** + frame Hug | Works normally. Fill children are excluded from the cross-axis hug calculation; non-fill siblings determine the cross-axis size; fill children stretch to match |
| Fill + frame Fixed | Works normally |

**All-fill cross-axis edge case:** When ALL children have `fill` on the cross axis (no non-fill anchor), Brilliant measures each child's natural content size and uses the largest as the cross-axis bootstrap. Common in pricing grids and multi-column layouts.

**Accent-bar pattern:** A thin rectangle with `w:fixed h:fill` inside a horizontal auto layout. The rect's height does not affect the parent's hug height; siblings determine it, and the bar stretches.

**Plain frames and groups (non-auto-layout):** Fill collapses to content size on **both** axes (no main/cross distinction). A fill-width text inside a hug-width plain frame will not wrap; it renders at its natural single-line width. Matches Figma.

### Frame Axis Sizing

| Mode | Description |
|------|-------------|
| Hug | Frame fits children + padding |
| Fill | Frame expands to fill available space |
| Fixed | Frame keeps explicit size |

### Absolute Position

Children of auto layout frames can opt out of layout flow with **absolute positioning**. An absolute child stays nested (clipping, coordinate space, z-order) but does not participate in positioning, spacing, or hug sizing. It moves and resizes freely.

**Toggle:**
- Pin button in the right toolbar's **Element** section sizing row (rightmost button), or
- Run "Toggle Ignore Auto Layout" command (`toggle_absolute_position`)

The pin button only appears when at least one selected element is inside an auto layout frame.

**Blueprint:** add `abs` keyword: `c abs p(200,-8) s(20,20) f[(#EF4444)]`

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
| Add a child | Re-layouts via reactive hook |
| Arrow keys | Reorders flow children along main axis (absolute children nudge normally) |
| Drag within frame | Drag-reorder for flow children, free move for absolute children |
| Drag to different frame | Reparents both, both re-layout |
| Toggle absolute position | Removes from / re-inserts into flow |

### Converting Between Types

The Type dropdown in the right toolbar Parent section lists all 8 types: Frame, Group, Auto Layout, Union, Subtract, Intersect, Exclude, Mask.

Common conversions:

| From → To | Effect |
|-----------|--------|
| Frame → Group | Forces w:hug h:hug, clears auto layout data |
| Frame → Auto Layout | Infers direction, spacing, alignment, padding from current child positions; sorts children spatially along main axis |
| Frame → Boolean | Forces hug, clears auto layout data, **clears fills/strokes** (only when source is non-boolean/non-mask), renames |
| Frame → Mask | Forces hug, clears auto layout data, clears fills/strokes (only when source is non-boolean/non-mask), renames to "Mask" |
| Group → Frame | Unlocks sizing |
| Group → Auto Layout | Infers layout, unlocks sizing |
| Auto Layout → Frame | Clears auto layout data, children keep current positions |
| Auto Layout → Group | Clears auto layout data, forces w:hug h:hug |
| Boolean ↔ Boolean | Preserves fills/strokes, renames |
| Boolean ↔ Mask | Preserves fills/strokes |
| Mask → non-mask non-boolean | Standard conversion, keeps fills/strokes |

**Auto-conversion:** Changing a Group's sizing from hug on either axis automatically converts it to Frame.

**Side effect:** Converting an auto layout parent to any non-auto-layout type **strips `isAbsolutePosition`** from all children.

## Parent Properties (All Types)

| Property | Description |
|----------|-------------|
| Clip content | Clip children to parent bounds. Default: **off** for all types. Toggle: scissors button next to Type dropdown. Blueprint: `clip` / `no-clip` |
| Corner radius | Per-corner or uniform; supports radius tokens |
| Fill | Color, gradient, image, or shader |
| Stroke | Border |
| Effects | Drop shadow, outer glow, element blur (inner shadow / inner glow / background blur are fill types in the Fills list) |
| Sizing | Frame and Auto Layout: hug/fill/fixed per axis. Group, Mask, Boolean: locked to w:hug h:hug |
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
| **Cmd+G** | Group (always w:hug h:hug) |
| **Shift+A** | Auto Layout (or in-place convert if a single non-auto-layout parent is selected) |
| **Ctrl+Cmd+M** | Mask |
| **Alt+Shift+U / S / I / E** | Boolean Union / Subtract / Intersect / Exclude |

## Layout Guides

Frames support column, row, and grid overlays. See [layout-guides.md](./layout-guides.md).

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
| Text wrapping when it should not | Text has `fill` width | Change to `hug` |
| Text not wrapping when it should | Text has `hug` in horizontal layout | Set `w:fill h:hug` explicitly |
| Siblings not equal height in a row | Cross-axis (height) is `hug` | Use `fill` height; cross-axis fill stretches to match tallest sibling |
| Nested parent not stretching | Auto layout default is hug | Set Fill on the nested parent explicitly |
| Children inside Group/Mask/Boolean cannot be dragged out | Intentional, those types are not reparent targets | Use the layers explorer, or convert to Frame |
| Layout looks wrong after undo | Normal | Re-apply changes if needed |

> **See also:** [editing.md](./editing.md), [layout-guides.md](./layout-guides.md), [components.md](./components.md), [vectors.md](./vectors.md), [crop.md](./crop.md)
