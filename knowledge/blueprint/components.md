---
assumes: blueprint/core, blueprint/variables, blueprint/layout
dsl: [for, range, in, vars, step, flat, comp, inst, override]
---
# Blueprint Components & Iteration

For 3+ similar elements (calendar days, nav items, stat tiles, dot grids,
color swatches — anything you'd otherwise stamp by hand), use `for(...)`.
It expands a uniform template and generates `comp + inst()` under the hood.

## Shapes

### `for(range(N))` — pure count
```
for(range(7))
  al(v,x(c),y(c),pad(8)) s(60,80) "Slot $n" #slot
    t("$n",Inter,14,sb)
```
Implicit `$i` (0-based) and `$n` (1-based) are available in any body.
`range(s,e)` is end-exclusive. `range(s,e,step(N))` skips by N.
Name the index when you want both value and position: `for($step, range(3,9))`.

### `for($v, in([scalars]))` — single-var values
```
for($abbr, in([MON,TUE,WED,THU,FRI,SAT,SUN]))
  al(v,x(c),y(c),pad(8)) s(fill,hug) "Day $abbr" #day
    t("$abbr",JetBrains Mono,11,sb)
```
`$abbr` substitutes inside any property — string literals, hex, refs, names.

### `for(vars[...], in([(...),...]))` — multi-var tuples
Tabular data with multiple values per iteration. Encode variants
(color, signal, icon name) directly in the data:
```
for(vars[$abbr,$num,$dColor], in([
  (MON,20,#475569),
  (TUE,21,#475569),
  (WED,22,#10B981),
]))
  al(v,x(c),y(c),pad(8)) s(fill,hug) "Day $abbr" #day
    t("$abbr",Inter,11,sb) f[($dColor)] #abbr
    t("$num",Inter,16,sb) f[(#0F172A)] #num
```

### Seed-scale composition
For-loop substitution runs before var resolution, so `$brand.$step` works:
```
for($step, in([5,10,20,30,40,50,60,70,80,90]), flat)
  r s(48,fill) f[($brand.$step)]
```

## Per-iteration refs — the addressability win

Every iteration's outer frame and every ref'd inner child is addressable.
The suffix is the first declared var (or `$i` for ranges):

| Ref | Points to |
|---|---|
| `#day_MON` | The COMP (first iteration's frame). Modifying propagates to all instances. |
| `#day_TUE`, `#day_WED`, ... | Each instance frame. Modifying one affects only that instance. |
| `#abbr_MON` | Master's child. Propagates. |
| `#abbr_TUE`, ... | Each instance's own child. |

```
# Highlight THU specifically
#day_THU f[(#6366F1)]
#abbr_THU f[(#FFFFFF)]
#num_THU f[(#FFFFFF)]
```

For pure ranges, the suffix is `$i`: `#slot_0, #slot_1, ..., #slot_6`.

## Active-state / exception override

Use the loop for the uniform list, then flat-modify the one that differs.
**Even with one different item, the loop is still right** — don't drop
to hand-coded N-copies.

```
for(vars[$key,$icon,$label], in([
  (home,squares-four,Dashboard),
  (revenue,chart-line,Revenue),
  (orders,shopping-bag,Orders),
]))
  al(h,x(s),y(c),g(12),pad(8,12)) s(fill,hug) "Nav $label" #nav
    svg(icon:$icon) s(18,18) f[(#64748B)] #nav_icon
    t("$label",Inter,13,m) f[(#64748B)] #nav_text

# Active state — three flat-modify lines, not a second loop
#nav_home f[(#F8FAFC)]
#nav_icon_home f[(#0F172A)]
#nav_text_home t("Dashboard",Inter,13,sb) f[(#0F172A)]
```

## `flat` opt-out — independent copies

For genuinely independent copies (no comp+inst link, edits don't propagate):
```
for(range(8), flat)
  c s(8,8) f[(#94A3B8)]
```

`for(...)` auto-falls-back to flat with a warning when the body root isn't
a frame OR has multiple top-level elements per iteration. Wrap in `al(...)`
or `fr` to enable comp+inst sharing.

## Manual `comp` + `inst()` — the escape hatch

When iterations differ heavily in shape (e.g., pricing tiers with 3, 5, 8
features each), drop to manual. Same machinery `for(...)` generates:
```
al(v,g(16),pad(24)) s(300,hug) "Card" comp #card
  t("Title",Inter,18,b) #title
  t("Description",Inter,14) #desc
inst(#card) p(320,0) "Pro" #pro
  override(#title) t("Pro Plan")
  override(#desc) t("For growing teams")
```

Mark a child `slot` to let instances fully replace that subtree
(`#features` below):
```
al(v) "Card" comp #card
  al(v) "Features" slot #features
    t("3 projects",Inter,14)
inst(#card) "Custom"
  #features
    t("Unlimited projects",Inter,14)
    t("Priority support",Inter,14)
```

`inst()` stays synced to master. Use `clone(id)` for an independent copy.

## Limits

- **No nested `for(...)`** — flatten: write outer rows out, use `for(range(N))` per row.
- **No expressions** — `$i+1` doesn't evaluate. Use `$n` for 1-based, or bake values into tuples.
- **Multi-line `in([...])` works** (one tuple per line), but a single tuple `(...)` cannot span lines.
