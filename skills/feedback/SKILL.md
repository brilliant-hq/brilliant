---
name: "feedback"
description: "File feedback, bug reports, or feature requests for Brilliant"
---

# Feedback Assistant

Help the user file feedback against the `brilliant-hq/brilliant` GitHub repository.

## Step 1: Detect GitHub access

Silently check which method is available (don't show the output to the user):

1. Run `gh auth status` to check if `gh` CLI is installed and authenticated.
2. If `gh` works, use it for all operations.
3. If not, fall back to **GitHub REST API via curl**:
   - Searching works without auth (public repo).
   - Creating issues requires a token. Check `$GITHUB_TOKEN` or `$GH_TOKEN`.
   - If no token exists, inform the user only when it's time to create (not during search).

## Step 2: Ask what the feedback is about

Use the `AskUserQuestion` tool to ask the user to describe their feedback:

```json
{
  "question": "What would you like to report or request?",
  "options": [
    { "label": "Bug report", "description": "Something isn't working correctly" },
    { "label": "Feature request", "description": "I'd like a new capability" },
    { "label": "Question", "description": "I need help understanding something" }
  ]
}
```

Then ask for a description of the issue.

## Step 3: Search for existing issues

Search the repo for related issues using multiple keyword variations. Cast a wide net — search both open and closed issues.

**With `gh`:**
```
gh search issues --repo brilliant-hq/brilliant "<keywords>" --json number,title,state,body,labels,url --limit 10
```

**With curl:**
```
curl -s "https://api.github.com/search/issues?q=repo:brilliant-hq/brilliant+<keywords>" | jq '.items[:10] | .[] | {number, title, state, html_url, labels: [.labels[].name]}'
```

## Step 4: Present findings

Use `AskUserQuestion` to present results and let the user choose:

- **Matches found**: Show issue numbers, titles, state, and URLs. Ask whether to comment on an existing one or create new.
- **Closed match**: Note it was closed. Ask if this is a regression or different aspect.
- **No matches**: Tell the user and proceed to drafting.

## Step 5: Draft the issue

Compose a well-structured issue:

- **Title**: Clear, concise (under 80 chars)
- **Body**: Description, steps to reproduce (bugs), expected vs actual behavior, additional context
- **Label**: Pick from `bug`, `enhancement`, `documentation`, `question`

Show the full draft and use `AskUserQuestion` to confirm:

```json
{
  "question": "Ready to create this issue?",
  "options": [
    { "label": "Create it", "description": "Submit the issue as shown above" },
    { "label": "Edit first", "description": "I'd like to make changes" }
  ]
}
```

## Step 6: Create or comment

**With `gh`:**
```
gh issue create --repo brilliant-hq/brilliant --title "..." --body "..." --label "..."
gh issue comment <number> --repo brilliant-hq/brilliant --body "..."
```

**With curl (needs GITHUB_TOKEN):**
```
curl -s -X POST "https://api.github.com/repos/brilliant-hq/brilliant/issues" \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"...","body":"...","labels":["..."]}'
```

If creating via curl and no token exists, tell the user:
> To create issues without `gh`, set a GitHub personal access token:
> `export GITHUB_TOKEN=ghp_...` (create one at https://github.com/settings/tokens with `repo` scope)

Show the resulting issue URL when done.
