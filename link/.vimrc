" Variables "{{{
let $DOTPATH = expand("$HOME/.dotfiles")
let $CUSDATA = expand("$HOME/.dotfiles/data/vimdata")
let $ZGEN_FZF = expand("$HOME/.zgen/junegunn/fzf-master/")
if isdirectory(expand("$HOME/.vim/bundle"))
    let $BUNDLE = expand("$HOME/.vim/bundle")
else
    let $BUNDLE = expand("$CUSDATA/bundle")
endif
let $VIMCONFIG = expand("$CUSDATA/config")
let $PLUG_DIR = expand("$CUSDATA/vim-plug")
"}}}

" init "{{{
if has('vim_starting')
    let $ORIG_PWD = getcwd()
    source $VIMCONFIG/init.vim
endif

source $VIMCONFIG/functions.vim
"}}}

" Include Plug "{{{
source $PLUG_DIR/plug.vim
call plug#begin(expand($BUNDLE))
Plug expand('$CUSDATA/LocalBundle/tags4proj')
Plug expand('$CUSDATA/LocalBundle/MyPlugins')
Plug expand('$CUSDATA/LocalBundle/paste')

" Highligts multiple words
Plug 'https://github.com/dimasg/vim-mark'

" Plug 'https://github.com/ianva/vim-youdao-translater.git', {'on': ['Ydc', 'Yde', 'Ydv']}
" Plug 'https://github.com/vim-scripts/DirDiff.vim.git', {'on': ['DirDiff']}

" BundleList "{{{
Plug 'https://github.com/junegunn/fzf.vim.git' ", { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'https://github.com/vim-scripts/ingo-library' " need by PatternsOnText
" Plug 'https://github.com/vim-scripts/PatternsOnText'
Plug 'https://github.com/vim-scripts/ExtractMatches'
" Plug 'https://github.com/mtth/scratch.vim'
Plug 'https://github.com/AndrewRadev/linediff.vim'
Plug 'https://github.com/wincent/vim-clipper'
Plug 'chrisbra/vim-diff-enhanced'
" NeoBundle 'https://github.com/junegunn/goyo.vim'
" NeoBundle 'https://github.com/junegunn/limelight.vim'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-repeat.git'
" Plug 'https://github.com/christoomey/vim-titlecase'
Plug 'https://github.com/vim-scripts/VisIncr.git'
Plug 'https://github.com/triglav/vim-visual-increment'
Plug 'https://github.com/Raimondi/delimitMate.git'
" Plug 'https://github.com/bruno-/vim-man'
Plug 'https://github.com/zenbro/mirror.vim'
Plug 'https://github.com/hiberabyss/vim-gradle'
" NeoBundle 'https://github.com/ludovicchabant/vim-gutentags'
" NeoBundle 'https://github.com/MattesGroeger/vim-bookmarks'

" Test " {{{
Plug 'https://github.com/janko-m/vim-test'
Plug 'https://github.com/alepez/vim-gtest'
"}}}

" Google Plugins"{{{
" Plug 'google/vim-syncopate'
"}}}

" NeoBundle 'https://github.com/jiangmiao/auto-pairs.git'

" Coding plugins "{{{
" NeoBundle 'https://github.com/neovimhaskell/haskell-vim'
" NeoBundle 'https://github.com/eagletmt/neco-ghc'
"}}}

" NeoBundle 'https://github.com/xolox/vim-notes.git'
" Plug 'https://github.com/tpope/vim-speeddating.git'
" NeoBundle 'https://github.com/benmills/vimux.git'
Plug 'https://github.com/chrisbra/NrrwRgn.git'
" NeoBundle 'https://github.com/ludovicchabant/vim-gutentags'

" NeoBundle 'https://github.com/junkblocker/patchreview-vim'
" NeoBundle 'https://github.com/roxma/vim-tmux-clipboard'
"}}}
" Plug 'https://github.com/kshenoy/vim-signature.git', { 'on': ['SignatureToggle']}
Plug 'https://github.com/hiberabyss/changesqlcase.vim', {'on': 'ChangeSqlCase'}
" Plug 'https://github.com/junegunn/vim-peekaboo'

Plug 'https://github.com/saltstack/salt-vim', {'for': 'sls'}

source $VIMCONFIG/ctrlp.vim
" source $VIMCONFIG/sqlclient.vim
source $VIMCONFIG/unite.vim
source $VIMCONFIG/ide.vim

" source $VIMCONFIG/filetype.vim
source $VIMCONFIG/theme.vim
source $VIMCONFIG/edit.vim
source $VIMCONFIG/search.vim
source $VIMCONFIG/motion.vim
" source $VIMCONFIG/integration.vim

source $VIMCONFIG/website.vim
source $VIMCONFIG/writting.vim
source $VIMCONFIG/notes.vim
source $VIMCONFIG/git.vim
" source $VIMCONFIG/VersionControlSystem.vim

source $VIMCONFIG/textobj.vim

source $VIMCONFIG/filetypes.vim
source $VIMCONFIG/utilities.vim

if has('nvim')
    source $VIMCONFIG/nvim.vim
endif

" Should run at last
call plug#end()

" vim plug "{{{
function! GetPlugNameFronCurrentLine(cmd)
    let plugin_name = getline(".")
	let plugin_name = split(split(plugin_name, "'")[1], '/')[-1]
	let plugin_name = substitute(plugin_name, '\.git$', '', 'g')
	execute(a:cmd .' '. plugin_name)
endfunction

nmap ,pi :w<cr>:call GetPlugNameFronCurrentLine('PlugInstall')<cr>
nmap ,pI :PlugInstall<cr>
nmap ,pu :call GetPlugNameFronCurrentLine('PlugUpdate')<cr>
nmap ,pU :PlugUpdate<cr>
"}}}
"}}}

source $VIMCONFIG/mappings.vim
source $VIMCONFIG/commands.vim

" NrrwRgn "{{{
function! FilterComment()
	let comment_string = &commentstring
	let comment_string = split(split(comment_string, '%')[0])[0]
	let filter_pattern = "^" .comment_string. "\\|^$"
	execute(":v/" .filter_pattern. "/NRP")
	execute(":NRMulti")
endfunction

command! -nargs=0 FilterComment call FilterComment()
"}}}

" vim test"{{{
" nmap <silent> <leader>N :TestNearest<CR>
function! CreateNewTest()
    if &ft == 'javascript'
        execute('new spec/' . expand('%:t:r') . '.spec.js')
    endif
endfunction

command! TN call CreateNewTest()

nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>A :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>G :TestVisit<CR>

let test#strategy = 'neovim'
"}}}

" Line Diff"{{{
autocmd User LinediffBufferReady nnoremap <buffer> q :LinediffReset<cr>
autocmd User LinediffBufferReady setl wrap
nmap <Leader>ld :Linediff<cr>
vmap <Leader>ld :Linediff<cr>
"}}}

" fzf "{{{
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

" text edit "{{{
" nmap ,a; A;<ESC>

nmap <silent> ,af :exec append(line('$'), " vim:fdm=marker")<cr>G\cc
"}}}

" vimux config "{{{
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vi :VimuxInspectRunner<CR>
nmap <Leader>vq :VimuxCloseRunner<CR>
nmap <Leader>vz :VimuxZoomRunner<CR>
"}}}

" xmledit"{{{
let g:xml_syntax_folding=1
au! FileType xml,html setlocal foldmethod=syntax
"}}}

" orgmode "{{{
let g:org_agenda_files = ['~/orgmod/*.org']
"}}}

" ColorsSolarized "{{{
let g:solarized_termtrans = 1
if has('vim_starting')
    " when reload colorscheme, some abnormal thing with airline
    set background=dark
    colorscheme solarized
endif
"}}}

" Youdao Translater "{{{
" vnoremap <silent> ,tv <Esc>:Ydv<CR>
" nnoremap <silent> ,tw <Esc>:Ydc<CR>
" noremap <silent> ,te <Esc>:Yde<CR>
"}}}

" neovim gdb "{{{
let g:nvimgdb_host_cmd = {
            \ 'dr01' : ['cads', 'gdb -f ./ads'],
            \ 'd32' : ['cads', 'gdb -f ./ads'],
            \ '1085' : ['cd ~/hbliu', 'sudo gdb --pid `cat /ads-debug/run/ads-eng.pid` -f'],
            \ 'ts1' : ['Docker', 'gdb -q -f --pid `pgrep transcoding`'],
            \ 'ts' : ['Docker', 'gdb -q -f --pid `pgrep transcoding`'],
            \ }
"}}}

" EasyAlign "{{{
vmap <Enter> <Plug>(EasyAlign)
"}}}

" limelight"{{{
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
" let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
xmap <Leader>ll <Plug>(Limelight)
nmap <Leader>L :Limelight!<cr>
"}}}

" goyo"{{{
function! s:goyo_enter()
  silent !tmux set status off
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()

" let g:goyo_width = 80
" let g:goyo_height = 85%
" let g:goyo_linenr = 0
"}}}

" cmdline setting"{{{
cnoremap <C-A> <Home>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-d> <S-Right><C-w>
" select last paste content
" nnoremap <expr> ,gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"}}}

" Mouse"{{{
set mouse=n
" nmap ,m :set mouse=n<cr>:call ShowMsg("Enable Mouse")<cr>
" nmap ,M :set mouse=<cr>:call ShowMsg("Disable Mouse")<cr>
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
autocmd! FileType cpp setl completefunc=RtagsCompleteFunc
"}}}

" Tags and Cscope Manage"{{{
function! AddCscopeCon()
    if filereadable("cscope.out") && !cscope_connection(getcwd())
        execute("cs add cscope.out " . getcwd() )
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endfunction

" nmap ,gc :!cscope -Rbq<cr> 
" nmap silent <A-]> <C-w>]
vnoremap <C-]> "vy:tag /<c-r>v<cr> " / represent not exactly match
"}}}

" cfile settings"{{{
nmap <silent> ,gf ,cd:vsplit <cfile><cr>
nmap <silent> ,gt :tabnew <cfile><cr>
"}}}

" fold settings"{{{
if has('vim_starting')
    set foldlevelstart=3
    " set fdm=syntax
endif

"set fdo-=search " 'foldopen' To search only in open folds 

function! CallRepeat(funcHandler)
    let countRepeat = v:count1
    while countRepeat > 0
        execute('call ' . a:funcHandler)
        let countRepeat -= 1
    endwhile
endfunction

function! NavigateFolds(direction, foldStatus)
    if a:direction " == "next"
        normal zj
        let posDelta = 1
    else
        normal zk
        let posDelta = -1
    endif
    let curLineNum = line('.')

    if a:foldStatus " == "closed"
        while foldclosed(curLineNum) == -1
            let curLineNum += posDelta
        endwhile
    else
        while foldclosed(curLineNum) != -1
            let curLineNum += 1
        endwhile
    endif
    call cursor(curLineNum, 0)
endfunction

nmap ,fs :setl fdm=syntax<cr>
nmap ,f[ :setl fmr={,}<cr>:setl fdm=marker<cr>
nmap ,fn :setl fdm=manual<cr>

" nnoremap <Tab> za
command! -nargs=1 -bar RepeatFunc call CallRepeat(<f-args>)
nmap <silent> ,zj :<c-u>RepeatFunc NavigateFolds(1, 1)<cr>  
nmap <silent> ,zk :<c-u>RepeatFunc NavigateFolds(0, 1)<cr>
"}}}

" scratch "{{{
let g:scratch_insert_autohide = 0
"}}}

if has('vim_starting')
	source $VIMCONFIG/autocmds.vim
	autocmd BufWritePost $VIMCONFIG/* source ~/.vimrc
endif

highlight TermCursor ctermfg=red guifg=red

" vim:set fdm=marker:
