---
name: ship-pr
description: Wraps up a finished feature branch in this myON repo — files an NXLIB Jira ticket, pushes the branch, and opens a draft GitHub PR from .github/PULL_REQUEST_TEMPLATE.md. Use this whenever the user says something like "ship this", "ship this branch", "open a PR for this", "file a ticket and PR", "let's wrap this up", or "I'm done, let's get this reviewed" — even if they only mention one part (e.g. just "push this up" or "make a ticket for this") that pushing the PR-and-ticket workflow forward is clearly the intent. Do NOT use this for creating a ticket in isolation with no intent to open a PR soon, and do NOT use it to run tests/lint/fix code — this is purely the shipping wrap-up step, assuming the branch's code changes are already done.
argument-hint: "[sprint|backlog]"
arguments:
  - sprint
---

# ship-pr

Files an NXLIB Jira ticket, pushes the current branch, and opens a draft PR for it —
the "I'm done coding, let's get this out for review" step. It does not touch code,
run tests, or run linters; those are separate concerns.

## Argument

`/ship-pr sprint` or `/ship-pr backlog` answers the sprint-vs-backlog question (see
below) up front instead of asking. Whatever was typed in that position: `$sprint`

- Starts with "sprint" (or "current"): skip the question below, use the current sprint.
- Starts with "backlog": skip the question below, use backlog.
- Blank or anything else: ask as normal, per the section below.

This skill executes real, visible actions (creates a real Jira ticket, pushes a real
branch, opens a real PR). Move deliberately — confirm the plan with the user before
firing off API calls, per this repo's general norm of checking before hard-to-reverse
or externally-visible actions.

## Before anything else: guardrails

1. Run `git fetch origin dev` then `git log origin/dev..HEAD --oneline`. If this is
   empty, there's nothing to ship — say so and stop.
2. Read the actual diff before drafting anything: `git diff origin/dev...HEAD --stat`
   and `git log origin/dev..HEAD --oneline`. Everything below (ticket description,
   acceptance criteria, story points, PR body) should be grounded in what this diff
   actually does, not generic boilerplate.

## The two things you must ask about, not guess

- **Sprint or backlog?** Whether new work goes into the active sprint is a planning call
  the user makes, not something inferable from the diff. Ask directly (a simple
  AskUserQuestion with "Current sprint" vs "Backlog" is enough) — unless the invocation
  argument already answered it, see "Argument" above.
- **The "why" for the ticket/PR**, if it isn't already clear from the conversation.
  Every Jira ticket description here must state why the change is needed, not just what
  changed — if that reason hasn't come up in conversation, ask for it rather than
  inventing one. The tl;dr section of the PR needs the same why, woven into prose (no
  `### What`/`### Why` sub-headings inside the PR's prose sections — that structure is
  for the Jira description only, see below).

Everything else (issue type, story points, acceptance criteria, PR checkbox selections)
is something you should determine yourself from the diff, not ask about — that's the
point of automating this.

## Step 1: Create the Jira ticket

The conventions below reflect this team's current ticket process. If a Jira call fails
with a schema/field error, or the process has since changed, check AGENTS.md for
anything newer and update this file to match.

**Fixed identifiers:**
- Cloud ID: `illuminate.atlassian.net`
- Project key: `NXLIB` (project id `14764`)

**Resolve the assignee dynamically, every run** — call
`mcp__claude_ai_Atlassian__atlassianUserInfo` and use its `account_id` as
`assignee_account_id`. Don't hardcode an account id; "assign it to me" means whoever is
running the skill.

**Pick the issue type**: `Task` for most work; `Bug` only if the branch is clearly fixing
a defect rather than adding/changing behavior. Don't ask — infer from the diff and
commit messages.

**Estimate Story Points yourself** (`customfield_10004`, a plain number) from the actual
size/complexity of `origin/dev...HEAD` — file count, line count, and how many distinct
concerns are touched, not just line count alone (e.g. a one-line config fix across many
generated files is smaller than a 20-line change to core business logic). Use a
Fibonacci-ish scale as a guide: 1 (trivial, single file, no real judgment calls), 2-3
(small, isolated, a handful of files), 5 (a real feature or multi-file refactor), 8+
(touches multiple layers/domains or has real design complexity). State the number you
picked in your summary to the user so they can override it if it's off.

