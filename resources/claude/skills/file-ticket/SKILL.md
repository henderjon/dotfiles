---
name: file-ticket
description: Creates a single, well-fleshed-out ticket in your issue tracker from a plain-language description of an issue, bug, or piece of work — no branch, diff, or PR involved. Use this whenever the user says something like "file a ticket for X", "create a ticket about Y", "log this as a bug", "make a ticket for this idea", or describes a problem/feature and asks for it to be tracked. Do NOT use this when the user is wrapping up a finished branch and wants a ticket-plus-PR together — that is a separate "ship" workflow's job, not this one.
argument-hint: "[sprint|backlog]"
arguments:
  - sprint
---

# file-ticket

Turns a plain-language description into a single, detailed ticket in your team's issue
tracker. This is the "I want to track this properly" step, on its own — no code, no
branch, no PR.

This skill executes a real, visible, hard-to-reverse action (creates a real ticket).
Move deliberately: draft the ticket's full content first and confirm it with the user
before calling the create API.

## Before first use: fill in your tracker's specifics

This skill is written generically. Before relying on it, fill in the placeholders below
for whichever tracker your team uses:

- **Tracker MCP tools or CLI**, e.g. `<create-ticket-tool>`, `<edit-ticket-tool>`,
  `<search-tickets-tool>`, `<lookup-user-tool>`
- **Workspace/instance identifier**, e.g. a hosted-instance id, a workspace slug, or a
  repo/org identifier, depending on your tracker
- **Project or board identifier** ticket should be filed under
- **Issue type names** available (e.g. `Bug`, `Task`, `Story`, or your tracker's
  equivalents)
- **Any custom fields** your team requires on every ticket (e.g. story points,
  acceptance-criteria field, sprint/iteration field) — including their field IDs and
  expected value shapes, since many trackers reject a plain string where they expect a
  structured document or a specific type
- **Sprint/iteration mechanics**, if your tracker has them — how to find the active
  sprint and how to move an issue into it
- **Ticket ID format**, if your team references tickets by a short code (e.g.
  `PROJ-123`) in commit messages or PR titles

Keep this section up to date — if a tracker call fails with a schema/field error, or
your team's ticket process changes, update this file to match rather than special-casing
around the mismatch every time.

## Argument

`/file-ticket sprint` or `/file-ticket backlog` answers the sprint-vs-backlog question
(see below) up front instead of asking. Whatever was typed in that position: `$sprint`

- Starts with "sprint" (or "current"): skip the question below, use the current sprint
  (only meaningful if your tracker has a sprint/iteration concept).
- Starts with "backlog": skip the question below, use backlog.
- Blank or anything else: ask as normal, per the section below.

## Step 1: Get enough detail to write a real ticket, not a placeholder

There is no diff to ground this ticket in — the description you were given IS the
source of truth, so its quality determines the ticket's quality. Before drafting
anything, make sure you actually have:

- **What** is broken, needed, or being proposed — specific enough to act on. "The
  export button is broken" is not enough; "the CSV export on the admin page times out
  for datasets over ~500 rows" is.
- **Why** it matters — impact, who is affected, and how badly. Every ticket description
  here must state why, not just what. If the user's description doesn't already make
  this clear, ask for it rather than inventing a plausible-sounding reason.
- Enough context to write concrete acceptance criteria (see below) — repro steps for a
  bug, or the specific behavior expected for a feature/task.

If the user's initial description is thin, ask targeted follow-up questions rather than
padding the ticket with vague filler to make it look complete. A short back-and-forth
here is the point of this skill — it is what makes the resulting ticket "greater
detail" than a one-line summary would produce. Don't interrogate for its own sake
either: once you have what/why/verifiable-criteria, move on.

## The other things you must ask about, not guess

**Sprint or backlog?** (skip if your tracker has no sprint/iteration concept) Whether
this goes into the active sprint is a planning call the user makes, not something
inferable from the description. Ask directly (a simple AskUserQuestion with "Current
sprint" vs "Backlog" is enough) — unless the invocation argument already answered it,
see "Argument" above.

**Who should this be assigned to?** Don't assume it's whoever is running the skill —
"file a ticket" is not "assign it to me." Look up the current user's identity in the
tracker first (via whatever your tracker's "who am I" call is) so you know who "you"
are, then ask via AskUserQuestion — options "Me (\<resolved name\>)", "Someone else", and
"Leave unassigned" — unless the user's description already named an assignee. If
"Someone else," ask who, then resolve their account id via your tracker's user-lookup
call, or ask the user for the account id directly if lookup doesn't find a clean match.
If "Leave unassigned," omit the assignee field from the create call entirely rather than
passing an empty value.

Everything else below (issue type, story points, acceptance criteria) is something you
should determine yourself from the gathered description, not ask about.

## Step 2: Draft the ticket

The conventions below reflect a generic ticket process — replace the bracketed
placeholders with your tracker's actual identifiers before using this skill for real.

**Fixed identifiers:**
- Workspace/instance: `<your-tracker-instance>`
- Project key: `<YOUR-PROJECT-KEY>`

**Assignee**: use the assignee id resolved in "The other things you must ask about, not
guess" above — do not re-derive or re-ask here.

**Pick the issue type**: `Bug` if the description is a defect in existing behavior,
`Task` for everything else (new work, improvements, chores). Don't ask — infer from the
description. Adjust these two names to whatever your tracker calls them.

**Estimate an effort/size field yourself**, if your team tracks one (e.g. story points),
from the described scope and complexity — how many areas/surfaces are touched, how much
uncertainty or investigation the work implies, not just how long the description is.
Use a Fibonacci-ish scale as a guide: 1 (trivial, single obvious change), 2-3 (small,
isolated, well understood), 5 (a real feature or multi-part fix), 8+ (touches multiple
layers/domains, or the description itself signals real design/investigation
complexity). State the number you picked in your summary to the user so they can
override it if it's off — this is a guess made without a diff to measure against.

**Description** (the issue's own description field): starts with a single plain line —
the longer Title line (see "Summary" vs. "Title line" below) — followed by a blank
line, then exactly two sections, in this order — `### Why` (the reason alone, not
"because...") then `### What` (imperative, specific). Pull all three from what was
gathered in Step 1. The Why/What sections should read as genuinely detailed — specific
enough that someone who wasn't in this conversation could pick up the ticket cold. This
is what a reader sees the moment they open the ticket, regardless of what brought them
there — a column, a notification, or a direct link.

**Acceptance Criteria**: if your tracker has a dedicated acceptance-criteria field,
check what value shape it expects before writing to it — some trackers reject a plain
string and require a structured document format (e.g. a checklist/task-list node
structure) with specific attributes on each item. Test the exact shape once and record
it here so future runs of this skill don't have to rediscover it by trial and error.

Write 2-5 criteria that are concretely verifiable against the described issue (e.g.
"CSV export completes in under 10s for a 500-row dataset" rather than "Export works
correctly"). More criteria than a typical PR-ticket would have is expected here —
there's no code diff to fall back on for what "done" means, so the criteria are the
ticket's main definition of done.

**Summary**: this is the tracker's title/summary field — the only thing that shows up in
board columns, search results, and notification emails, all places where length costs
real readability. Keep it as short as possible while still clear on its own: a few
words, not a sentence. E.g. "CSV export times out for large datasets", not "Fix export
bug" (too vague, doesn't say what's wrong).

**Title line**: the first line of the description (see above) — a longer, fully
specific version of the same title, carrying the detail the short Summary had to drop.
This is what a reader actually opening the ticket sees first, above the Why/What detail
below it. Using the example above: Summary is "CSV export times out for large
datasets"; the Title line is "CSV export times out for datasets over 500 rows".

## Step 3: Confirm before creating

Show the user the full draft — short Summary, longer Title line, issue type, effort
estimate, description (Why/What), and acceptance criteria as a plain checklist — before
calling the create API. This is the negotiation point: let them edit freely. Don't treat
this as a rubber stamp.

## Step 4: Create the ticket

Call your tracker's create-issue tool/API with the workspace identifier, project key,
issue type, summary, description, assignee (omit entirely if the user chose "Leave
unassigned" above), and any required custom fields (acceptance criteria, effort
estimate).

Note what the create response actually returns — some trackers' create responses only
include an id/key and an internal API link, not a browsable URL. If so, build the
human-facing URL yourself from the returned key (e.g.
`https://<your-tracker-instance>/browse/<KEY>`). Don't hand the user an internal API
link as "the ticket URL" — verify it resolves in a browser first.

### Sprint vs backlog

(Skip this whole section if your tracker has no sprint/iteration concept.)

If the user chose backlog, do nothing further — a freshly created issue is backlog by
default in most trackers.

If the user chose current sprint, look up the active sprint's id via your tracker's
search/query tool, then move the new issue into that sprint via your tracker's edit-issue
call. Check the exact value shape the sprint field expects (a bare id vs. an array vs. a
richer object) before calling — trackers are often inconsistent between what a read
returns and what a write accepts. If no issue currently sits in an open sprint, tell the
user you couldn't find an active sprint and fall back to backlog rather than guessing.

## Step 5: Report back

Give the user the full ticket URL you built in Step 4 (verified to resolve in a
browser, not an internal API link), plus the effort estimate, issue type, assignee, and
sprint/backlog decision, so they can adjust anything that's off.
