---
name: "knowledge-frames-auto-layout-spacing"
description: "Auto layout spacing, padding modes, and wrap."
assumes: reference/frames
---

# Auto Layout Spacing, Padding and Wrap

## Spacing

Gap between children, in pixels. Modes:

| Mode | Behavior |
|------|----------|
| Fixed | The entered value is used directly |
| Auto | Equivalent to space-between main-axis alignment. The spacing field becomes read-only and shows the *computed* gap |

Spacing can be bound to a design system spacing token via the spacing-tokens menu next to the field.

## Padding

Three editing modes, switched via the two buttons next to the all-padding field. The buttons mirror the corner radius row: a square split in two (Horizontal/Vertical padding) and a square split in four (Individual padding). Clicking the active button collapses back to the all-padding field alone.

| Mode | Layout |
|------|--------|
| **H/V** (default) | A left-and-right field (arrows left and right, tooltip "Left and right padding") and a top-and-bottom field (arrows up and down, tooltip "Top and bottom padding") |
| **Individual** | Left/Top then Right/Bottom fields (two rows), each with a side marker |
| **Uniform** | The all-padding field alone |

The mode you pick is the mode shown, whatever the values (like Figma). When the sides differ, a field that cannot show them exactly reads "Mixed" and nothing changes until you type: a value typed into a Mixed all-padding field (or a spacing token picked from its menu) sets all four sides, a value in a Mixed left-and-right or top-and-bottom field sets that pair, and one undo restores the original sides. Selecting a frame opens on the simplest mode that shows its values exactly: uniform when all four sides match, H/V when left matches right and top matches bottom, otherwise Individual; your pick holds while that selection stays. Corner radius and stroke widths follow the same rule.

The all-padding field accepts comma-separated input even in uniform mode: typing "16,8" sets H/V; "16,8,24,8" sets Left/Top/Right/Bottom. Padding values can be bound to design system spacing tokens.

## Wrap

Wrap toggle button (rightmost in the alignment+spacing row). When enabled, overflowing children flow to the next row (horizontal) or column (vertical). CSS `flex-wrap: wrap` equivalent.

- Wrap only takes effect when the frame has **fixed or fill** sizing on the **main axis** (need a constraint to wrap against)
- The gap between rows/columns defaults to the item spacing; a **cross-gap field** appears under the Spacing field while wrap is on to set it independently (leave it empty to inherit the item spacing)
- Fill children inside a wrapped row fill that row's main axis, not the frame's
- Drag-reorder uses 2D cursor position to find the right row/column first, then position within it
