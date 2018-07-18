Plug 'https://github.com/AndrewRadev/switch.vim'
Plug 'https://github.com/machakann/vim-swap'
Plug 'https://github.com/alpertuna/vim-header'
Plug 'https://github.com/aperezdc/vim-template'
Plug 'https://github.com/lfilho/cosco.vim'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
" Plug 'https://github.com/maxbrunsfeld/vim-yankstack'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister'
Plug 'https://github.com/salsifis/vim-transpose'
Plug 'https://github.com/benmills/vim-commadown' ", {'on': 'CommaDown'}
Plug 'https://github.com/sjl/gundo.vim.git', {'on' : ['GundoToggle']}
" Plug 'https://github.com/mbbill/undotree', {'on' : ['UndotreeToggle']}
Plug 'https://github.com/christoomey/vim-sort-motion'
" Plug 'https://github.com/vim-scripts/DrawIt'

Plug 'https://github.com/hiberabyss/visincr'

Plug 'https://github.com/wannesm/wmgraphviz.vim', {'for': ['dot', 'gv']}
let g:WMGraphviz_output = 'jpg'

Plug 'https://github.com/Raimondi/delimitMate.git'

Plug 'https://github.com/junegunn/vim-easy-align'
" EasyAlign "{{{
vmap <Enter> <Plug>(EasyAlign)
"}}}

Plug 'https://github.com/tpope/vim-surround.git'

" Search and replace
" Plug 'https://github.com/pelodelfuego/vim-swoop'
" let g:swoopUseDefaultKeyMap = 0

Plug 'https://github.com/tpope/vim-endwise' " wisely add endfunction/endif/more in vim script

if has('mac')
    Plug 'https://github.com/CodeFalling/fcitx-vim-osx'
    " Plug 'https://github.com/ybian/smartim.git' ", {'on': 'SmartIM'}
    " let g:smartim_disable = 1
    " let g:smartim_debug = 1
    command! -nargs=0 SmartIM let g:smartim_disable = 0
    command! -nargs=0 SmartIMdisable let g:smartim_disable = 1
else
	" Plug 'https://github.com/vim-scripts/fcitx.vim.git'
endif

if (has('python') || has('python3'))
Plug 'https://github.com/SirVer/ultisnips.git'
" Plug 'https://github.com/reconquest/vim-pythonx'
endif

Plug 'https://github.com/honza/vim-snippets.git'

" Macro {{{
Plug 'https://github.com/dohsimpson/vim-macroeditor'
Plug 'https://github.com/dahu/VimLocalMacros'
"}}}

" Ultisnip"{{{
" default priority is 0
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "MyCusSnips"]
let g:cfamily_style_sep = ' '
nmap <silent> ,es :execute("Gsnips " . &ft . " vnew")<cr>
"}}}


" Vinarise "{{{
Plug 'https://github.com/Shougo/vinarise.vim'

let g:vinarise_enable_auto_detect = 0
"}}}

" swap "{{{

" let g:swap#rules = g:swap#default_rules
" let g:swap#rules += [
			" \ {
			" \   'body': '\%(\h\w*\s\+\)\+\h\w*',
			" \   'delimiter': ['\s\+', ',', ':'],
			" \ },
			" \ {
			" \   'surrounds' : ['\[', '\]', 1],
			" \   'delimiter' : [':', ';'],
			" \   'braket'    : [['(', ')'], ['[', ']']],
			" \   'quotes'    : [['"', '"']],
			" \   'literal_quotes': [["'", "'"]],
			" \ }
			" \ ]
"}}}

" CommaDown "{{{
" command! -range CommaDown call CommaDown()<cr>
"}}}

" Far {{{
" Plug 'https://github.com/brooth/far.vim'
" let g:far#source = 'ag'
"}}}

source $VIMCONFIG/complete.vim

" undotree {{{
let g:undotree_WindowLayout = 2
let g:undotree_DiffAutoOpen = 1
let g:gundo_width = 30
"}}}

" gundo {{{
let g:gundo_preview_bottom = 1
"}}}

" Yank stack {{{
" let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'x', 'X', 'y', 'Y']
"}}}

" vim multiple cursors "{{{
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
    " let g:smartim_disable = 1
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
    " let g:smartim_disable = 0
endfunction

function! TextObjectMultipleCursors(type, ...)
	let cur_word = @v
	execute(":'[,']MultipleCursorsFind " .cur_word)
endfunction

nmap <silent> gM :let @v = expand('<cword>')<cr>:<C-U>set opfunc=TextObjectMultipleCursors<cr>g@

let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_start_key='g<C-n>'
let g:multi_cursor_start_word_key='<C-n>'
"}}}

" SplitJoin "{{{
Plug 'https://github.com/AndrewRadev/splitjoin.vim'

let g:splitjoin_align = 1

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap ,gj :SplitjoinJoin<cr>
nmap ,gs :SplitjoinSplit<cr>
"}}}

nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)

" Switch "{{{
let g:switch_mapping = "-"

autocmd VimEnter * let g:switch_custom_definitions =
			\ [
			\ 	['$HOME', expand('$HOME')],
			\	switch#NormalizedCase(['disabled', 'enabled']),
			\	switch#NormalizedCase(['disable', 'enable']),
			\	switch#NormalizedCase(['private', 'public'])
			\ ]
"}}}

" vim template "{{{
function! GetParentDirectoryName()
	return split(expand('%:p:h'), '/')[-1]
endfunction

let g:templates_user_variables = [
			\   ['PARENT_DIR', 'GetParentDirectoryName'],
			\ ]

let g:email = 'lhbf@qq.com'
let g:username = 'Hongbo Liu'
let g:templates_no_builtin_templates = 1
"}}}

" header {{{
let g:header_auto_add_header = 0
let g:header_field_author = 'Hongbo Liu'
let g:header_field_author_email = 'hbliu@freewheel.tv'
let g:header_field_filename = 0
let g:header_field_timestamp_format = '%Y-%m-%d'

nmap <silent> ,ah :AddHeader<cr>
"}}}

" remove next or previous line
nmap [r kdd
nmap ]r jddk

" Neovim Remote "{{{
if has('nvim')
  let $EDITOR = 'tvim -w'
endif
"}}}

" vim:set fdm=marker:
