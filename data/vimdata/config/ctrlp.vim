Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/tacahiroy/ctrlp-funky.git'
Plug 'https://github.com/fisadev/vim-ctrlp-cmdpalette'
" Plug 'https://github.com/dbeecham/ctrlp-commandpalette.vim'

" CtrlP "{{{
function! CtrlPModeSwitch()
    let cnt = v:count
    echomsg cnt
    if cnt == 1
        execute(":CtrlP")
        return 0
    endif

    execute(g:ctrlp_cmd)
    while cnt > 1
        exe "normal \<c-f>"
        let cnt -= 1
    endwhile
endfunction

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
            \ 'javascript' : {
            \ 'bin': 'jsctags',
            \ 'args': '-f -',
            \ },
            \ 'vimwiki' : '--vimwiki-kinds=+h'
            \ }

let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'eEt'
let g:ctrlp_max_history = &history
let g:ctrlp_lazy_update = 0
let g:ctrlp_extensions = ['line', 'changes', 'mixed', 'undo' ]
let g:ctrlp_mruf_exclude = '*.o\|*.bin\|*.elf\|*.swp'
let g:ctrlp_arg_map = 1
nmap <silent> <C-P> :<C-U>call CtrlPModeSwitch()<cr>
nmap <silent> <C-j> :CtrlPBufTag<cr>
nmap <silent> <Leader>pb :CtrlPBookmarkDir<cr>
nmap <silent> <Leader>pf :CtrlPCurWD<cr>
nmap <silent> <Leader>pl :CtrlPLine<cr>

" ctrlpz "{{{
Plug 'https://github.com/vim-scripts/ctrlp-z'
nmap <silent> <Space>pf :CtrlPF<cr>
nmap <silent> <Space>pz :CtrlPZ<cr>
let g:ctrlp_z_nerdtree = 1
"}}}

let g:ctrlp_help_default_mode = 't'
nmap <silent> ,ph :CtrlPHelp<cr>
nnoremap <A-f>  :<C-u>CtrlPCurWD<CR>
"}}}

" Ctrlp funky "{{{
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
nmap <silent> <A-x> :CtrlPCmdPalette<cr>
"}}}

" vim:set fdm=marker:
