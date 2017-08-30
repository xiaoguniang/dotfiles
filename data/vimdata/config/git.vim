Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/gregsexton/gitv'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/jreybert/vimagit'
" Plug 'https://github.com/idanarye/vim-merginal'
Plug 'https://github.com/kmnk/vim-unite-giti'
Plug 'https://github.com/shumphrey/fugitive-gitlab.vim' ", {'on': 'Gbrowse'}
Plug 'https://github.com/tpope/vim-rhubarb'

" gitlab "{{{
let g:fugitive_gitlab_domains = ['https://git.dev.fwmrm.net']
"}}}

" fugitive "{{{
nmap <silent> <Leader>gd :Gdiff<cr>
nmap <silent> ,ob :Gbrowse<cr>
"}}}

nmap <silent> ,gb :Unite giti/branch<cr>
nmap <silent> <space>gs :Gstatus<cr><c-n>
nmap <silent> <space>gm :Magit<cr>

" vim Gitgutter"{{{
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_eager = 0
nmap <silent> ,gg :GitGutterToggle<cr>
"}}}

