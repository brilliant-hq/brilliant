---
name: "knowledge-editing-figma-paste"
description: "Pasting a Figma copy into Brilliant as native editable elements, what comes across, and the honest limits."
assumes: reference/editing
---

# Editing: Paste from Figma

Copy anything in Figma (Cmd+C), switch to Brilliant, and paste (Cmd+V). No plugin and no file link: the design arrives as real Brilliant elements you can edit by hand, dropped at the cursor.

What comes across:

- **Live components.** Components arrive as real instances linked to a master, showing the labels, amounts, shown-or-hidden rows, and slot content exactly as you saw them, not the blank template underneath. You can swap variants and reconfigure them like any Brilliant component. Paste the same design again, even after restarting the app, and the paste reuses the matching masters already on your canvas instead of adding duplicates.
- **Your variables, as a design system.** The variables the design uses arrive as a real design system with its modes, and elements stay bound to those tokens, so switching a mode re-themes them.
- **Reflowing auto layout.** Frames that used Figma auto layout arrive as real auto-layout frames, positioned exactly as they looked, that reflow when you resize or edit them.
- **Text**, with its content, font, size, weight, alignment, per-range styling, lists, letter case, line-limit truncation, and OpenType features like stylistic sets and small caps.
- **Fills, colors, gradients, strokes, corner radii, and effects**, including shadows, blurs, and liquid glass.
- **Icons and vector shapes**, as editable vector paths.
- **Images**, brought in for real when you are connected to Figma (see the limits below).

A very large paste (tens of thousands of layers) lands in steps: the canvas fills in as it arrives and the app stays responsive, the pasted layers are selected when it finishes, and one Cmd+Z still removes the whole paste.

Honest limits:

- **Images need the Figma connection.** Photos and exported bitmaps used as image fills come across as real images only when Brilliant is connected to your Figma account. Without the connection they arrive as a labeled placeholder you can replace: drag the file in or paste the image on its own.
- **An edited master is never silently overwritten or adopted.** If you changed a pasted component's fills, text, or structure and then paste the same design again, the paste adds a fresh master under a new name (with a note) instead of merging with your edited one.
- **Rounded stars and polygons arrive with sharp corners.** The star or polygon shape itself comes across exactly; Figma's corner rounding on those shapes does not, and a labeled note tells you when that happened. Boolean shapes arrive as real boolean groups with live operands.
- Works in the **desktop app** (macOS and Windows) and in the **browser editor**. In the browser, paste with the keyboard (Cmd+V, or Ctrl+V): a paste from a menu can bring in Figma's picture of the selection instead of the elements, because some browsers hand the Figma copy only to a keyboard paste.
