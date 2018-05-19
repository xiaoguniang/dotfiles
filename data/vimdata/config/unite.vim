" Unite List "{{{
" Plug 'https://github.com/Shougo/denite.nvim'
" Plug 'https://github.com/tsukkee/unite-tag'
" Plug 'https://github.com/Shougo/junkfile.vim'
"}}}

" unite "{{{
Plug 'https://github.com/Shougo/unite.vim'
let g:unite_source_bookmark_directory = expand("$CUSDATA/UnitBookmark/")
" let g:unite_source_history_yank_enable = 1

let g:unite_profile_default_context = {
            \ 'wrap': 1,
            \ 'number': 1,
            \ 'direction': 'botright',
            \ 'sync': 1,
			\ 'start_insert': 1,
            \ }

autocmd VimEnter * call unite#custom#profile('default', 'context', g:unite_profile_default_context)


autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    imap <buffer> <c-k> <Plug>(unite_select_previous_line)
    imap <buffer> <c-j> <Plug>(unite_select_next_line)
endfunction

function! LoadUniteCustomMappings()
    let mappings = {
                \ "<C-q>" : "<Plug>(unite_exit)",
                \ }
                " \ "<C-i>" : "<expr> unite#do_action('insert')",
    for [key, value] in items(mappings)
        execute(printf("imap <buffer> <silent> %s %s", key, value))
    endfor
endfunction

autocmd! FileType unite call LoadUniteCustomMappings()

" <TAB> select from actions
nmap <silent> ,ub <ESC>:Unite -no-start-insert bookmark:_<cr>
nmap <silent> ,uf :Unite buffer<cr>
nmap <silent> ,ur :Unite register<cr>
nmap <silent> ,uj :Unite jump<cr>
nmap <silent> ,uy :Unite history/yank<cr>
nmap <silent> ,up :Unite process -no-wrap<cr>
nnoremap <silent> ,ul  :<C-u>Unite -buffer-name=search
            \ line:all -start-insert -direction=botright<CR>

" nnoremap <silent> g<C-h>  :<C-u>UniteWithCursorWord help<CR>

" nmap <silent> ,uc :<c-u>Unite change<cr>
"}}}

" neoyank "{{{
Plug 'https://github.com/Shougo/neoyank.vim'

let g:neoyank#save_registers = ['"', "0", "1", "2", "3"]
"}}}

" history "{{{
Plug 'https://github.com/thinca/vim-unite-history'

nmap ,c/ :Unite history/command<cr>
nmap ,s/ :Unite history/search<cr>
"}}}

" giti "{{{
Plug 'https://github.com/kmnk/vim-unite-giti'

nmap <silent> ,gb :Unite giti/branch<cr>
"}}}

" vim:set fdm=marker:
