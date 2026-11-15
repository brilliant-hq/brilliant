---
name: "knowledge-editing-paste-replace"
description: "Paste to Replace (Cmd+Shift+R) and Copy/Paste properties, the style copy (Cmd+Alt+C / Cmd+Alt+V): what each does, what travels, and undo."
assumes: reference/editing
---

# Editing: Paste to Replace, Copy and Paste Properties

### Paste to Replace

Select one or more elements, then press **Cmd+Shift+R** (or right-click > **Paste to replace**, or Edit > Paste to Replace): each selected element is removed and the copied elements are pasted in its place, like Figma. The paste lands in the same parent at the same layer position, so inside an auto layout frame it takes the replaced element's slot. It keeps its own size, centered where the replaced element was, and adopts the replaced element's constraints. One Undo puts the replaced elements back in their slots. It pastes what you copied in Brilliant (elements), not an image or text copied in another app.

### Copy and Paste Properties

Copy the look of one element and apply it to others, like Figma. Select ONE element and press **Cmd+Alt+C** (Copy properties), then select any number of elements and press **Cmd+Alt+V** (Paste properties). Both are also in the right-click menu and the Edit menu.

What travels: fills, strokes (color, weight, position, dashes, joins), effects, opacity, blend mode, corner radius, and, from text to text, the text style (font family, size, weight, italic, line height, letter spacing, paragraph spacing, alignment, underline, strikethrough, case). The characters of a text never change. From an auto layout frame to another auto layout frame it also carries the auto layout settings: direction, gap, padding, alignment, and wrap with its row gap; a fixed or fill frame keeps its size; a hug frame refits to the new gap and padding, and its children re-flow to the new settings. A frame without auto layout never gains it, and pasting from one never removes it. Each target takes only what it supports: an ellipse skips corner radius, a rectangle skips text style. Design token bindings travel as bindings, so a pasted `color.primary` fill keeps following the token. Copying properties does not touch the element clipboard, so a copied layer is still there for Cmd+V. One Undo reverts the paste on every target.
