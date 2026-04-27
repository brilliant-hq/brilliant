# Design Foundations

Core guidance for every design. Load this for any building task.

## Repeated Elements — Use `for(...)`, Don't Hand-Code

**If your design has 3+ similar elements** (cards, tiles, list rows, buttons in a row, calendar days, color swatches, dot grids, table rows) — load `blueprint/components` and use `for(...)`. Hand-coding N near-identical lines is a smell, not a baseline. The loop version is shorter, lets you address each iteration with `#ref_<value>` after creation, and stays in sync if you tweak the master.

```
WRONG (5 nearly-identical hand-coded cards, no per-iteration ref):
  al(v) "Stat 1" #s1
    t("Revenue",...)
    t("$48.2K",...)
  al(v) "Stat 2" #s2
    ...

RIGHT (one loop, per-iteration refs minted automatically):
  for(vars[$label,$val], in([(Revenue,$48.2K),(Users,1284),(Conv,3.2%)]))
    al(v) "Stat $label" #stat
      t("$label",...)
      t("$val",...)
```

After expansion, `#stat_Revenue`, `#stat_Users`, `#stat_Conv` each address one tile. See `blueprint/components` for the full syntax (range, vars[...], variants, slots, flat).

## Before You Build

**Read the intent.** Vague prompt + no visual context = user is evaluating you — deliver one tight, impressive deliverable. Specific product prompt = prioritize clarity and usability over style.

**Commit to a system.** Before building: pick 3-6 hex values with roles, font + heading/body weights/sizes, spacing rhythm (section / group / element gaps).

Then answer: **What emotion?** · **What's the focal point?** (one per section) · **What personality?** (determines effect budget below)

## Effect Intensity by Personality

Minimal: subtle/no shadows, skip effects (restraint IS premium), solid bg. Professional: layered shadows on key elements, 1 glass/shader accent, gradient bg. Bold: strong colored shadows, 2-3 effects, rich bg. Playful: colored shadows, claymorphism, bright gradients. Dark/premium: colored inner glows, glass+shaders, gradient+ambient.

**Default to restraint.** White space is a feature, not wasted space.

## Visual Weight & Composition

Every screen needs **one dominant visual region** — the element that carries the most weight and draws the eye first. Secondary regions must be visually subordinate (smaller, lighter, less contrast). Avoid equal-weight zones competing for attention — if two sections feel equally important, one of them isn't designed yet.

Ask: "If I squint, does one area clearly dominate?" If not, increase the contrast between primary and secondary.

## Content & Layout

Hero headline 4-8 words · subtitle 12-25 words · section heading 3-6 words · card description 10-25 words.
Max 1 CTA per section. 60-70% whitespace. After building, ask "what can I remove?"

Prefer information directly on surfaces over boxing everything in cards. Favor asymmetry and scale contrast (large headline next to small muted text) over grid-like sameness. Vary spacing — tighter to group related elements, generous to let hero content breathe.

## Hero Anti-Cliches

**Weight:** Modern SaaS heroes use `medium` or `semibold` — not bold. At 48-64px, medium reads as confident.

**Eyebrow variety** (tinted pill is the #1 AI cliche): tinted pill (feature launches) · outlined pill (premium, minimal) · split pill (announcements) · plain overline text (editorial) · avatar stack + count (social proof) · no eyebrow (strong headlines).

## AI Color Anti-Patterns

Avoid: blue-to-purple gradient (use domain-matched colors) · dark bg + neon green/cyan (use warm dark + amber/gold) · all-white + only blue #3B82F6 (try indigo, emerald, violet) · lime green on dark (use emerald/teal) · low-opacity circles behind sections (use solid, gradient, or nothing).

**Rule:** Default to white/light mode. Test: would these colors work in a 1985 poster, a 2000s magazine, and today? If yes, excellent. If you've seen the combo in 3+ AI designs, skip it. One bold color choice is better than several.
