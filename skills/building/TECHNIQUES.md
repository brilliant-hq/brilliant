---
name: "building-techniques"
description: "AI anti-patterns, design toolkit, professional shadows, shaders, shader strokes, brand DNA — always-loaded guidance. Recipes in RECIPES.md."
---

> **Parent skill:** [building/SKILL.md](./SKILL.md)

# Design Techniques

Concept-first recipes and AI-correcting guidance. Generic design theory (hierarchy, typography basics, composition) is assumed knowledge — this file covers what Claude gets wrong and what's Brilliant-specific.

> **Your designs have superpowers.** Brilliant gives you layered shadows, inner glows, background blur, animated shaders, glassmorphism, and metallic surfaces — tools that most design agents never touch. A single well-placed shader fill turns a flat hero into something alive. A two-layer shadow system makes cards feel like they float off the page. A frosted glass card over a gradient makes a section feel premium. **But these tools are powerful because they're used intentionally, not everywhere.** The techniques below teach you when to reach for them — and when restraint is the better choice.

## Before You Build

Before any layout work, answer: **What emotion should this evoke?** (drives font, color, spacing) · **What should the viewer notice first?** (one focal point per section) · **What makes THIS design different from the last?** (if it looks like hero + icon-grid + pricing + footer, push harder) · **What's this design's personality?** (see table below — this determines your effect budget, not a blanket rule).

## Effect Intensity by Design Personality

**Not every design needs the same amount of effects.** A law firm site with layered glass cards and neon glows is as wrong as a gaming dashboard with zero shadows. Match effect usage to the design's personality:

| Personality | Shadows | Premium effects | Backgrounds |
|---|---|---|---|
| **Minimal / editorial** | Subtle single shadows or none — clean space IS the effect | Skip. Restraint is the premium touch | Solid or flat gradient only |
| **Professional / SaaS** | Layered shadows on key elevated elements (cards, modals) | 1 glass card or shader accent per page, if any | Solid, gradient, maybe one subtle decorative section |
| **Bold / energetic** | Strong layered + colored shadows | 2-3 per page — glass, shaders, glows | Richer treatments, shader backgrounds |
| **Playful / friendly** | Colored shadows, claymorphism | Colored shadows, inner glows, bouncy depth | Bright gradients, maybe one decorative |
| **Dark / premium** | Colored shadows, inner glows at full vibrancy | Glass + shaders — dark is their natural home | Gradient + subtle ambient touches |

**The default is restraint.** If you're unsure, start with clean solid backgrounds and subtle shadows. You can always add effects — but stripping overused effects from a cluttered design is harder. A senior designer's first instinct is "does this need more?" not "let me add everything."

---

## Content Restraint

AI designs overstuff sections. World-class sites communicate **one idea per section** with minimal text.

| Element | Word count |
|---|---|
| Hero headline | 4-8 words |
| Hero subtitle | 12-25 words |
| Section heading | 3-6 words |
| Section description | 15-40 words |
| Card title | 2-5 words |
| Card description | 10-25 words |

**Rules:** Max 1 CTA per section (secondary action = text link, not a button). Center-align only text under 2-3 lines. Content-to-whitespace ratio: 60-70% whitespace. After building, ask "what can I remove?" — strip decorative icons that don't add meaning, redundant subtitles, extra CTAs, ornamental gradients.

---

## Hero Anti-Cliches

**Headline weight:** Modern SaaS heroes use `medium` or `semibold` — not bold. At 48-64px, medium reads as confident. Bold at hero sizes feels aggressive.

**Eyebrow variety:** The tinted pill above the headline is the #1 AI cliche. Break the pattern:

| Eyebrow Type | When to use |
|---|---|
| Tinted pill | Feature launches, status updates |
| Outlined pill | Premium, minimal brands (stroke-only, no fill) |
| Split pill (two-tone) | Announcements with context (dark label + light description) |
| Pill with icon | Product features, launches |
| Pill with dot | Status, live indicators |
| Plain overline text | Editorial, confident brands (no container) |
| Avatar stack + count | Social proof, traction |
| Star rating + source | Reviews, trust |
| Category definition | Market leaders (plain declarative, no container) |
| No eyebrow | Strong headlines that don't need one |

---

## AI Color Anti-Patterns

These combinations are technically fine but **massively overused by AI**, making designs instantly recognizable as AI-generated:

