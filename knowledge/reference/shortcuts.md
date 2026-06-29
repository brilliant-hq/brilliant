---
name: "knowledge-shortcuts"
description: "Complete keyboard shortcut reference for Brilliant covering tools, editing, styling, canvas, and canvas management."
---

# Keyboard Shortcuts

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

- **No chord (multi-key) shortcuts**: Each shortcut is a single key combination (one key + optional modifiers). You cannot bind sequences like `Ctrl+K, Ctrl+C`. Use **Combos** (Cmd+Shift+M) to chain multiple actions behind a single shortcut.
- **Modifier-only behaviors are not remappable**: Hold-modifiers like Space (temporary hand tool), Alt+hover (measurements), Alt+drag (duplicate while moving), Shift+drag (constrain proportions or angle), and Ctrl+drag (scale mode during resize) are built-in and cannot be reassigned in the Shortcuts panel. Note: the **K** key toggles persistent scale mode as an alternative to holding Ctrl during resize.

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

All shortcuts are fully remappable: you can match any tool's layout via **Shift+?** or the `set_keybinding` batch command.

## Platform Key Convention

| This Guide Says | macOS | Windows / Linux |
|----------------|-------|------------------|
| Cmd | Command (⌘) | Ctrl |
| Ctrl | Control (⌃) | Ctrl |
| Alt | Option (⌥) | Alt |
| Shift | Shift (⇧) | Shift |

### Windows-disabled defaults

On Windows several macOS defaults are unbound, because their Cmd-based chords collapse onto an essential Ctrl shortcut (e.g. a quick-color Ctrl chord would collide with Bold/Group/Rename) or because the feature is macOS-only. Users can reassign any of these in the Shortcuts panel; the actions also stay reachable via the menu, command palette, or inspector.

| Command | Reason |
|---------|--------|
| `toggle_overlay_mode` (default Ctrl+F on macOS) | Ctrl+F is the universal "Find" shortcut on Windows. Also unregisters the global hotkey. |
| `toggle_pass_through` (default Ctrl+A on macOS) | Ctrl+A is the universal "Select All" shortcut on Windows. |
| Snip tool (`change_tool_snip`, default S) | Screen capture is macOS-only. |
| `toggle_desktop_icons` (default Ctrl+I) | macOS-only no-op; frees Ctrl+I for Italic. |
| Outline Text (`Cmd+Ctrl+O`) | Collapses to Ctrl+O and collides; use the menu/command palette instead. |
| All quick colors (Ctrl+R/G/B/Y/O/P/W/K) and gradient colors (Ctrl+D/L) | Collide with Cmd→Ctrl editing commands (Bold, Group, Rename, etc.); set color via the inspector or command palette. |
| Blue / green / red highlighter combos (Ctrl+Shift+B/G/R) | Collide with Blackboard / Ungroup / Focus Layers. The yellow highlighter combo stays bound. |

### Windows-remapped defaults

On Windows some Cmd+Ctrl defaults are moved to free chords (the plain Ctrl chord is reserved by an essential command). A Windows user should expect these instead of the macOS chords listed elsewhere in this guide:

| Command | macOS | Windows |
|---------|-------|---------|
| Fit all content | Cmd+Ctrl+A | Alt+A |
| Center on selection | Cmd+Ctrl+C | Alt+C |
| Zoom to selection | Cmd+Ctrl+F | Alt+Z |
| Disable zoom out | Cmd+Ctrl+D | Alt+D |
| Duplicate canvas | Cmd+Ctrl+N | Alt+N |
| Increase size | Shift+= | = (bare) |
| Increase / decrease rotation | Cmd+Ctrl+Shift+= / Cmd+Ctrl+- | Shift+= / Shift+- |
| Rotation levels 0–9 | Cmd+Ctrl+0–9 | Alt+Shift+0–9 |

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
| Alt/Option + drag | Place a disconnected node (only the outgoing handle is set; incoming side stays zero) |
| Shift + drag | Snap handles to 15-degree increments |

## Selection & Navigation

| Action | Shortcut |
|--------|----------|
| Select all | Cmd+A (in vector edit mode: selects all nodes and handles) |
| Select previous sibling | Tab (id `select_previous_element`) |
| Select next sibling | Shift+Tab (id `select_next_element`) |
| Enter frame / edit element / enter vector edit mode | Enter |
| Exit / cancel (context-aware: clears selection, exits vector mode, exits crop, etc.) | Escape |
| Select parent frame | Shift+Enter |
| Rename selected layer | Cmd+R |
| Delete selected | Backspace |

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
| Nudge selection 1px (up/down/left/right) | Arrow keys (ids `move_elements_up`, `_down`, `_left`, `_right`) |
| Nudge selection 10px | Shift+Arrow keys (ids `move_elements_*_fast`) |
| Enter move mode | (no default, id `enter_move_mode`) |

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

**Scale mode toggle (K):** Pressing K enables persistent scale mode: all resizes behave as if Ctrl is held until K is pressed again or you switch tools. See [tools.md](./tools.md#scale-mode-k).

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

Undo history is per-canvas: each canvas has its own undo stack. When the file explorer is focused, undo/redo applies to canvas and folder operations instead.

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
| Reorder fill in stack | (no default, id `reorder_fill`) |
| Reorder stroke in stack | (no default, id `reorder_stroke`) |
| Remove selection color (from selection-colors editor) | (no default, id `remove_selection_color`) |

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
| Create Component | Cmd+Alt+K (id `create_component`) |
| Create Instance | (no default, id `create_instance`) |
| Detach Instance | Cmd+Alt+B (id `detach_component`) |
| Go to Master Component | (no default, id `go_to_master_component`) |
| Reset Instance Overrides | (no default, id `reset_component_instance_overrides`) |
| Push Overrides to Master | (no default, id `push_overrides_to_master`) |

## Frame & Container

| Action | Shortcut |
|--------|----------|
| Toggle clip content (frame) | (no default, id `toggle_clip_content`) |
| Toggle constrain proportions (selected element) | (no default, id `toggle_constrain_proportions`) |
| Toggle absolute position (auto layout child) | (no default, id `toggle_absolute_position`) |
| Toggle auto layout wrap | (no default, id `toggle_auto_layout_wrap`) |
| Set frame type (Frame / Group / Auto Layout / Mask / Boolean) | (no default, id `set_frame_type`; dropdown command in inspector) |
| Skew elements | (no default, id `skew_elements`) |

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
| Set Point Type Straight / Mirrored / Asymmetric / Disconnected | (no defaults, ids `set_point_type_straight`, `set_point_type_mirrored`, `set_point_type_asymmetric`, `set_point_type_disconnected`; or click the Point Type row in the right toolbar) |

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
| Toggle text direction (LTR / RTL) | (no default, id `toggle_text_direction`) |
| Auto-size text (Auto / Auto Width / Auto Height / Fixed) | (no defaults, ids `auto_size_text`, `auto_width_text`, `auto_height_text`, `fixed_size_text`; also `set_text_sizing_mode` dropdown) |
| Increase / decrease text size | (no defaults, ids `increase_text_size`, `decrease_text_size`) |
| Increase / decrease line height | (no defaults, ids `increase_line_height`, `decrease_line_height`) |
| Reset line height | (no default, id `reset_line_height`) |
| Set font weight | (no default, id `set_font_weight`; dropdown in Typography section) |
| Apply font family | (no default, id `apply_font_family`; via font selector Cmd+Shift+F) |
| Outline text (text -> vector path) | Cmd+Ctrl+O |
| Flatten text (collapse styled runs) | (no default, id `flatten_text`) |

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
| Cycle stroke position (inside / center / outside) | (no default, id `cycle_stroke_position`) |
| Set stroke position (specific) | (no defaults, ids `set_stroke_position_inside`, `set_stroke_position_center`, `set_stroke_position_outside`) |
| Set stroke cap round / square | (no defaults, ids `set_stroke_cap_round`, `set_stroke_cap_square`) |
| Increase / decrease stroke width | (no defaults, ids `increase_stroke_width`, `decrease_stroke_width`) |
| Add image-filter / shader fill (inner shadow, inner glow, background blur, color adjust, noise/grain, halftone, pixelate, duotone, posterize, dither) | (no defaults, ids `add_inner_shadow_fill`, `add_inner_glow_fill`, `add_background_blur_fill`, `add_color_adjust_fill`, `add_noise_grain_fill`, `add_halftone_fill`, `add_pixelate_fill`, `add_duotone_fill`, `add_posterize_fill`, `add_dither_fill`) |
| Toggle global shader animation | (no default, id `toggle_global_shader_animation`) |

## Effects

| Action | Shortcut |
|--------|----------|
| Add drop shadow | (no default, id `add_drop_shadow`) |
| Add layer (element) blur | (no default, id `add_layer_blur`) |
| Add outer glow | (no default, id `add_outer_glow`) |
| Remove effect | (no default, id `remove_effect`) |

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
| Increase transparency | Cmd+Shift+= (bound to the numpad + key; on keyboards without a numpad this default may not fire, so reassign it in the Shortcuts panel) |
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
| Toggle zoom | 0 (Move/Hand tool only, toggles between current zoom and last zoom state) |
| Center on selection | Cmd+Ctrl+C |
| Zoom to selection | Cmd+Ctrl+F |
| Fit all content | Cmd+Ctrl+A |
| Disable zoom out below 100% (toggle) | Cmd+Ctrl+D |
| Reset zoom to 100% | (no default, command id `reset_zoom`) |
| Cmd+scroll zoom | Cmd + scroll/trackpad |

## Grids & Snapping

| Action | Shortcut |
|--------|----------|
| Toggle layout grids | Shift+G |
| Toggle pixel grid | Cmd+' |
| Toggle snap to pixel grid | Cmd+Shift+' |
| Toggle rulers | Shift+U |
| Clear all ruler guides | (no default, command id `clear_all_ruler_guides`) |
| Toggle snap guides (alignment, spacing, equidistant) | (no default, command id `toggle_snap_guides`) |
| Toggle dimension labels | (no default, command id `toggle_dimension_labels`) |
| Toggle vector snapping | (no default, command id `toggle_vector_snapping_enabled`) |
| Toggle vector snap to geometry / self / others / grids / path curves | (no default, ids `toggle_vector_snap_to_geometry`, `_self`, `_others`, `_grids`, `_path_curves`) |
| Toggle handle angle (vector edit) | (no default, command id `toggle_handle_angle`) |
| Add layout grid to selected frame | (no default, command id `add_layout_grid`) |

## Window & Background

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode | Ctrl+F on macOS — an OS-level global hotkey that fires even when Brilliant is unfocused; switches between studio and overlay. Requires overlay mode enabled in settings. Unbound by default on Windows. |
| Toggle passthrough (overlay only) | Ctrl+A on macOS (global hotkey while in overlay; makes the window click-through to apps below). Unbound by default on Windows. |
| Show/hide UI | Cmd+\\ (toggles toolbars in both window modes; in overlay creates a clean transparent drawing surface) |
| Expand/collapse all right-toolbar sections | Cmd+/ (id `toggle_sections`) |
| Toggle blackboard | Cmd+Shift+B |
| Toggle whiteboard | Cmd+Shift+W |
| Toggle canvas background | Cmd+Shift+D (id `toggle_background`) |
| Toggle desktop icons (overlay) | Ctrl+I |
| Presentation mode | Alt+P |
| Clear all elements on canvas | C (bare, on canvas) |
| Toggle render profiler | Cmd+Shift+Alt+P (id `toggle_render_profiler`) |
| Toggle search profiler | (no default, id `toggle_search_profiler`) |
| Toggle top-left indicator | (no default, id `toggle_indicator`) |
| Quit application | (no default, id `quit_app`; macOS provides Cmd+Q) |
| Hide application / Hide others | (no defaults, ids `hide_app`, `hide_others`; macOS provides Cmd+H, Cmd+Alt+H) |

## Canvas Management

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N (creates a new canvas; when AI chat is open instead routes to `new_chat`) |
| Duplicate canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N |
| Rename canvas | Alt+Enter |
| Delete canvas | Cmd+Shift+Delete |
| Switch to next canvas | Alt+→ |
| Switch to previous canvas | Alt+← |
| Switch to previously active canvas | Ctrl+Alt+← |
| Focus active canvas in explorer | Cmd+Shift+K |
| Toggle expand/collapse all folders | Cmd+Shift+C |
| Toggle hidden files | (no default) |

## File Operations

| Action | Shortcut |
|--------|----------|
| Open design folder (workspace) | Cmd+O (id `open_design_folder`) |
| Import (images, SVGs, Figma URL, Sketch files, .design folders) | Cmd+Shift+O (id `import`) |
| Save as | Cmd+Shift+S |
| Export selection to PNG | Cmd+E (id `export_to_png`) |
| Export selection to JPEG / WebP / SVG / PDF / Replay (mp4/mov) | (no defaults, ids `export_to_jpeg`, `export_to_webp`, `export_to_svg`, `export_to_pdf`, `export_to_replay`) |
| Copy as PNG / WebP / SVG / CSS / YAML / Blueprint | (no defaults, ids `copy_as_png`, `copy_as_webp`, `copy_as_svg`, `copy_as_css`, `copy_as_yaml`, `copy_as_blueprint`) |
| Insert image / Import image | (no defaults, ids `insert_image`, `import_image`) |
| Clean up unused assets | (no default, id `clean_up_unused_assets`) |
| Load Getting Started canvas | (no default, id `load_getting_started`) |

## UI Panels

| Action | Shortcut |
|--------|----------|
| Command palette (commands only) | Cmd+Shift+P |
| Global search (all categories) | Cmd+K |
| Canvas search (files filter) | Cmd+P |
| Layer search | Cmd+L |
| Chat search | Cmd+Shift+I |
| Font selector | Cmd+Shift+F |
| Color selector / picker | Ctrl+C |
| Settings | Cmd+, |
| Shortcuts reference | Shift+? |
| Combos | Cmd+Shift+M |
| Toggle left toolbar | Cmd+Shift+← |
| Toggle right toolbar | Cmd+Shift+→ |
| Toggle bottom toolbar | Cmd+Shift+↓ |
| Focus file (canvas) explorer | Cmd+Shift+E (id `focus_canvas_explorer`) |
| Focus layers explorer | Cmd+Shift+R (id `focus_layers_explorer`) |
| Toggle layers section in left toolbar | (no default, id `toggle_layers`) |
| Focus AI chat input in bottom toolbar | / (slash) |
| Check for updates | Cmd+Shift+U |
| Toggle Vim mode (code editor) | (no default, id `toggle_vim_mode`) |

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
| AI chat layout: full screen / bottom half / right half / left half | (no defaults, ids `ai_chat_full_screen`, `ai_chat_bottom_half`, `ai_chat_right_half`, `ai_chat_left_half`) |
| Toggle AI chat panel | (no default, command id `toggle_ai_chat`) |
| Toggle suggested prompts | (no default, command id `toggle_suggested_prompts`) |
| Toggle AI input collapse | (no default, command id `toggle_ai_input_collapse`) |
| Clear AI input | (no default, command id `clear_ai_input`) |
| Delete all archived chats | (no default, command id `delete_all_archived_chats`) |

These shortcuts focus (and expand if minimized) the AI chat session assigned to that number. Cmd+N and Cmd+Shift+A are conditional: they only act on the chat when the AI chat surface is open or focused. When the AI chat surface is not open, Cmd+N creates a new canvas. Cmd+W close-chat is gated behind chat focus and falls through otherwise (no global window-close binding).

## Combo Presets

| Action | Shortcut |
|--------|----------|
| Yellow highlighter | Ctrl+Shift+Y |
| Red highlighter | Ctrl+Shift+R |
| Green highlighter | Ctrl+Shift+G |
| Blue highlighter | Ctrl+Shift+B |

## Design System

| Action | Shortcut |
|--------|----------|
| Switch design mode (e.g. light / dark) | (no default, id `set_design_system_mode`) |
| Apply dark theme / Apply light theme | (no defaults, ids `apply_dark_theme`, `apply_light_theme`. Note: Ctrl+D and Ctrl+L are bound to the "Gradient (dark)" / "Gradient (light)" color commands, NOT to these theme commands) |
| Apply typography / shadow token to selection | (no defaults, ids `apply_typography_token`, `apply_shadow_token`) |
| Set design token on selected element property | (no default, id `set_design_token`) |
| Regenerate / reset / open design system file | (no defaults, ids `regenerate_design_system`, `reset_design_system`, `open_design_system_file`) |
| Create a design system viewer canvas | (no default, id `create_design_system_viewer`) |
| Switch active design system | (no default, id `set_design_system`) |

Note: seeds (color, mode) and base scales (spacing, radius, font size, font weight, line height) are not set via individual commands. They are authored in the design system source, which `open_design_system_file` opens in the code editor. For the authoring syntax, see the design-systems knowledge files.

## Provider / API Keys

| Action | Shortcut |
|--------|----------|
| Set Anthropic / OpenAI / Google / OpenRouter / Quiver API key | (no defaults, ids `set_anthropic_api_key`, `set_openai_api_key`, `set_google_api_key`, `set_openrouter_api_key`, `set_quiver_api_key`) |

## Programmatic Keybinding Customization

Keybindings can be queried and batch-updated via commands:

- **`list_keybindings`**: returns all commands with current/default keybinding, `isCustom` flag, and command groups. Optional `group` param to filter by command group, optional `search` param for case-insensitive regex matching against id/name/description (e.g. `"align|distribute"`).
- **`set_keybinding`**: batch set keybindings. Params: `{ "bindings": [{ "commandId": "...", "key": "L", "modifiers": ["shift"] }] }`. Omit key/modifiers to clear. Returns conflicts if any.

Modifier names: `command` (Cmd/Ctrl), `shift`, `alt` (Option), `control`, `fn`. Changes persist to `~/.config/brilliant/keybindings.json`.

---

## Customizing Shortcuts

Open **Shift+?** to view the Keyboard Shortcuts panel. All shortcuts are fully customizable.

### Viewing Shortcuts

Commands are organized in groups (Drawing Tools, Selection & Editing, Canvas Management, etc.) in a two-column scrollable layout. Use the search bar at the top to filter by command name, group, or keybinding.

### Reassigning a Shortcut

1. **Hover** over any command row to reveal action buttons on the right
2. Click the **record** button (circle icon): the keybinding area shows "Recording..."
3. **Press** your desired key combination (modifiers + key)
4. The new shortcut is saved immediately
5. Press **Escape** to cancel recording without changes

### Removing or Resetting a Shortcut

While hovering a command row:
- **Trash** button: removes the shortcut entirely (command becomes palette-only)
- **Reset** button (appears only if modified): restores the default shortcut

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

Click any command name in the shortcuts view to execute it immediately: useful for testing commands or triggering commands that don't have shortcuts assigned.
