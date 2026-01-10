---
description: Run tests, commit (fast), and push - all in background. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes

Execute the following workflow to ship the current changes:

### Step 1: Start Both Tasks in Parallel

Launch both of these simultaneously in a single response:

1. **Tests in background**: Run tests using Bash with `run_in_background: true`
   - Detect test runner: `package.json` (npm test), `pyproject.toml` (uv run pytest), `Cargo.toml` (cargo test), `go.mod` (go test ./...), `Rakefile` (rake test), `.rspec` (rspec), `Makefile` (make test)

2. **Commit in background**: Spawn a Task with `model: haiku` and `run_in_background: true`
   - The agent should: check git status, git diff, write a concise commit message, stage files, and commit

After launching both, tell the user you're waiting for results.

### Step 2: Wait for Notifications (DO NOT use TaskOutput)

**IMPORTANT**: Do NOT use TaskOutput to check on the background tasks. Just wait for the `<task-notification>` to arrive automatically. This avoids duplicate notifications.

When you receive the test notification:
- If tests **pass**: Check that commit finished (use TaskOutput only for commit), then `git push`
- If tests **fail**:
  1. Show the failure output to the user
  2. Immediately attempt to fix using Task tool with `model: opus`
  3. The fixing agent should: analyze failures, make targeted fixes, re-run tests to verify
  4. If fixes succeed, amend the commit and push
  5. If fixes fail after 2 attempts, stop and ask for user help

### Important Notes

- Both tasks run in background concurrently
- Only use TaskOutput for the commit task, never for tests (to avoid duplicate notifications)
- For fixing test failures, use opus model for thorough analysis
- **The working tree must be clean when done** - no uncommitted or untracked files. Everything should be committed and pushed.
