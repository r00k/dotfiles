# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS. Configuration files are symlinked to the home directory with a dot prefix (e.g., `zshrc` → `~/.zshrc`).

## Installation

```bash
rake install
```

`rake install` is idempotent. It links top-level dotfiles into `~/.<filename>`, links managed config paths (Amp/agents/Claude), installs Vundle, initializes git submodules, and installs core tool dependencies.

## Key Configuration Files

- **zshrc** - Main shell config, sources files from `zsh/` directory
- **vimrc** - Extensive vim configuration using Vundle for plugin management
- **gitconfig** - Git aliases and settings
- **tmux.conf** - tmux with C-a prefix (screen-style), vim keybindings

## Architecture

Shell setup chain: `zshenv` → `zlogin` → `zshrc` → sources `zsh/{aliases,functions,prompt,z}`

Vim plugins are managed via Vundle in `~/.vim/bundle/`. Run `:PluginInstall` in vim after adding plugins to `vimrc`.

## Notable Aliases and Functions

- `g` - git status (no args) or git command passthrough
- `gc <message>` - git commit without needing quotes
- `gad` - git add all
- `gp/gpf` - git push / force push
- `gpr` - git pull --rebase
- `git-sweep` - clean merged branches locally and remotely
- `so` - reload aliases

## Runtime Management

Uses mise (formerly rtx) for Ruby, Node, and other runtimes. Activated in zshrc via `eval "$(mise activate zsh)"`.

Use uv for Python projects and package management.

## Claude Code Configuration

The following are managed by `rake install`:
- `claude/user-instructions.md` → `~/.claude/CLAUDE.md`
- `.claude/settings.json` → `~/.claude/settings.json`
- `.claude/settings.local.json` → `~/.claude/settings.local.json`

The `claude/` directory in this repo intentionally stores portable config content only (currently `user-instructions.md`). Runtime/session artifacts should stay in `~/.claude`, not in git.

When editing these files from `~/.claude` as the working directory, the `/commit` skill won't work because it runs from cwd (which isn't a git repo). Use Bash with explicit `cd /Users/ben/.dotfiles && git ...` instead.
