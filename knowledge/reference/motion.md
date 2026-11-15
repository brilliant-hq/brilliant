---
name: "knowledge-motion"
description: "Motion in Brilliant: films made of styleframes and a Motion/<film>.bm, rendered to mp4 with sound, edited by hand, and Remotion compositions brought in."
---

# Motion

Brilliant makes motion graphics from designs: the states of a film are ordinary frames on one or more canvases, and a film, `Motion/<film>.bm` in the folder beside `Styles/`, says how time moves between them, on `bm:v1`, its `canvases[...]` line naming the canvases its states live on. Films are written and checked through `edit` in the desktop app and the web editor alike, with the same diagnostics. They render to mp4 or mov in the desktop app (or by the runner), and on the web a film plays through a motion fill. Writing one is `motion/core`.

- **Rendering.** `export` with `motion: "<film>"` renders a film to mp4 through the canvas engine, the same frames the canvas draws: liquid glass, live shaders, design tokens and vector type included, with motion blur, a contact sheet and per-frame timing in the answer.
- **The runner.** Brilliant ships a motion runner with the app (the `init` answer names its path as `motionRunner`, a path under your home written with `~` for a shell to expand, and it needs node and ffmpeg). It renders a film or a program to mp4, mixes the music bed and the sound effects the `.bm` names, checks the film against the craft rules before a master render, reads its rhythm after, and fits the file to a byte budget. `--help` lists its flags, `--preview <sec>` renders the 2 s from that time at 640 px and low quality, and `--frames a..b` any window of frames.
- **Editing.** A film (`.bm`) opens in the built-in code editor with syntax highlighting, and every state stays a design you edit by hand: the next render plays the edit. An agent reads a film with `read` and replaces it whole with a `bm` fence through `edit`.
- **Remotion.** A composition written for Remotion (React, `useCurrentFrame`, `interpolate`, `spring`, `Sequence`) becomes a Brilliant film without a browser, its poses editable styleframes on a canvas, an edit on the canvas reading back as an override beside the code, and `@brilliant/remotion` giving it liquid glass, live shaders, engine type and the design tokens: `motion/remotion`.
