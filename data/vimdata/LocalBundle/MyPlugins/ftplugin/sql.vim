" if exists('b:loaded_sql_vim')
    " finish
" endif
" let b:loaded_sql_vim = 1

map <silent> <buffer> ,rp vip:TREPLSendSelection<cr>
map <silent> <buffer> ,rr vip:TREPLSendSelection<cr>
map <silent> <buffer> ,rl :TREPLSendLine<cr>
map <silent> <buffer> ,rf :TREPLSendFile<cr>
