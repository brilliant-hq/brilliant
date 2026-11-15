---
name: "knowledge-ai-setup-codex-cursor"
description: "The Codex, Cursor and Muse Code rows in Settings > Models > Your own AI: install, sign-in, detection paths, and failure causes."
assumes: reference/ai-setup
---

# Codex, Cursor and Muse Code (Your own AI)

On the Your own AI list (Settings > Models > Your own AI):

- **Codex** follows Claude Code and likewise has no key field: it signs in with
  a ChatGPT subscription, not an API key. Install with `npm install -g
  @openai/codex`, run `codex login` once, and Brilliant detects it on launch. Its
  GPT-5.6-family and GPT-5.5 models then appear in the model selector. Detection
  searches the usual install locations (Homebrew, npm, pnpm, Volta, Bun, and the
  nvm/fnm/asdf/mise node-version dirs). If your codex lives somewhere unusual, or
  a slow shell startup outruns detection, set the `BRILLIANT_CODEX_PATH`
  environment variable to the codex binary and Brilliant will use it directly.
- **Cursor** also has no key field: it signs in with your Cursor account, not an
  API key. The `cursor-agent` CLI is a **separate install from the Cursor desktop
  app** (a common surprise: having the app does not give you the CLI). Install the
  Cursor CLI (`cursor-agent`), run `cursor-agent login` once
  (or set a `CURSOR_API_KEY`), and Brilliant detects it on launch. A single
  **Cursor Agent** model then appears in the selector; it auto-routes to the best
  model for the task, the way `cursor-agent` does on its own. The settings row
  reads "Not connected" when the CLI itself was not found (install it), and
  "Not signed in" when the CLI is found but not logged in yet; run
  `cursor-agent login` in your terminal, then the circular-arrow button
  re-checks. If your `cursor-agent` lives somewhere unusual, set the
  `BRILLIANT_CURSOR_AGENT_PATH` environment variable to its path. If a chat fails
  to start, the error names the actual cause rather than always pointing at
  login: a sign-in problem still says to run `cursor-agent login`, but a process
  that could not launch, a request cursor-agent rejected (a version mismatch),
  or a no-response timeout each say so plainly, so you fix the right thing.
- **Muse Code** (Meta's coding agent, desktop app only) also has no key field: it
  signs in with your Meta account. Install Muse Code, run `muse login` once, and
  Brilliant detects it on launch; the models your login can run then appear in
  the selector under **Muse Code**. A Muse Code subscription unlocks **Muse Wonder
  Full**, which has no API and is reachable only this way. Replies stream into
  the chat as they are written, the agent drives the canvas through Brilliant's
  own tools, Stop ends the turn, and a chat picks up the same Muse conversation
  after a restart. No manual MCP entry is needed: Brilliant connects each chat
  to the canvas on its own, and a `brilliant` server in Muse Code's settings
  for terminal use (Settings > MCP Connections > Muse Code writes one) does not
  block the chat: the chat's own server is then named `brilliant_chat`, and the
  chat tells its model to use that one. Brilliant runs Muse Code on your account login even when a
  `META_API_KEY` is set in your shell (that key would hide the subscription
  models). The row reads "Not connected" when `muse` was not found, "Not signed
  in" until `muse login`, "status check failed" when the model list could not be
  read, and "Signed in · no models available" when your login lists none; the
  circular-arrow button re-checks. If `muse` lives somewhere other than
  `~/.local/bin`, set the `BRILLIANT_MUSE_PATH` environment variable to it.
