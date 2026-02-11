# Release Notes Generator

Generate comprehensive release notes by comparing two git branches following the established release notes format.

## Usage

```
/release-notes [base-branch] [compare-branch]
```

**Examples:**
- `/release-notes release/4.28.1 release/4.28.2`
- `/release-notes dev release/4.29.0`

If no arguments provided, compares current branch against `dev`.

## Instructions

When this skill is invoked, follow these steps to generate release notes:

### 1. Gather Git Information

Run these commands in parallel:
- `git log [base]..[compare] --merges --pretty=format:"%H %an %s"` - Get merge commits only with authors
- `git rev-parse [compare]` - Get the release ref
- `git diff [base]...[compare] --stat` - Get file change statistics
- `git rev-parse --abbrev-ref HEAD` - Get current branch name

**IMPORTANT:** Only merge commits should be listed in the final Commits section. Use the `--merges` flag to filter.

### 2. Analyze Configuration Changes

Run:
- `git diff [base]...[compare] -- conf/config.template.ini`

Extract any new or modified configuration sections. Include:
- Section name in brackets (e.g., `[section_title]`)
- List of changed settings with example values
- Code block showing the configuration snippet

If no changes, state "- none"

### 3. Analyze Database Changes

Run:
- `git diff [base]...[compare] --name-only -- server/sql/` - Get list of changed SQL files
- `git diff [base]...[compare] -- server/sql/` - Get full diff to understand changes

**IMPORTANT:** If there are database changes, you MUST include:
1. A summary description of what each script does
2. The relative file path to each SQL script (from repo root)

Format:
```
  - Description of change
    - `server/sql/047_retire_old_placement_tables.sql`
  - Description of another change
    - `server/sql/account_indexes/001_alter_table_accounts_add_index.sql`
```

Summarize:
- New migration files and their purposes
- Table alterations, indexes, or schema changes
- Any table renames or deprecations

If no changes, state "- none"

### 4. Analyze Dependency Changes

Run:
- `git diff [base]...[compare] -- composer.lock | grep -A 2 -B 2 '"name"' | head -100`
- `git diff [base]...[compare] -- package.json`

Extract version changes for:
- PHP dependencies (from composer.lock)
- Node/npm dependencies (from package.json)
- Format as: `PackageName old-version → new-version`

Only include notable changes (PHPUnit, static analysis tools, major libraries). Skip patch-level updates of minor dependencies.

### 5. Categorize Commits by Type

Organize merge commits from the commit list into these categories:

**Next UI Features** - PRs with NXLIB- tickets for new Next UI functionality
**Regulatory Compliance** - Legal, compliance, content filtering features
**Bug Fixes** - PRs fixing defects (look for "fix" in title or NXLIB- fix tickets)
**Code Quality** - Refactoring, type improvements, baseline updates, test additions
**Infrastructure & Tooling** - CI/CD, build tools, deployment, configuration
**Markdown Rendering** / **[Domain-Specific]** - Group related commits by technical domain

Format for each category:
```
  - #PRNUM - Description (TICKET-ID if present)
    - Sub-bullets for multi-part changes
```

### 6. Generate Release Notes Document

Create a markdown file at `local/[version]-release-notes.md` following this template:

```markdown

Please deploy [branch] to $destination

Branch: [branch-name].

Ref: [short-ref]

## Config Changes

[Configuration changes or "- none"]

## Database Changes

[If changes exist, list descriptions with file paths]
[Example format:]
  - Retired old tables by renaming with underscore prefix
    - `path/to/file.sql`
  - Added index for improved status joins
    - `path/to/file.sql`

[If no changes, state "- none"]

## Dependency Changes

[Dependency version changes]

## Other Notable Changes

### [Category Name]

  - #PR - Description (TICKET)
    - Additional context
    - Sub-features

### [Next Category]

...

## Commits

[For each merge commit only, format as:]
- Author      (short-hash) [#PR](github-link) Merge commit title
```

### 7. Format Guidelines

**Merge Commit List:**
- **ONLY include merge commits** (obtained using `git log --merges`)
- Extract author's last name (first 10 chars, padded)
- Short hash (10 chars)
- Link PRs: `[#12345](https://github.com/org/repo/pull/12345)`
- Use PR title as-is
- Include "Auto-compiled" merge commits
- Sort alphabetically by author's last name

**Author Formatting (Merge Commits Only):**
```
- Donat        (abc123def4) [#14624](link) Pull Request title
- Henderson    (def456abc7) [#14625](link) Pull Request title
- Roeming      (ghi789jkl0) [#14626](link) Pull Request title
- robot        (mno012pqr3) [#12345] Pull Request title
- CICD         (stu345vwx6) Auto-compiled release/4.28.2
```

**PR Number Extraction:**
- Extract from merge commits: "Merge pull request #XXXXX"
- If no PR found, omit the `[#PR](link)` portion

**Notable Changes Section:**
- Group related PRs together
- Include ticket IDs (NXLIB-XX, etc.) when present
- Use sub-bullets for multi-part features
- Focus on user/developer-facing changes

### 8. Output

After generating the release notes:
1. Write the file to `local/[version]-release-notes.md`
2. Display a summary showing:
   - Total merge commit count
   - Number of PRs
   - Number of files changed
   - Key highlights (3-5 bullet points)

## Notes

- Always use `git diff [base]...[compare]` (three dots) for showing changes since branches diverged
- Always use `git log [base]..[compare] --merges` (two dots, with --merges flag) for merge commits only
- **Only list merge commits in the Commits section** - individual commits are too granular for release notes
- Respect the established formatting patterns exactly
- Preserve the tone and style of existing release notes
- Default base branch is the project's main development branch (`dev` for most projects)
- Skip mentioning trivial changes like whitespace fixes or typo corrections in the Notable Changes section
- When in doubt about categorization, prefer "Code Quality" or "Bug Fixes"
