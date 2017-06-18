#!/bin/sh
#
# Description: tmux select pane
# Author: hiberabyss
# Email: lhbf@qq.com
# CreatTime: 2015-09-08 16:32:45 CST

PATH=$HOME/.local/bin:$PATH

SelectPane() {
	TMUX_CMD="tmux select-pane $1"
	if [[ $2 == 'max' ]]; then
		TMUX_CMD+="\; resize-pane -Z"
	fi
	TMUX_CMD+="\; refresh-client -S"
	sh -c "$TMUX_CMD" &> /dev/zero
	# echo $TMUX_CMD
}

CreatePane() {
	TMUX_CMD="tmux split-window $1 -c'#{pane_current_path}' "
	if [[ $2 == 'max' ]]; then
		TMUX_CMD+="\; resize-pane -Z "
	fi
	TMUX_CMD+="\; refresh-client -S"
	sh -c "$TMUX_CMD" &> /dev/zero
}

SelectLastPane() {
	TMUX_CMD="tmux last-pane"
	if [[ $1 == 'max' ]]; then
		TMUX_CMD+="\; resize-pane -Z "
	fi
	TMUX_CMD+="\; refresh-client -S"
	if ! sh -c "$TMUX_CMD" &> /dev/zero; then
		if [[ $pane_num < 2 ]]; then
			# tmux split-window -v -c"#{pane_current_path}"\; resize-pane -Z\; refresh-client -S\;
			CreatePane -v $1
		else
			SelectPane -t+ $1
		fi
	fi
}

SelectOrCreatePane() {
	DIRT=$1
	MAX=$2

	if [[ $pane_num == 1 ]]; then
		case $DIRT in
			-U|-D )
				DIRT="-v"
				;;
			-L|-R )
				DIRT="-h"
				;;
		esac
		CreatePane $DIRT $MAX
	else
		SelectPane $DIRT $MAX
	fi
}

pane_num=$(tmux display -p '#{window_panes}')

case $1 in
	last )
		SelectLastPane $2
		;;
	select )
		SelectOrCreatePane $2 $3
		;;
esac

# bind s if '! tmux last-pane\; resize-pane -Z' "run-shell 'sh ~/.tmux/SwitchOrCreate.sh'"
