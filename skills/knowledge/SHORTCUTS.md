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
| **Core drawing** | R, O, T, F, L | Rectangle, Circle, Text, Frame, Line |
| **Core editing** | Cmd+D, Cmd+G, Cmd+Shift+G, Backspace | Duplicate, Group, Ungroup, Delete |
| **Navigation** | Enter / Escape | Enter frame / Exit to parent |
| **Navigation** | Tab / Shift+Tab | Previous / Next sibling |
| **Layout** | Shift+A | Add auto layout |
| **Zoom** | Cmd+Ctrl+C | Center on selection |

Once comfortable, add alignment (Alt+Shift+L/R/T/B), z-order (]/[), and quick colors (Ctrl+R/G/B/K/W).

## Limitations

- **No chord (multi-key) shortcuts** — Each shortcut is a single key combination (one key + optional modifiers). You cannot bind sequences like `Ctrl+K, Ctrl+C`. Use **Combos** (Cmd+Shift+M) to chain multiple actions behind a single shortcut.
- **Modifier-only behaviors are not remappable** — Hold-modifiers like Space (temporary hand tool), Alt+hover (measurements), Alt+drag (duplicate while moving), Shift+drag (constrain proportions), and Ctrl+drag (scale mode during resize) are built-in and cannot be reassigned in the Shortcuts panel.

## Coming From Figma?

Most Figma shortcuts work unchanged. Key differences:

| Action | Figma | Brilliant | Notes |
|--------|-------|-----------|-------|
| Color picker | No default | **Ctrl+C** | Quick access to color picker |
| Quick colors | No default | **Ctrl+R/G/B/Y/O/P/W/K** | Instant color application |
| Export PNG | Ctrl+Shift+E | **Cmd+E** | Simpler shortcut |
| Auto layout | Shift+A | **Shift+A** | Same |
| Group | Cmd+G | **Cmd+G** | Same |
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
| Eraser tool | E |

### Temporary Tool Switching

| Action | How |
|--------|-----|
| Temporary hand tool | Hold **Space** (release to return) |

### Tool Modifiers (While Drawing)

| Modifier | Effect |
|----------|--------|
| Shift | Constrain proportions (square, circle, 45°) |

## Selection & Navigation

| Action | Shortcut |
|--------|----------|
| Select all | Cmd+A |
| Select previous sibling | Tab |
| Select next sibling | Shift+Tab |
| Enter frame / edit element | Enter |
| Exit to parent / cancel | Escape |
| Select parent frame | Shift+Enter |
| Rename selected layer | Cmd+R |

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

### Resize Modifiers (While Dragging Handle)

| Modifier | Effect |
|----------|--------|
| Shift | Proportional (maintain aspect ratio) |
| Ctrl | Scale mode: proportional resize + scales font sizes, strokes, corner radii, and descendant elements |
| Cmd | Preserve crop position (image stays in place) |

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
| Ungroup | Cmd+Shift+G |
| Add auto layout | Shift+A |

## Text Styling

| Action | Shortcut |
|--------|----------|
| Bold | Cmd+B |
| Italic | Cmd+I |
| Underline | Cmd+U |

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
| Reset zoom | 0 (Move/Hand tool only) |
| Center on selection | Cmd+Ctrl+C |
| Fit all content | Cmd+Ctrl+A |
| Disable zoom out | Cmd+Ctrl+D |
| Toggle pixel grid | Cmd+' |
| Toggle snap to pixel grid | Shift+Cmd+' |
| Cmd+scroll zoom | Cmd + scroll/trackpad |

## Grids

| Action | Shortcut |
|--------|----------|
| Toggle layout grids | Shift+G |
| Add layout grid | Ctrl+Shift+G |
| Toggle pixel grid | Cmd+' |
| Toggle rulers | Shift+U |

## Window & Background

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode | Ctrl+F (global hotkey, works when unfocused — switches between studio and overlay) |
| Toggle passthrough | Ctrl+A (overlay mode only — makes window click-through) |
| Show/hide UI | Cmd+\\ (in overlay mode, hides all panels for a clean transparent drawing surface) |
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
| Save as | Cmd+Shift+S |
| Save workspace as | Cmd+Ctrl+S |
| Import image | Cmd+K |
| Export to PNG | Cmd+E |
| Save workspace | Cmd+S |

## UI Panels

| Action | Shortcut |
|--------|----------|
| Command palette | Cmd+Shift+P |
| Canvas search | Cmd+P |
| Layer search | Cmd+L |
| Settings | Cmd+, |
| Shortcuts reference | Shift+? |
| Font selector | Cmd+Shift+F |
| Combos | Cmd+Shift+M |
| Left toolbar | Cmd+Shift+← |
| Right toolbar | Cmd+Shift+→ |
| Bottom toolbar | Cmd+Shift+↓ |
| File explorer | Cmd+Shift+E |
| Layers explorer | Cmd+Shift+R |
| Focus AI search | / |
| Check for updates | Cmd+Shift+U |
| Launch onboarding | Cmd+Shift+O |
| Rename layer | Cmd+R |

## Chat Sessions

| Action | Shortcut |
|--------|----------|
| Focus chat session 1–9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat | Cmd+Shift+] |
| Focus previous chat | Cmd+Shift+[ |
| Close AI chat | Cmd+W |

These shortcuts focus (and expand if minimized) the AI chat session assigned to that number.

## Boolean Operations

| Action | Shortcut |
|--------|----------|
| Boolean Union | Alt+Shift+U |
| Boolean Subtract | Alt+Shift+S |
| Boolean Intersect | Alt+Shift+I |
| Boolean Exclude | Alt+Shift+E |

## Components

| Action | Shortcut |
|--------|----------|
| Create Component | Cmd+Alt+K |
| Detach Instance | Cmd+Alt+B |

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

Modifier names: `command` (Cmd/Ctrl), `shift`, `alt` (Option), `control`, `fn`. Changes persist to `~/.config/brilliant.design/keybindings.json`.

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
