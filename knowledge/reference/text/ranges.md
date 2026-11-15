---
name: "knowledge-text-ranges"
description: "Styled ranges (rich text), hyperlinks, and design-token bindings on text."
assumes: reference/text
---

# Styled Ranges, Links and Tokens

## Styled Ranges (Rich Text)

Apply different styles to portions of a single text element:

1. Enter edit mode (double-click, or select and press Enter).
2. Select a range of text (drag, or Shift+Arrow).
3. Apply a style change (Cmd+B, Cmd+I, Cmd+U, a font/size/weight/color change, etc.).

Per-range overrides supported: font weight, italic, underline, strikethrough, font size, font family, text color (solid or gradient), letter spacing, and a hyperlink. Each override is independent; anywhere a range leaves a property unset, it inherits the element's base style.

Not available per-range: line height, alignment, text direction, text case, OpenType features, and max-lines (those are whole-element only). Per-range color can be a solid or a gradient; shader and image fills are not available on a substring. Design-token bindings on a range exist for text color, opacity, and font family (a token-bound color or font applied to a range keeps following the design system's mode and brand); font size, weight, and line height token bindings stay whole-element.

**Reading and setting styled text in the inspector.** With a range selected, the Typography fields show that range's values (Mixed when it spans different values). With the caret placed (no selection), they show the style the next typed character takes: the character before the caret (the first character at the start of the text). With the whole text element selected (not editing), Size, Weight, Letter spacing, Font family, Italic, Underline and Strikethrough read every character, so a selection whose characters differ in that value reads Mixed (equal values never do: an unset letter spacing counts as 0); setting one of them there (or toggling a style) applies it to all of the text, and scrubbing moves every range by the same amount.

Ranges are non-overlapping. Editing the surrounding text shifts range offsets automatically, and a range whose overrides all match the base style is dropped.

### Hyperlinks

A text range (or a whole text element) can carry a hyperlink. The **link field** at the bottom of the Typography section sets or clears it: with a range selected while editing, it links that range; with a text element selected (not editing), it links the whole string. Commit with Enter or by clicking away; clearing the field removes the link.

**Cmd+click** a linked range on the canvas to open its URL in your default browser (an ordinary Cmd+click still deep-selects on unlinked text). A link is pure data: it does not restyle the glyphs, so style the linked range yourself (underline, color) if you want it to read as a link.

Links survive export as real anchors in HTML and SVG; PDF and the raster formats (PNG/JPEG/WebP) do not carry them, so linked text exports as ordinary styled text. See `reference/export`.

## Text and Design Tokens

Text properties can be bound to design-system tokens. Bindings resolve at render time, so switching modes (light/dark/custom) or editing the design system updates bound text live. The inspector shows a token chip on a bound field.

Bindable: font size, font weight, line height, font family, text color (via the fill's token binding), and composite typography tokens. A **composite typography token** bundles font family, size, weight, line height, and letter spacing into one named style; applying one via the **Apply Typography Token** command sets all of those at once and clears the individual font token bindings. Manually changing the font family clears the composite binding.

Changing a bound size by hand detaches it, as in Figma: Increase / Decrease Text Size (and scrubbing or typing an offset) steps the size the text shows by 1, clears its size token (and every run's own size token it moves), and leaves a composite typography binding partial (the other properties keep following the design system). Undo restores the binding.

For the token system, default typography tokens, and design-system authoring syntax, see `reference/design-systems`.
