---
assumes: motion/grammar
dsl: [type, count, scramble, draw, trim, orbit, follow, trail, particles, burst, fall, breathe, pulse, drift, spin, wiggle, flicker, tilt, scale, click, drag, along, pivot, anticipate, program, fn]
---
# Motion: Behaviors

A behavior is what an element does over its window or hold, evaluated from the film's time, written on that element's body row. It composes with the pose tween and carries its phase across adjacent rows, and on a set row each member runs it on its own seed. `orbit`, `follow`, `fall` and `along` own the position, one per element per window, and the next row starts from where they leave it. Every omitted number is a default.

```
#s02 to(#s03) sec(1.4)
  #prompt type(26,caret)                                           // the sentence types itself behind a caret
#s03 hold(sec(2))
  #send-i orbit(#hero,260,sec(1),tilt(60))                         // the arrow circles the capsule on a tilted ring
  #send follow(#send-i,lag(sec(0.15)),spring) trail(sec(0.3))      // the button chases the arrow, a tail behind it
#s03 to(#s04) sec(0.4)
  #send anticipate burst(24,1100,shape(#send-i),orient)            // a pull back before the press, arrows fly out pointing their way
  #hero particles(40,sec(1.2),300,spread(60),from(#hero))           // sparks born across the capsule
#s04 to(#s07) sec(0)
#s07 hold(sec(0.5))
  #win tilt(12,-12,2600) scale(0.8)                                 // the app window lies back in perspective, smaller
#s07 to(#s08) sec(0.4)
  #row-3 click(#agent)                                              // the agent's cursor taps the row it builds
  #win pivot(c) tilt(11.4,-11.4,2600) scale(0.812)                  // and keeps turning toward the viewer
  #shine-a trim(0,1)                                                // the outline draws itself around
#s08 to(#s23) sec(0)
#s23 hold(sec(0.3))
  #agent-name drift(8,sec(2))                                       // the name floats
#s23 to(#s24) sec(1.1)
  #agent-name scramble(sec(0.5),alphabet(emoji))                    // the name shuffles through emoji into the next
#s24 to(#s30) sec(2)
  all(name(mark)) enter(draw)                                       // the mark's pieces draw in
  #wordmark fall(bounce(0.4),throw(0,-500))                         // the wordmark is tossed up and lands
```

- `type(<cps>,caret)`: the text types from the earlier content, a shared prefix kept, the old tail deleted at twice the rate (26 cps).
- `count(sec(),<curve>,odometer)`: every number in the text counts from its earlier value (0.8 s, `ease(out,expo)`), `odometer` rolling the digits.
- `scramble(sec(),alphabet("..."))`: glyphs shuffle before landing (0.6 s, letters for letters and digits for digits), `alphabet(emoji)` a built-in 24.
- `draw` and `trim(a,b)`: `enter(draw)` draws a stroke in, `trim(0,1)` animates the visible range from the one the previous row left (`trim(0,0)` under a cut parks it empty), on one-path vectors and rectangle and circle outlines.
- `orbit(#center|p(x,y),<r>,sec(<period>),cw|ccw,phase(<deg>),tilt(<deg>))`: once around per period from the element's own angle, `1120->300` spiralling in over the window.
- `follow(#target,lag(sec()),spring)`: the target's position `lag` ago (0.08 s), `spring` softening it. `trail(sec(<len>),fade|solid,width(<px>),o(<a>))`: a ribbon in the element's color along its last `len` seconds, under it, its width and alpha running smoothly from full at the element to 0 at the tail end over its LENGTH (an eased move's tail fades as evenly as a steady one's, and `solid` keeps one alpha and still tapers). An image or shader fill has no one color, so its ribbon keeps that fill and fades in short steps.
- `particles(<n>,sec(<life>),<speed>,spread(<deg>),gravity(<px/s2>),size(<a>-><b>),seed(<k>),from(#area))`: copies of the element born over the window, flying, falling and fading, `from` spreads their births over a box.
- `burst(<n>,<r>,sec(),shape(#ref),orient)`: copies fly out to `r` px and fade, `orient` turning each outward.
- `fall(gravity(<px/s2>),bounce(<e>),floor(#ref|<y>),spin(<deg/s>),throw(<vx>,<vy>),by(glyph))`: drops to a floor and settles inside the window, a text glyph by glyph.
- Idle life: `breathe(sec(<period>))` (1.5 percent), `pulse(sec(<period>))` (4 percent), `drift(<px>,sec(<period>))`, `spin(<deg>,sec(<period>))`, `wiggle(<deg>,<Hz>)`, `flicker(<Hz>,depth(<0..1>))`.
- `tilt(<rx>,<ry>,<depth px>)`: the perspective the element reaches at the row's end, its text crisp, `tilt(0,0)` clears it. `scale(<k>)`: the whole subtree scales as one picture about its center, text, radii and strokes with it, a frame's size tween moves its children and never scales them.
- `click(#cursor)` and `drag(#cursor)` on the target's or the handle's row: the cursor (the element named `cursor` when none is given) moves onto the target on `snappy` and dips as it presses, or rides the handle.
- `along(#path,orient)`: rides a single-chain vector from pose to pose instead of the position tween. `pivot(c|tl|tr|bl|br|p(x,y))`: the point rotation and scale turn about.
- `anticipate(sec())`: a 3 percent counter-move before the element's move (0.06 to 0.14 s, bare 0.1).

**What needs code.** A custom field (a point cloud, glyphs placed by a rule of your own), physics between elements and a renderer the engine lacks. `program(motion.mjs)` in the `.bm` names an ES module beside it: `export function frame(t, ctx)` runs on every frame and returns that frame's whole patch, blueprint lines (a modify line overrides the tween for that frame, a create line is that frame's element, `delete(#ref)` hides one), a pure function of `t` with nothing carried between frames. A modify line on a state frame (`#<frame name>`) repaints the film's backdrop for that frame: its fill, strokes, corners, effects and `o()` apply, its place and size stay the film's. `fn(pulse)` on a window row calls `export function pulse(t, from, to, ctx)` inside that window with `t` from its start, on an element's row (`#cta fn(pulse)`) for that element. A unit line reaches a text's glyphs, words or lines (`#title glyph([1,2,3]) o[0,0.4,1] p+[(0,18),(0,9),(0,0)]`, one value per unit, `o(0.4)` one for all), `ctx` carries `fps`, `size`, `bpm`, `states`, `elements`, `id(name)` and the beat grid, and `ctx.lib` the springs, eases and noise.
