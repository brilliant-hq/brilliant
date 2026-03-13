---
name: "vectors-vectorization"
description: "Raster-to-vector conversion via Quiver.ai — how to vectorize images, what works well."
---

# Image Vectorization

Use `vectorize_svg` to convert raster images (PNG, JPEG) into editable vector elements via Quiver.ai. The original image is preserved — the vectorized result is placed as new elements alongside it.

## How It Works

1. Specify element IDs of raster images on canvas
2. Each element is exported as PNG and sent to Quiver.ai
3. The resulting SVG is imported as native editable vector elements
4. Original elements are untouched

## What Works Well

| Input | Result Quality |
|-------|---------------|
| Logos (clean, few colors) | Excellent |
| Icons (simple shapes) | Excellent |
| Line art / sketches | Good |
| Screenshots of UI elements | Good |
| Text / typography | Good |
| Complex photographs | Poor — use for artistic effect only |
| Detailed illustrations | Moderate — may simplify |

## Usage

```
vectorize_svg(canvasId: "...", elementIds: ["element-id-1", "element-id-2"])
```

Each element is vectorized independently. Results include `originalId` → `newElementIds` mapping.

## Tips

- **Higher contrast inputs** produce cleaner vectors
- **Simple shapes with clear edges** vectorize best
- **Auto-crop is enabled by default** — trims whitespace around the subject
- After vectorization, use path editing tools to clean up any artifacts
- For best results, vectorize images that are already clean (not noisy/textured)
