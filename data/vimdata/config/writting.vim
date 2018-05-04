" Plug 'https://github.com/rhysd/vim-grammarous'

Plug 'https://github.com/hiberabyss/vim-hexo'

let g:hexoRootPath = expand("$HOME/Projects/Hexo/blog/")

function! Zwc() range
  " send selected lines to system command *zwc* and print the output
  let select_beg_line = getpos("'<")[1]
  let select_end_line = getpos("'>")[1]
  let lines = getline(select_beg_line, select_end_line)
  let input = join(lines, "\n") . "\n"
  let output = system("zwc", input)
  echom substitute(output, '\v(^\_s+)|(\_s+$)', '', 'g')
endfunction

vnoremap ,wc :call Zwc()<CR>

command! -nargs=0 HexoServer :Dispatch hexo g && hexo server
" command! -nargs=0 HexoServer :Dispatch hexo g && hexo server -o

" Youdao Translater "{{{
Plug 'https://github.com/ianva/vim-youdao-translater.git', {'on': ['Ydc', 'Yde', 'Ydv'], 'branch': 'dev-async'}

vnoremap <silent> ,tt <Esc>:Ydv<CR>
nnoremap <silent> ,tt <Esc>:Ydc<CR>
noremap <silent> ,ti <Esc>:Yde<CR>
" }}}

