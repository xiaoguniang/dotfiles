" Plug 'https://github.com/rhysd/vim-grammarous'

Plug 'https://github.com/eaglelzy/vim-hexo'

let g:hexoRootPath = expand("$HOME/Projects/Hexo/blog/")

command! -nargs=0 HexoServer :Dispatch hexo g && hexo server -o
