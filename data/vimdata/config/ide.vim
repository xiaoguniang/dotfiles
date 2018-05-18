" Plug 'https://github.com/szw/vim-ctrlspace'
Plug 'https://github.com/majutsushi/tagbar.git'
" Plug 'https://github.com/lvht/tagbar-markdown', {'for': ['markdown', 'md']}
Plug 'https://github.com/scrooloose/nerdtree.git' ", {'on': ['NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind', 'NERDTreeFromBookmark']}
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'
" Plug 'https://github.com/scrooloose/syntastic.git', {'on': ['SyntasticCheck', 'Errors', 'SyntasticToggleMode']}
Plug 'https://github.com/w0rp/ale'
" Plug 'https://github.com/neomake/neomake'
Plug 'https://github.com/Yggdroot/indentLine', {'on' : 'IndentLinesToggle'}
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/tpope/vim-commentary'
" Plug 'https://github.com/tomtom/tcomment_vim'
" Plug 'https://github.com/jsfaint/gen_tags.vim'
Plug 'https://github.com/tyru/capture.vim'

Plug 'https://github.com/hiberabyss/NeovimGdb'
Plug 'https://github.com/dbgx/lldb.nvim'

" Plug 'https://github.com/xolox/vim-session'
" Plug 'https://github.com/xolox/vim-misc'

Plug 'https://github.com/hiberabyss/ProjectConfig'

