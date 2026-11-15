---
name: "knowledge-design-systems-figma-import"
description: "Importing a design system from Figma, and what the design system can and cannot do."
assumes: reference/design-systems
---

# Figma Import, Can and Cannot

## Importing a Design System from Figma

Bringing a Figma file into Brilliant with the Brilliant Figma plugin (its whole-file import, Import to Brilliant and the import screen, or copy in Figma with the plugin, then paste into Brilliant with Cmd+V) carries the file's design system across as a real Brilliant system, not as flattened literal values. For the import mechanics (the plugin, the import screen, connecting Figma), see `reference/canvases/figma-import`. What you get on the design-system side:

- **Every variable keeps its Figma name.** A variable named `brand/500` arrives as a token named `brand.500`; nothing is renamed away, so a search for the name you already know still finds it. One exception: a name segment that is only a number and is followed by a segment starting with a digit gets an underscore, so `blue/500/50` becomes `blue.500._50`, because the token language reads `500.50` as one number.
- **Each multi-mode collection becomes its own mode axis.** A collection with modes like Day and Night becomes an axis you can switch in the inspector, independently of every other collection. A collection whose modes are Light and Dark instead drives Brilliant's built-in theme toggle, so the light/dark switch just works on it. Single-mode collections come in as plain tokens.
- **Brilliant's role names are added on top, as aliases.** Where a Figma token clearly plays a standard role (a primary brand color, a surface, body text, an h1 type style), Brilliant adds its own role name (`color.primary`, `color.surface`, `typography.h1`, and friends) pointing at your token. Both names resolve, and because the role points at your token, switching brands or editing that token re-themes through the role.
- **Per-node mode overrides become per-element pins.** A node pinned to a specific collection mode in Figma (a dark strip inside a light page) imports pinned to that mode and stays that way across brand switches.
- **Gradient style stop colors become tokens.** A shared gradient paint style brings each of its stop colors across as its own color token, rebound to the matching gradient stops on the elements that used the style.

The import boundaries (what stays literal or on the element rather than becoming a token) are listed under Cannot below, and each such loss is named in the import warnings so nothing drops silently.

## What Brilliant Can and Cannot Do

Can:
- Resolve color, spacing, radius, typography, shadow, stroke-width, opacity, and font tokens at paint time, so one source edit updates every binding.
- Define multiple brands and switch between them at canvas or element scope with live hover preview.
- Define multiple mode axes (theme, density, accessibility, plus arbitrary custom axes) and switch each independently.
- Bind tokens in every color slot and in numeric properties (radius, opacity, gap, padding, stroke width, font size/weight/line height/family).
- Apply composite typography and shadow tokens via commands.
- Visualize the system with the Design System Viewer element.
- Import a Figma file's design system (via the Brilliant Figma plugin) as a real Brilliant system: variables keep their names, each multi-mode collection becomes a mode axis, a light/dark collection drives the theme toggle, standard roles are added as aliases, per-node mode overrides become per-element pins, and gradient-style stop colors become tokens (see "Importing a Design System from Figma" above).
- Generate, on save, a `Styles/.gen/<name>.gen.yaml` artifact of fully resolved values for external tools (Style Dictionary, Tokens Studio, custom build scripts). These `.gen` files are git-ignored and must never be hand-edited.
- Survive a `.ds` file with a syntax error: the design keeps rendering against the last version of that file that parsed (also after you quit and reopen Brilliant), and a notification names the file and how many errors it has, with an Open button that takes you to the first error in the code editor (it stays until dismissed, and clears itself when the file parses again; while the file is already open in the code editor, the list of problems above the text tells you instead). While a file is broken, brand and mode switches on it are declined rather than rewriting the file over your unfinished edit. A deleted `.ds` is not an error, it simply stops contributing.

Cannot:
- There is **no standalone variables / token editor panel**. Token authoring (new tokens, renames, deletes, scale tweaks, mode overrides) is done by editing the `.ds` source, not through inspector buttons. There are no in-app rename or delete buttons for tokens.
- There is **no default keyboard shortcut** for switching brand or mode; use the inspector dropdowns.
- There is **no export to CSS variables or Tailwind config** from the UI; external tools consume the `.gen.yaml` artifact.

Figma import boundaries (each announced in the import warnings, never silent):
- **Gradient geometry is not themable.** A gradient paint style brings its stop *colors* across as tokens, but the gradient's geometry (angle, stop positions) imports as fixed values, not tokens.
- **Image paint styles stay literal.** A photo/image paint style has nothing single-valued to tokenize, so it imports as a literal image fill.
- **Some text-style details stay on the element, not the token.** Italic, text case, text decoration, and a pixel line-height unit are kept on the imported elements but are not carried into the typography tokens (Brilliant's typography tokens do not express them). The expressible parts of the type style still become a token, including letter spacing: a px or percent letter spacing imports as a font-size fraction on the token (like a line-height multiplier), so it survives.
- **T-shirt role names are aliases only.** When a large numeric scale imports, Brilliant may add t-shirt role names (`spacing.md` and friends) as aliases, but element bindings stay on your faithfully-named tokens: a numeric binding is never redirected onto a role alias.
- **Your role names are never overwritten.** If a Figma variable already owns a standard role name, Brilliant keeps your token and adds no competing alias; a dark-theme sibling of that variable stays its own separate token rather than folding onto the role.
