---
name: "knowledge-shortcuts"
description: "Complete keyboard shortcut reference for Brilliant covering tools, editing, styling, canvas, and canvas management."
---

# Keyboard Shortcuts

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Press **Shift+?** to view shortcuts inside the app.

## Start Here: Essential Shortcuts

If you're new to Brilliant, learn these first:

| Priority | Shortcut | Action |
|----------|----------|--------|
| **Must know** | V | Move tool (your home base) |
| **Must know** | Cmd+Z / Cmd+Shift+Z | Undo / Redo |
| **Must know** | Cmd+Shift+P | Command palette (find any command) |
| **Must know** | / | AI input (natural language commands) |
| **Must know** | Shift+? | Shortcuts reference (this panel) |
| **Core drawing** | R, O, T, F, L, P | Rectangle, Circle, Text, Frame, Line, Pen |
| **Core editing** | Cmd+D, Cmd+G, Cmd+Shift+G, Cmd+F, Backspace | Duplicate, Group, Ungroup, Frame Selection, Delete |
| **Navigation** | Enter / Escape | Enter frame / Exit to parent |
| **Navigation** | Tab / Shift+Tab | Previous / Next sibling |
| **Layout** | Shift+A | Add auto layout |
| **Zoom** | Cmd+Ctrl+C | Center on selection |

Once comfortable, add alignment (Alt+Shift+L/R/T/B), z-order (]/[), boolean ops (Alt+Shift+U/S/I/E), Flatten (Cmd+Enter), and quick colors (Ctrl+R/G/B/K/W).

## Limitations

- **No chord (multi-key) shortcuts** — Each shortcut is a single key combination (one key + optional modifiers). You cannot bind sequences like `Ctrl+K, Ctrl+C`. Use **Combos** (Cmd+Shift+M) to chain multiple actions behind a single shortcut.
- **Modifier-only behaviors are not remappable** — Hold-modifiers like Space (temporary hand tool), Alt+hover (measurements), Alt+drag (duplicate while moving), Shift+drag (constrain proportions or angle), and Ctrl+drag (scale mode during resize) are built-in and cannot be reassigned in the Shortcuts panel. Note: the **K** key toggles persistent scale mode as an alternative to holding Ctrl during resize.

## Coming From Figma?

Most Figma shortcuts work unchanged. Key differences:

| Action | Figma | Brilliant | Notes |
|--------|-------|-----------|-------|
| Color picker | No default | **Ctrl+C** | Quick access to color picker |
| Quick colors | No default | **Ctrl+R/G/B/Y/O/P/W/K** | Instant color application |
| Export PNG | Cmd+Shift+E | **Cmd+E** | Simpler shortcut |
| Auto layout | Shift+A | **Shift+A** | Same |
| Group | Cmd+G | **Cmd+G** | Same |
| Outline text | Cmd+Shift+O | **Cmd+Ctrl+O** | Different default |
| Mask | Cmd+Alt+M | **Cmd+Ctrl+M** | Cmd+Alt+M is reserved by macOS ("Minimize All") |
| Overlay mode | N/A | **Ctrl+F** | Unique to Brilliant |
| AI input | N/A | **/** | Natural language commands |
| Combos | N/A | **Cmd+Shift+M** | Macro system |

All shortcuts are fully remappable — you can match any tool's layout via **Shift+?** or the `set_keybinding` batch command.

## Platform Key Convention

| This Guide Says | macOS | Windows / Linux |
|----------------|-------|------------------|
| Cmd | Command (⌘) | Ctrl |
| Ctrl | Control (⌃) | Ctrl |
| Alt | Option (⌥) | Alt |
| Shift | Shift (⇧) | Shift |

## Tools

| Tool | Shortcut |
|------|----------|
| Move tool | V |
| Hand tool | H |
| Pen tool | P |
| Pencil tool | Shift+P |
| Rectangle (fill) | R |
| Rectangle (stroke) | Shift+R |
| Circle (fill) | O |
| Circle (stroke) | Shift+O |
| Line tool | L |
| Arrow tool | Shift+L |
| Text tool | T |
| Frame tool | F |
| Snip tool | S |
| Scale mode (toggle) | K |

### Temporary Tool Switching

| Action | How |
|--------|-----|
| Temporary hand tool | Hold **Space** (release to return) |

### Tool Modifiers (While Drawing)

| Modifier | Effect |
|----------|--------|
| Shift | Constrain proportions (square, circle, 45°) |
| Space | Reposition the in-progress shape without changing its size |

### Pen Tool Modifiers (While Placing Nodes)

| Modifier | Effect |
|----------|--------|
| Click | Place a sharp corner node (no handles) |
| Click and drag | Place a smooth node with mirrored handles |
| Alt/Option + drag | Place an asymmetric node (only one handle moves) |
| Shift + drag | Snap handles to 15-degree increments |

## Selection & Navigation

| Action | Shortcut |
|--------|----------|
| Select all | Cmd+A (in vector edit mode: selects all nodes and handles) |
| Select previous sibling | Tab |
| Select next sibling | Shift+Tab |
| Enter frame / edit element / enter vector edit mode | Enter |
| Exit / cancel (context-aware: clears selection, exits vector mode, exits crop, etc.) | Escape |
| Select parent frame | Shift+Enter |
| Rename selected layer | Cmd+R |

### Escape Behavior (Context-Aware)

A single Escape press picks one of these targets, in priority order:

1. Close the command palette
2. Exit color pick / eyedropper mode
3. Cancel frame label editing
4. Exit image crop mode
5. Clear the current vector handle/node selection (first press in vector mode)
6. Exit vector edit mode (second press) or pen tool
7. Exit boolean group edit mode
8. Exit mask edit mode
9. Blur the AI input
10. Clear the canvas selection

## Movement

| Action | Shortcut |
|--------|----------|
| Nudge 1px | Arrow keys |
| Nudge 10px | Shift+Arrow keys |

### Measurement Overlay

| Modifier | Effect |
|----------|--------|
| Alt/Option + Hover | Show distance measurements between selection and hovered element |

### Move Modifiers (While Dragging)

| Modifier | Effect |
|----------|--------|
| Alt/Option | Duplicate while moving |
| Shift | Constrain movement to one axis |

### Resize Modifiers (While Dragging Handle)

| Modifier | Effect |
|----------|--------|
| Shift | Proportional (maintain aspect ratio) |
| Ctrl | Scale mode: proportional resize + scales font sizes, strokes, corner radii, and descendant elements |
| Cmd | Preserve crop position (image stays in place) |

**Scale mode toggle (K):** Pressing K enables persistent scale mode — all resizes behave as if Ctrl is held until K is pressed again or you switch tools. See [tools.md](./tools.md#scale-mode-k).

### Rotation Modifiers

| Modifier | Effect |
|----------|--------|
| Shift | Snap to 15-degree increments |

## Transform

| Action | Shortcut |
|--------|----------|
| Flip horizontally | Shift+H |
| Flip vertically | Shift+V |

## Clipboard

| Action | Shortcut |
|--------|----------|
| Copy | Cmd+C |
| Cut | Cmd+X |
| Paste | Cmd+V |
| Duplicate | Cmd+D |
| Delete | Backspace |

In vector edit mode, Cmd+C / Cmd+V copy and paste the selected nodes (and their connecting edges) inside the same vector path.

## Undo / Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

Undo history is per-canvas — each canvas has its own undo stack. When the file explorer is focused, undo/redo applies to canvas and folder operations instead.

## Alignment

| Action | Shortcut |
|--------|----------|
| Align left | Alt+Shift+L |
| Align right | Alt+Shift+R |
| Align top | Alt+Shift+T |
| Align bottom | Alt+Shift+B |
| Center horizontally | Alt+H |
| Center vertically | Alt+V |
| Align horizontally | Alt+Shift+H |
| Align vertically | Alt+Shift+V |
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V |
| Fit to parent | Ctrl+Alt+F |

## Layer Order

| Action | Shortcut |
|--------|----------|
| Bring to front | ] |
| Send to back | [ |
| Bring forward | Cmd+] |
| Send backward | Cmd+[ |

## Grouping & Frames

| Action | Shortcut |
|--------|----------|
| Group selection | Cmd+G |
| Frame selection | Cmd+F |
| Ungroup | Cmd+Shift+G |
| Add auto layout | Shift+A |
| Flatten (selection to single vector) | Cmd+Enter |

## Boolean Operations & Masks

| Action | Shortcut |
|--------|----------|
| Boolean Union | Alt+Shift+U |
| Boolean Subtract | Alt+Shift+S |
| Boolean Intersect | Alt+Shift+I |
| Boolean Exclude | Alt+Shift+E |
| Mask | Cmd+Ctrl+M |
| Outline Text (text to vector path) | Cmd+Ctrl+O |

Boolean ops require 2+ elements selected. If a single boolean or mask group is already selected, the same shortcut switches its operation type instead of creating a new group. Use Cmd+Enter (Flatten) to bake a boolean group into a single vector.

## Components

| Action | Shortcut |
|--------|----------|
| Create Component | Cmd+Alt+K |
| Detach Instance | Cmd+Alt+B |
| Go to Master Component | (no default — set in Shift+?) |
| Reset Instance Overrides | (no default — set in Shift+?) |
| Push Overrides to Master | (no default — set in Shift+?) |

## Vector Edit Mode

These shortcuts apply only while a vector path is open for editing.

| Action | Shortcut |
|--------|----------|
| Enter vector edit mode | Enter (with vector selected) or double-click |
| Exit vector edit mode | Escape (twice if a node/handle is selected) |
| Select all nodes and handles | Cmd+A |
| Delete selected nodes / handles | Backspace |
| Toggle node handles (smooth ↔ corner) | Cmd+Click on node |
| Remove a single handle | Cmd+Click on handle |
| Delete an edge | Shift+Click on edge |
| Add a node on an edge | Click on edge |
| Constrain node move to one axis | Shift+drag node |
| Duplicate selected nodes | Alt/Option+drag |
| Detach a handle (set node to Disconnected) | Alt/Option+drag handle |
| Snap rotation of multi-node selection | Shift+drag rotation handle |
| Set Point Type to Straight / Mirrored / Asymmetric / Disconnected | (no defaults — set in Shift+?, or click the Point Type row in the right toolbar) |

See [vectors.md](./vectors.md) for full pen / pencil / vector editing reference.

## Text Styling

| Action | Shortcut |
|--------|----------|
| Bold | Cmd+B |
| Italic | Cmd+I |
| Underline | Cmd+U |
| Align text left | Cmd+Alt+L |
| Align text center | Cmd+Alt+T |
| Align text right | Cmd+Alt+R |

## Quick Colors

| Color | Shortcut |
|-------|----------|
| Red | Ctrl+R |
| Green | Ctrl+G |
| Blue | Ctrl+B |
| Yellow | Ctrl+Y |
| Orange | Ctrl+O |
| Purple | Ctrl+P |
| White | Ctrl+W |
| Black | Ctrl+K |
| Gradient (dark) | Ctrl+D |
| Gradient (light) | Ctrl+L |

## Color Picker

| Action | Shortcut |
|--------|----------|
| Open color selector | Ctrl+C |
| Toggle eyedropper | Ctrl+Shift+C |

## Fill & Stroke

| Action | Shortcut |
|--------|----------|
| Add fill | Shift+F |
| Remove fill | Alt+F |
| Add stroke | Shift+S |
| Remove stroke | Alt+S |
| Swap fill and stroke | Shift+X |

## Size Levels (Stroke / Tool Size)

> **Note:** Bare digit keys (0–9) control size levels in drawing tools. In Move/Hand tool, they control zoom instead.

| Action | Shortcut |
|--------|----------|
| Size level 0–9 | 0–9 (drawing tools only) |
| Increase size | Shift+= |
| Decrease size | - |

## Transparency

| Action | Shortcut |
|--------|----------|
| Transparency level 0%–90% | Cmd+Shift+0 through Cmd+Shift+9 |
| Increase transparency | Cmd+Shift+= |
| Decrease transparency | Cmd+Shift+- |

## Corner Radius

| Action | Shortcut |
|--------|----------|
| Radius level 0–9 | Cmd+Alt+0 through Cmd+Alt+9 |
| Increase radius | Cmd+Alt+Shift+= |
| Decrease radius | Cmd+Alt+- |

## Rotation

Rotation levels use a **clock position** metaphor: level 1 = 1 o'clock (30°), level 2 = 2 o'clock (60°), ..., level 9 = 9 o'clock (270°), level 0 = 12 o'clock (0°). Each level is 30 degrees.

| Action | Shortcut |
|--------|----------|
| Rotation level 0–9 (clock positions) | Cmd+Ctrl+0 through Cmd+Ctrl+9 |
| Increase rotation | Cmd+Ctrl+Shift+= |
| Decrease rotation | Cmd+Ctrl+- |

## Scale

| Action | Shortcut |
|--------|----------|
| Scale level 0–9 | Alt+0 through Alt+9 |
| Scale up | Alt+Shift+= |
| Scale down | Alt+- |

## Zoom & Canvas

| Action | Shortcut |
|--------|----------|
| Zoom in (2x) | Cmd+= |
| Zoom out (0.5x) | Cmd+- |
| Zoom 100%–900% | 1 through 9 (Move/Hand tool only) |
| Toggle zoom | 0 (Move/Hand tool only — toggles between current zoom and last zoom state) |
| Center on selection | Cmd+Ctrl+C |
| Zoom to selection | Cmd+Ctrl+F |
| Fit all content | Cmd+Ctrl+A |
| Disable zoom out | Cmd+Ctrl+D |
| Cmd+scroll zoom | Cmd + scroll/trackpad |

## Grids & Snapping

| Action | Shortcut |
|--------|----------|
| Toggle layout grids | Shift+G |
| Toggle pixel grid | Cmd+' |
| Toggle snap to pixel grid | Shift+Cmd+' |
| Toggle rulers | Shift+U |
| Toggle snap guides (alignment, spacing, equidistant) | (no default — search "Toggle Snap Guides" in command palette) |
| Toggle vector snapping | (no default — search "Toggle Vector Snapping" in command palette) |
| Toggle vector snap to geometry / self / others / grids / path curves | (no default — search "Toggle Vector Snap…" in command palette) |

## Window & Background

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode | Ctrl+F (global hotkey, works when unfocused — switches between studio and overlay) |
| Toggle passthrough | Ctrl+A (overlay mode only — makes window click-through) |
| Show/hide UI | Cmd+\\ (works in both modes; in overlay mode, creates a clean transparent drawing surface) |
| Expand/collapse sections | Cmd+/ |
| Toggle blackboard | Cmd+Shift+B |
| Toggle whiteboard | Cmd+Shift+W |
| Toggle background | Cmd+Shift+D |
| Toggle desktop icons | Ctrl+I |
| Presentation mode | Alt+P |
| Clear all elements | C |

## Canvas Management

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N |
| Duplicate canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N |
| Rename canvas | Alt+Enter |
| Delete canvas | Cmd+Shift+Delete |
| Next file | Alt+→ |
| Previous file | Alt+← |
| Previously active file | Ctrl+Alt+← |
| Focus canvas in explorer | Cmd+Shift+K |
| Expand/collapse all folders | Cmd+Shift+C |

## File Operations

| Action | Shortcut |
|--------|----------|
| Open folder | Cmd+O |
| Import (images, SVGs, design files) | Cmd+Shift+O |
| Save as | Cmd+Shift+S |
| Export to PNG | Cmd+E |

## UI Panels

| Action | Shortcut |
|--------|----------|
| Command palette | Cmd+Shift+P |
| Global search | Cmd+K |
| Canvas search | Cmd+P |
| Layer search | Cmd+L |
| Chat search | Cmd+Shift+I |
| Settings | Cmd+, |
| Shortcuts reference | Shift+? |
| Font selector | Cmd+Shift+F |
| Combos | Cmd+Shift+M |
| Left toolbar | Cmd+Shift+← |
| Right toolbar | Cmd+Shift+→ |
| Bottom toolbar | Cmd+Shift+↓ |
| File explorer | Cmd+Shift+E |
| Layers explorer | Cmd+Shift+R |
| Focus AI chat | / |
| Check for updates | Cmd+Shift+U |

## Chat Sessions

| Action | Shortcut |
|--------|----------|
| Focus chat session 1–9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat | Cmd+Shift+] |
| Focus previous chat | Cmd+Shift+[ |
| Close AI chat | Cmd+W (when chat is focused) |
| Toggle chat explorer | Cmd+Shift+A (when AI chat is open) |
| New chat | Cmd+N (when AI chat is open) |

These shortcuts focus (and expand if minimized) the AI chat session assigned to that number. Cmd+N and Cmd+Shift+A are conditional: they only act on the chat when the AI chat surface is open or focused; otherwise Cmd+N creates a new canvas.

## Combo Presets

| Action | Shortcut |
|--------|----------|
| Yellow highlighter | Ctrl+Shift+Y |
| Red highlighter | Ctrl+Shift+R |
| Green highlighter | Ctrl+Shift+G |
| Blue highlighter | Ctrl+Shift+B |

## Programmatic Keybinding Customization

Keybindings can be queried and batch-updated via commands:

- **`list_keybindings`** — returns all commands with current/default keybinding, `isCustom` flag, and command groups. Optional `group` param to filter by command group, optional `search` param for case-insensitive regex matching against id/name/description (e.g. `"align|distribute"`).
- **`set_keybinding`** — batch set keybindings. Params: `{ "bindings": [{ "commandId": "...", "key": "L", "modifiers": ["shift"] }] }`. Omit key/modifiers to clear. Returns conflicts if any.

Modifier names: `command` (Cmd/Ctrl), `shift`, `alt` (Option), `control`, `fn`. Changes persist to `~/.config/brilliant/keybindings.json`.

---

## Customizing Shortcuts

Open **Shift+?** to view the Keyboard Shortcuts panel. All shortcuts are fully customizable.

### Viewing Shortcuts

Commands are organized in groups (Drawing Tools, Selection & Editing, Canvas Management, etc.) in a two-column scrollable layout. Use the search bar at the top to filter by command name, group, or keybinding.

### Reassigning a Shortcut

1. **Hover** over any command row to reveal action buttons on the right
2. Click the **record** button (circle icon) — the keybinding area shows "Recording..."
3. **Press** your desired key combination (modifiers + key)
4. The new shortcut is saved immediately
5. Press **Escape** to cancel recording without changes

### Removing or Resetting a Shortcut

While hovering a command row:
- **Trash** button — removes the shortcut entirely (command becomes palette-only)
- **Reset** button (appears only if modified) — restores the default shortcut

### Conflict Detection

If your new shortcut conflicts with an existing command:
- A **warning triangle** appears next to the keybinding
- A **context picker** dropdown appears automatically, letting you set when each command is active
- The **"Show conflicts"** filter button (warning triangle in the search bar) highlights all conflicting commands so you can resolve them

Hover the warning triangle to see which commands conflict.

### Activation Contexts ("Active When")

Each command has an activation context that controls when it responds to its shortcut. Hover the **info** button (ⓘ) on any command row to see its "Active when" condition.

Two commands can share the same shortcut if their contexts don't overlap. For example, `Cmd+B` can mean "Bold" during text editing and something else on the canvas.

Available context presets in the picker:

| Context | Meaning |
|---------|---------|
| Canvas | Active on canvas, not during text input or command palette |
| Always | Active everywhere, no restrictions |
| Has Selection | Requires at least one element selected |
| Multiple Selected | Requires 2+ elements selected |
| Auto Layout Selected | Requires an auto layout frame selected |
| Parent Selected | Requires a frame/group selected |
| Component Instance | Requires a component instance selected |
| Text Editing | Active only while editing text |
| AI Input | Active only while the AI input is focused |
| Vector Mode | Active only in vector editing mode with nodes selected |
| Code Editor | Active only while the code editor is focused |

### Executing Commands from the Shortcuts View

Click any command name in the shortcuts view to execute it immediately — useful for testing commands or triggering commands that don't have shortcuts assigned.
