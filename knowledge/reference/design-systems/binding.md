---
name: "knowledge-design-systems-binding"
description: "Binding tokens to properties in the inspector, applying composite tokens, and unbinding tokens."
assumes: reference/design-systems
---

# Binding Tokens

## Binding Tokens to Properties

Most numeric and color properties in the inspector accept a token binding. When a property is bound, its field shows the token name instead of a raw value. Manually typing a value into a bound field clears the binding for that property, and so does a bare value on a Blueprint modify line (`o(1)` on an element bound as `o(1:$platform.mac)` unbinds it; the tagged `o(1:$platform.mac)` keeps the binding). A color token whose value carries alpha (`#FFFFFF00`) owns the alpha of the fills and strokes bound to it; an opaque token leaves them their own opacity.

To bind a numeric or font field (radius, opacity, gap/padding, stroke width, font size/weight/line height/family), open the field's dropdown (the chevron next to the value): the menu lists the matching token type alongside the plain preset values, and picking a token replaces the literal with the token name. Bound fields are marked with a purple chevron and diamond indicator (the color picker's Library tab does the same for colors).

Where you bind in the UI:

| Property | Where in the inspector | Token type |
|----------|------------------------|------------|
| Fill / stroke color | Color picker, Library tab | Color tokens |
| Fill / stroke opacity | Color picker, the opacity cell's dropdown in the value field (a bound opacity shows as a pill, e.g. "firm · 60%") | Opacity (visibility) tokens |
| Corner radius (per corner) | Right toolbar, radius fields | Radius tokens |
| Element opacity | Right toolbar, opacity field | Opacity tokens |
| Font size, weight, line height | Right toolbar, typography fields | Font tokens |
| Font family | Right toolbar, font picker | Font family token |
| Auto layout gap and padding | Right toolbar, auto layout fields | Spacing tokens |
| Stroke width | Right toolbar, stroke fields | Stroke width tokens |

The color picker's **Library** tab lists the system's color tokens: a search field, the pinned tokens (the `pin:` list, in order, or the `color.*` roles when nothing is pinned), one nine-step scale per pinned palette, then every color token by group. Hidden palettes (`hide:`) stay out of the list until you choose **Search all colors**. The swatches resolve through the canvas's active modes, so themed colors reflect the current theme. **+ New token** saves the current color as a token: it adds one line to the design system file for the canvas's folder (comments and everything else in the file stay as they were), can bind the color to it, and undoes in one step. A project without a design system gets one from the same tab. Token-bound colors work in every color slot: solid fills, gradient stops, shader colors, effect colors (drop shadow, outer glow, inner shadow, inner glow), image-filter colors (duotone, halftone), layout grid colors, and per-range text colors.

Composite tokens are applied via commands, not inline fields:

- **Apply Typography Token**: applies a `typography.*` composite to the selected text element(s). The text stays bound: a token edit, a brand switch or a mode switch re-applies the composite's size, weight, family, line height and letter spacing. Changing one of those by hand on the text detaches it from the composite.
- **Apply Shadow Token**: applies a `shadow.*` composite to the selected element(s).

These two commands need a token to apply, so they run only with a token argument (via `execute_commands`, `{value: "typography.h1"}`); picking them bare from the palette does nothing but say so. A refused apply is never silent: if no text (or element) is selected, the named key is not a token in the active design system, or the key names a token of the wrong kind (a color where a typography token was asked for), a warning names the token and the reason. An unsupported record property in a `typography.*` definition (for example `textTransform`, which Brilliant's typography tokens do not carry) does not drop the token: the token still applies from its supported keys, and the design-system diagnostics name the ignored property.

## Unbinding Tokens

The **Unbind Tokens** command takes the current selection (and its descendants), replaces every token binding with the literal value it currently renders as, and drops the per-element design-system assignment. The result looks identical but no longer tracks the design system. Use it to "freeze" a subtree. Undoable.

## Binding Literals to Tokens (agents)

To move existing literals onto the design system (after switching a canvas to one, or cleaning up an import), call `execute_commands` with `bind_tokens`: `{"commandId": "bind_tokens", "ids": [...]}` scopes the pass to those elements and their descendants; no `ids` covers the whole canvas. Add `"params": {"dryRun": true}` to get the report without changing anything. Each literal fill, stroke, stroke width, radius, opacity, font size, line height, letter spacing, gap, padding, effect color and grid color binds to the token of the element's design system that resolves to exactly that value; nothing changes visually. When several tokens share the value, the slot's role decides (a text fill takes `color.text.*`/`color.on-*`, other fills a surface role, a stroke `color.outline*`; `color.*` roles beat palette stops); a remaining tie stays literal. Already-bound values are untouched. One undo step. The reply counts what bound per slot and token, lists the values left literal (by value, with counts) and the ambiguous values with their candidate tokens: add tokens for the literals worth keeping, or bind an ambiguous one by hand.
