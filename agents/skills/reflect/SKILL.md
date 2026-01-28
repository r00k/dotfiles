---
name: reflect
description: Analyzes thread history for agent mistakes (failed commands, schema misunderstandings, user confusion) and updates project AGENTS.md to prevent future failures.
---

# Reflect

Review the current thread to identify agent failures and update project documentation to prevent them.

## When to Use

- After completing a task with stumbles
- When the user says "reflect" or asks to learn from mistakes
- Periodically to improve project-specific guidance

## Steps

1. **Analyze Thread History** - Review the conversation for:
   - Failed shell commands (non-zero exit codes, errors)
   - Schema/structure misunderstandings (wrong column names, missing fields, incorrect associations)
   - Misinterpreted user intent (doing the wrong thing, needing clarification)
   - Incorrect assumptions about the codebase (wrong file locations, missing dependencies, outdated patterns)

2. **Extract Learnings** - For each failure, identify:
   - What went wrong
   - What the correct approach was
   - A concise rule or hint that would prevent it

3. **Update AGENTS.md** - Add learnings to the project's AGENTS.md file:
   - Create the file if it doesn't exist
   - Add a `## Learnings` or `## Gotchas` section if not present
   - Write concise, actionable guidance (not verbose explanations)
   - Avoid duplicating information already in the file

## Output Format

After updating, summarize:
- Number of issues found
- What was added to AGENTS.md
- Any issues that couldn't be captured as guidance

## Guidelines

- Be selective: only add learnings that will genuinely help future sessions
- Keep entries concise: one line per learning when possible
- Use specific examples: "Use `bundle exec rspec` not `rspec`" beats "run tests correctly"
- Don't add obvious things the agent should already know
