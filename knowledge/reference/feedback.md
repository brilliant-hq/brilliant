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

## Route the obvious shapes straight

Most feedback is NOT ambiguous, and asking anyway is friction the user did not
ask for. These four shapes are obvious. Route them straight, say in one line
why that channel fits, and do not ask:

- a short note, a quick suggestion, or praise: the card
- a reproducible bug with real repro steps: GitHub
- an account, billing, payment, or otherwise private matter: email
- an open question the user wants other people to weigh in on: Discord

## The playbook

- `reference/feedback/situation`: the scenario map: read what the user is actually doing first
- `reference/feedback/offering`: when you may offer feedback on your own, at most once per session and once per class
- `reference/feedback/routing`: the routing tree: probe quietly, the one "Where should this go?" question, the channel table
- `reference/feedback/consent`: the consent gradient, the per-channel mechanics, and the draft-preview requirement
- `reference/feedback/facts`: the user's own door to the card, caps, when Brilliant asks on its own, crash reports
