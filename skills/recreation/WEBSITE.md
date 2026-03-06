---
name: "recreation-website"
description: "Recreating a design from a live website URL. Fetch HTML/CSS to extract exact values, download assets, then build section-by-section."
---

# Recreating from a Website

**Make it look exactly like the live site.** You have a massive advantage over image recreation — the actual HTML, CSS, and assets are available. Extract exact colors, fonts, spacing, and text instead of guessing from pixels.

## Step 0: Fetch and Analyze (BEFORE any building)

1. **Fetch the page** with `web_fetch`. Read the HTML structure, extract key CSS values.
2. **Write down what you found** — describe the overall color scheme (exact hex values), font stack, major sections, and the layout structure. This prevents building from stereotype.
3. **Identify assets** — logos, hero images, icons. Look for SVGs in the HTML (inline `<svg>` or `.svg` URLs).

## Rules

1. **Extract, don't guess.** You have the CSS — use it. Get exact hex colors, font families, font weights, font sizes, padding, margin, gap, border-radius, and box-shadow values from the source. When CSS is minified or hard to parse, the fetched HTML still gives you exact text content and structural hints.

2. **Build every element.** If the nav has 6 links, build 6. If there are 4 pricing tiers, build 4. Count elements on the page and count elements in your output. They must match.

3. **Build one section at a time.** Do NOT build the entire page in one `<objects>` block. Build the outermost container + first section (usually navbar), then `export_to_png` and compare. Then build the next section. This is non-negotiable.

4. **Use the exact text.** You have the actual HTML text content — copy it verbatim. No paraphrasing, no placeholder copy.

5. **Match proportions and density.** Use the CSS values you extracted. If the hero has `padding: 80px 120px` and `gap: 24px`, use those values. Don't inflate or normalize spacing.

6. **After each section, export and compare.** Use `export_to_png` to verify. List specific differences and fix them.

7. **Font matching.** Check the CSS `font-family` stack. If the site uses a Google Font that's in Brilliant's bundled set, use it. If not, pick the closest match from the bundled fonts — a geometric sans for a geometric sans, a humanist serif for a humanist serif.

## Asset identification

**SVG logos/icons:** Look for inline `<svg>` elements or `<img src="...svg">` URLs. Inline SVGs can sometimes be extracted from the HTML.

**Raster images:** Look for `<img>` tags, `background-image` in CSS, or `<picture>` with `srcset`.

**Wikimedia is your friend:** don't forget you can always use wikimedia assets.

## Build Order

1. **Fetch and analyze** (Step 0 above)
2. Root container with correct overall dimensions and background
3. Navbar — with real logo, real nav links, real CTAs. Export and compare.
4. Hero section — with real headline, subtitle, images. Export and compare.
5. Each subsequent section. Export and compare after each.
6. Footer. Export and compare.
7. Final full export and comparison pass.

## When Fetch Fails

Some sites block automated fetches, use heavy JS rendering, or return minimal HTML. If `web_fetch` returns unusable content:

- **Ask the user for a screenshot** and fall back to the image recreation workflow (`IMAGE.md`).
- If you got partial HTML (text content but no styles), use the text verbatim and estimate visual properties from any screenshot the user provides.
