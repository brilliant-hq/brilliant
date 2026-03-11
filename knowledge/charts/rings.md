---
assumes: blueprint/arcs, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Progress Rings

Assumes: `blueprint/arcs`

## Single Ring

Track + arc + center text in a group:
```
al(v,a(c,c),g(8)) s(hug,hug)
  gr s(80,80)
    c s(80,80) st[(#E2E8F0,w(4))] ratio(1) "Track"
    c s(80,80) st[(#3B82F6,w(4),cap(r,r))] arc(90,75) ratio(1) "Arc"
    t("75%",Inter,18,b,c) p(0,28) s(80,24) f[(#0F172A)] "Pct"
  t("Revenue",Inter,11,m,c) f[(#64748B)] "Label"
```

## Multi-Ring

Concentric rings using `comp` + `inst()` at different sizes:
```
gr s(80,80)
  fr s(80,80) comp #ring
    c p(0,0) s(80,80) st[(#E2E8F0,w(5))] ratio(1) "Track"
    c p(0,0) s(80,80) st[(#3B82F6,w(5),cap(r,r))] arc(90,78) ratio(1) "Arc"
  inst(#ring) p(12,12) s(56,56)
    "Track" p(0,0) s(56,56) st[(#E2E8F0,w(4))]
    "Arc" p(0,0) s(56,56) st[(#10B981,w(4),cap(r,r))] arc(90,62)
  t("78%",Inter,14,b,c) p(0,30) s(80,20) f[(#0F172A)]
```

## Gradient Ring

Angular gradient follows arc naturally:
```
gr s(80,80) "Gradient Ring"
  c p(0,0) s(80,80) st[(#E2E8F0,w(4))] ratio(1) "Track"
  c p(0,0) s(80,80) st[(angular(#3B82F6,#8B5CF6),w(4),cap(r,r))] arc(90,84) ratio(1) "Arc"
```

## Color by Status

Blue `#3B82F6` neutral · Green `#10B981` on-track · Amber `#F59E0B` warning · Red `#EF4444` critical
