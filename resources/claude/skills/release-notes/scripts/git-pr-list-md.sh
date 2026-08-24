#!/usr/bin/env bash

# This script lists all merged pull requests between two commits/branches
# with their actual GitHub PR titles.
#
# Bundled with the release-notes skill so it has no dependency on a
# git-pr-list-md executable existing on PATH. Repository owner/repo is
# auto-detected from `git remote get-url origin`, so this script works
# unmodified in any git repository hosted on GitHub.

# Detect the GitHub owner/repo from the origin remote so PR links are correct
# no matter which repository this script runs in.
remote_url=$(git remote get-url origin 2>/dev/null)
if [[ "$remote_url" =~ github\.com[:/]([^/]+)/([^/.]+)(\.git)?$ ]]; then
    REPO_OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
else
    echo "Error: Could not determine GitHub owner/repo from 'git remote get-url origin'." >&2
    echo "Remote URL was: $remote_url" >&2
    exit 1
fi

if [ $# -eq 0 ]; then
    # No arguments provided - find the latest two release branches
    git fetch --all >&2

    releases_output=$(git branch -r -l 'origin/release/*' | sed 's|origin/||' | sed 's|^[[:space:]]*||' | sort -V -r)
    releases=($releases_output)

    if [ ${#releases[@]} -lt 2 ]; then
        echo "Error: Need at least 2 release branches to compare." >&2
        [ ${#releases[@]} -eq 1 ] && echo "Found only: ${releases[0]}" >&2
        exit 1
    fi

    FROM_REF="origin/${releases[1]}"
    TO_REF="origin/${releases[0]}"

    FROM_SHA=$(git rev-parse --short "$FROM_REF")
    TO_SHA=$(git rev-parse --short "$TO_REF")

    echo "Comparing releases:" >&2
    echo "  From: ${releases[1]} ($FROM_SHA)" >&2
    echo "  To:   ${releases[0]} ($TO_SHA)" >&2
    echo "" >&2
elif [ $# -lt 2 ]; then
    echo "Usage: git-pr-list-md.sh [<from-ref> <to-ref>]" >&2
    echo "Example: git-pr-list-md.sh origin/release/1.0 origin/release/2.0" >&2
    echo "If no arguments provided, compares the latest two release branches." >&2
    exit 1
else
    FROM_REF="$1"
    TO_REF="$2"
fi

# Get list of merge commits
git fetch --all >&2

# Extract PR numbers, author names, and commit hashes from merge commits
git log --merges --format="%an|%h|%s" --grep="pull request" "$FROM_REF..$TO_REF" | \
while IFS='|' read -r author short_ref message; do
    pr_number=$(echo "$message" | grep -oE '#[0-9]+' | sed 's/#//')
    if [ -n "$pr_number" ]; then
        # Extract last name (last word of author name)
        last_name=$(echo "$author" | awk '{print $NF}')
        echo "$last_name|$short_ref|$pr_number"
    fi
done | \
sort -u -t'|' -k3,3n | \
while IFS='|' read -r last_name short_ref pr_number; do
    # Fetch the PR title from GitHub, retrying on transient failures
    pr_title=""
    for attempt in 1 2 3; do
        pr_title=$(gh pr view "$pr_number" --json title --jq '.title' 2>/dev/null)
        [ -n "$pr_title" ] && break
        sleep 1
    done

    if [ -n "$pr_title" ]; then
        printf -- "- %-12s (%-10s) [#%s](https://github.com/%s/%s/pull/%s) %s\n" "$last_name" "$short_ref" "$pr_number" "$REPO_OWNER" "$REPO_NAME" "$pr_number" "$pr_title"
    else
        printf -- "- %-12s %-11s #%-6s (unable to fetch title)\n" "$last_name" "$short_ref" "$pr_number"
    fi
done | \
sort
