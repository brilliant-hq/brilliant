---
name: "knowledge-styling"
description: "Colors, fills, strokes, opacity, and corner radius in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Styling

## Colors

### Quick Color Shortcuts

| Color | Shortcut |
|-------|----------|
| Red | Ctrl+R |
| Green | Ctrl+G |
| Blue | Ctrl+B |
| Yellow | Ctrl+Y |
| Orange | Ctrl+O |
| Purple | Ctrl+P |
| White | Ctrl+W |
| Black | Ctrl+K |
| Dark gradient | Ctrl+D |
| Light gradient | Ctrl+L |

### Color Picker

Open by clicking any color swatch in the right toolbar, or press **Ctrl+C**.

Components (top to bottom):
1. **Color rectangle** (280x280) — X = saturation, Y = brightness. Drag the crosshair.
2. **Eyedropper button + Hue slider** — Eyedropper toggle on the left, horizontal 360-degree hue strip on the right.
3. **Opacity slider** — Alpha channel (0%–100%) for the focused fill or stroke.
4. **Gradient bar** — Only shown in gradient mode. Click empty space to add a stop, click an existing stop to focus it, drag to reposition, Delete/Backspace to remove the focused stop (minimum 2 stops).
5. **Format inputs** — Format dropdown (Hex/RGB/HSB/CSS) + value fields + opacity field + copy button.

When a fill is an image, the top section is replaced by an Image Manager (preview + replace UI). When a fill is a shader, you click the individual shader-color swatches in the right toolbar's expanded fill row to focus a specific color, then edit it in the picker. The bottom sections (Design Tokens, Canvas, Recent) remain visible in all modes.

### Color Formats

The color picker includes a format dropdown with these options:

| Format | Example | Description |
|--------|---------|-------------|
| Hex | `FF5733` | 6-digit uppercase hex (no `#` prefix in the input field). Token-aware: shows the bound color token name and a swatch when applicable. |
| RGB | `R 255  G 87  B 51` | Red, green, blue (0–255). Each field is draggable. |
| HSB | `H 14  S 80  B 100` | Hue (0–360°), saturation (0–100%), brightness (0–100%). Draggable. |
| CSS | `rgba(255, 255, 255, 1)` | CSS rgba or hex notation. Submit-only (Enter to apply). |

OKLCH and HSL formats are not exposed in the picker. Color tokens (e.g. `brand.50`) are stored in OKLCH internally and resolved at render time, but the picker UI displays the resolved sRGB value in the selected format.

**Named colors** (e.g., `coral`, `navy`) are supported when entering colors via AI commands or the command palette, not as a color picker format.

### Named Colors (42)

red, green, blue, yellow, orange, purple, pink, cyan, magenta, white, black, gray, grey, navy, teal, maroon, olive, lime, aqua, coral, salmon, turquoise, indigo, violet, gold, silver, brown, beige, tan, crimson, lavender, plum, orchid, khaki, azure, ivory, mint, peach, rose, charcoal, slate, transparent

### Eyedropper (Ctrl+Shift+C)

Sample a color from anywhere on screen. A magnified 21x21 pixel grid appears around your cursor. Click to apply the sampled color, Escape to cancel. Sampling captures the entire screen via the system screen capture pipeline, so it works across other applications.

### Color Picker Sections

The color picker includes additional sections below the main controls:

- **Design Tokens** — Color tokens from the active design system (`.styles` file). Grouped by category (brand, neutral, success, etc.). Click a swatch to apply a token-bound color. Tokens stay bound through theme/mode switches.
- **Canvas Colors** — Unique colors used by elements on the active canvas, collected automatically. Sorted solids first then gradients, then by hue.
- **Recent Colors** — Up to 24 recently used colors across sessions. Hover a swatch to see its value in the active format.

In contexts that only support solid colors (canvas background, layout grid color, effect color, callback hex editing, text-range color), gradients and shader fills are filtered out of all three sections.

### Token Bindings

A `PaintStyle` has two independent token bindings:

- **Color token** (e.g. `brand.50`) — chosen via the design tokens section or the hex field's token dropdown. Resolves to the actual color at render time.
- **Opacity token** (e.g. `opacity.50`) — chosen via the opacity field's token dropdown when the design system has opacity tokens.

You can bind both at once. Manually dragging the opacity slider clears the opacity token binding; manually editing hex/RGB/HSB clears the color token binding.

## Fills

### Adding and Removing Fills

| Action | How |
|--------|-----|
| Add a fill | Shift+F or click "+" in Fills section |
| Remove a fill | Alt+F or click delete button |

### Solid Color Fills

Click the fill color swatch in the right toolbar to open the color picker. Use Ctrl+R/G/B/Y/O/P/W/K for quick colors.

### Gradient Fills

1. Press **Ctrl+D** (dark gradient) or **Ctrl+L** (light gradient) for quick gradients
2. Or change the fill type to Linear/Radial/Angular via the type dropdown on the fill row in the right toolbar
3. Click color stops to edit, add stops by clicking the gradient bar in the color picker, drag to reposition

**Linear**, **radial** (elliptical), and **angular** (sweep/conic) gradients are supported. Diamond, conic-with-multi-axis, and mesh gradients are not available. Select the gradient type from the fill type dropdown in the right toolbar.

Gradient handles are only visible on the canvas while the color picker is open for that element's fill or stroke. They disappear when the picker closes.

**Linear gradients** are defined by start/end points — edit on canvas by dragging the gradient handles (start handle, end handle), or click the gradient line to add a color stop.

**Radial gradients** are defined by center, radius, and width handles — drag the center to reposition, drag the radius handle to resize and rotate, drag the width handle to make the gradient elliptical.

**Angular gradients** (sweep/conic) rotate color stops around a center point — drag the center to reposition, drag the angle handle to rotate the gradient start direction. The angular sweep covers a full 360° with wrap-around interpolation across the seam.

Add/remove/reposition color stops directly on the gradient bar in the color picker, or by clicking the canvas gradient line. Hovering a stop shows the position percentage and color hex; dragging shows just the percentage.

### Image Fills

Import an image via Cmd+Shift+O (Import), drag-and-drop from Finder, or paste from clipboard. The image becomes a rectangle with an image fill.

**Image Manager:** Click an image fill's color swatch in the right toolbar to open the color picker in image mode. The color picker replaces its color controls with an image preview and replacement UI. From there you can:
- **Select** a new image file from disk
- **Drop** an image file from Finder onto the image area
- **Paste** an image with Cmd+V (works with screenshots, browser copies, and Finder-copied files)

The design tokens, canvas colors, and recent colors sections remain visible below the image area. A replace button is also available in the expanded image fill config row.

**Supported formats:** PNG, JPG, GIF, BMP, WebP on all platforms. TIFF, HEIC, and AVIF are additionally supported on macOS (converted to PNG via native decoding). On Windows/Linux these formats are excluded from file pickers and drop targets.

**Image Scale Modes:**

| Mode | Description |
|------|-------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved |
| **Crop** | Custom positioning with interactive crop editor (see [CROP.md](./CROP.md)) |
| **Repeat** | Image tiles at natural pixel size relative to the element |

Change the scale mode in the right toolbar under the image fill section.

### Shader Fills

Animated, GPU-rendered procedural patterns. Choose from 6 shader types. See `SHADERS.md` for details.

### Image Filter Fills

GPU-powered post-processing filters applied to all fills below them in the z-order. Available in the **Filters** category of the fill type dropdown:

| Filter | Description |
|--------|-------------|
| **Noise / Grain** | Film-like grain overlay (monochrome/color, uniform/gaussian distribution, roughness and midtone bias) |
| **Halftone** | Classic print halftone dots (standard + CMYK mode, circle/diamond/line shapes, square/hex grid, softness control) |
| **Pixelate** | Mosaic pixelation (square/hexagonal/diamond/circle/triangle shapes) |
| **Duotone** | Two-tone or tri-tone color mapping with gamma/midpoint control |
| **Posterize** | Reduce color levels for poster-style banding (RGB/luminosity/HSL modes) |
| **Dither** | Ordered dithering patterns (Bayer/noise/blue noise, 2x2/4x4/8x8 matrix sizes) |

Each filter has adjustable parameters, optional color inputs, and built-in presets. Filters work on fills, strokes, text, and vector regions. See [IMAGE_FILTERS.md](./IMAGE_FILTERS.md) for detailed per-filter parameter reference.

### Color Adjust Fills

Non-destructive photo-style adjustments (exposure, contrast, saturation, whites, blacks, clarity, sharpness, vignette, hue, temperature, tint, and more). Processes all fills below it in the z-order. Includes built-in presets (Vivid, Cinematic, Vintage, B&W, etc.). Available in the **Filters** category alongside image filters. Hue-rotate and saturate adjustments live here, not as element-level CSS-style filters. See `EFFECTS.md` for details.

### Multiple Fills

Stack multiple fills on a single element. Rendered bottom-to-top in list order. Reorder fills by dragging them in the right toolbar.

### Vector Region Fills

Vector elements with multiple enclosed regions (e.g. a path that crosses itself, or an outlined-and-flattened text glyph with counters) can be colored per region. Click a region while in vector edit mode to focus its fill, then change color in the picker. Each region keeps its own fill independently of the element's main fills list.

### Text Fills

