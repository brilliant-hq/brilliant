---
name: "knowledge-styling-fills"
description: "Adding and removing fills, solid fills, multiple fills, vector region fills, and text fills."
assumes: reference/styling
---

# Fills

## Adding and Removing Fills

| Action | How |
|--------|-----|
| Add a fill | Shift+F or click "+" in Fills section |
| Remove a fill | Alt+F or click delete button |

## Solid Color Fills

Click the fill color swatch in the right toolbar to open the color picker. Use Ctrl+R/G/B/Y/O/P/W/K for quick colors.

## Multiple Fills

Stack multiple fills on a single element. Rendered bottom-to-top in list order. Reorder fills by dragging them in the right toolbar.

## Vector Region Fills

Vector elements with multiple enclosed regions (e.g. a path that crosses itself, or an outlined-and-flattened text glyph with counters) can be colored per region. Cmd+click a region on the canvas (a plain click selects the whole shape), or click it while in vector edit mode, to focus its fill, then change color in the picker. Each region keeps its own fill independently of the element's main fills list.

## Text Fills

Text uses fills for text color. Text supports all fill types: solid, gradient, image, shader, image filters, and color adjust: rendered through the text glyphs. Text also supports strokes (including shader and filter strokes), rendered around the text glyphs with inside/center/outside positioning.

Per-character color is supported via styled ranges: enter edit mode, select a character range, and apply a color. The range's color overrides the element-level fill color for those characters. See `reference/text/ranges` for the full set of per-range overrides.
