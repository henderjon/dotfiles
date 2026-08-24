---
name: release-notes
description: Generate comprehensive release notes by comparing two git branches following a standardized release notes format.
---

# Release Notes Generator

Generate comprehensive release notes by comparing two git branches following a standardized release notes format.

## Usage

```
/release-notes [base-branch] [compare-branch]
```

**Examples:**
- `/release-notes release/1.2.0 release/1.2.1`
- `/release-notes main release/1.3.0`

If no arguments provided, compares current branch against the main development branch.

## Instructions

When this skill is invoked, follow these steps to generate release notes:

### 1. Detect Repository Information

First, extract repository information from git:
- `git remote get-url origin` - Get the remote repository URL
- Parse the URL to extract the GitHub owner and repository name
  - For SSH: `git@github.com:owner/repo.git` → owner: `owner`, repo: `repo`
  - For HTTPS: `https://github.com/owner/repo.git` → owner: `owner`, repo: `repo`
- `git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'` - Detect the main development branch (fallback to `main` or `master` if not set)
- Store these values to use throughout the release notes generation (for PR links, etc.)

### 2. Gather Git Information

Run these commands in parallel:
- `git log [base]..[compare] --merges --pretty=format:"%H %an %s"` - Get merge commits only with authors
- `git rev-parse [compare]` - Get the release ref
- `git diff [base]...[compare] --stat` - Get file change statistics
- `git rev-parse --abbrev-ref HEAD` - Get current branch name

**IMPORTANT:** Only merge commits should be listed in the final Commits section. Use the `--merges` flag to filter.

**PR Title Extraction:**
For each PR number extracted from merge commits, fetch the actual PR title using:
- `gh pr view [PR_NUMBER] --json title --jq '.title'`

Store these PR titles to use in the Commits section instead of the merge commit messages.

### 3. Capture the Verified PR List

