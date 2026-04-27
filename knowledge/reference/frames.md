---
name: "knowledge-frames"
description: "Parent types (frame, group, auto layout, mask, boolean), nesting, sizing, drag reorder, and parent properties in Brilliant."
---

# Parents (Containers)

> **Parent skill:** [reference/frames.md](./frames.md)

In Brilliant, any element that can contain children is called a **parent**. There are eight parent types: **Frame**, **Group**, **Auto Layout**, **Mask**, and four **Boolean** variants (Union, Subtract, Intersect, Exclude). Group, Mask, and the Boolean types share the same constraints (always w:hug h:hug, not reparent targets, children cannot be dragged out).

## Coming From Other Design Tools?

### Figma / Sketch

| Figma / Sketch | Brilliant | Notes |
|----------------|-----------|-------|
| **Frame** | Parent (Frame type) | Free-positioning container. Children placed manually with coordinates |
| **Group** (Cmd+G) | Parent (Group type) | Always w:hug h:hug. Not a drop target for reparenting |
| **Auto Layout Frame** | Parent (Auto Layout type) | Flexbox-like flow layout, children arranged in rows/columns, supports wrap |
| "Component" | "Component" | Same concept, masters and instances. See [components.md](./components.md) |
| "Artboard" | Canvas or Frame | A canvas is a separate page; a frame on a canvas serves as a design area |
| **Mask** (Cmd+Option+M) | Mask (Ctrl+Cmd+M) | Topmost element = clip shape. Same concept, different shortcut (macOS reserves Cmd+Option+M for "Minimize All Windows") |
| Constraints (pin to edges) | Not available | Use auto layout with hug/fill/fixed sizing instead |
| Absolute position (ignore auto layout) | Absolute position (pin icon / `abs` keyword) | Same concept, child ignores auto layout flow |
| Boolean ops (Union/Subtract/etc) | Boolean parents | Each boolean op produces a parent element you can re-edit by double-clicking |

**Key difference from Figma:** Frames, Groups, Masks, and Booleans are all **parent** elements in Brilliant, distinguished by a **parent type**. You can convert between any of them via the Parent Type dropdown in the right toolbar.

### Adobe Illustrator

| Illustrator | Brilliant | Notes |
|-------------|-----------|-------|
| **Artboard** | Canvas or Frame | Each canvas is a separate drawing surface; frames act as bounded areas within a canvas |
| **Group** | Parent (Group type) | Same concept. Cmd+G to group |
| **Clipping Mask** | Mask (Ctrl+Cmd+M) | Select elements, Ctrl+Cmd+M, topmost element defines clip shape. Or use Frame + "Clip content" for simple rectangular clipping |
| **Appearance panel** (multiple fills) | Fills section in right toolbar | Click "+" to add fills; they stack bottom-to-top like Illustrator appearances |
| **Symbols** | Components | Masters and instances with overrides. See [components.md](./components.md) |
| **Pen tool** | Pen tool (P) | Same workflow: click for corners, click-drag for curves. See [vectors.md](./vectors.md) |
| **Direct Selection** (white arrow) | Vector Edit Mode | Select an element, press **Enter** to edit nodes directly |
| **Pathfinder / Boolean ops** | Boolean operations | Select 2+ elements, Boolean Union (Alt+Shift+U), Subtract (Alt+Shift+S), Intersect (Alt+Shift+I), Exclude (Alt+Shift+E). Result is a re-editable parent |
| **Blend modes** (element-level) | Blend mode dropdown | Blend modes on elements, fills, strokes, and effects (16 modes) |
| **Image Trace** | Not available | Vectorize in Illustrator first, then import as SVG |
| **Mesh Gradient** | Not available | Use linear, radial, or angular gradients |

### Canvas vs Frame

A **canvas** is the infinite drawing surface, like a page or document. A **frame** is an element on a canvas that acts as a container for other elements. You can have many frames on a single canvas, and many canvases in a workspace.

## Parent Types

| Type | Description | Sizing | Reparent Target? | Created By |
|------|-------------|--------|-------------------|----------|
| **Frame** | Free-positioning container, children placed with `@X,Y` coordinates | Any (hug/fill/fixed) | Yes | Frame tool (F), Cmd+F |
| **Group** | Free-positioning container, always w:hug h:hug | Always w:hug h:hug | No | Cmd+G |
| **Auto Layout** | Flow container, children arranged automatically in row or column (with optional wrap) | Any | Yes | Shift+A |
| **Mask** | Topmost child clips all others, defines visible region | Always w:hug h:hug | No | Ctrl+Cmd+M |
| **Union** | Boolean: combine all child paths | Always w:hug h:hug | No | Alt+Shift+U |
| **Subtract** | Boolean: subtract front shapes from back | Always w:hug h:hug | No | Alt+Shift+S |
| **Intersect** | Boolean: keep overlapping area only | Always w:hug h:hug | No | Alt+Shift+I |
| **Exclude** | Boolean: keep non-overlapping area only | Always w:hug h:hug | No | Alt+Shift+E |

### Shared Capabilities (All Parent Types)

All parent types support:
- **Fill, stroke, corner radius** — visual styling
- **Clip content** — toggle whether children are hidden beyond parent bounds (Frame and Auto Layout)
- **Effects** — shadows, glows, blurs
- **Nesting** — parents inside parents, any combination of types
- **Conversion** — change between any types via the Parent Type dropdown

**Type-specific differences:**
- **Frame** and **Auto Layout** support all sizing modes (hug/fill/fixed) and accept reparenting (drag elements in/out)
- **Group** is always w:hug h:hug. Changing sizing from hug auto-converts to Frame. Groups are NOT reparent targets (dragging elements over a group will not reparent into it)
- **Mask** is always w:hug h:hug. The topmost child (last in z-order) is the mask shape, it defines the clip path and is invisible. All other children are clipped to the mask shape
- **Boolean** (Union/Subtract/Intersect/Exclude) is always w:hug h:hug. The combined path is rendered; double-click the boolean to enter edit mode and modify children

**Clip defaults:** All parents do not clip by default. Use `clip` / `no-clip` to override.

## Frames

### Creating a Frame

| Action | Result |
|--------|--------|
| **Cmd+F** (with selection) | Wrap selection in a Frame parent |
| **F** (Frame tool, then drag on canvas) | Draw a new Frame; elements fully inside the drawn area are captured as children |
| Right toolbar Parent Type dropdown | Convert any parent to Frame |

**Frame from selection (Cmd+F):** Default sizing is **fixed** (the combined bounds of selected children). The frame is a reparent target.

**Frame tool capture:** When you drag out a frame on the canvas, any elements whose bounds fall entirely inside the drawn rectangle are automatically reparented into the new frame.

### Frame Properties

- **Sizing** — Hug, Fill, or Fixed on each axis (W Sizing / H Sizing dropdowns in right toolbar)
- **Fill, Stroke, Corner radius, Effects, Opacity, Blend mode** — like any element
- **Clip content** — toggle in the Parent section header (next to the Type dropdown)
- **Layout guides** — column, row, or grid overlays (see [layout-guides.md](./layout-guides.md))

## Groups

### Creating a Group

1. Select two or more elements
2. Press **Cmd+G**
3. A group parent wraps the selection

**What happens:**
- Group starts with **hug** sizing (expands/contracts to fit children)
- Content clipping disabled by default
- No fill or stroke by default
- Per-parent grouping: elements from multiple parents create separate groups

### Sizing

Groups are **always w:hug h:hug**, they automatically resize to fit their children. Children move → group adjusts, children added → group expands.

**Changing sizing from hug** on either axis automatically converts the group to a **Frame**. This mirrors how changing text auto-size mode flips text sizing.

### Ungrouping

Select a group and ungroup (**Cmd+Shift+G**, right-click context menu, or command palette):
- Children reparent to the group's parent
- Coordinates transform to parent space
- Frame is deleted, z-order preserved
- If parent is auto layout, layout recalculates
- If the group was a component master, its component relationship is cleaned up first

**Via Blueprint:** `ungroup(#group)` or `ungroup(elementId)` directive in `create_modify_elements`.

### Editing Inside a Group

1. Click the group's label to select it
2. Press **Enter** to enter the group
3. Click individual children
4. Press **Shift+Enter** to select the parent and exit

### Group Properties

- **Fill** — Add background (Shift+F)
- **Stroke** — Add border (Shift+S)
- **Corner radius** — Round corners
- **Clip content** — Toggle clipping (off by default)
- **Sizing** — Always w:hug h:hug (changing from hug auto-converts to Frame)
- **Name** — Rename (Cmd+R)

## Masks

Masks use one element to define the visible region for other elements, like a cookie cutter. The topmost element (highest in layers) becomes the mask shape, and everything below it is clipped to that shape.

### Creating a Mask

1. Select two or more elements
2. Press **Ctrl+Cmd+M** (or right-click → Mask, or command palette → "Mask")
3. A mask parent wraps the selection

> **Why Ctrl+Cmd+M (not Cmd+Option+M)?** macOS reserves Cmd+Option+M for "Minimize All Windows" at the system level.

**What happens:**
- The **topmost element** (last in z-order) becomes the mask shape
- The mask shape is **invisible** in normal mode, it only defines the clip region
- All other children are clipped to the mask shape
- The mask shape includes stroke geometry in the clip path (a circle with a thick stroke masks a larger area than its fill alone)
- Per-parent masking: elements from multiple parents create separate masks

### Editing the Mask Shape

- **Double-click** the mask to enter edit mode, the mask shape becomes visible and selectable
- Modify the mask shape (resize, change arc sweep, edit vector nodes, etc.)
- Changes update the clip path live
- Click outside or press **Escape** to exit edit mode

### Mask Types

| Type | Description |
|------|-------------|
| **Vector** (default) | Clips using the mask shape's vector outline (including stroke geometry) |
| **Alpha** | Defined in the data model; not currently exposed in the UI |
| **Luminance** | Defined in the data model; not currently exposed in the UI |

The active type is always Vector. Alpha and Luminance exist in the file format but cannot be selected from the right toolbar yet.

### Mask Properties

- **Sizing** — Always w:hug h:hug (auto-resizes to fit children)
- **Fill, stroke, corner radius, effects** — apply to the mask result shape (same as boolean parents)
- **Name** — Defaults to "Mask" (rename with Cmd+R)

### Tips

- Any element type can be the mask shape: rectangles, circles, vectors, text
- Stroke geometry is included in the clip path
- Reorder children in the layers panel to change which element is the mask shape (topmost = mask)

## Boolean Operations

Boolean parents combine the paths of their children into a single rendered shape. Like masks, they are always w:hug h:hug and not reparent targets.

| Operation | Shortcut | Result |
|-----------|----------|--------|
| **Union** | Alt+Shift+U | All shapes combined |
| **Subtract** | Alt+Shift+S | Front shapes subtracted from the back shape |
| **Intersect** | Alt+Shift+I | Only the area where all shapes overlap |
| **Exclude** | Alt+Shift+E | Only the area where shapes do NOT overlap |

**Editing:** Double-click a boolean parent to enter edit mode (children become individually visible and editable). Press **Escape** to exit. Reordering children changes the result for Subtract.

**Conversion:** Switching between boolean types (or between boolean and mask) preserves fills/strokes. Switching from boolean/mask to a non-boolean type clears fills/strokes from the parent.

## Auto Layout

Auto layout frames automatically arrange children in a row or column. Optional wrap support handles overflow into multiple rows/columns.

### Creating Auto Layout

1. Select elements
2. Press **Shift+A**
3. Direction, spacing, and alignment are auto-inferred from element positions

**Single-frame in-place conversion:** If a single non-auto-layout frame is already selected, **Shift+A** converts it to auto layout in-place rather than wrapping it in a new frame. Children are sorted by spatial position along the inferred main axis, padding is computed from the frame's existing bounds.

### Right Toolbar Layout

The **Parent** section appears whenever a parent element is selected. Auto-layout-specific controls only appear when all selected parents are auto layout.

```
Parent section
├─ Row 1: Type dropdown    [clip-content button]
└─ Auto layout controls (only when all selected are auto layout):
   ├─ Row 2: 3x3 alignment grid    Spacing field    [wrap button]
   │                                Spacing mode (Fixed / Auto)
   ├─ Row 3: All-padding field    [H/V padding button]    [individual padding button]
   ├─ Optional H/V row (when H/V padding mode is on)
   ├─ Optional 2 individual rows (when individual padding mode is on)
   └─ Row 4: Direction buttons (horizontal / vertical)
```

The W/H sizing dropdowns and the absolute-position pin button live in the **Element** section (above the Rotation row), not the Parent section.

### Direction

| Direction | Description |
|-----------|-------------|
| Horizontal | Children flow left to right |
| Vertical | Children flow top to bottom |

Set via the two arrow buttons at the bottom of the auto layout block.

### Alignment (3x3 Grid)

The alignment grid simultaneously sets main-axis and cross-axis alignment. It maps grid position to alignment based on direction:

- **Horizontal:** columns = main axis (start/center/end), rows = cross axis (start/center/end)
- **Vertical:** rows = main axis, columns = cross axis

**Single-click** a dot to set alignment. **Double-click** a dot to toggle the spacing mode between Fixed and Auto (`spaceBetween`). When Auto is active, only the cross-axis dot can be changed (single-click), the main axis remains `spaceBetween`.

**Main Axis Alignment:**

| Alignment | Description |
|-----------|-------------|
| Start | Pack at beginning |
| Center | Center all children |
| End | Pack at end |
| Space between (Auto spacing) | Equal gaps, first/last at edges (single child centers) |

**Cross Axis Alignment:**

| Alignment | Description |
|-----------|-------------|
| Start | Align to top (horizontal) or left (vertical) |
| Center | Center in available space |
| End | Align to bottom (horizontal) or right (vertical) |

**Note:** With **Space between**, a single child is centered rather than pushed to the start. Two children go to opposite edges with no middle gap.

### Spacing

Gap between children, in pixels. Two modes (dropdown below the spacing field):

| Mode | Behavior |
|------|----------|
| **Fixed** | Use the entered value directly |
| **Auto** | Equivalent to `spaceBetween` main-axis alignment. The spacing field becomes read-only and shows the *computed* gap |

Spacing supports design system tokens (the dropdown menu lists spacing tokens for the active canvas).

### Padding

Three editing modes, toggled with the two buttons next to the all-padding field:

| Mode | Layout | Toggle |
|------|--------|--------|
| **Uniform** (default) | Single field for all four sides | (no button active) |
| **Horizontal/Vertical** | Two fields: H (left+right) and V (top+bottom) | H/V button |
| **Individual** | Four fields: left, top, right, bottom | Square-dashed button |

The all-padding field accepts comma-separated input even in uniform mode: `"16,8"` sets H/V; `"16,8,24,8"` sets L/T/R/B. Padding supports design system tokens.

### Wrap

Toggle the **wrap button** (next to the spacing field, top right of the auto layout block). When enabled, children that overflow the main axis flow to the next row (horizontal) or column (vertical). Equivalent to CSS `flex-wrap: wrap`.

- Wrap only takes effect when the frame has **fixed or fill size on the main axis**. If the frame hugs on the main axis, there is nothing to wrap against.
- The gap between rows/columns equals the item spacing.
- Fill children inside a wrapped row fill that row's width, not the frame's.
- Drag-reorder uses 2D cursor position to find the right row/column first, then the position within it.

### Child Sizing Modes

Set via the **W Sizing** and **H Sizing** dropdowns in the right toolbar's **Element** section (between Dimensions and Rotation).

| Mode | Description |
|------|-------------|
| **Hug** | Uses natural content size |
| **Fill** | Expands to fill remaining space |
| **Fixed** | Uses explicit size |

**Hug** is offered when all selected elements are frames or text. **Fill** is offered when any selected element is inside a frame parent. Otherwise only Fixed is offered.

**Automatic conversion to fixed:** Manually resizing or rotating a child converts it to fixed sizing. This explains why an element might stop stretching after you resize or rotate it, check the sizing dropdown and change it back to Fill if needed.

#### When to Use Each Mode

| Use Case | Width | Height | Notes |
|----------|-------|--------|-------|
| Label / value text (numbers, metrics, units, dates, nav items, section headers) | Hug | Hug | Must not wrap, omit `s()` or set `s(hug,hug)` |
| Prose text (descriptions, paragraphs, body copy) | Fill | Hug | Should wrap, `s(fill,hug)` |
| Text in horizontal layout (expanding) | Fill (**set explicitly**) | Hug | |
| Non-text in vertical layout | Fill *(auto)* | — | |
| Non-text in horizontal layout | — | Fill *(auto)* | |
| Button | Hug | Hug | |
| Icon / avatar | Fixed | Fixed | |
| Input field | Fill | Fixed (e.g., 40px) | |
| Sidebar | Fixed (e.g., 240px) | Fill | |
| Content area | Fill | Fill or Hug | |
| Full-width section | Fill | Hug | |
| Siblings that should be uniform size | Fill | Fill | Fill on cross axis stretches to match tallest/widest sibling |
| Proportional siblings (e.g., 3:1 split) | Fill:N | varies | `fill:3`+`fill:1` = 75%/25%, proportions maintained when parent resizes |

