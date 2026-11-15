---
name: "knowledge-ui-feedback"
description: "The feedback card on the notification rail, the doors that open it, and how /feedback routes."
assumes: reference/ui
---

# Feedback

Feedback rides a **CTA notification** on the right-side notification rail (not a
floating window): a title, a subtitle, one free-text field, a primary **Send**
(Cmd+Enter / Ctrl+Enter) and a secondary **Cancel**. The card reads left-aligned
like a message, and the field is a real message box: it starts six rows tall,
grows with what you type up to twenty-four rows, capped by the window height, and you can drag the grip at its
bottom-right corner to resize it (the height is remembered between opens). Enter
and Shift+Enter add a newline, and Cmd+Enter / Ctrl+Enter sends. Because it
carries a field and actions, the rail HOLDS the card until you act. There are no attachment
checkboxes; v1 attaches nothing about your world.

It opens from four doors: the **Send Feedback** command (palette), an
agent calling the `send_feedback` tool, the one post-error popup, or a remote
targeted prompt the team pushes to you. The remote prompt is **ambient**: it
does not grab the keyboard or steal focus, it just waits on the rail with its
own heading until you answer or dismiss it.

`/feedback` in the AI chat input does NOT open the card. It first asks you to
classify the feedback (bug, feature request, question or issue, or praise) on a
quick card, then submits a routing turn to the agent that carries your class as
context. The agent loads the playbook and picks the best destination (the card,
a GitHub issue, email, or Discord) per the consent gradient.

Nothing is attached or sent until you press Send: the press is the consent. An
agent can pre-fill the text; it cannot press Send.

Full detail: `reference/feedback`.
