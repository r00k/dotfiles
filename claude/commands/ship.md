---
description: Run tests, commit, and push. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes (Fast Mode)

### Step 1: Gather Info (Parallel)

Run ALL of these in a SINGLE response using parallel Bash calls:

```bash
# Call 1: Status check
git status --porcelain && git status --short --branch

# Call 2: Diff for commit message
git diff HEAD && git diff --cached

# Call 3: Recent commits for style
git log --oneline -5

# Call 4: Detect and run tests (single command)
if [ -f package.json ] && grep -q '"test"' package.json; then npm test;
elif [ -f pyproject.toml ]; then uv run pytest 2>/dev/null || pytest 2>/dev/null || echo "NO_TESTS";
elif [ -f Cargo.toml ]; then cargo test;
elif [ -f go.mod ]; then go test ./...;
elif [ -f Makefile ] && grep -q '^test:' Makefile; then make test;
elif [ -f .rspec ] || [ -d spec ]; then bundle exec rspec 2>/dev/null || rspec;
elif [ -f Rakefile ] && rake -T 2>/dev/null | grep -q 'rake test'; then rake test;
else echo "NO_TESTS"; fi
```

Run Call 4 (tests) with `run_in_background: true`. Run the others normally.

### Step 2: Early Exit Check

From the status output:
- If working tree is clean AND branch is up to date → output "Nothing to ship." and **STOP**
- Otherwise, continue

### Step 3: Generate Commit Message & Commit

Using the diff and log output you already have, write a commit message:
- One summary line (imperative mood, ~50 chars)
- Optionally 2-4 bullet points if changes are complex
- Match the style from the git log output

Then run:
```bash
git add -A && git commit -m "$(cat <<'EOF'
<your generated message here>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 4: Wait for Tests & Push

Output "Waiting for tests..." and **STOP**.

When `<task-notification>` arrives:

- **Tests pass (or NO_TESTS)**: Run `git push`
- **Tests fail**:
  1. Show failure output
  2. Fix with `Task` using `model: opus`
  3. Re-run tests
  4. If fixed, amend commit and push
  5. If still failing after 2 attempts, ask user

### Step 5: Verify Clean State

ALWAYS run `git status` before finishing. Working tree MUST be clean:
- No unstaged changes
- No untracked files

If dirty: stage and amend, or create additional commit, then push.
