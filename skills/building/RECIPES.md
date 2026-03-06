---
name: "building-recipes"
description: "Ready-to-use effect combination recipes: glass compositions, neon labels, button states, claymorphism, dark mode, embossed text, gradients, liquid glass, animation speed."
---

> **Parent skill:** [building/SKILL.md](./SKILL.md) · **Companion:** [TECHNIQUES.md](./TECHNIQUES.md)

# Effect & Style Recipes

Ready-to-use DSL recipes for specific visual styles. Load this alongside TECHNIQUES.md when building designs that use effects, dark mode, button states, glassmorphism, or claymorphism.

> **Prerequisite:** These recipes assume you've read TECHNIQUES.md — especially Professional Shadows (layered shadow principle, elevation scale) and Brilliant Power Moves (inner shadow, inner glow, background blur, shaders, shader strokes). The recipes below combine those building blocks into complete compositions.

---

## Effect Combination Recipes

Individual effects are good. **Stacked effects are transformative.** These combos create results that no single fill, shadow, or shader can achieve alone.

### Glass Over Living Background

The signature "premium" look — animated shader underneath, frosted glass card on top. **Why it works:** the shader provides the rich, colorful depth that glass needs to be meaningful — the blur reveals-but-obscures the motion, creating a focal card that feels connected to the energy below.

```
fr s(1280,600) f[(f1,#000000),(f2,metal(#CA00FF,#FFFFFF,shape(circle),softness(0.10),repetition(2),shiftRed(0.30),shiftBlue(0.30),distortion(0.07),contour(0.40),angle(70),speed(1),scale(3),uvrot(210)))] clip "Hero"
  al(v,a(c,c)) s(fill,fill) "Center"
    al(v,a(c,c),g(20),pad(40)) s(480,hug) f[(f1,inner(#B6B6B6,0.40,0,2,32)),(f2,blur(16))] st[(s1,solid(#FFFFFF,0.10),1,r,r)] rd(9999) "Glass Card"
      t("Engineered for\nperformance",Inter,36,sb,c) f[(f1,#F5F5F4)] "Title"
      t("Industrial-grade infrastructure.",Inter,16,r,c) s(400,hug) f[(f1,#FFFDFC)] "Subtitle"
      al(h,a(c,c),pad(12,24)) s(hug,hug) f[(f1,#F5F5F4)] rd(9999) "CTA"
        t("Get Started",Inter,14,sb) f[(f1,#1C1917)] "Label"
```

**Variations:** Swap `metal()` for `metaballs()` (organic), `holo()` (iridescent), or a simple `linear()` gradient. The glass card + blur works over any rich background.

### Holographic Badge

Premium label with shimmer. Holographic stroke + inner glow + colored shadow = foil-card effect with readable text:

```
al(h,a(c,c),pad(4,12)) s(hug,hug) f[(f1,#1E1B4B),(f2,glow(#C7D2FE,0.3,6))] st[(s1,holo(#E879F9,#67E8F9,intensity(0.5),metallic(0.8),speed(0.3)),1.5)] rd(9999) shadow(#8B5CF6,o(0.15),blur(12)) "Badge"
  t("Featured",Inter,12,sb) f[(f1,#E0E7FF)] "Label"
```

The holographic effect lives on the **stroke**, not the fill — text sits on the solid dark fill and stays perfectly readable while the border shimmers.

### Metallic Accent Divider

A thin `metal()` strip as a section divider — small element, massive visual impact:

```
r s(200,3) f[(f1,metal(#FFD700,#FFF8DC,softness(0.5),speed(0.2)))] rd(9999) "Divider"
```

Use between hero and content, between pricing tiers, or as a card header accent. At 2-4px height, the chrome effect catches light without overwhelming.

### Frosted Glass + Inner Shadow

**Why it works:** The inner shadow adds what real glass has — a slight bevel where light catches the edge. Blur alone makes a flat frosted surface; the inner shadow gives it thickness and physicality:

```
al(v,g(16),pad(24)) s(360,hug) f[(f1,solid(#FFF,0.10)),(f2,blur(12)),(f3,inner(#000,0.08,0,1,3))] st[(s1,solid(#FFF,0.15),1)] rd(16) shadow(#000,o(0.06),y(8),blur(24)) "Glass Panel"
  t("Analytics",Inter,18,sb) f[(f1,#F9FAFB)] "Title"
  t("Real-time insights",Inter,14) s(fill,hug) f[(f1,#94A3B8)] "Desc"
```

