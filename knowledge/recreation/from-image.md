---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components, blueprint/images
---
# Recreation: From Image

**Make it look exactly like the reference.** Match background color, text color, font size, weight, padding, margin, border, corner radius, proportions, shadows, blurs, glows, opacity. Use exact text from the image.

## Step 0: Describe What You See (BEFORE building)

Write 3-5 sentences describing: overall color scheme, major sections, text/brand names you can read. Don't build until you've committed observations to text. Prevents building from stereotype instead of observation.

## Rules

1. **Build every element.** 7 list items → build 7. 4 panels → build 4. Count elements in image, count in output. Must match.

2. **One section at a time.** Build outermost container + first section, `export_to_png` and compare. Then next section. Never single-pass.

3. **Match actual colors, not the category.** Build from THIS image, not what this type of app "usually" looks like.

4. **Match density.** If reference is compact, build compact. Don't inflate padding.

5. **Exact text.** Read from image verbatim. Don't substitute, invent, or paraphrase.

6. **Match proportions.** Narrow section stays narrow. Don't equalize.

7. **Export and compare after each section.** List specific differences, fix them.

8. **Only build what you see.** No colors, icons, or elements not in the image. When unsure, use neutral gray — never default to blue.

## Build Order

1. Describe what you see (Step 0)
2. Root container with correct dimensions
3. Top-level section structure
4. First section — all content. Export, compare.
5. Next section. Export, compare.
6. Continue until complete.
7. Final full export comparison.
