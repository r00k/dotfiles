---
description: Run tests, commit (fast), and push - all in background. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes

Execute the following workflow to ship the current changes:

### Step 1: Start Commit in Background (Use Haiku for Speed)

Immediately spawn a background Task with `model: haiku` and `run_in_background: true` to create a commit:
- The agent should: check git status, git diff, write a concise commit message, stage files, and commit
- This runs concurrently while tests run in foreground

### Step 2: Detect and Run Tests in Foreground

Detect how tests are run in this repository by checking for:
- `package.json` with test script (use `npm test` or `yarn test`)
- `Makefile` with test target
- `pyproject.toml` with uv or Python test files (use `uv run pytest`)
- `pytest.ini`, `setup.py`, or Python test files without uv (use `pytest`)
- `Cargo.toml` (use `cargo test`)
- `go.mod` (use `go test ./...`)
- `Rakefile` with test task (use `rake test`)
- `.rspec` or `spec/` directory (use `rspec`)

Run the tests in the foreground (not background) so you get the results directly.

### Step 3: Handle Results

- If tests **pass**: Wait for the background commit to finish (check TaskOutput), then push with `git push`
- If tests **fail**:
  1. Show the test failure output to the user
  2. Immediately attempt to fix the failing tests using the Task tool with `model: opus` (Opus 4.5 for complex reasoning)
  3. The fixing agent should: analyze failures, make targeted fixes, re-run tests to verify
  4. If fixes succeed, amend the commit (wait for background commit first) and push
  5. If fixes fail after 2 attempts, stop and ask for user help

### Important Notes

- Commit runs in background (haiku, fast) while tests run in foreground
- This avoids duplicate notifications from background test completion
- For fixing test failures, use opus model for thorough analysis
