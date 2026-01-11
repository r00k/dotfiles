# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS. Configuration files are symlinked to the home directory with a dot prefix (e.g., `zshrc` → `~/.zshrc`).

## Installation

```bash
rake install
```

This symlinks all config files to `~/.<filename>`, installs Vundle for vim plugins, z for directory jumping, and mise for runtime management.

## Key Configuration Files

- **zshrc** - Main shell config, sources files from `zsh/` directory
- **vimrc** - Extensive vim configuration using Vundle for plugin management
- **gitconfig** - Git aliases and settings
- **tmux.conf** - tmux with C-a prefix (screen-style), vim keybindings

## Architecture

Shell setup chain: `zshenv` → `zlogin` → `zshrc` → sources `zsh/{aliases,functions,prompt,z}`

Vim plugins managed via Vundle in `~/.vim/bundle/`. Run `:PluginInstall` in vim after adding plugins to vimrc.

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

## Working from ~/.claude

The `~/.claude/commands` directory symlinks to `claude/commands/` in this repo. When editing these files from `~/.claude` as the working directory, the `/commit` skill won't work because it runs from cwd (which isn't a git repo). Use Bash with explicit `cd /Users/ben/.dotfiles && git ...` instead.
