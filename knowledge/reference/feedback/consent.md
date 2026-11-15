---
name: "knowledge-feedback-consent"
description: "The feedback consent gradient, the per-channel mechanics (card, GitHub, email, Discord), and the draft-preview requirement."
assumes: reference/feedback
---

# The consent gradient (load-bearing)

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
