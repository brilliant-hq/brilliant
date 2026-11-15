---
name: "knowledge-export-files"
description: "Exporting a multi-selection as separate files or one file, and how hidden elements in the selection export."
assumes: reference/export
---

# Separate files (multi-selection, PNG/JPEG/WebP/SVG)

When you select **two or more frames** (or other top-level elements) and export a raster format (PNG/JPEG/WebP) or SVG, Brilliant exports **one file per selected element by default** rather than merging them into a single image, the same behavior as Figma.

- A **Files** dropdown appears (Separate files / Single file) whenever a raster or SVG export has 2+ export targets. For SVG it sits inline next to the format pill; for raster it's the first row inside the settings panel (gear button). It defaults to **Separate files**.
- Pick **Single file** to go back to the old behavior: the whole selection rendered into one merged image.
- **Desktop:** exporting separate files asks for one destination **folder** (a single pick for the whole batch); each element is written into it. Files with the same name get `-2`, `-3`, … suffixes.
- **Web:** the files are bundled into a single **zip** download.
- Nesting: a selected element inside another selected frame is exported as part of that frame, not as its own file. Only "selection roots" (selected elements with no selected ancestor) become files.
- SVG and PDF are separate concerns: PDF uses its multi-page mode; raster/SVG use this separate-files mode.

## Hidden elements in the selection

Selecting an element and exporting or copying it renders it **even when it is hidden**: an explicit selection is treated as intent, so its own hidden state (and any hidden frame above it) is ignored and it shows up in the output. Only a layer hidden *inside* a selected frame stays hidden, matching what you see on the canvas. So if an export or a Copy as comes back empty, the cause is that nothing in the selection resolves (stale or deleted ids), not that the selection was hidden.
