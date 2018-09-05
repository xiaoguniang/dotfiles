" Plug 'https://github.com/vim-scripts/vcscommand.vim.git'
Plug 'https://github.com/juneedahamed/vc.vim'

" VCScommand "{{{
augroup VCSCommand
  au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
augroup END

" nmap ,vB :VCSAnnotate!<cr>
" nmap ,vd :VCSVimDiff 
" }}}

command! -nargs=0 Sbrowse silent! call system("sbrowse " .expand("%:p"))

" vc "{{{
nmap ,vb :VCBlame<cr>
autocmd FileType vcblame silent! nmap <unique> <buffer> q :bwipeout<cr>
"}}}
