---
name: "knowledge-canvas-background"
description: "The canvas background layer stack (void, background color, blackboard) and the background modes."
assumes: reference/canvas
---

# Canvas: Background

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
