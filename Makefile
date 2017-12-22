DIR := ${CURDIR}
DIR := ~/icloud-drive/dotfiles

all: symlinks install_atom_packages

symlinks:
	echo $(DIR)
	@ln -nsf $(DIR)/ackrc ~/.ackrc
	@ln -nsf $(DIR)/agignore ~/.agignore
	@ln -nsf $(DIR)/atom ~/.atom
	@ln -nsf $(DIR)/gemrc ~/.gemrc
	@ln -nsf $(DIR)/git_template ~/.git_template
	@ln -nsf $(DIR)/gitconfig ~/.gitconfig
	@ln -nsf $(DIR)/gitignore_global ~/.gitignore_global
	@ln -nsf $(DIR)/psqlrc ~/.psqlrc
	@ln -nsf $(DIR)/tmux.conf ~/.tmux.conf
	@ln -nsf $(DIR)/vim ~/.vim
	@ln -nsf $(DIR)/vimrc ~/.vimrc
	@ln -nsf $(DIR)/zsh ~/.zsh
	@ln -nsf $(DIR)/zshrc ~/.zshrc
	@mkdir ~/.gnupg
	@chmod 755 ~/.gnupg
	@ln -nsf $(DIR)/gpg.conf ~/.gnupg/gpg.conf
	@ln -nsf $(DIR)/gpg-agent.conf ~/.gnupg/gpg-agent.conf


install_atom_packages:
	apm install --packages-file $(DIR)/atom/packages.txt

save_atom_packages:
	apm list --installed --bare > $(DIR)/atom/packages.txt
