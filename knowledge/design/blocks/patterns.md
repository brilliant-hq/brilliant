---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Composition Patterns

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Inline Elements in Headlines
Icon or decorative element BETWEEN words. Split into fragments in `al(h)`:
```
$brand=#F59E0B
$neutral=#64748B
$font=Playfair Display
al(v,a(c,c),g($spacing.1),pad($spacing.none)) s(hug,hug) "Title" #title_block
  al(h,a(c,c),g($spacing.3),pad($spacing.none)) s(hug,hug) #title_row1
    t("We Take Your",$font,40,b) f[($neutral.90)] #t1
    al(h,a(c,c),g($spacing.none),pad($spacing.none)) s(44,44) f[($brand.5)] rd($radius.md) #icon_box
      svg(icon:envelope-simple) s(24,24) st[($brand.50,w(2))] #icon
    t("Email",$font,40,b) f[($brand.50)] #t2
  t("Marketing to the Next Level",$font,40) italic f[($neutral.90)] #t3
```
One inline element per headline max.

## Bento Grid
Flex ratios create asymmetric cells. Fixed row heights + `fill:N` children = bento layout without pixel math:
```
$brand=#84CC16
$neutral=#64748B
al(v,g($spacing.3),pad($spacing.none)) s(520,hug) "Bento" #bento
  al(h,g($spacing.3),pad($spacing.none)) s(fill,200) #bento_r1
    al(v,a(s,s),g($spacing.2),pad($spacing.5)) s(fill:3,fill) f[(#171717)] rd($radius.md) #feat
      t("Analytics",Inter,18,sb) f[(#F8FAFC)] #feat_title
      t("Real-time dashboard with live metrics",Inter,13) s(fill,hug) f[($neutral.40)] #feat_desc
    al(v,g($spacing.3),pad($spacing.none)) s(fill:2,fill) #rcol
      al(h,g($spacing.3),pad($spacing.none)) s(fill,fill) #urow
        al(v,a(c,c),g($spacing.1),pad($spacing.3)) s(fill,fill) f[($brand.5)] rd($radius.md) #u1
          t("2.4K",Inter,20,b) f[($brand.50)]
          t("users",Inter,10) f[($neutral.50)]
        al(v,a(c,c),g($spacing.1),pad($spacing.3)) s(fill,fill) f[($brand.5)] rd($radius.md) #u2
          t("8.1K",Inter,20,b) f[($brand.50)]
          t("sessions",Inter,10) f[($neutral.50)]
      al(v,a(c,c),g($spacing.1),pad($spacing.4)) s(fill,fill) f[(#FEF2F2)] rd($radius.md) #uptime
        t("99.9%",Inter,24,b) f[(#EF4444)]
        t("uptime",Inter,11) f[($neutral.50)]
  al(v,a(c,c),g($spacing.none),pad($spacing.4)) s(fill,100) f[($brand.10)] rd($radius.md) #cta
    t("Growth is up 24% this quarter \u2014 view full report",Inter,14,sb) f[($brand.70)]
```
Mix `fill` (stretchy) and `fixed` (rigid). Different bg colors per cell. One cell dramatically different size.

## Stacked / Tilted Cards
Overlapping cards with free positioning. Use `comp`/`inst()` for repeated card structure. Group for standalone, `abs` inside auto layout:
```
$neutral=#64748B
gr s(320,200) "Showcase" #showcase
  al(v,g($spacing.none),pad($spacing.4)) rot(-4) p(60,40) s(200,hug) f[(#FFF)] st[($neutral.20,w(1))] rd($radius.md) shadow(#000,o(0.08),y(4),blur(12)) comp #scard "Back"
    t("Back Card",Inter,14,sb) f[($neutral.90)] "Title" #scard_title
    t("Offset & rotated",Inter,12) f[($neutral.50)] "Desc" #scard_desc
  inst(#scard) rot(2) p(40,25) "Mid"
    override(#scard_title) t("Mid Card")
    override(#scard_desc) t("Stacked overlays")
  inst(#scard) rot(-1) p(20,10) shadow(#000,o(0.12),y(4),blur(16)) "Front"
    override(#scard_title) t("Front Card")
    override(#scard_desc) t("Top of the stack")
```
First = back, last = front. Offset 15-20px. Rotation -5° to 5°.

## Image + Gradient Overlay
Image fill + dark overlay stacked as fills. Replace `img(URL)` with a real image URL:
```
$neutral=#64748B
fr s(480,240) f[(linear(135,#1E3A5F,#0F172A)),(f2,solid(#09090B,o(0.40)))] rd($radius.md) "Visual" #visual
  al(v,a(c,c),g($spacing.3),pad($spacing.8)) s(fill,fill) "Content" #visual_content
    t("Your Headline Here",Inter,28,sb,align(c)) f[($neutral.5)] #visual_title
    t("Overlay keeps text readable over any image",Inter,14,align(c)) s(fill,hug) f[(solid($neutral.5,o(0.70)))] #visual_desc
```

## Low-Opacity Watermark
Oversized text at 3-8% opacity. Use `abs` inside auto layout, or group for standalone:
```
$font=Inter
al(v,a(c,c),g($spacing.6),pad($spacing.16)) s(800,400) "Content"
  t("DESIGN",$font,180,bl) abs p(60,-20) f[(solid(#18181B,o(0.04)))]
  t("Your content here",$font,18) f[(#18181B)]
```

## Chat Bubble
Asymmetric radius: sent `rd(16,16,4,16)` small bottom-right, received `rd(16,16,16,4)` small bottom-left. Width ~60-70% container.

## Accent Bar / Edge Stripe
**`clip` required on parent:**
```
$brand=#B87333
$accent=#92400E
$neutral=#64748B
al(v,g($spacing.3),pad($spacing.none)) clip s(340,hug) f[(#FFF)] rd($radius.md) st[($neutral.20,w(1))] shadow(#000,o(0.04),y(2),blur(8)) "Card" #accent_card
  r s(fill,4) f[(linear(90,$brand.50,$accent.50))] "Accent" #accent_bar
  al(v,g($spacing.2),pad($spacing.4,$spacing.4)) s(fill,hug) "Content" #accent_content
    t("New Feature",Inter,15,sb) f[($neutral.90)] #accent_title
    t("Accent bar draws the eye to this card",Inter,13) s(fill,hug) f[($neutral.50)] #accent_desc
```

## Notification Dot
Numberless: `c s(8-10,8-10) f[(#EF4444)]`. With count: centered frame `s(18-20,18-20) rd($radius.full)` red + text(11,sb) white. Position with `abs` on a card or avatar container:
```
al(h,a(s,c),g($spacing.3),pad($spacing.3)) s(fill,hug) "List Item"
  fr s(40,40) "Avatar Wrap"
    c s(40,40) f[(#14B8A6)] rd($radius.full) "Avatar"
    c abs p(28,0) s(12,12) f[(#EF4444)] st[(#FFF,w(2))] rd($radius.full) "Dot"
  al(v,g(2),pad($spacing.none)) s(fill,hug)
    t("Username",Inter,14,m) f[(#0F172A)]
    t("Online",Inter,12) f[(#10B981)]
```
