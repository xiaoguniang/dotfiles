LIST_DIR="/etc/apt/sources.list.d"

_complete_aptlist() {
	local cur
	reply=($(ls "${LIST_DIR}"))
	# if [[ $(ls "${MARKPATH}" | wc -l) -gt 1 ]]; then
		# reply=($(ls $MARKPATH/**/*(-) | grep : | sed -E 's/(.*)\/([_a-zA-Z0-9\.\-]*):$/\2/g'))
	# else
		# if readlink -e "${MARKPATH}"/* &>/dev/null; then
			# reply=($(ls "${MARKPATH}"))
		# fi
	# fi
}
compctl -K _complete_aptlist update-repo
