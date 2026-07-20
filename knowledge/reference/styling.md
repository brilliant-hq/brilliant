---
name: "knowledge-styling"
description: "Colors, fills, strokes, opacity, and corner radius in Brilliant."
---

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

Open by clicking any color swatch (the small **color rectangle** on the left of any fill / stroke / effect / text-range / layout-grid row) in the right toolbar. The picker opens anchored to the right, focused on that target. There is also a global toggle: **Ctrl+C** (remapped to **Alt+C on Windows**) opens / closes the color selector for the current selection's fill or stroke.

Components (top to bottom):
1. **Color rectangle** (280x280) for solid / gradient / shader modes. X = saturation, Y = brightness. Drag the crosshair. In image mode this slot is replaced by the Image Manager (preview + select / drop / paste, accepts image files or URLs).
2. **Eyedropper button + Hue slider** (width 280). Eyedropper toggle on the left, horizontal 360-degree hue strip on the right.
3. **Opacity slider** (width 280). Alpha 0%-100% for the focused color.
4. **Gradient bar** (width 280). Only in gradient mode. Click empty space to add a stop, click an existing stop to focus it, drag to reposition, Delete / Backspace removes the focused stop (minimum 2 stops).
5. **Format inputs** row. Format dropdown (Hex / RGB / HSB / CSS) + value fields + copy button. The format dropdown has hover-preview (hovering a format previews the value display before clicking).
6. **Swatch sections** at the bottom, always present regardless of fill type (including image mode), top to bottom: the design-token strip (a horizontal row of color-token group dropdowns, no text heading, shown only when the active design system has color tokens), then a section headed **Canvas**, then a divider, then a section headed **Recent**.

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

### Eyedropper (Ctrl+Shift+C, Alt+Shift+C on Windows)

Shortcut is **Ctrl+Shift+C** on macOS and Linux (uses the Control key, not the Command key, even on macOS), remapped to **Alt+Shift+C on Windows**. Sample a color from anywhere on screen. A magnified pixel grid appears around the cursor. Click to apply, Escape to cancel. Sampling uses the system screen capture pipeline, so it works across other applications. The button on the left of the hue slider toggles the same mode from inside the color picker.

### Color Picker Sections

The color picker includes additional sections below the main controls:

- **Design tokens** (no text heading in the panel): color tokens from the active design system, shown as a horizontal strip of per-group dropdowns. Grouped by category (brand, neutral, success, etc.). Click a token to apply a token-bound color. Tokens stay bound through theme/mode switches. Only shown when the active design system has color tokens. For how design systems and tokens are authored, see the design-systems knowledge files.
- **Canvas** (heading text: "Canvas"): unique colors used by elements on the active canvas, collected automatically. Sorted solids first then gradients, then by hue.
- **Recent** (heading text: "Recent"): recently used colors across sessions (up to 24). Hover a swatch to see its value in the active format.

In contexts that only support solid colors (canvas background, layout grid color, effect color, text-range color, AI-input callback editing), gradients and shader fills are filtered out of all three sections.

### Token Bindings

A solid color can carry two independent token bindings:

- **Color token** (e.g. `brand.50`): chosen via the design tokens section or by typing the token name in the hex field. Resolves to the actual color at render time, so it follows mode/theme switches.
- **Opacity token** (e.g. `opacity.50`): chosen via the opacity field's token dropdown when the design system has opacity tokens.

Both can be set at once. Manually dragging the opacity slider clears the opacity token binding; manually editing hex/RGB/HSB clears the color token binding.

**Per-stop token bindings.** Gradient stops, shader colors, and image-filter colors each carry their own color and opacity token. Editing a stop's hex field, picking a token from the stop's dropdown, or typing a token name in the hex field binds that stop only. Switching between Linear / Radial / Angular preserves per-stop bindings; converting a solid to a gradient seeds both new stops with the solid's token, if any. A purple diamond badge marks a field that has a token binding. For how tokens are authored, see the design-systems knowledge files.

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

**Resolution:** large, high-resolution source images (well beyond typical screen dimensions) render fine and stay clean at any zoom, the app downsamples them smoothly when zoomed out, so detailed images don't shimmer or alias.

**Image Scale Modes:**

| Mode | Description |
|------|-------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved |
| **Crop** | Custom positioning with interactive crop editor (see [crop.md](./crop.md)) |
| **Repeat** | Image tiles relative to the element. Tile size defaults to the image's natural pixel size |

Change the scale mode in the right toolbar under the image fill section. When Repeat is selected, a **Tile Scale** field appears beside the scale mode dropdown: percent of the image's natural size (1%–800%, default 100%), with 25 / 50 / 100 / 200 / 400 presets.

### Shader Fills

Animated, GPU-rendered procedural patterns. 6 shader types total:

- **Animated group** (5): Metaballs, Liquid Metal, Iridescent, Liquid Stainless Steel, Dithering
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

Each filter has adjustable parameters, optional color inputs, and built-in presets. Filters work on fills, strokes, text, and vector regions. See [image-filters.md](./image-filters.md) for detailed per-filter parameter reference.

### Color Adjust Fills

