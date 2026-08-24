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
