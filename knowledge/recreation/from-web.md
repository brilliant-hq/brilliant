---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components, blueprint/images
---
# Recreation: From Website

**Make it look exactly like the live site.** You have HTML, CSS, and assets — extract exact values instead of guessing.

## Step 0: Fetch and Analyze (BEFORE building)

1. `web_fetch` the page. Read HTML structure, extract CSS values.
2. Write down: color scheme (exact hex), font stack, sections, layout structure.
3. Identify assets: logos, hero images, inline SVGs, image URLs.

## Rules

1. **Extract, don't guess.** Get exact hex colors, fonts, weights, sizes, padding, gap, border-radius, box-shadow from CSS.

2. **Build every element.** 6 nav links → build 6. Count page elements, count output.

3. **One section at a time.** Container + navbar first, `export_to_png`, compare. Then hero. Then each section.

4. **Exact text.** Copy HTML text verbatim.

5. **Match proportions.** Use extracted CSS values. `padding: 80px 120px` → use those values.

6. **Export and compare** after each section.

7. **Font matching.** Check CSS `font-family`. If Google Font is bundled, use it. If not, closest match.

## Assets

- **SVG logos:** Look for inline `<svg>` or `<img src="...svg">` URLs
- **Raster images:** `<img>` tags, `background-image` CSS, `<picture>` srcset
- **Wikimedia:** Use for brand logos and flags

## Build Order

1. Fetch and analyze (Step 0)
2. Root container + background
3. Navbar — real logo, links, CTAs. Export, compare.
4. Hero — real headline, images. Export, compare.
5. Each section. Export, compare.
6. Footer. Export, compare.
7. Final full export pass.

## When Fetch Fails

Sites may block fetches or use heavy JS. Ask user for screenshot → fall back to image recreation workflow.
