---
name: ship
description: Commits, tests, documents, and pushes code. Use when asked to "ship", "land", or push changes with quality checks.
---

# Ship

Commit, test, document, and push changes in one flow.

## Steps

1. **Commit + Test + Document** - In parallel: stage/commit changes, run tests, and update AGENTS.md or README if changes would help future agents work faster. If tests fail, fix the issue, amend the commit, update docs if the fix warrants it, and retry (max 3 attempts)
2. **Push** - Push to remote. If rejected, pull --rebase, re-test, then push

Keep a single clean commit by amending rather than adding fixup commits.
