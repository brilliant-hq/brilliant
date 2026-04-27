---
name: "feedback"
description: "File feedback, bug reports, or feature requests for Brilliant"
---

# Feedback Assistant

Help the user share feedback with the Brilliant team. GitHub (`brilliant-hq/brilliant`) is the default for bugs and feature requests; Discord, email, and X are casual alternatives.

Anything beyond what the user typed (version info, screenshots, selection details) is **opt-in only** — never attach extra context without explicit consent.

## Step 1: Understand the feedback

If the user already described their feedback in the message that triggered this skill, use it — skip the category prompt. Otherwise:

```json
{
  "question": "What would you like to share?",
  "options": [
    { "label": "Bug report", "description": "Something isn't working correctly" },
    { "label": "Feature request", "description": "I'd like a new capability" },
    { "label": "Question", "description": "I need help understanding something" },
    { "label": "General feedback", "description": "Thoughts, ideas, or anything else" }
  ]
}
```

Then ask for a description if not already given.

## Step 2: Search GitHub for prior discussion

Goal: figure out if the user's question is already answered or the bug already tracked, before drafting anything new. Works without auth via the public REST API. Don't narrate the auth probe or paste raw output — just summarize findings.

### Primary search

**With `gh` (if installed and authed):**
```
gh search issues --repo brilliant-hq/brilliant "<keywords>" --json number,title,state,labels,url --limit 10
```

**Public REST (no auth needed):**
```
curl -sS "https://api.github.com/search/issues?q=repo:brilliant-hq/brilliant+<keywords>" \
  | jq '.items[:10] | .[] | {number, title, state, html_url, labels: [.labels[].name]}'
```

### Search budget — keep it tight

- Unauth search rate limit is **10 requests/minute**; authed is 30/min. Don't burn it on synonym sprays.
- Run **at most 2 broad queries** before falling back to a listing. One literal-keyword query + one symptom-phrase query is usually enough.
- If both return zero (common in sparse repos), don't keep guessing — drop to the listing fallback below.

### Useful `q` qualifiers (REST and `gh search` both accept these)

`is:issue` · `is:pr` · `is:open` · `is:closed` · `label:bug` · `in:title` · `in:body` · `in:comments` · `sort:updated-desc` · `sort:reactions-desc` · `created:>=2026-01-01`

### Listing fallback (cheap, no search budget)

When search returns nothing or the repo is sparse, list recent activity directly — much more useful than another search:
```
gh issue list --repo brilliant-hq/brilliant --state all --limit 20
# or
curl -sS "https://api.github.com/repos/brilliant-hq/brilliant/issues?state=all&sort=updated&per_page=20" \
  | jq '.[] | {n:.number, state, title, labels:[.labels[].name], updated_at}'
```
This uses the core API (60/hr unauth, 5000/hr authed), not the search budget.

### Read the conversation, not just the title

For close matches — especially **closed** ones — the resolution is usually in the comments, not the body:
```
gh issue view <n> --repo brilliant-hq/brilliant --comments
# or
curl -sS "https://api.github.com/repos/brilliant-hq/brilliant/issues/<n>/comments" | jq '.[] | {user:.user.login, body}'
```

### Check in-flight PRs too

A fix or feature may already be on the way. Worth a quick look before filing a duplicate:
```
gh pr list --repo brilliant-hq/brilliant --search "<keywords>" --state all
```

## Step 3: Present findings and pick a channel

Show matches (number, title, state, URL). Then ask where to go next:

```json
{
  "question": "How would you like to proceed?",
  "options": [
    { "label": "Comment on existing issue", "description": "Add to one of the threads above" },
    { "label": "File on GitHub", "description": "Public issue tracker — recommended for bugs and feature requests" },
    { "label": "Send via email", "description": "hello@brilliant.design — private, goes straight to the team" },
    { "label": "Post in Discord", "description": "Community chat — good for questions and casual feedback" },
    { "label": "Post on X", "description": "Public — @usebrilliant" }
  ]
}
```

Recommendations:
- **Bug or feature request** → GitHub.
- **Question or casual feedback** → Discord.
- If the user picks GitHub but `gh` isn't authed → silently route to email instead. Don't ask them to set up a personal access token.

## Step 4: Offer optional context (opt-in only)

Before drafting, ask which extras (if any) to include. Default is **nothing** beyond what the user typed. Only attach what the user explicitly approves.

Available extras:
- **App version + OS** — read `version:` from `pubspec.yaml` and the user's OS.
- **Canvas screenshot** — current view via `mcp__brilliant__export` (PNG). Skip this option if there's no active canvas.
- **Selection details** — `mcp__brilliant__get_selection` followed by `mcp__brilliant__lookup` (`scope` set to the selected IDs, `format: "blueprint"`) for the selected elements. Skip if nothing is selected.

Ask the user to pick which to include (a single question with these as options, or one quick yes/no each — whichever is less friction). If the user says "none" or skips, attach nothing.

## Step 5: Draft and confirm

Compose the message in the chosen channel's format. **Show the user the complete payload** — title, body, every attachment, and where it's going — so nothing leaves their machine without their seeing it first.

- **GitHub**: title (under 80 chars), body, label. Run `gh label list --repo brilliant-hq/brilliant --limit 50` (or the REST equivalent) to use real labels — don't guess.
- **Email**: subject + body, URL-encoded into `mailto:hello@brilliant.design?subject=...&body=...`. Also copy the body to the clipboard since long `mailto:` URLs can truncate. For screenshots, save the PNG locally and tell the user to attach it manually before sending.
- **Discord**: drafted message + the invite link `https://discord.gg/qxT2rgk9uC`. Tell the user to drag any screenshot into the channel after joining.
- **X**: drafted post (under 280 chars) mentioning `@usebrilliant`, opened via `https://x.com/intent/tweet?text=<url-encoded>`.

Confirm:

```json
{
  "question": "Send it?",
  "options": [
    { "label": "Send", "description": "Submit / open as shown above" },
    { "label": "Edit first", "description": "I'd like to make changes" }
  ]
}
```

## Step 6: Send

**GitHub (authed):**
```
gh issue create --repo brilliant-hq/brilliant --title "..." --body "..." --label "..."
gh issue comment <number> --repo brilliant-hq/brilliant --body "..."
```
Show the resulting URL.

**Email / Discord / X**: open the relevant URL with the drafted text ready to send or paste. Confirm the body is on the clipboard for email. The user reviews and sends from their own client.

## Channels reference

| Channel | Where |
|---|---|
| GitHub | `brilliant-hq/brilliant` |
| Email | `hello@brilliant.design` |
| Discord | `https://discord.gg/qxT2rgk9uC` |
| X | `@usebrilliant` — `https://x.com/usebrilliant` |
