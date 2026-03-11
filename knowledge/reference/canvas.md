---
name: "knowledge-canvas"
description: "Canvas navigation, zoom, pan, snap guides, background modes, and display options in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Canvas

## Zoom

### Zoom Shortcuts

| Action | Shortcut |
|--------|----------|
| Zoom in (2x) | Cmd+= |
| Zoom out (0.5x) | Cmd+- |
| Zoom 100%–900% | 1 through 9 (Move/Hand tool only; press again to reset to 100%) |
| Reset zoom | 0 (Move/Hand tool only) |
| Cmd+scroll/trackpad | Zoom around cursor |

### Zoom Behavior (Figma-Compatible)

- **Multiplicative steps:** Zoom in/out by 2x (100% → 200% → 400% → 800%)
- **Max zoom:** 25600% (256x) — useful for pixel-perfect work
- **Min zoom:** 2% (0.02x) — unless "Disable Zoom Out" is active, which clamps to 100%
- **Keyboard zoom:** Centers on viewport
- **Scroll/trackpad zoom:** Centers on cursor position

### Zoom to Content

| Action | Shortcut | Description |
|--------|----------|-------------|
| Fit all content | Cmd+Ctrl+A | Zoom and pan to show all elements |
| Zoom to selection | Cmd+Ctrl+F | Zoom and pan to fit selected elements in view |
| Center on selection | Cmd+Ctrl+C | Pan to center without changing zoom |
| Reset zoom | 0 (Move/Hand tool only) | Reset to 1.0x and center |

### Scroll and Trackpad

- **Scroll wheel** — Pans the canvas (vertical scroll = vertical pan)
- **Cmd+scroll wheel** — Zooms around cursor position
- **Trackpad two-finger drag** — Pans the canvas
- **Trackpad pinch** — Zooms around focal point
- **Cmd+trackpad drag** — Zooms around cursor position

### Zoom Percentage

Displayed in the right toolbar header. Drag the value to adjust interactively.

### Disable Zoom Out

**Cmd+Ctrl+D** — Prevents zooming below 100%. Useful for overlay mode.

## Pan

### Infinite Canvas Panning

Pan works at **any zoom level**, including 100% with zero offset. This enables infinite canvas exploration like Figma.

### Hand Tool (H)

Press **H**, click and drag to pan, press **V** to return to Move.

### Temporary Pan (Space)

Hold **Space** while in any tool to temporarily pan. Release to return to previous tool.

### Two-Finger Trackpad

Two-finger drag on trackpad pans the canvas. Hold **Cmd** while dragging to zoom instead.

## Snap Guides

Snap guides help position elements precisely with visual alignment cues.

### How Snapping Works

When moving, resizing, or creating elements, Brilliant shows:
- **Solid lines** — Alignment snaps (edges/centers aligned)
- **Dashed lines with labels** — Spacing, distribution, and sizing snaps

Guide color adapts to theme: light gray on dark backgrounds, dark gray on light backgrounds.

### Snap Types

**Alignment Snap** — Snaps edges and centers to other elements' edges and centers.

**Spacing Snap** — Snaps to maintain equal spacing relative to neighbors.

**Equidistant Snap** — Equal distances between 3+ elements in a row/column.

**Size Matching Snap** — When resizing, snaps to match dimensions of nearby elements.

**Angle Snap** — Hold **Shift** when drawing lines to snap to 45-degree increments.

### Toggling Snaps

| Action | How |
|--------|-----|
| Toggle snap guides | Toggle snap guides command (command palette) |
| Toggle dimension labels | Toggle dimension labels command (command palette) |

### Per-Parent Snapping

Elements snap to siblings within the same parent, not elements in other frames.

## Measurement Overlays

Hold **Alt** and hover over an element to see distance measurements between your selection and the hovered target. Works like Figma's measurement overlay.

### How It Works

1. **Select** one or more elements
2. **Hold Alt/Option** and hover over another element
3. Distance guides appear showing pixel values

### Three Scenarios

| Scenario | What You See |
|----------|--------------|
| **Element to element** | Horizontal and/or vertical gap distances between the two AABBs |
| **Child to parent frame** | Padding distances from selection to all 4 frame edges |
| **Frame to child** | Padding distances from hovered child to all 4 selected frame edges |

### Visual Style

Measurement guides appear as **dashed lines with pixel labels**. When elements are positioned diagonally (no perpendicular overlap), thin extension lines connect the measurement to each element's nearest edge.

### Behavior

| Condition | Result |
|-----------|--------|
| Hover a non-selected element with Alt held | Show distance measurements |
| Hover a parent frame with children selected | Show padding to frame edges |
| Select a frame, hover a child inside it | Show padding from child to frame edges |
| Elements touch (gap = 0) | No measurement shown |
| Elements overlap on one axis | Only the non-overlapping axis shows measurement |
| Start dragging | Measurements disappear |
| Release Alt | Measurements disappear |

## Background

### Background Modes

| Mode | Description | Shortcut |
|------|-------------|----------|
| Solid (studio default) | Opaque background in studio mode | — |
| Transparent | Default in overlay mode | — |
| Blackboard | Dark opaque surface | Cmd+Shift+B |
| Whiteboard | Light opaque surface | Cmd+Shift+W |
| Toggle | Switch between transparent and last opaque | Cmd+Shift+D |

### Window Modes

Brilliant has two window modes:

| Mode | Description |
|------|-------------|
| **Studio** (default) | Regular desktop window with title bar, shadow, resizable. Visible in Dock. Launches on startup. |
| **Overlay** | Fullscreen transparent layer above other apps. Borderless, always-on-top, hidden from Dock. |

