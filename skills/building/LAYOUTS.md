---
name: "building-layouts"
description: "Auto layout mechanics: sizing rules, fill/hug/fixed behavior, layout decisions, grid patterns, and debugging tips."
---

# Layout Mechanics

Layouts are built recursively. A page, a card, and a button all follow the same process — pick direction, set sizing, set spacing. The difference is scale. At every level of nesting:

1. **Direction** — `al(v)` or `al(h)`
2. **Sizing** — where each dimension comes from (`hug`, `fill`, `fixed`)
3. **Spacing** — edges (`pad`) and between children (`g`)

Start from the outermost frame and apply these three decisions at every level down to the smallest component. Combine with BUILDING_BLOCKS for domain-specific component anatomy.

```
al(v,g(24),pad(32)) s(800,hug)                ← page: vertical, fixed width, section-level gap
  al(h,g(12)) s(fill,hug)                     ← row: horizontal, fills page, card-level gap
    al(v,g(12),pad(20)) s(fill,hug)            ← card: vertical, fills row, content-level gap
      al(h,a(c),g(8),pad(10,20)) s(hug,hug)   ← button: horizontal, centered, tight gap
```

Same three decisions at every depth — only the values change.

> **Structure and appearance are independent.** `al()`, `s()`, `pad()`, `g()`, `p()` = structure. `f[...]`, `st[...]`, `shadow()`, `rd()`, `o()` = appearance. A visual restyle never touches layout. A structural change never touches fills or strokes. When modifying existing elements, include only properties that change — omitted ones are preserved.

## Sizing Fundamentals

`s(W,H)` where each value is a number (fixed), `fill`, `fill:N` (flex-weighted fill), or `hug`.

**Flex factor:** `fill:N` sets a flex weight for proportional distribution among fill siblings. Plain `fill` = flex 1. Two siblings with `fill:3` and `fill:1` get 75%/25% of remaining space. Only affects the main axis in auto layout.

**How to choose:** For each axis, ask "what determines this element's size?" Self-contained components (buttons, toggles, badges) are sized by their content → `hug`. Structural containers (columns, sections, card grids) are sized by their parent → `fill`. Specific-dimension elements (icons, avatars) are sized by spec → `fixed`.

```
al(h,g(12)) s(fill,hug) "Row"            ← structural: fills parent
  al(v,g(12),pad(20)) s(fill,hug) "Card" ← structural: fills row
    t("Title",Inter,16,sb) "Title"        ← content: hug (label)
    t("Desc",Inter,14) s(fill,hug) "Desc" ← stretches to wrap: fill
    al(h,a(c,c),g(8),pad(10,20)) s(hug,hug) "Button"  ← component: hug
      svg(icon:plus) s(16,16) "Icon"      ← spec: fixed
```

| Element type | Width | Height | Reasoning |
|-------------|-------|--------|-----------|
| Root component (card, form, section) | `fixed` or `hug` | `hug` | Width: `fixed` if fill children need a concrete ancestor; `hug` if component adapts. Height: content determines it |
| Label / value text (numbers, metrics, units, dates, nav items, section headers, badges) | `hug` | `hug` | Must not wrap — omit `s()` entirely (text defaults to hug on both axes) |
| Prose text (descriptions, paragraphs, body copy) | `fill` | `hug` | Should wrap — `s(fill,hug)` |
| Text in horizontal frame (expanding) | `fill` | `hug` | Must set explicitly — `s(fill,hug)` |
| Nested frame in vertical parent | `fill` | `hug` | Width: parent. Height: content |
| Nested frame in horizontal parent | varies | `fill` | Height: parent (equal-height columns) |
| Button frame | `hug` | `hug` | Content determines both |
| Icon / Avatar | `fixed` | `fixed` | Designer knows the exact size |
| Input field frame | `fill` | `fixed` | Width: parent. Height: designer specifies |
| Equal-width siblings | `fill` | `fill` or `hug` | Width: parent divides equally. Height: match siblings or adapt |
| Proportional-width siblings (e.g., 3:1 split) | `fill:N` | varies | `fill:3`+`fill:1` = 75%/25%. Proportions maintained when parent resizes |
| spaceBetween row children | `hug` | `hug` | Both sides hug, spaceBetween distributes gap |

**Text sizing decision:** Ask "should this text wrap if the container gets narrower?" **No** → `hug` (most text). **Yes** → `fill` (prose only). In a typical UI, 80-90% of text elements are labels/values (hug). Only descriptions and paragraphs need fill.

### The #1 Error: Fill Inside Hug

Fill on main axis + parent hug on main axis = **COLLAPSES to 0**.

- Vertical layout (`al(v)`): child `s(fill,_)` needs parent with fixed/fill **width** — not `s(hug,_)`
- Horizontal layout (`al(h)`): child `s(_,fill)` needs parent with fixed/fill **height** — not `s(_,hug)`
- Cross-axis fill always works — `s(_,fill)` in `al(h)` with `s(_,hug)` parent is fine

**Why:** Main axis of a hug frame = sum of children. If a child says "fill remaining space" and the frame says "be as small as my children," that's circular — so fill collapses. Cross axis doesn't have this problem because the frame's cross size = max of children.

**Fix:** Any frame whose children use `fill` on the main axis must have `fixed` or `fill` width — not `hug`.

**Auto-layout frames default to hug.** `s(504,288)` alone won't fix dimensions — auto-layout overrides to hug. Always set sizing explicitly.

### Fill Inheritance Chain

`fill` on the main axis requires a concrete dimension from an ancestor somewhere up the chain:

| Scenario | Result |
|----------|--------|
| fill child -> fill parent -> **fixed** grandparent | Works |
| fill child -> fill parent -> **fill** grandparent -> **fixed** great-grandparent | Works |
| fill child -> fill parent -> **hug** grandparent | Collapses |

**Rule:** Walk up the main-axis chain. If you hit `fixed` (or `fill` with a concrete ancestor) before `hug`, fill works. If you hit `hug` first, fill collapses to content size. Cross-axis fill is unaffected.

### All-Fill-Children Edge Case

When ALL children have `fill` on the cross axis, there are no non-fill siblings to anchor the dimension. The layout engine measures each child's natural content size and uses the tallest (or widest) as the cross-axis dimension. All children then stretch to match.

## Cross-Axis Sizing

Every child has two axes: **main** (layout direction) and **cross** (perpendicular).

| Cross-axis mode | Behavior | Use when |
|----------------|----------|----------|
| `fill` | Stretches to match tallest/widest sibling | Siblings should be the same size — uniform edge |
| `hug` | Each child sizes independently | Siblings can be different sizes |

In **horizontal** layout (`al(h)`): cross axis = **height**. `fill` height = all children same height.
In **vertical** layout (`al(v)`): cross axis = **width**. `fill` width = all children same width.

## Text Wrapping

Controlled entirely by width sizing mode. **Default to hug** — only use fill for text that should reflow.

| Width mode | Wrapping | Use for |
|-----------|---------|---------|
| `hug` (or omit `s()`) | No wrapping — single line, natural width | Labels, numbers, metrics, units, dates, nav text, section headers, badges, button text, prices — any atomic content |
| `fill` → `s(fill,hug)` | Wraps to fill allocated width | Descriptions, paragraphs, body copy — multi-sentence prose |
| `fixed` → `s(W,H)` | Wraps within explicit pixel width | Specific column widths |

**If text wraps when it shouldn't:** it has `fill` width — change to `hug`. This is the most common text sizing error — especially in narrow cards (e.g., 3-column metric grids) where fill causes numbers to wrap.
**If text overflows when it should wrap:** it has `hug` width — change to `fill`.

## Spacing

Every auto-layout frame has two spacing concerns — set both when you create a frame:

- **`pad(V,H)`** — distance from frame edges to content
- **`g(N)`** — distance between children

`pad()` without `g()` means children touch — correct for full-bleed sections, wrong for discrete items like icon + text. Both are deliberate choices at every level of nesting.

```
al(v,g(16),pad(20)) s(fill,hug) "Card"           ← edges: 20, between children: 16
  al(h,a(c,c),g(8),pad(10,20)) s(hug,hug) "Btn"  ← edges: 10/20, between icon+text: 8
  al(v,g(0)) s(fill,hug) "List"                   ← edges: none, children touch (full-bleed rows)
```

| Level | What it controls | Owner | Property |
|-------|-----------------|-------|----------|
| **Edge inset** | Distance from container edge to content | Parent | `pad(V,H)` |
| **Between siblings** | Distance between adjacent children | Parent | `g(N)` |
| **Internal** | Layout within a child | Child | its own `pad()`, `g()` |

**Rule: never duplicate.** If a parent has `pad(0,16)`, its children inherit the inset — they don't add their own edge spacing. Each level is owned by exactly one element.

### Gap: `g(0)` vs `g(N)`

`g(0)` — children touch edge-to-edge. Only correct when children are full-bleed dividers, separators, or seamless sections with no visible boundary between them.

`g(N)` — children are visually separated. Use for **any** siblings that need space between them — including cards with their own backgrounds/borders.

**Key rule:** Children can only control their own *inner* spacing (`pad()`). They **cannot** create space around themselves — only the parent's `g(N)` controls inter-child spacing. Cards with generous inner padding but `g(0)` on the parent will still be jammed together.

### Spacing Scale

Spacing decreases with nesting depth — page sections are far apart, card content is moderate, component internals are tight.

| Relationship | Gap | Use for |
|-------------|-----|---------|
| Tightly coupled | `g(2-4)` | Label + sublabel, icon + badge, dot + legend text |
| Related items | `g(6-8)` | Icon + text in a row, form label + input, items in a small group |
| Siblings in a section | `g(12-16)` | Items in a list, fields in a form, stats in a row |
| Sections or major groups | `g(20-32)` | Distinct content blocks within a container |
| Page-level sections | `g(40-64)` | Major sections of a full-page layout |

Same scale applies to `pad()` — tighter padding for compact components, wider for spacious containers.

### Padding Proportions

Padding values should be proportional to the content they surround. The most common visual error is padding that's too small for the text size, causing text to crowd container edges.

| Container type | Horizontal padding rule | Example |
|---------------|------------------------|---------|
| Pill / toggle / capsule | >= 1× font size | 15px text → `pad(_,16)` minimum |
| Button / chip / badge | >= 0.8× font size | 14px text → `pad(_,12)` minimum |
| Card / section | >= 1.5× font size | 16px body text → `pad(_,24)` minimum |

**`pad()` and alignment are independent.** `a(sb,c)` distributes children across the main axis — it does NOT create edge spacing. Without `pad()`, the first and last children sit flush against the container walls regardless of alignment.

## Layout Decisions

Choose the right pattern for your intent:

| I want... | Use | Key constraint |
|-----------|-----|---------------|
| Self-sizing row (button, chip, tag) | `al(h,a(c,c),g(N),pad(V,H)) s(hug,hug)` | Sizes to content |
| Push to opposite edges (label + value) | `al(h,a(sb,c),pad(V,H)) s(fill,hug)` | **Exactly 2 children** — group 3+ into 2 wrappers |
| Pin footer to bottom | `al(v,a(sb,s))` | Parent **MUST** have fixed/fill height — see "Distribution Needs Room" |
| N equal-width items (stat row, tabs) | All children `s(fill,fill)` in `al(h)` parent | Parent needs concrete width. `fill` height = match tallest |
| Proportional split (75/25, sidebar) | `fill:N` siblings — `fill:3` + `fill:1` | Parent needs concrete width |
| Fixed + flexible (sidebar + content) | Fixed-width `s(240,fill)` + flex `s(fill,fill)` | Parent needs both fixed width and height |
| Overlapping elements | `gr` (group) + `p(x,y)` per child | Auto layout can't overlap — group required |
| Push items apart | `a(sb)` with 2 children, NOT a spacer frame | **Never use `fr s(fill,hug)` as a spacer** — use alignment |
| Cross-item alignment in strips | Fixed height on variable slots | Same height = same baseline across items |
| Hide overflow at rounded corners | Add `clip` on parent | Images, charts, accent bars at frame edges |
| Negative spacing / overlap in a row | `g(-N)` | Stacked avatars, overlapping cards |
| Bottom-align items in columns | `al(v,a(e,c)) s(hug,fill)` per column | Container must have fixed height |

### No Spacer Frames

Never create an empty frame (`fr s(fill,hug)`) to push items apart. This is a CSS flexbox hack — auto layout has proper alignment for every distribution case:

| Instead of spacer... | Use |
|---------------------|-----|
| Items on opposite edges | `a(sb)` on parent with 2 children |
| Items pushed right | `a(e)` on parent |
| Top content + bottom footer | `a(sb)` on parent with fixed/fill height |
| 3+ items with specific grouping | `a(sb)` with 2 wrapper groups (see below) |

Spacers waste an element, obscure intent, and add tokens. Alignment is the correct abstraction.

### spaceBetween: Always 2 Children

3+ flat children in a spaceBetween row spread evenly instead of grouping:

```
Wrong — icon drifts to center:
{id} al(h,a(sb,c)) s(fill,hug) "Row"
  {id} ... "Day"
  {id} ... "Icon"
  {id} ... "Temp"

Right — 2 groups, icon stays with day:
{id} al(h,a(sb,c)) s(fill,hug) "Row"
  {id} al(h,a(c,c),g(8)) s(hug,hug) "Left"
    {id} ... "Day"
    {id} ... "Icon"
  {id} ... s(hug,hug) "Temp"
```

### Bottom-Aligned Columns

Items pushed to the bottom of equal-height columns. Each column: `al(v,a(e,c)) s(hug,fill)`.

**CRITICAL:** Columns must be `s(hug,fill)` not `s(hug,hug)`. With hug, the column collapses to fit content and `e` has no space to push — items top-align instead. Container must have fixed height. (See "Distribution Needs Room" in Alignment.)

**Used by:** bar charts, comparison columns, any baseline-aligned strip.

## Grid Patterns

| Need row alignment? | Structure | Cell sizing |
|---------------------|-----------|-------------|
| **Yes** (table, comparison, matrix) | Row-major: rows → cells | Cells `s(fill,fill)` |
| **No** (kanban, independent streams) | Column-major: columns → items | Columns `s(fill,fill)`, items `s(fill,hug)` |

**Row-Major:** `al(v,g(1))` parent → `al(h,g(1)) s(fill,hug)` rows → `s(fill,fill)` cells. `g(1)` with colored parent fill = grid lines. Every row must have same cell count.

**Column-Major:** `al(h,g(16))` parent → `al(v,g(12)) s(fill,fill)` columns → `s(fill,hug)` items. Items stack independently.

## Alignment

`a(main,cross)` — main axis alignment + cross axis alignment. **Cross-axis defaults to `c` (center).** Single-value shorthand `a(main)` is supported — e.g., `a(sb)` = `a(sb,c)`.

| Value | Main axis behavior | Cross axis behavior |
|-------|-------------------|-------------------|
| `s` (start) | Pack children at start | Align children to top/left |
| `c` (center) | Center children | Center children |
| `e` (end) | Pack children at end | Align children to bottom/right |
| `sb` (spaceBetween) | Distribute with equal gaps | *(not valid on cross)* |

### How to Choose Cross-Axis Alignment

The cross-axis value controls how children of **different sizes** line up perpendicular to the layout direction. In a horizontal row, cross-axis = vertical — it decides whether a 22px icon, 15px text, and 8px bar share a top edge, a center line, or a bottom edge.

**`c` (center) is the default** — omitting the cross value gives you center alignment. When children have different heights (or widths in a vertical layout), centering them on their midline is almost always what looks right. A row with an icon, text, and a thin progress bar — `c` aligns their visual centers. `s` would top-align them all, making the thin bar float awkwardly at the top.

Only deviate from `c` for specific reasons:

| Cross-axis | When to use | Example |
|-----------|-------------|---------|
| `c` (center) | **Default.** Mixed-size children in any row or column | Icon + text + badge, data rows, nav items |
| `s` (start) | Children should share a top/left edge | Long prose paragraph beside a sidebar element — top-align so both start at the same line |
| `e` (end) | Children should share a bottom/right edge | Tab bar where underline indicators sit at the bottom edge |

### How to Choose Main-Axis Alignment

| I want children to... | Use | Note |
|-----------------------|-----|------|
| Pack at the start (left/top) | `s` | Default for most content rows |
| Center as a group | `c` | Buttons, avatars, centered content |
| Pack at the end (right/bottom) | `e` | Trailing actions, right-aligned values |
| Spread to opposite edges | `sb` | Label+value pairs — **exactly 2 children** |

### Distribution Needs Room

`sb` (spaceBetween), `e` (end), and `c` (center) on the main axis only produce visible effects when the parent has **more space than its children consume**. If the parent is `hug` on the main axis, it shrinks to fit its children exactly — there's no leftover space for distribution, so `sb`/`e`/`c` all look identical to `s`.

This applies everywhere: pinning a footer to the bottom of a card (parent needs fixed height), distributing items evenly across columns (columns need fixed/fill height), centering content in a hero (parent needs concrete dimensions).

**Common combos** (single-value shorthand uses default cross `c`):
- `a(s)` or `a(s,c)` — left-aligned, vertically centered (most rows)
- `a(c)` or `a(c,c)` — centered both axes (buttons, avatars, icons)
- `a(sb)` or `a(sb,c)` — spread apart, vertically centered (label+value rows)
- `a(s,e)` — left-aligned, bottom-aligned (tab indicators)
- `a(e)` or `a(e,c)` — right-aligned, vertically centered (trailing elements)

## Group vs Frame

| | Frame (`fr`) / Auto Layout (`al()`) | Group (`gr`) |
|---|---|---|
| Layout | Auto-layout (gap, padding, alignment) | Free positioning (`p(x,y)`) |
| Clipping | No-clip by default, add `clip` | No-clip by default, add `clip` |
| Use for | Structured content, spacing, alignment | Overlapping elements, precise positioning |

**Use group when you need overlapping or absolute positioning:**
- Charts (gridlines + curves + axis labels share coordinate space)
- Progress rings (track circle + arc + center text)
- Stacked bars at calculated `p(x,y)` positions
- Image + text overlay compositions

**Use frame for everything else** — auto-layout prevents most spacing errors.

**Group Overlay pattern:** `gr s(W,H)` with children at explicit `p(x,y)` positions. All children share the same coordinate space.

## Common Dimensions

| Format | Size |
|--------|------|
| iPhone 15/16 | 393x852 |
| iPhone SE | 375x667 |
| iPad | 1024x1366 |
| iPad landscape | 1366x1024 |
| Laptop | 1440x900 |
| Desktop | 1920x1080 |
| Business card | 252x144 |
| A4 | 595x842 |
| US Letter | 612x792 |

## Debugging Tips

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| Fill child invisible (0 width/height) | Parent has `hug` on main axis | Give parent `fixed` or `fill` width |
| Text wrapping unexpectedly | Text has `fill` width | Change to `hug` |
| Text overflowing / not wrapping | Text has `hug` width | Set `s(fill,hug)` |
| Content disappeared after resize | Resize converts to `fixed` sizing | Check sizing, change back to fill if needed |
| Siblings not equal width | Children don't have `fill` width | Set `fill` width inside parent with concrete width |
| Siblings not equal height in a row | Cross-axis height is `hug` | Set `fill` height (cross-axis fill stretches to tallest) |
| spaceBetween row with wrapping text | One side has `fill` width | Both sides should use `hug` |
| Items squished to minimum | Siblings use `fixed` instead of `fill` | Set `fill` width — siblings divide space equally |
| Bottom section not pinned down | Parent uses `hug` height | Parent needs fixed/fill height — distribution needs room (see Alignment) |
| Items in a row look vertically misaligned | Cross-axis is `s` (top-aligned) | Use `c` (center) — the default for mixed-size children |
| Children touching container edges | Parent has no `pad()` | Add `pad(V,H)` — parent owns edge inset |
| Items jammed together | Parent has `g(0)` or no gap | Add `g(N)` — parent owns sibling spacing |
| Image/chart/accent extends beyond rounded corners | Frame isn't clipping | Add `clip` on parent frame |
| `p(x,y)` has no effect | Element is in an auto-layout frame | Positions only work in groups or top-level canvas |
| Icon+text row has no spacing | Missing `g()` | Every icon+text row needs `g(8)` or similar |
| Used a spacer frame to push items apart | Spacer is a CSS hack | Use `a(sb)` alignment — see "No Spacer Frames" |
