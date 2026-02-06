---
name: wip-commit
description: Commit all staged changes with a WIP message.
allowed-tools: Bash(git commit:*),Bash(git status:*)
---

# commit-staged

Inspect the currently staged changes with git status.

Commit currently staged changes with a commit message.

## Commit Message Guidelines

- Max line length 120 characters.
- Write in very terse Hemingway style.
- Avoid jargon.
- Avoid contractions.
- Avoid conjunctions.
- Use simple words.
- Be direct.
- Don't mention Claude.
- Do not include co-author credits in commit messages.
- Avoid under-specific messages like "Update code" or "Fix bug" or "Refactors X". Be specific about what was changed and why.

### Commit Message Format

Format the commit message as follows:

```
WIP; <summary of changes - soft limit 50 characters, hard limit 72 characters>
<bulleted list of detailed changes>
<non bulleted optional human readable context paragraph - only needed if additional context is helpful; included more often than excluded>
```

The summary MUST start with "WIP" verbatim to signify that this commit is a work in progress commit.

The summary should be in present tense and in terms of what the commit does like "Adds feature X" or "Fixes bug Y"
The commit should be read as "What it does when applied" rather than "What was done".

Verify the commit with the user before finalizing it.

If there is a bulleted list and a context paragraph, separate them with a blank line.

