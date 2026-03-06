---
name: "recreation-image"
description: "Recreating a design from a screenshot or reference image. Section-by-section building with verification."
---

# Recreating from an Image

**Make it look exactly like the reference.** Pay close attention to background color, text color, font size, font weight, padding, margin, border, corner radius, proportions, drop shadows, blurs, glows, and opacity. Match the colors, sizes, and effects exactly. Use the exact text from the image.

## Step 0: Describe What You See (BEFORE any building)

Before your first `<objects>` block, write 3-5 sentences describing the visual foundation of the image. This prevents the #1 recreation failure — building from stereotype instead of observation. State: the overall color scheme, what the major sections are, and any text/brand names you can read. Don't build anything until you've committed these observations to text.

## Rules

1. **Build every element.** If there are 7 list items, build 7. If there are 4 panels, build 4. Element omission is the #1 recreation failure — models skip entire sections, panels, buttons, and details. Count elements in the image and count elements in your output. They must match.

2. **Build one section at a time.** Do NOT build the entire design in one `<objects>` block. Build the outermost container + first section, then `export_to_png` and compare. Then build the next section. This is non-negotiable — single-pass builds consistently fail.

3. **Match the actual colors, not the category.** Don't build from what you think this type of app usually looks like. Build from what you see in THIS image. Two designs of the same app type can have completely different color schemes.

4. **Match the density.** Look at how tight the spacing is. If the reference is compact, build compact. Don't inflate padding and gaps beyond what the image shows.

5. **Use the exact text.** Read text from the image and use it verbatim. Don't substitute with your own copy. Don't invent names, brands, or labels. Read character by character when unsure.

6. **Match proportions.** If one section is narrow and another is wide, maintain those ratios. Don't equalize widths.

7. **After each section, export and compare.** Use `export_to_png` to verify. Don't say "looks close" — list specific differences and fix them.

8. **Only build what you see.** Do not add colors, icons, badges, or elements that aren't clearly visible in the image. When unsure about a color, use neutral gray — never default to blue or any brand color from memory. If you can't read text clearly, leave it as placeholder rather than inventing copy.

## Build Order

1. **Describe what you see** (Step 0 above)
2. Root container with correct overall dimensions
3. Top-level section structure (get sizes right)
4. First section — all content. Export and compare.
5. Next section. Export and compare.
6. Continue until complete.
7. Final full export and comparison pass.