### Glass Logo Effect

Apply per-region glass fills to a multi-region vector (e.g. an imported SVG logo). Read the vector with `get_blueprint` — it shows `vr()` lines per region with SVG path data. Then modify each region independently:

```
abc123
  vr(r1) f[(f1,solid(#3B82F6,0.15)),(f2,blur(12)),(f3,inner(#000,0.2,0,2,4))]
  vr(r2) f[(f1,solid(#8B5CF6,0.10)),(f2,blur(8)),(f3,inner(#000,0.15,0,1,3))]
  vr(r3) f[(f1,solid(#06B6D4,0.12)),(f2,blur(10)),(f3,inner(#000,0.18,0,1.5,3.5))]
```

**Why it works:** Each region gets its own glass stack — semi-transparent solid for tint, background blur for frosted depth, inner shadow for edge physicality. Varying the tint color per region creates a rich, dimensional logo that feels like colored glass panes.

### Shader Window

Full-bleed shader with a "window" cut into it — a glass card that lets the living surface peek through its edges:

```
fr s(1280,500) clip "Section"
  r s(fill,fill) f[(f1,metaballs(#FFFEFE,#00FFA7,#C40CFF,#0031FF,#FF9D00,speed(0.40),count(11),size(0.40),scale(1.50)))] "Shader BG"
  r s(fill,fill) f[(f1,solid(#0B0B09,0.10))] "Dim Overlay"
  al(v,a(c,c),g(24),pad(60)) s(fill,fill) "Content"
    t("built Different",Apple Chancery,44,sb,c) f[(f1,#000000)] "Title"
      spans[(0,6,w(light),f(Inter)),(6,15,b,f(Bungee Shade),#FF0900FF)]
```

The dim overlay tames the shader for readability while the edges and corners still show animated movement.

---

## Neon & Glow Labels

**Real neon has three light layers:** the tube glows from within (inner glow), the surface catches that light (fill), and color bleeds onto the surrounding wall (outer shadow). Replicate all three and the element looks like it emits light. Only works on dark backgrounds — light backgrounds wash out the glow.

### Neon Badge

Three-layer glow: inner luminance + element fill + ambient outer shadow:

```
al(h,a(c,c),pad(4,12)) s(hug,hug) f[(f1,#1E1B4B),(f2,glow(#818CF8,0.7,6))] st[(s1,solid(#818CF8,0.4),1)] rd(9999) shadow(#818CF8,y(0),blur(12)) "Neon Badge"
  t("Live",Inter,12,sb) f[(f1,#C7D2FE)] "Label"
```

The inner glow lights the badge from within, the border catches the edge, and the outer shadow bleeds color onto the surface below.

### Status Glow Dot

A pulsing-look status indicator with color-matched glow:

```
c s(10,10) f[(f1,#22C55E)] shadow(#22C55E,o(0.40),y(0)) shadow(#22C55E,o(0.15),y(0),blur(16)) "Online Dot"
```

Two outer glow shadows at different spreads create a halo effect. Works for "live," "recording," "online" indicators.

### Accent Glow Card Border

An entire card that glows on dark backgrounds — colored shadow replaces the traditional stroke border:

```
al(v,g(16),pad(24)) s(340,hug) f[(f1,#18181B)] rd(16) shadow(#3B82F6,o(0.15),y(0),blur(1),sp(1)) shadow(#3B82F6,o(0.12),y(0),blur(16)) "Glow Card"
  t("Pro Plan",Inter,20,sb) f[(f1,#FAFAFA)] "Title"
  t("Everything unlimited",Inter,14) s(fill,hug) f[(f1,#A1A1AA)] "Desc"
```

The tight shadow with 1px spread acts as a glowing border; the soft shadow creates ambient glow. Much more alive than `st[(s1,#3B82F6,1)]`.

---

## Button State Design

**Shadow = height.** Default floats, hover lifts higher (bigger shadow), press pushes into the surface (inner shadow replaces outer). Show states side by side in a component showcase or use the appropriate state contextually.

