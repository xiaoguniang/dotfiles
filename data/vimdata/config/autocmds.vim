autocmd BufWritePost .vimrc source ~/.vimrc
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd FileType tex setl sw=2 " | setl iskeyword+=:
autocmd FileType html setl sw=2 | setl fdm=syntax
autocmd FileType json,ruby setl fdm=syntax

" restore cursor position
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" vim:fdm=marker:
