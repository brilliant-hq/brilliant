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

Open by clicking any color swatch in the right toolbar. There is no global keybinding to open the picker. The picker opens on the swatch you click, focused on that fill / stroke / effect / text-range / layout-grid.

Components (top to bottom):
1. **Color rectangle** (280x280) for solid / gradient / shader modes. X = saturation, Y = brightness. Drag the crosshair. In image mode this slot is replaced by the Image Manager (preview + select / drop / paste, accepts image files or URLs).
2. **Eyedropper button + Hue slider** (width 280). Eyedropper toggle on the left, horizontal 360-degree hue strip on the right.
3. **Opacity slider** (width 280). Alpha 0%-100% for the focused color.
4. **Gradient bar** (width 280). Only in gradient mode. Click empty space to add a stop, click an existing stop to focus it, drag to reposition, Delete / Backspace removes the focused stop (minimum 2 stops).
5. **Format inputs** row. Format dropdown (Hex / RGB / HSB / CSS) + value fields + copy button. The format dropdown has hover-preview (hovering a format previews the value display before clicking).
6. **Design Tokens** section, then **Canvas Colors**, then a divider, then **Recent Colors** (always present regardless of fill type, including image mode).

In shader mode, the rectangle/hue/opacity controls edit one shader-color slot at a time. To pick which slot, click the individual color swatches in the right toolbar's expanded shader fill row before opening the picker.

The picker has no separate Solid / Gradient / Image / Shader tabs. Fill type is selected from the type dropdown on the fill row in the right toolbar (not in the picker). The picker reflows its top section based on the current fill type.

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

Command id: `toggle_color_pick_mode`. Shortcut is **Ctrl+Shift+C on all platforms** (uses the Control key, not the Command key, even on macOS). Sample a color from anywhere on screen. A magnified pixel grid appears around the cursor. Click to apply, Escape to cancel. Sampling uses the system screen capture pipeline, so it works across other applications. The button on the left of the hue slider toggles the same mode from inside the color picker.

### Color Picker Sections

The color picker includes additional sections below the main controls:

- **Design Tokens**: Color tokens from the active design system (`.styles` file). Grouped by category (brand, neutral, success, etc.). Click a swatch to apply a token-bound color. Tokens stay bound through theme/mode switches.
- **Canvas Colors**: Unique colors used by elements on the active canvas, collected automatically. Sorted solids first then gradients, then by hue.
- **Recent Colors**: Recently used colors across sessions. Hover a swatch to see its value in the active format.

In contexts that only support solid colors (canvas background, layout grid color, effect color, text-range color, AI-input callback editing), gradients and shader fills are filtered out of all three sections.

### Token Bindings

A solid `PaintStyle` has two independent token bindings (stored on `SolidData`):

- **Color token** (e.g. `brand.50`): chosen via the design tokens section or the hex field's token dropdown. Resolves to the actual color at render time.
- **Opacity token** (e.g. `opacity.50`): chosen via the opacity field's token dropdown when the design system has opacity tokens.

Both can be set simultaneously. Manually dragging the opacity slider clears the opacity token binding; manually editing hex/RGB/HSB clears the color token binding.

**Per-stop token bindings.** Gradient stops, shader colors, and image-filter colors carry their own parallel `colorTokenRefs` / `colorOpacityTokenRefs` lists (one slot per color). Editing a stop's hex field, picking a token from the stop's dropdown, or typing a token name in the hex field writes to that stop's slot only. Changing fill type between gradient flavors (Linear / Radial / Angular) preserves per-stop bindings; converting solid -> gradient seeds both stops with the solid's token (if any).

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
2. Or change the fill type to Linear / Radial / Angular via the type dropdown on the fill row in the right toolbar
3. Click color stops to edit, add stops by clicking the gradient bar in the color picker, drag to reposition

Three gradient types are supported: **Linear**, **Radial** (elliptical), and **Angular** (sweep / conic). Diamond, mesh, and multi-axis conic gradients are NOT available. Select the gradient type from the fill type dropdown in the right toolbar's "Colors" group.

Gradient handles render on the canvas while the color picker is open for that element's fill or stroke.

**Linear gradients** are defined by start/end points: edit on canvas by dragging the gradient handles (start handle, end handle), or click the gradient line to add a color stop.

**Radial gradients** are defined by center, radius, and width handles: drag the center to reposition, drag the radius handle to resize and rotate, drag the width handle to make the gradient elliptical.

**Angular gradients** (sweep/conic) rotate color stops around a center point: drag the center to reposition, drag the angle handle to rotate the gradient start direction. The angular sweep covers a full 360 degrees with wrap-around interpolation across the seam.

Add / remove / reposition color stops directly on the gradient bar in the color picker, or by clicking the canvas gradient line. Hovering a stop shows the position percentage and color hex, dragging shows just the percentage.

Each gradient stop has its own row in the right toolbar with a hex field, opacity field, and position field. The hex field accepts both hex literals and design token names (e.g. `brand.50`); typing a token name binds that token to the stop only. A purple diamond badge on the hex or opacity field indicates a token binding on that stop.

### Image Fills

Import an image via Cmd+Shift+O (Import), drag-and-drop from the OS file manager, or paste from clipboard. The image becomes a rectangle with an image fill.

**Image Manager:** Click an image fill's color swatch in the right toolbar to open the color picker in image mode. The color picker replaces its color controls with an image preview and replacement UI. From there you can:
- **Select** a new image file from disk
- **Drop** an image file from the OS file manager onto the image area
- **Paste** an image or image URL with Cmd+V (works with screenshots, browser copies, Finder-copied files, and pasted URLs)

The design tokens, canvas colors, and recent colors sections remain visible below the image area. A replace button is also available in the expanded image fill config row.

**Supported formats:** PNG, JPG / JPEG, GIF, BMP, WebP on all platforms. TIFF / TIF, HEIC / HEIF, and AVIF are additionally supported on macOS (converted to PNG via native NSImage decoding). On Windows / Linux those macOS-only formats are excluded from file pickers and drop targets.

**Image Scale Modes:**

| Mode | Description |
|------|-------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved |
| **Crop** | Custom positioning with interactive crop editor (see [CROP.md](./CROP.md)) |
| **Repeat** | Image tiles at natural pixel size relative to the element |

Change the scale mode in the right toolbar under the image fill section.

### Shader Fills

Animated, GPU-rendered procedural patterns. 6 shader types total:

- **Animated group** (5): Metaballs, Liquid Metal, Iridescent (internal name `PaintStyleType.holographic`), Liquid Stainless Steel, Dithering
- **Interactive group** (1): Reactive Grid (cursor-reactive)

See [shaders.md](./shaders.md) for full parameter reference.

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

Non-destructive photo-style adjustments (exposure, contrast, saturation, whites, blacks, clarity, sharpness, vignette, hue, temperature, tint, vibrance, brilliance, highlights, shadows, sepia, inversion). Processes all fills below it in the z-order. Includes built-in presets (Vivid, Cinematic, Vintage, B&W, etc.). Available in the **Filters** category alongside image filters. Data is stored as -1.0..1.0 (or 0..1, or 0..360 for hue) and the inspector displays it as percentages. Hue-rotate and saturate adjustments live here, not as element-level CSS-style filters. See [effects.md](./effects.md#color-adjust-fill) for the full parameter table.

### Multiple Fills

Stack multiple fills on a single element. Rendered bottom-to-top in list order. Reorder fills by dragging them in the right toolbar.

### Vector Region Fills

Vector elements with multiple enclosed regions (e.g. a path that crosses itself, or an outlined-and-flattened text glyph with counters) can be colored per region. Click a region while in vector edit mode to focus its fill, then change color in the picker. Each region keeps its own fill independently of the element's main fills list.

### Text Fills

Text uses fills for text color. Text supports all fill types: solid, gradient, image, shader, image filters, and color adjust: rendered through the text glyphs. Text also supports strokes (including shader and filter strokes), rendered around the text glyphs with inside/center/outside positioning.

Per-character color is supported via styled ranges: enter edit mode, select a character range, and apply a color. The range's color overrides the element-level fill color for those characters. See [text.md](./text.md) for the full set of per-range overrides.

## Strokes

### Adding and Removing Strokes

| Action | How |
|--------|-----|
| Add a stroke | Shift+S or click "+" in Strokes section |
| Remove a stroke | Alt+S or click delete button |
| Swap fill and stroke | Shift+X |

### Stroke Properties

**Position** (`StrokePosition` enum, default Center):

| Position | Description |
|----------|-------------|
| Inside | Drawn inside the element edge |
| Center | Centered on the element edge (default) |
| Outside | Drawn outside the element edge |

**Thickness:** Adjust via right toolbar, size level shortcuts 0-9 (`set_size_level_0` ... `set_size_level_9`, plain digit keys), Shift+= to increase, `-` to decrease.

**Dash pattern:** The `Stroke` data model has no dash pattern fields. Dashed strokes are not first-class on element strokes; the only dashed rendering in Brilliant is for UI overlays (selection, snap guides). SVG / Sketch import preserves dashPattern in serialization but it is not editable in the inspector.

**Caps** are NOT a property of `Stroke`. They live on the geometry:
- **Vector paths:** per-node `cap` field on leaf nodes (degree 1 endpoints). Values from `StrokeCap2` enum: `none` (butt), `round` (default), `square`, `arrow`, `circle` (filled dot marker, radius approx. thickness).
- **Circles:** `startCap` and `endCap` on `CircleData` (default `round`). Cap controls appear in the stroke section of the inspector only when the circle's arc sweep is less than 100% (any arc, including ring sectors).
- **Rectangles** and other closed shapes have no caps.

**Join:** The `Stroke` model has no `strokeJoin` / miter / bevel field. Joins are not user-configurable; the renderer uses Flutter's default join behavior.

**Fields on `Stroke`:** `id`, `thickness` (TokenizedDouble, supports design tokens), `style` (PaintStyle), `position` (StrokePosition), `blendMode` (default `srcOver`). No cap, join, or dash fields.

### Stroke Style Types

Strokes support the same `PaintStyleType` set as fills (one unified dropdown is reused, command id `change_shader_effect_type`). Dropdown groups in order: **Colors** (Solid, Linear, Radial, Angular), **Static** (Image, Inner Shadow, Inner Glow, Background Blur), **Animated** (Metaballs, Liquid Metal, Iridescent, Liquid Stainless Steel, Dithering), **Interactive** (Reactive Grid), **Filters** (Color Adjust, Noise / Grain, Halftone, Pixelate, Duotone, Posterize, Dither). Total 21 `PaintStyleType` values. Inner Shadow / Inner Glow as strokes render the inner-shadow/glow primitive over the stroke band, not over the element interior. Background Blur as a stroke produces a frosted-glass band along the stroke path.

Text ranges only support Solid.

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

1. **Top/Bottom mode** (first button): Two fields: one for top corners (TL + TR), one for bottom corners (BL + BR).
2. **Individual mode** (second button): Four fields in a 2x2 grid: top-left, top-right, bottom-left, bottom-right.

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

Effects add shadows, glows, blurs, and texture. Brilliant has two parallel systems:

### Outer Effects (Effects Section)

Live in `element.effects` (a separate list from fills). Managed in the Effects section of the right toolbar, or add via the command palette (Cmd+Shift+P): "Add Drop Shadow", "Add Outer Glow", "Add Element Blur". Compact blueprint tokens: `shadow(...)`, `outerglow(...)`, `eblur(...)`.

| EffectType | Description |
|------------|-------------|
| `dropShadow` | Shadow behind the element |
| `outerGlow` | Luminous glow around the element |
| `layerBlur` (UI label "Element Blur") | Blurs the element itself |

### Inner/Fill Effects (Fills Section)

Live in the `fills` list as `PaintStyleType` values, giving full z-order control alongside solid/gradient/image/shader fills. Added as fills, not effects.

| PaintStyleType | Description |
|----------------|-------------|
| `innerShadow` | Shadow inside the element edges |
| `innerGlow` | Luminous glow inside the element edges |
| `backgroundBlur` | Blurs content behind the element (frosted glass), rendered at the widget level via BackdropFilter |

Inner effects are in the fill type dropdown under the **Static** group (alongside Image). Inner effect fills can be interleaved with other fill types.

See [effects.md](./effects.md) for default values, parameter ranges, blueprint syntax, and shadow tokens.
