" Unite List "{{{
" Plug 'https://github.com/Shougo/denite.nvim'
Plug 'https://github.com/Shougo/unite.vim.git'
Plug 'https://github.com/Shougo/neoyank.vim'
Plug 'https://github.com/thinca/vim-unite-history.git'

Plug 'https://github.com/kmnk/vim-unite-giti'

" Plug 'https://github.com/Shougo/unite-outline'
" Plug 'https://github.com/zeero/vim-ctrlp-help'
" Plug 'https://github.com/tsukkee/unite-tag'
" Plug 'https://github.com/Shougo/junkfile.vim'
"}}}

nmap <silent> ,gb :Unite giti/branch<cr>

" unite "{{{
let g:unite_source_bookmark_directory = expand("$CUSDATA/UnitBookmark/")
let g:unite_source_history_yank_enable = 1

let g:unite_profile_default_context = {
            \ 'wrap': 1,
            \ 'number': 1,
            \ 'direction': 'botright',
            \ 'sync': 1,
			\ 'start_insert': 1,
            \ }

autocmd VimEnter * call unite#custom#profile('default', 'context', g:unite_profile_default_context)

" <TAB> select from actions
nmap <silent> ,ub <ESC>:Unite bookmark:_<cr>
nmap <silent> ,uf :Unite buffer<cr>
nmap <silent> ,ur :Unite register<cr>
nmap <silent> ,uj :Unite jump<cr>
nmap <silent> ,ut :Unite outline<cr>
nmap <silent> ,uy :Unite history/yank<cr>
nmap <silent> ,up :Unite process -no-wrap<cr>
nnoremap <silent> ,ul  :<C-u>Unite -buffer-name=search
            \ line:forward -start-insert -direction=botright -no-quit<CR>

" nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

" nmap <silent> ,uc :<c-u>Unite history/command<cr>
nmap <silent> ,uc :<c-u>Unite change<cr>
nmap <silent> <space>c :<c-u>Unite command<cr>
nmap <silent> ,us :<c-u>Unite history/search<cr>
"}}}

" vim:set fdm=marker:
