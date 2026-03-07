---
name: "building-colors"
description: "Deep color knowledge: palette construction, color relationships, domain psychology, gradient craft, dark mode mapping, data viz colors, neutral tinting."
---

> **Parent skill:** [building/SKILL.md](./SKILL.md)

# Color Mastery

Deep knowledge for choosing, combining, and applying color. Goes far beyond "pick a palette" — covers the WHY behind every color decision.

> **This file is about color theory and decision-making.** For color syntax (hex, gradients, fills), see CLAUDE.md.

---

## Palette Construction

### The 60-30-10 Rule

Every design uses three tiers of color:

| Tier | % of surface area | What it covers |
|------|------------------|----------------|
| **60% Dominant** | Background, card surfaces, large areas | `#FFFFFF`, `#F8FAFC`, `#0F172A` |
| **30% Secondary** | Text, borders, icons, secondary surfaces | `#334155`, `#E2E8F0`, `#F1F5F9` |
| **10% Accent** | CTAs, active states, highlights, badges | `#3B82F6`, `#10B981`, `#F43F5E` |

**The most common mistake:** Using accent color on 30%+ of the surface. One accent-colored CTA is confident. Accent on the navbar, card headers, AND badges is noisy. Restraint > saturation.

### Building from One Accent

Start with one accent hex. Derive everything else:

1. **Pick accent** — Match to domain (see Domain Psychology below)
2. **Generate tinted neutral** — Take accent, desaturate 90%, darken for text tones
3. **Light variant** — Accent at 8-12% opacity for tags/badges/selected states
4. **Dark variant** — Darken accent 15-20% for hover/pressed states

```
Accent:       #3B82F6 (blue)
Light:        #EFF6FF (blue at ~8% on white)
Hover:        #2563EB (20% darker)
Tinted text:  #0F172A (slate — blue-tinted dark)
Tinted gray:  #64748B (slate — blue-tinted mid)
Border:       #E2E8F0 (slate — blue-tinted light)
```

**Why tinted neutrals matter:** Pure gray (`#808080`, `#CCCCCC`) looks lifeless next to chromatic accents. Slate grays have blue undertone. Stone grays have warm undertone. This subtle tint makes the palette feel cohesive.

### Neutral Families

| Family | Undertone | Pairs well with | Feels |
|--------|-----------|----------------|-------|
| **Slate** | Cool blue | Blue, indigo, violet, cyan | Professional, tech, clean |
| **Stone** | Warm yellow | Amber, orange, rose, terracotta | Organic, inviting, earthy |
| **Zinc** | True neutral | Violet, emerald, any accent | Versatile, modern, minimal |
| **Gray** | None (avoid) | Nothing well | Lifeless, generic |

**Rule:** Pick the neutral family that shares undertone with your accent. Blue accent + slate neutrals = cohesive. Blue accent + stone neutrals = dissonant (unless intentionally mixing warm/cool for contrast).

---

## Color Relationships

### Complementary Pairs (High Contrast)

Colors opposite on the wheel. Use for maximum visual tension:

| Pair | Hex | Use for |
|------|-----|---------|
| Blue + Amber | `#3B82F6` + `#F59E0B` | Tech dashboards, fintech |
| Violet + Yellow | `#8B5CF6` + `#EAB308` | Creative tools, gaming |
| Emerald + Rose | `#10B981` + `#F43F5E` | Health/wellness, status indicators |
| Indigo + Orange | `#6366F1` + `#F97316` | Developer tools, bold brands |

**Usage:** One is the accent, the other is for highlights only (badges, alerts, secondary CTAs). Never use both at equal weight — one dominates.

### Analogous Groups (Harmony)

Adjacent colors on the wheel. Use for smooth, cohesive palettes:

| Group | Hex range | Feels |
|-------|-----------|-------|
| Blue to Violet | `#3B82F6` to `#8B5CF6` | Tech, premium (but overused by AI — see anti-patterns) |
| Emerald to Teal | `#10B981` to `#14B8A6` | Fresh, nature, health |
| Amber to Rose | `#F59E0B` to `#F43F5E` | Warm, energetic, food |
| Indigo to Blue | `#6366F1` to `#3B82F6` | Trust, depth, enterprise |
| Rose to Pink | `#F43F5E` to `#EC4899` | Playful, fashion, social |

**Gradient trick:** Analogous pairs make the best gradients because the transition stays smooth — no muddy middle zone.

### Triadic Accents (Data Viz)

Three evenly-spaced colors. Use for charts, categories, multi-status:

| Triad | Colors | Use for |
|-------|--------|---------|
| Primary | `#3B82F6` `#10B981` `#F59E0B` | Dashboard KPIs (blue=neutral, green=good, amber=warning) |
| Vibrant | `#8B5CF6` `#F43F5E` `#14B8A6` | Category badges, pie charts |
| Muted | `#6366F1` `#EC4899` `#F97316` | Chart series, timeline events |

---

## Domain Color Psychology

Colors trigger specific associations. Match your palette to the domain's emotional space:

### Warm Domains (Inviting, Personal)

| Domain | Primary Accent | Secondary | Neutral Family | Why |
|--------|---------------|-----------|----------------|-----|
| Restaurant / Cafe | Amber `#F59E0B` or Red `#DC2626` | Terracotta `#C2410C` | Stone | Appetite, warmth, craft |
| Bakery / Dessert | Rose `#F43F5E` | Amber `#F59E0B` | Stone | Sweetness, delight |
| Travel / Hotel | Teal `#0D9488` | Gold `#F59E0B` | Stone | Escape, luxury, nature |
| Real Estate | Emerald `#10B981` | Slate blue `#3B82F6` | Stone | Growth, trust, home |
| Wedding / Events | Rose `#F43F5E` | Gold `#D4AF37` | Zinc | Romance, elegance |

### Cool Domains (Precise, Trustworthy)

| Domain | Primary Accent | Secondary | Neutral Family | Why |
|--------|---------------|-----------|----------------|-----|
| Finance / Fintech | Emerald `#10B981` | Blue `#3B82F6` | Slate | Growth, trust, money |
| SaaS / Productivity | Blue `#3B82F6` | Indigo `#6366F1` | Slate | Trust, clarity, professional |
| Developer Tools | Violet `#8B5CF6` | Cyan `#06B6D4` | Zinc | Technical, creative |
| Healthcare | Teal `#14B8A6` | Emerald `#10B981` | Slate | Calm, clinical, clean |
| Legal / Insurance | Indigo `#4F46E5` | Slate `#475569` | Slate | Authority, stability |

### Playful Domains (Energetic, Expressive)

| Domain | Primary Accent | Secondary | Neutral Family | Why |
|--------|---------------|-----------|----------------|-----|
| Gaming | Violet `#8B5CF6` | Lime `#84CC16` | Zinc | Energy, digital, fun |
| Education / Kids | Amber `#F59E0B` | Pink `#EC4899` | — | Joy, learning, approachable |
| Social Media | Rose `#F43F5E` | Violet `#8B5CF6` | Zinc | Connection, expression |
| Music / Audio | Violet `#7C3AED` | Pink `#EC4899` | Zinc | Creative, emotional |
| Sports / Fitness | Orange `#F97316` | Emerald `#10B981` | Zinc | Energy, performance |

### Restrained Domains (Minimal, Premium)

| Domain | Primary Accent | Secondary | Neutral Family | Why |
|--------|---------------|-----------|----------------|-----|
| Luxury / Fashion | Off-black `#1A1A2E` | Champagne `#D4AF37` | Zinc | Restraint IS the statement |
| Architecture | Slate `#475569` | Warm gray `#78716C` | Stone | Material, texture, form |
| Photography | Almost-black `#0A0A0A` | White `#FAFAFA` | Zinc | Let images speak |
| Agency / Studio | One bold accent | Nothing else | Stone or Zinc | Confidence, identity |

---

## Gradient Craft

### When to Use Gradients

| Situation | Gradient? | Why |
|-----------|-----------|-----|
| Hero background | Maybe — very subtle tonal shift only | `f[(linear(180,#F8FAFC,#E2E8F0))]`, not a color ramp |
| Card accent bar | Maybe — small surface, not attention-grabbing | Keep it to analogous hues |
| CTA button | **No** — solid colors only | Gradient CTAs are the #1 AI design tell. Use solid dark or solid accent |
| Text headline | Sparingly — one per page max | Gradient text can be a show-stopper, but not every design needs it |
| Sparkline area fills | Yes — fading to transparent | `f[(linear(180,stop(#hex,0,0.15),stop(#hex,1,0.0)))]` for polished charts |
| Every surface | **No** | Modern design uses solid colors + whitespace, not gradients |

### Gradient Types by Mood

| Mood | From to To | Hex | Angle |
|------|-----------|-----|-------|
| Subtle depth | Background to slightly darker | `f[(linear(180,#F8FAFC,#E2E8F0))]` | top to bottom |
| Premium dark | Dark to slightly lighter | `f[(linear(90,#0F172A,#1E293B))]` | left to right |
| Warm energy | Amber to Rose | `f[(linear(135,#F59E0B,#F43F5E))]` | diagonal |
| Ocean calm | Teal to Blue | `f[(linear(90,#14B8A6,#3B82F6))]` | left to right |
| Tech depth | Dark navy to Slate | `f[(linear(135,#0F172A,#334155))]` | diagonal |
| Sunrise | Rose to Amber | `f[(linear(90,#F43F5E,#F59E0B))]` | left to right |
| Forest | Emerald to Teal | `f[(linear(180,#10B981,#14B8A6))]` | top to bottom |
| Frost | Sky to White | `f[(linear(180,#0EA5E9,#F8FAFC))]` | top to bottom |

