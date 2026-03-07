---
name: "building-typography"
description: "Deep typography knowledge: type scale construction, font pairing theory, visual hierarchy, styled ranges mastery, when to go big, domain typography."
---

> **Parent skill:** [building/SKILL.md](./SKILL.md)

# Typography Mastery

Deep knowledge for choosing, sizing, and styling text. Typography is 80% of what makes a design feel "professionally designed" vs. "AI-generated."

> **This file is about typographic decisions and craft.** For text syntax and styled range flags, see CLAUDE.md. For font catalog, see `assets/FONTS.md`.

---

## The Type Scale

### Standard Scale (Body = 16px)

```
12 · 14 · 16 · 18 · 20 · 24 · 30 · 36 · 48 · 60 · 72
```

| Role | Size | Weight | Letter Case |
|------|------|--------|-------------|
| Overline / tag | 11-12 | semibold | UPPERCASE |
| Caption / meta | 12-13 | medium | Normal |
| Secondary text | 13-14 | regular | Normal |
| Body | 15-16 | regular | Normal |
| Subheading | 18-20 | semibold | Normal |
| Section heading | 24-28 | bold | Normal |
| Page heading | 32-40 | bold | Normal |
| Hero headline | 44-72 | bold/extrabold | Normal |
| Display / statement | 72-120 | bold/black | Often UPPERCASE |

### Compact Scale (Mobile, Cards)

When space is tight, tighten the entire scale:

```
11 · 13 · 14 · 16 · 18 · 24 · 32
```

Body at 14px, headings at 18-24px, hero at 32px. Everything shrinks proportionally.

### The Jump Rule

**Heading should be 150-200% of body.** If body is 16px, heading is 24-32px. This creates clear hierarchy without wasteful gaps. Common mistake: body at 16px, heading at 18px — that's barely different. Be bold with your jumps.

---

## Font Pairing Theory

### The 3 Pairing Strategies

**1. Same family, different weights (Safest)**

One font family, vary weight for hierarchy. Works 90% of the time:

| Heading | Body | Effect |
|---------|------|--------|
| Inter / bold | Inter / regular | Clean, corporate |
| DM Sans / bold | DM Sans / regular | Modern, geometric |
| Plus Jakarta Sans / bold | Plus Jakarta Sans / regular | Friendly, startup |

**2. Sans + Serif (High Contrast)**

Serif headings + sans body creates editorial, premium feel:

| Heading | Body | Effect |
|---------|------|--------|
| Playfair Display / bold | Inter / regular | Luxury, editorial |
| Libre Baskerville / bold | DM Sans / regular | Traditional, authoritative |
| Lora / bold | Source Sans Pro / regular | Warm, literary |

**3. Geometric + Humanist (Subtle Contrast)**

Two sans-serif fonts with different shapes — geometric (circular Os, even strokes) vs humanist (calligraphic, organic):

| Heading | Body | Effect |
|---------|------|--------|
| Space Grotesk / bold | Inter / regular | Tech, developer |
| Outfit / bold | Inter / regular | Modern, clean |
| Sora / bold | Work Sans / regular | Contemporary, balanced |
| Bricolage Grotesque / bold | DM Sans / regular | Distinctive, editorial |

### Domain-Specific Font Selection

| Domain | Good heading fonts | Why |
|--------|-------------------|-----|
| **Restaurant / Food** | Playfair Display, Lora, DM Serif Display | Warmth, craft, organic feel |
| **Finance / Fintech** | Inter, DM Sans, Space Grotesk | Precision, trust, clarity |
| **Developer Tools** | Space Grotesk, JetBrains Mono, Outfit | Technical, monospaced influence |
| **Travel / Luxury** | Playfair Display, Cormorant Garamond, Libre Baskerville | Elegance, timelessness |
| **SaaS / Startup** | Plus Jakarta Sans, Outfit, Sora | Friendly, modern, energetic |
| **Healthcare** | DM Sans, Nunito, Source Sans Pro | Approachable, clean, calm |
| **Education** | Nunito, Rubik, Poppins | Friendly, rounded, welcoming |
| **Agency / Portfolio** | Instrument Sans, Bricolage Grotesque, Sora | Distinctive, contemporary |
| **E-commerce** | Poppins, Raleway, Plus Jakarta Sans | Clean, readable, versatile |
| **News / Editorial** | Libre Baskerville, Merriweather, Lora | Authority, readability |

