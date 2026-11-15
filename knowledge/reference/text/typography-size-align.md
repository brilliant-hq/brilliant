---
name: "knowledge-text-typography-size-align"
description: "Font size, bold, italic, underline, strikethrough, and horizontal and vertical text alignment."
assumes: reference/text
---

# Typography: Size, Style and Alignment

## Font size

| Action | How |
|--------|-----|
| Exact value | Type in the font size field |
| Drag to adjust | Drag horizontally on the font size field |
| Increase by 1px | **Shift+=** |
| Decrease by 1px | **-** |

Range 0.2 to 20000. Scaling a text element on the canvas adjusts font size proportionally. Shift+= and - step the size by 1px; with a range selected while editing, they step that range only. (Shift+= / - are shared with stroke width: on a non-text shape they nudge the stroke instead.)

## Bold / Italic / Underline / Strikethrough

| Style | Shortcut | Notes |
|-------|----------|-------|
| Bold | Cmd+B | No toggle button; use the shortcut or the font weight dropdown |
| Italic | Cmd+I | Toggle button in Typography section |
| Underline | Cmd+U | Toggle button |
| Strikethrough | (no default shortcut) | Toggle button in Typography section; also palette |

All four work on whole text elements (no edit mode required) and on the active text selection inside an open editor (applied as a per-range override). Underline and strikethrough are the only text-decoration lines available.

## Text alignment

| Alignment | Shortcut |
|-----------|----------|
| Align Left | Cmd+Alt+L |
| Align Center | Cmd+Alt+T |
| Align Right | Cmd+Alt+R |

Also settable via the alignment buttons in the Typography section. Alignment is whole-element only (no per-range alignment). Justify has no Typography button but works via Blueprint `align(j)`.

**Vertical alignment** (Top / Middle / Bottom, default Top): a button trio behind the Typography section's "..." expander places the text block inside a fixed-height box. It only has a visible effect when the height is fixed (hug-height boxes fit the text exactly). Blueprint: `valign(t|c|b)`. Commands: `align_text_top` / `align_text_middle` / `align_text_bottom` (no default shortcuts).

Explicitly choosing **Align Left** always renders physically left. A text element with **no** alignment chosen is direction-aware: left-to-right text sits flush left, right-to-left text sits flush right naturally.
