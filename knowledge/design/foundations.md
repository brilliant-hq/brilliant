# Design Foundations

Core judgment for every build. For 3+ similar elements (cards, tiles,
rows, swatches), declare the shape once with `comp` and stamp `inst()`
copies; load `blueprint/components`. Hand-coding N near-identical lines
is a smell — and for copies on a circle/arc/grid, compute each position,
never eyeball (see `blueprint/layout-patterns`).

## Before you build

Read the intent. A vague prompt with no visual context means the user is
evaluating you: deliver one tight, impressive piece. A specific product
prompt means clarity and usability come before style. Either way, commit
to a system first: 3-6 colors with roles, a font with heading and body
weights, a spacing rhythm. Then decide the emotion, the focal point (one
per section), and the personality.

## Effect budget by personality

- **Minimal**: subtle or no shadows, no effects, solid background.
- **Professional**: layered shadows on key elements, one glass or shader
  accent, a gradient background.
- **Bold / playful**: colored shadows, 2-3 effects, claymorphism, rich
  gradients.
- **Dark / premium**: colored inner glows, glass over shaders, ambient
  gradients.

## Composition

Every screen needs one dominant region that draws the eye first;
secondary regions stay visibly subordinate (smaller, lighter, less
contrast). If you squint and nothing dominates, raise the contrast.
Prefer information on surfaces over boxing everything in cards; favor
asymmetry and scale contrast over grid-like sameness. Headlines run 4-8
words, subtitles 12-25; one CTA per section; aim for 60-70% white space,
then ask what to remove.

## Avoid the AI clichés

- **Hero weight**: modern SaaS heroes use `mid`/`firm` (500/600), not
  bold; at 48-64px mid reads confident.
- **Eyebrows**: the tinted pill is the #1 tell. Vary it: outlined pill,
  split pill, plain overline, an avatar stack with a count, or none.
- **Color**: skip blue-to-purple gradients, neon-on-dark, all-white with
  one safe accent, and low-opacity circles behind sections. If you have
  seen a combo in three AI designs, drop it.

For a second color, reach for brand slots first (`$primary` +
`$secondary`), then semantic aliases (`$color.secondary`), and Tailwind
stops only for genuinely hue-specific needs (data viz, fixed badges).
