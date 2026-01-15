---
description: Run tests, commit, and push. Auto-fixes test failures.
allowed-tools: Bash, Task, Read, Edit, Write, Glob, Grep, TodoWrite
---

## Ship Changes (Fast Mode)

### Step 1: Gather Info (Parallel)

Run ALL of these in a SINGLE response using parallel Bash calls:

```bash
# Call 1: Status and branch check
git status --porcelain && git status --short --branch

# Call 2: Diff for commit message
git diff HEAD && git diff --cached

# Call 3: Recent commits for style
git log --oneline -5

# Call 4: Get current branch and main branch name
git rev-parse --abbrev-ref HEAD && git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main"
```

### Step 2: Early Exit Check

From the status output:
- If working tree is clean AND branch is up to date AND on main branch → output "Nothing to ship." and **STOP**
- Otherwise, continue

### Step 3: Commit Local Changes (if any)

If there are uncommitted changes, commit them first:

Use the `Task` tool with `model: haiku` to generate a commit message:
- Pass the diff and recent commit log to the task
- Request: one summary line (imperative mood, ~50 chars), optionally 2-4 bullets if complex
- Ask it to match the style from the git log output
- Have it return ONLY the commit message text

Then run:
```bash
git add -A && git commit -m "$(cat <<'EOF'
<haiku's generated message here>

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### Step 4: Rebase onto Main (if on feature branch)

If NOT on the main branch:

1. Fetch latest main:
   ```bash
   git fetch origin main
   ```

2. Rebase onto main:
   ```bash
   git rebase origin/main
   ```

3. If conflicts occur:
   - Resolve each conflict by editing the files
   - After resolving, run `git add <resolved-files> && git rebase --continue`
   - Repeat until rebase completes
   - If a conflict is too complex to resolve automatically, ask the user

### Step 5: Run Tests

Now run tests (after rebase if applicable):

```bash
if [ -f package.json ] && grep -q '"test"' package.json; then npm test;
elif [ -f pyproject.toml ]; then uv run pytest 2>/dev/null || pytest 2>/dev/null || echo "NO_TESTS";
elif [ -f Cargo.toml ]; then cargo test;
elif [ -f go.mod ]; then go test ./...;
elif [ -f Makefile ] && grep -q '^test:' Makefile; then make test;
elif [ -f .rspec ] || [ -d spec ]; then bundle exec rspec 2>/dev/null || rspec;
elif [ -f Rakefile ] && rake -T 2>/dev/null | grep -q 'rake test'; then rake test;
else echo "NO_TESTS"; fi
```

- **Tests pass (or NO_TESTS)**: Continue to Step 6
- **Tests fail**:
  1. Show failure output
  2. Fix with `Task` using `model: opus`
  3. Re-run tests
  4. If fixed, amend commit
  5. If still failing after 2 attempts, ask user

### Step 6: Merge to Main and Push

If on a feature branch:

1. Switch to main and fast-forward merge:
   ```bash
   git checkout main && git merge <feature-branch-name>
   ```

2. Push main:
   ```bash
   git push
   ```

3. Delete the feature branch locally and remotely (if it was pushed):
   ```bash
   git branch -d <feature-branch-name>
   git push origin --delete <feature-branch-name> 2>/dev/null || true
   ```

If already on main:
```bash
git push
```

### Step 7: Update Documentation (if needed)

Check if the changes warrant updates to CLAUDE.md or README:

1. Review what was changed in this session (use the diff from Step 1 or `git diff HEAD~1`)
2. Consider updates if:
   - New commands, aliases, or scripts were added
   - Architecture or file structure changed
   - New dependencies or tools introduced
   - Setup/installation steps changed
   - New features that users/developers should know about

3. If updates are needed:
   - Edit the relevant file(s) directly
   - Keep changes minimal and focused on what's new
   - Match existing style and format
   - Commit with message like "Update docs for <feature>"

4. If no updates needed, continue to Step 8

### Step 8: Verify Clean State

ALWAYS run `git status` before finishing. Working tree MUST be clean:
- No unstaged changes
- No untracked files

If dirty: stage and amend, or create additional commit, then push.
