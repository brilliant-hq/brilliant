---
name: "knowledge-frames"
description: "Parent types (frame, group, auto layout), nesting, and parent properties in Brilliant."
---

# Parents (Containers)

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

In Brilliant, any element that can contain children is called a **parent**. Parents come in three types — **frame**, **group**, and **auto layout**.

## Coming From Other Design Tools?

### Figma / Sketch

| Figma / Sketch | Brilliant | Notes |
|----------------|-----------|-------|
| **Frame** | Parent (Frame type) | Free-positioning container. Children placed manually with coordinates |
| **Group** (Cmd+G) | Parent (Group type) | Always w:hug h:hug. Not a drop target for reparenting |
| **Auto Layout Frame** | Parent (Auto Layout type) | Flexbox-like flow layout — children arranged in rows/columns |
| "Component" | "Component" | Same concept — masters and instances. See [COMPONENTS.md](./COMPONENTS.md) |
| "Artboard" | Canvas or Frame | A canvas is a separate page; a frame on a canvas serves as a design area |
| Constraints (pin to edges) | Not available | Use auto layout with hug/fill/fixed sizing instead |

**Key difference from Figma:** In Figma, "Frame" and "Group" are distinct top-level concepts. In Brilliant, they're all **parent** elements with a **parent type** that determines their layout behavior. You can convert between types freely via the Parent Type dropdown in the right toolbar.

### Adobe Illustrator

| Illustrator | Brilliant | Notes |
|-------------|-----------|-------|
| **Artboard** | Canvas or Frame | Each canvas is a separate drawing surface; frames act as bounded areas within a canvas |
| **Group** | Parent (Group type) | Same concept. Cmd+G to group |
| **Clipping Mask** | Frame with Clip Content | Draw a frame (F key), place elements inside, enable "Clip content" in right toolbar |
| **Appearance panel** (multiple fills) | Fills section in right toolbar | Click "+" to add fills; they stack bottom-to-top like Illustrator appearances |
| **Symbols** | Components | Masters and instances with overrides. See [COMPONENTS.md](./COMPONENTS.md) |
| **Pen tool** | Pen tool (P) | Same workflow: click for corners, click-drag for curves. See [VECTORS.md](./VECTORS.md) |
| **Direct Selection** (white arrow) | Vector Edit Mode | Select an element, press **Enter** to edit nodes directly |
| **Pathfinder / Boolean ops** | Boolean operations | Select 2+ elements → Boolean Union (Alt+Shift+U), Subtract (Alt+Shift+S), Intersect (Alt+Shift+I), Exclude (Alt+Shift+E) |
| **Blend modes** (element-level) | Blend mode dropdown | Blend modes on elements, fills, strokes, and effects (16 modes) |
| **Image Trace** | Not available | Vectorize in Illustrator first, then import as SVG |
| **Mesh Gradient** | Not available | Use linear, radial, or angular gradients |

### Canvas vs Frame

A **canvas** is the infinite drawing surface — like a page or document. A **frame** is an element on a canvas that acts as a container for other elements. You can have many frames on a single canvas, and many canvases in a workspace.

## Parent Types

| Type | Description | Sizing | Reparent Target? | Shortcut |
|------|-------------|--------|-------------------|----------|
| **Frame** | Free-positioning container — children placed with `@X,Y` coordinates | Any (hug/fill/fixed) | Yes | Frame tool (F) |
| **Group** | Free-positioning container — always w:hug h:hug | Always w:hug h:hug | No | Cmd+G |
| **Auto Layout** | Flow container — children arranged automatically in a row or column | Any | Yes | Shift+A |

### Shared Capabilities (All Parent Types)

All parent types support:
- **Fill, stroke, corner radius** — visual styling
- **Clip content** — toggle whether children are hidden beyond parent bounds
- **Nesting** — parents inside parents, any combination of types

