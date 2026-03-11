---
assumes: blueprint/layout
---
# Blueprint Layout Patterns

## Common patterns
```
al(h,a(sb,c)) s(fill,hug)                ← push 2 children to opposite edges (spaceBetween)
al(h,a(e,c)) s(fill,hug)                 ← push all children to the right
al(h,a(c,c),g(8)) s(hug,hug)             ← self-sizing centered row (button, chip)
al(v,a(sb,s)) s(fill,600)                ← pin footer to bottom (needs fixed/fill height!)
al(h,g(-8))                               ← negative gap for overlapping (avatar stacks)
al(h) s(fill,hug)                        ← N equal-width items: all children s(fill,fill)
al(h) s(fill,hug)                        ← fixed + flexible: s(240,fill) + s(fill,fill)
al(v,a(e,c)) s(hug,fill)                ← bottom-align in column (container needs fixed height)
gr s(W,H)                                 ← group for free positioning with p(x,y)
```

## Alignment: `a(main,cross)`
`s` start · `c` center · `e` end · `sb` spaceBetween (main only, exactly 2 children for push-apart, 3+ for even distribution). Only works when parent has more space than children — `hug` parent = no room.

⚠ **`al(v)`: main = vertical, cross = horizontal. `al(h)`: main = horizontal, cross = vertical.** Bottom-center in a column = `a(e,c)` NOT `a(c,e)`. Right-center in a row = `a(e,c)` NOT `a(c,e)`.

Never create empty `fr s(fill,hug)` spacers — items right → `a(e)`, opposite edges → `a(sb)` with 2 children, top+bottom → `a(sb)` with fixed/fill height.

## Grid patterns
Row-aligned (table): `al(v,g(1))` → `al(h) s(fill,hug)` rows → `s(fill,fill)` cells.
Column-major (kanban): `al(h,g(16))` → `al(v) s(fill,fill)` columns.

## Group vs Frame
Frame/auto-layout: structured content with gap, padding, alignment. Group: overlapping elements, charts, free `p(x,y)` positioning.

## Debugging
Fill child invisible → parent has `hug` on that axis, needs `fixed`/`fill`. spaceBetween not working → parent is `hug`, needs concrete size. `p(x,y)` no effect → element is in auto-layout, use group. Text wrapping unexpectedly → text has `fill`, change to `hug`. Bottom not pinned → parent uses `hug` height, needs fixed/fill. Items jammed together → parent has `g(0)`, add `g(N)`.

Common sizes: iPhone 393×852 · iPad 1024×1366 · Laptop 1440×900 · Desktop 1920×1080.
