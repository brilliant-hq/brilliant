---
assumes: blueprint/paint
---
# Design Colors

For color syntax, see `blueprint/paint`.

## 60-30-10 Rule

60% dominant (backgrounds #FFF/#F8FAFC) · 30% secondary (text/borders #334155/#E2E8F0) · 10% accent (CTAs #3B82F6/#10B981). Most common mistake: accent on 30%+ of surface. One accent CTA is confident — accent on navbar, headers, AND badges is noisy.

## Building from One Accent

1. Pick accent (match domain below)
2. Generate tinted neutral — desaturate 90%, darken for text
3. Light variant — accent at 8-12% opacity for tags/badges
4. Dark variant — darken 15-20% for hover/pressed

## Neutrals

Slate (cool blue, pairs with blue/indigo/violet) · Stone (warm yellow, pairs with amber/orange/rose) · Zinc (true neutral, pairs with anything) · avoid pure Gray (lifeless). **Body text should never be pure black (#000) or pure gray (#333/#666)** — tint it to match your neutral family.

## Domain Color Psychology

Restaurant: Amber `#F59E0B` / Red `#DC2626`, Stone · Finance: Emerald `#10B981`, Slate · SaaS: Blue `#3B82F6`, Slate · Dev Tools: Violet `#8B5CF6`, Zinc · Travel/Luxury: Teal `#0D9488`, Stone · Healthcare: Teal `#14B8A6`, Slate · Gaming: Violet/Lime, Zinc · Luxury/Fashion: Off-black `#1A1A2E`, Zinc.

## Dark Mode

Light → Dark: bg #FFFFFF→#0D1117 · card #FFFFFF+border→#1F2937 · text primary #0F172A→#F9FAFB · text secondary #64748B→#9CA3AF · border #E2E8F0→#374151 · accent stays the same.
Never #000 bg (void), never #FFF text (eye strain). Reduce accent saturation on dark. Shadows invisible — surface color does the work.

## Data Viz Colors

**Semantic:** Green=good `#10B981`, Red=bad `#F43F5E`, Amber=warning `#F59E0B`, Blue=neutral `#3B82F6`

**Chart series (max 6):** `#3B82F6` `#10B981` `#F59E0B` `#8B5CF6` `#F43F5E` `#06B6D4`

## Contrast (WCAG AA)

Normal text (<18px): 4.5:1 · Large text (18px+ bold): 3:1 · `#10B981` on white fails for small text — use `#059669`. Reduced opacity is useful for hierarchy but text must remain readable at a glance.