| Overused scheme | Do this instead |
|---|---|
| Blue-to-purple gradient (`#3B82F6→#8B5CF6`) | Match gradient to domain: amber→rose for food, emerald→teal for finance |
| Dark bg + neon green/cyan | Warm dark (`#1C1917`) + amber/gold, or cool dark (`#0F172A`) + sky blue |
| All-white + only blue `#3B82F6` | Try indigo, emerald, violet, or a warm accent |
| Black `#000` + gold `#F59E0B` | Real luxury = restraint: off-black `#1A1A2E`, champagne, or no gold |
| Pink-to-orange gradient | Solid coral or rose→blush gradient instead |
| Pastel rainbow (5+ pastel fills) | ONE accent + tinted variant. Three colors max |
| Lime green `#84CC16` on dark | Emerald `#10B981` or teal `#14B8A6` — richer greens |
| Violet `#8B5CF6` as accent on every design | Emerald, amber, rose, indigo, or domain-matched. Purple is fine occasionally, not your go-to |
| Indigo-to-pink gradient | Single solid accent. Gradients for one element, not every surface |
| Blue `#3B82F6` or green `#10B981` on every design | **Pick a fresh accent each time.** These appear in examples as placeholders — don't fixate |
| Low-opacity circles behind every section | Solid fill, gradient, diagonal stripe, dot grid, or nothing. Glow circles max once per design |

**The rule:** If you've seen the combo in 3+ AI designs, avoid it. A sushi restaurant with terracotta and warm stone is memorable. The same restaurant with blue-purple gradient is forgettable.

---

## Design Toolkit

### Section Background Alternation

The #1 technique for multi-section pages. Alternate between 2-3 background tones. No two adjacent sections share the same background:

```
Navbar    f[(#FFFFFF)]
Hero      f[(#FFFFFF)]
Logos     f[(#FAFAFA)]     ← tinted (zinc-50)
Features  f[(#FFFFFF)]
Stats     f[(#F4F4F5)]     ← deeper tint (zinc-100)
Pricing   f[(#FFFFFF)]
CTA       f[(#18181B)]     ← dark accent
Footer    f[(#FAFAFA)]
```

**Parent frame uses `g(0)`** — sections manage their own vertical padding. `g()` would add space between sections that can't have different backgrounds.

### Presentation Treatments

When the design includes a product UI, choose a treatment:

| Treatment | How | Effect |
|---|---|---|
| **Flat** | No transform, clean edges | Professional, focused |
| **Tilted** | `rot(-3)` or `skew(-8,0)` | Dynamic, editorial |
| **Stacked** | 2-3 frames offset with `p(x,y)`, slight rotation | Depth, multiple views |
| **Browser chrome** | Top bar with 3 dots + URL bar | Realistic context |
| **Clipped preview** | Frame with `clip` + `rd(12)`, partially visible | Intrigue, focus on key area |
| **Floating widgets** | Stat cards/chat bubbles around the product | Energy, feature highlights |

**Build real product UIs at real-app fidelity** — not gray placeholders. Use real names, real data, real timestamps. Widgets orbit the product, never overlap CTAs.

### Background Treatments

**Vary backgrounds across sections.** Alternate between 2-3 tones so no two adjacent sections share the same fill. For most sections, **solid or gradient is the right choice.** Decorative treatments (shapes, grids, glass) need a reason — they should serve the brand's personality, not fill visual silence.

**If you're unsure, pick solid or gradient.** They work for every personality. Decorative treatments are for specific moods — see the table below.

#### Your defaults: solid and gradient

These cover 80%+ of sections in any design. A well-chosen solid is more interesting than a mediocre decorative treatment.

**Solid:** A dark solid between white sections creates rhythm without decoration. Don't underestimate a strong solid. Vary the tonal family to match the brand (zinc for neutral, stone for warm, slate for cool).

```
al(v,a(c,c),g(24),pad(80,64)) s(1280,500) f[(#18181B)] "Dark Section"
  t("Built for scale",Inter,40,sb,c) f[(#FAFAFA)] "Title"
  t("Enterprise-grade from day one.",Inter,16,c) s(600,hug) f[(#A1A1AA)] "Subtitle"
```

**Gradient sweep:** Angle `180` grounds, `135` energizes, `0` lifts. Keep stops in the same tonal family.

```
al(v,a(c,c),g(24),pad(80,64)) s(1280,500) f[(linear(180,#1C1917,#292524))] "Gradient Section"
  t("Ship faster",Inter,40,sb,c) f[(#F5F5F4)] "Title"
  t("From idea to production in minutes.",Inter,16,c) s(600,hug) f[(#A8A29E)] "Subtitle"
```

#### Decorative treatments (use when the brand calls for it)

These add visual personality but can easily become noise. Use **at most 1-2 decorative sections** per full-page design. Match the treatment to the brand:

| Treatment | Vibe | Best for |
|---|---|---|
| **Diagonal stripe / edge accent** | Bold, structured | SaaS, fintech, enterprise |
| **Dot / line grid** | Blueprint, technical | Developer tools, dashboards |
| **Corner/edge shapes** | Restrained elegance | Luxury, portfolio |
| **Floating shapes** | Technical, structured | Dev tools, SaaS |
| **Glassmorphism** | Layered, premium | Cards over rich backgrounds (bold/premium personalities only) |
| **Full-bleed image + overlay** | Dramatic, immersive | Travel, food, lifestyle |

**Diagonal accent stripe:** Rotated rectangle extending beyond bounds in a Group Overlay with `clip`. Rotation -8° to -12°, fill opacity 0.04-0.08 of an accent color.

**Dot grid:** 4x4px circles in a Group Overlay, spaced 40-60px apart. Keep dots very subtle (0.06-0.15 opacity). Best on white/light backgrounds.

**Corner/edge accents:** 1-3 shapes tucked into corners via Group Overlay, partially offscreen. Mix filled (0.03-0.06) and stroke-only (0.08-0.12). Restrained — one corner, not all four.

**Floating shapes:** 3-5 shapes in Group Overlay, mix filled (0.03-0.06) and stroke-only (0.06-0.12), rotated, varying sizes (80-240px).

**Glassmorphism section:** Glass card over a rich background. See Background Blur (Glass) in Brilliant Power Moves. Only use in bold/premium designs.

> **DO NOT use ambient glow circles as a background treatment.** Large low-opacity circles behind content is the #1 AI background cliche — it instantly makes the design look AI-generated. If you're reaching for glow circles, you probably need a solid, gradient, or one of the treatments above instead. The only exception: a single ambient touch in a dark/premium hero (like the Liquid Glass Hero in RECIPES.md) — never as a repeating pattern across sections.

---

## DSL Construction Patterns

Non-obvious Brilliant constructions. Generic patterns (cards, buttons) are in BUILDING_BLOCKS.md.

### Inline Elements in Headlines

Icon, image, or decorative element BETWEEN words. Split headline into text fragments in `al(h)`:

```
al(v,a(c,c),g(4)) s(hug,hug) "Title"
  al(h,a(c,c),g(10)) s(hug,hug) "Row 1"
    t("We Take Your",Playfair Display,40,b) f[(#1C1917)] "T1"
    al(h,a(c,c)) s(44,44) f[(#EFF6FF)] rd(12) "Ic"
      svg(icon:envelope-simple) s(24,24) st[(#3B82F6,2)] "Icon"
    t("Email",Playfair Display,40,b) f[(#3B82F6)] "T2"
  t("Marketing to the Next Level",Playfair Display,40) italic f[(#1C1917)] "Row 2"
```

Variations: product thumbnail, avatar circle, decorative SVG, colored pill. One inline element per headline max.

### Bento Grid

Mixed-size cards — tall + wide + square cells:

```
al(v,g(12)) s(800,hug) "Bento"
  al(h,g(12)) s(fill,hug) "Row 1"
    al(v,g(16),pad(32)) s(fill,hug) f[(#171717)] rd(16) "Wide"
      t("Ship faster",Inter,28,b) s(fill,hug) f[(#FAFAFA)] "Title"
      t("From idea to production in minutes.",Inter,15) s(fill,hug) f[(#A3A3A3)] "Desc"
    al(v,a(c,c)) s(200,200) f[(#EFF6FF)] rd(16) "Square"
      svg(icon:rocket) s(48,48) st[(#3B82F6,2)] "Icon"
  al(h,g(12)) s(fill,hug) "Row 2"
    al(v,a(c,c)) s(200,200) f[(#F0FDF4)] rd(16) "Square"
      svg(icon:shield) s(48,48) st[(#10B981,2)] "Icon"
    al(v,g(12),pad(24)) s(fill,200) f[(#F5F3FF)] rd(16) "Tall"
```

Mix `fill` (stretchy) and `fixed` (rigid) children per row — or use `fill:N` for proportional cells that maintain ratio when the grid resizes. Different bg colors per cell. At least one cell dramatically different in size.

### Stacked / Tilted Cards

Slight rotation + offset for energy. Uses **Group Overlay** for overlapping positioned cards:

```
gr s(600,400) "Showcase"
  al(v,pad(24)) rot(-4) p(80,50) s(260,hug) f[(#FFFFFF)] st[(#E2E8F0,1)] rd(16) "Back"
  al(v,pad(24)) rot(2) p(60,35) s(260,hug) f[(#FFFFFF)] st[(#E2E8F0,1)] rd(16) "Mid"
  al(v,pad(24)) rot(-1) p(40,20) s(260,hug) f[(#FFFFFF)] st[(#E2E8F0,1)] rd(16) "Front"
```

First = back, last = front (z-order). Offset 15-20px per card. Rotation -5° to 5°. Single card tilt: even `rot(2)` adds personality.

### Image + Gradient Overlay

Image fill + color overlay stacked as fills on the parent frame:

```
fr s(1280,600) f[(img(https://picsum.photos/id/164/1280/600)),(f2,solid(#09090B,0.55))] "Visual"
  al(v,a(c,c),g(20),pad(80,200)) s(fill,fill) "Content"
    t("Your headline here",Inter,48,b,c) s(fill,hug) f[(#FFFFFF)] "Title"
```

Overlay options: solid `solid(#000,0.5)`, brand-tinted `solid(#09090B,0.55)`, gradient fade `linear(180,stop(#000,0,0.4),stop(#000,1,0.85))`.

### Low-Opacity Background

ANY content at 3-8% opacity behind main content — oversized word, dense micro-text, product UI, icon grid, full composition. Uses **Group Overlay**:

```
gr s(800,400) "Section"
  t("DESIGN",Inter,180,bl) p(60,-20) f[(solid(#18181B,0.04))] "Watermark"
  al(v,a(c,c),g(24),pad(60)) s(fill,fill) "Content"
    t("Our Philosophy",Inter,36,b,c) f[(#18181B)] "Title"
```

**Opacity on fill:** `f[(solid(#hex,0.04))]` — always use `solid()` for low-opacity fills.

### Highlight Bar Behind Text

Colored rectangle behind a key phrase, like a marker-pen highlight. Group wrapper so the bar sits behind text. Bar height ~30-40% of font size, positioned at baseline. One per section max.

---

## Professional Shadows

**Shadows are a hierarchy system, not decoration.** Every shadow implies a light source and tells the viewer how high an element floats above its surface. Higher = more important = more interactive. When you add a shadow, you're making an architectural statement about the element's role in the interface.

**The light model:** Imagine two light sources illuminating your design — a **key light** (directional, like the sun) casting a tight shadow with offset, and **ambient light** (diffused, like the sky) casting a soft spread with little offset. This is why a single `shadow()` looks fake — it only simulates one light. Two layers match how light actually works. Three layers add a deep ambient layer that sells real height.

**Blur = perceived height.** This is the core tuning principle. More blur + more spread = element floats higher. Tight blur + small offset = near the surface. Don't memorize shadow presets — think "how high is this element?" and translate: resting card = barely lifted, modal = floating well above, popover = highest layer.

**Never pure black.** In nature, shadows aren't black — they darken the surface below, taking on its color. Pure `#000` shadows look artificial. Always use low opacity (0.04-0.10) or tint with the element's color.

**Consistent direction.** All shadows in a design must come from the same light direction. Mixed directions make the scene feel physically wrong — humans detect this instantly, even subconsciously.

**If you can obviously see the shadow, it's too strong.** Shadows should be felt, not seen. A deliberately minimal design may skip shadows entirely — that's valid when clean space IS the design language.

### Shadow Elevation Scale

Starting points — adapt blur and offset to your specific elevation needs:

**Low elevation** (resting cards, inputs, badges) — barely lifted, tight + ambient:
```
shadow(#000,o(0.04),y(1),blur(2)) shadow(#000,o(0.06),blur(12))
```

**Medium elevation** (active cards, modals, product screenshots) — noticeable float:
```
shadow(#000,o(0.05),y(2),blur(4)) shadow(#000,o(0.08),y(8),blur(24))
```

**High elevation** (popovers, dropdowns, floating widgets) — three layers for convincing height:
```
shadow(#000,o(0.06),blur(6)) shadow(#000,o(0.10),y(12),blur(32)) shadow(#000,o(0.05),y(20),blur(48))
```

### Colored & Tinted Shadows

**Why colored shadows work:** When you tint a shadow to match the element's fill, it looks like the element is casting colored light onto the surface below — like sunlight through stained glass. The shadow connects to its source instead of being a generic dark smudge. This single change signals intentional design.

```
shadow(#3B82F6,o(0.10),y(2),blur(4)) shadow(#3B82F6,o(0.08),y(8),blur(20))
```

On light backgrounds, tint shadows with the element's dominant color at low opacity. On dark backgrounds, colored shadows double as ambient glow — increase opacity slightly (0.12-0.20). A CTA button with colored shadows draws the eye more than one with a larger font size.

---

## Brand DNA

Every design needs a unique visual fingerprint. The default AI logo — icon in a solid-colored box — is generic. Break this pattern:

| Logo Style | Best for |
|---|---|
| **Naked icon** (no background) | Confident, minimal brands |
| **Outlined circle** | Premium SaaS, fintech |
| **Gradient mark** | Modern SaaS, AI/tech |
| **Subtle fill** (10% opacity bg) | Dashboards, professional tools |
| **Icon + accent shape** | Startups, playful brands |
| Solid filled box | **Only when the brand actually uses this** |

### Threading Brand Language

The logo's visual DNA should echo throughout. Pick 2-3 echo points:

| Logo trait | Echo in |
|---|---|
| Circular (`rd(9999)`) | CTA buttons, avatar frames, badge pills |
| Rounded square (`rd(8)`) | Cards, feature icon boxes, inputs |
| Gradient fill | Accent bar gradient, hero headline |
| Outline/stroke style | Cards use stroke not fill, thin dividers |
| 10% opacity fill | Feature icon boxes, tag backgrounds |
| Accent shape (dot, circle) | Section dividers, bullets, indicators |

**The test:** Cover the logo. Can you still guess the brand's personality?

---

## Brilliant Power Moves

**These are the features that make Brilliant designs extraordinary.** One shader fill, one glass card, one set of layered shadows — and suddenly the design has depth, energy, and craft. But **use them intentionally, not reflexively.** A bold SaaS hero benefits from a shader background and glass overlay. A minimal portfolio page is better served by clean space and crisp typography. Match your effect usage to the design personality above.

**When the design calls for depth and energy, reach for these:**
- Layered shadows on elevated elements (cards, buttons, modals) — see Shadow Elevation Scale above
- A premium touch where the design needs a focal point (glass card, shader accent, inner glow, colored shadows)
- For hero sections in bold/energetic/premium designs: consider a shader background, glassmorphism overlay, or animated element

> **CRITICAL: Never place text directly on a shader fill.** Shaders (metal, holo, steel, metaballs) produce busy, high-contrast patterns that make overlaid text unreadable — even with color contrast. This is the #1 shader mistake. **Always separate shader from text** using one of these patterns:
>
> **1. Shader on stroke, solid fill for text** (best for buttons/badges) — `steel()`:
> ```
> al(h,a(c,c),pad(12,24)) s(hug,hug) f[(#18181B)] st[(steel(#FFD700,#DAA520,speed(1.5)),2)] rd(10) "Button"
>   t("Premium",Inter,14,sb) f[(#FAFAFA)] "Label"
> ```
> Text sits on a clean solid surface; the liquid steel stroke in gold catches light without competing with readability.
>
> **2. Shader as background fill, text in a glass card on top** (best for heroes/sections) — `holo()`:
> ```
> fr s(900,540) f[(linear(135,#0A0A1A,#1A1040)),(f2,holo(#E879F9,#818CF8,#34D399,opacity(0.12),scale(1.5),speed(0.3)))] clip "Hero"
>   al(v) s(fill,fill) "Page"
>     al(h,a(sb,c),pad(14,28)) s(fill,hug) "Nav"
>       t("acme",Space Grotesk,18,b) f[(#FAFAFA)] "Logo"
>       al(h,a(c,c),g(20)) s(hug,hug) "Links"
>         t("Features",Inter,13,m) f[(solid(#FAFAFA,0.50))] "L1"
>         t("Pricing",Inter,13,m) f[(solid(#FAFAFA,0.50))] "L2"
>       al(h,a(c,c),pad(3)) s(hug,hug) f[(solid(#FFF,0.06))] st[(solid(#FFF,0.08),1)] rd(9999) "Mode"
>         al(h,a(c,c),pad(4,10)) s(hug,hug) rd(9999) "Off"
>           t("Light",Inter,11,m) f[(solid(#FFF,0.35))] "Lbl"
>         al(h,a(c,c),pad(4,10)) s(hug,hug) f[(solid(#FFF,0.12))] rd(9999) "On"
>           t("Dark",Inter,11,sb) f[(#FAFAFA)] "Lbl"
>     al(v,a(c,c)) s(fill,fill) "Center"
>       al(v,a(c,c),g(24),pad(48,64)) s(520,hug) f[(solid(#09090B,0.50)),(f2,blur(16))] rd(24) st[(solid(#FFF,0.08),1)] "Glass"
>         t("Design at the\nspeed of thought",Space Grotesk,38,m,c) f[(#FAFAFA)] "Title"
>         t("Ship polished interfaces in minutes.",Inter,15,c) s(fill,hug) f[(#94A3B8)] "Sub"
>         al(h,a(c,c),pad(12,28)) s(hug,hug) f[(#FAFAFA)] rd(9999) "CTA"
>           t("Start building",Inter,14,sb) f[(#18181B)] "Lbl"
> ```
> Full hero with navbar and glass light/dark toggle. Holo shimmer + dark gradient as fills on the parent frame. Glass card with blur creates a readable zone; the iridescence shows through the frosted edges.
>
> **3. Shader as subtle texture under solid fill** (cards/panels) — `steel()`:
> ```
> al(v,g(12),pad(24)) s(320,hug) f[(#1C1917),(f2,steel(opacity(0.12)))] rd(16) "Card"
>   t("Enterprise Plan",Inter,18,sb) f[(#F5F5F4)] "Title"
>   t("Unlimited seats, priority support.",Inter,14) s(fill,hug) f[(#94A3B8)] "Desc"
> ```
> Low-opacity steel underneath the solid fill — metallic shimmer at the edges without affecting text readability.
>
> **4. Shader on a decorative element** (accents) — `metaballs()`:
> ```
> al(h,a(s,c),g(16)) s(hug,hug) "Accent"
>   r s(4,48) f[(metaballs(#F59E0B,#EF4444,#EC4899))] rd(2) "Bar"
>   al(v,g(4)) s(hug,hug) "Text"
>     t("What's New",Inter,20,sb) f[(#171717)] "Title"
>     t("Latest features and improvements",Inter,14) f[(#64748B)] "Sub"
> ```
> The shader lives on a decorative accent bar beside the text — not behind it. The animated bar draws the eye without competing with readability.

**Inner Shadow** — inset depth via `inner()` in the fills array. Inner shadows create the illusion of a surface being **pressed into or carved from** its surroundings — the opposite of drop shadows, which lift elements up. Shadow direction tells the viewer where the light hits: shadow from above = surface dips down, shadow from below = surface pushes up. The dual-shadow trick (dark bottom-right + white top-left) simulates a single light source illuminating a 3D dent.
- **Recessed well** (inputs, sunken panels): `f[(#F1F5F9),(f2,inner(#000,0.15,0,1,3))]` — solid fill + subtle dark inset. Great for search bars, text inputs, content wells.
- **Neumorphic press** (toggles, active states): `f[(#E2E8F0),(f2,inner(#000,0.2,2,2,4)),(f3,inner(#FFF,0.7,-2,-2,4))]` — dark bottom-right + light top-left = the surface appears pressed in from one direction.
- **Claymorphic 3D** (cards, badges): same dual-shadow principle + outer drop shadow + high corner radius (rd(16)+) = soft, molded-clay appearance.
- On dark backgrounds, use very low opacity (0.1-0.2) with slightly larger blur. `inner()` alone gives sensible defaults.
- **On text:** produces embossed (raised) or debossed (carved) lettering — reverse the shadow direction to flip the effect.

**Inner Glow** — soft inner luminance via `glow()` in the fills array. Inner glow simulates light **emanating from within** or reflecting off the inner surface of an element. It's a dark-mode superpower because dark backgrounds provide the contrast that makes the glow visible — on light backgrounds, there's not enough contrast for it to read, so keep opacity very low (0.1-0.15) or skip.
- **Neon edge** (luminous emphasis): `f[(#1E1E2E),(f2,glow(#3B82F6,0.7,8))]` — colored glow on dark fill. The element appears to emit light from within.
- **Soft inner light** (subtle depth): `f[(#1A1A2E),(f2,glow(#FFF,0.15,12))]` — white glow creates gentle inner illumination, an alternative to borders for defining edges on dark surfaces.
- **Status reinforcement** (semantic color): match glow to meaning — `glow(#22C55E,0.5,6)` success, `glow(#EF4444,0.5,6)` error. Light reinforces the message beyond color alone.

**Background Blur (Glass)** — frosted glass via `blur()` in fills. Glass is a **material that communicates spatial relationships** — it separates layers while maintaining visual connection, like architectural glass between rooms. It is NOT a decoration to slap on panels.

**Why glass works:** Humans intuitively read blur as depth. A blurred layer says "this content exists but isn't your focus." Glass creates hierarchy through selective concealment — revealing enough context for spatial awareness without competing for attention.

**Three ingredients, each with a job:**
- **Tint** (semi-transparent fill) — gives the surface materiality. Without it, the element is invisible. Light mode: `solid(#FFF,0.08-0.15)`. Dark mode: `solid(#000,0.25-0.50)`.
- **Blur** — signals distance between layers. More blur (16-20) = frosted/premium/more separation. Less blur (8-12) = barely-there/lightweight. Tune to how much background should show through.
- **Edge** (thin stroke or inner glow) — defines where glass ends. Real glass refracts light at its edges. `st[(solid(#FFF,0.08-0.20),1)]` or `glow(#FFF,0.08,6)` for soft edge catch.

**When to use glass:** Over rich/colorful backgrounds where flat panels would feel jarring. For floating elements that need to feel connected to content below. When one or two elements need to feel elevated and premium.

**When glass is wrong:** Over solid/plain backgrounds (no depth to reveal — just use a tinted solid). On every panel (if everything is glass, nothing stands out — hierarchy collapses). In minimal/editorial designs where clean space IS the effect. When readability matters more than visual richness.

**Tuning:** Start with `f[(solid(#FFF,0.10)),(f2,blur(12))] st[(solid(#FFF,0.12),1)]` and adjust: increase tint opacity for readability, increase blur for more frosting, add `glow()` for edge definition on dark backgrounds. Always verify text contrast.

**Fills are your compositing system.** Brilliant's fill stack works like a layer compositor — each fill renders in order, and you can stack as many as you need. Tint, blur, glow, inner shadow, gradient warmth, shimmer — these are all fill layers on the element itself. A "backlight" is a warm gradient fill at low opacity. A "frosted edge" is an inner glow fill. A "depth bevel" is an inner shadow fill. You compose visual richness by stacking fills, not by creating separate elements behind or around the target. If you find yourself creating a new element to augment another element's appearance, stop — that effect is almost certainly a fill layer.

**Group Overlay is for positioned content, not backgrounds or effects.** Group Overlay (`gr` with positioned children) exists for overlapping content that requires independent position, size, or rotation — chart gridlines + data curves, rotated accent stripes, elements at explicit coordinates. Backgrounds (images, gradients, shaders, overlays) belong as fills on the parent frame, not as separate `r s(fill,fill)` child elements. Visual effects (glow, backlight, depth, frosting, shimmer) are fill/stroke/shadow properties, not separate elements.

**Shaders simulate real-world materials** — each one is a physical surface, not an abstract effect. Choosing the right shader means asking "what material would this object be made of?" The four shaders map to distinct moods:

| Shader | Material | Mood | Reach for it when... |
|--------|----------|------|---------------------|
| `metaballs()` | Lava lamp, oil-in-water | Organic, playful, alive | Creative tools, gaming, music, brands that breathe |
| `metal()` | Chrome, brushed aluminum | Premium, luxury, editorial | Fashion, jewelry, fintech, high-end product |
| `holo()` | Holographic foil, CD surface | Futuristic, trendy, youthful | Web3, tech startups, event branding |
| `steel()` | Liquid mercury, polished cookware | Industrial, professional, clean | SaaS, enterprise, automotive, hardware |

**Surface area rule:** The larger the shader surface, the slower and more muted it must be. A small shader badge at `speed(2.0)` is fine. A full-bleed hero at `speed(2.0)` is nauseating. Scale speed inversely with area.

**Color transforms shaders.** Every shader accepts custom color palettes, and palette choice shifts mood dramatically: dark muted colors → atmospheric depth, warm golds → luxury, desaturated pastels → subtle sophistication, vibrant brand colors → energy. Default palettes are safe starting points — custom colors are how you make a shader yours.

**Metaballs Shader** — `metaballs()` simulates organic fluid (lava lamp, oil-in-water). Blobs merge and separate with surface tension. Use where the design should feel alive and breathing.
- `f[(metaballs(#09090B,#3B82F6,#8B5CF6,#06B6D4))]` — vibrant brand palette, bold organic motion.
- `f[(metaballs(#F59E0B,#EF4444,count(6),size(0.9)))]` — warm amber-red, fewer blobs for a polished, graphic look.
- `f[(metaballs(#0A0A0A,#064E3B,#065F46,speed(0.3)))]` — near-black + dark emerald, slow = atmospheric forest.
- `count()` = how many blobs (fewer = cleaner), `size()` = blob scale (larger = calmer), `speed()` = energy level.
- **Text legibility:** Never place text directly on metaballs. Use as a background with a glass card or dark overlay on top.

**Liquid Metal Shader** — `metal()` simulates chrome or brushed aluminum. Metallic reflections with chromatic aberration create a premium, physical surface. The material has weight — it catches and bends light.
- `f[(metal())]` — default silver chrome. Clean metallic surface for hero accents or product showcases.
- `f[(metal(#FFD700,#FFF8DC))]` — warm gold tones. Pair with dark backgrounds for maximum contrast.
- `f[(metal(softness(0.3),repetition(5),contour(0.7)))]` — brushed-metal look with visible striations.
- `softness()` = edge smoothness (higher = softer reflections), `repetition()` = stripe count (more = brushed texture), `contour()` = ridge visibility (higher = more defined grooves), `angle()` = light direction. `shiftRed()`/`shiftBlue()` = chromatic aberration spread.
- **Text legibility:** Metal fills are extremely busy — never put text on them. Use on strokes, accents, or dividers. For buttons: `f[(#18181B)] st[(metal(),2)]` so text sits on the solid fill.

**Holographic Shader** — `holo()` simulates holographic foil — the iridescent surface of security stickers and collector cards. Rainbow reflections shift with viewing angle. Eye-catching and trendy.
- `f[(holo())]` — default white/lavender palette with rainbow reflections. Instant holographic foil.
- `f[(holo(#FF00FF,#00FFFF,#FFFF00))]` — custom colors shift the iridescence to match brand.
- `f[(holo(intensity(0.4),metallic(0.9),speed(0.2)))]` — restrained: sophisticated shimmer, not full rainbow.
- `intensity()` = rainbow strength (lower = more subtle), `spread()` = fold density, `metallic()` = metallic vs matte finish, `noise()` = surface complexity. `speed()` = shimmer rate.
- **Text legibility:** Holo fills shift between light and dark — no text color works. Use on strokes (`st[(holo(),2)]`) or as low-opacity texture (`holo(opacity(0.15))`) under a solid fill.

