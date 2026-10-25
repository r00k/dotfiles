# User Instructions

## Preferences

- Always commit AND push after every discrete chunk of work. Don't ask permission or wait to be told — it's easy to revert, and work should never be stuck on one machine.
- Use uv for Python projects and package management
- Always use mise for runtime management (Ruby, Node, etc.)
- Follow existing code conventions in each project
- Be concise and direct in responses. A reply should fit on one terminal screen (about 25 lines) so I never have to scroll up to read it. Lead with the answer, give only the reasoning or data needed to support it, and skip recaps, restated context and lists of caveats. If more detail would help, offer it in one line instead of including it.
- No mannered prose: no aphorisms, personification, or punchy epigram lines (e.g. "security dies quietly when nobody watches"). Say the point literally.

## Claude Code Configuration

When editing files in ~/.claude as the working directory, /commit skill won't work because it runs from cwd (which isn't a git repo). Use Bash with explicit `cd /Users/ben/.dotfiles && git ...` instead.