*(auto)* = applied by smart defaults, omit sizing and the system handles it. **Note:** In vertical auto layout, the smart default gives text `fill` width. This is correct for prose but wrong for labels/values, override with `s(hug,hug)` when text should not wrap.

**Horizontal layout text rule:** In a horizontal auto layout with multiple text elements (e.g., bullet + item, label + value), only the expanding text should get `fill` width. Short labels/bullets should keep `hug` (default). Example: `Bullet Row frame auto-h w:fill h:hug` → bullet text stays hug, item text gets `w:fill h:hug`.

#### How Fill Divides Space

When multiple children have Fill sizing on the same axis, they divide the remaining space proportionally based on their **flex factor** (default 1):

```
Frame: 400px wide, 16px padding each side → content area = 368px
Children: [Fixed 80px] [Fill] [Fill] [Fixed 80px]
Spacing: 8px between children

Total spacing = 8 × 3 = 24px
Fixed children = 80 + 80 = 160px
Remaining = 368 - 160 - 24 = 184px
Each Fill child (flex 1) = 184 ÷ 2 = 92px
```

**Flex factor** — set via `fill:N` in the blueprint format (e.g., `s(fill:3,hug)`). Controls proportional distribution:

```
Same frame, but first fill child has flex 3, second has flex 1:
Total flex = 3 + 1 = 4
First Fill child = 184 × 3/4 = 138px
Second Fill child = 184 × 1/4 = 46px
```

Plain `fill` = flex 1 (backward compatible). The **Flex** field appears in the right toolbar's Element section (in the Rotation row) when a fill child on the parent's main axis is selected, prefixed with "F".

If fixed/hug children consume all available space, fill children get 0 width (they will not go negative, but may become invisible).

#### Fill Inside Hug Frames

Fill behavior changes depending on parent type, axis, and whether the parent uses Hug sizing:

**Auto layout frames:**

| Scenario | Behavior |
|----------|----------|
| Fill on **main axis** + frame Hug | Fill **collapses to content size** (acts like Hug) |
| Fill on **cross axis** + frame Hug | Fill **works normally** (stretches to widest sibling) |
| Fill + frame Fixed | Fill works normally |

**Why?** The main axis size of a Hug frame equals the sum of its children. If a child says "fill remaining space" and the frame says "be as small as my children," that is a circular dependency. So fill collapses to content size on the main axis.

The cross axis does not have this problem because the frame's cross-axis size equals the **max** of its children, not the sum. Cross-axis fill children are **excluded** from the hug calculation entirely, only non-fill siblings (fixed/hug) determine the cross-axis hug size. Fill children then stretch to match.

**Edge case (all-fill children):** When ALL children are fill on the cross axis (no non-fill anchor), Brilliant measures each child's natural content size and uses the largest as the cross-axis bootstrap. Common in pricing grids and multi-column layouts.

**Example:** Vertical auto layout frame with Hug width and Hug height:
- Child with Fill width (cross axis): excluded from hug width calculation, then stretches to match widest sibling
- Child with Fill height (main axis): collapses to its content height (acts like Hug)

**Common pattern, accent bar:** A thin rectangle with `w:fixed h:fill` inside a horizontal auto-layout frame. The rect's explicit height does not affect the parent's hug height; siblings determine it, and the accent bar stretches to match.

**Plain frames and groups (non-auto-layout):**

Fill collapses to content size on **both** axes, there is no main/cross distinction since there is no layout direction. A fill-width text inside a hug-width plain frame will not wrap; it renders at its natural single-line width. This matches Figma behavior.

### Frame Axis Sizing

| Mode | Description |
|------|-------------|
| **Hug** | Frame fits children plus padding |
| **Fill** | Frame expands to fill available space in parent |
| **Fixed** | Frame keeps explicit size |

