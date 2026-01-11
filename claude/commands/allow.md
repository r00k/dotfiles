---
description: Find recent permission prompts and configure permanent access for those commands.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

## Auto-Allow Permissions

Review conversation history to find permission prompts and eliminate future friction.

### Step 1: Identify Permission Prompts

Look through recent conversation for:
1. Commands that required manual approval (user had to press enter/y)
2. Tool uses that were blocked or required confirmation
3. Especially commands with no "always allow" option in the UI (like `pkill`, `kill`, etc.)

### Step 2: Determine Solution

For each permission prompt found, determine the best approach:

**Option A: Update settings.json**
- Add to `~/.claude/settings.json` under `permissions.allow`
- Use patterns like `Bash(pkill:*)` or `Bash(kill:*)`
- Best for: commands that can be safely always-allowed

**Option B: Create a wrapper script**
- Create a script in `~/.claude/scripts/` that wraps the command
- Add permission for that specific script
- Best for: dangerous commands that need guardrails

**Option C: Add to project-level settings**
- Update `.claude/settings.json` in the project
- Best for: project-specific commands

### Step 3: Implement

1. Read current `~/.claude/settings.json`
2. Show the user what was found and proposed solution
3. After user confirms, apply the changes
4. Explain what was changed and why

### Output Format

```
Found N permission prompts:

1. `pkill node` - No always-allow option
   → Propose: Add `Bash(pkill:*)` to settings.json

2. ...

Recommended changes:
- [list changes]

Apply these changes? (waiting for confirmation)
```

### Notes

- Be conservative - don't auto-allow dangerous commands without user review
- Prefer narrow patterns (`Bash(pkill node:*)`) over broad ones (`Bash(pkill:*)`) when sensible
- If a command is genuinely dangerous (rm -rf, etc.), suggest a wrapper script with safeguards instead
