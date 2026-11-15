---
name: "knowledge-editing-clipboard"
description: "Clipboard shortcuts, what Copy writes (internal clipboard, system PNG), copying between projects, and Cut."
assumes: reference/editing
---

# Editing: Clipboard, Copy, Cut

| Action | Shortcut |
|--------|----------|
| Copy | Cmd+C |
| Cut | Cmd+X |
| Paste | Cmd+V |
| Paste to replace | Cmd+Shift+R |
| Copy properties | Cmd+Alt+C |
| Paste properties | Cmd+Alt+V |
| Duplicate | Cmd+D |
| Delete | Backspace (or Delete) |
| Clear canvas | C (the C key, when the canvas has focus) |

### Copy

Copies the selected elements to an **internal clipboard** (in-memory) and writes a PNG render of the selection to the **system clipboard** so it can be pasted into other apps. Frame children are captured at copy time so cross-canvas paste works even after switching canvases.

**What gets copied:**
- The selected elements and their full hierarchy (frames include all children and nested frames)
- Styling (fills, strokes, corner radius, opacity, layout behavior, effects, component data)
- When the selection is exactly one image element with no strokes, zero corner radius, full opacity, and no active crop, the raw image bytes are written to the system clipboard instead of a re-rendered PNG (preserves original quality)

**Copying between projects:** A copy carries the real, editable elements to any other Brilliant project, not just a flat image. Paste it into another canvas tab, into a second app window, into the same project after relaunching the app, or into the web editor, and the elements come back fully intact: components (with their masters and overrides), images, brand tokens, and fonts all travel with the copy. Copying between the desktop app and the web editor works in Chromium-based browsers (for example Chrome).

### Cut

Same as Copy plus removes the selected elements from the canvas. Cut copies first (the internal clipboard and the system clipboard PNG) and only then removes, so the copy is never taken from an empty selection. If the system clipboard cannot be written (a toast says the copy is available for pasting in Brilliant), the internal copy still wins the next Paste in Brilliant; content you copy in another app AFTER the cut wins instead. In vector edit mode, Cut copies and deletes the selected vector nodes only (not the whole element). Undoable: Undo restores the removed elements.