### Linear vs Radial vs Angular

Linear gradients simulate directional light — a tilted plane, a sweep across a surface. They create **flow** that moves the eye along a path. Radial gradients simulate point-source light — spotlights, lamps, glowing orbs. They create a **focal point** that draws the eye inward. Angular (conic/sweep) gradients rotate colors around a center point — like a color wheel, a clock face, or light refracting through a prism. Choose based on whether your composition needs movement, gravity, or rotation.

**When to reach for radial:**
- Dark UI ambient depth — 2-3 large, low-opacity radial glows at different positions is the signature technique of modern dark UIs (Linear, Vercel, Stripe). The gradient fades from a brand color to transparent; where they overlap, colors blend like watercolors.
- Spotlighting content — a bright center fading to dark edges focuses attention without borders or arrows.
- Vignettes — transparent center → semi-opaque edges over images/backgrounds creates a natural reading zone without hard overlays.
- Simulating a light source on a surface — radial falloff is how real point lights work. A single radial gradient behind a card creates "lift" without any shadow.

**When to reach for angular:**
- Progress rings and gauges — angular gradients naturally follow circular paths, making them ideal for radial progress indicators, speedometers, and timer rings.
- Metallic/holographic sheen — a subtle angular gradient with close hues creates the look of light sweeping across a brushed metal or holographic surface.
- Color wheel / spectrum displays — angular is the only gradient type that can show a full hue rotation around a center point.
- Badge and icon accents — small angular gradients on circular elements create a gem-like refraction effect that linear/radial can't achieve.

**Radial instincts:**
- **Off-center by default.** Centering every radial gradient is an amateur tell — real light sources are almost never at geometric center. Position the bright spot at `(-0.5,-0.5)` (upper-left) to simulate natural overhead light.
- **Elliptical over circular.** Real light pools stretch and distort. Use `w()` for a wider-than-tall gradient — circular radials feel synthetic.
- **Layer, don't overload.** Two radial gradients at 15% opacity beat one at 30%. Layered radials create naturalistic depth that single gradients cannot.
- **Radial + linear stacking.** Linear provides the overall mood direction; a radial on top adds a soft focal highlight. At 10-15% opacity the radial is felt, not seen.

### Gradient Rules

1. **Default is no gradient.** Modern SaaS sites use solid colors + whitespace. Only add a gradient when it genuinely improves the design — most of the time it doesn't.
2. **Never gradient a CTA button.** Solid dark (`#1C1917`) or solid accent. Gradient CTAs are the #1 AI design tell.
3. **Never use blue-purple.** `#3B82F6` to `#8B5CF6` is the most recognizable AI gradient. If you need a gradient, use subtle tonal shifts (`f[(linear(180,#F8FAFC,#E2E8F0))]`) or domain-matched hues.
4. **One good color, shifted.** The best gradients start from ONE color and shift its lightness or hue by small amounts — not two unrelated colors. Blue-to-slightly-more-purple-blue always beats blue-to-orange.
5. **Two stops usually, three strategically.** A carefully placed third stop creates a "knee" that prevents the uniform wash of a two-color blend — but only when you choose the mid-stop color intentionally.
6. **One gradient per visual group.** Card with gradient accent bar + gradient background = competing. Pick one.
7. **Per-stop opacity for overlays.** `f[(linear(180,stop(#000000,0,0.4),stop(#000000,1,0.85)))]` — semi-transparent top, dark bottom. Always specify opacity on BOTH stops.
8. **Angle matches reading direction.** `135` (diagonal) for dynamic energy. `180` (top to bottom) for grounding. `0` (bottom to top) for lift.

---

## Data Visualization Colors

### Semantic Colors (Status)

| Meaning | Color | Hex | When |
|---------|-------|-----|------|
| Success / Growth | Emerald | `#10B981` | Revenue up, task complete, positive delta |
| Warning / Caution | Amber | `#F59E0B` | Near threshold, needs attention |
| Error / Decline | Rose | `#F43F5E` | Revenue down, error state, negative delta |
| Neutral / Info | Blue | `#3B82F6` | Default state, informational |
| Disabled / Empty | Gray | `#94A3B8` | Inactive, no data |

**Rule:** These are universal. Green = good, red = bad, amber = watch it. Don't reverse them.

### Chart Series Colors

When showing multiple data series (line chart, bar chart, pie), use visually distinct, accessible colors:

```
Series 1: #3B82F6 (blue)
Series 2: #10B981 (emerald)
Series 3: #F59E0B (amber)
Series 4: #8B5CF6 (violet)
Series 5: #F43F5E (rose)
Series 6: #06B6D4 (cyan)
```

**Rules:**
- Max 6 series — beyond that, aggregate or filter
- Each color should be distinguishable at a glance
- Don't use adjacent hues (blue + indigo) for consecutive series
- Desaturated/muted versions for less important series

### Sparkline Colors by Metric Type

| Metric type | Stroke | Area fill gradient | Example |
|-------------|--------|-------------------|---------|
| Revenue / growth | `#10B981` | `f[(linear(180,stop(#10B981,0,0.15),stop(#10B981,1,0.0)))]` | Revenue $45.2K |
| Users / signups | `#3B82F6` | `f[(linear(180,stop(#3B82F6,0,0.15),stop(#3B82F6,1,0.0)))]` | Users 2,350 |
| Performance / latency | `#F59E0B` | `f[(linear(180,stop(#F59E0B,0,0.15),stop(#F59E0B,1,0.0)))]` | Latency 42ms |
| Errors / issues | `#F43F5E` | `f[(linear(180,stop(#F43F5E,0,0.15),stop(#F43F5E,1,0.0)))]` | Errors 12 |

---

## Dark Mode Color Mapping

### The Principle

Dark mode is NOT "invert everything." It's a specific mapping:

| Role | Light Mode | Dark Mode | Rule |
|------|-----------|-----------|------|
| Background | `#FFFFFF` / `#F8FAFC` | `#0D1117` / `#111827` | Darkest surface |
| Card surface | `#FFFFFF` + border | `#1F2937` (no border needed) | One step lighter than bg |
| Inset/recessed | `#F1F5F9` | `#0D1117` | One step darker than card |
| Text primary | `#0F172A` | `#F9FAFB` | Near-white, not pure white |
| Text secondary | `#64748B` | `#9CA3AF` | Midtone |
| Text tertiary | `#94A3B8` | `#6B7280` | Near-surface |
| Border | `#E2E8F0` | `#374151` | Subtle separation |
| Hover/surface | `#F1F5F9` | `#374151` | Slightly lighter than card |
| Accent | Keep same | Keep same | Accents don't change |

### Dark Mode Gotchas

1. **Never use `#000000` background.** `#0D1117` or `#111827` — true black feels like a void.
2. **Never use `#FFFFFF` text.** `#F9FAFB` — pure white on dark bg causes eye strain.
3. **Reduce accent saturation on dark.** Vibrant colors on dark backgrounds feel radioactive. Consider `#60A5FA` (lighter blue) instead of `#3B82F6` on dark surfaces.
4. **Borders become optional.** Dark surfaces naturally separate from each other with slight lightness differences. Remove most borders.
5. **Shadows become invisible.** Dark mode cards don't need drop shadows — the surface color difference does the work.
6. **Images need darkened overlay.** Bright images on dark pages create jarring contrast. Add `f[(solid(#000000,0.2))]` overlay.

---

## Accessible Color Combinations

### Contrast Ratios (WCAG AA)

| Text size | Required ratio | What this means |
|-----------|---------------|-----------------|
| Normal text (< 18px) | 4.5:1 | Dark text on light bg, or light text on dark bg |
| Large text (18px+ bold, 24px+) | 3:1 | More lenient for headings |
| Non-text (icons, borders) | 3:1 | UI components need visibility |

### Pre-Checked Safe Pairs

| Background | Text | Ratio | Safe? |
|-----------|------|-------|-------|
| `#FFFFFF` | `#0F172A` | 16.7:1 | Yes |
| `#FFFFFF` | `#334155` | 9.4:1 | Yes |
| `#FFFFFF` | `#64748B` | 4.9:1 | Yes (barely) |
| `#FFFFFF` | `#94A3B8` | 3.0:1 | Large text only |
| `#F8FAFC` | `#0F172A` | 15.5:1 | Yes |
| `#3B82F6` | `#FFFFFF` | 4.6:1 | Yes |
| `#10B981` | `#FFFFFF` | 3.4:1 | Large text only |
| `#111827` | `#F9FAFB` | 17.5:1 | Yes |
| `#111827` | `#9CA3AF` | 5.1:1 | Yes |

**Gotcha:** `#10B981` (emerald) on white only passes for large text. Use `#059669` (darker emerald) for small text on white, or white text on emerald background.
