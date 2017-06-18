#!/bin/sh
#
# Description: Setup environment
# Author: Hongbo Liu
# Email: hbliu@freewheel.com
# CreatTime: 2015-10-13 22:21:44 CST

ZSH_BIN="/bin/zsh"
ZGENRC="$HOME/.dotfiles/data/zgen/zgen.zsh"

if [[ -f "$ZSH_BIN" ]]; then
	chsh -s $ZSH_BIN
fi

if which pip &> /dev/zero; then
	if is_osx; then
		pip install powerline-status
	else
		pip install --user powerline-status
	fi
fi

git submodule update --recursive

install_zsh_plugins() {
	source "$ZGENRC"
	zgen update
	~/.dotfiles/link/.zgen/junegunn/fzf-master/install --all
}

install_tmux_plugins() {
	sh -c '$HOME/.tmux/plugins/tpm/bindings/install_plugins'
}

install_zsh_plugins
install_tmux_plugins