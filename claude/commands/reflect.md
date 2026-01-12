---
description: Analyze conversation for failed commands/approaches, find what worked, and optionally update CLAUDE.md with generalizable learnings (with user approval).
allowed-tools: Read, Edit, Write, Glob, Grep, WebSearch, Bash, Skill, AskUserQuestion
---

## Learn from Mistakes

Review the conversation history to find learning opportunities and document them.

**User guidance:** $ARGUMENTS

If guidance was provided above, use it to direct your analysis. This could be:
- A focus area (e.g., "git issues") - prioritize that topic
- A specific learning to document (e.g., "add a note about using --no-verify")
- General direction on what changes to make to CLAUDE.md

If no guidance was provided, analyze the entire conversation broadly.

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

### Step 3: Research Best Practices

For non-trivial failures, search for how others have solved similar problems:

1. **Web search**: Look for best practices, common solutions, or official documentation
   - Example: "eslint config flat config migration best practices"

2. **GitHub search**: Find real-world examples in popular repos
   - Use `gh search code "pattern" --limit 5` for code examples
   - Use `gh search repos "topic"` for relevant projects

3. **Compare approaches**: Did our workaround align with community best practices, or is there a better way?

Skip this step for simple issues with obvious solutions.

### Step 4: Present Learnings and Ask User

After identifying learnings, **do not automatically update CLAUDE.md**. Instead:

1. Summarize what you found:
   - What failures were identified
   - What learnings were extracted
   - Any best practices discovered via web/GitHub search

2. For each generalizable learning, explain:
   - What would be added to CLAUDE.md
   - Which section it would go in
   - Why it's worth documenting

3. **Ask the user**: "Would you like me to add these learnings to CLAUDE.md?"

### Step 5: Update CLAUDE.md (If Approved)

Only if the user approves:
1. Read the current CLAUDE.md
2. Find the appropriate section (Commands, Preferences, etc.)
3. Add a clear, concise note about:
   - What fails and why
   - What works instead (include best practices found via search if applicable)
4. Keep it actionable - future Claude should know exactly what to do

### Step 6: Commit the Change (If CLAUDE.md Was Updated)

After updating CLAUDE.md:
1. Use the `/commit` skill to commit the CLAUDE.md change
2. The commit message should clearly describe:
   - What learning was added
   - Why it was documented (the failure that led to it)
3. This should be a separate commit focused only on the CLAUDE.md update

### Output Format

Summarize:
- What failures were found
- What learnings were extracted
- Any best practices discovered via web/GitHub search
- Whether CLAUDE.md was updated (and if so, confirm the commit was made)
