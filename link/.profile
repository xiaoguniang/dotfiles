# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then     
	. "$HOME/.bashrc"
    fi
fi

export HOME_BIN="$HOME/bin"

if [[ -d $HOME_BIN ]]; then
	export PATH=$PATH:$HOME_BIN
fi
export __PROFILE=".profile Loaded"

[[ -s "/Users/hbliu/.gvm/scripts/gvm" ]] && source "/Users/hbliu/.gvm/scripts/gvm"

export PATH="$HOME/.cargo/bin:$PATH"
