---
assumes: blueprint/text
---
# Design Typography

For text syntax, see `blueprint/text`.

## Type Scale (Body = 16px)

```
12 · 14 · 16 · 18 · 20 · 24 · 30 · 36 · 48 · 60 · 72
```

Overline 11-12/sb UPPERCASE · Caption 12-13/m · Secondary 13-14/r · Body 15-16/r · Subheading 18-20/sb · Section heading 24-28/b · Page heading 32-40/b · Hero 44-72/b or eb.
Jump rule: heading = 150-200% of body.

## Font Pairing

**Same family (safest):** Inter bold + Inter regular. DM Sans, Plus Jakarta Sans also work.
**Sans + Serif (high contrast):** Playfair Display / bold + Inter / regular → luxury, editorial.
**Geometric + Humanist:** Space Grotesk / bold + Inter / regular → tech, developer.

Domain fonts: Restaurant (Playfair Display, Lora, DM Serif Display) · Finance (Inter, DM Sans, Space Grotesk) · Developer Tools (Space Grotesk, JetBrains Mono) · SaaS (Plus Jakarta Sans, Outfit, Sora) · Agency (Instrument Sans, Bricolage Grotesque).

**Avoid:** Inter for everything (generic), Poppins + Poppins (template feel), Roboto (placeholder).

## Hierarchy

Use 2-3 levers simultaneously: **Size** + **Weight** + **Color**. Pair heavy headings (bold/extrabold) with regular or light body. 3-4 text colors max: Primary `#0F172A` · Body `#334155` · Secondary `#64748B` · Subtle `#94A3B8`. Max 2 font families. Tighter tracking on large type (24px+), open tracking on small-caps or labels below 13px.

## Anchor Principle

Every screen has ONE focal element sized 2-3x body: landing hero headline 48-72px · pricing price 36-48px · dashboard primary KPI 32-48px.
