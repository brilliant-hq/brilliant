---
name: "knowledge-text"
description: "Text editing, inline editing, text sizing modes, typography, fonts, and text styling in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Text

## Text Editing

### Entering Edit Mode

| Action | How |
|--------|-----|
| Create new text | Press **T**, click on canvas, start typing |
| Edit existing text | Double-click the text element, or select it and press **Enter** |

### While Editing

- Type to insert text at the cursor position
- Standard text editing shortcuts work (Cmd+A, Cmd+C, Cmd+X, Cmd+V, etc.)
- The text element updates live as you type

### Exiting Edit Mode

Press **Enter**, press **Escape**, or click outside the text element. Use **Shift+Enter** to insert a new line instead of exiting.

## Text Sizing Modes

### Auto Size (Hug)

The text box automatically resizes in both width and height to fit content. Text grows horizontally without wrapping. Set via AI command "auto size text" or right toolbar.

### Auto Height

Width is fixed, height grows to fit. Text wraps at the fixed width. Useful for specific column widths. Set via "auto height text" or right toolbar.

### Auto Width

Height is fixed, width grows to fit content. Text expands horizontally without wrapping. Set via "auto width text" or right toolbar.

### Fixed Size

Both width and height are explicit. Text wraps within fixed width and may overflow. Manually resizing a text element switches to fixed size.

### Text Inside Auto Layout Frames

**The fundamental question: "Should this text wrap?"**

- **No** (labels, numbers, metrics, units, dates, nav items, section headers, badges, button text, prices) → use `hug`: omit `s()` or set `s(hug,hug)` explicitly
- **Yes** (descriptions, paragraphs, body copy, multi-sentence content) → use `fill`: set `s(fill,hug)`

Most text in UI is labels and values that should never wrap. Only use fill for prose.

**Smart defaults (how the system behaves if you omit sizing):**

- **Vertical auto layout**: text automatically gets `fill` width, EXCEPT in `hug`-width parents where text stays `hug`. This default is convenient for prose but **wrong for labels/values**: override with `s(hug,hug)` when text should not wrap. When fill IS applied, text alignment is auto-inferred from the parent's cross-axis: `center` → center text, `end` → right text.
- **Horizontal auto layout**: text keeps `hug` width by default. You must **explicitly set `s(fill,hug)`** on the text element that should expand to fill remaining space. This is intentional: in a row with multiple text elements (e.g., bullet "•" + item text), only one should expand.

**Example: bullet list row:**
```
al(h,x(s),y(s),g(8),pad($spacing.none)) s(fill,hug) "Bullet Row"
  t("•",Inter,16) f[(#F97316)]
  t("Launch multiplayer cursors",Inter,16) s(fill,hug) f[(#334155)]
```
The bullet stays hug width, the item text fills remaining space.

**Common issues:**
- "Text wraps when it shouldn't" → text has `fill` width (possibly via smart default in vertical layout): change to `hug`. This is the most common text sizing error, especially in narrow cards like 3-column metric grids where numbers wrap.
- "Text overflows and doesn't wrap" → text has `hug` width: set `s(fill,hug)` for prose that should wrap.

## Typography

All typography properties are in the right toolbar when a text element is selected.

### Font Family

1. Click the font name in the right toolbar Typography section
2. Font selector opens (also **Cmd+Shift+F**)
3. Search or scroll, hover to preview live on the canvas, click or press **Enter** to apply
4. Press **Escape** to cancel and restore the original font

### Font Selector

The font selector is the **Fonts** filter view of the global command palette. Pressing the font selector shortcut opens the palette pre-filtered to fonts.

| Action | How |
|--------|-----|
| Open font selector | **Cmd+Shift+F** (`toggle_font_family` command) or click the font name in the right toolbar Typography section |
| Search | Type to fuzzy-search by font name |
| Preview | Hover over a font; selected text updates live on canvas |
| Apply | Click or press **Enter** |
| Cancel | Press **Escape** to restore the original font |

Recently used fonts surface at the top of the list when the search field is empty.

### Available Fonts

