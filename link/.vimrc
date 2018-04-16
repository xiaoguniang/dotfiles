" Variables "{{{
let $DOTPATH = expand("$HOME/.dotfiles")
let $CUSDATA = expand("$HOME/.dotfiles/data/vimdata")
if isdirectory(expand("$HOME/.vim/bundle"))
    let $BUNDLE = expand("$HOME/.vim/bundle")
else
    let $BUNDLE = expand("$CUSDATA/bundle")
endif
let $VIMCONFIG = expand("$CUSDATA/config")
let $PLUG_DIR = expand("$BUNDLE/vim-plug")
"}}}

" init "{{{
if has('vim_starting')
    let $ORIG_PWD = getcwd()
    source $VIMCONFIG/init.vim
endif

source $VIMCONFIG/functions.vim
"}}}

" Include Plug "{{{
if empty(glob(expand("$PLUG_DIR/plug.vim")))
  silent !curl -fLo $PLUG_DIR/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
source $PLUG_DIR/plug.vim

call plug#begin(expand($BUNDLE))
Plug expand('$CUSDATA/LocalBundle/tags4proj')
Plug expand('$CUSDATA/LocalBundle/MyPlugins')
Plug expand('$CUSDATA/LocalBundle/paste')
Plug expand('$CUSDATA/LocalBundle/RemoteCompile')
Plug 'https://github.com/hiberabyss/FileJumper'

Plug 'https://github.com/vim-scripts/ExtractMatches'
Plug 'https://github.com/AndrewRadev/linediff.vim'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/vim-scripts/VisIncr.git'
Plug 'https://github.com/janko-m/vim-test'
Plug 'https://github.com/chrisbra/NrrwRgn.git'

" Plug 'https://github.com/dimasg/vim-mark' " Highligts multiple words

" Plug 'https://github.com/ianva/vim-youdao-translater.git', {'on': ['Ydc', 'Yde', 'Ydv']}
" Plug 'https://github.com/vim-scripts/DirDiff.vim.git', {'on': ['DirDiff']}

" BundleList "{{{
" Plug 'https://github.com/vim-scripts/ingo-library' " need by PatternsOnText
" Plug 'https://github.com/vim-scripts/PatternsOnText'
" Plug 'https://github.com/mtth/scratch.vim'
" Plug 'chrisbra/vim-diff-enhanced'
" NeoBundle 'https://github.com/junegunn/goyo.vim'
" NeoBundle 'https://github.com/junegunn/limelight.vim'
" Plug 'https://github.com/christoomey/vim-titlecase'
" Plug 'https://github.com/triglav/vim-visual-increment'
" NeoBundle 'https://github.com/ludovicchabant/vim-gutentags'
" NeoBundle 'https://github.com/MattesGroeger/vim-bookmarks'

" NeoBundle 'https://github.com/xolox/vim-notes.git'
" Plug 'https://github.com/tpope/vim-speeddating.git'
" NeoBundle 'https://github.com/benmills/vimux.git'
" NeoBundle 'https://github.com/ludovicchabant/vim-gutentags'

" NeoBundle 'https://github.com/junkblocker/patchreview-vim'
"}}}
" Plug 'https://github.com/kshenoy/vim-signature.git', { 'on': ['SignatureToggle']}
" Plug 'https://github.com/junegunn/vim-peekaboo'

" source $VIMCONFIG/sqlclient.vim
" source $VIMCONFIG/VersionControlSystem.vim

source $VIMCONFIG/ctrlp.vim
source $VIMCONFIG/unite.vim
source $VIMCONFIG/ide.vim

source $VIMCONFIG/theme.vim
source $VIMCONFIG/edit.vim
source $VIMCONFIG/search.vim
source $VIMCONFIG/motion.vim

source $VIMCONFIG/website.vim
source $VIMCONFIG/writting.vim
source $VIMCONFIG/notes.vim
source $VIMCONFIG/git.vim

source $VIMCONFIG/textobj.vim
source $VIMCONFIG/filetypes.vim
source $VIMCONFIG/utilities.vim

if has('nvim')
    source $VIMCONFIG/nvim.vim
endif

call plug#end() " Should run at last

" vim plug "{{{
function! GetPlugNameFronCurrentLine(cmd)
    let plugin_name = getline(".")

    if plugin_name !~ "^Plug"
        execute(a:cmd . '!')
        return
    endif

	let plugin_name = split(split(plugin_name, "'")[1], '/')[-1]
	let plugin_name = substitute(plugin_name, '\.git$', '', 'g')
	execute(a:cmd .' '. plugin_name)
endfunction

nmap ,pi :w<cr>:call GetPlugNameFronCurrentLine('PlugInstall')<cr>
nmap ,pI :PlugInstall<cr>
nmap ,pu :call GetPlugNameFronCurrentLine('PlugUpdate')<cr>
nmap ,pU :PlugUpdate<cr>

function! s:plug_loaded(spec)
  let rtp = join(filter([a:spec.dir, get(a:spec, 'rtp', '')], 'len(v:val)'), '/')
  return stridx(&rtp, rtp) >= 0 && isdirectory(rtp)
endfunction

function! s:plug_names(...)
    return sort(filter(keys(filter(copy(g:plugs), { k, v -> !s:plug_loaded(v) })), 'stridx(v:val, a:1) != -1'))
endfunction

command! -nargs=+ -bar -complete=customlist,s:plug_names PlugLoad call plug#load([<f-args>])
"}}}

"}}}

source $VIMCONFIG/mappings.vim
source $VIMCONFIG/commands.vim

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

" goyo "{{{
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
