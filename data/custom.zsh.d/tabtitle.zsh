function omz_termsupport_preexec {
  emulate -L zsh
  setopt extended_glob

  if [[ "$DISABLE_AUTO_TITLE" == true ]]; then
    return
  fi

  local cmd_ignore_pattern="*=*|sudo|ssh|mosh|rake|-*"
  if [[ -n "$TABTITLE_CUSTOM_IGNORE_PATTERN" ]]; then
	  cmd_ignore_pattern="$cmd_ignore_pattern|$TABTITLE_CUSTOM_IGNORE_PATTERN"
  fi
  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^($cmd_ignore_pattern)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}