**Description** (the issue's own `description` field, via `contentFormat: "markdown"`):
markdown with exactly two sections, in this order — `### What` (imperative, specific:
"Remove X and update Y") then `### Why` (the reason alone, not "because..."). Pull the
why from the conversation or from what you asked the user in the step above.

**RL Acceptance Criteria** (`customfield_13701`) — this field REJECTS a plain string
("Operation value must be an Atlassian Document"); it must be full ADF with a real
`taskList`/`taskItem` checkbox structure. `localId` (on both the `taskList` and every
`taskItem`) and `state: "TODO"` (on each `taskItem`) belong inside a nested `attrs`
object — putting them at the top level 400s with no useful error detail. Working shape:

```json
{
  "type": "doc",
  "version": 1,
  "content": [
    {
      "type": "taskList",
      "attrs": { "localId": "ac-1" },
      "content": [
        {
          "type": "taskItem",
          "attrs": { "localId": "ac-2", "state": "TODO" },
          "content": [ { "type": "text", "text": "Criterion text here" } ]
        }
      ]
    }
  ]
}
```

Write 2-4 criteria that are concretely verifiable against *this* diff (e.g. "Recommender
no longer returns X when Y" rather than "Code works correctly"). `localId` just needs to
be unique within the document — short strings like `ac-1`, `ac-2`, ... are fine.

**Putting it together** — call `mcp__claude_ai_Atlassian__createJiraIssue` with
`cloudId`, `projectKey: "NXLIB"`, `issueTypeName`, `summary`, `description` (markdown
string), `assignee_account_id`, and `additional_fields` containing both
`customfield_13701` (the ADF object above) and `customfield_10004` (the story point
number).

### Sprint vs backlog

If the user chose backlog, do nothing further — a freshly created issue is backlog by
default.

If the user chose current sprint, you need the active sprint's numeric id:

```
mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql
  cloudId: "illuminate.atlassian.net"
  jql: "project = NXLIB AND sprint in openSprints() ORDER BY updated DESC"
  fields: ["customfield_10007"]
  maxResults: 1
  searchResultMode: "issues"
```

The Sprint field is `customfield_10007`. On a read, it comes back as an array of full
sprint objects (`{id, name, state, boardId, goal, startDate, endDate}`) — grab `id` from
the first result's `customfield_10007[0]`. If no issue currently sits in an open sprint,
tell the user you couldn't find an active sprint and fall back to backlog rather than
guessing.

Then move the new issue into that sprint with
`mcp__claude_ai_Atlassian__editJiraIssue`, `fields: {"customfield_10007": sprintId}` —
a bare integer, no array (verified live: passing `[sprintId]` 400s with "The Sprint (id)
must be a number"; the rich object shape from the read above is read-only format).

## Step 2: Push the branch

```
git push -u origin <current-branch-name>
```

Tell the user you're about to push before running it. (This repo's own
`.claude/settings.local.json` also gates `git push` behind a confirmation prompt, so
this is belt-and-suspenders.)

## Step 3: Open the draft PR

Read `.github/PULL_REQUEST_TEMPLATE.md` fresh each run (don't rely on a cached copy —
it can change) and fill it in:

- **Title**: `<TICKET-KEY> <short imperative description>`, e.g.
  `NXLIB-501 Remove dev/ddldump CLI command` — the ticket ID always leads, per AGENTS.md.
  Do **not** put the ticket ID in any commit message — this repo connects the ticket to
  the work only through the PR (title + Connected issues), by established convention.
- **tl;dr**: flowing prose that includes both what changed and why it matters — no
  `### What`/`### Why` headings inside it; the template's own `##` headings are already
  enough structure.
- **Connected issues**: replace the bare `NXLIB-` line with the new ticket key.
- **Testing notes**: concrete steps for a teammate to verify this diff in isolation.
- **Release notes**: the same change, in plain language, 10 words or fewer.
- **Deployment notes**: check the boxes that actually apply based on the diff (don't
  delete unchecked ones — the template's checkboxes must all be preserved). Specifically
  check for new/changed files under `server/sql/` — this repo's SQL migrations live
  there (see `docs/SQL-Migrations-Guidelines.md` for how to classify pre-code /
  time-sensitive / post-code). If any exist, list every one of them in the section below
  the `---` divider, in execution order, and check the matching "DB schema changes" or
  "DB view/procedure/trigger/event changes" boxes plus whichever of
  pre-code/time-sensitive/post-code applies.
- Keep every other `##` heading in the template untouched, and use `###` or lower for
  any extra structure you add within a section.

Write the filled body to a temp file and create the PR:

```
gh pr create --draft --title "<TICKET-KEY> <description>" --body-file <tmpfile>
```

## Step 4: Report back

Give the user the Jira ticket URL and the PR URL, plus the story point estimate and
sprint/backlog decision, so they can adjust anything that's off before review starts.
