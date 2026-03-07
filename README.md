# Ben Orenstein's dot files

These are config files to set up a system the way I like it.

Vim users will likely find useful stuff in my [vimrc](vimrc) and snippets under [vim/UltiSnips](vim/UltiSnips).

I'm also a pretty aggressive aliaser. You might find a few you like in [zsh/aliases](zsh/aliases).

## Installation

```bash
git clone https://github.com/r00k/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
rake install
```

`rake install` is idempotent and handles linking dotfiles/config paths, installing Vundle, initializing git submodules, and bootstrapping core tools (mise/Homebrew packages).

Vim plugins are managed via Vundle (`VundleVim/Vundle.vim`). After install, run `:PluginInstall` in vim.

## More

You can [follow me on Twitter](https://twitter.com/r00k).
