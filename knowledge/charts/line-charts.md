---
assumes: blueprint/vectors, blueprint/text, blueprint/components
---
# Data Viz: Line Charts

Frame Overlay: gridlines, axis labels, and data curves overlap inside an
un-clipped frame. The body is `fr`, `clip` is only required for closed
area fills, never stroke-only curves (`clip` + `mi` nodes guarantees a
C405 overshoot warning because bezier handles bulge past node coords).

**Y positions:** `y = chart_height × (1 - value / max_value)`. Gridline
y sits at the LABEL'S BASELINE, not its top, `gridline.y ≈ label.y + 8`
for a 12px-tall `$font.size.xs` label, so the gridline slides under the
glyph rather than through it.

```
-- Simple, stroke-only curve. Body is fr (no clip). Y labels in a left
-- gutter at x=0..40; gridlines start at x=48 so they don't cross labels.
fr s(420,200) "Body"
  t("$30K",$font.family,$font.size.xs,m,align(r)) abs p(0,0) s(40,16) f[($color.text.secondary)]
  t("$15K",$font.family,$font.size.xs,m,align(r)) abs p(0,80) s(40,16) f[($color.text.secondary)]
  t("$0",$font.family,$font.size.xs,m,align(r)) abs p(0,160) s(40,16) f[($color.text.secondary)]
  r abs p(48,8) s(372,1) f[($color.outline.variant)]    -- aligned to LABEL BASELINE (label.y + 8)
  r abs p(48,88) s(372,1) f[($color.outline.variant)]
  r abs p(48,168) s(372,1) f[($color.outline.variant)]
  v(nodes[(0,0,140,mi),(1,93,100,mi),(2,186,72,mi),(3,279,48,mi),(4,372,12,mi)]) abs p(48,8) s(372,160) st[($primary.mid,w($stroke.width.mid))]

-- Complex, area fill under a comparison stroke line. ONLY the area fill
-- needs a clip wrapper (to mask the closing bottom edge); the comparison
-- line stays absolute alongside it.
fr s(420,200) "Body2"
  -- ...same labels + gridlines as above...
  v(nodes[(0,0,120,mi),(1,93,108,mi),(2,186,96,mi),(3,279,84,mi),(4,372,72,mi)]) abs p(48,8) s(372,160) st[($color.outline,w($stroke.width.soft))]    -- previous period, stroke only
  al(v,g($spacing.none),pad($spacing.lg,$spacing.none,$spacing.none,$spacing.none)) abs p(48,-16) s(372,176) clip "AreaClip"
    v(nodes[(0,0,140,mi),(1,93,100,mi),(2,186,72,mi),(3,279,48,mi),(4,372,12,mi),(5,372,160),(6,0,160)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6),(6,6,0)],closed) s(fill,fill) f[(linear(180,stop($primary.mid,0,o($visibility.soft)),stop($primary.mid,1,o($visibility.invisible))))] st[($primary.mid,w($stroke.width.mid),pos(o))]
```

**Legend:** dot + label pairs via `comp` + `inst()` (see `blueprint/components`).

**Three rules:**

1. **No `clip` on the body**: only on the area-fill wrapper. Stroke-only
   curves don't need masking.
2. **Area-fill top pad ≥ stroke width + handle bulge**: `$spacing.lg`
   covers most rises; raise it when consecutive nodes drop steeply
   (the curve bulges above the first node by ~30% of that drop).
3. **Gridline y = label baseline**, not label top. Labels read cleanly
   only when the gridline runs *under* them.
