---
name: "knowledge-feedback-facts"
description: "Feedback facts: the user's own door to the card, caps, when Brilliant asks on its own, and crash reports on Windows."
assumes: reference/feedback
---

# A few facts worth knowing

- **The user can open the card themselves.** The "Send Feedback" command (in
  the palette, bindable to a key), or `/feedback` (optionally with
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
  launch asks once whether to send the crash report: a small technical
  snapshot (module names and stack data, never document content). Nothing
  uploads unless the user presses Send. Declining or dismissing means that
  crash is never asked about again; a future crash may ask once more.
