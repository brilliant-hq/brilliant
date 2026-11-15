---
assumes: motion/craft
---
# Motion: Genres

The dials the design read picks, the clips it names, and the beats a film is made of, in the order 32 studied clips use them.
## Dials by genre
| Genre (references) | Tempo | Cuts | Density | Hold cap | Camera |
|---|---|---|---|---|---|
| Showreel (hugo, ajith, stephanlivera) | 120 BPM | a hard cut per bar, a scene per 1.1 s accelerating to the end, a new full-contrast world each | two events a second, the read time | 1 s, the end card excepted | none: the cut is the move |
| Launch clip, social (twoclipping develop., the food film, tessel) | 120 to 130 | none: one continuous take, every scene made of the previous | one move per bar plus pops on the beats, 1.5 to 2.5 events a second in the high phrases | the read time, 1 s the cap | one eased push per scene, never reversing, the drop 40 to 80 percent in |
| Launch film, studio (Linear, Config 2024, Arc Act II) | the temp track's | understand, then accelerate: 4 s a shot to read a mechanic, under 1 s on the run (Lieu) | one action at a time in the real product | after a payoff only | through the product, readable |
| Material film (the Apple keynote reel, wabi) | 120, high beat overall | morphs, not cuts | high, with two slow moments of 1.2 to 1.8 s where the glass is appreciated and the music dips | the two slow moments only | one slow push throughout plus one 0.4 s move on the climax |
| UI reel (twoclipping one shape, morse) | 120 | none: one shape through 8 to 12 states | something on every beat | none | zooming so each state fills the frame, the last frame the first (`loop`) |
| Feature tour (Pocketsflow, opencode) | 30 to 60 s long | cut or continuous | a hook line, then five to ten sentence-plus-UI beats | the read time | the default look unless one is named |
| Data story (tessel, hugo) | 120 BPM | a card per comparison, cut on the bar | the number typed as digits at display size on the drop, counters in mono | 1 s, the end card excepted | the camera along one chart one way, fitting it as it fills, the counter on the last hit |
## The references
- hugo: a full-contrast colour card per cut, the material beats.
- ajith: HUD chrome tying thirteen scenes, Swiss red and cream.
- stephanlivera: flat colour cards cut hard, one real idea per scene.
- twoclipping develop.: one take, a cursor throughout, cream and black, each scene made of the last.
- The food film: the typed request, the send, a lime flood on the drop, photos on dark cards, a sound per event.
- tessel: ink, paper and one red, bold type lines as the spine, one red dot through every act, a calendar tilted in 3D.
- The Apple keynote reel: black, one object, one slow push, the material as the subject.
- wabi: the dispersion arrival, smeared prismatic in travel, settling crisp.
- twoclipping one shape: one element through twelve UI states, a cursor driving each, the camera on each.
- morse: a colour flood from the cursor per section.
- Pocketsflow: a house sentence, bold sans and one italic serif accent word, ten features.
- opencode: monospace only, one accent word per caption, restraint.
- The studio tier, for a launch film (no shot log is published, log one before quoting numbers): Linear, the camera through the real product one action at a time, no voiceover, no abstract 3D (a third party's account). Config 2024 open: one motif, activation, varied over a minute. Arc Act II: a founder's first person, scripted like a short film. Trailers: a recurring sound as the spine, reveals held back (Woollen). Title sequences: one motif escalated on the music (Elastic). Here, where the viewer must understand a product, the showreel grammar does not apply: no cut per bar, no new world per cut, no filler pops, no 1 s hold cap.
## The beats
- The end card (32 of 32): mark, wordmark, tagline held 1.5 to 3 s from the last landing, `#mark enter(pop) stagger(sec(0.04))` then `#tagline at(sec(0.1)) enter(rise(20))`, the hero beside the wordmark, never over it.
- Spring pops (32): `#x enter(pop)`, a field of them one set line, `all(name(tile)) enter(pop) stagger(sec(0.03),from(center),grid(3,4))`.
- Kinetic type (27): a word per cut, the mask-line rise `#line enter(mask(line),by(word))`, a word per beat `#name enter(pop,by(word)) stagger(sec(0.5))` at 120 BPM.
- The camera push per scene (22): `camera(fit(#hero),pad(120)) smooth`, 0.8 to 1.5 s, a display line exiting on the beat the window leaves it.
- The cursor that acts (16): `#send click` on the target's row, the change it causes starting within four frames of the dip.
- Counters and odometers (16): `#total count`, `#total count(sec(0.8),odometer)` for the roll.
- The phone or browser mockup (15): a real UI with real content.
- The typewriter (13): `#prompt type(26,caret) sfx(type)`, in the product's own bar.
- Particles (12): a field that fills a hold `#bits particles(200,sec(2.5),60,from(#area))`, the ring `#orb orbit(#hero,320,sec(2))`, the comet `#comet along(#route) trail(sec(0.4))`, the pile `all(name(glyph)) fall(gravity(1400),bounce(0.4))`.
- Self-drawing charts (11): bar heights tween between styleframes, a ring fills by `#ring trim(0,1)`.
- The one 3D beat (11): `#ui tilt(20,0)`, the whole UI in perspective with its text crisp.
- The shared-element handoff (10): the same name in both states, the button that becomes the page, `#hero s[bouncy] rd[smooth]`, a text child riding at `o[cut]`.
- The trim draw (9): `#ribbon trim(0,1)` or `#mark enter(draw)`.
- Motion blur on fast moves (9): a `blur` on the fastest move's own row.
- The flood or iris on the drop (8): `#send burst(24,1100)`, or a mask whose child grows from the button.
- The material beats (7): glass, shaders with time, halftone and duotone.
- The word wall (6), stamps (5) from 1.6 times their size `#stamp s[snappy] o[cut]`, glitch (5) `#word scramble`, halftone and duotone (4) tweened by parameter.
- Radial rays (4) `all(name(ray)) enter(fade,sec(0.3)) stagger(sec(0.1),from(random))`, and the match cut (4): a short window whose pivot carries one name in both states, `exit(sec(0))` for the rest.
