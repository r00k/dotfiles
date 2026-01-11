---
description: Analyze conversation for failed commands/approaches, find what worked, and update CLAUDE.md with generalizable learnings.
allowed-tools: Read, Edit, Write, Glob, Grep
---

## Learn from Mistakes

Review the conversation history to find learning opportunities and document them.

### Step 1: Identify Failures and Fixes

Look through the conversation for:
1. **Failed commands**: Commands that returned errors or didn't work as expected
2. **Failed approaches**: Code or strategies that had to be revised
3. **Successful workarounds**: What ultimately worked after the failure

### Step 2: Analyze Root Causes

For each failure/fix pair:
1. What was the actual root cause of the failure?
2. Is this a generalizable lesson (would apply to future work)?
3. Is this specific to this project, or universal?

Skip anything that was just a typo or one-off mistake.

### Step 3: Update CLAUDE.md

For generalizable learnings:
1. Read the current CLAUDE.md
2. Find the appropriate section (Commands, Preferences, etc.)
3. Add a clear, concise note about:
   - What fails and why
   - What works instead
4. Keep it actionable - future Claude should know exactly what to do

### Output Format

After updating, summarize:
- What failures were found
- What learnings were extracted
- What was added to CLAUDE.md (or why nothing was added)
