Plug 'https://github.com/vim-scripts/vcscommand.vim.git'

" VCScommand "{{{
augroup VCSCommand
  au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
augroup END
nmap ,vb :VCSBlame<cr>
nmap ,vB :VCSAnnotate!<cr>
nmap ,vd :VCSVimDiff 
" }}}