Text uses fills for text color. Text supports all fill types — solid, gradient, image, shader, image filters, and color adjust — rendered through the text glyphs. Text also supports strokes (including shader and filter strokes), rendered around the text glyphs with inside/center/outside positioning.

Per-character color is supported via styled ranges: enter edit mode, select a character range, and apply a color. The range's color overrides the element-level fill color for those characters. See [text.md](./text.md) for the full set of per-range overrides.

## Strokes

### Adding and Removing Strokes

| Action | How |
|--------|-----|
| Add a stroke | Shift+S or click "+" in Strokes section |
| Remove a stroke | Alt+S or click delete button |
| Swap fill and stroke | Shift+X |

### Stroke Properties

**Position:**

| Position | Description |
|----------|-------------|
| Inside | Drawn inside the element edge |
| Center | Centered on the element edge (default) |
| Outside | Drawn outside the element edge |

**Thickness:** Adjust via right toolbar, size level shortcuts (0–9), Shift+= to increase, or - to decrease.

**Caps (Lines/Arrows/Arcs):** None, Round, Square, Arrow. Caps are per-endpoint (per-node on vector paths, per-arc-endpoint on circles). Only leaf nodes (path endpoints with degree 1) render caps. For circles, caps appear when sweep < 100% (any arc, including ring sectors).

### Stroke Style Types

Strokes support the same style types as fills:

| Type | Description |
|------|-------------|
| **Solid** | Single color (default) |
| **Linear** | Linear gradient along the stroke |
| **Radial** | Radial (elliptical) gradient on the stroke |
| **Angular** | Angular (sweep) gradient on the stroke |
| **Image** | Image pattern rendered on the stroke |
| **Shader** | Animated procedural pattern (metaballs, liquid metal, iridescent, liquid stainless steel, dithering, reactive grid) |
| **Image Filter** | GPU post-processing (noise/grain, halftone, pixelate, duotone, posterize, dither) |
| **Color Adjust** | Non-destructive photo-style adjustments |
| **Background Blur** | Blurs content behind the stroke area (frosted glass) |
| **Inner Shadow / Inner Glow** | Effect paint styles rendered on the stroke |

Switch the stroke type using the type dropdown on any stroke row in the right toolbar.

### Multiple Strokes

Add multiple strokes with independent style, thickness, and position. Reorder strokes by dragging them in the right toolbar.

### Stroke on New Shapes

Use **Shift+R** or **Shift+O** for stroke-only shapes. When a shape tool (rectangle/circle) is active, the right toolbar shows creation style checkboxes in the Fills and Strokes section headers to toggle whether new shapes include fill and/or stroke.

## Blend Mode

Blend modes control how elements, fills, strokes, and effects composite against content below them. Available at four independent levels:

| Level | Where | Default |
|-------|-------|---------|
| **Element** | Right toolbar, Element section ("more" expandable subsection) | Normal |
| **Fill** | Right toolbar, per-fill row (expanded config) | Normal |
| **Stroke** | Right toolbar, per-stroke row (expanded config) | Normal |
| **Effect** | Right toolbar, per-effect row (expanded config) | Normal (Screen for glow) |

**16 blend modes:** Normal, Darken, Multiply, Color Burn, Lighten, Screen, Color Dodge, Overlay, Soft Light, Hard Light, Difference, Exclusion, Hue, Saturation, Color, Luminosity.

**Element-level** wraps the entire element (fills + strokes + effects) as a unit, then blends against the canvas. **Fill/stroke-level** blends each individual fill or stroke independently.

Blend modes are preserved across copy/paste, undo/redo, and all export formats (PNG, SVG, PDF).

## Opacity

### Shortcuts

| Action | Shortcut |
|--------|----------|
| 0%–90% transparency | Cmd+Shift+0 through 9 |
| Increase transparency | Cmd+Shift+= |
| Decrease transparency | Cmd+Shift+- |

### UI

**Element-level opacity** is in the Element section of the right toolbar, on the same row as the rotation field. Drag or type a percentage (0%–100%).

**Fill/stroke opacity** is controlled by the opacity slider in the color picker (affects the alpha of the focused fill or stroke color).

## Corner Radius

### Uniform Radius

| Action | Shortcut |
|--------|----------|
| Radius level 0–9 | Cmd+Alt+0 through Cmd+Alt+9 |
| Increase radius | Cmd+Alt+Shift+= |
| Decrease radius | Cmd+Alt+- |

### Per-Corner Radius

The corner radius row has two toggle buttons for expanding into per-corner editing:

1. **Top/Bottom mode** (first button) — Two fields: one for top corners (TL + TR), one for bottom corners (BL + BR).
2. **Individual mode** (second button) — Four fields in a 2x2 grid: top-left, top-right, bottom-left, bottom-right.

### Parent Corner Radius

