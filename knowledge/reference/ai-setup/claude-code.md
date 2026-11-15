---
name: "knowledge-ai-setup-claude-code"
description: "The Claude Code row in Settings > Models > Your own AI: detection, sign-in, plan eligibility, a failed status check, and the minimum CLI version."
assumes: reference/ai-setup
---

# Claude Code (Your own AI)

On the Your own AI list (Settings > Models > Your own AI):

- **Claude Code** leads the list and has no key field: install the `claude` CLI
  and Brilliant detects it automatically (on launch, when the Your own AI pane
  opens, and on a manual re-check) with no app restart needed
  after installing. If the CLI is not signed in, run `claude auth login` in a
  terminal. If the row reads "Installed · login unverified, chat still works",
  only the sign-in check was inconclusive: the CLI is detected and chat runs
  normally. The circular-arrow button re-checks. Claude Code needs a paid Claude
  plan (Pro, Max, Team, or Enterprise); if the CLI is signed in on a plan that
  cannot run it, the row reads "Signed in · plan not eligible" (or "Signed in ·
  plan unverified" when no plan could be read) rather than "Not connected",
  since detection and sign-in both worked and only the plan disqualifies it.
  If Claude Code is your only provider and its status check outright fails (for
  example behind a corporate proxy or a custom certificate authority, where a
  `claude` that works in your terminal can still fail when the app launches it),
  the chat panel says so instead of sitting empty: it names the likely cause
  (network or proxy, certificate, permission, sign-in, or an out-of-date
  version) and shows a **Retry** button that re-checks. Brilliant runs that
  check under your login shell's environment (the same PATH, proxy, and CA
  settings your terminal uses), and re-checks once on its own the first time you
  click into the chat box, so a fix you make in your terminal is picked up
  without restarting the app. Brilliant needs Claude Code 2.1.41 or newer: with
  an older CLI the row and the chat panel name the installed version and the
  minimum, and `claude update` (then the re-check) fixes it. If a chat turn's
  CLI exits with an error, the chat shows that error (its own words are in the
  card's details) instead of ending the turn without a reply.
