---
name: "vectors-generation"
description: "AI SVG generation via Quiver.ai — when to use generate_svg vs generate_image, prompt tips, batch variations."
---

# SVG Generation

Use `generate_svg` to create editable vector elements from text prompts via Quiver.ai. The generated SVG is imported as native Brilliant elements — fully editable with direct selection, path editing, boolean operations, and all other vector tools.

## When to Use

| Need | Tool |
|------|------|
| Icons, logos, illustrations | `generate_svg` |
| Photos, textures, realistic images | `generate_image` |
| Resolution-independent assets | `generate_svg` |
| Raster art, photography | `generate_image` |
| Editable vector shapes | `generate_svg` |
| Background images, hero images | `generate_image` |

**Rule of thumb:** If it should scale without quality loss or be editable path-by-path, use `generate_svg`. If it should look photographic or painterly, use `generate_image`.

## Prompt Tips

- **Be specific about style:** "flat minimal icon", "geometric line art", "hand-drawn sketch style"
- **Mention colors when important:** "monochrome black", "using brand blue #2563EB and white"
- **For icons:** "simple icon of a house, single color, no background, clean lines"
- **For logos:** "modern geometric wordmark for a tech company called Acme, minimal"
- **For illustrations:** "isometric illustration of a laptop with code on screen, flat style, limited palette"
- **Keep it focused:** One subject per prompt produces cleaner results than complex scenes

## Batch Variations

Set `n=2-4` to generate multiple variations of the same prompt. Each variation is placed as separate elements on the canvas. Pick the best one and delete the rest.

```
generate_svg(prompt: "minimal rocket icon, single stroke weight", canvasId: "...", n: 3)
```

## Reference Images

Pass `referenceElementIds` to export existing canvas elements as PNG references for style guidance. Useful for:
- Matching an existing visual style
- Generating icons that look consistent with each other
- Using a sketch as structural guidance

## After Generation

Generated SVGs are fully editable:
- Use **direct selection** (A) to edit individual paths
- Apply fills, strokes, and effects
- Use boolean operations (union, subtract, intersect)
- Resize without quality loss
- Reposition with `create_modify_elements`
