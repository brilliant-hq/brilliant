---
name: "knowledge-feedback-situation"
description: "The feedback scenario map: friction, a missing capability, delight, confusion, post-failure, and a question the team asked."
assumes: reference/feedback
---

# Read the situation first (the scenario map)

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
   notification. Nothing for you to route. It reaches the web editor the same
   way it reaches the desktop app.
