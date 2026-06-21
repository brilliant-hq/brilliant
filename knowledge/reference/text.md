---
name: "knowledge-text"
description: "Working with text in Brilliant by hand: creating and editing text, sizing modes, typography controls (font, weight, size, alignment, line height, letter spacing, case, OpenType features, truncation), rich-text ranges, design-token bindings, and outline/flatten."
---

# Text

Text is a regular element type. A text element is its bounding box plus a text payload; the same selection, move, resize, rotate, and flip operations apply to it as to any shape. Text color comes from fills (not strokes), and text also supports strokes (outlined text). All typography controls live in the right toolbar's Typography section when a text element is selected.

## Creating Text

| Action | How |
|--------|-----|
| Activate Text tool | Press **T**, or pick the Text tool in the bottom toolbar |
| Place a text element | With the Text tool active, click on the canvas; the caret lands and editing starts immediately |

New text starts empty with the current font family (default "System Font") and current font size (default 24px). These defaults carry forward from the last text you styled. A fresh text element hugs its content in both axes (Auto Size), so it grows as you type until you resize it or change its sizing mode.

The Text tool is click-to-place only. Dragging does not create a fixed-width box; to get a fixed width, resize the element after creating it (which switches it to a fixed sizing mode).

## Editing Text

### Entering edit mode

| Action | How |
|--------|-----|
| Edit an existing text element | Double-click it, or select it and press **Enter** |
| With the Text tool active | Click an existing text element to edit it directly |

### While editing

- Type to insert at the caret.
- Standard editing shortcuts work: Cmd+A, Cmd+C, Cmd+X, Cmd+V, Cmd+Z, Cmd+Shift+Z.
- The element re-measures and reflows live as you type.

### Exiting edit mode

- **Enter** finishes editing and exits.
- **Escape** cancels and exits (reverts an in-progress edit).
- Click outside the element to commit and exit.
- **Shift+Enter** inserts a newline instead of exiting.

If a text element is left empty when you exit, it is deleted automatically.

## Text Sizing Modes

Sizing is controlled by the sizing row in the Typography section (a width control and a height control), and also by direct resizing on the canvas. The four modes:

| Mode | Width | Height | Behavior |
|------|-------|--------|----------|
| Auto Size | hug | hug | Box hugs content on both axes. Text never wraps; it can overflow a parent. |
| Auto Height | fixed | hug | Width is fixed; text wraps; height grows to fit. |
| Auto Width | hug | fixed | Height is fixed; width grows to fit; text does not wrap. |
| Fixed Size | fixed | fixed | Both dimensions locked; text wraps inside and may clip. |

Manually resizing a text element on the canvas locks the dragged axis to fixed. The same hug/fill/fixed controls used for any element drive text sizing, so inside an auto layout frame a text element's width sizing also accepts **fill** (expand to the available space).

### Text inside auto layout frames

The decision for any text in an auto layout frame is: **should this text wrap?**

- **No wrap** (labels, numbers, metrics, units, dates, nav items, headings, badges, button text, prices): keep the width sizing as **hug**. The box stays as wide as the content. This is the right choice for most UI text.
- **Wrap** (descriptions, paragraphs, body copy): set the width sizing to **fill** so the text is constrained to the frame's content width and wraps inside it.

Note: hug width means the layout engine will not constrain the text, so long hug text can overflow a narrow frame. If text wraps when it should not, its width sizing is fill (or fixed) and should be hug. If text overflows and should wrap, its width sizing is hug and should be fill.

For auto layout sizing behavior in general, see [frames.md](./frames.md). For blueprint authoring syntax (how sizing is expressed in the DSL), see the blueprint knowledge files.

## Typography Controls

All controls are in the right toolbar's Typography section while a text element is selected. When the selection mixes text elements with **different** values for a property, the field shows **Mixed**; typing a value applies it to the whole selection.

Typography commands applied to a selected frame (not in edit mode) cascade to all text descendants of that frame.

### Font family

1. Click the font name in the Typography section, or press **Cmd+Shift+F**.
2. The font picker opens (it is the global command palette pre-filtered to fonts).
3. Type to fuzzy-search by name; hover a font to preview it live on the selected text.
4. Click or press **Enter** to apply; **Escape** restores the original font.

Recently used fonts appear at the top when the search box is empty.

**Available fonts:** about 300 curated Google Fonts plus all system fonts installed on your OS. Google Fonts load on demand (first use triggers a fetch, then cached). There is no in-app custom font upload; to use a font not in the list, install it as a system font and it appears in the picker. The "System Font" entry maps to the platform default font.

### Font weight

Set via the weight dropdown in the Typography section, which lists only the weights the current font actually provides. Standard scale: Thin (100), Extra Light (200), Light (300), Regular (400, default), Medium (500), Semibold (600), Bold (700), Extra Bold (800), Black (900).

### Font size

| Action | How |
|--------|-----|
| Exact value | Type in the font size field |
| Drag to adjust | Drag horizontally on the font size field |

Range 0.2 to 1000. Scaling a text element on the canvas adjusts font size proportionally.

### Bold / Italic / Underline / Strikethrough

| Style | Shortcut | Notes |
|-------|----------|-------|
| Bold | Cmd+B | Toggle button in Typography section |
| Italic | Cmd+I | Toggle button |
| Underline | Cmd+U | Toggle button |
| Strikethrough | (no default shortcut) | Toggle button in Typography section; also command palette |

All four work on whole text elements (no edit mode required) and on the active text selection inside an open editor (applied as a per-range override). Underline and strikethrough are the only text-decoration lines available.

### Text alignment

| Alignment | Shortcut |
|-----------|----------|
| Align Left | Cmd+Alt+L |
| Align Center | Cmd+Alt+T |
| Align Right | Cmd+Alt+R |

Also settable via the alignment buttons in the Typography section. Alignment is whole-element only (no per-range alignment). There is no Justify alignment and no vertical alignment; text anchors to the top edge of its box.

### Line height

A multiplier of font size (1.5 = 1.5x). Set via the line height field: type a value or drag to adjust. Common values: 1.0 tight, 1.2 headings, 1.5 body, 2.0 double-spaced. A value of 0 or less clears the override and uses the font's default ("Auto"). Whole-element only (no per-range override).

### Letter spacing

Horizontal space between characters, in pixels. Set via the letter spacing field next to line height: type a value or drag to adjust. 0 means default (no override); positive widens, negative tightens.

### Text case

A display-only transform that does not change the stored text. Dropdown in the Typography section with: None, Uppercase, Lowercase, Title Case.

### Truncation (max lines)

A dropdown in the Typography section limits the text to a maximum number of lines and adds an ellipsis when it overflows. Options: No truncation, 1 line, 2/3/4/5/6/8/10 lines.

### OpenType features

The "OpenType features" button in the Typography section opens a stay-open checklist of font features (each toggles independently; multiple can be on). Available toggles: Ligatures, Tabular Figures, Small Caps, Slashed Zero, Fractions. Effects depend on the current font actually supporting that feature.

### Text direction

Toggle left-to-right (LTR, default) and right-to-left (RTL) via the command palette: search "Toggle Text Direction". No default keybinding. Whole-element only.

## Styled Ranges (Rich Text)

Apply different styles to portions of a single text element:

1. Enter edit mode (double-click, or select and press Enter).
2. Select a range of text (drag, or Shift+Arrow).
3. Apply a style change (Cmd+B, Cmd+I, Cmd+U, a font/size/weight/color change, etc.).

Per-range overrides supported: font weight, italic, underline, strikethrough, font size, font family, text color, letter spacing. Each override is independent; anywhere a range leaves a property unset, it inherits the element's base style.

Not available per-range: line height, alignment, text direction, text case, OpenType features, max-lines, and design-token bindings (those are whole-element only). Per-range color is solid color only (no gradient, shader, or image fill on a substring).

Ranges are non-overlapping. Editing the surrounding text shifts range offsets automatically, and a range whose overrides all match the base style is dropped.

## Text and Design Tokens

Text properties can be bound to design-system tokens. Bindings resolve at render time, so switching modes (light/dark/custom) or editing the design system updates bound text live. The inspector shows a token chip on a bound field.

Bindable: font size, font weight, line height, font family, text color (via the fill's token binding), and composite typography tokens. A **composite typography token** bundles font family, size, weight, line height, and letter spacing into one named style; applying one via the **Apply Typography Token** command sets all of those at once and clears the individual font token bindings. Manually changing the font family clears the composite binding.

For the token system, default typography tokens, and design-system authoring syntax, see [design-systems.md](./design-systems.md).

## Text Navigation While Editing

| Shortcut | Action |
|----------|--------|
| Shift+Enter | Insert newline |
| Double-click | Select word |
| Triple-click | Select line |
| Quadruple-click | Select all |
| Cmd+A | Select all |
| Shift+Arrow | Extend selection |
| Cmd+Shift+Left/Right | Select to line start/end |
| Alt+Shift+Left/Right | Select word by word |
| Cmd+Left/Right | Jump to line start/end |
| Alt+Left/Right | Move by word |
| Cmd+Up/Down | Jump to document start/end |
| Cmd+Backspace | Delete to line start |
| Alt+Backspace | Delete previous word |

## Outline Text and Flatten

Both convert a text element to vector geometry, and both are one-way (the result is no longer editable as text).

| Command | Default shortcut | Result | Use for |
|---------|------------------|--------|---------|
| Outline Text | **Cmd+Ctrl+O** (macOS/Windows) | A group of per-character vector outlines (each glyph is its own editable vector) | Editing individual characters, per-character coloring, character-level boolean ops |
| Flatten | **Cmd+Enter** | A single compound vector (all glyphs merged into one path) | Masking, boolean ops against other shapes, exporting as one path |

**Platform:** Outline Text is macOS and Windows only (Linux has no glyph-outline backend; it is hidden there). On Windows its Cmd+Ctrl+O chord is run from the right-click/context menu or command palette. Flatten works on all platforms and applies to any selection, not just text; on a text element it produces the merged single-path result described above.

## Tips

- Text color is set via fills, not strokes. Text supports all fill types (solid, gradient, image, shader, image filter, color adjust). See [styling.md](./styling.md#text-fills).
- Text also supports strokes (outlined text) with inside/center/outside positioning.
- Text reflows from its top edge: when size or font changes, the top stays anchored and the box grows downward.
- Multi-line text uses real newlines. There is no separate paragraph-spacing field; use line height or blank lines for paragraph gaps.

## Not Supported

Do not promise these:

- Justified text alignment (only left/center/right).
- Vertical alignment (text anchors to the top edge).
- Bulleted or numbered lists (use literal bullet characters per line).
- Per-paragraph spacing (tune with line height or blank lines).
- Text-on-path (text following a curve).
- Find and replace within or across text elements.
- Per-range line height, alignment, direction, case, OpenType features, max-lines, or token bindings.
- Per-range non-solid fills (gradient/shader/image color on a substring).
- Custom font upload (install as a system font instead).
- Auto-shrink-to-fit (no automatic font scaling to fit a fixed box; truncation only clips with an ellipsis).
- Vector edit mode directly on text (run Outline Text or Flatten first).
