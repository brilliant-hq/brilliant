# Design Foundations

Core judgment for every build. Reusable UI is a component, not hand-coded
copies: the same shape stamped more than once (cards, rows, swatches), or a
shape with states (button primary/secondary/tertiary, tab active/inactive). Pick the
kind, inline degenerate vs outside set, per `blueprint/components`. For copies
on a circle/arc/grid, compute each position, never eyeball
(see `blueprint/layout-patterns`).

## Before you build

Read the intent. A vague prompt with no visual context means the user is
evaluating you: deliver one tight, impressive piece. A specific product
prompt means clarity and usability come before style. Either way, commit
to a system first: 3-6 colors with roles, a font with heading and body
weights, a spacing rhythm. For a second color, reach for brand slots
(`$primary`/`$secondary`), then semantic aliases (`$color.secondary`),
Tailwind stops only for genuinely hue-specific needs (data viz, fixed
badges). Then decide the emotion, the focal point (one per section), and
the personality. Derivative is a tell: if you've seen a combo in three AI
designs, drop it.

## Composition

Every screen needs one dominant region that draws the eye first;
secondary regions stay visibly subordinate (smaller, lighter, less
contrast). If you squint and nothing dominates, raise the contrast.
Prefer information on surfaces over boxing everything in cards; favor
asymmetry and scale contrast over grid-like sameness. Headlines run 4-8
words, subtitles 12-25; one CTA per section; aim for 60-70% white space,
then ask what to remove.
