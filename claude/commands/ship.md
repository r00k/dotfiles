---
description: Run tests, commit (fast), and push - all in background. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes

Execute the following workflow to ship the current changes:

### Step 1: Detect and Run Tests in Background

First, detect how tests are run in this repository by checking for:
- `package.json` with test script (use `npm test` or `yarn test`)
- `Makefile` with test target
- `pyproject.toml` with uv or Python test files (use `uv run pytest`)
- `pytest.ini`, `setup.py`, or Python test files without uv (use `pytest`)
- `Cargo.toml` (use `cargo test`)
- `go.mod` (use `go test ./...`)
- `Rakefile` with test task (use `rake test`)
- `.rspec` or `spec/` directory (use `rspec`)

Run the tests in the background using Bash with `run_in_background: true`.

### Step 2: Commit Changes (Use Haiku for Speed)

While tests run, create a commit for the staged/unstaged changes:
- Use the Task tool with `model: haiku` to spawn an agent that creates a good commit
- The agent should: check git status, git diff, write a concise commit message, stage files, and commit
- This runs concurrently with the tests

### Step 3: Wait for Tests and Handle Results

Check on the background test process:
- If tests **pass**: Push the commit to the remote with `git push`
- If tests **fail**:
  1. Notify the user that tests failed
  2. Show the test output
  3. Immediately attempt to fix the failing tests using the Task tool with `model: opus` (Opus 4.5 for complex reasoning)
  4. The fixing agent should: analyze failures, make targeted fixes, re-run tests to verify
  5. If fixes succeed, amend the commit and push
  6. If fixes fail after 2 attempts, stop and ask for user help

### Important Notes

- Keep the user informed of progress at each step
- For the commit, use haiku model for speed
- For fixing test failures, use opus model for thorough analysis
- All background tasks should be monitored and their output shown when relevant
