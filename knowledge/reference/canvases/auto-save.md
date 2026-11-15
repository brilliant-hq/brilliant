---
name: "knowledge-canvases-auto-save"
description: "Auto-save: where work is written, save failures and retries, and opening a file with a few damaged lines."
assumes: reference/canvases
---

# Auto-Save

Brilliant auto-saves continuously. There is no Cmd+S and you never need to save manually for normal use.

- **Repository mode** (a folder opened with Cmd+O): `.bl` files are written directly into the workspace folder, mirroring the explorer hierarchy on disk
- **Scratch mode** (no folder open): work is auto-saved to `~/.config/brilliant/scratch/`

Behavior:
- Shortly after you stop editing, the active canvas is written in the background so saves never block interaction
- The save captures element state, hierarchy, fills/strokes/effects, components, design-system bindings, ruler guides, zoom, pan, and background settings
- The dirty indicator is the dot on the project's tab in the top bar, shown until the change is saved
- If a save fails (permissions, a full disk, a cloud project offline), the canvas stays queued and Brilliant keeps retrying on a widening interval, the dirty indicator stays on, and if saving keeps failing for about two minutes (or at once on a retry when the project folder is missing or the disk is full) a held notice says the edits have not reached disk yet. A single failed save that the next retry fixes shows no notice. Work is never dropped or shown as saved when it is not
- On quit and on workspace switch, all dirty canvases are flushed first, including any whose earlier save failed
- If a `.bl` file fails to load (corrupt content, schema mismatch), saves on that canvas are blocked so good data is never overwritten with empty state

## Recovered files (a few damaged lines)

If a `.bl` file has a small number of damaged lines (for example, an incomplete write or an edit that left one row unreadable), Brilliant now opens the rest of the file instead of failing the whole canvas. The damaged lines, and anything nested under them, are left out, and a banner says so ("“<canvas>” opened with damage, not saving"). A related case opens even more completely: a file written by a NEWER version of Brilliant can carry properties this version does not know yet. Every element stays visible with the properties this version understands, nothing is left out at any count, and the unknown bits stay safely in the file: the same recovered state applies, so nothing rewrites them behind your back, and saving a repaired copy strips them only if you ask.

While a file is in this recovered state:

- **Auto-save is paused for it.** The original file on disk is never changed, so nothing is lost while you decide what to do.
- The banner offers two choices:
  - **Save repaired copy**: writes a new file next to the original ("Name (repaired)") containing everything that loaded, without the damaged lines, and switches you to it. The original file is left exactly as it was.
  - **Dismiss**: keeps the file open in the recovered state (auto-save stays paused). You can still copy work out of it manually.

If a file is damaged beyond a few lines (most of it is unreadable), Brilliant treats it as it does any unreadable file: it blocks saves so the original is preserved, rather than opening a mostly-empty canvas.
