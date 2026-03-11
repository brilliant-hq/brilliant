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

Click outside the text, or press **Escape**.

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

- **No** (labels, numbers, metrics, units, dates, nav items, section headers, badges, button text, prices) → use `hug` — omit `s()` or set `s(hug,hug)` explicitly
- **Yes** (descriptions, paragraphs, body copy, multi-sentence content) → use `fill` — set `s(fill,hug)`

Most text in UI is labels and values that should never wrap. Only use fill for prose.

**Smart defaults (how the system behaves if you omit sizing):**

- **Vertical auto layout** — text automatically gets `fill` width, EXCEPT in `hug`-width parents where text stays `hug`. This default is convenient for prose but **wrong for labels/values** — override with `s(hug,hug)` when text should not wrap. When fill IS applied, text alignment is auto-inferred from the parent's cross-axis: `center` → center text, `end` → right text.
- **Horizontal auto layout** — text keeps `hug` width by default. You must **explicitly set `w:fill h:hug`** on the text element that should expand to fill remaining space. This is intentional: in a row with multiple text elements (e.g., bullet "•" + item text), only one should expand.

**Example — bullet list row:**
```
Bullet Row frame auto-h start w:fill h:hug gap:8
  Bullet text "•" Inter/16 [f1]#3B82F6
  Item text "Launch multiplayer cursors" Inter/16 [f1]#334155 w:fill h:hug
```
The bullet stays hug width, the item text fills remaining space.

**Common issues:**
- "Text wraps when it shouldn't" → text has `fill` width (possibly via smart default in vertical layout) — change to `hug`. This is the most common text sizing error, especially in narrow cards like 3-column metric grids where numbers wrap.
- "Text overflows and doesn't wrap" → text has `hug` width — set `s(fill,hug)` for prose that should wrap.

## Typography

All typography properties are in the right toolbar when a text element is selected.

### Font Family

1. Click the font name in the right toolbar Typography section
2. Font selector opens (also **Cmd+Shift+F**)
3. Search or scroll, hover to preview live on the canvas, click or press **Enter** to apply
4. Press **Escape** to cancel and restore the original font

### Font Selector

The font selector is a searchable overlay with fuzzy matching, live preview, and recent font tracking.

| Action | How |
|--------|-----|
| Open font selector | **Cmd+Shift+F** or click font name in right toolbar |
| Search | Type to fuzzy-search by font name |
| Preview | Hover over a font — selected text updates live on canvas |
| Apply | Click or press **Enter** |
| Cancel | Press **Escape** — restores original font |

**Fuzzy search** prioritizes exact matches, then start-of-word matches, then consecutive characters. Recently used fonts rank higher in results.

**Recently used** — The 10 most recently applied fonts appear at the top of the list when the search field is empty. Applied fonts move to the front of the recent list.

### Available Fonts

Brilliant bundles **~290 curated Google Fonts** plus all **system fonts** from your OS:

| Category | Examples |
|----------|----------|
| **Sans-Serif** (~80) | Inter, Roboto, Poppins, Montserrat, Open Sans, Lato, DM Sans |
| **Serif** (~55) | Playfair Display, Merriweather, Lora, Crimson Text, Source Serif Pro |
| **Display & Heading** (~50) | Bebas Neue, Oswald, Anton, Righteous, Abril Fatface |
| **Script & Handwritten** (~45) | Dancing Script, Great Vibes, Satisfy, Pacifico, Caveat |
| **Monospace** (~25) | Roboto Mono, Source Code Pro, JetBrains Mono, Fira Code |
| **Rounded & Friendly** (~25) | Nunito, Quicksand, Varela Round, Fredoka |

**System fonts** (from your OS) are also available — marked with a gear icon in the selector. Google Fonts are marked with a Google icon.

**Platform defaults:** SF Pro Display (macOS), Segoe UI (Windows), Ubuntu (Linux).

### Font Size

| Action | How |
|--------|-----|
| Set exact size | Type in font size field |
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

### Line Height

Line height is a **multiplier** of font size (e.g., 1.5 = 1.5x font size). Set via the right toolbar field. Type a value, drag to adjust, or use "auto line height" for font defaults. Common values: 1.0 (tight), 1.2 (headings), 1.5 (body text), 2.0 (double-spaced).

### Letter Spacing

Letter spacing controls the horizontal space between characters. Set via the right toolbar field next to line height. Type a value or drag to adjust. A value of 0 means default spacing (no override). Positive values increase spacing, negative values tighten it.

## AI Typography Commands

- "font size 24" — set font size
- "bold" / "italic" / "underline" — toggle style
- "align text left/center/right" — set alignment
- "line height 1.5" — set line height
- "bigger text" / "smaller text" — adjust size
- "set font [name]" — apply font family
- "auto size text" / "auto height text" / "auto width text" / "fixed size text" — sizing mode

## Styled Ranges (Rich Text)

You can apply different styles to portions of text within a single text element:

1. Enter edit mode (double-click or select + Enter)
2. Select a range of text (click and drag, or Shift+Arrow)
3. Apply style changes (Cmd+B for bold, Cmd+I for italic, etc.)

Supported per-range overrides: font weight, italic, underline, font size, font family, text color, and letter spacing. Line height is a base-level property and cannot be overridden per-range.

## Text Navigation While Editing

| Shortcut | Action |
|----------|--------|
| Shift+Enter | Insert new line |
| Double-click | Select word |
| Triple-click | Select line |
| Quadruple-click | Select all |
| Cmd+A | Select all |
| Cmd+Left/Right | Jump to line start/end |
| Alt+Left/Right | Move by word |
| Cmd+Up/Down | Jump to document start/end |
| Cmd+Backspace | Delete to line start |
| Alt+Backspace | Delete word |
| Fn+Delete | Forward delete |
| Home | Jump to line start |
| End | Jump to line end |

## Tips

- **Enter** finishes editing and exits edit mode; use **Shift+Enter** to insert a new line
- Escape exits text editing mode
- Text color is set via fills (not strokes)
