# Global Agent Config

## Missing Tools

If a command fails because a tool isn't found (e.g., `psql`, `railway`, `gh`), install it using Homebrew (`brew install <tool>`) rather than asking the user to do it.

## Agency

Never instruct the user to do something you can do yourself.

## Code Quality

Don't keep unused code around.

## Testing

Avoid trivial tests. Strive to write code that is easily tested. If you're struggling to test something, consider refactoring the code under test.