**Switching modes:** Press `Ctrl+F` (global hotkey — works even when Brilliant is unfocused) to toggle between studio and overlay. Studio window state (position, size, fullscreen) is saved before entering overlay and restored on exit.

| Action | Shortcut | Description |
|--------|----------|-------------|
| Toggle overlay mode | Ctrl+F | Global hotkey — switch between studio and overlay mode |
| Passthrough | Ctrl+A | Overlay only — window becomes click-through; elements visible as reference |
| Presentation | Alt+P | Clean view, UI panels hidden |

**Overlay-only experience:** In overlay mode, hide the UI with `Cmd+\` to get a clean, transparent drawing surface over your desktop — ideal for annotation, live demos, or tracing over other apps. To replicate the old overlay-only workflow (no studio window visible), minimize the Studio window and use `Ctrl+F` exclusively — the minimized window stays out of your way.

**Stuck in overlay mode?** If you cannot see the Brilliant window, press `Ctrl+F` — this is a **global hotkey** that works even when the app is in the background or invisible. It will switch back to Studio mode and restore the window to its previous position and size.

**Note:** Passthrough mode only works in overlay mode.

**Coming from legacy Brilliant?** The global hotkey changed from `Ctrl+Shift+W` to `Ctrl+F`. See the migration guide in [SKILL.md](./SKILL.md#coming-from-legacy-brilliant-bananoate).

### Other Display Options

| Action | Shortcut |
|--------|----------|
| Show/hide UI | Cmd+\\ |
| Toggle desktop icons | Ctrl+I |
| Clear all elements | C |

## Rulers

Toggle rulers with **Shift+U** to display rulers along the canvas edges.

### Ruler Guides

Drag from the ruler bar to create persistent horizontal or vertical guide lines on the canvas. Ruler guides:

- **Snap targets** — Elements snap to ruler guides during move and resize
- **Selectable** — Click a guide to select it
- **Deletable** — Select a guide and press Delete, or use "Clear All Ruler Guides" from the command palette
- **Per-canvas** — Each canvas has its own set of ruler guides

## Dimension Labels

When enabled, dimension labels show width/height during creation and resize operations.

## Pixel Grid

A 1-pixel grid overlay for pixel-perfect work at high zoom levels.

### Visibility

- **Appears at 400%+ zoom** (4x and above)
- **Fades in smoothly** between 400% and 500% zoom
- **Theme-aware** — light gray on dark theme, dark gray on light theme

### Toggle

**Cmd + '** (apostrophe) — Show/hide pixel grid

The pixel grid state persists across app restarts.

## Layout Grids

Layout grids are visual guides that help you align content within frames. They appear as overlays on the canvas but are not part of the final design.

### Toggle Visibility

| Action | Shortcut |
|--------|----------|
| Toggle layout grids | Shift+G |
| Add layout grid | Ctrl+Shift+G |

### Grid Types

| Type | Description |
|------|-------------|
| **Grid** | Uniform square grid with a configurable cell size |
| **Columns** | Vertical columns with count, gutter, and margin controls |
| **Rows** | Horizontal rows with count, gutter, and margin controls |

### How to Add and Configure

1. Select a frame
2. In the right toolbar, find the **Layout Guides** section
3. Click the **+** button to add a grid (default type: Grid)
4. Change the type using the dropdown in the grid row header (Grid, Columns, or Rows)
5. Click the settings icon on a grid row to expand configuration options

**Shortcuts:** Ctrl+Shift+G adds a layout grid, Shift+G toggles all grids visibility.

### Grid Options

**Uniform Grid:**
- **Size** — Cell size in pixels (e.g., 8px for an 8-point grid)

**Columns / Rows:**
- **Alignment** — Stretch (fill frame), Left/Right/Top/Bottom (anchored), or Center
- **Count** — Number of columns or rows
- **Gutter** — Space between columns or rows
- **Margin** — Space from frame edge (Stretch mode)
- **Width/Height** — Section size (fixed alignment modes)
- **Offset** — Distance from anchor edge (fixed alignment modes)

### Per-Grid Visibility

Each grid has an eye icon to show/hide it individually. This lets you keep multiple grids configured while only displaying the ones you need.

### Grid Color

Click the color swatch next to a grid to open the color picker and change the grid's display color.

---

## Snap to Pixel Grid

Automatically rounds element positions and sizes to whole pixel (integer) values. This prevents sub-pixel rendering artifacts and ensures crisp, pixel-perfect designs.

### How It Works

When enabled (default), moving, resizing, or creating elements automatically snaps to whole pixel values:
- **Move:** Element position rounded to nearest pixel
- **Resize:** Element size rounded to nearest pixel
- **Create:** Start and end points rounded to nearest pixel

### Priority

**Element snap takes priority.** If an element snaps to another element's edge (alignment snap), pixel grid snap is skipped on that axis. This ensures alignment guides work correctly while still rounding the other axis.

### Toggle

**Shift + Cmd + '** (apostrophe) — Toggle snap to pixel grid on/off

This is separate from the pixel grid overlay (which is just visual). You can have:
- Overlay ON + Snap OFF — See the grid but allow sub-pixel positioning
- Overlay OFF + Snap ON — Snap to pixels without seeing the grid
- Both ON — Full pixel-perfect workflow

The snap setting persists across app restarts.

### When Snap is Useful

- **UI design** — Ensures crisp edges on retina and standard displays
- **Icon design** — Prevents blurry edges from sub-pixel positioning
- **Export** — Avoids anti-aliasing artifacts at element boundaries

### When to Disable

- **Precise alignment** — When you need exact fractional positioning
- **Artistic work** — When pixel-perfect doesn't matter