**Type-specific differences:**
- **Frame** and **Auto Layout** support all sizing modes (hug/fill/fixed) and accept reparenting (drag elements in/out)
- **Group** is always w:hug h:hug — changing sizing from hug auto-converts to Frame. Groups are NOT reparent targets (dragging elements over a group won't reparent into it)

**Clip defaults:** All parents do not clip by default. Use `clip` / `no-clip` to override.

## Groups

### Creating a Group

1. Select one or more elements
2. Press **Cmd+G**
3. A group parent wraps the selection

**What happens:**
- Group starts with **hug** sizing (expands/contracts to fit children)
- Content clipping disabled by default
- No fill or stroke by default
- Per-parent grouping: elements from multiple parents create separate groups

### Sizing

Groups are **always w:hug h:hug** — they automatically resize to fit their children. Children move → group adjusts, children added → group expands.

**Changing sizing from hug** on either axis automatically converts the group to a **Frame**. This is similar to how changing text auto-size mode converts text sizing.

### Ungrouping

Select a group and ungroup (**Cmd+Shift+G**, right-click context menu, or command palette):
- Children reparent to the group's parent
- Coordinates transform to parent space
- Frame is deleted, z-order preserved
- If parent is auto layout, layout recalculates

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

## Auto Layout

Auto layout frames automatically arrange children in a row or column.

### Creating Auto Layout

1. Select elements
2. Press **Shift+A**
3. Direction, spacing, and alignment are auto-inferred from element positions

### Properties

All editable in right toolbar **Parent** section:

**Direction:**

| Direction | Description |
|-----------|-------------|
| Horizontal | Children flow left to right |
| Vertical | Children flow top to bottom |

**Spacing:** Gap between children (in pixels). Use the slider or AI ("spacing 12").

**Padding:** Space between frame edge and children. Three editing modes: **uniform** (one value for all sides), **horizontal/vertical** (separate h and v values), and **per-side** (individual top, right, bottom, left values). Toggle between modes using the padding section buttons in the right toolbar.

**Main Axis Alignment:**

| Alignment | Description |
|-----------|-------------|
| Start | Pack at beginning |
| Center | Center all children |
| End | Pack at end |
| Space between | Equal gaps, first/last at edges (single child centers) |

**Note:** With **space between** alignment, a single child is centered rather than pushed to the start. Two children go to opposite edges with no middle gap.

**Cross Axis Alignment:**

| Alignment | Description |
|-----------|-------------|
| Start | Align to top (horizontal) or left (vertical) |
| Center | Center in available space |
| End | Align to bottom (horizontal) or right (vertical) |

### Child Sizing Modes

| Mode | Description |
|------|-------------|
| **Hug** | Uses natural content size |
| **Fill** | Expands to fill remaining space |
| **Fixed** | Uses explicit size |

Set via right toolbar sizing dropdowns.

**Automatic conversion to fixed:** Manually resizing or rotating a child converts it to fixed sizing. This explains why an element might stop stretching after you resize or rotate it — check the sizing dropdown and change it back to Fill if needed.

#### When to Use Each Mode

| Use Case | Width | Height | Notes |
|----------|-------|--------|-------|
| Label / value text (numbers, metrics, units, dates, nav items, section headers) | Hug | Hug | Must not wrap — omit `s()` or set `s(hug,hug)` |
| Prose text (descriptions, paragraphs, body copy) | Fill | Hug | Should wrap — `s(fill,hug)` |
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
| Proportional siblings (e.g., 3:1 split) | Fill:N | varies | `fill:3`+`fill:1` = 75%/25% — proportions maintained when parent resizes |

*(auto)* = applied by smart defaults — omit sizing and the system handles it. **Note:** In vertical auto layout, the smart default gives text `fill` width. This is correct for prose but wrong for labels/values — override with `s(hug,hug)` when text should not wrap.

> **See also:** [building/AUTO_LAYOUT_PATTERNS.md](../building/AUTO_LAYOUT_PATTERNS.md) for worked examples of text wrapping, pricing grids, and spaceBetween rows.

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

**Flex factor** — set via `fill:N` in the DSL (e.g., `s(fill:3,hug)`). Controls proportional distribution:

```
Same frame, but first fill child has flex 3, second has flex 1:
Total flex = 3 + 1 = 4
First Fill child = 184 × 3/4 = 138px
Second Fill child = 184 × 1/4 = 46px
```

Plain `fill` = flex 1 (backward compatible). The flex field appears in the right toolbar when a fill child is selected in an auto layout frame.

If fixed/hug children consume all available space, fill children get 0 width (they don't go negative, but they may become invisible).

#### Fill Inside Hug Frames

Fill behavior changes depending on parent type, axis, and whether the parent uses Hug sizing:

**Auto layout frames:**

| Scenario | Behavior |
|----------|----------|
| Fill on **main axis** + frame Hug | Fill **collapses to content size** (acts like Hug) |
| Fill on **cross axis** + frame Hug | Fill **works normally** (stretches to widest sibling) |
| Fill + frame Fixed | Fill works normally |

**Why?** The main axis size of a Hug frame equals the sum of its children. If a child says "fill remaining space" and the frame says "be as small as my children," that's a circular dependency. So fill collapses to content size on the main axis.

The cross axis doesn't have this problem because the frame's cross-axis size equals the **max** of its children, not the sum. Cross-axis fill children are **excluded** from the hug calculation entirely — only non-fill siblings (fixed/hug) determine the cross-axis hug size. Fill children then stretch to match.

**Example:** Vertical auto layout frame with Hug width and Hug height:
- Child with Fill width (cross axis): excluded from hug width calculation, then stretches to match widest sibling
- Child with Fill height (main axis): collapses to its content height (acts like Hug)

**Common pattern — accent bar:** A thin rectangle with `w:fixed h:fill` inside a horizontal auto-layout frame. The rect's explicit height doesn't affect the parent's hug height; siblings determine it, and the accent bar stretches to match.

**Plain frames and groups (non-auto-layout):**

Fill collapses to content size on **both** axes — there is no main/cross distinction since there's no layout direction. A fill-width text inside a hug-width plain frame will not wrap; it renders at its natural single-line width. This matches Figma behavior.

### Frame Axis Sizing

| Mode | Description |
|------|-------------|
| **Hug** | Frame fits children plus padding |
| **Fill** | Frame expands to fill available space in parent |
| **Fixed** | Frame keeps explicit size |

### Drag Reorder

Inside auto layout, dragging a child reorders it:
1. Select and start dragging
2. Insertion indicator shows placement
3. Release to drop
4. Siblings reflow

### What Happens on Operations

| Operation | Effect |
|-----------|--------|
| Resize a child | Converts to fixed, re-layouts |
| Rotate a child | Converts to fixed, re-layouts |
| Delete a child | Siblings reflow |
| Add a child | Inserted at end, re-layouts |
| Drag within frame | Reorders via drag |
| Drag to different frame | Reparents, both re-layout |

### Converting Between Types

In right toolbar **Parent** section, change the Parent Type dropdown:
- **Frame → Group**: Forces w:hug h:hug sizing, clears auto layout data
- **Frame → Auto Layout**: Infers layout direction, spacing, and alignment from current child positions
- **Group → Frame**: Unlocks sizing (keeps current values but allows changes)
- **Group → Auto Layout**: Infers layout, unlocks sizing
- **Auto Layout → Frame**: Clears auto layout data, children keep current positions
- **Auto Layout → Group**: Clears auto layout data, forces w:hug h:hug

**Auto-conversion:** Changing a group's sizing from hug on either axis automatically converts it to Frame.

## Parent Properties (All Types)

| Property | Description |
|----------|-------------|
| Clip content | Clip children to parent bounds. Default: **off** for all types. Use `clip` / `no-clip` to override |
| Corner radius | Rounded corners (per-corner or uniform) |
| Fill | Background color, gradient, or image |
| Stroke | Border/outline |
| Sizing | Frame and Auto Layout: hug, fill, or fixed on each axis. Group: always w:hug h:hug |

## Nesting

Parents can nest inside other parents:
- **Enter** to drill into a parent
- **Shift+Enter** to select the parent (go back up)
- Layers explorer (Cmd+Shift+R) shows hierarchy

## Reparenting

Drag elements over a parent to auto-reparent:
- **Frame** and **Auto Layout** parents are reparent targets — elements dropped on them are reparented
- **Groups** are NOT reparent targets — dragging over a group will not reparent into it
- Children inside a group **cannot be dragged out** — they stay in the group during drag
- Coordinates transform to the target's local space
- Hold **Space** to prevent reparenting during drag

## Creating Parents

### From Selection

- **Cmd+G** — Group (always w:hug h:hug, not a reparent target)
- **Shift+A** — Auto layout parent

### Using Frame Tool (F)

Draw on canvas to create a plain Frame parent. Elements fully inside are captured as children.

## Layout Guides (Layout Grids)

Figma-style visual guides for alignment and spacing within parents.

### Guide Types

| Type | Description |
|------|-------------|
| **Grid** | Uniform pixel grid (like graph paper) |
| **Columns** | Vertical sections with gutters |
| **Rows** | Horizontal sections with gutters |

### Adding Layout Guides

1. Select a frame
2. In right toolbar **Layout Guides** section, click **+** to add a guide (default type: Grid)
3. Change the type using the dropdown in the guide row header (Grid, Columns, or Rows)

**Shortcuts:** **Ctrl+Shift+G** adds a layout grid. **Shift+G** toggles all guides' visibility.

### Column/Row Alignment Modes

| Mode | Description |
|------|-------------|
| **Stretch** | Fill frame with equal sections + margin |
| **Left/Top** | Fixed-size sections from left/top edge |
| **Right/Bottom** | Fixed-size sections from right/bottom edge |
| **Center** | Fixed-size sections centered in frame |

### Properties

- **Count** — Number of columns/rows
- **Gutter** — Space between sections
- **Margin** — Edge margin (stretch mode)
- **Section Size** — Fixed section width/height (non-stretch modes)
- **Offset** — Distance from edge (left/right/top/bottom modes)
- **Color** — Guide color (click color swatch to edit)
- **Visibility** — Toggle eye icon to show/hide

### Snapping to Guides

Elements snap to layout guide edges when moving or resizing:
- Column edges (left and right of each column)
- Row edges (top and bottom of each row)
- Grid intersections

**Note:** Snapping works even with rotated frames.

### Multiple Guides

Frames can have multiple layout guides. Each guide has its own visibility toggle.

## Troubleshooting Auto Layout

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Element not stretching to fill width | Sizing mode is Fixed or Hug | Change to Fill in right toolbar |
| Element stopped stretching after resize | Resize converts to Fixed | Change back to Fill |
| Fill child is invisible (0 width) | Fixed/hug siblings consume all space | Make parent larger or reduce sibling sizes |
| Fill not working on main axis | Parent uses Hug sizing (circular dependency) | Use Fixed size on parent, or accept that fill acts as hug |
| Children overlapping | Parent is a Group, not Auto Layout | Convert to Auto Layout (Shift+A or dropdown) |
| Children overflow horizontally | Too many hug children for container width | Auto layout does NOT wrap — reduce children, use smaller sizing, or increase container width |
| Unexpected gaps between children | Check spacing setting | Adjust itemSpacing in right toolbar |
| spaceBetween not pushing items to edges | Only one child | spaceBetween centers a single child; add more children or use different alignment |
| Text wrapping when it shouldn't | Text has `fill` width | Change to `hug` — fill width applies a constraint that causes wrapping |
| Text not wrapping when it should | Text has `hug` width in horizontal layout | Set `w:fill h:hug` explicitly |
| Siblings not equal height in a row | Cross-axis (height) is `hug` — each sizes to own content | Use `fill` height — cross-axis fill stretches to match tallest sibling |
| Nested parent not stretching | Auto layout parents default to Hug | Explicitly set Fill sizing on the nested parent |
| Layout looks wrong after undo | Normal — undo restores previous state | Re-apply changes if needed |

> **See also:** [knowledge/EDITING.md](./EDITING.md) for selection and navigation within parents
> **See also:** [knowledge/LAYOUT_GUIDES.md](./LAYOUT_GUIDES.md) for detailed layout guide documentation
