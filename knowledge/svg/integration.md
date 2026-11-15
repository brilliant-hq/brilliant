---
assumes: svg/prompts, blueprint/core
---
# SVG Generation: Integration & Decision Rules

## Which tool

- `generate_svg` for anything the user may later nudge or recolor: icons,
  logos, flat illustrations, diagrams. The default for iconographic work.
- `generate_image` for photos, realistic scenes, textures, soft lighting.
- `vectorize_image` to convert an existing raster to editable paths. For
  an AI raster you want to clean up, `generate_image` then
  `vectorize_image`.

Rule of thumb: if it should stay editable as shapes, `generate_svg`; if
it should look like a photo, `generate_image`.

## Placement

`generate_svg` and `vectorize_image` drop results straight onto the
canvas as native vector elements (each top-level SVG shape its own
element, grouped under a frame), auto-positioned clear of existing work.
Unlike `generate_image`, you do NOT pre-create a target element; just
pass `canvasId`. The response returns `elementIds` for follow-up
`execute_commands` (reposition, reparent, recolor).

The art lands at the display size (about 400 px on its longest side at
100% zoom, scaled uniformly from whatever viewBox the model used), as
real vector geometry; resize it afterwards like any vector.

## Working with the result

- **Intent line**: pass an optional `intent`, a short present-tense line
  shown beside your cursor while the vector is drawn (e.g. `"Sketching a
  fox logo"`). Without it the line is derived from the prompt.
- **Reference images**: pass up to 4 `referenceElementIds` as style
  guidance (match an illustration style, carry a brand palette). Arrow
  keeps the reference's feel, not its exact shapes.
- **Token sync**: after generating, apply `$color.*` tokens to the new
  SVG's fills via `execute_commands` so the icons re-tint with the DS.
- **Icon rows**: generate the SVGs, then `add_auto_layout` them
  via `execute_commands`.
- **After `vectorize_image`**: the source raster is left intact for
  comparison; delete it via `execute_commands` if only the vector is wanted.

Generation runs on Quiver's Arrow 2 model. Cost and rate limits are
metered by Quiver against the user's Quiver API Platform balance, and a
rate-limited request is retried automatically. If Quiver reports a problem
(a retired key, an empty balance, a refusal) the result says so with the
fix; tell the user, never retry silently or substitute hand-drawn shapes.
