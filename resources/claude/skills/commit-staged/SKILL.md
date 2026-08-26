---
name: commit-staged
description: Commit all staged changes with a message.
allowed-tools: Bash(git commit:*),Bash(git status:*)
---

# commit-staged

Inspect the currently staged changes with git status.

Commit currently staged changes with a commit message.

## Commit Message Guidelines

- Always include "why" the change was made, ask if it cannot be inferred from the conversation
- The "why" for the commit/changes should be the first part of the commit message before any list of changes.
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

### Commit Message Format

Format the commit message as follows:

```
<summary of changes - soft limit 50 characters, hard limit 72 characters>
<bulleted list of detailed changes>
<non bulleted optional human readable context paragraph - only needed if additional context is helpful; included more often than excluded>
```

The summary should be in present tense and in terms of what the commit does like "Adds feature X" or "Fixes bug Y"
The commit should be read as "What it does when applied" rather than "What was done".

Verify the commit with the user before finalizing it.

If there is a bulleted list and a context paragraph, separate them with a blank line.

## Cross-Repo/Org References

Never name or link to another repository, project, or organization — one other than the
one this commit is in — anywhere in the commit message, unless the user has explicitly
said to include it in this conversation. If a cross-reference seems useful, ask before
adding it — do not add it on your own judgment, even as an illustrative example.

## Repository Templates

- When creating a pull request or issue, always read the repo's actual template file (e.g. `.github/PULL_REQUEST_TEMPLATE.md`, `.github/ISSUE_TEMPLATE/`) before writing it.
- Never depend on conversation history, memory, or past examples to decide how a pull request or issue should be formatted. Templates change; re-read the current file every time.
- If the repo has no template, do not invent one from memory of other repos' templates. Use this fallback pull request template instead:

```markdown
## Why

<!-- Explain the motivation for this change. -->

## Connects

<!-- Add the GitHub issue link, for example: https://github.com/henderjon/php-oidc/issues/123 -->

## Changes

<!-- List the changes clearly and briefly. -->
-
```
