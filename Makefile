all: build

sync:
	echo $(DIR)
	[ -f ~/.ackrc ] || ln -s $(PWD)/ackrc ~/.ackrc
	[ -f ~/.agignore ] || ln -s $(DIR)/agignore ~/.agignore
	[ -f ~/.gemrc ] || ln -s $(DIR)/gemrc ~/.gemrc
	[ -f ~/.git_template ] || ln -s $(DIR)/git_template ~/.git_template
	[ -f ~/.gitconfig ] || ln -s $(DIR)/gitconfig ~/.gitconfig
	[ -f ~/.gitignore_global ] || ln -s $(DIR)/gitignore_global ~/.gitignore_global
	[ -f ~/.psqlrc ] || ln -s $(DIR)/psqlrc ~/.psqlrc
	[ -f ~/.tmux.conf ] || ln -s $(DIR)/tmux.conf ~/.tmux.conf
	[ -f ~/.vimrc ] || ln -s $(DIR)/vimrc ~/.vimrc
	[ -f ~/.zsh ] || ln -s $(DIR)/zsh ~/.zsh
	[ -f ~/.zshrc ] || ln -s $(DIR)/zshrc ~/.zshrc
	mkdir ~/.gnupg
	chmod 755 ~/.gnupg
	[ -f ~/.gnupg/gpg.conf ] || ln -s $(DIR)/gpg.conf ~/.gnupg/gpg.conf
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(DIR)/gpg-agent.conf ~/.gnupg/gpg-agent.conf


clean:
  rm -f ~/.ackrc
  rm -f ~/.agignore
  rm -f ~/.gemrc
  rm -rf ~/.git_template
  rm -f ~/.gitconfig
  rm -f ~/.gitignore_global
  rm -f ~/.psqlrc
  rm -f ~/.psqlrc
  rm -f ~/.tmux.conf
  rm -f ~/.vimrc
  rm -rf ~/.zsh
  rm -f ~/.zshrc
  rm -rf ~/.gnupg

.PHONY: all clean sync build run kill