All parent types support corner radius. With `clipContent` enabled (disabled by default for all parent types), children are clipped to the rounded bounds.

## Circle Arc & Ratio

Circle elements have additional properties for creating arcs, pie sectors, and donut/ring shapes. Edit them in the right toolbar or use the interactive drag handles (see [TOOLS.md](./TOOLS.md#arc-drag-handles)).

| Property | Range | Description |
|----------|-------|-------------|
| **Sweep** | 0–100% | How much of the circle to fill. 100% = full circle |
| **Start** | 0–360° | Where the arc begins. 0° = 3 o'clock (right), counter-clockwise (90° = top) |
| **Ratio** | 0–1 | Inner radius fraction. 0 = solid, >0 = donut/ring |

**Stroke caps on arcs:** When sweep < 100% (any arc, including ring sectors), start/end cap controls appear in the stroke section. Use round caps for progress rings, arrow caps for directional arcs.

**Common combinations:**
- **Progress ring:** stroke-only circle + `arc(90, 75) ratio(1)` + round caps for 75% completion (90° = top)
- **Pie sector:** filled circle + `arc(90, 25)` for a 25% wedge starting at top
- **Donut chart:** filled circle + `arc(90, 50)` + `ratio(0.5)` for a half-ring
- **Full donut:** filled circle + `ratio(0.6)` (no arc needed)

See [DATA_VISUALIZATION.md](../building/DATA_VISUALIZATION.md#circular-progress-ring) for detailed examples and multi-ring dashboard patterns.

## Effects

Effects add visual enhancements like shadows, glows, blurs, and texture. Brilliant has two effect systems:

### Outer Effects (Effects Section)

Render outside or around elements. Managed in the Effects section of the right toolbar, or add via the **command palette** (Cmd+Shift+P) by searching for "Add Drop Shadow", "Add Outer Glow", or "Add Element Blur". Effects can also be specified in blueprint syntax (see [EFFECTS.md](./EFFECTS.md) for the compact format).

| Type | Description |
|------|-------------|
| Drop Shadow | Shadow behind the element |
| Outer Glow | Luminous glow around the element |
| Element Blur | Blurs the element itself |

### Inner/Fill Effects (Fills Section)

Render within element bounds. Added as fills for full z-order control:

| Type | Description |
|------|-------------|
| Inner Shadow | Shadow inside the element edges |
| Inner Glow | Luminous glow inside the element edges |
| Background Blur | Blurs content behind the element (frosted glass) |

Inner effects are in the fill type dropdown under the **Static** group (alongside Image). The full dropdown groups are: **Colors** (Solid, Linear, Radial, Angular), **Static** (Image, Inner Shadow, Inner Glow, Background Blur), **Animated** (shader fills), **Interactive** (shader fills), **Filters** (Color Adjust + 6 image filters). Inner effect fills can be interleaved with other fill types.

### Key Properties

**Drop Shadow:** X/Y offset, blur, spread, color, opacity, blend mode. "Show behind transparent areas" toggle.

**Outer Glow:** Blur, spread, color, opacity, blend mode (default: Screen).

**Element Blur:** Radius (0-200).

**Inner Shadow:** X/Y offset, blur, spread, color, opacity, blend mode.

**Inner Glow:** Blur, spread, color, opacity, blend mode (default: Screen).

Each effect row has: type dropdown (with color swatch prefix for non-blur effects), opacity field, expand toggle, and remove button. Expanding reveals the full property fields.

| Action | How |
|--------|-----|
| Add outer effect | Command palette: "Add Drop Shadow" / "Add Outer Glow" / "Add Element Blur", or click "+" in Effects section |
| Add inner effect | Command palette: "Add Inner Shadow" / "Add Inner Glow" / "Add Background Blur", or click "+" in Fills section and choose from the type dropdown |
| Remove effect | Command palette: "Remove Effect", or click delete button on effect row |
| Toggle visibility | Command palette: "Toggle Effect Visibility", or click the eye icon (in expanded view) |

**Background Blur:** Radius (0-200).

Elements can have multiple effects stacked. Reorder by dragging. Render order: outer effects (drop shadows and outer glows in list order) → fills (solid, gradient, image, shaders, inner shadow, inner glow — all in z-order) → strokes.

### Shadow Tokens

Drop shadows can be bound to a composite shadow token from the design system (e.g. `shadow.sm`, `shadow.md`, `shadow.lg`). Applying a shadow token replaces the element's drop shadows with the token's shadow stack (a token can define multiple stacked drop shadows) and stores the token reference on the element. Other effect types (outer glow, element blur, inner shadow, inner glow, background blur) are preserved unchanged. Shadow tokens are useful for keeping a coherent shadow scale across components.

See `EFFECTS.md` for full details, default values, and tips.
