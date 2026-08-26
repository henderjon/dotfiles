---
name: pr-summary
description: Generate a comprehensive pull request summary following the repository's PR template.
allowed-tools: Bash(git *),Read,Grep,Glob,Write
---

# pr-summary

Generate a comprehensive pull request summary for the current branch following the project's PR template format.

## Usage

```
/pr-summary [TICKET-ID]
```

**Arguments:**
- `TICKET-ID` (optional): issue tracker ticket identifier (e.g., "PROJ-1234") to populate the "connected issues" section
  - If provided, the ticket will be linked in the connected issues section
  - If omitted, the user will be prompted to provide one
  - If this project has no ticket tracker, skip the connected issues section entirely rather than asking

**Examples:**
```
/pr-summary PROJ-1234
/pr-summary
```

**Output:**
- Writes the PR summary to a file — see "Where to write the file" below.
- File can be opened and copied directly into the PR description.

## Before first use: fill in your project's specifics

This skill is written generically. Before relying on it, check whether these apply to
your repository and adjust:

- **PR template location** — this skill looks for `.github/PULL_REQUEST_TEMPLATE.md`
  first. If your project keeps it elsewhere (`.github/pull_request_template.md`,
  `docs/PULL_REQUEST_TEMPLATE.md`, or none at all), update "Generate PR Summary" below,
  or fall back to the generic sections listed there.
- **Ticket tracker prefix**, if your team references tickets by a short code (e.g.
  `PROJ-123`) — used only to label the "connected issues" section, not to call any API.
- **Output directory** — this skill writes to `pr-summary/` by default. If your project
  already has a scratch/output convention (a gitignored `local/` dir, a `tmp/` dir,
  etc.), write there instead. Check `.gitignore` if unsure whether the chosen directory
  needs to be added to it.
- **Deployment-notes categories** (DB schema, config, workers, scripts) reflect common
  categories across projects. Rename or drop any that do not apply to this project's
  stack, and add any that do (e.g. a queue/topic change, a feature-flag change).

## Summary Guidelines

- Always include "why" the change was made, ask if it cannot be inferred from the conversation
- "Why" should always be the first line(s) of the commit message
- Max line length 120 characters.
- Write in very terse Hemingway style.
- Avoid jargon.
- Avoid contractions.
- Avoid conjunctions.
- Use simple words.
- Be direct.
- Only include co-author credits in commit messages when an agent contributed to the code being committed
- Only sign or co-sign a commit or a commit message when an agent contributed to the code being committed
- Avoid under-specific messages like "Update code" or "Fix bug" or "Refactors X". Be specific about what was changed and why.
- Do not push the branch

## Cross-Repo/Org References

Never name or link to another repository, project, or organization — one other than the
one this PR is in — anywhere in the summary, unless the user has explicitly said to
include it in this conversation. If a cross-reference seems useful, ask before adding it
— do not add it on your own judgment, even as an illustrative example.

## Process

1. **Analyze Branch Changes**
   - Run git commands to understand branch commits and changes
   - Compare current branch with the base branch (detect it via
     `git symbolic-ref refs/remotes/origin/HEAD` if you do not already know it, typically
     `main`, `master`, or `dev`)
   - Review all modified, added, and deleted files
   - Understand the scope and impact of changes

2. **Generate PR Summary**
   - If a PR template exists in this repository, follow its exact format
   - If no template exists, use the generic section set below (tl;dr, connected issues,
     release notes, deployment notes, background/changes/testing as needed)
   - Fill in all required sections with detailed, accurate information
   - Keep language clear and concise

3. **Present to User**
   - Write the complete PR summary to the output directory (create it first if it does
     not already exist) — never to the project root
   - This ensures no leading or trailing spaces are added
   - The file can be opened and copied directly into PR description
   - Inform the user where the file was written

## Where to write the file

Default to a `pr-summary/` directory at the repo root (`mkdir -p pr-summary` if it does
not exist). If the project already has an established scratch/output convention, use
that instead.

File naming:
- With a ticket ID: `pr-summary/TICKET-ID_PR_SUMMARY.md` (e.g., `pr-summary/PROJ-1234_PR_SUMMARY.md`)
- Without a ticket ID: `pr-summary/PR_SUMMARY.md`

## PR Summary Guidelines

### tl;dr Section
- 1-3 sentences maximum
- Technical but clear - aimed at developers
- Describe in human terms **why** this change is being made
- Focus on **what** changed and **why**
- Example: "Reverts a failed endpoint migration and removes ~900 lines of now-dead lookup code."

### Connected Issues Section
- If a ticket ID argument is provided (e.g., "PROJ-1234"):
  - Use `finishes TICKET-ID` if the PR completes the ticket
  - Use `connects TICKET-ID` if the PR is related but doesn't complete the ticket
  - Default to `finishes` unless the changes are clearly incomplete or partial
- If no ticket ID argument is provided, prompt the user to provide one
- If this project has no ticket tracker, omit this section entirely
- Examples:
  - `finishes PROJ-1234`
  - `connects PROJ-5678`

### Release Notes Section
- Written for **non-developers** (product managers, QA, support)
- 10 words or less
- Layman's terms - avoid technical jargon
- Focus on **user-facing impact** or "Internal improvement"
- Examples:
  - "Improves page load performance for logged-in users"
  - "Internal: Removes unused analytics event collection"

### Output Format

**CRITICAL FORMATTING REQUIREMENT:**
- ALWAYS write the ENTIRE PR summary to a file under the output directory (see "Where
  to write the file" above) — never to the project root
- Use the Write tool to create the file with the complete PR summary
- This ensures all special formatting is preserved (checkboxes, headers, etc.) without
  any accidental leading or trailing spaces
- The raw markdown can then be copy-pasted directly from the file into the PR description
- **ALL content must be FULLY LEFT-JUSTIFIED - no leading spaces or indentation at the start of lines**
- Use `- [ ]` for unchecked items (note the spaces between brackets)
- Use `- [x]` for checked items (lowercase x)
- Maintain exact indentation for nested items (2 spaces for sub-items, 4 spaces for details)
- **Wrap all sections after "Deployment notes" in a collapsible `<details>` block with summary text "View detailed change log"**
- After writing the file, inform the user where it was written

#### DB Schema Changes
- Applicable only if this project has a database with checked-in migration scripts.
- Mark the appropriate timing with `[x]`:
  - `pre-code deployment` - Must run before code deploys
  - `time-sensitive deployment` - Must run at specific time (explain in Release notes)
  - `post-code deployment` - Can run after code deploys
- List the actual migration files to run, use the full path from the repo root
- Include any special instructions (order, verification steps, rollback procedures)

#### DB View/Procedure/Trigger/Event Changes
- Mark timing if applicable
- List specific changes

#### Script
- Mark if any one-time scripts need to run
- Include script path and execution instructions

#### Config Change
- Mark if configuration changes are needed
- Document which config files and which keys
- Include location in the product (e.g., "config/app.yml - add new_key: value")

#### Worker Update
- Mark if background workers/consumers need to be restarted or updated
- Note any queue compatibility concerns
- Document migration strategy if breaking changes

## Content Guidelines

### Be Comprehensive
- Include all important technical details
- List all major file changes with line counts
- Explain architectural decisions
- Document breaking changes clearly

### Be Specific
- Don't just say "updates code" - say what specifically changed
- Include file paths for important changes
- Reference specific methods/classes that changed
- Quantify changes (lines added/removed, files changed)

### Consider the Audience
- **tl;dr** - For reviewers to quickly understand the PR
- **Release notes** - For product/support teams
- **Deployment notes** - For DevOps/deployment engineers
- **Background/Changes** - For developers reviewing the code

### Include Context Sections as Needed

Add additional sections if helpful:

#### Background
- Why was this change needed?
- What problem does it solve?
- What was tried before?

#### Changes
- Bulleted list of all major changes
- Group related changes together
- Include line counts for significant additions/deletions

#### Testing
- What tests were run?
- Any test failures (explain if pre-existing)?
- Manual testing performed?

#### Deployment Considerations
- Any special deployment requirements?
- Breaking changes and migration strategies?
- Monitoring recommendations?

#### Follow-up Work
- Any additional PRs needed?
- Technical debt to address?
- Features to implement later?

## Example Output Format

```markdown
## tl;dr

Brief summary of the PR in 1-3 sentences.

## connected issues

finishes PROJ-1234

## Release notes

User-facing description in 10 words or less.

## Deployment notes

- DB schema changes
  - [x] post-code deployment
    - Run migrations/folder/001_file.sql
    - Verify with: SELECT COUNT(*) FROM table;
- [ ] DB view/procedure/trigger/event changes
- [ ] Script
- [ ] Config change
- [x] Worker update
  - Restart exampleWorker after deployment
  - Backwards compatible with old queue messages

<details>
<summary>View detailed change log</summary>

## Background

Context about why this change was needed...

## Changes

### Code Removed (X lines):
- File descriptions with line counts

### Code Modified:
- Key changes with file paths

### Database Changes:
- Table operations

## Testing

- Test results
- Coverage information

## Deployment Considerations

### Important Notes:
- Any special considerations
- Breaking changes
- Monitoring recommendations

## Follow-up Work

- [ ] Future tasks
- [ ] Technical debt

</details>
```

## Important Notes

- **ALWAYS write the entire PR summary to a file under the output directory using the
  Write tool** (see "Where to write the file" above) — never write it to the project root
  - Use filename format: `TICKET-ID_PR_SUMMARY.md` if a ticket ID was provided, otherwise `PR_SUMMARY.md`
- **NEVER output the PR summary as text in chat - always write to file to avoid spacing issues**
- **Check if a ticket ID argument was provided and use it in both the filename and the "connected issues" section**
- **Wrap everything AFTER the "Deployment notes" section in a collapsible `<details>` block**
  - Use `<summary>View detailed change log</summary>` as the summary text
  - This keeps the PR summary concise while allowing reviewers to expand for full details
- Always analyze the full branch diff, not just the latest commit
- Check for breaking changes and document them clearly
- Include rollback procedures for risky operations
- Be honest about risks and unknowns
- Quantify changes (files, lines, classes removed/added)
- Cross-reference related commits when explaining complex changes
- This skill has no dependency on any particular tech stack, ticket tracker, or PR
  template. "Before first use" above asks you to detect what this project actually uses
  rather than assuming a fixed set of paths or tools.
