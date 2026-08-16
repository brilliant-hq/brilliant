---
name: "knowledge-canvas"
description: "Canvas navigation, zoom, pan, snap guides, background modes, and display options in Brilliant."
---

# Canvas

## Zoom

### Zoom Shortcuts

| Action | Shortcut |
|--------|----------|
| Zoom in (2x, viewport-centered) | Cmd+= |
| Zoom out (0.5x, viewport-centered) | Cmd+- |
| Zoom 100%, 200%, ..., 900% | 1, 2, 3, 4, 5, 6, 7, 8, 9 (Move or Hand tool only, no text input, no command palette). Pressing the same digit twice resets to 100%. |
| Toggle zoom | 0 (Move or Hand tool only) toggles between 100% and the previously-zoomed state. With no previous state it jumps to 200%. |
| Cmd+scroll, Cmd+trackpad drag | Zoom around cursor |
| Trackpad pinch | Zoom around focal point |

Note: there is no built-in "Zoom to 100%" Cmd+0 binding. `0` alone (without Cmd) is `toggle_zoom`; Cmd+0 focuses chat session 10. To jump to 100% explicitly, press `1`.

### Zoom Behavior

- **Multiplicative steps:** Cmd+= and Cmd+- zoom by 2x and 0.5x (100% to 200% to 400% to 800%)
- **Max zoom:** 25600% (256x)
- **Min zoom:** 2% (0.02x), unless "Disable Zoom Out" (Cmd+Ctrl+D) is active, which clamps to 100% and constrains pan to canvas bounds
- **Keyboard zoom (Cmd+= and Cmd+-):** centers on the viewport
- **Cmd+scroll, Cmd+trackpad drag, trackpad pinch:** zoom around the cursor
- **Smooth animation:** zoom transitions ease smoothly, so retargeting mid-flight stays smooth. Toggle via "Toggle Zoom Animation" command (no default shortcut).
- **Per-canvas zoom state:** each canvas remembers its own zoom and pan; switching canvases restores them. The first time a canvas with content is opened, the viewport zoom-fits to its bounds automatically.

### Zoom to Content

| Action | Shortcut | Description |
|--------|----------|-------------|
| Fit all content | Cmd+Ctrl+A | Zoom and pan to show all elements on the canvas |
| Zoom to selection | Cmd+Ctrl+F | Zoom and pan to fit the current selection. Falls back to fit-all when nothing is selected. |
| Center on selection | Cmd+Ctrl+C (macOS; unbound on Windows) | Pan to center the selection without changing zoom |
| Reset zoom | (no default; `reset_zoom`) | Snap back to 100% and zero pan; user-bindable |
| Toggle zoom | 0 (Move or Hand tool only) | Toggle between 100% and the previously-zoomed state. With no previous state it jumps to 200%. |

**Windows remaps:** the Cmd+Ctrl+* chords above collapse onto essential Ctrl commands on Windows, so three are re-homed to Alt: Fit all content = Alt+A, Zoom to selection = Alt+Z, Disable zoom out = Alt+D. Center on selection is unbound on Windows (command palette only).

### Scroll and Trackpad

- Scroll wheel: pans the canvas (vertical scroll = vertical pan)
- **Shift+scroll wheel:** pans horizontally (Figma/Penpot convention). Tilt-wheel x-deltas are folded in.
- Cmd+scroll wheel: zooms around cursor position
- Trackpad two-finger drag: pans the canvas
- Trackpad pinch: zooms around focal point
- Cmd+trackpad drag: zooms around cursor position
- **Middle-mouse drag:** temporarily swaps to the Hand tool while held (same as holding Space). Cursor flips to grabbing; bottom toolbar reflects the mode. Release to return to the previous tool.

### Zoom Percentage

Displayed in the right toolbar header. The percentage is a draggable value (drag horizontally to adjust interactively). It is per-canvas and updates on canvas switch.

### Disable Zoom Out

**Cmd+Ctrl+D** (Alt+D on Windows) toggles a clamp that prevents zooming below 100% and constrains pan to canvas bounds. Useful for overlay mode and presentations.

## Pan

### Infinite Canvas Panning

Pan works at any zoom level, including 100% with zero offset. The only constraint is when "Disable Zoom Out" is active: pan is clamped to canvas bounds.

### Hand Tool (H)

H activates the Hand tool; click and drag pans. Press V to return to Move.

### Temporary Pan (Space)

Holding Space in any tool temporarily switches to Hand-tool pan behavior. Release returns to the previous tool.

### Two-Finger Trackpad