**Liquid Stainless Steel Shader** — `steel()` simulates liquid mercury or polished stainless steel. Flowing chrome with a clean, industrial character. Less chromatic than `metal()`, more fluid than static.
- `f[(steel())]` — default flowing chrome. Smooth, professional metallic surface.
- `f[(steel(roughness(0.7),distortion(0.8)))]` — worked-metal look with more surface variation.
- `f[(steel(depth(0.9),flow(0.8),speed(0.3)))]` — deep reflections + high flow + slow = dramatic, mesmerizing.
- `flow()` = surface fluidity (higher = more liquid movement), `roughness()` = texture grain (higher = more matte), `distortion()` = warping intensity, `depth()` = reflection intensity (higher = more dramatic), `angle()` = light direction.
- **Text legibility:** Same as metal — use on strokes or decorative elements, not under text.

**Shader UV Controls** — all shader types support UV transform params inside the fill parens:
- `scale(N)` — zoom pattern in/out (default 1.0). `scale(2)` doubles the pattern density.
- `uvx(N)` / `uvy(N)` — pan the pattern horizontally/vertically (-1.0 to 1.0).
- `uvrot(N)` — rotate the pattern within the element (0-360°), independent of element `rot()`.
- `opacity(N)` — shader fill opacity (0.0-1.0), independent of element-level `o()`.
- `frozen` — bare flag, disables shader animation (renders a static frame).
- `shape(none|circle|metaballs)` — shape-aware rendering mode (metal & holo only). `shape(circle)` makes metallic contours follow a circular form.
- Example: `f[(metal(shape(circle),scale(1.5),uvrot(30),frozen))]`

**Multi-Fill Stacking** — layer multiple fills: `f[(#F8FAFC),(f2,solid(#3B82F6,0.04))]`. Each fill renders in ID order. Use opacity to let lower layers show through.

**Shader & Gradient Strokes** — **strokes support ALL fill types**, not just solid colors. This is one of the most underused capabilities in Brilliant. A button with no fill and a liquid metal stroke is stunning. A card with a holographic border catches light. A gradient stroke on a circle creates a progress-ring feel.

- **Liquid metal border**: `st[(metal(),2)]` — chrome-reflective edge. The stroke alone makes an element feel expensive.
- **Holographic border**: `st[(holo(intensity(0.5),speed(0.3)),2)]` — rainbow shimmer around any shape. Incredible on dark backgrounds.
- **Gradient stroke**: `st[(linear(90,#3B82F6,#8B5CF6),2)]` — color flows along the stroke. Great for card accents and dividers.
- **Angular gradient stroke**: `st[(angular(#3B82F6,#8B5CF6),2)]` — color sweeps around the shape. The natural choice for progress rings, circular indicators, and badges.
- **Fill-less button**: No fill, just a shader stroke — `st[(metal(softness(0.4)),2)]` on a button frame. The entire visual is the border.
- **Shader stroke + solid fill**: `f[(#18181B)] st[(holo(intensity(0.3),metallic(0.8)),1.5,_,_,i)]` — inside stroke position (`i`) keeps the shader border tight against the fill.

**The insight:** When fills get all the attention, the stroke becomes invisible. A shader stroke on an otherwise simple element is unexpected and memorable — the viewer's eye catches the animated edge.

**Skew Transforms** — `skew(-5,0)` for dynamic energy. Small values (-8 to 8°) add life. Pair with `rot` for compound angles.

---

## Ready-to-Use Recipes → [RECIPES.md](./RECIPES.md)

Complete DSL recipes for specific visual styles live in **RECIPES.md**. Load it alongside this file when building designs that use these techniques:

| Recipe | What it covers |
|--------|---------------|
| **Effect Combination Recipes** | Glass over living background, holographic badge, metallic divider, frosted glass + inner shadow, shader window |
| **Neon & Glow Labels** | Neon badge, status glow dot, accent glow card border |
| **Button State Design** | Default, hover, pressed — shadow = height physical metaphor |
| **Dark Mode Playbook** | Effect tuning table, surface hierarchy, dark glass patterns |
| **Gradient Depth** | Direction = mood, multi-stop gradients, gradient + effect stacking |
| **Animation Speed Guide** | Speed settings by context (heroes, accents, ambient, export) |
| **Claymorphism** | Clay cards, buttons, icon boxes — saturated pastels + dual inner shadows |
| **Liquid Glass Compositions** | Light/dark glass cards, full liquid glass hero section |
