---
name: pr-summary
description: Generate a comprehensive pull request summary following the repository's PR template.
allowed-tools: Bash(git *),Read,Grep,Glob,Write
---

# pr-summary

Generate a comprehensive pull request summary for the current branch following the project's PR template format.

## Usage

```
/pr-summary [JIRA-TICKET]
```

**Arguments:**
- `JIRA-TICKET` (optional): Jira ticket identifier (e.g., "NXLIB-1234") to populate the "connected issues" section
  - If provided, the ticket will be linked in the connected issues section
  - If omitted, the user will be prompted to provide one

**Examples:**
```
/pr-summary NXLIB-1234
/pr-summary
```

**Output:**
- Writes PR summary to `JIRA-TICKET_PR_SUMMARY.md` in the current working directory (e.g., `NXLIB-1234_PR_SUMMARY.md`)
- If no Jira ticket provided, writes to `PR_SUMMARY.md`
- File can be opened and copied directly into GitHub PR description

## Overview

This skill analyzes the current git branch, reviews all changes, and generates a structured PR summary that follows the repository's PULL_REQUEST_TEMPLATE.md format.

## Process

1. **Analyze Branch Changes**
   - Run git commands to understand branch commits and changes
   - Compare current branch with the base branch (typically dev or main)
   - Review all modified, added, and deleted files
   - Understand the scope and impact of changes

2. **Generate PR Summary**
   - Follow the exact format from `.github/PULL_REQUEST_TEMPLATE.md`
   - Fill in all required sections with detailed, accurate information
   - Keep language clear and concise

3. **Present to User**
   - Write the complete PR summary to a file in the current working directory
   - File naming: `JIRA-TICKET_PR_SUMMARY.md` (e.g., `NXLIB-1234_PR_SUMMARY.md`)
   - If no Jira ticket provided, use `PR_SUMMARY.md`
   - This ensures no leading or trailing spaces are added
   - The file can be opened and copied directly into PR description
   - Inform the user where the file was written

## PR Summary Guidelines

### tl;dr Section
- 1-3 sentences maximum
- Technical but clear - aimed at developers
- Describe in human terms **why** this change is being made
- Focus on **what** changed and **why**
- Example: "Reverts failed PAS endpoint migration and removes ~900 lines of dead Enterprise/SEL lookup code."

### Connected Issues Section
- If a Jira ticket argument is provided (e.g., "NXLIB-1234"):
  - Use `finishes JIRA-TICKET` if the PR completes the ticket
  - Use `connects JIRA-TICKET` if the PR is related but doesn't complete the ticket
  - Default to `finishes` unless the changes are clearly incomplete or partial
- If no Jira ticket argument is provided, prompt the user to provide one
- Examples:
  - `finishes NXLIB-1234`
  - `connects NXLIB-5678`

### Release Notes Section
- Written for **non-developers** (product managers, QA, support)
- 10 words or less
- Layman's terms - avoid technical jargon
- Focus on **user-facing impact** or "Internal improvement"
- Examples:
  - "Improves student reading level calculation performance"
  - "Internal: Removes unused Star Reading data collection"

### Output Format

**CRITICAL FORMATTING REQUIREMENT:**
- ALWAYS write the ENTIRE PR summary to a file in the current working directory
- File naming convention:
  - With Jira ticket: `JIRA-TICKET_PR_SUMMARY.md` (e.g., `NXLIB-1234_PR_SUMMARY.md`)
  - Without Jira ticket: `PR_SUMMARY.md`
- Use the Write tool to create the file with the complete PR summary
- This ensures all special formatting is preserved (checkboxes, headers, etc.) without any accidental leading or trailing spaces
- The raw markdown can then be copy-pasted directly from the file into GitHub PR descriptions
- **ALL content must be FULLY LEFT-JUSTIFIED - no leading spaces or indentation at the start of lines**
- Use `- [ ]` for unchecked items (note the spaces between brackets)
- Use `- [x]` for checked items (lowercase x)
- Maintain exact indentation for nested items (2 spaces for sub-items, 4 spaces for details)
- **Wrap all sections after "Deployment notes" in a collapsible `<details>` block with summary text "View detailed change log"**
- After writing the file, inform the user where it was written

#### DB Schema Changes
- Mark the appropriate timing with `[x]`:
  - `pre-code deployment` - Must run before code deploys
  - `time-sensitive deployment` - Must run at specific time (explain in Release notes)
  - `post-code deployment` - Can run after code deploys
- List the actual SQL files to run, use the full path from content root
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
- Include location in the product (e.g., "conf/config.ini - add new_key = value")

#### Worker Update
- Mark if workers need to be restarted or updated
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

finishes NXLIB-1234

## Release notes

User-facing description in 10 words or less.

## Deployment notes

- DB schema changes
  - [x] post-code deployment
    - Run server/sql/folder/001_file.sql
    - Verify with: SELECT COUNT(*) FROM table;
- [ ] DB view/procedure/trigger/event changes
- [ ] Script
- [ ] Config change
- [x] Worker update
  - Restart getScaledScoreWorker after deployment
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

- **ALWAYS write the entire PR summary to a file in the current working directory using the Write tool**
  - Use filename format: `JIRA-TICKET_PR_SUMMARY.md` if Jira ticket provided, otherwise `PR_SUMMARY.md`
- **NEVER output the PR summary as text in chat - always write to file to avoid spacing issues**
- **Check if a Jira ticket argument was provided and use it in both the filename and the "connected issues" section**
- **Wrap everything AFTER the "Deployment notes" section in a collapsible `<details>` block**
  - Use `<summary>View detailed change log</summary>` as the summary text
  - This keeps the PR summary concise while allowing reviewers to expand for full details
- Always analyze the full branch diff, not just the latest commit
- Check for breaking changes and document them clearly
- Include rollback procedures for risky operations
- Be honest about risks and unknowns
- Quantify changes (files, lines, classes removed/added)
- Cross-reference related commits when explaining complex changes
