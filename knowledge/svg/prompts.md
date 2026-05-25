---
assumes: blueprint/core
---
# SVG Generation: Prompt Patterns

`generate_svg` (Quiver's Arrow model) produces clean, editable vector
paths that drop onto the canvas as native elements. Arrow rewards
specificity about structure and form (shapes, colors, counts), not
atmosphere and lighting.

**Good for:** icons, logos, flat illustrations, diagrams, UI shapes,
decorative badges and dividers, schematic maps. **Poor at:** photorealism,
soft gradients and lighting, realistic faces, textures (wood, fabric,
fog), dense detail. Use `generate_image` (raster) for any of those.

## Writing the prompt

Name the subject, 1-3 dominant colors, the detail level, and any hard
constraints. Two qualifiers carry the most weight: a color count ("3
colors max") and "no text"; Arrow over-draws and inserts stray labels
without them.

```
"a magnifying glass icon, 2px stroke, rounded ends, monochrome"
"a minimalist logo for a coffee shop 'Brew', a coffee bean in a
 sunrise circle, single warm brown"
"a flat vector illustration of a developer at a desk, 3 colors max
 (navy, peach, cream), rounded shapes, no text"
```

Enumerate the parts (4 boxes, the exact colors) instead of describing a
mood. Skip vague aesthetic words ("beautiful", "stunning"); they are
noise to Arrow, and one precise sentence beats a paragraph. For headline
text, place a Brilliant text element over the SVG rather than asking
Arrow to draw it.

## prompt vs instructions

`prompt` is what to draw (subject, layout); `instructions` is how to draw
it (style, palette, "outline-only", "no text"). `instructions` stay
sticky across batch `targets`, so put shared style there and vary the
subject per `prompt`.

Variations: `n: 2-4` gives parallel takes on one prompt (cheap: "4
search-icon ideas"); `targets` fans out distinct prompts under one
`instructions`. Pass an existing element via `referenceElementIds` for
style transfer; Arrow copies the style, not the pixels.
