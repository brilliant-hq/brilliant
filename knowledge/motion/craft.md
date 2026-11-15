---
assumes: motion/core
dsl: [treatment]
---
# Motion: Craft

The method, once per film, before the first create. The bar is the piece people see and say holy shit, I thought Apple made this, judged on rhythm, quality and polish, never on technique coverage. The numbers per genre are `motion/genres`.

## The process

Each stage locks one layer (School of Motion, Sarofsky, Animade): 1. A temp track and a beat sheet first, each cut, title and land on a bar.beat (Kurzgesagt). 2. A grey animatic at final timing, every hold at its final length. 3. A cold-viewer read: a fresh agent with no intent gets the frames at 8 fps with timestamps plus a phone-size copy and says what it took at 3 s, 10 s and the end, where it got lost or bored (Pixar's Braintrust). 4. The human signs the animatic before polish. 5. The look, polish and sound last.

## The design read

One line before the first create, in your reply and at the top of the treatment: `Reading this as: a <showreel | launch film | launch clip | material film | UI reel | feature tour | data story> for <audience>, at <BPM>, in <palette>, leaning on <glass | shaders | type>, after <reference>.` The reference is a clip named in `motion/genres` or in the prompt, never a description: a film with no reference comes out as the default look (centered text on a gradient, everything fading in). The read is the one clarifying question, asked of the prompt, not of the user.

## The treatment

The first artifact: energy and beat come from a treatment, "as if a billion dollar studio decided the message, the sections by time, and per section what is psychologically most incredible for the viewer given what counts as incredible motion graphics, rhythms and effects for that style." One page, `treatment.md` beside the `.bm`, named by `treatment(treatment.md)`, written first, then the grey styleframes and the `bm` fence:
1. The title line: duration, size, fps, BPM, the drop time.
2. The message in one sentence: what the viewer feels and remembers.
3. Inputs: the product and the one action a user takes in it, the assets, the track (BPM, drop and hits measured), the product's own mark (from the canvas or the user, never invented), two fonts named and set on every text.
4. The look: five named hexes (the field, the ink, one accent, two for the light and a highlight), one background family, one material, the hero and its share of the frame, its material checked on a full-resolution frame at its largest. A shader names its `speed` (`blueprint/shaders/overview`), metal and steel still.
5. Sections by time, each with a numeral and a name, the range, the feeling (its psychological job), the technique (`motion/genres`), the rhythm (events, density, cuts, holds), one motive per event (hierarchy, story, feedback or a state change, never "it looked cool"), the claim and its visible effect, and the shared element carried out.
6. The energy budget: seconds high against slow, the counts of cuts, morphs and camera moves, the slow moments and their lengths.
7. The sound plan: the track window, the accents with times, one sound per event, an exit(sec(0)) silent, the duck points (`motion/sound`).
8. The checks: the six of The checks below, ticked by hand.

A styleframe's name starts with its storyboard number and its state row takes that number as its handle, `state(05 Claim A) #s05` (`#s1` to `#s9` in a film under ten states), so a state handle never meets an element's.

## Timing

Every move in three parts: anticipation 4 to 8 frames, action 8 to 20, the settle inside the following hold, no move over 0.5 s except the camera and the light, and never a glide at one speed over 0.4 s. Overlap, never simultaneity: the next start at 70 percent settled, a group staggered 2 to 4 frames, and a pair shares one name in both states. Contrast: 0.6 to 1.2 s of stillness after a fast action, fast then slow, never medium, the end card held 1.5 to 3 s. Type: on screen max(0.8 s, 0.3 s + 0.3 s per word) after the text stops moving, a typed line from its last keystroke (Netflix, BBC), the tool flags under 3.5 words per second, an entrance 0.25 to 0.5 s and an exit 0.6 of it, an entrance decelerates and an exit accelerates, a glyph stagger 12 to 18 ms and a word 60 to 120 ms, a headline never under 48 px at 1080p and at least 1.6 times its subtitle, the hero 40 to 60 percent of the frame, persistent labels enter once. Springs: z 0.7 to 0.8 one overshoot, 0.82 to 0.9 none, never under 0.6. Duration by scale: a glyph 100 to 200 ms, an element 300 to 500, a scene morph 500 to 800, a camera 800 to 1500. The edit: cuts on the computed grid (frames per beat = fps times 60 over BPM), the first cut on a downbeat, one cut per beat at most, calm passages cut on the bar. The shutter: blur 3 to 4 sub-frames, 8 for a 600 px move in nine frames, each sub-frame carrying 7.5 px of travel a frame (30 at 4). A loop ends on its first frame, cursor included.

## The energy rule

"A motion piece runs high beat overall, with a few super slow parts where the liquid glass can be appreciated as the contrast, never slow throughout." One drop, on the climax, 40 to 80 percent in (an earlier drop is a choice the treatment names). At most two slow moments, each a still that moves like one breath: the camera pushes or the light dims through the hold while the set piece drifts, from the hold's first frame. Three defects: dead time, a phrase without an accent event, an event without a motive: a hold follows a payoff, dead time is a hold with no payoff (Lieu, Grandin). A launch film takes the trailer shape: a hook in 2 s, escalate (each beat bigger, faster or stranger), the drop, a button, one surprise before the mark (Woollen, Lieu, TikTok). Its unit is cause and effect: a claim, its visible effect within 0.5 s at viewing size, never after its caption.

## The checks

1. A bounce: a spring under z 0.6, an elastic ease, more than one overshoot.
2. A 3D flip on a 2D film.
3. A reversal: a camera that reverses inside a scene, or zooms in and out back to back (the pull to the whole frame for the end card excepted).
4. A reflow: text that reflows as its width, wrapping or tracking animates (a whole word popping from 0.85 is a scale, a matched label's size tween is allowed).
5. More than two scene-transition styles in one film, or a scene transition over 40 frames.
6. Anything that looks like a template: a stock lower third, a generic wipe, a lens flare on nothing.

**The glass law.** "Clear and fully rounded, always: no frost, no tint, capsule or circle or a rounded rect with full radii, in anything we make or show." Frost, tint, `glow` and `edge` stay at 0, chroma is the one parameter a piece moves, full radii is half the short side, and a pane carries a light or content behind it (a light about 1.7 times the hero, leading each pose by 0.25 to 0.35 s), its rim resting over one display word at most.

The tool says these at the mistake, once per session, with the element, the film line and the fix: cut off the grid, two cuts inside one beat, a move over its band, a glide, two starts on one frame, an entrance over its band, an exit over its band, a unit stagger under its band, words faster than reading, a camera run over its band, an end card off its band, a sound on a silent exit, an entrance on a paired element, a drop outside its band, a camera that reverses, a move faster than its blur, a text that reflows, a short rest after a fast action, a near pair that dissolves, many elements on one clock, an ease against its direction.