Two-finger drag on trackpad pans. Cmd+two-finger drag zooms around the cursor.

### Scroll-Wheel Pan

Mouse scroll wheel pans (vertical scroll = vertical pan). Shift+scroll pans horizontally. Cmd+scroll zooms around the cursor instead. Trackpad pan and hand-tool drag include momentum: a quick flick keeps gliding and decelerates after release, and stops on the next click or scroll. Mouse scroll wheel has no added momentum (the OS handles its own acceleration).

### Middle-Mouse Drag

Press and drag the middle mouse button to pan. This temporarily swaps to the Hand tool (same code path as holding Space), so the cursor shows "grabbing" and the bottom toolbar reflects the mode. Release to return to the previous tool.

## Coordinate Spaces

The canvas has four nested coordinate systems. Understanding which space a coordinate lives in matters when reasoning about positions.

| Space | What it is | Where it shows up |
|-------|-----------|-------------------|
| **Screen** | Raw pointer pixel coordinates from the OS | Pointer events, before any transform |
| **World** | Absolute canvas coordinates, after inverse zoom transform | Hit testing input, rendering output, marquee rects |
| **Parent-local** | Position relative to the element's parent frame | An element's stored X/Y position and bounds |
| **Element-local** | Geometry inside an element's own frame | Vector path nodes, internal text layout |

An element's stored X/Y/width/height are **parent-local**: relative to the frame that contains it. Top-level elements live under a synthetic root parent, so for top-level elements parent-local equals world. A child inside a rotated frame sits in a rotated parent-local space, so its world bounds are computed by rotating about the frame center.

The position shown in the right toolbar's X/Y fields is parent-local (relative to the selected element's parent frame).

## Selection and Hit Testing

How clicks resolve to elements, and how the result is shown.

### Hit test rules per element type

| Element kind | Hit test |
|--------------|----------|
| Filled shape (rectangle, circle, vector region) | Inside the rendered fill path (respects corner radii, arcs, rings) |
| Outlined shape with no fill | Within 4 screen pixels of the stroke |
| Vector path (line, curve) | Within 4 screen pixels of the path; closed paths additionally hit on filled regions |
| Text | Inside the text bounding box |
| Top-level frame (root parent) | The frame label above the top-left corner selects the frame; clicking the frame body passes through to children. Frames are always hit-testable on their fill area even without an explicit fill. |
| Nested frame (inside another frame) | Anywhere on the frame's fill or stroke |
| Boolean / mask parent | Uses the resulting visible shape, not the rectangular bounding box |
| Circle arc / ring | Hit test follows the arc fill path or ring band, not the full ellipse |

Tolerance is 4 screen pixels at any zoom level. Stacking order is topmost-first: the last-drawn element wins.

### Selection rectangles

Selection is per-parent. With 2 elements selected in Frame A and 3 in Frame B, two selection rectangles render, one per parent. Each has its own resize and rotate handles, and align/distribute/resize commands operate within each parent's coordinate space independently.

The selection rectangle (and the hover highlight) hugs the shape geometry itself, not the stroke: a thick outside stroke or a per-side border never inflates the rectangle, like Figma. Hit testing still includes the stroke band, so you can click a stroke to select its element even though the rectangle sits on the shape edge.

Selection handles auto-hide when they would dwarf a small selection; multi-parent selections always show handles, and two-point paths (lines) always show handles.

### Marquee (drag-to-select)

Drag on empty canvas to draw a selection rectangle. Rules:
- Nested elements are selected as soon as the marquee touches them (intersection test)
- Top-level frames **with children** are selected only when fully contained by the marquee; otherwise the marquee selects the frame's children that intersect it (a childless top-level frame is selected on intersection, like any element)
- Holding Cmd during marquee ignores fills: elements are matched by their shape even where they have no fill, so a hollow or unfilled shape the rectangle crosses still gets selected

### Selection navigation (keyboard)

