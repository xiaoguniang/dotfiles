Plug 'https://github.com/sheerun/vim-polyglot'

" polyglot"{{{
let g:polyglot_disabled = ['python']
"}}}

" Python "{{{
" Plug 'https://github.com/davidhalter/jedi-vim', {'for': ['py', 'python']}
Plug 'https://github.com/klen/python-mode.git', {'for': ['py', 'python']}

" pythonmode "{{{
" let g:pymode_python = 'python3'
" Values may be chosen from: `pylint`, `pep8`, `mccabe`, `pep257`, `pyflakes`.
" let g:pymode_lint_checkers = ['pyflakes', 'mccabe']
let g:pymode_lint = 0
let g:pymode_lint_ignore = "E501,W0611,C901, W0401"
let g:pymode_options = 0
let g:pymode_rope = 0
let g:pymode_indent = 0
let g:pymode_trim_whitespaces = 0
let g:python_recommended_style = 0
"}}}

"}}}

" Ruby {{{
Plug 'https://github.com/vim-ruby/vim-ruby', {'for': 'ruby'}
"}}}

" asm {{{
au FileType asm setl commentstring=;%s
au FileType asm setl filetype=nasm
"}}}

" LaTex {{{
" PlugLazy 'git://git.code.sf.net/p/vim-latex/vim-latex', {
            " \ 'filetypes' : ['tex', 'latex']
            " \}
" PlugLazy 'https://github.com/lervag/vimtex', {
            " \ 'filetypes' : ['tex', 'latex']
            " \}

" LatexSuit "{{{
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = 'pdf'
" let g:Tex_DefaultTargetFormat = 'dvi'
let g:Tex_MultipleCompileFormats = 'pdf,dvi'
let g:Tex_BIBINPUTS = 'ref'
let g:Tex_CompileRule_pdf = 'xelatex -file-line-error -interaction=nonstopmode $*'
" let g:Tex_CompileRule_dvi = 'xelatex -no-pdf -file-line-error -interaction=nonstopmode $*'
let g:Tex_TreatMacViewerAsUNIX = 1
" let g:Tex_CompileRule_pdf = 'arara $*'
" let g:Tex_ViewRule_pdf = 'open -a Preview.app'
if has('mac')
    let g:Tex_ViewRule_pdf = 'open' 
endif

" let g:Tex_BibtexFlavor = 'biber'
"let g:Imap_UsePlaceHolders = 1
let Imap_PlaceHolderStart = '<S'
let Imap_PlaceHolderEnd = 'E>'
"let g:Tex_Env_theorem = "\\begin{theorem}\<CR><++>\<CR>\\end{theorem}"
let g:Tex_GotoError = 0
let g:Tex_UseMakefile = 0
" imap <c-]> <Plug>Tex_InsertItemOnThisLine
let g:Tex_IgnoredWarnings = 
    \"Underfull\n".
    \"Overfull\n".
    \"specifier changed to\n".
    \"You have requested\n".
    \"Missing number, treated as zero.\n".
    \"There were undefined references\n" .
    \"Citation %.%# undefined\n" .
    \"Font Warning"
let g:Tex_IgnoreLevel = 8
"}}}

"}}}

" Markdown {{{
" Markdown Bundle "{{{
" Plug 'https://github.com/suan/vim-instant-markdown.git'
Plug 'https://github.com/plasticboy/vim-markdown.git', { 'for': ['md', 'markdown', 'mkd'] }
Plug 'https://github.com/mzlogin/vim-markdown-toc', { 'for': ['md', 'markdown', 'mkd'] }
" Plug 'https://github.com/suan/vim-instant-markdown', { 'for': ['md', 'markdown', 'mkd'] }
Plug 'https://github.com/iamcco/markdown-preview.vim', { 'for': ['md', 'markdown', 'mkd'] }
"}}}

let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
let g:vim_markdown_folding_disabled = 1

let g:instant_markdown_autostart = 0
let g:instant_markdown_allow_unsafe_content = 1

" vim markdown "{{{
" let g:vim_markdown_initial_foldlevel = 3
" let g:vim_markdown_math = 1
" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_folding_disabled = 1
"}}}

"}}}

" go {{{
Plug 'https://github.com/fatih/vim-go.git', {'for': 'go'}
Plug 'https://github.com/tenfyzhong/golint-fixer.vim'

" vimgo "{{{
let g:go_autodetect_gopath = 1
let g:go_term_mode = "botright split"
let g:go_fmt_autosave = 0
let g:go_def_mapping_enabled = 1
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = ['vet', 'errcheck']
let g:go_metalinter_autosave_enabled = ['vet']
"}}}

"}}}

" Plug 'https://github.com/dearrrfish/vim-applescript'

" Plug 'https://github.com/tmux-plugins/vim-tmux' " tmux.conf

" vim:set fdm=marker:
