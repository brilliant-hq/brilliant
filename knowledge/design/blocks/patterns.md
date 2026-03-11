---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Composition Patterns

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Inline Elements in Headlines
Icon or decorative element BETWEEN words. Split into fragments in `al(h)`:
```
al(v,a(c,c),g(4)) s(hug,hug) "Title"
  al(h,a(c,c),g(10)) s(hug,hug)
    t("We Take Your",Playfair Display,40,b) f[(#1C1917)]
    al(h,a(c,c)) s(44,44) f[(#EFF6FF)] rd(12)
      svg(icon:envelope-simple) s(24,24) st[(#3B82F6,w(2))]
    t("Email",Playfair Display,40,b) f[(#3B82F6)]
  t("Marketing to the Next Level",Playfair Display,40) italic f[(#1C1917)]
```
One inline element per headline max.

## Bento Grid
Mixed-size cards — tall + wide + square:
```
al(v,g(12)) s(800,hug) "Bento"
  al(h,g(12)) s(fill,hug)
    al(v,pad(24)) s(fill,120) f[(#171717)] rd(16)
      t("Dashboard",Inter,16,sb) f[(#F8FAFC)]
      t("Real-time analytics",Inter,13) f[(#71717A)]
    al(v,a(c,c)) s(120,120) f[(#EFF6FF)] rd(16)
      t("24",Inter,32,b) f[(#3B82F6)]
      t("alerts",Inter,12) f[(#64748B)]
```
Mix `fill` (stretchy) and `fixed` (rigid). Different bg colors per cell. One cell dramatically different size.

## Stacked / Tilted Cards
Group Overlay for overlapping cards. Use `comp`/`inst()` for repeated card structure:
```
gr s(320,200) "Showcase"
  al(v,pad(20)) rot(-4) p(60,40) s(200,hug) f[(#FFF)] st[(#E2E8F0,w(1))] rd(12) shadow(#000,o(0.08),y(4),blur(12)) comp #scard "Back"
    t("Back Card",Inter,14,sb) f[(#0F172A)] "Title"
    t("Offset & rotated",Inter,12) f[(#64748B)] "Desc"
  inst(#scard) rot(2) p(40,25) "Mid"
    "Title" t("Mid Card")
    "Desc" t("Stacked overlays")
  inst(#scard) rot(-1) p(20,10) shadow(#000,o(0.12),y(4),blur(16)) "Front"
    "Title" t("Front Card")
    "Desc" t("Top of the stack")
```
First = back, last = front. Offset 15-20px. Rotation -5° to 5°.

## Image + Gradient Overlay
Image fill + dark overlay stacked as fills. Replace `img(URL)` with a real image URL:
```
fr s(480,240) f[(linear(135,#1E3A5F,#0F172A)),(f2,solid(#09090B,o(0.40)))] rd(16) "Visual"
  al(v,a(c,c),g(12),pad(40)) s(fill,fill) "Content"
    t("Your Headline Here",Inter,28,sb,c) f[(#FAFAFA)]
    t("Overlay keeps text readable over any image",Inter,14,c) s(fill,hug) f[(solid(#FAFAFA,o(0.70)))]
```

## Low-Opacity Watermark
Group Overlay with oversized text at 3-8% opacity:
```
gr s(800,400)
  t("DESIGN",Inter,180,bl) p(60,-20) f[(solid(#18181B,o(0.04)))]
  al(v,a(c,c),g(24),pad(60)) s(fill,fill) "Content"
```

## Chat Bubble
Asymmetric radius: sent `rd(16,16,4,16)` small bottom-right, received `rd(16,16,16,4)` small bottom-left. Width ~60-70% container.

## Accent Bar / Edge Stripe
**`clip` required on parent:**
```
al(v,g(12),pad(0)) clip s(W,hug) f[(#FFF)] rd(12) st[(#E2E8F0,w(1))] shadow(#000,o(0.04),y(2),blur(8)) "Card"
  r s(fill,4) f[(linear(90,#3B82F6,#8B5CF6))] "Accent"
  al(v,g(8),pad(16,20)) s(fill,hug) "Content"
    t("New Feature",Inter,15,sb) f[(#0F172A)]
    t("Accent bar draws the eye to this card",Inter,13) s(fill,hug) f[(#64748B)]
```

## Notification Dot
Numberless: `c s(8-10,8-10) f[(#EF4444)]`. With count: centered frame `s(18-20,18-20) rd(9999)` red + text(11,sb) white.
