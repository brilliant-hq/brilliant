---
name: "building-blocks"
description: "Compact anatomy reference for 55+ UI components. Structural recipes using layout patterns from LAYOUTS.md — full DSL only for non-obvious tricks."
---

# Component Reference

Anatomy recipes for common UI components. Each entry decomposes the component into layout patterns from LAYOUTS.md. The agent constructs DSL from these descriptions and its knowledge of primitives. Full DSL shown only where the construction trick is non-obvious.

> **These are recipes, not templates.** Adapt colors, sizing, spacing, and structure freely. Learn the anatomy, then reinvent.

> **Shadows add realism where appropriate.** Buttons feel pressable, cards float, toasts hover. See TECHNIQUES.md for shadow elevation scale and when to use effects. A card without a shadow is a wireframe. Adapt to the design's personality.

> **Parent stacks need gap.** A card's `pad()` is internal — it spaces content inside the card, not between cards. When cards, metric tiles, or sections are siblings in a vertical scroll, their parent needs `g(12-16)` to create visible breathing room between them. Without it, sibling cards jam together regardless of how generous their internal padding is. This applies at every level: a page content wrapper with 5 card children and `g(0)` = 5 cards touching edge-to-edge.

---

## Actions

### Button
Inline row a(c,c) pad(10,20) s(hug,hug) rd(8). Primary: solid dark fill + white text(14,sb) + layered shadow. Secondary: no fill, 1px stroke + dark text. Icon variant: add g(8), svg icon(16x16) before or after label. CTA buttons are solid — never gradient.

### Button Group
H-row g(0-2). Buttons as children sharing a visual container. With gap: uniform rd per button. Without gap: first rd(8,0,0,8), middle rd(0), last rd(0,8,8,0). Active: filled. Inactive: stroke or tinted bg.