Run the script bundled with this skill (resolve the path against this skill's base directory, given in the invocation context as "Base directory for this skill"):
- `[skill-base-dir]/scripts/git-pr-list-md.sh [base] [compare]`

The script auto-detects the GitHub owner/repo from `git remote get-url origin`, so it works in any repository without edits.

Capture its stdout verbatim. This script independently lists merged PRs between two refs — treat its output as a verification cross-check against the Commits section built from the merge-commit and PR-title data gathered elsewhere in this skill, not as raw material to rewrite or reformat.

**IMPORTANT:** Do not edit, re-sort, re-format, or summarize this output in any way. Paste it into the final document byte-for-byte, inside a fenced code block, exactly as printed to stdout (excluding any `>&2` diagnostic lines the command prints to stderr, such as "Comparing releases:").

### 4. Analyze Configuration Changes

If this project keeps a checked-in configuration template or example file (common patterns: `config.template.*`, `.env.example`, `settings.example.*`, `config/*.dist.*`), diff it:
- `git diff [base]...[compare] -- <config-template-path>`

If you are not sure such a file exists, check `git diff [base]...[compare] --stat` from step 2 for a plausibly-named config file before skipping this section.

Extract any new or modified configuration sections. Include:
- Section/key name
- List of changed settings with example values
- Code block showing the configuration snippet
- Use present tense for descriptions (e.g., "Adds new configuration", not "Added new configuration")

**Categorize into change types:**
- **Adds:** New configuration settings being introduced
- **Changes:** Existing configuration settings being modified (value changes, renamed keys, etc.)
- **Removes:** Configuration settings being removed or deprecated

If no changes for a category, state "- none" under that category's section. If the project has no config template file at all, state "- none" for the whole Config Changes section rather than guessing.

### 5. Analyze Database Changes

If this project keeps versioned database migration scripts (common locations: `migrations/`, `db/migrate/`, `sql/`, `database/migrations/`), run:
- `git diff [base]...[compare] --name-only -- <migrations-path>` - Get list of changed migration files
- `git diff [base]...[compare] -- <migrations-path>` - Get full diff to understand changes

**IMPORTANT:** If there are database changes, you MUST include:
1. A summary description of what each script does (use present tense)
2. The relative file path to each migration script (from repo root)

Format:
```
  - Description of change (use present tense: "Retires" not "Retired")
    - `migrations/047_retire_old_placement_tables.sql`
  - Description of another change (use present tense: "Adds" not "Added")
    - `migrations/account_indexes/001_alter_table_accounts_add_index.sql`
```

**Categorize into deployment phases:**
- **Pre-Deploy:** Database changes that must run before code deployment (rare, usually schema preparations)
- **Time-Sensitive:** Database migrations that run as part of deployment (most DB changes go here - table creation, column additions, indexes)
- **Post-Deploy:** Database changes that must run after deployment is complete (data migrations, cleanup scripts)

Summarize:
- New migration files and their purposes
- Table alterations, indexes, or schema changes
- Any table renames or deprecations

**IMPORTANT:** Use present tense for all descriptions (e.g., "Creates table", "Adds column", "Renames index")

If no changes for a phase, state "- none" under that phase's Database Changes section. If the project has no migrations directory at all, state "- none" for the whole Database Changes section rather than guessing.

### 6. Analyze Dependency Changes

Run whichever of these apply to the project's stack:
- `git diff [base]...[compare] -- <lockfile>` (e.g. `composer.lock`, `package-lock.json`, `yarn.lock`, `poetry.lock`, `Gemfile.lock`, `go.sum`) — filter to lines showing package name/version
- `git diff [base]...[compare] -- <manifest>` (e.g. `composer.json`, `package.json`, `pyproject.toml`, `Gemfile`, `go.mod`)

Extract version changes and format as: `PackageName old-version → new-version`

Only include notable changes (test frameworks, static analysis tools, major libraries, anything with a breaking-change note). Skip patch-level updates of minor dependencies.

### 7. Categorize Commits by Type

Organize merge commits from the commit list into categories that fit this specific project's domain. Common starting categories, adjust names/groupings to match what the diff actually contains:

**Features** - PRs adding new functionality
**Bug Fixes** - PRs fixing defects (look for "fix" in title or linked bug tickets)
**Code Quality** - Refactoring, type improvements, baseline updates, test additions
**Infrastructure & Tooling** - CI/CD, build tools, deployment, configuration
**Documentation** - README, docs, comments
**[Domain-Specific]** - Group related commits by technical domain when a project has one that recurs often (e.g. a rendering engine, a compliance module, a payments pipeline)

Format for each category:
```
  - #PRNUM - Description (ticket ID if present)
    - Sub-bullets for multi-part changes
```

### 8. Generate Release Notes Document

Create `release-notes/` first if it does not exist (`mkdir -p release-notes`) — never write this file to
the project root. Create a markdown file at `release-notes/[version]-release-notes.md` following
this template:

```markdown
Branch: [branch-name].

Ref: [short-ref]

## Config Changes

### Adds

[New configuration settings using PRESENT TENSE, or "- none"]
[Example: Adds `target_link_uri` configuration for dynamic launch URLs]

### Changes

[Modified configuration settings using PRESENT TENSE, or "- none"]
[Example: Changes `cache_ttl` from 300 to 600 seconds]

### Removes

[Removed/deprecated configuration settings using PRESENT TENSE, or "- none"]
[Example: Removes deprecated `old_api_endpoint` configuration]

---

## Database Changes

### Pre-Deploy

[Database migrations that must run before deployment, or "- none"]

### Time-Sensitive

[Database migrations that run during deployment using PRESENT TENSE]
[Example format:]
  - Retires old placement tables by renaming with underscore prefix
    - `migrations/047_retire_old_placement_tables.sql`
  - Adds index for improved anonymized status joins
    - `migrations/account_indexes/001_alter_table_accounts_add_index.sql`

[If no changes, state "- none"]

### Post-Deploy

[Database migrations or changes that must run after deployment, or "- none"]

---

## ETC

[This section serves as a container for the remaining informational sections below]

### Statistics

- **Merge Commits:** [count] ([PR count] PRs + [automated merge count] automated merges)
- **Files Changed:** [count] files
- **Lines Changed:** +[insertions] insertions, -[deletions] deletions

### Key Highlights

1. **[Highlight 1]** - Brief description
2. **[Highlight 2]** - Brief description
3. **[Highlight 3]** - Brief description
4. **[Highlight 4]** - Brief description
5. **[Highlight 5]** - Brief description

[Include 3-5 key highlights focusing on:
- Major features or functionality (use present tense: "Adds feature" not "Added feature")
- Important bug fixes or security updates (use present tense: "Fixes bug" not "Fixed bug")
- Database schema changes (use present tense: "Creates table" not "Created table")
- Configuration changes (use present tense: "Adds config" not "Added config")
- Significant dependency updates (use present tense: "Updates dependency" not "Updated dependency")
Keep each highlight to 1-2 lines with ticket references where applicable]

### Dependency Changes

[Dependency version changes]

### Other Notable Changes

#### [Category Name]

  - #PR - Description (ticket ID)
    - Additional context
    - Sub-features

#### [Next Category]

...

### Commits

[For each merge commit only, format as:]
- Author      (short-hash) [#PR](github-link) PR title (not merge commit message)

### PR List (git-pr-list-md.sh)

[Exact, unmodified stdout of `scripts/git-pr-list-md.sh [base] [compare]` from step 3, wrapped in its own fenced code block per the Format Guidelines below]
```

### 9. Format Guidelines

**Merge Commit List:**
- **ONLY include merge commits** (obtained using `git log --merges`)
- Extract author's last name (first 10 chars, padded)
- Short hash (10 chars)
- Link PRs using the detected repository: `[#12345](https://github.com/{owner}/{repo}/pull/12345)`
- **Use the actual PR title** (fetched via `gh pr view`), NOT the merge commit message
- Include "Auto-compiled" or other automated merge commits (no PR title for these)
- Sort alphabetically by author's last name

**Author Formatting (Merge Commits Only):**
```
- Donat        (abc123def4) [#14624](link) Actual PR title from GitHub
- Henderson    (def456abc7) [#14625](link) Actual PR title from GitHub
- Roeming      (ghi789jkl0) [#14626](link) Actual PR title from GitHub
- dependabot   (mno012pqr3) [#12345] Actual PR title from GitHub
- Runner       (stu345vwx6) Auto-compiled release/1.2.1
```

**PR Number and Title Extraction:**
- Extract PR number from merge commits: "Merge pull request #XXXXX"
- Fetch actual PR title using: `gh pr view [PR_NUMBER] --json title --jq '.title'`
- If no PR found (e.g., auto-compiled commits), omit the `[#PR](link)` portion

**Statistics Section:**
- Count total merge commits (including automated merges)
- Count PRs (exclude automated merges)
- Get files changed and line changes from `git diff --stat` output
- Format: `- **Label:** value description`

**Key Highlights Section:**
- Create 3-5 numbered highlights summarizing the most important changes
- Focus on high-impact items: major features, important fixes, schema changes, config updates
- Include ticket references where applicable
- Keep each highlight to 1-2 lines for scannability
- Order by importance/impact
- Use present tense for consistency (e.g., "Adds feature", not "Added feature")

**Notable Changes Section:**
- Group related PRs together
- Include ticket IDs when present
- Use sub-bullets for multi-part features
- Focus on user/developer-facing changes

**PR List (git-pr-list-md.sh) Section:**
- Wrap the captured stdout from step 3 in a fenced code block (` ``` `) so it renders as literal text
- Do not touch its contents in any way - no reformatting, re-sorting, re-wrapping, or fixing perceived mistakes. If it looks wrong, that is a signal to fix the bundled `scripts/git-pr-list-md.sh` script itself, not to paper over it here
- Exclude stderr diagnostic lines (e.g. "Comparing releases:", "From:", "To:") if the command was run with no arguments and printed them - only the stdout PR list lines belong in the block

### 10. Output

After generating the release notes:
1. Write the file to `release-notes/[version]-release-notes.md` including:
   - Statistics section with merge commit count, PR count, files changed, and line changes
   - Key Highlights section with 3-5 major points about the release
   - All other sections as defined in the template
2. Display a brief confirmation message showing:
   - Release version
   - Repository (owner/repo)
   - Total merge commit count
   - Number of files changed

## Notes

- Always use `git diff [base]...[compare]` (three dots) for showing changes since branches diverged
- Always use `git log [base]..[compare] --merges` (two dots, with --merges flag) for merge commits only
- **Only list merge commits in the Commits section** - individual commits are too granular for release notes
- **Use actual PR titles, not merge commit messages** - Fetch titles via `gh pr view` for better readability
- **Use present tense for all descriptions** - Write "Adds feature", "Creates table", "Changes configuration" instead of past tense ("Added", "Created", "Changed"). This is especially important for Config Changes and Database Changes sections
- **Organize config changes by change type:**
  - **Adds:** New configuration settings
  - **Changes:** Modified configuration settings
  - **Removes:** Deprecated/removed configuration settings
- **Organize database changes under Database Changes (H2) by deployment phase (H3):**
  - **Pre-Deploy:** Database changes required before code deployment (rare, schema preparations)
  - **Time-Sensitive:** Database migrations during deployment (most DB changes - default placement)
  - **Post-Deploy:** Database changes after deployment (data migrations, cleanup)
  - When in doubt, place DB changes in Time-Sensitive
- Respect the established formatting patterns exactly
- Preserve the tone and style of existing release notes in this repo, if any exist
- Default base branch is automatically detected from `git symbolic-ref refs/remotes/origin/HEAD` (typically `main`, `master`, or `develop`)
- PR links are dynamically generated using the repository owner and name extracted from `git remote get-url origin`
- Skip mentioning trivial changes like whitespace fixes or typo corrections in the Notable Changes section
- When in doubt about categorization, prefer "Code Quality" or "Bug Fixes"
- The PR List section exists to cross-check the hand-built Commits section against an independent tool (the bundled `scripts/git-pr-list-md.sh`). Include it verbatim even if it disagrees with the Commits section - do not reconcile the two by editing either one
- This skill has no dependency on any particular tech stack, ticket tracker, or config format. Sections 4-6 explicitly ask you to detect what the project actually uses rather than assuming a fixed set of paths.
