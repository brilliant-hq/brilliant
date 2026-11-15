---
name: "knowledge-shaders-adding"
description: "Adding a shader as a fill or stroke, and the five shader types."
assumes: reference/shaders
---

# Adding Shaders

## Adding a Shader

Both fills and strokes are configured in the right toolbar (property inspector) when an element is selected.

**As a fill:**
1. Select an element.
2. In the Fills section, click "+" to add a fill (or select an existing fill row).
3. Open the fill's type dropdown and pick a shader from the **Animated** category.

**As a stroke:**
1. Select an element.
2. In the Strokes section, click "+" to add a stroke (or select an existing stroke row).
3. Open the stroke's type dropdown and pick a shader. The stroke renders the shader pattern along its path.

You can switch any fill or stroke between types freely (solid, gradient, image, shader, filter) without deleting the row.

## Shader Types

| Shader | Category | Colors | What it looks like |
|--------|----------|--------|--------------------|
| **Metaballs** | Animated | up to 5 (default 5) | Organic blobs that merge and split |
| **Liquid Metal** | Animated | up to 2 | Metallic reflections with chromatic aberration and bump-modulated stripes |
| **Iridescent** | Animated | up to 3 | Folded, oil-slick iridescence with a metallic finish |
| **Liquid Stainless Steel** | Animated | up to 2 | Flowing chrome with specular highlights and environment reflections |
| **Dithering** | Animated | up to 2 | Procedural noise rendered as retro two-tone dithered output |
