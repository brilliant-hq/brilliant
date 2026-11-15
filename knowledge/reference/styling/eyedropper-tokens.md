---
name: "knowledge-styling-eyedropper-tokens"
description: "Named colors, the eyedropper, token-preserving picks, and color and opacity token bindings."
assumes: reference/styling
---

# Named Colors, Eyedropper and Token Bindings

**Named colors** (e.g., `coral`, `navy`) are supported when entering colors via AI commands or the palette, not as a color picker format.

## Named Colors (42)

red, green, blue, yellow, orange, purple, pink, cyan, magenta, white, black, gray, grey, navy, teal, maroon, olive, lime, aqua, coral, salmon, turquoise, indigo, violet, gold, silver, brown, beige, tan, crimson, lavender, plum, orchid, khaki, azure, ivory, mint, peach, rose, charcoal, slate, transparent

## Eyedropper (Ctrl+Shift+C, Alt+Shift+C on Windows)

Shortcut is **Ctrl+Shift+C** on macOS and Linux (uses the Control key, not the Command key, even on macOS), remapped to **Alt+Shift+C on Windows**. Sample a color from anywhere on screen. A magnified pixel grid appears around the cursor. Click to apply, Escape to cancel. Sampling uses the system screen capture pipeline, so it works across other applications. The button on the left of the hue and opacity tracks toggles the same mode from inside the color picker.

**Picking onto a gradient**: a pick recolors one stop, it never flattens the gradient. If a stop is focused (click it in the stop bar first) that stop takes the color; otherwise the first stop does. The stop keeps its own opacity. To turn a gradient into a flat color, use the solid paint type instead.

**Token-preserving picks**: when the sampled pixel comes from a token-bound solid fill, the pick applies that design token (not the raw hex), resolved under the source element's active modes and brand. Even without a bound source, a sampled color that equals a design token's current resolved color (within a tiny per-channel tolerance) binds that token; a genuinely non-token color applies as plain hex. The same matching runs when you commit a color from the picker's wheel or type a hex/CSS value: land exactly on a token's color and the token binds instead of a raw value. Matching never happens mid-drag, only at commit.

## Token Bindings

A solid color can carry two independent token bindings:

- **Color token** (e.g. `brand.50`): chosen in the Library tab (or from the hex value's dropdown). Resolves to the actual color at render time, so it follows mode/theme switches. While a color is bound, the value field shows the token as a pill (a purple diamond and its name), the resolved hex beside it (read-only), the opacity, and a **detach** button (the broken link): detach keeps the color but drops the token, in one undo step. Clicking the pill opens the Library tab.
- **Opacity token** (e.g. `visibility.firm`): chosen from the opacity cell's dropdown (hover the "100%" and click the chevron) when the design system has opacity tokens. A bound opacity shows as a pill with the token's name and value, e.g. "firm · 60%"; clicking it lists the opacity tokens to switch to another.

Both can be set at once. Dragging the opacity slider clears the opacity token binding; dragging the color field or the hue slider clears the color token binding.

**Per-stop token bindings.** Gradient stops, shader colors, and image-filter colors each carry their own color and opacity token. Editing a stop's hex field, picking a token from the stop's dropdown, or typing a token name in the hex field binds that stop only. Switching between Linear / Radial / Angular preserves per-stop bindings; converting a solid to a gradient seeds both new stops with the solid's token, if any. A purple diamond badge marks a field that has a token binding. For how tokens are authored, see the design-systems knowledge files.