**Default** — medium shadow, solid fill:
```
al(h,a(c,c),pad(12,24)) s(hug,hug) f[(f1,#3B82F6)] rd(10) shadow(#3B82F6,o(0.12),y(2),blur(4)) shadow(#3B82F6,o(0.08),y(6),blur(16)) "Button"
  t("Subscribe",Inter,14,sb) f[(f1,#FFFFFF)] "Label"
```

**Hover** — enhanced shadow (element "lifts"), slightly brighter fill:
```
al(h,a(c,c),pad(12,24)) s(hug,hug) f[(f1,#60A5FA)] rd(10) shadow(#3B82F6,o(0.15)) shadow(#3B82F6,o(0.12),y(10),blur(24)) "Button Hover"
  t("Subscribe",Inter,14,sb) f[(f1,#FFFFFF)] "Label"
```

**Pressed** — inner shadow replaces outer, element appears pushed in:
```
al(h,a(c,c),pad(12,24)) s(hug,hug) f[(f1,#2563EB),(f2,inner(#000,0.15,0,2,4))] rd(10) "Button Pressed"
  t("Subscribe",Inter,14,sb) f[(f1,#FFFFFF)] "Label"
```

**Disabled** — no shadow, muted fill (`#94A3B8`), reduced text opacity (`solid(#FFF,0.6)`). **Focus** — glow ring via `shadow(color,y(0),blur(0),sp(3))` + soft ambient shadow. The tight spread acts as a focus ring.

---

## Dark Mode Playbook

Dark backgrounds are where Brilliant's effects truly shine. Inner glows, colored shadows, and shaders that look garish on white become elegant and premium on dark surfaces.

### What Works Best on Dark vs Light

| Effect | On Light Backgrounds | On Dark Backgrounds |
|---|---|---|
| **Inner shadow** | Higher opacity (0.15-0.25), standard | Lower opacity (0.08-0.15), larger blur |
| **Inner glow** | Skip or very subtle (0.08-0.12) | **Superpower** — full vibrancy (0.3-0.8) |
| **Drop shadow** | Black/gray, low opacity | **Colored shadows** — they double as ambient glow |
| **Outer glow** | Rarely useful | Great for "floating" and "neon" effects |
| **Background blur** | Lower blur (8-12), light tint | Higher blur (12-20), darker tint |
| **Shaders** | Lower opacity, muted palette | Full vibrancy — dark is their natural home |
| **Gradient fills** | Subtle tone shifts | Bold color transitions |

### Dark Surface Hierarchy

On dark backgrounds, use fill brightness (not shadows) to establish visual hierarchy:

```
Base layer:     f[(f1,#09090B)]     ← deepest, darkest
Surface 1:      f[(f1,#18181B)]     ← cards, panels
Surface 2:      f[(f1,#27272A)]     ← elevated cards, active states
Surface 3:      f[(f1,#3F3F46)]     ← popovers, tooltips
```

Each step up is a lighter shade. Combine with colored shadows for extra depth:
```
al(v,g(16),pad(24)) s(340,hug) f[(f1,#18181B)] rd(16) shadow(#000,o(0.30)) shadow(#000,o(0.20),y(12),blur(32)) "Dark Card"
```

### Dark Mode Glass

**Why dark is glass's natural home:** On dark backgrounds, even subtle color differences behind the glass become visible through the blur — dark amplifies the depth effect that makes glass work. Lower tint opacity (0.06 vs 0.12) because the dark background does the contrast work for you:

```
al(v,g(16),pad(24)) s(360,hug) f[(f1,solid(#FFF,0.06)),(f2,blur(16))] st[(s1,solid(#FFF,0.08),1)] rd(16) "Dark Glass"
```

Inner glow replaces the border's job on dark surfaces — it simulates light refracting at the glass edge:
```
al(v,g(16),pad(24)) s(360,hug) f[(f1,solid(#FFF,0.06)),(f2,blur(16)),(f3,glow(#FFF,0.08,8))] st[(s1,solid(#FFF,0.06),1)] rd(16) "Glass + Glow"
```

---

## Gradient Depth

Gradients are under-used and under-layered. A thoughtful gradient communicates mood, direction, and depth that solid colors cannot.

### Direction = Mood

| Angle | Feeling | Best For |
|---|---|---|
| `180` (top → bottom) | Grounding, stable, natural | Hero backgrounds, page headers |
| `135` (top-left → bottom-right) | Energizing, dynamic, forward | CTA sections, feature highlights |
| `0` (bottom → top) | Uplifting, aspirational, open | Footer-to-CTA transitions |
| `90` (left → right) | Progressive, journey, flow | Timeline sections, process steps |
| `225` (bottom-right → top-left) | Dramatic, unconventional | Dark mode heroes, editorial |

### Multi-Stop Gradients

Two-stop gradients feel flat. Three stops create depth:

```
f[(f1,linear(180,stop(#09090B,0),stop(#18181B,0.6),stop(#312E81,1)))]
```

The middle stop creates a "knee" — a point where the gradient shifts character. This prevents the uniform wash of a two-color blend.

**Dark hero with color accent:**
```
f[(f1,linear(135,stop(#09090B,0),stop(#09090B,0.5),stop(#1E1B4B,1)))]
```

Mostly dark with a late-blooming color shift in one corner — sophisticated and unexpected.

### Radial Gradients

Radial creates focal gravity that linear cannot. Use for light sources, ambient depth, and vignettes — especially on dark backgrounds where they naturally shine.

**Ambient glow** — the modern dark-UI signature. Off-center, low opacity, brand-tinted. Layer 2-3 of these at different positions for simulated mesh:
```
r s(fill,fill) f[(f1,radial(-0.5,-0.5,0.5,0.5,stop(#312E81,0,0.25),stop(#312E81,1,0)))] "Ambient Glow"
```

**Vignette** — transparent center, dark edges. Focuses attention on content without hard overlays:
```
r s(fill,fill) f[(f1,radial(0,0,1,1,stop(#000,0,0),stop(#000,0.6,0),stop(#000,1,0.7)))] "Vignette"
```

**Radial + linear stack** — linear sets the mood direction, radial adds a point-light highlight on top:
```
f[(f1,linear(135,#09090B,#1E1B4B)),(f2,radial(0.3,-0.3,0,-1,stop(#6366F1,0,0.15),stop(#6366F1,1,0)))]
```

**Elliptical accent** — wider-than-tall glow using `w()`. Real light pools aren't circular:
```
r s(fill,200) f[(f1,radial(0,0,0,-1,w(1,0),stop(#3B82F6,0,0.3),stop(#3B82F6,1,0)))] "Top Glow"
```

### Gradient + Effect Stacking

Layer a gradient fill with a low-opacity shader or inner glow for textures that gradients alone can't achieve:

```
f[(f1,linear(135,#831843,#9F1239)),(f2,metaballs(#9F1239,#BE185D,#831843,opacity(0.15),speed(0.2)))]
```

The gradient provides the base color direction; the shader adds subtle organic texture on top. At 15% opacity the shader is felt, not seen.

---

## Animation Speed Guide

Shaders are animated by default. The speed setting is the difference between "dynamic and alive" and "distracting and nauseating."

| Context | Speed | Rationale |
|---|---|---|
| Behind readable text (heroes, CTAs) | `speed(0.2-0.4)` | Content is king — motion should enhance, not compete |
| Hero background (no text overlay) | `speed(0.5-1.0)` | Can be more dynamic when nothing competes for attention |
| Small accent elements (badges, dividers, icons) | `speed(1.0-2.0)` | Small surface area = higher speed is still comfortable |
| Atmospheric ambient (dark subtle backgrounds) | `speed(0.1-0.3)` | Barely perceptible = premium. If you notice the motion, it's too fast |
| Showcase/demo context | `speed(1.0-1.5)` | Drawing attention is the point |
| Static export (PNG, PDF) | `frozen` | No animation possible — freeze at a good frame |

**The rule:** If someone would describe the motion unprompted, it's too fast. The best shader animation is one the viewer only notices after a few seconds — "wait, is that moving?"

---

## Claymorphism

The 2025-2026 evolution of neumorphism — saturated pastel fills, high corner radius, dual inner shadows, and outer drop shadows create soft, molded-clay objects that feel touchable.

```
al(v,g(16),pad(24)) s(300,hug) f[(f1,#DBEAFE),(f2,inner(#000,0.08,3,3,6)),(f3,inner(#FFF,0.6,-2,-2,4))] rd(20) shadow(#000,o(0.06),y(2),blur(4)) shadow(#000,o(0.10),y(8),blur(24)) "Clay Card"
  t("Insights",Inter,20,sb) f[(f1,#1E3A5F)] "Title"
  t("See what's working",Inter,14) s(fill,hug) f[(f1,#64748B)] "Desc"
```

