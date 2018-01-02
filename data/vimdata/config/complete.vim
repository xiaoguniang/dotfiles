if has('nvim')
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'https://github.com/Shougo/neco-vim'
elseif has('lua')
    Plug 'https://github.com/Shougo/neocomplete.vim'
endif

Plug expand('$CUSDATA/LocalBundle/deoplete-fwlqs')

Plug 'https://github.com/Shougo/neoinclude.vim'
Plug 'https://github.com/wellle/tmux-complete.vim'
Plug 'https://github.com/zchee/deoplete-jedi'
Plug 'zchee/deoplete-go', {'do': 'make'}
" Plug 'https://github.com/Shougo/context_filetype.vim'
" Plug 'https://github.com/zchee/deoplete-asm'

Plug 'https://github.com/Shougo/neco-syntax'
" Plug 'https://github.com/thalesmello/webcomplete.vim'

Plug 'https://github.com/Shougo/neco-syntax'

" Plug 'https://github.com/Rip-Rip/clang_complete'
Plug 'https://github.com/Shougo/echodoc.vim'

" Neocomplete "{{{
" let g:neocomplete_fnpath = './include,./fig,./figure'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 1
" let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1
let g:neoinclude#paths = {'cpp': ".,include,/usr/include,/usr/local/include/c++/5.2.0"}
"}}}

" tmux complete "{{{
" let g:tmuxcomplete#trigger = 'completefunc'
"}}}

" deoplete "{{{
let g:deoplete#enable_at_startup = 0
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#buffer#require_same_filetype = 0
let g:context_filetype#same_filetypes = 1

function! DeopleteInit()
	" call deoplete#custom#source('clang_complete', 'rank', 9999)
	call deoplete#custom#source('vim', 'rank', 9999)
	call deoplete#custom#source('go', 'rank', 9999)
	call deoplete#custom#source('buffer', 'dup', 1)
endfunction

if has('nvim')
	autocmd VimEnter * call DeopleteInit()
	autocmd InsertEnter * call deoplete#enable()
endif
" let g:deoplete#auto_complete_delay = 125

" let g:deoplete#complete_method = "omnifunc"
" let g:deoplete#auto_complete_delay = 0

" inoremap <expr><C-g> deoplete#undo_completion()

" inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"

" let g:deoplete#ignore_sources = {
            " \ '_' : ['tag'],
            " \ 'cpp' : ['tag']
            " \ }

" inoremap <silent><expr> <Tab>
            " \ pumvisible() ? "\<C-n>" :
            " \ deoplete#mappings#manual_complete()
" call deoplete#custom#set('_', 'matchers', ['matcher_head'])

let g:clang_library_path = '/usr/local/Cellar/llvm/5.0.0/lib'
"}}}

" echodoc"{{{
let g:echodoc_enable_at_startup = 1
"}}}

" fzf "{{{
let $ZGEN_FZF = expand("$HOME/.zgen/junegunn/fzf-master/")
Plug 'https://github.com/junegunn/fzf.vim.git' ", { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

if has('vim_starting')
    set runtimepath+=$ZGEN_FZF
endif

" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')

autocmd! FileType fzf nmap <buffer> <silent> q :quit<cr>
"}}}

" vim:fdm=marker