" Run Command "{{{
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/radenling/vim-dispatch-neovim'

let g:nremap = {"m": ",m"}
let g:dispatch_neovim_fixedsize = 1
"}}}

" lsp "{{{
" Plug 'https://github.com/autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" let g:LanguageClient_serverCommands = {
			" \ 'javascript': ['$HOME/github/javascript-typescript-langserver/lib/language-server-stdio.js'],
			" \ }

let g:LanguageClient_autoStart = 1
"}}}

" code format "{{{
Plug 'https://github.com/google/vim-maktaba', {'on': ['FormatCode', 'FormatLines', 'AutoFormatBuffer']}
Plug 'google/vim-glaive', {'on': ['FormatCode', 'FormatLines', 'AutoFormatBuffer']}
" Pre-requirement: vim-glaive vim-maktaba
Plug 'https://github.com/google/vim-codefmt', {'on': ['FormatCode', 'FormatLines', 'AutoFormatBuffer']}
" Plug 'https://github.com/Chiel92/vim-autoformat'
"}}}

" document "{{{
if has('mac')
    Plug 'https://github.com/rizzatti/dash.vim.git'
    nmap <silent> <leader>z <Plug>DashSearch
else
    Plug 'https://github.com/KabbAmine/zeavim.vim'
endif
"}}}

" ale "{{{
let g:ale_set_highlights = 0
let g:ale_linters = {
			\ 'cpp': ['clang', 'cppcheck', 'cpplint', 'g++'],
			\ 'go' : ['gofmt', 'golint', 'gometalinter', 'go vet', 'staticcheck']
			\ }
			" \ 'python' : ['mypy', 'pylint']
"}}}

" let g:loaded_youcompleteme = 1

" Plug 'https://github.com/Valloric/YouCompleteMe.git', {'do': './install.py --clang-completer --system-libclang --gocode-completer'}
" Plug 'https://github.com/rdnetto/YCM-Generator', 'stable'

" YouCompleteMe "{{{
" let g:ycm_global_ycm_extra_conf = expand("$CUSDATA/conf/ycm/cpp/.ycm_extra_conf.py")
" let g:ycm_global_ycm_extra_conf = expand("$CUSDATA/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py")

" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_key_invoke_completion = '<c-n>'
"let g:ycm_min_num_of_chars_for_completion = 99
" let g:ycm_auto_trigger = 0
"let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_confirm_extra_conf = 0

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
" let g:ycm_use_ultisnips_completer = 0

let g:ycm_disable_for_files_larger_than_kb = 1500

"Disable syntaxcheck of ycm
let g:ycm_show_diagnostics_ui = 0
let g:ycm_filetype_whitelist = {
            \ 'cpp' : 1,
            \ 'c'   : 1
            \}
"\ '*': 1,

let g:ycm_filetype_blacklist = {
			\ 'go': 1,
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1
            \}

" nmap <silent> ,yd :YcmDiags<cr>
nmap <silent> <Leader>jd :YcmCompleter GoToDeclaration<CR>
nmap <silent> <Leader>ji :YcmCompleter GoToDefinition<CR>
nmap <silent> <Leader>jg :YcmCompleter GoTo<CR>
nmap <Leader>jc :YcmCompleter 
"}}}

" NERDcommenter"{{{
let g:NERDSpaceDelims = 1
let g:NERDCommentWholeLinesInVMode = 0
" let g:NERD_c_alt_style = 0
let g:NERDUsePlaceHolders = 1

" let g:NERDCustomDelimiters = {
            " \ 'markdown': { 'left': '<!--', 'right': '-->' },
            " \ }
" imap <c-c>i <plug>NERDCommenterInsert<cr>

" autocmd! FileType markdown set commentstring=<!--%s-->
"}}}

" IndentLine "{{{
" let g:indentLine_char = '┊'
let g:indentLine_char = '|'
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_fileTypeExclude = ['text', 'help']

nmap <silent> <Leader>il :IndentLinesToggle<cr>
"}}}

" ctrlspace 5 "{{{
" let g:CtrlSpaceUseTabline = 1
let g:CtrlSpaceSetDefaultMapping = 1
let g:CtrlSpaceDefaultMappingKey = "<A-Space>"
" let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
let g:CtrlSpaceProjectRootMarkers = [ ".git", ".hg", ".svn", ".bzr", "_darcs",
            \ "CVS",
            \ ".proj",
            \ "_config.yml",
            \ 'main.tex'
            \ ]
let g:CtrlSpaceIgnoredFiles = '\v((tmp|temp)[\/])|(\f*\.log|\f*\.wiki)'

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

" let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"

hi link CtrlSpaceNormal   Normal
"}}}

" Tagbar "{{{
" let g:tagbar_width = 30
let g:tagbar_singleclick = 1
let g:tagbar_zoomwidth = 0
let g:tagbar_foldlevel        = 0
let g:tagbar_autoshowtag      = 1
let g:tagbar_map_showproto    = "d"
" let g:tagbar_show_linenumbers = 0
let g:tagbar_show_visibility  = 1
let g:tagbar_sort             = 0
let g:tagbar_compact = 1
" let g:tagbar_autopreview = 1
" let g:tagbar_autoclose = 1
" let g:tagbar_autofocus = 1

let g:tagbar_type_cpp = {
            \ 'ctagstype' : 'c++',
            \ 'kinds'     : [
                \ 'd:macros:1:0',
                \ 'p:prototypes:1:0',
                \ 'g:enums',
                \ 'e:enumerators:0:0',
                \ 't:typedefs:0:0',
                \ 'n:namespaces',
                \ 'c:classes',
                \ 's:structs',
                \ 'u:unions',
                \ 'f:functions',
                \ 'm:members:0:0',
                \ 'v:variables:0:0'
            \ ],
            \ 'sro'        : '::',
            \ 'kind2scope' : {
                \ 'g' : 'enum',
                \ 'n' : 'namespace',
                \ 'c' : 'class',
                \ 's' : 'struct',
                \ 'u' : 'union'
            \ },
            \ 'scope2kind' : {
                \ 'enum'      : 'g',
                \ 'namespace' : 'n',
                \ 'class'     : 'c',
                \ 'struct'    : 's',
                \ 'union'     : 'u'
            \ }
\ }

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '$CUSDATA/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

let g:tagbar_type_vimwiki = {
    \   'ctagstype':'vimwiki'
    \ , 'kinds':['h:header']
    \ , 'sro':'&&&'
    \ , 'kind2scope':{'h':'header'}
    \ , 'sort':0
    \ , 'ctagsbin':'$CUSDATA/TagbarTools/vwtags.py'
    \ , 'ctagsargs': 'default'
\ }

let g:tagbar_type_man = {
    \ 'ctagstype': 'man',
    \ 'kinds' : [
        \ 's:Sections',
    \ ],
    \ 'sort': 0,
\ }

" \ 'v:variables',
" \ 'm:maps',
let g:tagbar_type_vim = {
    \ 'ctagstype': 'vim',
    \ 'kinds' : [
        \ 't:TAGS',
        \ 'f:functions',
    \ ],
    \ 'sort': 1,
\ }

let g:tagbar_type_bib = {
    \ 'ctagstype': 'bib',
    \ 'kinds' : [
        \ 'b:BIBS',
    \ ],
    \ 'sort': 1,
\ }

let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds' : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort'    : 0,
\ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

let g:tagbar_type_coffee = {
        \ 'ctagstype' : 'coffee',
        \ 'kinds'     : [
            \ 'c:classes',
            \ 'm:methods',
            \ 'f:functions',
            \ 'v:variables',
            \ 'f:fields',
        \ ]
\ }

map <silent> <Space>t :let b:tagbar_ignore=0<cr>:TagbarToggle<cr>
nmap <silent> <Space>T :let b:tagbar_ignore=0<cr>:TagbarOpenAutoClose<cr>
nmap <Leader>t/ :TagbarOpenAutoClose<cr>/
vmap <Leader>t/ :TagbarOpenAutoClose<cr>/
map <silent> <Leader>tp :TagbarTogglePause<cr>
map <silent> <Leader>tc :TagbarCurrentTag<cr>
" autocmd FileType tagbar setlocal nocursorline nocursorcolumn
"}}}

" NERDTree"{{{
let g:NERDTreeAutoDeleteBuffer=1
" let g:NERDTreeChDirMode = 0
" let NERDTreeBookmarksFile = expand("$CUSDATA/NERDTreeBookmarks")

let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowLineNumbers = 0

nmap <silent> <Space>d :NERDTreeToggle<CR>
nmap <silent> <Space>D :NERDTreeFocus<CR>
nmap <silent> <Leader>dc :NERDTreeCWD<CR>
nmap <silent> <Leader>df :NERDTreeFind<cr>
nmap <Leader>db :NERDTreeFromBookmark 
"}}}

" nerdtree git "{{{
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
"}}}

" neomake"{{{
let g:neomake_cpp_enable_markers=['clang']
let g:neomake_cpp_clang_args = ["-std=c++14", "-Wextra", "-g", '-I./server']
"}}}

" Compile Run"{{{
let g:interpreter_cmd = {
            \ 'javascript': 'node',
            \}

if exists('g:interpreter_cmd')
	for [ft, cmd] in items(g:interpreter_cmd)
		execute('autocmd FileType ' .ft. ' nmap <buffer> <silent> ,rr :call WinRun("' .cmd. '")<cr>')
	endfor
endif
"}}}

" vim:set fdm=marker:
