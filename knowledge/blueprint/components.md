---
assumes: blueprint/core, blueprint/layout
dsl: [comp, inst, override, slot]
---
# Blueprint Components & Iteration

3+ near-identical elements (nav items, cards, tiles, table rows)?
Declare the shape once with `comp` on the parent, then stamp copies
with `inst(#master)` in source order. Editing the master propagates
to every instance.

```
al(h,g($spacing.md),pad($spacing.md)) s(900,hug) "Board" #board

  -- comp goes on the parent type. The master IS the first instance —
  -- this row IS Backlog. Children that vary per instance need #refs.
  -- One child can be a `slot` for heterogeneous per-instance content.
  al(v,g($spacing.sm),pad($spacing.md)) comp s(280,fill) f[($color.surface)] rd($radius.md) "Backlog" #col
    t("Backlog",$font.family,$font.size.md,sb) f[($color.text.primary)] #col_title
    al(v,g($spacing.sm),pad($spacing.none)) s(fill,fill) slot "Body" #col_body
      al(h,g($spacing.none),pad($spacing.sm)) s(fill,hug) f[($color.surface.container)] rd($radius.sm) "Audit docs"
        t("Audit docs",$font.family,$font.size.sm) f[($color.text.primary)]

  -- Trailing props on inst() modify the INSTANCE FRAME — use this to
  -- make one stamp special (active tab, current column, selected row).
  -- override(#child) edits a master child by ref. Each override LOCKS
  -- that token category against future master edits: t() locks all
  -- text props, s() locks sizing, f[]/o()/rot()/effects each lock
  -- independently. Reset via reset_component_instance_overrides.
  inst(#col) f[($color.primary.container)] shadow($color.shadow,o($visibility.faint),y(2),blur(8)) "In Progress"
    override(#col_title) t("In Progress",$font.family,$font.size.md,sb) f[($color.primary)]

  -- Slot fill: bare `#slot_ref` (or `override(#slot_ref)`, same) opens a
  -- block; on a NEW instance the indented children replace the master's
  -- seed for THIS instance only.
  inst(#col) "Shipped"
    override(#col_title) t("Shipped today",$font.family,$font.size.md,sb)
    #col_body
      al(h,g($spacing.none),pad($spacing.sm)) s(fill,hug) f[($color.primary.container)] rd($radius.sm) "v2.4 release"
        t("v2.4 release",$font.family,$font.size.sm) f[($color.primary)]

-- Add to an instance ALREADY on canvas (e.g. one more card): parent the
-- new element into the slot by ref. clone(#card) parent(#slot) works too.
-- ONLY a slot accepts adds — parenting onto a normal instance child drops
-- the line with a warning (add it to the master instead).
al(v,g($spacing.sm),pad($spacing.md)) parent(#col_body) f[($color.surface)] rd($radius.md) "New card"
  t("Ship the thing",$font.family,$font.size.sm,sb) f[($color.text.primary)]

-- Slot adds APPEND — they never clear. Re-filling a slot stacks on top of
-- what's there (only the first fill of an untouched slot replaces the
-- seed). To swap content, delete() the old slot children first.
delete(#old_card)
```
