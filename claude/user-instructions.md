# User Instructions

## Preferences

- Use uv for Python projects and package management
- Always use mise for runtime management (Ruby, Node, etc.)
- Follow existing code conventions in each project
- Be concise and direct in responses

## Claude Code Configuration

When editing files in ~/.claude as the working directory, /commit skill won't work because it runs from cwd (which isn't a git repo). Use Bash with explicit `cd /Users/ben/.dotfiles && git ...` instead.