### Absolute Position

Children of auto layout frames can opt out of the layout flow with **absolute positioning**. An absolute child stays nested in the frame (clipping, coordinate space, z-order) but does not participate in positioning, spacing, or hug sizing, it moves and resizes freely like a regular frame child.

**Toggle:** Select a child of an auto layout frame, click the **pin icon** in the right toolbar's **Element** section (right of the W/H Sizing dropdowns), or run the "Toggle Ignore Auto Layout" command.

The pin button only appears when at least one selected element is inside an auto layout frame.

**Blueprint:** Add `abs` keyword: `c abs p(200,-8) s(20,20) f[(#EF4444)]`

**Use for:** Badges, notification dots, floating buttons, watermarks, decorative overlays, anything that should sit on top of auto layout content without disrupting the flow.

**Behavior:**
- Absolute children do not affect siblings, do not consume gap space, do not contribute to hug sizing
- Absolute children are excluded from drag reorder and from arrow-key reorder (arrow keys nudge them like normal elements)
- Toggling back to flow repositions the element at its z-order position in the auto layout

### Reordering Children

Inside auto layout, children are reordered rather than freely positioned:

**Drag reorder** (flow children only; absolute children move freely instead):
1. Select and start dragging
2. Insertion indicator shows placement (a line perpendicular to the main axis)
3. Release to drop
4. Siblings reflow

In wrapped layouts, the insertion index is computed in 2D (cursor position determines which row/column first, then position within it).

**Keyboard reorder:** Arrow keys reorder flow children along the main axis instead of nudging:
- **Horizontal layout:** Left arrow = move earlier, Right arrow = move later
- **Vertical layout:** Up arrow = move earlier, Down arrow = move later
- Cross-axis arrow keys are ignored (no effect)
- Absolute-positioned children are not affected (arrow keys nudge them normally)

### What Happens on Operations

| Operation | Effect |
|-----------|--------|
| Resize a child | Converts to fixed, re-layouts |
| Rotate a child | Converts to fixed, re-layouts |
| Delete a child | Siblings reflow |
| Add a child | Inserted at end, re-layouts |
| Arrow keys | Reorders flow children along main axis (absolute children nudge normally) |
| Drag within frame | Reorders via drag (flow children) or free move (absolute children) |
| Drag to different frame | Reparents, both re-layout |
| Toggle absolute position | Removes/adds child from layout flow |

### Converting Between Types

In right toolbar **Parent** section, change the Parent Type dropdown. The dropdown lists all eight parent types: Frame, Group, Auto Layout, Union, Subtract, Intersect, Exclude, and Mask.

Common conversions:

| From → To | Effect |
|-----------|--------|
| Frame → Group | Forces w:hug h:hug, clears auto layout data |
| Frame → Auto Layout | Infers direction, spacing, alignment, padding from current child positions |
| Frame → Boolean | Forces hug, clears auto layout data, clears fills/strokes (only when source was non-boolean/non-mask), renames |
| Frame → Mask | Forces hug, clears auto layout data, clears fills/strokes (only when source was non-boolean/non-mask), renames to "Mask" |
| Group → Frame | Unlocks sizing (keeps current hug values but allows changes) |
| Group → Auto Layout | Infers layout, unlocks sizing |
| Auto Layout → Frame | Clears auto layout data, children keep current positions |
| Auto Layout → Group | Clears auto layout data, forces w:hug h:hug |
| Boolean → Boolean | Preserves fills/strokes, switches operation type, renames |
| Boolean ↔ Mask | Preserves fills/strokes (both render them on the result shape) |
| Mask → non-mask (non-boolean) | Standard conversion, keeps fills/strokes |

**Auto-conversion:** Changing a Group's sizing from hug on either axis automatically converts it to Frame.

## Parent Properties (All Types)

| Property | Description |
|----------|-------------|
| Clip content | Clip children to parent bounds. Default: **off** for all types. Toggle button next to the Type dropdown in the Parent section. Use `clip` / `no-clip` in blueprint format |
| Corner radius | Rounded corners (per-corner or uniform) |
| Fill | Background color, gradient, image, or shader |
| Stroke | Border/outline |
| Effects | Shadows, glows, blurs |
| Sizing | Frame and Auto Layout: hug/fill/fixed on each axis. Group, Mask, Boolean: always w:hug h:hug |
| Opacity, Blend mode | Element-level (in Element section) |

