let $VIMCACHE = expand("$HOME/.vimcache/")
let s:vim_undodir = expand("$VIMCACHE") . "undo"
let s:vim_backdir = expand("$VIMCACHE") . "backup"
let g:default_session_file = expand("$VIMCACHE") . "session.vim"

if !isdirectory(expand("$VIMCACHE")) && exists("*mkdir")
    call mkdir(s:vim_undodir, "p")
    call mkdir(s:vim_backdir, "p")
endif

execute('set undodir=' . s:vim_undodir)
execute('set backupdir=' . s:vim_backdir)

" Lazy Redraw
" set lazyredraw " :redraw to force draw

" Overall Preference settings"{{{
set hidden
set shortmess+=A

if v:version >= 800 || has('nvim')
	set shortmess+=c
	set nofixendofline
endif

set undofile
set backupext=.bak

set path+=include
set path+=../include

" set cpoptions+=W

set virtualedit=block

set define=^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)
" set wildignore+=*.o
set wildignore+=*.elf

set backspace=indent,eol,start

" set nostartofline

set showcmd
set noshowmode
set modeline
" set isfname-==
set isfname+=?

set number
set relativenumber

set laststatus=2
set ruler
set pumheight=20 " popup menue max items

set complete-=i
set completeopt-=preview

set hlsearch
set incsearch
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :let @/=''<CR><C-L>:<ESC>
endif

" set linebreak
set ignorecase
set fileignorecase
set wildignorecase
set smartcase

if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j " Delete comment character when joining commented lines
	" set fo+=B " when join lines with multi-bytes, without space
endif

if &history < 1000
	set history=1000
endif
if &tabpagemax < 50
	set tabpagemax=50
endif

if !empty(&viminfo)
	set viminfo+=!
endif

" if !has('nvim')
	" execute('set viminfo+=n' .s:vim_backdir)
" else
" if has('nvim')
	" set shada+=%
" endif

if &shell =~# 'fish$'
	set shell=/bin/bash
endif

" popup menu
" set wildmode=longest,full
set wildmenu

if has('autocmd')
	filetype plugin indent on
endif

" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set listchars=tab:\|\ ,trail:•,extends:#,nbsp:.
" set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+

if has('syntax') && !exists('g:syntax_on')
	syntax enable " h syntax_cmd
endif

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
	set t_Co=16
endif

" % match endif and xml node
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
	runtime! macros/matchit.vim
endif

set sessionoptions-=options

nnoremap Q <nop> " disable ex mode

" indent settings"{{{
function! ReplaceTabWithSpace()
	let opt_save = &expandtab
	set expandtab
	retab
	let &expandtab = opt_save
endfunction

command! Retab call ReplaceTabWithSpace()

set autoindent
set smartindent
set tabstop=4
set smarttab
set shiftwidth=4
set shiftround
set cino=N-sg0
set noexpandtab
"}}}

" timout settings"{{{
set ttimeout
set ttimeoutlen=10 " Reduce delay when vim in tmux
"}}}

set fileencodings=utf-8,ucs-bom,latin1,gbk,gb18030,gb2312

set fileformats+=mac
" set fileformat=unix " set ff=mac
" nmap <silent> ,rr :%s/\r//g<cr>

" scroll settings "{{{
set scrolloff=3

if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
"}}}

"}}}

 " vim:fdm=marker
