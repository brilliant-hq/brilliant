---
dsl: [ds_file, unset, designSystem, brand, modes]
---
# Design System: Authoring & Modifying

`ds_file("name")` authors or extends a brand: a top-level statement,
body is indentation-based DSL. It inherits the project `default` (the
catalog shown in your init context), so declare ONLY what differs, a
real brand is usually a few lines. Output merges into
`<canvas-folder>/Styles/<name>.styles` and runs before element rows, so
later rows can `ds(name)` it. Kebab-case; name the visual direction
(`fintech-warm`), not the task.

```
ds_file("fintech-warm")
  modes { theme: [light, dark] }          // axes; first value = default

  // PRIMITIVE (mode-independent): color(seed) → 11-stop OKLCH ramp .50…950,
  // number([list]|seed,count,ramp) → numeric scale. SEMANTIC wraps one in a
  // role vocab; mode behavior auto-applies per generator (see authoring-modes):
  primary:         boldness(color(#1976D2))            // 9 roles hint…intense
  spacing:         tshirt(number([4,8,16,24,32]), min: { none: 0 })  // xs…Nxl + named stop
  font.lineHeight: looseness(number([1,1.25,1.5]))     // 6 steps none…loose
  font.family:     "Noto Serif"                        // multi-word names need quotes; single-word fonts (Manrope, Inter) can stay bare

  // Color roles need boldness(color(...)), a bare hex is one frozen value,
  // no light/dark flip, no hover/container steps. Outside-catalog hue gets
  // its own primitive first:
  success:       boldness(color(#1AAB7A))
  color.success: success.firm // correct, mode aware dynamic resolution
  // WRONG: color.success: #bare-hex // incorrect, non-mode aware static resolution

  // Per-mode branch on an alias; $default is the fallback. Combo key
  // (`theme.dark, density.compact:`) fires only when ALL modes active:
  color.surface { $default: neutral.hint, dark: neutral.intense }

  typography.h1: { fontSize: font.size.3xl, fontWeight: font.weight.bold }  // composite record
  shadow.md: [ drop(y: 2, blur: 4, color: rgba(0,0,0,0.1)) ]                // composite list

  unset { color.primary, *.dark }   // drop inherited entries; *.key hits all semantics
```

After `ds_file()`, the brand becomes the session default and unstamped
frames auto-stamp it. `inherits: none` makes a brand standalone (rare);
`root: true` stops the parent-folder cascade. Comments are preserved
into `.styles` and carry to future sessions, use them for design intent.
