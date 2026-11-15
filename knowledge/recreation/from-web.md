---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components, blueprint/images
---
# Recreation: From Website

**Make it look exactly like the live site.** You have HTML, CSS, and assets, extract exact values instead of guessing.

## Step 0: Fetch and Analyze (BEFORE building)

1. `web_fetch` the page. Read HTML structure, extract CSS values.
2. Write down: color scheme (exact hex), font stack, sections, layout structure.

## Rules

1. **Extract, don't guess.** Get exact hex colors, fonts, weights, sizes, padding, gap, border-radius, box-shadow, `filter: blur()` and `drop-shadow()` from CSS (an `html` fence carries them as `shadow()` and `eblur()`, and folds a scale about its `transform-origin`).

2. **Build every element.** 6 nav links → build 6. Count page elements, count output.

3. **Exact text.** Copy HTML text verbatim.

4. **Font matching.** Check CSS `font-family`. If Google Font is bundled, use it. If not, closest match.

## What an `html` Fence Keeps From CSS

The canvas matches what a browser shows for these, so write the CSS as the site does:

- `justify-content: space-around` and `space-evenly` are laid out as the browser lays them out (`sa` / `se` on the frame's main axis).
- `text-align` only aligns: the text keeps the weight the CSS declares.
- A `transparent` gradient stop fades to its neighbor color, never through black, and background layers stack as CSS paints them, the background color at the bottom.
- An absolutely positioned child of a flex container leaves the flow and is placed against the container's padding box.
- An icon inherits color (alpha included) and size from its nearest ancestor that declares them, through inline wrappers, and its own declaration wins.
- `letter-spacing` keeps fractional px values, and `em` resolves against the element's own font size.

## Assets

- **SVG logos:** Look for inline `<svg>` or `<img src="...svg">` URLs
- **Raster images:** `<img>` tags, `background-image` CSS, `<picture>` srcset
- **Wikimedia:** Use for brand logos and flags

## Build Order

1. Fetch and analyze (Step 0)
2. Root container + background
3. Navbar, real logo, links, CTAs. Export, compare.
4. Hero, real headline, images. Export, compare.
5. Each section. Export, compare.
6. Footer. Export, compare.
7. Final full export pass.

When the fetch fails, see `recreation/from-image`.
