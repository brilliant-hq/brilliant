---
assumes: motion/core
dsl: [state, label, to, sec, pair, enter, exit, delay, at, stagger, by, all, name, in, not, camera, ease, spring, blur, loop, treatment, video, fn, snappy, smooth, bouncy, decelerate, accelerate, standard, emphasized]
---
# Motion: Grammar

A window's body is one row per target, each on its own clock inside the window: it starts with the window and runs to its end unless it says otherwise. The rows below are the timeline of `motion/core`'s film, reworked to show every form once.

```
label(sec(3.2)) #drop                                                    // a named time
#s01 hold(sec(0.5))
#s01 to(#s02) sec(0.8) snappy blur(6)                                    // the window: length, curve, its own shutter
  #hero s[snappy] rd[smooth,delay(sec(0.05))] o[decelerate,sec(0.2)]     // per-property clocks: the orb stretches into the capsule
  [#send,#send-i] at(sec(0.3)) sec(0.4) enter(pop) stagger(sec(0.06))    // a list in 02 only: pops in 0.3 s in, 0.4 s each, in order
  camera(fit(#hero),pad(240)) smooth                                     // the camera, its own row on its own curve
#s02 to(#s03) sec(1)
  #prompt at(end-sec(0.6)) enter(rise(32),by(word))                      // in 03 only: rises in word by word, ending with the window
  #send delay(sec(0.2))                                                  // the whole run shifted, it settles into the hold
#s03 hold(sec(0.5))
#s03 to(#s04) sec(0.4) spring(f(2.4),z(0.8))                             // a curve inline
  #prompt at(sec(0.06)) sec(0.3) p[ease(in,cubic)] o[ease(in,quad)]      // its own start and length inside the window
  #send at(prev+sec(0.06)) s[bouncy]                                     // 0.06 s after the row above starts
#s04 to(#s05) sec(0) at(#drop)                                           // a hard cut on the label
  camera(p(0,0),s(1920,1080))                                            // back to the whole frame
#s05 to(#s06) sec(2.8) ease(out,cubic)
  all(name(cl),not(#cl-1)) stagger(sec(0.2),from(end)) f[ease(out,cubic),sec(0.45)]   // a set: cl-2 and cl-3 darken, the last first
  #cl-1 at(prev+sec(0.1)) f[standard]
  #cline at(sec(0.7)) enter(mask(line),by(word)) stagger(sec(0.12))      // the line rises out of its own baseline, word by word
#s06 hold(sec(1.4))
```

**Targets.** A `#ref` or an element id, a list `[#a,#b]`, or a set `all(...)` whose filters intersect: `name(tile)` (`tile`, `tile-1`, `tile-12`), `type(t)` (the blueprint type words), `in(#grid)` (descendants), `not(#x)`. A set is stored as written, so an element added later joins it, and the export answer's `matches` lists its members. One body row per element per window, carrying every note about that element (`#reply enter(rise(24),by(word))`, `#send click`). `pair(#other)` on a row pairs its element with a differently named one of the other state. A `camera(...)` row has no target.

**Clocks.** `at(sec(0.2))` from the window's start, `at(end-sec(0.25))` from its end, `at(prev+sec(0.1))` from the previous body row's start, `at(#drop+sec(0.5))` from a label, the row's own `sec()` its length, `delay(sec(0.2))` shifts the whole run. On a timeline row `at(...)` places the row itself: a gap holds the previous state, `at(end-sec(0.2))` overlaps the row before. Per-property clocks `p[] s[] o[] rot[] rd[] f[] st[] fx[]` each take a curve, a length and a `delay()`, or `cut` (a switch at the midpoint, `f[cut,delay(sec(0.3))]` at 0.3 s), items comma-separated, and on the window row a bracket covers every matched element.

**Enter and exit**, for an element in one state only: `enter(<kind>,sec(),<curve>,by(glyph|word|line))`, kinds `fade` (the default), `rise(px)`, `drop(px)`, `slide(left|right|up|down,px)`, `pop` (0.85 to 1 on a spring), `wipe(left|right|up|down)`, `mask(line)` (up out of its own baseline), `draw`. An enter runs 0.35 s and an exit 0.2 s unless the note names a length, and an exit runs backward. `enter(sec(0.2))` is a plain dissolve of that length, `enter(sec(0))` and `exit(sec(0))` pop and cut at the window's start, and `exit(sec(0))` on the window row cuts every element leaving. `by(glyph|word|line)` reveals per unit (`stagger` sets the step), a container `by(child)`, the text keeps one fill across its box, so a gradient line reveals as one sweep. `stagger(sec(<step>)|amount(sec(<total>)),from(start|end|center|edges|random),grid(r,c),ease(<curve>))` spreads the starts over its row's container children, list, set or text units.

**Camera.** `camera(fit(#ref),pad(px))` or `camera(p(x,y),s(w,h))` in the reached state's coordinates, its own row under a window or a hold, arriving at the window's end on its own curve and held by every later row until another camera, `camera(p(0,0),s(W,H))` the whole frame. The region keeps the output aspect and renders at output size, so type stays crisp under a push, and a region past the frame composes the outside as background, a fly-in. Under a hold it shows from the hold's first frame.

**Holds.** `#s03 hold(sec(2))` shows the state as its own geometry, and its body rows run inside it, each with its own `at`, length and curve (`#hero breathe(sec(1))`). `#s03 to(#s03) sec(2)` is a window over one state, its camera row arriving at its end like any window's.

**Time.** Every time is `sec(N)`, every other number bare in its slot's unit (px, degrees, a ratio, Hz, dB). `sec(0)` is a hard cut: it takes `at`, `sfx` and `blur`, and a body of `camera`, `sfx`, `trim` and `video` rows. `label(sec(3.2)) #drop` names a time once, for `at(#drop)`.

**Curves.** `ease(in|out|in-out,quad|cubic|expo|back|elastic)`, `ease(linear)`, `ease(bezier(x1,y1,x2,y2))`, `spring(f(Hz),z(ratio))` (z under 1 overshoots, settles in about 1/(f z) s and carries its velocity into the next row). The words: `snappy` `spring(f(2.1),z(0.78))`, `smooth` `spring(f(1.6),z(0.9))`, `bouncy` `spring(f(1.6),z(0.7))`, `decelerate` `ease(bezier(0.05,0.7,0.1,1))`, `accelerate` `ease(bezier(0.3,0,0.8,0.15))`, `standard` `ease(bezier(0.2,0,0,1))`, `emphasized`. A window with none is `snappy`, a camera `smooth`, and an enter or exit with none takes its row's curve word (`#card enter(drop(160),sec(0.3)) smooth`), else `decelerate` for an enter and `accelerate` for an exit.

**What tweens** between paired elements: position, size, rotation (`rot(0)` to `rot(300)` turns 300 degrees), opacity, corner radii, fills (gradients stop by stop), strokes (width, colour, dash phase), effect parameters, image adjustments and filters, a text's size and letter spacing, and vector paths of any node counts, two images cross-fade. Text content and z-order switch at the midpoint, a shader's time runs with the clip, and an element that changes parents still tweens.

**Header and file rows.** `canvases["Projects/Launch","Projects/Outro"]` names the canvases whose top-level frames are the states (required, `motion/core`), `s(1920,1080)` the output size. `blur(n)` renders n sub-frames per exported frame, each moving element swept along its travel across its sub-frame, so a fast glyph, dot or stem reads as one continuous smear at any speed (a turn or a resize still rides the n samples), and on a window, body or hold row sets that run's own. `loop`: the last frame is the first. `treatment(treatment.md)` names the treatment (`motion/craft`). `#clip video(start(sec(2.5)),rate(1),vol(0.8))` on a body row plays the element's video fill (`blueprint/images`, Video fills) from `start` at `rate` from that row's start, its sound at `vol` (`motion/sound`, Clip sound). Without one the clip plays from its fill's own `start` at its `rate` from the film's 0. `program(motion.mjs)` and `fn(pulse)`: `motion/behaviors`.
