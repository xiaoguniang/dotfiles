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
            \ 'markdown' : '--language-force=markdown --markdown-types=hik',
            \ 'go' : '--go-kinds=+t+s+i+p',
            \ 'help' : '--language-force=vimhelp',
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

function! TermOpenFunc(action, line)
    if a:action =~? '^[e]$' && a:line =~ '^term://'
        call ctrlp#exit()

        let win_size = 12
        if exists('g:neoterm_size')
            let win_size = g:neoterm_size
        endif

        execute("botright new")
        execute("resize " .win_size)
        let term_bufnr = bufnr(a:line)
        execute("b" . term_bufnr)
    else
        call call('ctrlp#acceptfile', [a:action, a:line])
    endif
endfunction

let g:ctrlp_open_func = {
            \ 'buffers': 'TermOpenFunc',
            \ }

" nmap <silent> <C-P> :<C-U>call CtrlPModeSwitch()<cr>
nmap <silent> <C-j> :CtrlPBufTag<cr>
nmap <silent> ,gl :CtrlPLine<cr>
nmap <silent> <Leader>pb :CtrlPBookmarkDir<cr>

nnoremap <A-f>  :<C-u>CtrlPCurWD<CR>
nmap <A-Space> :<C-u>CtrlPBuffer<cr>
"}}}

" FileJumper "{{{
let g:file_jumper_command = {
            \ "Gbin": {'dir': expand("$HOME/bin")},
            \ "Gwiki": {'dir': expand("$HOME/vimwiki"), 'keymap': '<Leader>wg', 'ext': '.wiki'},
            \ "Gvimconfig": {'dir': expand('$VIMCONFIG'), 'keymap': ',gv'},
            \ "Gftplugin": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/ftplugin")},
            \ "Gsnips": {'dir': expand("$CUSDATA/LocalBundle/MyPlugins/MyCusSnips"), 'ext': '.snippets'},
			\ "Grest": {"dir": expand("$CUSDATA/REST"), 'ext': '.rest'},
            \ }

function! FileJumperHandler(dir, ext, ...)
	if a:0 == 0
		execute("CtrlP " .a:dir)
		return
	endif

	let cmd = "vnew"
	if a:0 > 1
		let cmd = join(a:000[1:])
	endif

	if a:0 > 0
		execute(printf("%s %s/%s%s", cmd, a:dir, a:1, a:ext))
	endif
endfunction

function! s:DefineDirFileCompletionCommand()
	for cmd in keys(g:file_jumper_command)
		let extension = ""
		if has_key(g:file_jumper_command[cmd], 'ext')
			let extension = g:file_jumper_command[cmd].ext
		endif
		execute(printf("command! -nargs=* %s call FileJumperHandler('%s', '%s', <f-args>)", cmd, g:file_jumper_command[cmd].dir, extension))
		if has_key(g:file_jumper_command[cmd], 'keymap')
			execute(printf('nmap %s :%s<cr>', g:file_jumper_command[cmd].keymap, cmd))
		endif
	endfor
endfunction

call s:DefineDirFileCompletionCommand()
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
vmap <silent> <A-x> :<c-u>CtrlPCmdPalette<cr>
"}}}

" ctrlp help "{{{
Plug 'https://github.com/zeero/vim-ctrlp-help'

let g:ctrlp_help_vsplit_width = 80
nmap <silent> <Space>h :CtrlPHelp<cr>
"}}}

" register "{{{
" Plug 'https://github.com/mattn/ctrlp-register'
"}}}

" vim:set fdm=marker:
