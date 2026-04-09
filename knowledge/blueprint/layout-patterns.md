---
assumes: blueprint/layout
---
# Blueprint Layout Patterns

## Common patterns
```
al(h,a(sb,c),g($spacing.4),pad($spacing.none)) s(fill,hug)   ← push 2 children to opposite edges (spaceBetween)
al(h,a(e,c),g($spacing.3),pad($spacing.none)) s(fill,hug)   ← push all children to the right
al(h,a(c,c),g($spacing.2),pad($spacing.none)) s(hug,hug)    ← self-sizing centered row (button, chip)
al(v,a(sb,s),g($spacing.none),pad($spacing.none)) s(fill,600)           ← pin footer to bottom (g($spacing.none) = intentional zero gap)
al(h,g(-8),pad($spacing.none))                               ← negative gap for overlapping (avatar stacks)
al(h,g($spacing.2),pad($spacing.none)) s(fill,hug)          ← N equal-width items: all children s(fill,fill)
al(h,g($spacing.4),pad($spacing.none)) s(fill,hug)          ← fixed + flexible: s(240,fill) + s(fill,fill)
al(v,a(e,c),g($spacing.2),pad($spacing.none)) s(hug,fill)   ← bottom-align in column (container needs fixed height)
gr s(200,200)                              ← group for free positioning with p(x,y)
gr s(200,200)                              ← center child inside group/frame using p(c,c)
  r abs p(c,c) s(100,100)                 ← abs: free positioning inside auto layout
```

## Alignment: `a(main,cross)`
`s` start · `c` center · `e` end · `sb` spaceBetween (main only, exactly 2 children for push-apart, 3+ for even distribution). Only works when parent has more space than children — `hug` parent = no room.

⚠ **`al(v)`: main = vertical, cross = horizontal. `al(h)`: main = horizontal, cross = vertical.** Bottom-center in a column = `a(e,c)` NOT `a(c,e)`. Right-center in a row = `a(e,c)` NOT `a(c,e)`.

Never create empty `fr s(fill,hug)` spacers — items right → `a(e)`, opposite edges → `a(sb)` with 2 children, top+bottom → `a(sb)` with fixed/fill height.

## Grid patterns
Row-aligned (table): `al(v,g(1))` → `al(h,g(0)) s(fill,hug)` rows → `s(fill,fill)` cells.
Column-major (kanban): `al(h,g($spacing.4))` → `al(v,g($spacing.2)) s(fill,fill)` columns.

## Group vs Frame vs Absolute
Frame/auto-layout: structured content with gap, padding, alignment. Group: overlapping elements, charts, free `p(x,y)` positioning. `abs` on a child inside auto layout: element ignores the flow and positions freely with `p(x,y)` while staying a child of the frame (clips, moves, undoes with it). Use `p(c,c)` to center a child inside any parent without calculating coordinates.

When to use each: badges, floating buttons, notification dots on cards → `abs` inside auto layout. Standalone chart overlays (arcs, rings) → `gr`. Decorative layers needing rotation/scale → `gr` or `abs` depending on whether the parent is auto layout.

## Debugging
Fill child invisible → parent has `hug` on that axis, needs `fixed`/`fill`. spaceBetween not working → parent is `hug`, needs concrete size. `p(x,y)` no effect → element is in auto-layout, add `abs` to position freely. Text wrapping unexpectedly → text has `fill`, change to `hug`. Bottom not pinned → parent uses `hug` height, needs fixed/fill. Items jammed together → parent has `g(0)`, add `g($spacing.2)` or similar.

Common sizes: iPhone 393×852 · iPad 1024×1366 · Laptop 1440×900 · Desktop 1920×1080.
