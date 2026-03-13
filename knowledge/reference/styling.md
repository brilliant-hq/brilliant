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

Components:
1. **Color rectangle** — X = saturation, Y = brightness. Drag the crosshair.
2. **Hue slider** — Horizontal strip, 360-degree spectrum.
3. **Opacity slider** — Alpha channel (0%–100%).

### Color Formats

The color picker includes a format dropdown with these options:

| Format | Example | Description |
|--------|---------|-------------|
| Hex | `#FF5733` | 6-digit hex code |
| RGB | `255, 87, 51` | Red, green, blue values (0-255) |
| HSB | `14, 80, 100` | Hue (0-360), saturation (0-100), brightness (0-100) |
| CSS | `rgba(255, 87, 51, 1.0)` | CSS rgba notation |

**Named colors** (e.g., `coral`, `navy`) are supported when entering colors via AI commands or the command palette, not as a color picker format.

### Named Colors (42)

red, green, blue, yellow, orange, purple, pink, cyan, magenta, white, black, gray, grey, navy, teal, maroon, olive, lime, aqua, coral, salmon, turquoise, indigo, violet, gold, silver, brown, beige, tan, crimson, lavender, plum, orchid, khaki, azure, ivory, mint, peach, rose, charcoal, slate, transparent

### Eyedropper (Ctrl+Shift+C)

Sample a color from anywhere on screen. A magnified 21x21 pixel grid appears around your cursor. Click to apply the sampled color.

### Color Picker Sections

The color picker includes additional sections below the main controls:

- **Design Tokens** — Color tokens from the active design system (`.styles` file). Grouped by category (brand, neutral, success, etc.). Click a swatch to apply a token-bound color.
- **Canvas Colors** — Colors currently used on the active canvas, collected automatically.
- **Recent Colors** — Recently used colors across sessions.

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
2. Or open the color picker and switch to gradient mode
3. Click color stops to edit, add stops by clicking the gradient bar, drag to reposition

**Linear**, **radial**, and **angular** gradients are supported (diamond gradients are not available). Select the gradient type from the fill type dropdown in the right toolbar.

**Linear gradients** are defined by start/end points — edit on canvas by dragging the gradient handles (start handle, end handle), or click the gradient line to add a color stop.

**Radial gradients** are defined by center, radius, and width handles — drag the center to reposition, drag the radius handle to resize and rotate, drag the width handle to make the gradient elliptical (Shift constrains to circular).

Add/remove/reposition color stops directly on the gradient bar.

### Image Fills

Import an image (Cmd+K) or paste from clipboard. The image becomes a rectangle with an image fill.

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
| **Noise / Grain** | Film-like grain overlay (monochrome/color, uniform/gaussian/film) |
| **Halftone** | Classic print halftone dots (standard + CMYK mode, circle/diamond/line/soft shapes) |
| **Pixelate** | Mosaic pixelation (square/hex/diamond/circle modes) |
| **Duotone** | Two-tone or tri-tone color mapping with gamma/midpoint control |
| **Posterize** | Reduce color levels for poster-style banding (RGB/luminosity/HSL modes) |
| **Dither** | Ordered dithering patterns (Bayer/white noise/blue noise) |

Each filter has adjustable parameters, optional color inputs, and built-in presets. Filters work on fills, strokes, text, and vector regions.

### Color Adjust Fills

Non-destructive photo-style adjustments (exposure, contrast, saturation, whites, blacks, clarity, sharpness, vignette, and more). Processes all fills below it in the z-order. Includes built-in presets (Vivid, Cinematic, Vintage, B&W, etc.). Available in the **Filters** category alongside image filters. See `EFFECTS.md` for details.

### Multiple Fills

Stack multiple fills on a single element. Rendered bottom-to-top in list order.

### Text Fills

Text uses fills for text color. Text supports all fill types — solid, gradient, shader, image filters, and color adjust — rendered through the text glyphs. Text also supports strokes (including shader and filter strokes), rendered around the text glyphs with inside/center/outside positioning.

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

**Thickness:** Adjust via right toolbar, size level shortcuts (0–9), or Shift+=.

**Caps (Lines/Arrows/Arcs):** None, Round, Square, Arrow. Each endpoint has independent cap settings. For circles, caps appear when sweep < 100% (open arcs without inner ring).

### Stroke Style Types

Strokes support the same style types as fills:

| Type | Description |
|------|-------------|
| **Solid** | Single color (default) |
| **Linear** | Linear gradient along the stroke |
| **Radial** | Radial (elliptical) gradient on the stroke |
| **Angular** | Angular (sweep) gradient on the stroke |
| **Image** | Image pattern rendered on the stroke |
| **Shader** | Animated procedural pattern (metaballs, liquid metal, holographic, liquid stainless steel, dithering, magnetic glow) |
| **Image Filter** | GPU post-processing (noise/grain, halftone, pixelate, duotone, posterize, dither) |
| **Color Adjust** | Non-destructive photo-style adjustments |
| **Background Blur** | Blurs content behind the stroke area (frosted glass) |
| **Inner Shadow / Inner Glow** | Effect paint styles rendered on the stroke |

