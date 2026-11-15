---
name: "knowledge-ai-vectors"
description: "AI vector graphics generation and vectorize with Quiver, and choosing image vs vector."
assumes: reference/ai
---

# AI Vector Graphics Generation

The AI generates editable vector graphics with Quiver's model and places them on the canvas as native vector elements, so the user can immediately move, resize, recolor, and reshape them like any hand-drawn vector. It can also **vectorize** an existing raster element on the canvas into editable vector paths (the original raster is left intact).

- **What the user sees:** the AI draws the illustration live. Its cursor moves to a free spot near the middle of the view, a soft outline marks where the art will land, and while the model thinks (often half a minute) a slow shimmer crosses that area and one short line beside the cursor says what it is drawing ("Sketching a fox logo") and stays until the first stroke. Then the AI's pen draws the illustration shape by shape over about five seconds (each shape traced, then filled in), even when the model delivers it all at once. When the drawing finishes, the preview melts into the final, fully editable vectors in about a fifth of a second: nothing moves. Several SVGs from one request draw one after another, each in its own spot.
- **Size:** the art lands at a comfortable display size, about 400 px on its longest side at 100% zoom (a smaller or larger share of the view when zoomed far in or out), whatever size the model drew it at. It is real vector geometry at that size, so resizing it by hand works like any other vector. The layer is named after what was drawn (for example "Cute fox mascot").
- **One undo step:** a whole generation (or a whole vectorize) undoes with a single Cmd+Z and comes back with a single redo.
- **If it fails** partway (a Quiver error, a cancel, the project closing), the partial drawing is removed and the AI reports the error.
- **Requires** a connected Quiver provider, regardless of which chat model is active.
- **Use for:** icons, logos, illustrations, diagrams, anything that should stay crisp at any zoom and remain editable.

### Choosing image vs vector

- Photo / realistic / complex texture -> AI image generation (Google).
- Icon / logo / illustration / diagram / crisp-at-any-zoom -> AI vector generation (Quiver).
- User has a raster they want as editable vectors -> vectorize (Quiver).

For prompt patterns and decision rules, see the `svg/prompts` and `svg/integration` knowledge files.
