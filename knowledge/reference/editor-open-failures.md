---
name: "knowledge-editor-open-failures"
description: "When the editor or the canvas does not open: what each failure card means (in the browser at brilliant.design and in the desktop app), what the user can try, and what to include when they report it."
---

# When the editor or the canvas does not open

Brilliant draws the canvas with its own GPU renderer: WebGPU in the browser, Metal on macOS, DirectX 12
on Windows. When that renderer cannot start, or a design file cannot be read, Brilliant never leaves a
blank canvas behind. It shows a card that names what happened, and most cards offer a way forward. Find
the card by its title below.

Every card that says "Your work is safe" means it: the design is untouched, and nothing is saved over
it while the card is up.

## Sub-keys

- `reference/editor-open-failures/browser`: browser cards about WebGPU, the graphics device, and renderer errors
- `reference/editor-open-failures/browser-loading`: browser cards about loading the editor, a project, or a design
- `reference/editor-open-failures/desktop`: desktop cards about the renderer and graphics hardware
- `reference/editor-open-failures/desktop-startup`: desktop cards about drivers, crashes, a slow startup, and fonts
- `reference/editor-open-failures/one-canvas`: one canvas that does not open, and reporting a failure