Brilliant bundles a curated list of approximately **300 Google Fonts** (`curatedGoogleFonts` in `lib/managers/font_manager.dart`) plus all **system fonts** from your OS. Examples by category:

| Category | Examples |
|----------|----------|
| Sans-Serif | Inter, Roboto, Poppins, Montserrat, Open Sans, Lato, DM Sans |
| Serif | Playfair Display, Merriweather, Lora, Crimson Text, Source Serif Pro |
| Display / Heading | Bebas Neue, Oswald, Anton, Righteous, Abril Fatface |
| Script / Handwritten | Dancing Script, Great Vibes, Satisfy, Pacifico, Caveat |
| Monospace | Roboto Mono, Source Code Pro, JetBrains Mono, Fira Code |
| Rounded / Friendly | Nunito, Quicksand, Varela Round, Fredoka |

System fonts come from the OS font registry. Google Fonts are loaded on-demand via the `google_fonts` package; the first use of a font triggers a network fetch (subsequent uses are cached).

Custom font upload is not supported in-app. To use a font that is not in the bundled list, install it as a system font on your OS and it will appear in the selector.

### Font Size

| Action | How |
|--------|-----|
| Set exact size | Type in font size field |
| Drag to adjust | Drag horizontally on the font size field |
| AI command | "text size 24" or "bigger text" |

**Range:** 0.2 to 1000. Scaling a text element adjusts font size proportionally.

### Font Weight

| Weight | Name |
|--------|------|
| w100 | Thin |
| w200 | Extra Light |
| w300 | Light |
| w400 | Regular (default) |
| w500 | Medium |
| w600 | Semibold |
| w700 | Bold |
| w800 | Extra Bold |
| w900 | Black |

Font weight can also be set via the weight dropdown in the right toolbar Typography section, which shows only weights available for the current font.

### Bold, Italic, Underline

| Style | Shortcut |
|-------|----------|
| Bold | Cmd+B |
| Italic | Cmd+I |
| Underline | Cmd+U |

### Text Alignment

| Alignment | Shortcut |
|-----------|----------|
| Align Left | Cmd+Alt+L |
| Align Center | Cmd+Alt+T |
| Align Right | Cmd+Alt+R |

Also settable via the right toolbar Typography section or AI commands ("align text left/center/right").

### Text Direction

Text direction controls whether text flows left-to-right (LTR, the default) or right-to-left (RTL). Toggle via the command palette: search "Toggle Text Direction". No default keybinding.

### Line Height

Line height is a **multiplier** of font size (e.g., 1.5 = 1.5x font size). Set via the right toolbar field. Type a value, drag to adjust, or use "auto line height" for font defaults. Common values: 1.0 (tight), 1.2 (headings), 1.5 (body text), 2.0 (double-spaced).

### Letter Spacing

Letter spacing controls the horizontal space between characters. Set via the right toolbar field next to line height. Type a value or drag to adjust. A value of 0 means default spacing (no override). Positive values increase spacing, negative values tighten it.

## AI Typography Commands

- "font size 24": set font size
- "bold" / "italic" / "underline": toggle style
- "align text left/center/right": set alignment
- "line height 1.5": set line height
- "bigger text" / "smaller text": adjust size
- "set font [name]": apply font family
- "auto size text" / "auto height text" / "auto width text" / "fixed size text": sizing mode

## Styled Ranges (Rich Text)

You can apply different styles to portions of text within a single text element:

1. Enter edit mode (double-click or select + Enter)
2. Select a range of text (click and drag, or Shift+Arrow)
3. Apply style changes (Cmd+B for bold, Cmd+I for italic, etc.)

`TextStyleRange` supports these per-range overrides (each nullable; null means "inherit from base"):

| Property | Per-range override field |
|----------|--------------------------|
| Font weight | `fontWeight` |
| Italic | `isItalic` |
| Underline | `isUnderlined` |
| Font size | `fontSize` |
| Font family | `fontFamily` |
| Text color | `color` |
| Letter spacing | `letterSpacing` |

Properties NOT supported per-range: line height (whole-element only), text alignment, text direction, decorations beyond underline (no strikethrough), and design token bindings (token refs are base-level only).

Per-range color is restricted to solid colors (no gradients, shaders, or image fills on a sub-string).

Ranges are non-overlapping and stored sorted by character offset. Editing the surrounding text (insert, delete) shifts range offsets automatically. A range whose properties all match the base style is dropped automatically.

## Text and Design Tokens

Text properties can be bound to design system tokens. Bindings resolve at render time via `RenderContext`, so mode switching (light/dark/custom) and `.styles` edits update bound text live.

| Property | Token key pattern | Stored on `TextData` field |
|----------|------------------|---------------------------|
| Font size | `font.size.{xs..2xl}` | `fontSizeTokenRef` |
| Font weight | `font.weight.{thin..black}` | `fontWeightTokenRef` |
| Line height | `font.lineHeight.{none..loose}` | `lineHeightTokenRef` |
| Font family | `font.family` | `fontFamilyTokenRef` |
| Text color | color token (via fill `tokenRef`) | on `Fill.style.tokenRef` |
| Composite typography | `typography.{name}` | `typographyTokenRef` |

A **composite typography token** bundles font family, size, weight, line height, and letter spacing into one named style. Applying a typography token via the **Apply Typography Token** command sets all five fields, stores the key in `typographyTokenRef`, and clears the four individual font token refs. Built-in composites: `typography.h1`–`h6`, `typography.body.sm`/`md`/`lg`, `typography.caption`, `typography.label`, `typography.code` (monospace family). See the design system reference for default values.

Manually changing the font family clears `typographyTokenRef`. Other inspector edits update the underlying value but may leave the composite ref in place; the inspector chip is the authoritative indicator.

## Text Navigation While Editing

| Shortcut | Action |
|----------|--------|
| Shift+Enter | Insert new line |
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
| Fn+Delete | Forward delete |
| Cmd+Fn+Delete | Delete to line end |
| Alt+Fn+Delete | Delete next word |
| Home | Jump to line start |
| End | Jump to line end |

## Outline Text (Convert to Vectors)

Select a text element and use **Cmd+Ctrl+O** (or search "Outline Text" in the command palette) to convert the text into a group of per-character vector outlines. Each character becomes its own editable vector element inside a group. This is a one-way conversion: the text can no longer be edited as text. Useful for custom letter modifications, boolean operations with other shapes, or when you need the text as pure geometry.

**Platform:** macOS only. On other platforms the command is registered but tagged `invisibleToUser` and the execute body returns immediately.

## Flatten Text (Convert to Single Vector)

Select a text element and use **Cmd+Alt+O** (or search "Flatten Text" in the command palette) to convert the text into a single compound vector element. Unlike Outline Text (which creates one vector per character), Flatten Text merges all characters into one vector path. This is a one-way conversion.

**Platform:** macOS only. On other platforms the command is hidden and the execute body returns immediately.

## Tips

- **Enter** finishes editing and exits edit mode; use **Shift+Enter** to insert a new line
- Escape exits text editing mode
- Text color is set via fills (not strokes). Text supports all fill types (solid, gradient, image, shader, image filter, color adjust). See [styling.md](./styling.md#text-fills).
- Text elements also support strokes (rendered as outlined text), with inside/center/outside positioning
- Text reflows from its top edge: when font size or family changes, the top stays anchored and the box grows downward
- Multi-line text uses real newlines (`\n`). There is no separate paragraph spacing field; tune spacing via line height or insert blank lines.

## Not Supported

These typography features are not available in Brilliant today, so don't promise them to users:

- Vertical alignment (top/middle/bottom). Text is anchored to the top edge.
- Justified text alignment. Only `TextAlign.start`/`center`/`end` are supported.
- Bulleted or numbered lists. Use literal bullet characters in front of each line if you need a list.
- Per-paragraph spacing. Tune visual paragraph gaps via `lineHeight` or extra blank lines.
- Text-on-path (text following a curve).
- Find and replace within or across text elements.
- Per-range line height, text direction, or alignment.
- Per-range token bindings (token refs are base-level only).
- Strikethrough decoration (only underline is supported).
- Custom font upload. Install as a system font instead.
- Text-frame "auto-shrink to fit" mode (no automatic font-size scaling to fit a fixed box).