### Fonts to Avoid (Overused in AI Outputs)

| Font | Problem | Better Alternative |
|------|---------|-------------------|
| Inter for everything | The #1 cause of generic-looking AI designs | Use Inter for BODY only. Pick a different heading font |
| Poppins + Poppins | So overused it screams "template" | DM Sans, Plus Jakarta Sans, Outfit |
| Roboto | Default Android — feels like a placeholder | Inter, DM Sans, Source Sans Pro |

---

## Visual Hierarchy

### The Squint Test

Blur your eyes (or zoom out). You should see 3 clear layers:

1. **Anchor** — The ONE element that draws the eye first (hero headline, key stat, price)
2. **Support** — Elements that explain the anchor (subtitle, description, labels)
3. **Detail** — Everything else (metadata, captions, borders)

If everything looks the same weight when blurred → hierarchy is too flat. If more than one thing screams for attention → hierarchy is too noisy.

### Creating Hierarchy (4 Levers)

| Lever | Low priority | High priority |
|-------|-------------|---------------|
| **Size** | 12-14px | 32-72px |
| **Weight** | regular (400) | bold (700) / extrabold (800) |
| **Color** | `#94A3B8` (subtle) | `#0F172A` (primary) |
| **Contrast** | Low against background | High against background |

**Best practice:** Use 2-3 levers simultaneously. Don't just make a heading bigger — make it bigger AND bolder AND darker. One lever alone isn't enough:

```
# Weak hierarchy (only size differs)
Title: 24px / regular / #64748B
Body:  16px / regular / #64748B

# Strong hierarchy (size + weight + color all differ)
Title: 32px / bold / #0F172A
Body:  16px / regular / #64748B
```

### Weight Mapping

| CSS Weight | Keyword | Use for |
|-----------|---------|---------|
| 400 | `r` | Body text, descriptions |
| 500 | `m` | Labels, secondary headings, captions |
| 600 | `sb` | Subheadings, nav links, card titles |
| 700 | `b` | Section headings, hero headlines, CTAs |
| 800 | `eb` | Display headlines, hero text |
| 900 | `bl` | Oversized watermarks, statement text |

**Rule:** Most designs need only 2-3 weights. `r` + `sb` + `b` covers 95% of use cases. Don't use all 6 weights in one design.

---

## Styled Ranges Mastery

Styled ranges are the single highest-leverage typography upgrade. They transform flat, uniform text into visually rich, editorially styled content.

> For basic construction (accent word, price formatting, mixed typeface), see BUILDING_BLOCKS.md > Styled Text Patterns. This section covers advanced patterns and guidance.

### Pattern: Price with Mixed Formatting

```
t("$49/month",Inter,32,b) f[(#0F172A)] "Price"
  spans[("$49",s(48),b,#10B981),("/month",#64748B,s(16))]
```

Result: Large green "$49" + small gray "/month". Every pricing element should use this pattern.

**More price variations:**
```
# Dimmed original price (no strikethrough in DSL — use gray color + small size)
t("$99 $49/mo",Inter,24) "Price"
  spans[("$99",#94A3B8,s(16)),("$49",b,s(36),#0F172A),("/mo",#64748B,s(14))]

# Free tier
t("$0 forever",Inter,32,b) "Price"
  spans[("$0",s(48),#10B981),("forever",#64748B,s(16),w(400))]
```

### Pattern: Stat with Unit

```
t("2,847 users",Inter,32,b) f[(#0F172A)] "Stat"
  spans[("users",w(600),s(16),#64748B)]
```

Result: Bold "2,847" + smaller gray "users." Use for dashboard metrics, profile stats, achievement numbers.

### Pattern: Feature Description with Bold Keyword

```
t("Unlimited projects for your entire team",Inter,15) "Desc"
  spans[("Unlimited",w(600),#0F172A)]
```

Making one keyword bold in body text draws the eye to the benefit. Use in feature lists, descriptions, bullet points.

### Pattern: Tag / Badge with Emphasis

```
t("NEW FEATURE",Inter,11,sb) f[(#3B82F6)] "Tag"
  spans[("NEW",b,s(12))]
```

Subtle size/weight variation even within tiny text creates polish.

### When to Apply Styled Ranges

| Element | Style it? | How |
|---------|-----------|-----|
| Hero headline | **Always** | Bold accent word, color, or italic |
| Price | **Always** | Large amount + small period/unit |
| Stat / metric | **Always** | Bold number + lighter label/unit |
| Feature title | Usually | Bold keyword |
| Navigation | Sometimes | Bold active item |
| Body paragraph | Rarely | Only for inline emphasis |
| Caption / meta | Never | Too small for mixed formatting |

---

## When to Go Big

### The Anchor Principle

Every screen has ONE focal element. Size it aggressively:

| Screen type | Anchor element | Target size |
|------------|----------------|-------------|
| Landing page hero | Headline | 48-72px bold |
| Pricing page | Price amount | 36-48px bold |
| Dashboard | Primary KPI | 32-48px bold |
| Profile page | User name or key stat | 28-40px bold |
| Weather app | Temperature | 72-96px bold |
| Timer / clock | Time display | 64-120px bold |
| Receipt / invoice | Total amount | 36-48px bold |

**Rule:** The anchor should be 2-3x the body text size. If body is 16px, the anchor should be 32-48px minimum. Undersized anchors make designs feel timid.

### Hero Headlines Specifically

Hero headlines are **always bold or semibold** — never regular weight. A 48px regular-weight headline looks like an accident, not a design choice.

| Hero style | Size | Weight | Font |
|-----------|------|--------|------|
| Confident minimal | 48-56px | bold | Sans-serif |
| Editorial statement | 64-80px | bold | Serif |
| Typographic hero | 80-120px | extrabold/black | Display font |
| Subtle elegance | 40-48px | semibold | Elegant sans |

---

## Text Layout Rules

### Line Length

Optimal readable line: **45-75 characters** (roughly 400-600px for 16px body text).

| Width | Too narrow? | Too wide? |
|-------|-------------|-----------|
| < 300px | Yes — lines break awkwardly | |
| 300-400px | Good for cards, sidebars | |
| 400-600px | Ideal for body text | |
| 600-800px | | Getting wide — use columns |
| > 800px | | Yes — eyes lose track of lines |

**Fix wide text:** Use `s(fixed_width,hug)` to constrain width, or put text inside a narrower frame. Wide horizontal padding on the parent also works: `pad(40,200)` keeps text centered with generous margins.

### Text Color Hierarchy

Use exactly 3-4 text colors per design:

| Role | Light mode | Dark mode | Usage |
|------|-----------|-----------|-------|
| Primary | `#0F172A` | `#F9FAFB` | Headings, key content |
| Body | `#334155` | `#D1D5DB` | Paragraphs, descriptions |
| Secondary | `#64748B` | `#9CA3AF` | Labels, metadata, captions |
| Subtle | `#94A3B8` | `#6B7280` | Placeholders, disabled text |

**Rule:** Never use more than 4 text colors. 3 is ideal. Each color has a clear role. Random grays at arbitrary lightness look messy.

### Uppercase Text Rules

Uppercase is for **short labels only** (1-3 words):

| Good use | Example |
|----------|---------|
| Overlines | `t("FEATURES",Inter,11,sb)` |
| Badge text | `t("NEW",Inter,11,sb)` |
| Tab labels | `t("OVERVIEW",Inter,12,m)` |
| Section tags | `t("PRICING",Inter,11,sb)` |

**Never uppercase:** Sentences, descriptions, paragraphs, headings longer than 3 words. Uppercase body text is unreadable and feels like shouting.

---

## Common Typography Mistakes

| Mistake | Fix |
|---------|-----|
| All text is the same size (16px everything) | Establish clear scale: 14px body, 24px heading, 48px hero |
| All text is the same color (`#333`) | Use 3 tiers: primary, body, secondary (see above) |
| Heading is regular weight | Headings are bold/semibold — always |
| Too many font sizes (8+ different sizes) | Stick to 4-5 sizes from the scale |
| Too many font families (3+) | Max 2 families: one heading, one body |
| No styled ranges on prices/stats | Every number deserves mixed formatting |
| Inter for everything | Inter for body only. Pick a heading font |
| Hero headline at regular weight | Hero = bold/extrabold. Regular weight looks accidental |
| Subtitle same weight as heading | Subtitle = regular/medium. Heading = bold. Contrast! |
| No size difference between heading and subheading | At least 1.5x jump between hierarchy levels |