The dark inner shadow (bottom-right) + white inner shadow (top-left) create the molded 3D look. Same technique at smaller scale for buttons and icon boxes — reduce inner shadow offsets to 1-2px.

**Key principles:**
- Fill MUST be a saturated pastel — `#DBEAFE` (blue), `#BBF7D0` (green), `#C4B5FD` (violet), `#FECACA` (rose), `#FDE68A` (amber)
- Corner radius 16-24px — higher than normal
- Always two inner shadows: dark bottom-right + white top-left
- Always outer drop shadow for lift
- Text should be dark and high-contrast against the pastel
- Works best on light, slightly tinted backgrounds — not pure white

---

## Liquid Glass Compositions

The fullest expression of glass in Brilliant — every ingredient working together: tint for material, blur for depth, inner glow for edge refraction, layered shadows for float, and a rich background to make it all meaningful. **Liquid glass is glass with physicality** — it doesn't just blur, it catches light, casts shadows, and feels like it has weight and thickness.

### Light Liquid Glass Card

```
al(v,g(16),pad(24)) s(380,hug) f[(f1,solid(#FFF,0.15)),(f2,blur(16)),(f3,glow(#FFF,0.12,6))] st[(s1,solid(#FFF,0.20),1)] rd(20) shadow(#000,o(0.04),y(2),blur(4)) shadow(#000,o(0.08),y(8),blur(24)) "Liquid Glass"
  t("Dashboard",Inter,22,sb) f[(f1,#18181B)] "Title"
  t("Your overview at a glance.",Inter,14) s(fill,hug) f[(f1,#475569)] "Subtitle"
```

The inner glow adds the light-catching edge that real glass has. The white stroke acts as a refraction highlight. **Dark mode tuning:** lower tint opacity (`solid(#000,0.25)` vs `solid(#FFF,0.15)`), increase blur (20 vs 16), soften inner glow (`glow(#FFF,0.06,8)`). On dark backgrounds, less is more — the blur itself does the heavy lifting.

### Liquid Glass Hero

A complete hero section built around the liquid glass aesthetic. Layered fills on the parent frame — holo shader + dark tint + radial vignette — no ambient glow circles. Every element participates in the glass language: pill badge, headline, CTA.

```
fr s(1280,700) f[(f1,holo(#FFFFFF,#0022FF,#3500FF,shape(none),intensity(0.90),spread(0.10),angle(30),noise(0.15),metallic(0.70),speed(0.80),scale(0.25))),(f2,solid(#000000,0.70)),(f3,radial(cx(75),cy(75),r(25),stop(#000000,0,0.68),stop(#000000,1,0)))] clip "Hero"
  al(v,a(c,c),g(32),pad(80)) s(fill,fill) "Content"
    al(h,a(c,c),pad(4,12)) s(hug,hug) f[(f1,solid(#FFFFFF,0.08)),(f2,blur(8))] st[(s1,solid(#FFFFFF,0.12),1,r,r)] rd(9999) "Pill"
      t("Now in beta",Inter,13,m) f[(f1,solid(#FAFAFA,0.75))] "Pill Text"
    t("Design without limits",Inter,52,m,c) s(700,hug) f[(f1,#FAFAFA)] "Headline"
    t("The AI-native design tool that thinks as fast as you do.",Inter,18) s(560,hug) f[(f1,solid(#FAFAFA,0.75))] "Subtitle"
    al(h,a(c,c),g(16)) s(hug,hug) "CTAs"
      al(h,a(c,c),pad(14,28)) s(hug,hug) f[(f1,solid(#FFFFFF,0.10)),(f2,blur(8))] st[(s1,solid(#FFFFFF,0.16),1,r,r)] rd(12) "Glass CTA"
        t("Get Started",Inter,15,sb) f[(f1,#FAFAFA)] "Label"
      al(h,a(c,c),pad(14,28)) s(hug,hug) rd(12) "Secondary"
        t("Watch demo",Inter,15,m) f[(f1,solid(#FAFAFA,0.75))] "Label"
```

Holo shader + dark solid tint + radial vignette stacked as fills on the parent frame. Glass pill + glass CTA with frosted blur. No separate background elements needed — the fill stack handles all the depth.
