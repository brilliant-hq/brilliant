---
name: "knowledge-text-limits"
description: "Outline Text and Flatten, multilingual text and emoji, text tips, and what text does not support."
assumes: reference/text
---

# Outline, Multilingual, Tips and Limits

## Outline Text and Flatten

Both convert a text element to vector geometry, and both are one-way (the result is no longer editable as text).

| Command | Default shortcut | Result | Use for |
|---------|------------------|--------|---------|
| Outline Text | **Cmd+Ctrl+O** (macOS/Windows) | A group of per-character vector outlines (each glyph is its own editable vector) | Editing individual characters, per-character coloring, character-level boolean ops |
| Flatten Text | (palette only; no default shortcut) | A single compound vector (all glyphs merged into one path) | Masking, boolean ops against other shapes, exporting as one path |
| Flatten | **Cmd+Enter** | Same single compound vector for a text-only selection; the generic flatten for any selection | Flattening text together with other shapes |

**Platform:** glyph extraction is macOS and Windows only (Linux has no glyph-outline backend), so Outline Text and Flatten Text are hidden on Linux. On Windows the Cmd+Ctrl+O chord for Outline Text is unbound (collision); run it from the right-click/context menu or palette. The generic Flatten (Cmd+Enter) applies to any selection on all platforms; on text it routes through the same glyph extraction, so text flattening also needs macOS or Windows.

## Multilingual Text and Emoji

Text shapes with the correct platform fonts for complex scripts automatically, so marks attach and conjuncts form properly. No setup is required.

- **Indic and Southeast Asian scripts:** Devanagari, Bengali, Telugu, Tamil, Kannada, Oriya, Sinhala, Khmer, Myanmar, Lao, Thai (and more) all render with correct glyph shaping.
- **Spaceless scripts** (Thai, Lao, Khmer, Myanmar) wrap at dictionary word boundaries, not mid-word.
- **RTL scripts** (Arabic, Hebrew): set the element to RTL (see `reference/text/typography-paragraph`); default alignment then flushes right naturally.
- **Emoji:** color emoji render by default. A variation selector overrides presentation: VS16 (U+FE0F) forces the color emoji, VS15 (U+FE0E) forces the monochrome text glyph. ZWJ sequences (family, profession, flag emoji) form as single glyphs.
- **Soft hyphen** (U+00AD): stays invisible unless a line breaks at that point, where it renders a hyphen.

## Tips

- Text color is set via fills, not strokes. Text supports all fill types (solid, gradient, image, shader, image filter, color adjust). See `reference/styling/fills`.

- Text reflows from its top edge: when size or font changes, the top stays anchored and the box grows downward.
- Multi-line text uses real newlines. Paragraphs are newline-separated blocks; space them with the paragraph spacing field (or line height) and offset first lines with paragraph indent.
- Bulleted and numbered lists are per-paragraph: toggles behind the Typography "..." expander, Cmd+Shift+8 / Cmd+Shift+7, list spacing field for the gap between items.

## Not Supported

Do not promise these:

- A justify button in the UI (justify is available via Blueprint `align(j)` only).
- Text-on-path (text following a curve).
- Find and replace within or across text elements.
- Per-range line height, alignment, direction, case, OpenType features, or max-lines. (Per-range token bindings DO exist for color, opacity, and font family; size, weight, and line height bindings stay whole-element.)
- Per-range shader or image fills (a shader or image color on a substring). Per-range gradients ARE supported.
- A font-upload button in the picker (use the Install Font Files command or install as a system font; both routes make the family pickable).
- Auto-shrink-to-fit (no automatic font scaling to fit a fixed box; truncation only clips with an ellipsis).
- Vector edit mode directly on text (run Outline Text or Flatten first).