| Key | Action |
|-----|--------|
| Tab | Select previous sibling (within the current parent's children, wrapping around). With nothing selected, selects the first top-level element. |
| Shift+Tab | Select next sibling (within the current parent's children, wrapping around). With nothing selected, selects the last top-level element. |
| Shift+Enter | Select parent of the current selection (Enter dives into a parent) |
| Cmd+A | Select all top-level elements |
| Escape | Clear selection (when no other Escape target consumes the event first) |

### Nudge (arrow keys)

| Key | Action |
|-----|--------|
| Arrow | Move selection 1 px |
| Shift+Arrow | Move selection 10 px |

Both nudge variants register undo and respect per-parent constraints.

### Cursor states

| Cursor | When |
|--------|------|
| Arrow | Default (Move tool) |
| Crosshair | Drawing tools (Rectangle, Circle, Line, Arrow, Pen, Pencil, Frame, Text, Snip) |
| Open hand | Hand tool (H) idle |
| Closed hand | Hand tool dragging, or window-drag in the top toolbar breadcrumb |
| Resize arrows | Hovering a selection handle (axis-aware) |
| Rotate | Hovering a corner just outside the selection bounds |
| Eyedropper | Color pick mode (Ctrl+Shift+C; Alt+Shift+C on Windows) |
| I-beam | Hovering a text element while in Move tool |

### Highlights rendered during work

- Hover highlight: thin outline on the element under the cursor
- Selection rectangles: one per parent with selected children, plus resize/rotate handles
- Snap guides: solid alignment lines and dashed spacing/distribution/size labels
- Measurement overlays: Alt+hover shows pixel distances and frame padding
- Frame labels: above top-level frames; click selects the frame. At low zoom labels declutter: frames too small on screen drop their label, and colliding labels keep only the widest frame's name (hovered or selected frames always keep theirs)

## Blend Modes

Brilliant supports blend modes at four scopes: element, fill, stroke, and effect. All default to Normal.

| Scope | Where to set it | What it composites |
|-------|-----------------|--------------------|
| Element | Blend-mode dropdown in the right toolbar's element/canvas section (next to opacity) | Entire element (all fills + strokes + effects) against the canvas underneath |
| Fill | Blend-mode control on a fill row (right toolbar Fill section) | This single fill against the canvas underneath |
| Stroke | Blend-mode control on a stroke row (right toolbar Stroke section) | This single stroke against the canvas underneath |
| Effect | Blend-mode dropdown on a drop shadow / outer glow / element blur (right toolbar Effects section). Inner shadow and inner glow carry their own blend mode (inner glow defaults to Screen). | Per-effect output |

Element-level blend mode wraps the whole element in a single composite layer so its fills, strokes and effects composite normally with each other first, then the unit blends against the canvas. Fill, stroke, and effect modes are independent and apply only to their own render pass.

Supported modes (16): Normal, Darken, Multiply, Color Burn, Lighten, Screen, Color Dodge, Overlay, Soft Light, Hard Light, Difference, Exclusion, Hue, Saturation, Color, Luminosity. The same set exports cleanly to SVG (`mix-blend-mode`) and PDF.

## Rendering Performance

Brilliant renders all canvas content through a native GPU engine that scales to very large canvases (tens of thousands of elements) automatically; no user action or mode switching is needed.

### Studio vs Overlay screen capture

When the canvas is zoomed/panned in overlay mode, the OS desktop image is captured and painted as the background behind the canvas content. In studio mode this is skipped (capture would record the app's own window); the void background fills the area instead.

## Snap Guides

### How Snapping Works

While moving, resizing, or creating elements, snap guides render as:
- Solid lines: alignment snaps (edge or center aligned to a reference)
- Dashed lines with labels: spacing, equidistant distribution, and size-match snaps

Guide color adapts to theme (light gray on dark, dark gray on light). The snap engine is per-axis: X and Y snap independently and the closest valid target wins per axis. Once a winning position is determined, all guide types active at that exact position render together.

### Snap Types

| Type | Behavior |
|------|----------|
| Alignment | Snaps edges and centers to siblings' edges and centers |
| Spacing | Maintains an equal gap relative to a neighbor |
| Equidistant | Equal gaps between 3+ siblings in a row or column |
| Size matching | When resizing, snaps to match width or height of nearby siblings |
| Layout grid | Snaps to columns, rows, or grid lines on the parent frame |
| Ruler guides | Snaps to dragged-out ruler guides |
| Angle | Shift while drawing lines/arrows snaps to 45 degree increments; pen handle drag snaps to 15 degree |

### Per-Parent Snapping

Snapping operates within the primary parent's coordinate space. Elements snap to siblings, never across frame boundaries. Frames themselves are valid snap targets when they are siblings.

### Toggling Snaps

| Action | How |
|--------|-----|
| Toggle snap guides | Command palette: "Toggle Snap Guides" (no default shortcut) |
| Toggle dimension labels | Command palette: "Toggle Dimension Labels" (no default shortcut) |
| Toggle snap to pixel grid | Cmd+Shift+' |

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
| Elements touch (gap < 1px) | No measurement shown on that axis |
| Elements have a gap on one axis, overlap on the other | Gap measurement on the non-overlapping axis, plus edge offset measurements on the overlapping axis |
| Elements fully overlap on both axes | Edge offset measurements on both axes |
| Start dragging | Measurements disappear |
| Release Alt | Measurements disappear |

## Background

The canvas paints three background layers in order: void, background color, blackboard. Each layer is shown only when the layers above it would not fully cover it.

### Layer stack

1. **Void**: visible only when the canvas is "outside" the editable area (studio mode, preview mode, or overlay mode while zoomed/panned). The void renders a theme-aware base (light grey on light theme, very dark grey on dark theme) plus a faint checkerboard pattern to signal "no canvas content here". The void is skipped when an opaque background or blackboard color would fully occlude it.
2. **Background color**: the canvas's configured background, drawn over the void. Shown when the canvas background is enabled and no blackboard color is set.
3. **Blackboard color**: highest-priority opaque fill. Drawn over everything else when a blackboard color is set.

### Background Modes

| Mode | Description | Shortcut |
|------|-------------|----------|
| Solid (studio default) | Opaque background in studio mode | (set by canvas) |
| Transparent | Default in overlay mode | (set by canvas) |
| Blackboard | Dark opaque surface | Cmd+Shift+B |
| Whiteboard | Light opaque surface | Cmd+Shift+W |
| Toggle | Toggle between transparent and last opaque | Cmd+Shift+D |

### Window Modes

| Mode | Description |
|------|-------------|
| Studio (default) | Regular desktop window: title bar, shadow, resizable, visible in Dock. Launches on startup. |
| Overlay | Fullscreen transparent layer above other apps: borderless, always-on-top, hidden from Dock. |

Overlay mode is **opt-in** and **macOS-focused** (the `toggle_overlay_mode` and `toggle_pass_through` shortcuts are disabled on Windows; reach them via menus/command palette). Until the user enables it (Settings: "Overlay Mode"), the global hotkey is not registered. Once enabled, **Ctrl+F** toggles between studio and overlay mode. The hotkey fires even when Brilliant is unfocused, minimized, or invisible. Studio window state (position, size, fullscreen, maximized) is saved on entering overlay and restored on exit.

| Action | Shortcut | Notes |
|--------|----------|-------|
| Toggle overlay mode | Ctrl+F | Global hotkey; macOS-focused, disabled on Windows |
| Toggle passthrough | Ctrl+A | Overlay only: pointer events pass through to apps below |
| Toggle presentation mode | Alt+P | Hides UI panels for a clean view |
| Toggle agent cursors | (none) | Named cursors for the user and AI agents (command palette: "Toggle Agent Cursors"; Settings → General) |
| Toggle UI (all chrome) | Cmd+\ | Hide/show ALL app chrome: the left, right, and bottom toolbars AND the top strip (home / tabs / breadcrumb, plus the phantom title bar). Summoned surfaces stay reachable (command palette, tooltips, notifications), and pressing Cmd+\ again brings everything back, so nothing is unreachable. |
| Toggle inspector sections | Cmd+/ | Collapse/expand all collapsible toolbar sections (the right-toolbar inspector groups) |
| Toggle left toolbar | Cmd+Shift+Left | |
| Toggle right toolbar | Cmd+Shift+Right | |
| Toggle bottom toolbar | Cmd+Shift+Down | |
| Toggle desktop icons | Ctrl+I | Hides/shows the macOS desktop icons (a real Finder toggle). macOS only: the command hard-returns off macOS, and the Ctrl+I chord is disabled on Windows (freed for Italic) |
| Clear all elements | C | Removes all elements from the active canvas (undoable) |

Passthrough mode is overlay-only. Cmd+\ hides ALL app chrome (the left / right / bottom toolbars plus the top strip) in both window modes; press it again to bring everything back. In overlay the top strip's tabs are already suppressed, so an overlay drawing surface stays clear. The hidden state is not remembered across launches: a reboot always restores the chrome.

**Agent cursors** (on by default; toggle via the command palette "Toggle Agent Cursors" or Settings → General → Agent Cursors; persisted across restarts) adds multiplayer-style named cursors. Each AI agent working on the canvas gets a cursor (the same arrow as the user's own cursor, tinted in the agent's session color, matching its shimmer) that glides between the elements it touches, with a name tag. The cursor is present for the WHOLE turn, not just during edits: it appears (slightly dimmed) the moment the agent starts thinking — before its first edit — sits quietly near its last work (or mid-viewport on a first turn), and lifts to full strength when the agent edits or narrates. External agents driving Brilliant over MCP (e.g. Claude Code terminals) stay visibly present across their tool calls the same way. If you switch to another canvas, the cursor stays with its work and reappears there when you switch back. Agents name themselves after the task at hand (e.g. "Meditation App", streamed via the same mechanism as chat titles), falling back to a stable per-session name like "Nova" or "Pixel" until the name arrives. With "Show Agent Thinking" enabled (sub-setting, on by default), the name tag extends into a small card where the agent's live commentary types out word-by-word at reading pace, subtitle-style (up to four scrolling lines); element references appear as clickable chips that select and zoom to the element. The cursor waits for its caption to finish before moving on, and if a response ends naturally the caption plays out before the cursor fades; stopping the chat removes both immediately. **Clicking an agent's cursor, name, or card opens its chat session** (the pointer shows a click cursor over it, and clicks never affect canvas content beneath). Optionally (sub-setting "Show Your Cursor Name", off by default) the user's own pointer carries a blue name tag baked into the native arrow cursor (zero lag); the name defaults to the local part of the activation email and can be changed in Settings → General → Agent Cursors → Displayed Name. All of these settings persist across restarts.

If the window cannot be seen, press Ctrl+F: as a global hotkey it forces a return to studio mode and restores the saved window geometry.

## Rulers

Shift+U toggles rulers along the canvas edges.

### Ruler Guides

Drag from the ruler bar onto the canvas to create persistent horizontal or vertical guide lines. Ruler guides:

- Are snap targets during move, resize, and create
- Are selectable: click a guide to select it
- Are deletable: select and press Delete, or use "Clear All Ruler Guides" via the command palette
- Are per-canvas: each canvas has its own set

## Dimension Labels

When enabled, dimension labels show width/height during creation, resize, and during snap interactions. Toggled via "Toggle Dimension Labels" in the command palette.

## Pixel Grid

A 1-pixel grid overlay for pixel-perfect work at high zoom levels.

### Visibility

- **Appears at 400%+ zoom** (4x and above)
- **Fades in smoothly** between 400% and 600% zoom
- **Adaptive contrast:** each line reads the content beneath it and shifts its
  luminance away from the local backdrop (darker on light content, lighter on
  dark), so the grid stays visible on any background, including photos and
  gradients, and never dominates. It is not a flat theme color.
- Shown on all platforms (macOS, Windows, Linux).

### Toggle

Cmd+' toggles the pixel grid overlay.

The pixel grid state persists across app restarts.

## Layout Grids

Layout grids are per-frame **snap targets** that help you align content within frames. They are inspector configuration and snap guides only: they do not render on the canvas and never appear in exports. Full detail: [layout-guides.md](./layout-guides.md).

### Toggle Visibility

| Action | Shortcut |
|--------|----------|
| Toggle layout grids | Shift+G |
| Add layout grid | Command palette |

### Grid Types

| Type | Description |
|------|-------------|
| **Grid** | Uniform square grid with a configurable cell size |
| **Columns** | Vertical columns with count, gutter, and margin controls |
| **Rows** | Horizontal rows with count, gutter, and margin controls |

### Adding and Configuring

1. Select a frame
2. Right toolbar: find the "Layout Guides" section
3. Click the + button to add a grid (default type: Grid)
4. Change the type via the dropdown in the grid row header (Grid, Columns, Rows)
5. Click the settings icon on a row to expand configuration options

Shift+G enables/disables all layout-grid snapping. The command palette exposes one command, **"Add Layout Grid"** (it adds a Grid-type guide; change the type on the row afterwards). There is no separate "Add Columns", "Add Rows", or "Add Grid" command.

### Grid Options

**Uniform Grid:**
- Size: cell size in pixels (e.g. 8px for an 8-point grid)

Columns / Rows:
- Alignment: Stretch (fill frame), Left/Right/Top/Bottom (anchored), or Center
- Count: number of columns or rows
- Gutter: space between columns or rows
- Margin: space from frame edge (Stretch mode)
- Width/Height: section size (fixed alignment modes)
- Offset: distance from anchor edge (fixed alignment modes)

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

Shift+Cmd+' toggles snap-to-pixel-grid on/off.

The snap setting is independent of the pixel grid overlay (visual only). Possible combinations:
- Overlay on, snap off: see the grid, allow sub-pixel positioning
- Overlay off, snap on: snap to pixels without rendering the grid
- Both on: full pixel-perfect workflow

The snap setting persists across app restarts.

### When pixel snap is useful

- UI design: keeps edges crisp on standard and retina displays
- Icon design: prevents sub-pixel blur
- Export: avoids anti-aliasing artifacts at element boundaries

### When to disable pixel snap

- Precise alignment requiring fractional positioning
- Artistic work where pixel-perfect is not a goal
