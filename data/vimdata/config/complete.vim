if has('nvim')
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'https://github.com/Shougo/neco-vim'
elseif has('lua')
    Plug 'https://github.com/Shougo/neocomplete.vim'
endif
Plug 'https://github.com/Shougo/neoinclude.vim'
Plug 'https://github.com/wellle/tmux-complete.vim'
Plug 'https://github.com/zchee/deoplete-jedi'

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
let g:deoplete#enable_at_startup = 1
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
" let g:clang_complete_auto = 0
" let g:clang_auto_select = 0
" let g:clang_omnicppcomplete_compliance = 0
" let g:clang_make_default_keymappings = 0
"}}}

" vim:fdm=marker