### Segmented Control
H-row pad(3) g(2) f[(#F1F5F9)] rd(10). Each segment: centered row pad(6,14) rd(8). Active: white fill + shadow + sb text. Inactive: no fill + muted text(13-14,m).

### Toggle Switch
Knob position via main-axis alignment — `a(e,c)` for on, `a(s,c)` for off:
```
al(h,a(e,c),pad(3)) s(44,26) f[(#8B5CF6)] rd(9999) "On"
  al(h,a(c,c)) s(20,20) f[(#FFF)] rd(9999) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
al(h,a(s,c),pad(3)) s(44,26) f[(#E4E4E7)] rd(9999) "Off"
  al(h,a(c,c)) s(20,20) f[(#FFF)] rd(9999) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
```

### Floating Action Button (FAB)
Centered frame s(56,56) rd(9999) accent fill + high shadow. Icon s(24,24) white. Position at bottom-right corner.

---

## Inputs

### Text Input
V-stack g(6) s(fill,hug). Label text(14,m) + input frame: H-row a(s,c) g(10) pad(0,14) s(fill,44) white fill + inner shadow `inner(#000,0.06,0,1,2)` for inset feel + 1px stroke rd(8). Optional leading icon(16x16, #94A3B8). Placeholder text(15, #94A3B8).

### Textarea
V-stack g(6). Label row: spaceBetween(name(14,m) + counter "0/500"(13, muted)). Input: V-stack a(s,s) pad(12,14) s(fill,120-200) stroke rd(8). Placeholder text s(fill,hug). Fixed height, top-aligned via `a(s,s)`.

### Search Input
H-row a(s,c) g(8) pad(0,14) s(fill,44) stroke rd(9999 or 8). magnifying-glass icon(16x16, muted) + placeholder text. Optional trailing x icon as clear button.

### Select / Dropdown
Closed state: like Text Input but with caret-down icon(16x16) trailing instead of editable text — shows selected value text. Open state: append Dropdown Menu below.

### Checkbox
H-row a(s,c) g(10). Box: centered frame s(20,20) rd(4). Checked: accent fill + `t("\u2713",Inter,12,b)` white. Unchecked: 1.5px neutral stroke only. Label text(14).

### Radio Button
H-row a(s,c) g(10). Circle: centered frame s(20,20) rd(9999). Selected: accent 2px stroke + inner dot `c s(10,10)` accent fill. Unselected: neutral 1.5px stroke only. Label text(14).

### Slider
Group s(W,16). Track: rect s(W,4) rd(9999) muted fill. Filled track: rect s(FILL_W,4) rd(9999) accent fill. Thumb: circle frame s(16,16) rd(9999) white fill + shadow + accent stroke. Value label above thumb optional.

### File Upload / Dropzone
V-stack a(c,c) g(8) pad(24,32) s(fill,hug). Dashed-look 2px muted stroke, rd(12). upload icon(32x32, muted) + instruction text(14) + "Browse" accent text(14,sb).

### Date Input
Text Input variant with calendar-blank icon(16x16) as leading icon. Value formatted as date string. For calendar picker: grid of 7 columns (day names header + 5-6 rows of date numbers).

---

## Navigation

### Horizontal Navbar
spaceBetween row pad(12,32) s(SCREEN_W,hug) white fill. Three groups: Logo (H-row g(10): icon frame + brand text(18,b)), Nav (H-row g(4): link items pad(8,16) with text(14,m)), Right (H-row g(12): text link + CTA button). 1px bottom stroke or subtle shadow.

### Sidebar
V-stack a(sb,c) pad(12,0) s(64-240,fill) dark fill. Top(V-stack: logo + divider + nav V-stack g(2-4)) + **Bottom(settings/profile)**. Ensure clear separation between Top and Bottom (e.g. `g(12-20)` on the outer sidebar stack, or a divider above Bottom). Nav item: H-row a(s/c,c) g(8) pad(8-12) s(fill or 40, hug or 40) rd(8). Active: tinted fill + accent icon. Inactive: no fill + muted icon. Sidebar MUST have fixed height for spaceBetween.

### Tabs (Underline)
```
al(h,a(s,e),pad(0,16)) s(hug,hug) "Tab Bar"
  al(v,a(c,e),pad(12,16,0,16)) s(hug,hug) "Active"
    t("Tab",Inter,13,sb) f[(#3B82F6)] "Lbl"
    r s(fill,2) f[(#3B82F6)] "Indicator"
  al(v,a(c,e),pad(12,16,0,16)) s(hug,hug) "Inactive"
    t("Tab",Inter,13,m) f[(#64748B)] "Lbl"
    r s(fill,2) f[(parent-bg-color)] "Indicator"
```
Key: `a(s,e)` pushes indicators to bottom. Inactive indicator uses parent bg color (invisible). Optional content panel V-stack below.

### Bottom Tab Bar (Mobile)
Floating pill: H-row a(c,c) g(4) pad(6) s(hug,hug) dark fill rd(9999) high shadow. Active tab: H-row g(6) pad(8,16) accent fill rd(9999) with icon + label. Inactive: icon only pad(8,12) no fill.

### Breadcrumbs
H-row g(4-8) a(s,c). **Interleave exactly:** item → caret-right → item → caret-right → last item (no double separators). caret-right icons(12x12, muted). Last item: sb weight, dark. Earlier items: muted, regular weight.

### Pagination
H-row a(c,c) g(4). Prev/next: icon buttons (arrow-left, arrow-right) or text. Page numbers: centered frames s(32-36,32-36) rd(8). Active: accent fill + white text. Inactive: no fill + muted text. Ellipsis `t("...")` for gaps.

### Stepper
```
al(h,a(c,s),g(0)) s(hug,hug) "Steps"
  al(v,a(c,c),g(6)) s(hug,hug) "Step"
    al(h,a(c,c)) s(28,28) f[(accent)] rd(9999) "Circle"
      t("\u2713",Inter,14,b,c) f[(#FFF)] "Mark"
    t("Label",Inter,11,m,c) f[(accent)] "Name"
  al(h,a(c,c)) s(48,28) "Connector"
    r s(48,2) f[(accent-or-muted)] "Line"
  ... repeat step + connector ...
```
Completed: accent fill + checkmark. Current: accent fill + number. Future: stroke-only circle + muted text. Connector: accent if completed, muted if pending.

---

## Data Display

### Card
V-stack g(12-16) pad(20-24) s(W,hug) white fill + 1px stroke + rd(12) + shadow. Title(18-20,sb) + description(14, muted, s(fill,hug)) + optional action row at bottom. **Image-top:** add `clip` on card, image s(fill,160-200) as first child before content. **Horizontal:** H-row — image s(fixed-W,fill) + content V-stack s(fill,hug). **Parent:** cards stacked vertically need `g(12-16)` on the parent wrapper — card padding is internal only.

### List Item
H-row a(s,c) g(12) pad(12,16) s(fill,hug). Optional leading (icon frame or avatar) + center V-stack s(fill,hug): title(14,m) + subtitle(13, muted) + optional trailing element (badge, chevron caret-right, timestamp text). 1px divider between items.

### Table
V-stack g(0). Header row: H-row, cells s(fill,hug) pad(8,12) tinted bg — text(13,sb, muted). Body rows: H-row, cells s(fill,hug) pad(8,12) — text(14). Right-align number cells. 1px dividers between rows. All rows must have same cell count for column alignment. See LAYOUTS.md Grid Patterns for structural detail.

### Avatar
Centered frame s(32-48,32-48) rd(9999) accent fill. Initials text(13-16,sb) white. Why a frame: circles can't contain children — use frame + `rd(9999)` + `a(c,c)`.

### Avatar Stack
```
al(h,g(-8)) s(hug,hug) "Stack"
  al(h,a(c,c)) s(32,32) f[(#3B82F6)] st[(#FFF,2)] rd(9999) "A1"
    t("A",Inter,13,sb) f[(#FFF)]
  al(h,a(c,c)) s(32,32) f[(#8B5CF6)] st[(#FFF,2)] rd(9999) "A2"
    t("M",Inter,13,sb) f[(#FFF)]
  al(h,a(c,c)) s(32,32) f[(#E2E8F0)] st[(#FFF,2)] rd(9999) "More"
    t("+3",Inter,12,sb) f[(#64748B)]
```
`g(-8)` creates overlap. White 2px stroke separates. Last item: "+N" counter with muted fill.

### Badge / Status Pill
Inline row a(c,c) pad(2-4,8-12) s(hug,hug) rd(9999). Text(12,m). Tinted bg + saturated text:

| Status | Background | Text |
|--------|-----------|------|
| Success | `#ECFDF5` | `#10B981` |
| Warning | `#FFFBEB` | `#D97706` |
| Error | `#FEF2F2` | `#EF4444` |
| Info | `#EFF6FF` | `#3B82F6` |
| Neutral | `#F1F5F9` | `#64748B` |

### Stat / Metric Card
V-stack g(4-8) pad(16-20) s(fill,hug). Label text(12-13,m, muted) + value text(24-32,sb) + optional delta row: H-row g(4) — arrow-up/arrow-down icon(12x12, green/red) + percentage text(13,m, green/red). **Parent:** typically 3-4 siblings in `al(h,g(8-12))` — parent gap spaces the tiles apart.

### Rating
H-row g(2). Star icons(16-20x16-20). **Conventional ordering:** filled stars on the left, empty stars on the right. Filled: `st[(#F59E0B,2)]`. Empty: `st[(#E2E8F0,2)]`. Optional value text(14,sb) and count text(14, muted) after stars.

### Quote / Testimonial
V-stack g(12-16) pad(20-24). Large open-quote `t("\u201C",serif-font,48-64)` muted, or quote icon. Quote text(16-18, italic or regular, s(fill,hug)). Attribution: H-row g(12) — avatar(32x32) + V-stack(name(14,sb) + role(13, muted)).

### Tree View
V-stack g(0). Node: H-row a(s,c) g(8) pad(4,8+indent). Indent via increasing left padding (16-24px per depth level). Expandable: caret-right icon(12x12, rot(90) when expanded) + label(14). Leaf: no caret, extra left padding to align with sibling labels. Optional file/folder icons.

### Image
Rect s(fill,H) f[(#F1F5F9)] rd(8) clip. Placeholder: centered image icon(32x32, muted). With content: `f[(img(url))]`. Common ratios: 16:9 (hero), 4:3 (card), 1:1 (avatar/thumb), 3:2 (gallery).

---

## Feedback

### Alert / Banner
H-row a(s,s) g(12) pad(12,16) s(fill,hug) rd(8). Status icon(20x20) + V-stack s(fill,hug): title(14,m) + message(14) + optional dismiss **x icon (typically 14–16px in compact UI)** trailing. Colored bg + 1px border per variant:

| Variant | Background | Border | Icon/Title | Body |
|---------|-----------|--------|-----------|------|
| Success | `#ECFDF5` | `#A7F3D0` | `#10B981` / `#065F46` | `#047857` |
| Error | `#FEF2F2` | `#FECACA` | `#EF4444` / `#991B1B` | `#991B1B` |
| Warning | `#FFFBEB` | `#FDE68A` | `#F59E0B` / `#92400E` | `#92400E` |
| Info | `#EFF6FF` | `#BFDBFE` | `#3B82F6` / `#1E40AF` | `#1E40AF` |

### Toast
H-row a(s,c) g(12) pad(12,16) s(320-400,hug) rd(10) + shadow for float. Icon(20x20) + V-stack s(fill,hug): title(14,m) + body(13) + trailing **x close icon (typically 14–16px in compact UI)**. Same color system as Alert. Position: top-right or bottom-center of screen.

### Modal / Dialog
Scrim: rect filling parent, `solid(#000,0.5)`. Dialog: V-stack pad(24) s(480-560,hug) white fill rd(16) high shadow, centered. Header: spaceBetween(title(18,sb) + x close icon). Content: V-stack g(16). Footer: H-row a(e,c) g(8) — secondary button + primary button.

### Drawer
V-stack s(360-480,fill) white fill + high shadow. Positioned at left or right edge. Header: spaceBetween row pad(16,20) — title(18,sb) + x close. Scrollable content V-stack g(16) pad(0,20). Optional sticky footer with actions.

### Bottom Sheet
```
al(v) s(SCREEN_W,hug) f[(#FFF)] rd(20,20,0,0) shadow(#000,o(0.12),y(-4),blur(16)) "Sheet"
  al(h,a(c),pad(12,0)) s(fill,hug) "Handle"
    r s(36,4) f[(#D1D5DB)] rd(9999) "Bar"
  al(v,g(4),pad(8,16,16,16)) s(fill,hug) "Content"
    ... option items: H-row a(s,c) g(12) pad(12) s(fill,hug) rd(8) — icon(20x20) + label(16)
```
Top-only radius `rd(20,20,0,0)`. Upward shadow `y(-4)`. Drag handle bar centered at top. Destructive actions below a divider in red.

### Dropdown Menu
V-stack pad(4-8) s(200-280,hug) white fill rd(8) + high shadow + 1px stroke. Menu items: H-row a(s,c) g(8) pad(8,12) s(fill,hug) rd(4). Icon(16x16, muted) + label(14). Hover: tinted bg. Destructive items: red text/icon. Dividers between groups.

### Popover
V-stack pad(8-12) s(200-320,hug) white fill rd(8) + high shadow. Content varies: menu items, description text, or compact form. Positioned near trigger element with offset.

### Tooltip
Compact pad(6-8,12) s(hug,hug) dark fill (#1E293B) rd(6). White text(12-13). Single line. Positioned near trigger with small offset. Arrow optional (small rotated square at edge).

### Progress Bar
**Flex variant** (resizes with parent, no math):
```
al(h) s(200,6) f[(#E2E8F0)] rd(9999) clip "Progress"
  r s(fill:3,fill) f[(#3B82F6)] rd(9999) "Fill"
  r s(fill:1,fill) "Empty"
```
75% filled. Ratio = percentage: `fill:4`+`fill:1` = 80%, `fill:1`+`fill:1` = 50%. **Group variant** for exact pixels: Track-and-Fill from LAYOUTS.md.

### Spinner
Circle with partial arc stroke: `c s(24-32,24-32) arc(0,75) ratio(1) st[(#3B82F6,3)]`. Larger: s(48,48) with thicker stroke. Or use arrows-clockwise icon.

### Skeleton
Rects mimicking the layout of loading content. Each placeholder: rd(4-8) f[(#E2E8F0)]. Text line: s(60-80% width, 14-16). Heading: s(40-50% width, 20-24). Image area: s(fill, aspect-height). Match gap/spacing of the real content structure.

### Empty State
V-stack a(c,c) g(12-16) pad(40-60) s(fill,hug). Large icon(48-64x48-64, muted) or illustration. Title(18,sb, centered) + description(14, muted, centered, s(400-500,hug)) + optional CTA button.

---

## Layout Components

### Separator / Divider
Horizontal: `r s(fill,1) f[(#E2E8F0)]`. Vertical: `r s(1,fill) f[(#E2E8F0)]`. With label: H-row a(c,c) g(12) — divider s(fill,1) + text(12, muted) + divider s(fill,1).

### Header
spaceBetween row pad(16-20,24-32) s(fill,hug). Logo left + optional nav center + actions right. Bottom: 1px stroke or subtle shadow. See Navbar for full structure.

### Footer
V-stack pad(40-60,32-64) s(fill,hug) tinted or dark fill. Top: H-row g(32-48) with link column groups (V-stack g(8): heading(13,sb) + link items(14, muted)). Bottom: spaceBetween row — copyright text(13, muted) + social icon row(H-row g(12): brand logo icons).

### Hero
V-stack a(c,c) g(20-32) pad(80-120,64) s(fill,hug). Optional eyebrow above title (see TECHNIQUES.md for variants). Title(40-56, m/sb, centered) + subtitle(16-18, muted, centered, s(500-700,hug)) + CTA row(H-row g(12-16): primary + secondary button). Optional product screenshot or illustration below.

### Accordion
V-stack g(0) s(fill,hug). Items separated by 1px dividers. **Item** = V-stack: header (spaceBetween row pad(12,16) — title(14,m) + caret-down icon(16x16)) + content panel (V-stack pad(0,16,12,16) s(fill,hug), description text). Expanded: sb title, `rot(180)` on chevron, panel visible. Collapsed: normal weight title, omit panel entirely.

### Carousel
Content area with visible slide(s) in a clip frame. Dot indicators below: H-row a(c,c) g(6-8) — active dot `c s(8,8)` accent fill, inactive dots `c s(8,8)` muted fill. Optional prev/next arrow icon buttons positioned at sides. Slides use fixed width matching visible area.

### Form
V-stack g(16-20) pad(24-32) s(fill or 400-500, hug). Sequential field groups (each is a Text Input / Select / Checkbox / etc. from above). Optional section headers(14,sb) to group related fields. Error text(13, #EF4444) below invalid inputs. Submit button at bottom — full width or right-aligned row. Note: the form's `g(16-20)` spaces fields apart — individual inputs don't need outer margin.

---

## Communication

### Chat Bubble
Asymmetric radius indicates direction:
```
al(v,pad(10,14)) s(240,hug) f[(#3B82F6)] rd(16,16,4,16) "Sent"
  t("Message text",Inter,14) s(fill,hug) f[(#FFF)]
  t("2:34 PM",Inter,11) f[(solid(#FFF,0.6))]
al(v,pad(10,14)) s(240,hug) f[(#F1F5F9)] rd(16,16,16,4) "Received"
  t("Reply text",Inter,14) s(fill,hug) f[(#0F172A)]
  t("2:35 PM",Inter,11) f[(#94A3B8)]
```
Sent: `rd(16,16,4,16)` small bottom-right. Received: `rd(16,16,16,4)` small bottom-left. Width ~60-70% of container.

### Notification Dot
Numberless: `c s(8-10,8-10) f[(#EF4444)]` positioned at **true top-right corner** of parent (often slightly overlapping: a few px up/right). With count: centered frame s(18-20,18-20) rd(9999) red fill + `t("3",Inter,11,sb)` white.

---

## Decorative

### Accent Bar / Edge Stripe
Thin colored strip at card edge. **CRITICAL: `clip` required on parent.**
```
al(v,g(12),pad(0)) clip s(W,hug) f[(#FFF)] st rd(12) shadow "Card"
  r s(fill,4) f[(linear(90,#3B82F6,#8B5CF6))] "Accent"
  al(v,g(12),pad(20,24)) s(fill,hug) "Content"
    ... title, description, etc.
```
Top bar: s(fill,4). Side bar: s(4,fill) in al(h). Without `clip`, bar extends beyond rounded corners.

---

## Styled Text Patterns

Use `spans[...]` continuation lines for per-character styling within one text element.

### Accent Word
One word pops with color: `t("Build something amazing",Inter,48,b) f[(#1C1917)]` then `spans[("amazing",b,#3B82F6)]`. Variants: italic `("word",i,#hex)`, lighter weight `("word",w(400),#hex)`, different font `("word",f(Playfair Display),i)`.

### Price Format
Mixed sizes in one element: `t("$49/month",Inter,14) f[(#0F172A)]` then `spans[("$49",s(36),b,#3B82F6),("/month",#64748B)]`.

### Mixed Typeface
Serif + sans-serif: `t("The art of modern design",Lora,44,b) f[(#1C1917)]` then `spans[("modern design",f(Inter))]`.