Non-destructive photo-style adjustments (exposure, contrast, saturation, whites, blacks, clarity, sharpness, vignette, hue, temperature, tint, vibrance, brilliance, highlights, shadows, sepia, inversion). Processes all fills below it in the z-order. Includes built-in presets (Vivid, Cinematic, Vintage, B&W, etc.). Available in the **Filters** category alongside image filters. The inspector shows each adjustment as a percentage. Hue-rotate and saturate adjustments live here, not as element-level CSS-style filters. See [effects.md](./effects.md#color-adjust-fill) for the full parameter table.

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

**Position** (default Center):

| Position | Description |
|----------|-------------|
| Inside | Drawn inside the element edge |
| Center | Centered on the element edge (default) |
| Outside | Drawn outside the element edge |

**Thickness:** Adjust via right toolbar, or use the number keys 0-9 to set the size level (Shift+= to increase, `-` to decrease). These size shortcuts are context-dependent: they set stroke width for shapes, but font size for text elements (or when the text tool is active).

**Per-side widths** (rectangles and frames): the width field sits at the bottom of the stroke configuration (below dash style and corner join) and shows the value shape: "4" when all sides match, "4, 8" when top/bottom and right/left pair up (first number is top/bottom, second is right/left), "1, 2, 3, 4" when all four differ (top, right, bottom, left). Type any of those shapes directly into the field: "6" sets all sides, "4, 8" sets the pairs, "1, 2, 3, 4" sets each side. The two buttons at the right of the row only change which editors are shown, never the stroke itself: the first opens a pairs editor (top/bottom + right/left), the second opens four per-side fields (T, R, B, L), each with the same preset dropdown as the main width field: pick a stroke-width token there to bind that side (or pair) to it, exactly like the uniform width. A side set to 0 draws no border on that side, so a single bottom border is 0, 0, 1, 0. Making all sides equal (in any editor) returns the stroke to a plain uniform width; if the equal sides share one token, the uniform width keeps that binding. On rounded corners each side's border continues through the whole corner arc, ending where the neighboring side's straight edge begins (adjacent sides share the corner arc), like Figma. Per-side borders have no corner-join concept, so the join control disappears while a stroke is per-side.

**Dash pattern:** solid / dashed / dotted presets with dash length, gap length, and dash cap fields in the expanded stroke row.

**Caps** are not a stroke property: they belong to the geometry, so they appear only for open shapes:
- **Vector paths:** each open endpoint (a path that does not close on itself) gets a cap. Options: None (butt), Round (default), Square, Arrow, Circle (filled dot marker). Set per endpoint.
- **Circles:** start cap and end cap (default Round). These controls appear in the stroke section only when the circle's arc sweep is less than 100% (any arc, including ring sectors).
- **Rectangles** and other closed shapes have no caps.

**Join:** miter / round (default) / bevel, set in the expanded stroke row.

**What a stroke holds:** thickness (supports design tokens), optional per-side weights (rect/frame), a paint style (its fill type), position (inside/center/outside), join, dash pattern + dash cap, and a blend mode. Endpoint caps do not live on the stroke (they belong to the geometry, below).

### Stroke Style Types

Strokes support the same fill-type set as fills (the same type dropdown is reused). Dropdown groups in order: **Colors** (Solid, Linear, Radial, Angular), **Static** (Image, Inner Shadow, Inner Glow, Background Blur, Liquid Glass), **Animated** (Metaballs, Liquid Metal, Iridescent, Liquid Stainless Steel, Dithering), **Interactive** (Reactive Grid), **Filters** (Color Adjust, Noise / Grain, Halftone, Pixelate, Duotone, Posterize, Dither). 22 types total. Inner Shadow / Inner Glow as a stroke render over the stroke band, not over the element interior. Background Blur as a stroke produces a frosted-glass band along the stroke path.

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

### Groups and frames: Pass through vs Normal

Containers (groups, frames, auto layout) work like Figma. Their blend dropdown has one extra entry, **Pass through**, and it is the default:

- **Pass through** (default): the container does not flatten. A child with Multiply blends against everything beneath the container, and container opacity fades the composited result without breaking that interaction.
- **Normal**: the container is isolated. Its own fill plus all children flatten into one layer first, then that layer composites once against the canvas. A Multiply child only sees content inside the container.
- **Any other mode** (Multiply, Screen, ...): also isolated. The flattened container blends with the backdrop using that mode.

In the Blueprint DSL, the bare `isolate` flag on a `fr`/`gr`/`al()` line sets Normal (isolated); `no-isolate` returns to Pass through. An explicit `blend(mode)` on a container isolates it implicitly, exactly like Figma.

Blend modes are preserved across copy/paste, undo/redo, and all export formats (PNG, SVG, PDF). Copy to Figma and Figma import both keep the Pass through / Normal / blend-mode state of every container.

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

All parent types support corner radius. With the **Clip content** toggle enabled (off by default for all parent types), children are clipped to the rounded bounds.

### Corner Smoothing (Squircle)

A **Smoothing** field (0–100%) rounds corners with a continuous curve instead of a plain circular arc, the squircle look of iOS app icons. It is behind a toggle button (app-icon glyph) that appears in the corner radius row, left of the top/bottom corners button, only when the radius is nonzero; toggling it reveals the smoothing field on its own row. The preset dropdown offers 0%, 30%, 50%, **iOS · 60%**, 80%, 100%. It applies to rectangles and frames, is a single value for all four corners, and has no effect at radius 0. Drag or type a percent to set it.

## Circle Arc & Ratio

Circle elements have additional properties for creating arcs, pie sectors, and donut/ring shapes. Edit them in the right toolbar or use the interactive drag handles (see [tools.md](./tools.md#arc-drag-handles)).

| Property | Range | Description |
|----------|-------|-------------|
| **Sweep** | 0–100% | How much of the circle to fill. 100% = full circle |
| **Start** | 0–360° | Where the arc begins. 0° = 3 o'clock (right), counter-clockwise (90° = top) |
| **Ratio** | 0–1 | Inner radius fraction. 0 = solid, >0 = donut/ring |

**Stroke caps on arcs:** When sweep < 100% (any arc, including ring sectors), start/end cap controls appear in the stroke section. Use round caps for progress rings, arrow caps for directional arcs.

**Common shapes by hand:**
- **Progress ring:** stroke-only circle, set Ratio to 1, set Sweep to the completion percentage, set Start to 90° (top), round caps.
- **Pie sector:** filled circle, set Sweep to the wedge percentage, Start at 90° for a wedge starting at top.
- **Donut chart segment:** filled circle, set Sweep to the segment percentage, set Ratio to ~0.5 for a thick ring.
- **Full donut:** filled circle, set Ratio above 0 (e.g. 0.6), leave Sweep at 100%.

## Effects

Effects add shadows, glows, blurs, and texture. Brilliant has two parallel systems:

### Outer Effects (Effects Section)

Live in a separate effects list (not fills). Managed in the Effects section of the right toolbar, or add via the command palette (Cmd+Shift+P): "Add Drop Shadow", "Add Outer Glow", "Add Element Blur".

| Effect | Description |
|--------|-------------|
| Drop Shadow | Shadow behind the element |
| Outer Glow | Luminous glow around the element |
| Element Blur | Blurs the element itself |

### Inner/Fill Effects (Fills Section)

These live in the fills list (not the effects list), so they sit in z-order alongside solid/gradient/image/shader fills. Added as fills, not effects.

| Fill type | Description |
|-----------|-------------|
| Inner Shadow | Shadow inside the element edges |
| Inner Glow | Luminous glow inside the element edges |
| Background Blur | Blurs content behind the element (frosted glass) |
| Liquid Glass | Refracts the content behind the element like a glass lens (rim magnification, chromatic fringing, specular highlights, glow) |

Inner effects are in the fill type dropdown under the **Static** group (alongside Image). Inner effect fills can be interleaved with other fill types.

**Liquid Glass** is engine-rendered: the native canvas refracts the backdrop through a physically-modeled glass slab. It appears in raster (PNG/JPEG/WebP) and video exports, and embeds as a rasterized image in SVG/PDF. HTML/React export omits it (no CSS equivalent). It applies to rectangles, circles, vectors, frames, and text (glyph refraction). Parameters (with defaults): **Thickness** 64 (glass slab thickness, 0–64px, how far the refracted ray travels; 0 = plain backdrop blur), **Bevel** 60 (rim band width where the surface rises), **IOR** 3.0 (index of refraction, 1.0–3.0; higher bends light more), **Chroma** 0.8 (chromatic dispersion, 0–3; >1 = extreme fringing), **Glow** 0 (additive rim glow, 0–1), **Edge** 0 (specular rim highlight, 0–1), **Angle** 2.3561945 rad / 135° (light direction, top-left), **Saturation** 1.05 (backdrop saturation remix, 0–2), **Blur** 0 (backdrop blur sigma). Two more parameters exist in the Blueprint DSL only (no inspector sliders): **Gathering** 1.0 (0–1, how much exterior content the rim lens pulls in; 0 = interior-only refraction, which is how Figma-imported glass arrives) and **Magnification** 1.0 (0–2, multiplies the rim's lateral displacement). All values are plain numbers (not token-bindable).

The color row for a glass fill is the material **Tint** (labeled "Tint" in the inspector), not an opaque fill, its alpha is the tint strength (0 alpha = clear glass). The glass section opens with a **Presets** dropdown that applies a full parameter bundle in one undoable step (a reset button restores defaults). Five presets ship (rim glow and specular rim are held at or below 0.1 on every preset): **Clear** (max-depth clear slab, maximum thickness and refraction, no glow), **Frosted** (heavy frost over a thick slab with a whisper of white tint), **Deep** (full thickness pulled into the widest bevel, near-zero rim), **Chromatic** (maximum refraction and dispersion with a vivid, double-saturated backdrop), **Smoke** (half-strength black tint, blurred desaturated backdrop). Editing any slider or the tint after applying a preset is fine, presets are just starting-point bundles, not a locked mode.

See [effects.md](./effects.md) for default values, parameter ranges, and shadow tokens.
