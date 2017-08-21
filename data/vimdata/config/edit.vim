Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'https://github.com/AndrewRadev/switch.vim'
Plug 'https://github.com/machakann/vim-swap'
Plug 'https://github.com/alpertuna/vim-header'
Plug 'https://github.com/aperezdc/vim-template'
Plug 'https://github.com/lfilho/cosco.vim'
Plug 'https://github.com/tpope/vim-abolish'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'https://github.com/maxbrunsfeld/vim-yankstack'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister'
Plug 'https://github.com/salsifis/vim-transpose'
Plug 'https://github.com/brooth/far.vim'
Plug 'https://github.com/benmills/vim-commadown' ", {'on': 'CommaDown'}
Plug 'https://github.com/sjl/gundo.vim.git', {'on' : ['GundoToggle']}
" Plug 'https://github.com/mbbill/undotree', {'on' : ['UndotreeToggle']}
Plug 'https://github.com/christoomey/vim-sort-motion'

Plug 'https://github.com/Shougo/vinarise.vim'

" Macro {{{
Plug 'https://github.com/dohsimpson/vim-macroeditor'
Plug 'https://github.com/dahu/VimLocalMacros'
"}}}

" Vinarise "{{{
let g:vinarise_enable_auto_detect = 1
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
let g:far#source = 'ag'
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
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'x', 'X', 'y', 'Y']
"}}}

" vim multiple cursors "{{{
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
    let g:smartim_disable = 1
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
    unlet g:smartim_disable
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

let g:splitjoin_align = 1

nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)

" Switch "{{{
let g:switch_mapping = "-"

let g:switch_custom_definitions =
			\ [
			\ 	['$HOME', expand('$HOME')],
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

" vim:set fdm=marker:
