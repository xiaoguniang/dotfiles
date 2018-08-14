" Variables "{{{
let $DOTPATH = expand('$HOME/.dotfiles')
let $CUSDATA = expand('$HOME/.dotfiles/data/vimdata')
let $BUNDLE = expand('$CUSDATA/bundle')
let $VIMCONFIG = expand('$CUSDATA/config')
let $PLUG_DIR = expand('$BUNDLE/vim-plug')
"}}}

" init "{{{
if has('vim_starting')
    let $ORIG_PWD = getcwd()
    source $VIMCONFIG/init.vim
endif
"}}}

" Include Plug "{{{
if empty(glob(expand('$PLUG_DIR/plug.vim')))
  silent !curl -fLo $PLUG_DIR/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup plug_install
      autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
  augroup END
endif
source $PLUG_DIR/plug.vim

call plug#begin(expand($BUNDLE))
Plug expand('$CUSDATA/LocalBundle/MyPlugins')
Plug expand('$CUSDATA/LocalBundle/paste')
Plug expand('$CUSDATA/LocalBundle/RemoteCompile')
" Plug 'https://github.com/hiberabyss/FileJumper'
" Plug 'https://github.com/yuratomo/w3m.vim'

Plug 'https://github.com/vim-scripts/ExtractMatches'
Plug 'https://github.com/AndrewRadev/linediff.vim'
Plug 'https://github.com/tpope/vim-repeat.git'
Plug 'https://github.com/chrisbra/NrrwRgn.git'

" Plug 'https://github.com/dimasg/vim-mark' " Highligts multiple words

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
" NeoBundle 'https://github.com/MattesGroeger/vim-bookmarks'

" Plug 'https://github.com/tpope/vim-speeddating.git'

" NeoBundle 'https://github.com/junkblocker/patchreview-vim'
"}}}
" Plug 'https://github.com/kshenoy/vim-signature.git', { 'on': ['SignatureToggle']}
" Plug 'https://github.com/junegunn/vim-peekaboo'

" source $VIMCONFIG/sqlclient.vim
source $VIMCONFIG/VersionControlSystem.vim

source $VIMCONFIG/ctrlp.vim
source $VIMCONFIG/unite.vim
source $VIMCONFIG/ide.vim
source $VIMCONFIG/test.vim

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

" source $VIMCONFIG/tencent.vim

if has('nvim')
    source $VIMCONFIG/nvim.vim
endif

call plug#end() " Should run at last
"}}}

" vim plug "{{{
nmap ,pi :w<cr>:call plug#GetPlugNameFronCurrentLine('PlugInstall')<cr>
nmap ,pu :call plug#GetPlugNameFronCurrentLine('PlugUpdate')<cr>
command! -nargs=+ -bar -complete=customlist,plug#plug_names PlugLoad call plug#load([<f-args>])
"}}}

source $VIMCONFIG/mappings.vim
source $VIMCONFIG/commands.vim

" Line Diff"{{{
autocmd User LinediffBufferReady nnoremap <buffer> q :LinediffReset<cr>
autocmd User LinediffBufferReady setl wrap
nmap <Leader>ld :Linediff<cr>
vmap <Leader>ld :Linediff<cr>
"}}}

" text edit "{{{
nmap <silent> ,af :exec append(line('$'), " vim:fdm=marker")<cr>G\cc
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
    if filereadable('cscope.out') && !cscope_connection(getcwd())
        execute('cs add cscope.out ' . getcwd() )
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endfunction

vnoremap <C-]> "vy:tag /<c-r>v<cr> " / represent not exactly match
"}}}

" fold settings "{{{
if has('vim_starting')
    set foldlevelstart=3
    set foldcolumn=0
    " set fdm=syntax
endif

"set fdo-=search " 'foldopen' To search only in open folds 

nmap ,fs :setl fdm=syntax<cr>
nmap ,f[ :setl fmr={,}<cr>:setl fdm=marker<cr>
nmap ,fn :setl fdm=manual<cr>
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
