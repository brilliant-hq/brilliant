---
name: "knowledge-text-typography-paragraph"
description: "Line height, letter spacing, paragraph spacing and indent, lists, case, truncation, OpenType features, and text direction."
assumes: reference/text
---

# Typography: Spacing, Lists and Features

## Line height

A multiplier of font size (1.5 = 1.5x). Set via the line height field: type a value or drag to adjust. Common values: 1.0 tight, 1.2 headings, 1.5 body, 2.0 double-spaced. A value of 0 or less clears the override and uses the font's default ("Auto"). Whole-element only (no per-range override).

## Letter spacing

Horizontal space between characters, in pixels. Set via the letter spacing field next to line height: type a value or drag to adjust. 0 means default (no override); positive widens, negative tightens.

## Paragraph spacing and indent

Both in pixels, default 0, whole-element only. **Paragraph spacing** adds vertical space between paragraphs (blocks separated by a hard newline); there is no space after the last paragraph. **Paragraph indent** shifts the first line of each paragraph along its leading edge (right for right-to-left text). Both fields are behind the Typography section's "..." expander: indent shares a row with list spacing, and paragraph spacing is the last row. Blueprint: `ps(N)` and `pi(N)` inside `t(...)`.

## Lists (bullets and numbering)

Any paragraph can be a list item: bulleted or numbered, per paragraph (a text can mix plain, bulleted, and numbered paragraphs). Toggle with the bullet / number buttons behind the Typography section's "..." expander, or Cmd+Shift+8 (bulleted) and Cmd+Shift+7 (numbered); pressing the active one again removes the list. While editing text, the toggle applies to the paragraphs in your selection; otherwise to the whole text. Pressing Enter inside a list item continues the list.

List text indents by 1.5x the font size per nesting level with a hanging marker before the first line. Numbered markers count 1. 2. 3. at level one, a. b. c. at level two, i. ii. iii. at level three, then the cycle repeats; the numbering restarts after any non-numbered paragraph. **List spacing** (behind the same "..." expander, next to paragraph indent) replaces paragraph spacing between two consecutive list items. Nesting levels and markers round-trip with Figma in both directions. Blueprint: `li(...)` and `lsp(N)` inside `t(...)`.

## Text case

A display-only transform that does not change the stored text. Dropdown behind the Typography section's "..." button with: None, Uppercase, Lowercase, Title Case.

## Truncation (max lines)

A dropdown behind the Typography section's "..." button limits the text to a maximum number of lines and adds an ellipsis when it overflows. Options: No truncation, 1 line, 2/3/4/5/6/8/10 lines.

## OpenType features

The "OpenType features" button in the Typography section opens a stay-open checklist of font features (each toggles independently; multiple can be on). Available toggles: Ligatures, Tabular Figures, Small Caps, Slashed Zero, Fractions. A feature the selected font can't actually express is greyed out with a "Not in this font" note and can't be toggled on, so a toggle never shows as checked while doing nothing (the bundled Inter, for example, has Tabular Figures, Slashed Zero, and Fractions but not Ligatures or Small Caps). A feature stays available whenever any selected text uses a font that supports it.

## Text direction

Toggle left-to-right (LTR, default) and right-to-left (RTL) with the direction button next to the font size field in the Typography section (the icon mirrors when the selection is RTL), or via the palette ("Toggle Text Direction"). No default keybinding. Whole-element only. In RTL, text with no explicit alignment flushes right (see Text alignment).
