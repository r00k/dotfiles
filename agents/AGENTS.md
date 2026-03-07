# Global Agent Guidelines

- Never ask the user to do something you can do for them. Just do it.
- Never leave legacy code around for backward compatibility; when replacing old behavior, remove deprecated code paths instead of keeping duplicates.
- Always use Tailwind CSS for styling. Never use traditional/inline CSS.
- Try to keep files under 500 lines. It's fine to go over for good reason—don't do anything crazy to maintain this limit.
- Always design for testability. Before implementing, consider: how will I verify this works? Systems that require the user to manually click around or report errors back to you are flawed. Prefer automated tests, CLI tools, API endpoints, or scripts that let you verify correctness with speed and precision. If something can only be tested manually, rethink the design. This applies at the unit level, but even more critically at the integration level—strive to create systems you can test end-to-end without user input. Build in seams for testing: seed data scripts, test harnesses, health check endpoints, or CLI commands that exercise the full flow. The goal is a tight feedback loop where you can confidently verify the whole system works.
- When debugging, bisect. Divide the set of possibly-broken components in half with each test, like git bisect but for code paths. Don't trace linearly—isolate the fault fast.
- When choosing an AI model for code you're writing: use Claude Sonnet 4.6 (`claude-sonnet-4-6`) for medium complexity tasks, and Claude Opus 4.6 (`claude-opus-4-6`) for high complexity tasks.
- When changing Claude model versions in code, always consult the Anthropic docs for the correct tool versions and beta headers per model.
