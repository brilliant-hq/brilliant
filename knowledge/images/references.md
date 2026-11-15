# Image Generation: Parallel, References, Cut Out

## Parallel Generation

Call `generate_image` for ALL images in the same turn, tool executor runs concurrently. 10 parallel = same time as 1 sequential.

## Reference Images

Pass `referenceElementIds` to maintain style across generations.

## Cut Out Instead of Generate

When the image is a real photo of a real person or product and the user
wants it on transparency (a thumbnail, a print piece, a portrait over a
color), call `remove_background` with the element's id, never
`generate_image`: a real photo of a real person, keep the face, cut it
out. `generate_image` regenerates the picture and invents a new face.
`remove_background` keeps the photo's own pixels, cuts the background in
place in the same fill (crop, scale mode and opacity kept) and answers the
new asset path. The fill then reads `img(<cutout>, ..., src(<original>))`;
`execute_commands` with `restore_background` puts the original back. It
runs on Brilliant AI for a signed-in account and counts against Brilliant
AI usage. If it answers "No subject found", nothing changed and nothing
was charged. `ids` can also name a frame, group or component instance: every
photo inside it is cut in the same call.

For a sticker look on a cut photo, call `add_cutout_outline` with the
element's id: it traces the cutout's visible edge into a new vector layer
("Cutout outline") right above the photo, aligned with its crop, rotation,
flip and scale; a white outside stroke by default (`color` as #RRGGBB and
`width` in px are optional). The outline is an ordinary element afterwards.
It runs locally (no Brilliant AI usage) and refuses, naming
`remove_background`, on a photo whose background is still there.
