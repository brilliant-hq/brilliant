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

Sizing is controlled by the sizing-mode dropdown in the Typography section (Auto Size / Auto Height / Auto Width / Fixed, next to the font weight dropdown), by the Auto Size button beside it (one click back to hug-both), and by direct resizing on the canvas. The four modes:

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

All controls are in the right toolbar's Typography section while a text element is selected. Rows, top to bottom: (1) font family + font size + text-direction (RTL) toggle; (2) line height + letter spacing + OpenType features button; (3) font weight dropdown + sizing-mode dropdown + Auto Size button; (4) horizontal alignment trio + Italic + Underline + Strikethrough + a "..." expander. Behind the "..." expander: a buttons row (vertical alignment trio on the left, bulleted and numbered list toggles on the right), then paragraph indent + list spacing, then case + truncation dropdowns, then paragraph spacing last.

When the selection mixes text elements with **different** values for a property, the field shows **Mixed**; typing a value applies it to the whole selection.

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
| Increase by 1px | **Shift+=** |
| Decrease by 1px | **-** |

Range 0.2 to 1000. Scaling a text element on the canvas adjusts font size proportionally. Shift+= and - step the size by 1px; with a range selected while editing, they step that range only. (Shift+= / - are shared with stroke width: on a non-text shape they nudge the stroke instead.)

### Bold / Italic / Underline / Strikethrough

| Style | Shortcut | Notes |
|-------|----------|-------|
| Bold | Cmd+B | No toggle button; use the shortcut or the font weight dropdown |
| Italic | Cmd+I | Toggle button in Typography section |
| Underline | Cmd+U | Toggle button |
| Strikethrough | (no default shortcut) | Toggle button in Typography section; also command palette |

All four work on whole text elements (no edit mode required) and on the active text selection inside an open editor (applied as a per-range override). Underline and strikethrough are the only text-decoration lines available.

### Text alignment

| Alignment | Shortcut |
|-----------|----------|
| Align Left | Cmd+Alt+L |
| Align Center | Cmd+Alt+T |
| Align Right | Cmd+Alt+R |

Also settable via the alignment buttons in the Typography section. Alignment is whole-element only (no per-range alignment). Justify has no Typography button but works via Blueprint `align(j)`.

**Vertical alignment** (Top / Middle / Bottom, default Top): a button trio behind the Typography section's "..." expander places the text block inside a fixed-height box. It only has a visible effect when the height is fixed (hug-height boxes fit the text exactly). Blueprint: `valign(t|c|b)`. Commands: `align_text_top` / `align_text_middle` / `align_text_bottom` (no default shortcuts).

Explicitly choosing **Align Left** always renders physically left. A text element with **no** alignment chosen is direction-aware: left-to-right text sits flush left, right-to-left text sits flush right naturally.

### Line height

A multiplier of font size (1.5 = 1.5x). Set via the line height field: type a value or drag to adjust. Common values: 1.0 tight, 1.2 headings, 1.5 body, 2.0 double-spaced. A value of 0 or less clears the override and uses the font's default ("Auto"). Whole-element only (no per-range override).

### Letter spacing

Horizontal space between characters, in pixels. Set via the letter spacing field next to line height: type a value or drag to adjust. 0 means default (no override); positive widens, negative tightens.

### Paragraph spacing and indent

Both in pixels, default 0, whole-element only. **Paragraph spacing** adds vertical space between paragraphs (blocks separated by a hard newline); there is no space after the last paragraph. **Paragraph indent** shifts the first line of each paragraph along its leading edge (right for right-to-left text). Both fields are behind the Typography section's "..." expander: indent shares a row with list spacing, and paragraph spacing is the last row. Blueprint: `ps(N)` and `pi(N)` inside `t(...)`.

### Lists (bullets and numbering)

Any paragraph can be a list item: bulleted or numbered, per paragraph (a text can mix plain, bulleted, and numbered paragraphs). Toggle with the bullet / number buttons behind the Typography section's "..." expander, or Cmd+Shift+8 (bulleted) and Cmd+Shift+7 (numbered); pressing the active one again removes the list. While editing text, the toggle applies to the paragraphs in your selection; otherwise to the whole text. Pressing Enter inside a list item continues the list.

List text indents by 1.5x the font size per nesting level with a hanging marker before the first line. Numbered markers count 1. 2. 3. at level one, a. b. c. at level two, i. ii. iii. at level three, then the cycle repeats; the numbering restarts after any non-numbered paragraph. **List spacing** (behind the same "..." expander, next to paragraph indent) replaces paragraph spacing between two consecutive list items. Nesting levels and markers round-trip with Figma in both directions. Blueprint: `li(...)` and `lsp(N)` inside `t(...)`.

### Text case

A display-only transform that does not change the stored text. Dropdown behind the Typography section's "..." button with: None, Uppercase, Lowercase, Title Case.

### Truncation (max lines)

A dropdown behind the Typography section's "..." button limits the text to a maximum number of lines and adds an ellipsis when it overflows. Options: No truncation, 1 line, 2/3/4/5/6/8/10 lines.

### OpenType features

The "OpenType features" button in the Typography section opens a stay-open checklist of font features (each toggles independently; multiple can be on). Available toggles: Ligatures, Tabular Figures, Small Caps, Slashed Zero, Fractions. Effects depend on the current font actually supporting that feature.

### Text direction

Toggle left-to-right (LTR, default) and right-to-left (RTL) with the direction button next to the font size field in the Typography section (the icon mirrors when the selection is RTL), or via the command palette ("Toggle Text Direction"). No default keybinding. Whole-element only. In RTL, text with no explicit alignment flushes right (see Text alignment).

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
| Flatten Text | **Cmd+Alt+O** | A single compound vector (all glyphs merged into one path) | Masking, boolean ops against other shapes, exporting as one path |
| Flatten | **Cmd+Enter** | Same single compound vector for a text-only selection; the generic flatten for any selection | Flattening text together with other shapes |

**Platform:** glyph extraction is macOS and Windows only (Linux has no glyph-outline backend), so Outline Text and Flatten Text are hidden on Linux. On Windows the Cmd+Ctrl+O chord for Outline Text is unbound (collision); run it from the right-click/context menu or command palette. The generic Flatten (Cmd+Enter) applies to any selection on all platforms; on text it routes through the same glyph extraction, so text flattening also needs macOS or Windows.

## Multilingual Text and Emoji

Text shapes with the correct platform fonts for complex scripts automatically, so marks attach and conjuncts form properly. No setup is required.

- **Indic and Southeast Asian scripts:** Devanagari, Bengali, Telugu, Tamil, Kannada, Oriya, Sinhala, Khmer, Myanmar, Lao, Thai (and more) all render with correct glyph shaping.
- **Spaceless scripts** (Thai, Lao, Khmer, Myanmar) wrap at dictionary word boundaries, not mid-word.
- **RTL scripts** (Arabic, Hebrew): set the element to RTL (see [Text direction](#text-direction)); default alignment then flushes right naturally.
- **Emoji:** color emoji render by default. A variation selector overrides presentation: VS16 (U+FE0F) forces the color emoji, VS15 (U+FE0E) forces the monochrome text glyph. ZWJ sequences (family, profession, flag emoji) form as single glyphs.
- **Soft hyphen** (U+00AD): stays invisible unless a line breaks at that point, where it renders a hyphen.

## Tips

- Text color is set via fills, not strokes. Text supports all fill types (solid, gradient, image, shader, image filter, color adjust). See [styling.md](./styling.md#text-fills).
- Text also supports strokes (outlined text) with inside/center/outside positioning.
- Text reflows from its top edge: when size or font changes, the top stays anchored and the box grows downward.
- Multi-line text uses real newlines. Paragraphs are newline-separated blocks; space them with the paragraph spacing field (or line height) and offset first lines with paragraph indent.
- Bulleted and numbered lists are per-paragraph: toggles behind the Typography "..." expander, Cmd+Shift+8 / Cmd+Shift+7, list spacing field for the gap between items.

## Not Supported

Do not promise these:

- A justify button in the UI (justify is available via Blueprint `align(j)` only).
- Text-on-path (text following a curve).
- Find and replace within or across text elements.
- Per-range line height, alignment, direction, case, OpenType features, max-lines, or token bindings.
- Per-range non-solid fills (gradient/shader/image color on a substring).
- Custom font upload (install as a system font instead).
- Auto-shrink-to-fit (no automatic font scaling to fit a fixed box; truncation only clips with an ellipsis).
- Vector edit mode directly on text (run Outline Text or Flatten first).
