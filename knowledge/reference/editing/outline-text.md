---
name: "knowledge-editing-outline-text"
description: "Outline Text and Flatten Text: converting text into vector geometry, per platform."
assumes: reference/editing
---

# Editing: Outline Text and Flatten Text

| Action | Shortcut |
|--------|----------|
| Outline Text | Ctrl+Cmd+O |
| Flatten Text | (palette only; no default shortcut) |

Both commands convert text into vector paths and are available on macOS and Windows (native glyph extraction), not on Linux. On Windows, Outline Text has no default keyboard shortcut because its chord collides with another command; reach it via the palette, menu, or context menu.

| Command | Output |
|---------|--------|
| Outline Text | A group of per-character vector elements (each glyph is a separate vector inside a group) |
| Flatten Text | A single compound vector element with per-character regions (the same operation as Flatten applied to a text element) |

Discovery: right-click context menu, "Outline Text", shown when the selection contains text. To get a single compound vector instead, use **Flatten Text** (palette; no default keyboard shortcut, no context-menu entry) or **Flatten** (Cmd+Enter).

Each converted glyph is a **single clean outline** with its counters (the holes in letters like e, o, a) preserved as holes, so a stroke or effect traces the letter's silhouette with no seams inside it. Curves stay true beziers, so outlined text scales without going polygonal.

Every converted glyph is checked against the live text before it is committed: it must paint exactly the same ink. If a glyph cannot be converted without changing its shape, the whole text is left as text and the command reports it (the MCP result names the character and the font; in the app a toast says "Couldn't convert this text without changing its shape"). A conversion never silently changes a letter.

Both are one-way conversions: the result is no longer editable as text.
