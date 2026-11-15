---
name: "knowledge-editing-paste"
description: "How Paste chooses the internal or system clipboard, internal and external paste, and pasting into another project."
assumes: reference/editing
---

# Editing: Paste

If the system clipboard is unchanged since the last copy, paste uses the faster internal clipboard; if it changed (you copied something in another app), paste reads from the system clipboard.

On the web the same rule holds. Paste reads the browser clipboard to check, so content you copy elsewhere after a cut wins the next paste, and if that read is blocked (no clipboard permission) your own cut still comes back.

**Internal paste:**

- **At cursor (default):** Recreates the copied elements centered on the cursor when the cursor is over the visible canvas (otherwise centered in the visible view, so a paste never lands off screen) with fresh IDs, preserving the full hierarchy. Component masters become instances linked to the master; existing instances keep their master link.
- **Into selected frames:** If every currently selected element is a frame, pasting places an independent copy inside **each** selected frame, centered. Circular references are prevented (you can't paste a frame into itself or its descendants); failed validation falls back to paste-at-cursor. A component instance (or any layer inside one) is never a paste target, as in Figma: with an instance (or a layer inside one) selected, the paste lands at the top level of the canvas at the cursor, never inside the instance, the same as a selection holding any layer that is not a frame. A slot inside an instance still takes pasted content.

**External paste** (when the system clipboard changed):

| Source | Behavior |
|--------|----------|
| Image (PNG, JPEG, etc.) | Creates a rectangle element with the image as a fill |
| SVG markup | Imports as native vector elements (auto-wraps fragments) |
| Figma | Copy in Figma, paste here, and the design lands as native editable elements (see `reference/editing/figma-paste`). Also handles data sent by the Figma plugin. |
| HTML | Imports HTML with inline CSS (e.g., from the Brilliant Capture browser extension) |
| Plain text | Creates a text element |

Brilliant's native design data and blueprint text also paste back in as elements with remapped IDs.

### Paste in another project

Pasting a Brilliant copy into a **different** project recreates the real elements (fresh IDs, full hierarchy), just like an in-project paste, and brings along everything those elements depend on:

- **Components** arrive with their masters; instances stay linked to the master and keep their overrides.
- **Images** come with their pixels, and are never silently swapped for a same-named image that already lives in the destination.
- **Brand tokens** travel too. Where a token name already exists in the destination, the destination's definition wins, and any hard-coded colors keep their exact appearance.
- **Fonts** used by the copied text are carried across, so a cloud project's viewers see the real typeface rather than a fallback.

Two limits worth knowing:

- On **Linux**, copying between two separate app windows is not supported yet. Copying between tabs of the same window works, and the other platforms cover every case.
- Pasting a Brilliant selection into a **non-Brilliant app** (a document, a chat, an image editor) gives a PNG image, same as before. The editable-element paste only lands when you paste back inside Brilliant.
