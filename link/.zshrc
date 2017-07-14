# gdate "+%s.%N"
export DOTFILES="$HOME/.dotfiles"
export DOTDATA="$HOME/.dotfiles/data"
export DEFAULT_USER=hbliu
export ZGEN_ohmyzsh="$HOME/.zgen/robbyrussell/oh-my-zsh-master"
export GITHUB_DIR="$HOME/github"

# zsh hook 

# helper function# {{{
is_osx() { [[ "$OSTYPE" =~ ^darwin ]] || return 1 }

secureSource() {
	[[ -f "$*" ]] && source "$*"
}

secureAddPath() {
	if [[ ! $PATH =~ "$1" ]]; then
		if [[ "$2" == "start" ]]; then
			export PATH=$1:$PATH
		else
			export PATH=$PATH:$*
		fi
	fi
}

secureAddGoPath() {
	if [[ ! $GOPATH =~ "$1" ]]; then
		if [[ "$2" == "start" ]]; then
			export GOPATH=$1:$GOPATH
		else
			export GOPATH=$GOPATH:$*
		fi
	fi
}

pre_require() {
	local url=$1
	if [[ -z $url ]]; then
		return
	fi
	local root="$HOME/.github"
	local username=$(echo $url | rev | cut -d'/' -f2 | rev)
	local project=$(echo $url | rev | cut -d'/' -f1 | rev)

	local dir="$root/$username"
	if [[ ! -d "$dir/$project" ]]; then
		mkdir -p "$dir" && cd "$dir" && git clone "$url"
	fi

	echo $dir/$project
}
# }}}

# ohmyzsh Options # {{{
export ZSH=$ZGEN_ohmyzsh
MYZSH="$DOTDATA/MyZshData"

# plugins=()

# if you set this to "random", it'll load a random theme each time
ZSH_THEME="robbyrussell"
# ZSH_THEME="arrow"
# ZSH_THEME="agnoster"
# ZSH_THEME="risto"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
export DISABLE_AUTO_UPDATE="true"

# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
TABTITLE_CUSTOM_IGNORE_PATTERN="rmux"
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$DOTDATA/custom.zsh"

# source $ZSH/oh-my-zsh.sh
# }}}

# System Environment # {{{
export EDITOR='nvim'
export LESS="$LESS -FRX"
export TERM="xterm-256color"
if is_osx; then
	export BROWSER="open"
else
	export BROWSER="xdg-open"
fi
export XDG_CONFIG_DIRS="$DOTFILES/config"
# export XDG_CONFIG_HOME="$DOTFILES/config"

secureAddPath "$HOME/bin"
secureAddPath "$HOME/.gem/ruby/2.0.0/bin"
secureAddPath "/usr/local/bin" start
secureAddPath "/usr/local/sbin"
secureAddPath "$HOME/.local/bin" start
secureAddPath /usr/local/Cellar/python/2.7.13/Frameworks/Python.framework/Versions/2.7/bin

# export MANPATH="/usr/local/man:$MANPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Fix tar error info in Linux
export COPYFILE_DISABLE=true

if [[ -f "~/.zsh_local" ]]; then
	source ~/.zsh_local
fi
# }}}

# zgen config # {{{
export ZGENRC="$HOME/.zgenrc"
ZGEN_RESET_ON_CHANGE=($ZGENRC)
source $ZGENRC

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# }}}

# completion# {{{
# autoload -U compinit && compinit -u
# zstyle ':completion:*' rehash true
# zstyle ':completion:*' menu select=2
fpath=($ZSH_CUSTOM $fpath)
# }}}

# ActivePerl# {{{
secureAddPath "$HOME/Library/ActivePerl-5.22/bin"
# }}}

# Project Management # {{{
proj_sig=( _config.yml .proj .git .svn)

p() {
	(wd $1 ; shift 1 ; zsh -i -c "$*")
}

compdef _wd.sh p

compdef fwcd=ssh

pjroot() {
    curdir=$(pwd)
	root=''
	origin_dir=$curdir
	for s in $proj_sig; do
		curdir=$origin_dir
		while [[ $curdir != '/' ]] && [[ ! -e "$curdir/$s" ]]; do
			curdir=$(cd $curdir/..; pwd)
		done
		if [[ -e "$curdir/$s" ]]; then
			root="$curdir"
			break
		fi
	done

    if [[ -d "$root" ]]; then
        echo "$root"
        return 0
    fi

    return 2
}

pcd() {
	if root=$(pjroot); then
		cd $root
	else
		echo "Not a project directory !"
	fi
}
# }}}

# Vim Man support # {{{
vman() {
	vim -c "Man $1 $2" -c 'silent only'
}
# }}}

# ZSH setting# {{{
# autoload section
autoload zmv
alias mmv='noglob zmv -W'
autoload -U zsh-mime-setup
zsh-mime-setup

zle_bracketed_paste=()

ZSH_HIGHLIGHT_MAXLENGTH=300
HISTSIZE=50000

# zstyle ':urlglobber' url-other-schema

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git cvs svn

# stty -ixon
# }}}

# zsh hints# {{{
# zle -N zsh-hints-param zsh-hints
# bindkey "^Xp" zsh-hints-param
# zle -N zsh-hints-paramflags zsh-hints
# bindkey "^Xf" zsh-hints-paramflags
# zle -N zsh-hints-glob zsh-hints
# bindkey "^Xg" zsh-hints-glob
# }}}

# git# {{{
alias gmbase='git merge-base master HEAD'

gbdiff() {
	base_branch=${1:-master}
	git diff `git merge-base $base_branch HEAD`
}

gclcd() {
	git clone --recursive $* && cd "$(ls -t | head -1)"
}

gbdboth() {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 branch # Delete both local and remote branch"
	else
		git branch -d $1 && git branch push :$1
	fi
}

# compdef _git gbdiff=git_branch
alias gbcur='git rev-parse --abbrev-ref HEAD'
DISABLE_UNTRACKED_FILES_DIRTY="true"
# }}}

# vim# {{{
alias vlarge='nvim -n -u NONE -i NONE -N'
if which nvim &> /dev/zero; then
	alias vim='nvim'
fi

vimprofiler() {
	local dir=$(pre_require "https://github.com/bchretien/vim-profiler")
	$dir/vim-profiler.py $*
}
# }}}

# calculator {{{
function = {
  echo "$@" | bc -l
}

alias c='noglob ='
# }}}

# Aliases # {{{
alias ql='qlmanage -p &> /dev/null'
alias -g NF='*(.om[1])'
alias gdb='gdb -q'
alias vtest='vim -u ~/.vimrc_test'
alias bc='bc -lq'
alias d='dirs -v | head -10'
alias bch='bc -lq <<< '
alias wine='env LANG=zh LANG=zh_CN.utf8 wine'
alias texzh='touch main.latexmain && vim main.tex +"TTemplate zharticle"'
alias aphot='sudo nmcli con up id Hiberabyss-AP'
alias cwifi='nmcli con up id '
alias fo='fasd -fi -e xdg-open'
alias vzsh="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
# alias autohide="dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode"
alias mv='mv -i'
alias adsdb='mysql -uads -pads -h'
# alias mysql='mysql --defaults-group-suffix='
alias ycmconf='~/.dotfiles/data/MyVimData/bundle/YCM-Generator/config_gen.py'
alias smux='teamocil 2>/dev/zero'
alias lcd='cd $(ls -t | head -1)'

alias -s pptx="xdg-open &> /dev/zero"
alias -s gz='tar -xzf'
alias -s tgz='tar -xzf'
alias -s tar='tar -xf'
alias -s zip='unzip -q'
alias -s zsh=vim
alias -s bz2='tar -xjf'
alias -s c=vim
alias -s conf=vim
alias -s rc='vim'
alias -s cpp=vim
alias -s h=vim
alias -s txt=vim
alias -s deb="sudo dpkg -i "
if is_osx; then
	alias -s pdf="open &> /dev/zero"
else
	alias getbind='bind -P | grep -v "not bound"'
	alias -s pdf="xdg-open &> /dev/zero"
fi
# }}}

# Key bindings # {{{
# man zshzle
bindkey \^U backward-kill-line # default: kill-whole-line ^x^k
bindkey ^X^H vi-find-prev-char-skip # default: kill-whole-line ^x^k
bindkey ^X^L vi-find-next-char-skip # default: kill-whole-line ^x^k
bindkey ^X\; vi-repeat-find
bindkey ^X, vi-rev-repeat-find
# bindkey \^C capitalize-word # default: kill-whole-line ^x^k

function _copy-to-clipboard {
    print -rn -- $BUFFER | pbcopy
    [ -n "$TMUX" ] && tmux display-message 'Line copied to clipboard!'
}
zle -N _copy-to-clipboard
bindkey "^X^y" _copy-to-clipboard
bindkey "^Xy" _copy-to-clipboard
# }}}

# # Gcc and G++ include path # {{{
# export C_INCLUDE_PATH=~/.local/include:$C_INCLUDE_PATH
# export CPLUS_INCLUDE_PATH=~/.local/include:$CPLUS_INCLUDE_PATH
# # }}}

# Gmock # {{{
if [[ -z "$SSH_CLIENT" ]] && [[ ! "$CPATH" =~ "$HOME/github/CppFreeMock" ]]; then
	export CPATH=$CPATH:$HOME/github/CppFreeMock
fi
secureAddPath "/usr/local/opt/llvm/bin" "start"
# }}}

# Useful functions # {{{
smount() {
	NODE="${1:-dfw32}"
	MNT_DIR="/tmp/$NODE"
	REM_DIR="${2:-/}"

	mkdir -p $MNT_DIR

	if is_osx; then
		diskutil unmount force $MNT_DIR &> /dev/zero
	else
		fusermount -z -u ${MNT_DIR} &> /dev/zero
	fi

	sshfs ${NODE}:${REM_DIR} ${MNT_DIR} -o reconnect

	cd $MNT_DIR
}

pyserver() {
	port=${1:-8080}
	python -m SimpleHTTPServer $port &
	open "http://localhost:$port/$2"
	fg
}

pf() {
	python -c "print $*"
}

nnn() {
	num=$(echo $1 | awk '{print toupper($0)}')
	ibase=${2:-10}
	obase=${3:-16}
	echo "ibase=$ibase;obase=$obase;$num" | bc
}

ckinds() { ctags --list-kinds=$@ }

pdbg() { python -S $DOTDATA/pydbgp/pydbgp $@ localhost:9000 }

pdate() { gdate --date="@$1" +'%F %T %Z'}

# tmux # {{{
rmux() {
    ssh "$@" -t 'bash -l -c ptmux'
}

tcd() {
	cd $(tmux display-message -p -F '#{pane_current_path}' -t'!')
}

# tmuxinator
secureSource "$GITHUB_DIR/tmuxinator/completion/tmuxinator.zsh"

# autoload -U __tmux-sessions
# compdef __tmux-sessions ptmux
# }}}

rscreen() {
	ssh "$@" -t 'screen -rd hbliu'
}

alias clip="nc localhost 8377"

copypath() {
    if is_osx; then
        grealpath -z "$1" | pbcopy
    else
        realpath -z "$1" | xsel -b
    fi
}

swname() {
	tmpname=$(basename $(mktemp -u))
	mv $1 $tmpname
	mv $2 $1
	mv $tmpname $2
}

tproxyoff() {
	unset http_proxy
	unset https_proxy
}


mkbak() {
	cp "$1"{,.bak}
}

mvbak() {
	mv "$1"{,.bak}
}

rmsuf() {
	mv "$1" "${1%.*}"
}

get_realpath() {
	path=$1
	if [[ "${path: -1}" == '/' ]]; then
		path=${path%/}
	fi

	if [[ -e "$path" ]]; then
		if [[ "${path:0:1}" == "/" ]]; then
			echo $path
		else
			echo $(pwd)/$path
		fi
		return 0
	fi
	return 1
}

# }}}

# go settings# {{{
# secureAddPath "$GOPATH/bin"
# }}}

# dash # {{{
dquery() {
	open dash://$1:$2
}

alias djs="dquery js"
alias dmd="dquery md"
alias dcoffee="dquery coffee"
# }}}

# python # {{{
export PYTHONSTARTUP="$HOME/.ipython/pythonrc.py"
# export IPYTHONDIR="$DOTDATA/python"
export IPYTHONDIR="$HOME/.ipython"
unset IPYTHONDIR
# }}}

# vimwiki # {{{
VIMWIKI_DIR="$HOME/vimwiki"

function vwiki() {
	local OPT OPTARG OPTIND
	while getopts 's:' OPT; do
		case $OPT in
			s)
				ack "$OPTARG" $VIMWIKI_DIR
				return 0
				;;
		esac
	done
	shift $(($OPTIND - 1))

	if [[ -z $@ ]]; then
		(vim +VimwikiIndex )
		return 0
	fi
	(vim +"e $VIMWIKI_DIR/$@.wiki") # cd to void ctrlspace autoload
}

# if [[ -d "$VIMWIKI_DIR" ]]; then
compctl -M 'm:{a-zA-Z}={A-Za-z}' -g "$VIMWIKI_DIR/*(:t:r)" vwiki
# fi
# }}}

# Docker # {{{
COMPOSE_FILE="docker-compose.yml:docker-compose.prod.yml"

# export DOCKER_TLS_VERIFY="1"
# export DOCKER_HOST="tcp://192.168.99.100:2376"
# export DOCKER_CERT_PATH="/Users/hbliu/.docker/machine/machines/default"
# export DOCKER_MACHINE_NAME="default"

dsh() {
	if [[ -z "$1" ]]; then
		echo "Usage: dsh container_name"
		return 1
	fi
	docker exec -it "$@" bash
}

# compdef dsh=docker-exec

alias dips="docker ps -a -q | xargs docker inspect --format '{{ .Name }} -- {{ .NetworkSettings.Networks.docker_default.IPAddress }}'"
# }}}

# hook chpwd
function precmd() {
  if [ -r $PWD/.zsh_config ]; then
    source $PWD/.zsh_config
  fi
}

# Video Convert
vconvert() {
	ffmpeg -i $1 -acodec copy -vcodec copy $2
}

# fzf # {{{
export FZF_DEFAULT_OPTS="--extended"
# export FZF_COMPLETION_TRIGGER='~~'
# export FZF_COMPLETION_OPTS='+c -x'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

[[ -s "/Users/hbliu/.gvm/scripts/gvm" ]] && source "/Users/hbliu/.gvm/scripts/gvm"

# FreeWheel # {{{
export GOPATH="$HOME/go"
# secureAddGoPath "$HOME/go" start
secureAddPath "$HOME/go/bin" start
secureSource "$HOME/.dotfiles/private/freewheel/plugin.zsh"
# }}}

# aws #{{{
alias ecs-cli='aws-mfa ecs-cli'
alias aws='aws-mfa aws'
# }}}

secureSource "$DOTFILES/private/freewheel/slack.zsh"
secureSource "$DOTFILES/private/private_info.zsh"

# vim:set fdm=marker:
