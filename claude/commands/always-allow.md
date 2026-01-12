---
description: Add the most recent permission prompt to allowed commands for all Claude sessions.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

## Always Allow Recent Command

Automatically add the most recently approved tool use to the global allow list.

### Step 1: Find Recent Permission

Look through the current conversation for the most recent tool use that required manual approval (user pressed enter/y).

Extract the tool and its parameters.

### Step 2: Generalize the Permission

Convert to a generalized permission pattern based on tool type:

**Bash commands** - use first-word wildcard:
- `uv run pytest` → `Bash(uv:*)`
- `docker compose up` → `Bash(docker:*)`

**Other tools** - allow the tool entirely:
- WebSearch → `WebSearch`
- Task (Explore) → `Task`
- WebFetch → `WebFetch`

### Step 3: Safety Check

Before adding, briefly evaluate if the permission is dangerous. Consider:
- Could this delete/modify important files? (rm, chmod, chown)
- Could this affect system stability? (kill, pkill, shutdown)
- Could this expose secrets or sensitive data?
- Could this make network changes or send data externally?

If the command is potentially dangerous, warn the user and ask for confirmation before proceeding. For benign tools (build tools, linters, version managers, etc.), proceed without extra confirmation.

### Step 4: Add to Settings

1. Read `~/.claude/settings.json`
2. Add the new permission to `permissions.allow` array (if not already present)
3. Write the updated file
4. Confirm what was added

### Output Format

For safe commands:
```
Found: `uv run pytest` (Bash)
Adding: `Bash(uv:*)`

Updated ~/.claude/settings.json
```

For potentially dangerous commands:
```
Found: `rm -rf dist` (Bash)
Would add: `Bash(rm:*)`

⚠️  This allows all `rm` commands, which can delete files. Are you sure?
```

### Notes

- For Bash, uses first-word wildcard for flexibility
- For other tools, allows the entire tool
- Adds to ~/.claude/settings.json which applies to ALL Claude sessions
- If the permission already exists, report that and make no changes
