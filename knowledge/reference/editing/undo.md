---
name: "knowledge-editing-undo"
description: "Undo and redo: per-canvas undo history, AI undo stacks, and the file explorer undo stack."
assumes: reference/editing
---

# Editing: Undo and Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

### Selection Is Not an Undo Step

Selecting is never undone on its own. Clicking, Shift-clicking, dragging a selection box, picking a layer in the Layers panel, Select All, and selecting points while editing a vector path add nothing to the undo history. While you edit a path, undoing a point move also brings back the point you moved, still selected. Each change you make remembers what was selected when you made it, so undo and redo bring that selection back along with the change.

For example: delete a shape, click another shape, then press Cmd+Z. The deleted shape comes back, selected as it was. Clicking around after an undo also keeps your redo available. An agent's `undo` never steps a selection either: it always undoes a real change.

### When a Step Can't Apply

If an undo or redo can't apply (for example, the frame it would restore into is gone), Brilliant shows a one-line notice such as **Couldn't undo "Delete". The step is kept, so you can try again.** Nothing is lost: the step stays on its stack. The notice goes away when that same history steps successfully; an AI agent's undo or an undo on another canvas does not dismiss it. An AI agent's failing undo answers an error and can be retried the same way.

### Per-Canvas Undo History

Each canvas has its own independent undo/redo history. Switching canvases does not affect undo stacks: when you return to a canvas, its full history is still available. Canvas switching itself is **not** undoable. AI operations get their own separate undo stack so they don't pollute your manual undo history. An external agent's undo history is released after 30 minutes with no call (or when its client ends the session), after which its `undo` answers that the history was released; an in-app chat keeps its agent's undo until the chat closes.

**Undo does not persist across sessions.** Closing and reopening the app clears all undo history. For persistent history, use Git version control (see `reference/canvases`).

### File Explorer Undo

When the **canvas explorer** is focused (left toolbar, **Cmd+Shift+E**), undo/redo applies to **file and folder operations** instead of canvas elements:

- Rename a canvas or folder
- Create a canvas or folder
- Delete a canvas or folder
- Reorder canvases / folders

This is a separate undo stack from each canvas. Cmd+Z with the explorer focused will not touch element edits, and vice versa.

An AI agent's `undo` or `redo` over `execute_commands` never steps this file history, whatever has focus: it steps its own session's last change on the canvas its `canvasId` names, and never touches another canvas. To remove or rename a canvas, an agent uses `delete_canvas`, `rename_canvas` and the other canvas commands. The answer names the action and the canvas, for example `Undid "Duplicate" on canvas "Home", this session's stack.` When the session has nothing to undo on that canvas, the answer names its real last action and canvas so the agent can name that canvasId instead.
