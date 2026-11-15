---
name: "knowledge-text-sizing"
description: "Text sizing modes (Auto Size, Auto Height, Auto Width, Fixed) and text inside auto layout frames."
assumes: reference/text
---

# Text Sizing Modes

Sizing is controlled by the sizing-mode dropdown in the Typography section (Auto Size / Auto Height / Auto Width / Fixed, next to the font weight dropdown), by the Auto Size button beside it (one click back to hug-both), and by direct resizing on the canvas. The four modes:

| Mode | Width | Height | Behavior |
|------|-------|--------|----------|
| Auto Size | hug | hug | Box hugs content on both axes. Text never wraps; it can overflow a parent. |
| Auto Height | fixed | hug | Width is fixed; text wraps; height grows to fit. |
| Auto Width | hug | fixed | Height is fixed; width grows to fit; text does not wrap. |
| Fixed Size | fixed | fixed | Both dimensions locked; text wraps inside and may clip. |

Manually resizing a text element on the canvas locks the dragged axis to fixed. The same hug/fill/fixed controls used for any element drive text sizing, so inside an auto layout frame a text element's width sizing also accepts **fill** (expand to the available space).

## Text inside auto layout frames

The decision for any text in an auto layout frame is: **should this text wrap?**

- **No wrap** (labels, numbers, metrics, units, dates, nav items, headings, badges, button text, prices): keep the width sizing as **hug**. The box stays as wide as the content. This is the right choice for most UI text.
- **Wrap** (descriptions, paragraphs, body copy): set the width sizing to **fill** so the text is constrained to the frame's content width and wraps inside it.

Note: hug width means the layout engine will not constrain the text, so long hug text can overflow a narrow frame. If text wraps when it should not, its width sizing is fill (or fixed) and should be hug. If text overflows and should wrap, its width sizing is hug and should be fill.

For auto layout sizing behavior in general, see `reference/frames`. For blueprint authoring syntax (how sizing is expressed in the DSL), see the blueprint knowledge files.
