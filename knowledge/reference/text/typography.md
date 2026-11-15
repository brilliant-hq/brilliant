---
name: "knowledge-text-typography"
description: "The Typography section layout, font family and available fonts, font weight, and italic."
assumes: reference/text
---

# Typography Controls

All controls are in the right toolbar's Typography section while a text element is selected. Rows, top to bottom: (1) font family + font size + text-direction (RTL) toggle; (2) line height + letter spacing + OpenType features button; (3) font weight dropdown + sizing-mode dropdown + Auto Size button; (4) horizontal alignment trio + Italic + Underline + Strikethrough + a "..." expander; (5) a hyperlink field for the selected range or element (see `reference/text/ranges`). Behind the "..." expander: a buttons row (vertical alignment trio on the left, bulleted and numbered list toggles on the right), then paragraph indent + list spacing, then case + truncation dropdowns, then paragraph spacing last.

When the selection mixes text elements with **different** values for a property, the field shows **Mixed**; typing a value applies it to the whole selection.

Typography commands applied to a selected frame (not in edit mode) cascade to all text descendants of that frame.

## Font family

1. Click the font name in the Typography section, or press **Cmd+Shift+F**.
2. The font picker opens (it is the global palette pre-filtered to fonts).
3. Type to fuzzy-search by name; hover a font to preview it live on the selected text.
4. Click or press **Enter** to apply; **Escape** restores the original font.

Recently used fonts appear at the top when the search box is empty.

**Available fonts:** about 300 curated Google Fonts plus all system fonts installed on your OS, plus any fonts installed into Brilliant's own font store. Google Fonts load on demand (first use triggers a fetch, then cached). To use a font not in the list, either install it as a system font or add the `.ttf`/`.otf` file directly via the Install Font Files command. Installed fonts appear in the picker, and imported texts shown in a substitute switch back to the real font in place. During a Figma import, Brilliant also fetches missing openly-licensed fonts automatically (Google Fonts and known open icon fonts such as remixicon) and notes each fetch in the migration report, so imported text keeps its real font instead of a substitute. HTML brought in through the browser extension or an agent's `html` fence gets the same treatment: a family the page names is fetched from Google Fonts at the weights the page uses, or installed from the page's own `.ttf`/`.otf`/`.woff`/`.woff2` file (linked or inlined as a `data:` url), before the text is laid out, so a captured site keeps its face. A create waits at most about 2 seconds for a Google Fonts download: a face that takes longer, or whose download fails, lays its text out on Inter (the face it draws in until then) and re-measures it the moment the face arrives, and a failed download is retried on its own for a few minutes, then again (at most once a minute) whenever another font loads or a text in that family is created or opened, so the face comes back when your connection does. A page file whose own family differs from the name the page gives it is used under its own family, the page's name being an alias for it as in a browser, and the reply names both. A family that cannot be fetched (a page file that does not read as a font, or a commercial face) renders on Inter and is named in the reply. Text with no explicit family is Inter, which ships with the app: there is no separate "System Font" entry, and your platform's UI font (SF Pro Display on macOS, Segoe UI on Windows) is just another pickable family. On macOS the Apple families (SF Pro, SF Pro Text, SF Pro Display, SF Compact, SF Mono, New York) draw in their real San Francisco or New York face: the SF Pro fonts you installed from Apple when present (the same face other Mac apps show), otherwise the face built into macOS. System families are listed under their real names as the font files themselves declare them, one entry per family (a family's bold/italic files never appear as separate entries), with the weight menu offering the weights actually installed.

## Font weight

Set via the weight dropdown in the Typography section, which lists only the weights the current font actually provides. Standard scale: Thin (100), Extra Light (200), Light (300), Regular (400, default), Medium (500), Semibold (600), Bold (700), Extra Bold (800), Black (900).

## Italic

Toggle with the Italic button in the Typography section or **Cmd+I**. When the font family ships a real italic face at the weight you are using, that face is used. When it does not (many display and trial fonts ship upright faces only, and plenty of classic families ship an italic at regular weight but no bold italic), Brilliant slants the upright face by 14 degrees instead of ignoring the request, the same way browsers, Word and Figma-adjacent tools do. Slanting never changes spacing, so the text box, line breaks and the caret land exactly where they would upright.

**An italic toggle never changes weight.** Bold text stays bold when you italicize it. Where a family has no bold italic, you get the bold face slanted rather than the family's regular-weight italic: keeping the weight you chose matters more than using a hand-drawn slant one weight too light.

The slant is the same whatever else you do to the text: skewing it, adding a stroke, or filling it with liquid glass never straightens it back out.