## Nesting

Parents can nest inside other parents:
- **Enter** to drill into a parent
- **Shift+Enter** to select the parent (go back up)
- Layers explorer (Cmd+Shift+R) shows hierarchy

## Reparenting

Drag elements over a parent to auto-reparent:
- **Frame** and **Auto Layout** parents are reparent targets, elements dropped on them are reparented (auto layout shows an insertion indicator)
- **Group**, **Mask**, and **Boolean** parents are NOT reparent targets, dragging over them will not reparent into them
- Children inside a Group, Mask, or Boolean parent **cannot be dragged out**, they stay in their parent during drag (use the layers panel or ungroup instead)
- Coordinates transform to the target's local space
- Hold **Space** to prevent reparenting during drag

## Creating Parents

### From Selection

| Shortcut | Result |
|----------|--------|
| **Cmd+F** | Frame (wraps selection in a Frame parent) |
| **Cmd+G** | Group (always w:hug h:hug, not a reparent target) |
| **Shift+A** | Auto layout parent (or in-place convert if a single non-auto-layout frame is selected) |
| **Ctrl+Cmd+M** | Mask |
| **Alt+Shift+U** | Boolean Union |
| **Alt+Shift+S** | Boolean Subtract |
| **Alt+Shift+I** | Boolean Intersect |
| **Alt+Shift+E** | Boolean Exclude |

### Using Frame Tool (F)

Press **F** to activate the Frame tool, then drag on the canvas to create a Frame parent. Elements fully inside the drawn rectangle are captured as children.

## Layout Guides

Frames support column, row, and grid overlays for alignment and snapping. See [layout-guides.md](./layout-guides.md) for full documentation.

**Quick reference:**
- **Shift+G** — Toggle visibility of all layout guides globally
- Add a guide via the right toolbar **Layout Guides** section (+ button)

## Troubleshooting Auto Layout

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Element not stretching to fill width | Sizing mode is Fixed or Hug | Change to Fill in W Sizing dropdown (right toolbar Element section) |
| Element stopped stretching after resize | Resize converts to Fixed | Change back to Fill |
| Fill child is invisible (0 width) | Fixed/hug siblings consume all space | Make parent larger or reduce sibling sizes |
| Fill not working on main axis | Parent uses Hug sizing (circular dependency) | Use Fixed size on parent, or accept that fill acts as hug |
| Children overlapping | Parent is a Group, not Auto Layout; or children have absolute position | Convert to Auto Layout (Shift+A), or toggle off the pin button |
| Children overflow horizontally | Too many hug children for container width, and wrap is not enabled | Enable wrap (button next to spacing field), or reduce children, use smaller sizing, or increase container width |
| Wrap toggle has no effect | Frame hugs on the main axis | Change main-axis sizing to Fixed or Fill (wrap needs a constraint to wrap against) |
| Unexpected gaps between children | Check spacing setting | Adjust the spacing field |
| Auto spacing not pushing items to edges | Only one child | Auto spacing centers a single child; add more children or use Fixed alignment |
| Text wrapping when it should not | Text has `fill` width | Change to `hug`, fill width applies a constraint that causes wrapping |
| Text not wrapping when it should | Text has `hug` width in horizontal layout | Set `w:fill h:hug` explicitly |
| Siblings not equal height in a row | Cross-axis (height) is `hug`, each sizes to own content | Use `fill` height, cross-axis fill stretches to match tallest sibling |
| Nested parent not stretching | Auto layout parents default to Hug | Explicitly set Fill sizing on the nested parent |
| Children inside Group/Mask/Boolean cannot be dragged out | Intentional, those types are not reparent targets | Use the layers panel to reparent, or convert to Frame first |
| Layout looks wrong after undo | Normal, undo restores previous state | Re-apply changes if needed |

> **See also:** [editing.md](./editing.md) for selection and navigation within parents
> **See also:** [layout-guides.md](./layout-guides.md) for layout guide documentation
> **See also:** [components.md](./components.md) for components/instances
> **See also:** [vectors.md](./vectors.md) for boolean op editing details
