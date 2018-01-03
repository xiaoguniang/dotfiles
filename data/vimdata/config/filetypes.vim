Plug 'https://github.com/saltstack/salt-vim', {'for': 'sls'}
Plug 'https://github.com/alepez/vim-gtest', {'for': ['cpp', 'c']}

Plug 'https://github.com/hiberabyss/vim-gradle', {'for': 'groovy'}

Plug 'https://github.com/sheerun/vim-polyglot'

" polyglot"{{{
let g:polyglot_disabled = ['python', 'latex', 'tex']
"}}}

" Cpp Settings "{{{
function! JumpToClassMemberByFunction()
    let cword = expand('<cword>')
    normal [[
    let line = getline('.')
    if line[0] == '{'
        let line = getline(line('.') - 1)
    endif
    
    if strlen(line) <= 0 | return | endif

    let class_name = matchstr(line, '\v(struct|class)\s+\zs\w+')
    if empty(class_name)
        let class_name = matchstr(line, '\w\+::')
    else
        let class_name .= '::'
    endif
    if empty(class_name) | return | endif

    let tagname = class_name . cword
    execute(':keepjumps tj ' . tagname)
endfunction

function! TaglistTagJump(tag_item, ...)
    let edit_cmd = "e"
    let is_preview = edit_cmd =~# "ped"

    if a:0 > 0 | let edit_cmd = a:1 | endif

    let buf_num = bufnr(a:tag_item["filename"])
    if !is_preview && buf_num > 0
        execute("keepjumps buffer " . buf_num)
    else
        execute("keepjumps " . edit_cmd . ' ' . a:tag_item["filename"])
    endif

    let save_magic = &magic
    set nomagic
    if edit_cmd =~# "ped" | wincmd p | endif
    execute("keepjumps 0;" . a:tag_item["cmd"])
    let &magic = save_magic
endfunction

function! GetFuncTags(tagname)
    let tag_items = taglist("^" . a:tagname . "$")
    let tag_fun = []

    for item in tag_items
        if item["kind"] == "f"
            call add(tag_fun, item)
        endif
    endfor

    return tag_fun
endfunction

function! TagJump(tagcmd, tagname)
    let tag_fun = GetFuncTags(a:tagname)
    if a:tagcmd !~# 'ptj' && len(tag_fun) == 1
        call TaglistTagJump(tag_fun[0])
    else
        execute(a:tagcmd . ' ' . a:tagname)
    endif
endfunction

function! JumpToClassMem(count, tagcmd)
    let save_keyword = &iskeyword
    setl iskeyword+=:
    let cword = expand('<cword>')
    let &iskeyword = save_keyword
    let cword = substitute(cword, ':$', '', '')

    if a:count == 0
        call TagJump(a:tagcmd, cword)
    else
        execute(a:count . 'tag' . ' ' . cword)
    endif
endfunction

function! JumpToClassMemberByDecl(tagcmd)
    let save_keyword = &iskeyword
    setl iskeyword+=.,-,>,:
    let cword = expand('<cword>')
    let &iskeyword = save_keyword

    let var = matchstr(cword, '\v(\w|::)+\ze(->|\.)*')
    let member = matchstr(cword, matchstr(cword, '\(->\|\.\)\zs\w\+'))

    if v:count > 0 || (!empty(var) && var[0] =~# '\u')
        call JumpToClassMem(v:count, a:tagcmd) 
        return
    endif

    let class_name = ''
    if searchdecl(var, 0, 1) == 0
        let line = substitute(getline('.'), 'const', '', 'g')
        let class_name =  matchstr(line, '\v(\w|::)+\ze(\s|[*&])+' . var . '\_s*[,;=)]\C')
        execute("normal \<c-o>")
    endif

    if empty(class_name) || class_name == 'auto'
        call JumpToClassMem(v:count, a:tagcmd)
        return
    endif

    if !empty(member) | let class_name .= '::' | endif
    let tagname = class_name . member

    call TagJump(a:tagcmd, tagname)
endfunction

function! CppFoldMethod(size, ignore_tagbar)
    if getfsize(expand('%')) > a:size * 1024
        execute("setl fmr={,}|setl fdm=marker")
        if a:ignore_tagbar != 0
            let b:tagbar_ignore = a:ignore_tagbar
        endif
    else
        execute("setl fdm=syntax")
    endif
endfunction

nmap <silent> ,b[ :call JumpToClassMemberByFunction()<cr>
nmap <silent> ,bd :call JumpToClassMemberByDecl('tj')<cr>
nmap <silent> ,bc :<C-U>call JumpToClassMem(v:count)<cr>

autocmd! BufReadPre *.h call CppFoldMethod(100, 1)
autocmd! BufReadPre *.cpp,*.inl,*.c call CppFoldMethod(100, 0)
" autocmd! FileType cpp setl completefunc=RtagsCompleteFunc
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
Plug 'https://github.com/lervag/vimtex', {'for': ['tex', 'latex']}

" LatexSuit "{{{
" set grepprg=grep\ -nH\ $*
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

let g:go_term_height = 15
let g:go_term_width = 15
"}}}

"}}}

" Plug 'https://github.com/dearrrfish/vim-applescript'

" Plug 'https://github.com/tmux-plugins/vim-tmux' " tmux.conf

" swift "{{{
Plug 'https://github.com/keith/swift.vim', {'for': 'swift'}
"}}}

" vim:set fdm=marker:
