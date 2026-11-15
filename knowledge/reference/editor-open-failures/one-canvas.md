---
name: "knowledge-editor-open-failures-one-canvas"
description: "Cards for a single canvas that cannot be opened or was cut off, and what to include when reporting any failure."
assumes: reference/editor-open-failures
---

# When one canvas does not open (both)

**"Couldn't open <canvas>"**
That canvas's file could not be found, or could not be read. The rest of the project is fine, and
Brilliant does not save over a file it could not read. An earlier checkpoint of the project can bring
the canvas back.

**"<canvas> is damaged and paused"**
Part of the canvas file was cut off. (A card that restored a good copy reads "The end of this file is missing".) Auto-save is paused so the original is never changed. **Restore
from checkpoint** brings back the last checkpoint, and **Save a copy of the damaged file** keeps the
damaged file to send for support. When the file is cut while the canvas is open (even a cut that
ends cleanly between two layers), the open canvas is kept as it was, a copy of it is saved, and
auto-save stays paused until a complete file lands, even when you had unsaved changes at that moment. The
card stays on screen while the canvas is held. If you
have not changed the canvas since, the complete file opens and auto-save resumes at once. If you have,
Brilliant first asks whether to **Reload** the file or **Keep mine**, and auto-save resumes with your
choice. When a
good copy of the file was saved on this computer, opening the canvas restores it and keeps the damaged
file in the project's `.archive` folder.

## Reporting it

Every desktop renderer card has a **Report** button that copies a short, private diagnostics block (app version,
system, graphics backend, and the reason) and sends us the renderer's recent logs (no designs, no file names) so we
can look into it, once per failure: paste the copied block into feedback (see `reference/feedback`).
To copy the diagnostics without sending any logs, use the **Copy diagnostics** link under the card's message.
In the browser, most failure cards offer **Copy details**. Include the card's title and, for a browser report,
the browser and the operating system.
