---
assumes: motion/grammar
dsl: [music, sfx, duck]
---
# Motion: Sound

The picture renders silent, the sound notes ride the same `.bm` and the runner (`reference/motion`) mixes the track and the sounds into the mp4.

```
music(soundtrack/score.m4a,drop(#drop))                           // the bed, started so its measured drop lands on the label
label(sec(3.4)) #drop
#s01 hold(sec(0.5)) sfx(riser)                                    // a sound at the row's start
#s01 to(#s02) sec(0.6) sfx(whoosh)
  [#send,#send-i] at(sec(0.3)) enter(pop) stagger(sec(0.06)) sfx(pop)   // on a body row: at the target's own start
#s02 to(#s03) sec(1.4)
  #prompt type(26,caret) sfx(type)                                 // one tick per keystroke
#s03 to(#s04) sec(0.4)
  #send sfx(click)                                                 // at that element's start
#s04 hold(sec(0.5)) duck                                           // the bed dips for the hold
#s04 to(#s05) sec(0) at(#drop) sfx(impact)                         // the hit on the cut
```

**The notes.** `music(<file>,start(sec()),drop(#<label>))` once, on its own row: with `drop` and no `start` the track is offset so its measured drop lands on the label. `sfx(<kind>|<file>)` on a window or hold row sounds at its start, on a body row at its target's start (a list or set at its first), and `sfx(type)` beside `type()` once per keystroke. Kinds: `hit`, `impact`, `riser`, `whoosh`, `click`, `tick`, `pop`, `sparkle`, `success`, `sub`, `type`, anything with a dot is a file. `duck(<dB>)` on a hold row dips the bed for the hold (bare -6, 0.15 s ramps, a 4 kHz low-pass), back at its end. Each sound lands by its loudest 5 ms on the event, mixed under the bed at -14 LUFS with a true peak of -1 dBTP.

**Clip sound.** A video fill's own audio is in the mix (the runner's mp4): it sounds while a state holding the element is on screen, at the clip time the picture shows, from the fill's `start` at its `rate` (pitch kept), and a body row `#clip video(start(sec(2.5)),rate(1),vol(0.6))` re-times it from that row's start with its gain (`vol(0)` mutes the clip, 1 is as recorded). It is mixed with the bed and the effects, then the whole mix lands at -14 LUFS, so set a voice clip's `vol` against the bed by ear. A clip with no audio track sounds nothing, said in the run's log.

**The rules.** Music first: the grid is the track's measured BPM, the drop sits on the climax, a breakdown is a `duck` that returns on the kick that ends it. One sound per event: an impact on the frame the picture changes, a whoosh's loudest point on the hit, a riser ending on the cut. The drop's impact and the last hit are the two loudest peaks, every cut's hit at least 3 dB under them. Silence is a beat: the two seconds before the last hit sit 12 dB under the bed. One sound family per piece, nothing on persistent labels. Silent first: the picture carries every fact, and sound is never its only carrier.
