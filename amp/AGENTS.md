# Global Agent Config

## Papercuts

When you hit small friction while working — missing docs sent you down the wrong path, a command took two tries, a setup step wasn't written down — record it and move on. Don't fix it now, and don't ask permission to record it:

    papercut "ran 'make test' but this repo uses 'script/test'; README doesn't say"

Write one sentence with enough context that a future session could fix it cold. Context (cwd, repo, branch) is captured automatically.

When asked to fix papercuts, run `papercut list` (or `papercut list --here` for the current repo), fix them, and mark each with `papercut done <id> "how it was fixed"`.

## Missing Tools

If a command fails because a tool isn't found (e.g., `psql`, `railway`, `gh`), install it using Homebrew (`brew install <tool>`) rather than asking the user to do it.

## Agency

Never instruct the user to do something you can do yourself.

## Code Quality

Don't keep unused code around.

## File Length

- Aim to keep files under ~500 lines. This is a soft guideline, not a hard rule.
- Don't do anything forced or suboptimal just to hit this target—if a longer file makes more sense, that's fine.

## Testing

Avoid trivial tests. Strive to write code that is easily tested. If you're struggling to test something, consider refactoring the code under test.

## Browser Automation

`agent-browser` is installed globally for headless browser automation. Use it to:
- Navigate to URLs: `agent-browser open <url>`
- Take screenshots: `agent-browser screenshot`
- Get page snapshots (DOM): `agent-browser snapshot`
- Click elements: `agent-browser click "<selector>"`
- Fill inputs: `agent-browser fill "<selector>" "<value>"`
- Get text: `agent-browser text "<selector>"`

Use `--json` for machine-readable output. Run `agent-browser --help` for full command list.
