---
dsl: [canvases, state, label, to, hold, sec]
---
# Motion Core

A motion piece is styleframes on the canvas (Blueprint, `blueprint/core`) plus a film. A **state** is a top-level frame. A film is `Motion/<film>.bm` in the canvas's folder, beside `Styles/` (`Motion/Launch.bm`): it names the canvases its states live on and the states in storyboard order, and says how time moves between them, never restating geometry, color or content. Many films per canvas, many canvases per film. The engine evaluates it, so scrubbing, playback and the mp4 are the same frames. The web editor writes and checks films through `edit` exactly as the desktop app does (the same engine parse, the same diagnostics, the film saved into the project and synced), and the mp4 or mov export stays in the desktop app (or the runner), and on the web a film plays through a motion fill. A film also fills an element, playing on loop on the canvas in the desktop app and the web editor alike: `f[(motion(Motion/Launch.bm))]` (`blueprint/images`, Motion fills).

```bm
file("Motion/Launch.bm")
// treatment.md beside this file.
fps(30) s(1920,1080) bpm(120) blur(3)
canvases["Brilliant LOVES MCP"]
treatment(treatment.md)
state(01 Orb) #s01
state(02 Prompt Bar) #s02
state(03 Prompt Typed) #s03
state(04 Send) #s04
state(05 Claim A) #s05
state(06 Claim B) #s06
state(30 End) #s30
label(sec(5.7)) #drop

// I HOOK 0 to 3.4: the glass orb becomes the prompt capsule, the sentence types, send
#s01 hold(sec(0.5))
  camera(p(135.8,63.8),s(1653.6,930.1))
#s01 to(#s02) sec(0.6) snappy
  camera(p(176.7,83),s(1573.3,884.9)) ease(bezier(0,0,1,1))
  [#send,#send-i] at(sec(0.3)) enter(pop) stagger(sec(0.06))         // a list, in order
#s02 to(#s03) sec(1.4)
  #prompt type(26,caret)
#s03 to(#s04) sec(0.4) spring(f(2.4),z(0.6)) blur(8)                 // the button punches in, the prompt zips away
  [#send,#send-i] s[spring(f(3.2),z(0.45))] p[spring(f(3.2),z(0.45))]   // per-property clocks
  #prompt at(sec(0.06)) sec(0.3) p[ease(in,cubic)] o[ease(in,quad)]
// II CLAIM 3.4 to 6.2: the promise, grey words darkening, the gradient line rising by word
#s04 to(#s05) sec(0)                                                 // a hard cut
  camera(p(0,0),s(1920,1080))
#s05 to(#s06) sec(2.8)
  all(name(cl)) at(sec(0.05)) sec(1.45) stagger(sec(0.2)) o[decelerate,sec(0.12)] f[ease(out,cubic),sec(0.45)]   // a set by name prefix
  #cline at(sec(0.7)) sec(0.8) enter(rise(28),ease(out,cubic),by(word)) stagger(sec(0.12))
#s06 to(#s30) sec(2.1) at(#drop) ease(out,cubic) blur(8)
  all(name(mark)) at(sec(0.8)) sec(0.7) enter(pop) stagger(sec(0.045))
#s30 hold(sec(1.4))
```

**Rows.** The header (`fps`, `s`, `bpm`, `blur`, `loop`, then `canvases[...]`, `treatment`, `program`, `music`, each at most once), one `state(Name) #handle` row per state in storyboard order (a top-level frame of those canvases by name, quoted only when it holds a comma, parens or quotes, `state(30 End,canvas(Projects/Outro)) #s30` for a name two canvases share, `state(<frame id>) #s30` for a name two frames of one canvas share), `label(sec(t)) #name` rows naming a time, and the timeline, read top to bottom, each row starting when the previous ends: a hold `#s01 hold(sec(0.5))`, or a window `#s01 to(#s02) sec(0.6) snappy` from one state to the next, with the rows indented under it as its body. Times, body forms, curves and per-property clocks: `motion/grammar`.

**Elements.** A body row addresses an element as a `bl` fence does: a `#ref` your fences or a `read` bound, or its id. Per window, elements pair across the two states by name at any depth: a pair tweens, one present in only one state dissolves in or out over the window, an unmatched child of a matched parent rides its parent, and `pair(#other)` on a row pairs two names. To bring an element in without a dissolve, give it a home in the earlier state too, parked off-frame or at `o(0)`. The stored file and `read` write an element as its id with its name as a label, `a3f9c0d2e18b7c44 "Send" at(sec(0.3)) enter(pop)`. Behaviors (typing, counting, scrambling, drawing): `motion/behaviors`, sound: `motion/sound`.

**Writing it.** A `bm` fence whose first row is `file("Motion/<film>.bm")`, sent through `edit` (an `<edit>` block in your reply), after the `bl` fences of the styleframes it names, its `canvases[...]` row naming them by path (the `.bl` optional). The fence is the whole film without the `bm:v1` line the stored file opens with: it replaces the file, so re-send the `//` comments you keep. `read` with the film's path answers it as that fence. `export` with `format: "mp4"` and `motion: "<film>"` renders it, the contact sheet and the rhythm tables: `motion/review`. A composition written for Remotion comes in through `motion/remotion`. Before a film, `motion/craft` first: the design read and the treatment, then the styleframes, then the film. Opened from the explorer, a film shows in the code editor with motion highlighting: `reference/canvases`.
