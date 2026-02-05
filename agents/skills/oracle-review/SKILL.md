---
name: oracle-review
description: "Reviews the most recent commit using Oracle for high-confidence issues. Use when asked to 'oracle review', 'review commit', or 'check my changes'."
---

# Oracle Review

Reviews the most recent commit, identifies significant high-confidence issues, and suggests fixes (but waits for user approval before implementing).

## Workflow

1. Run `git show --stat HEAD` to identify changed files
2. Run `git show HEAD` to get the full diff
3. Use the `handoff` tool with:
   - `follow: true`
   - Goal: Ask the Oracle to review the commit diff, identify only **high-confidence, significant issues** (not style nits), and fix them directly

## Handoff Goal Template

```
Review the most recent git commit and fix any significant issues.

1. Run `git show HEAD` to see the full diff
2. Use the Oracle tool to review the changes, focusing on:
   - Bugs and logic errors
   - Security issues
   - Missing error handling
   - Breaking API changes
   - Performance problems

3. Only report issues the Oracle is highly confident about
4. Ignore style preferences, minor naming suggestions, or "nice to haves"
5. Present the issues with suggested fixes, but ASK the user before implementing any changes
6. After user approves fixes, run the project's lint/typecheck commands to verify
```
