pcmd() { peco | while read LINE; do $@ $LINE; done }

alias ghqcd='ghq list -p | pcmd cd'
