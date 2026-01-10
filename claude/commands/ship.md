---
description: Run tests, commit (fast), and push - all in background. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes

### Step 1: Launch Background Tasks

In a SINGLE response, launch both:

1. **Tests**: `Bash` with `run_in_background: true`
   - Detect test runner: `package.json` (npm test), `pyproject.toml` (uv run pytest), `Cargo.toml` (cargo test), `go.mod` (go test ./...), `Rakefile` (rake test), `.rspec` (rspec), `Makefile` (make test)

2. **Commit**: `Task` with `model: haiku` and `run_in_background: true`
   - Agent should: git status, git diff, write commit message, stage files, commit

Then output "Waiting for tests..." and **STOP. Do not call any more tools. Do not use TaskOutput. Just wait.**

### Step 2: Handle Test Notification

A `<task-notification>` will arrive with test results. Only then continue:

- **Tests pass**: Use TaskOutput to check commit finished, then `git push`
- **Tests fail**:
  1. Show failure output
  2. Fix with `Task` using `model: opus`
  3. Re-run tests to verify
  4. If fixed, amend commit and push
  5. If still failing after 2 attempts, ask user for help

### CRITICAL

- **NEVER use TaskOutput to check on tests** - wait for the notification
- Working tree must be clean when done (nothing uncommitted/untracked)
