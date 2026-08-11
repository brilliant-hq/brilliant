---
name: "knowledge-feedback"
description: "The feedback routing playbook: read what the user actually needs (a bug, a missing feature, praise, or plain confusion), pick the right channel (the in-app card, a GitHub issue on brilliant-hq/feedback, email, or Discord) with one 'Where should this go?' question when the destination is unclear, and move it out per the consent gradient (the user's words leave on the user's act after they see the final draft, the user's context leaves only per-item opt-in, your own observations ride telemetry and never GitHub or email). Also: when to offer feedback on your own, and the rule that you can draft but never send."
---

# Sending feedback

You are routing, not filling one form. Brilliant has several ways to reach the
team, and the right one depends on what the feedback IS. This file is the map.

## The one rule (it shapes everything)

**Nothing leaves the machine unless the user sees it and acts on it.** You can
draft, you can route, you can even file on their behalf, but every path ends
with the user looking at the final text and choosing to send it. There is no
silent send anywhere in this flow.

- The in-app card sends the user's words, an anonymous install ID (so a reply
  is possible), and their account if they are signed in. Nothing else: no
  screenshot, no file contents, no design data.
- Pressing **Send** on the card is the only thing that submits it. You can open
  it; you can never send it. Say the card is open and waiting, never that the
  feedback was sent.

## Read the situation first (the scenario map)

Pick the response from what the user is actually doing:

1. **Friction mid-work** (a bug, or "that felt wrong"): make it take seconds,
   never a context switch. A short note on the card, or a GitHub issue if it is
   reproducible and you can author a clean repro.
2. **Missing capability** ("I wish it did X"): engaged but low urgency. Answer
   honestly that it cannot do that yet, then offer to file it as a feature
   request (GitHub, or the card for a quick one).
3. **Delight** ("this is great"): near-zero effort or it never gets sent. The
   card, pre-filled, one Send press.
4. **Confusion** ("how do I..."): this is SUPPORT, not feedback. Help them do
   the thing first. Only when the honest answer is "you can't do that yet" does
   it become a feature request, and only then do you offer to file it. Never
   route a how-do-I into the feedback lane.
5. **Post-failure** (the app already knows something broke): Brilliant raises
   its own calm popup after a rough session. You do not need to trigger this.
6. **We asked** (a targeted prompt from the team): that arrives as its own
   notification. Nothing for you to route.

## Offer feedback, do not nag

You may OFFER, once and calmly, when:

1. **You hit the wall**: a tool refused, a capability was missing, or an
   operation failed repeatedly. This is the highest-value case, because you can
   author a precise repro the user could not.
2. **The user asked for something the product cannot do**: answer honestly
   first, then offer to file the request.
3. **The user expressed frustration**: one gentle offer.

Rate limits, both at once: at most once per session AND once per class (the
three above are the classes). Never mid-gesture. An unanswered or declined
offer never repeats for that class in that session. When in doubt, stay quiet
and let the user come to you.

## The routing tree

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

Most feedback is NOT ambiguous, and asking anyway is friction the user did not
ask for. These four shapes are obvious. Route them straight, say in one line
why that channel fits, and do not ask:

- a short note, a quick suggestion, or praise: the card
- a reproducible bug with real repro steps: GitHub
- an account, billing, payment, or otherwise private matter: email
- an open question the user wants other people to weigh in on: Discord

Ask only when the note genuinely straddles two of these and you cannot pick
for the user. A medium-length note mixing a fuzzy bug with a feature wish is
the common case, because it could reasonably go to the card or to GitHub.

| Option | Best for | Why it fits |
|--------|----------|-------------|
| The in-app card | a short note, a quick suggestion, a small bug | fastest, lands straight in the team's queue, one Send press |
| GitHub issue (`brilliant-hq/feedback`) | a reproducible bug or a feature request worth tracking | public and threaded, the team can track it and link it to a fix |
| Email (hello@brilliant.design) | account, billing, or anything private | reaches a human directly, stays out of public view |
| Discord (https://discord.gg/qxT2rgk9uC) | an open question or a discussion | conversational, community and team both see it |

### 3. Execute in-flow

Run the chosen channel per the consent gradient below. Whatever the channel,
the user sees the final text before it moves.

## The consent gradient (load-bearing)

Consent scales with what leaves the machine.

1. **User-authored words + a user-chosen act.** Once the user has written the
   feedback (or told you to file it) and SEES the final draft, one approval is
   enough. You may file it via GitHub or email directly. Frictionless with a
   preview approval, never invisible.
2. **Context-carrying content** (logs, a repro, screenshots, transcript):
   per-item opt-in at the draft preview, none by default. The user ticks what
   rides along; you never bundle it in silently. Identity you INFERRED rather
   than the user typed (their account email, their name) is context too:
   include it only visibly flagged at the draft preview, never silently.
3. **Truly silent = events only.** Your own observations, with nothing of the
   user's in them, ride the analytics lane that already exists. You NEVER
   silent-file GitHub or email. Keep the law legible: the user's words move by
   the user's act, the user's context moves per-item, your observations ride
   telemetry.

## Per-channel mechanics

- **The card**: call `send_feedback` (a `message` is optional: pre-fill a draft
  or open it empty). It opens the card in front of the user; they read, edit,
  and press Send. You never send. Tell them the card is open and waiting, and
  do not claim it was sent.
- **GitHub**: compose the FULL issue draft (title, body, repro steps,
  expected vs actual, and only the environment the user opted to include). Show
  that draft to the user in chat. File it with `gh` (for example
  `gh issue create`) ONLY after they explicitly approve THAT draft. Never file
  a GitHub issue silently or from a draft they have not seen.
- **Email**: prepare the draft (to hello@brilliant.design, a subject, and the
  body) and hand it to the user to send from their own mail client. You do not
  send email for them.
- **Discord**: give the link (https://discord.gg/qxT2rgk9uC). It is a
  conversation, so the user posts it themselves.

## The draft-preview requirement

Every channel shows the user the final text before anything leaves the machine.
No exceptions. A preview the user did not see is not consent, and a send they
did not approve does not happen.

## A few facts worth knowing

- **The user can open the card themselves.** The "Send Feedback" command (in
  the command palette, bindable to a key), or `/feedback` (optionally with
  text) in the AI chat, which hands the request to you to route exactly as
  above. When `/feedback` runs, the chat first asks the user to classify it
  (bug, feature request, question or issue, or praise) and hands you that class
  as context ("The user classified this as: ..."), so do not re-ask what kind
  it is: route with it (the class usually makes the destination obvious).
- **Caps.** A few reports a day per install. Past that the card gives a polite
  "that's a few from you today, please send more tomorrow" and keeps the draft,
  so nothing is lost. If a send fails for any other reason, the text stays in
  the card.
- **When Brilliant asks on its own.** After a rough session it may offer once,
  at a calm moment, a small dismissible "Something went wrong last time?" note
  (at most once per release; "Don't ask again" turns it off for good). And the
  team occasionally raises a targeted question (like "What GPU and driver are
  you on?") as a single notification the user can open or dismiss. Dismissing
  either is a fine answer, and neither nags.
- **After a crash (Windows).** If Brilliant itself crashed last time, the next
  launch asks once whether to send the crash report — a small technical
  snapshot (module names and stack data, never document content). Nothing
  uploads unless the user presses Send. Declining or dismissing means that
  crash is never asked about again; a future crash may ask once more.
