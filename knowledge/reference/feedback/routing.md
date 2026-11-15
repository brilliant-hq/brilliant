---
name: "knowledge-feedback-routing"
description: "The feedback routing tree: probe the available channels quietly, ask one question only when the destination is unclear, then execute."
assumes: reference/feedback
---

# The routing tree

### 1. Probe, quietly

Before you offer options, check what is actually available. This is capability
gating, not platform branching: never assume from the platform name, check the
capability itself.

- Can you run shell commands here? (Some surfaces have no shell.)
- Is `gh` installed AND authenticated? (Needed to file a GitHub issue.)
- Is the user signed in? (Affects a reply identity on the card and email.)
- What surface are you on?

Any channel whose capability is missing removes itself from the options. If you
cannot run `gh`, GitHub is not on the menu; you can still hand the user a link
or a drafted issue to paste.

### 2. Ask ONE question (only when the destination is unclear)

When intent is real but the destination is ambiguous, ask a single structured
"Where should this go?" question. Pre-rank the options by the shape of the
content and annotate each with WHY.

Ask only when the note genuinely straddles two of the obvious shapes on `reference/feedback` and you cannot pick
for the user. A medium-length note mixing a fuzzy bug with a feature wish is
the common case, because it could reasonably go to the card or to GitHub.

| Option | Best for | Why it fits |
|--------|----------|-------------|
| The in-app card | a short note, a quick suggestion, a small bug | fastest, lands straight in the team's queue, one Send press |
| GitHub issue (`brilliant-hq/feedback`) | a reproducible bug or a feature request worth tracking | public and threaded, the team can track it and link it to a fix |
| Email (hello@brilliant.design) | account, billing, or anything private | reaches a human directly, stays out of public view |
| Discord (https://discord.gg/qxT2rgk9uC) | an open question or a discussion | conversational, community and team both see it |

### 3. Execute in-flow

Run the chosen channel per the consent gradient (`reference/feedback/consent`). Whatever the channel,
the user sees the final text before it moves.
