""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         custom how to compiler tex                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('b:loaded_tex_run')
    finish
endif

let b:loaded_tex_run = 1

" let b:main_path = expand("%:p:h")

map <buffer> <silent> ,ll \ll<cr>:redraw!<cr>
nmap <buffer> <silent> ,qm :Make! main<cr>:redraw!<cr>
map <buffer> <silent> ,lv \lv<cr>:redraw!<cr>
map <buffer> <silent> ,rr ,ll,lv