Switch the stroke type using the type dropdown on any stroke row in the right toolbar.

### Multiple Strokes

Add multiple strokes with independent style, thickness, and position.

### Stroke on New Shapes

Use **Shift+R** or **Shift+O** for stroke-only shapes. When a shape tool (rectangle/circle) is active, the right toolbar shows creation style checkboxes in the Fills and Strokes section headers to toggle whether new shapes include fill and/or stroke.

## Blend Mode

Blend modes control how elements, fills, strokes, and effects composite against content below them. Available at four independent levels:

| Level | Where | Default |
|-------|-------|---------|
| **Element** | Right toolbar, Element section (Opacity row) | Normal |
| **Fill** | Right toolbar, per-fill row (expanded config) | Normal |
| **Stroke** | Right toolbar, per-stroke row (expanded config) | Normal |
| **Effect** | Right toolbar, per-effect row | Normal (Screen for glow) |

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

Adjust the opacity slider in the color picker, or type a percentage value.

## Corner Radius

### Uniform Radius

| Action | Shortcut |
|--------|----------|
| Radius level 0–9 | Cmd+Alt+0 through Cmd+Alt+9 |
| Increase radius | Cmd+Alt+Shift+= |
| Decrease radius | Cmd+Alt+- |

### Per-Corner Radius

Expand the corner radius section in the right toolbar to adjust each corner independently: top-left, top-right, bottom-right, bottom-left.

### Parent Corner Radius

All parent types support corner radius. With `clipContent` enabled (disabled by default for all parent types), children are clipped to the rounded bounds.

## Circle Arc & Ratio

Circle elements have additional properties for creating arcs, pie sectors, and donut/ring shapes. Edit them in the right toolbar or use the interactive drag handles (see [TOOLS.md](./TOOLS.md#arc-drag-handles)).

| Property | Range | Description |
|----------|-------|-------------|
| **Sweep** | 0–100% | How much of the circle to fill. 100% = full circle |
| **Start** | 0–360° | Where the arc begins. 0° = 12 o'clock, clockwise |
| **Ratio** | 0–1 | Inner radius fraction. 0 = solid, >0 = donut/ring |

**Stroke caps on arcs:** When sweep < 100% and ratio = 0 (open arc, not a ring), start/end cap controls appear in the stroke section. Use round caps for progress rings, arrow caps for directional arcs.

**Common combinations:**
- **Progress ring:** stroke-only circle + `arc(90, 75) ratio(1)` + round caps for 75% completion (90° = top)
- **Pie sector:** filled circle + `arc(90, 25)` for a 25% wedge starting at top
- **Donut chart:** filled circle + `arc(90, 50)` + `ratio(0.5)` for a half-ring
- **Full donut:** filled circle + `ratio(0.6)` (no arc needed)

See [DATA_VISUALIZATION.md](../building/DATA_VISUALIZATION.md#circular-progress-ring) for detailed examples and multi-ring dashboard patterns.

## Effects

Effects add visual enhancements like shadows, glows, blurs, and texture. Brilliant has two effect systems:

### Outer Effects (Effects Section)

Render outside or around elements. Managed in the Effects section of the right toolbar, or add via the **command palette** (Cmd+Shift+P) by searching for "Add Drop Shadow", "Add Inner Shadow", etc. Effects can also be specified in blueprint syntax (see [EFFECTS.md](./EFFECTS.md) for the compact format).

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

Inner effects share the type dropdown with shader fills and can be interleaved with other fill types.

### Key Properties

**Drop Shadow:** X/Y offset, blur, spread, color, opacity, blend mode. "Show behind transparent areas" toggle.

**Outer Glow:** Blur, spread, color, opacity, blend mode (default: Screen).

**Element Blur:** Radius (0-200).

**Inner Shadow:** X/Y offset, blur, spread, color, opacity, blend mode.

**Inner Glow:** Blur, spread, color, opacity, blend mode (default: Screen).

| Action | How |
|--------|-----|
| Add effect | Command palette: "Add Drop Shadow", "Add Inner Shadow", etc., or click "+" in Effects/Fills section |
| Remove effect | Command palette: "Remove Effect", or click delete button |
| Toggle visibility | Command palette: "Toggle Effect Visibility", or click the eye icon |

**Background Blur:** Radius (0-200).

Elements can have multiple effects stacked. Reorder by dragging. Effects render in order: drop shadows → outer glows → fills (solid, gradient, image, shaders, inner shadow, inner glow — all in z-order) → strokes.

See `EFFECTS.md` for full details, default values, and tips.
