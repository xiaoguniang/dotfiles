" CtrlP "{{{
Plug 'https://github.com/ctrlpvim/ctrlp.vim'

let g:ctrlp_cmd = 'exe get(["CtrlPMRU", "CtrlPBuffer", "CtrlP", "CtrlPCurWD", "CtrlPCurFile", "CtrlPChange"], v:count)'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_max_history = &history
let g:ctrlp_lazy_update = 0
let g:ctrlp_extensions = ['line', 'changes', 'mixed', 'undo' ]
let g:ctrlp_mruf_exclude = '*.o\|*.bin\|*.elf\|*.swp'
let g:ctrlp_arg_map = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_tilde_homedir = 1

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
                \ --ignore .git
                \ --ignore .svn
                \ --ignore .hg
                \ --ignore .DS_Store
                \ --ignore "**/*.pyc"
                \ --ignore "**/*.swp"
                \ -g ""
                \'
endif

let g:ctrlp_buftag_types = {
            \ 'erlang'     : '--language-force=erlang --erlang-types=drmf',
            \ 'vim'        : '--vim-kinds=+tfm-v',
            \ 'man'        : '--man-kinds=+s',
            \ 'zsh'        : '--sh-kinds=+t',
            \ 'cpp'         : '--fields=+iaKSz --extra=+q --c++-kinds=+L-p',
            \ 'sql'         : '--sql-kinds=+Insert',
            \ 'markdown' : '--language-force=markdown --markdown-types=hik',
			\ 'go' : '--go-kinds=+t+s+i+p',
            \ 'javascript' : {
            \ 'bin': 'jsctags',
            \ 'args': '-f -',
            \ },
            \ 'vimwiki' : {
                \ 'bin' : '$CUSDATA/TagbarTools/vwtags.py',
                \ 'args': 'default',
            \ },
            \ }

let g:ctrlp_prompt_mappings = {
    \ 'ToggleType(-1)':       ['<c-b>', '<a-h>', '<c-left>'],
    \ 'ToggleType(1)':        ['<c-f>', '<a-l>', '<c-right>'],
    \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
    \ 'PrtCurRight()':        ['<right>'],
    \ }

" nmap <silent> <C-P> :<C-U>call CtrlPModeSwitch()<cr>
nmap <silent> <C-j> :CtrlPBufTag<cr>
nmap <silent> <Leader>pb :CtrlPBookmarkDir<cr>
nmap <silent> <Leader>pf :CtrlPCurWD<cr>
nmap <silent> <Leader>pl :CtrlPLine<cr>

nnoremap <A-f>  :<C-u>CtrlPCurWD<CR>
nmap <A-Space> :<C-u>CtrlPBuffer<cr>
"}}}

" ctrlpz "{{{
Plug 'https://github.com/vim-scripts/ctrlp-z'

let g:ctrlp_z_nerdtree = 1
nmap <silent> <Space>pf :CtrlPF<cr>
nmap <silent> <Space>pz :CtrlPZ<cr>
"}}}

" Ctrlp funky "{{{
Plug 'https://github.com/tacahiroy/ctrlp-funky.git'

let g:ctrlp_funky_after_jump = {
            \ 'default' : 'zxzz',
            \ 'python'  : 'zO',
            \ 'cpp'     : 'zxzt',
            \ 'go'      : 'zz',
            \ 'vim'     : '',
            \ }

" let g:ctrlp_funky_multi_buffers = 1 " search in multiple buffers
let g:ctrlp_funky_sort_by_mru = 1
let g:ctrlp_funky_nerdtree_include_files = 1
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_sh_type = 'zsh'

nnoremap ,pf :CtrlPFunky<Cr>
nnoremap <Leader>pu :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
"}}}

" CtrlPCmdPalette {{{
Plug 'https://github.com/fisadev/vim-ctrlp-cmdpalette'
" Plug 'https://github.com/dbeecham/ctrlp-commandpalette.vim'

let g:ctrlp_cmdpalette_execute = 1
nmap <silent> <A-x> :CtrlPCmdPalette<cr>
"}}}

" vim:set fdm=marker:
