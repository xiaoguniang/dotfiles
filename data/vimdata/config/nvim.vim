Plug 'https://github.com/kassio/neoterm'
" Plug 'https://github.com/jalvesaq/vimcmdline'
" Plug 'https://github.com/brettanomyces/nvim-editcommand'

" neoterm "{{{
let g:neoterm_size = '12'
let g:neoterm_fixedsize = 1
let g:neoterm_autoinsert = 1
let g:neoterm_open_in_all_tabs = 1
" let g:neoterm_focus_when_tests_fail = 1
let g:neoterm_keep_term_open = 1
let g:neoterm_autoscroll = 1
nmap <silent> ,to :Topen<cr>
" nmap <silent> ,tt :Ttoggle<cr>
nmap <buffer> ,rl :TREPLSendLine<cr>
nmap <buffer> ,rs :TREPLSendSelection<cr>
nmap <buffer> ,rf :TREPLSendFile<cr>
"}}}

" neovim "{{{
if exists('&inccommand')
	set inccommand=split
endif

tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <A-q> <C-\><C-n><C-w>c
" tnoremap <A-\> <c-\><c-n>"*pi
" tnoremap <C-v> <c-\><c-n>"*pi
" tnoremap <D-v> <c-\><c-n>"*pi
tnoremap <A-\> <c-\><c-n>:call WindowMaxToggle()<cr>i

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

inoremap <A-h> <ESC><C-w>h
inoremap <A-j> <ESC><C-w>j
inoremap <A-k> <ESC><C-w>k
inoremap <A-l> <ESC><C-w>l

" scroll other window
function! ScrollOtherWindow(scroll_cmd)
	if tabpagewinnr(tabpagenr(), '$') > 1
		wincmd w
		execute("normal " . a:scroll_cmd)
		wincmd w
	endif
endfunction

nnoremap <silent> <A-y> <esc>:call ScrollOtherWindow("\<lt>C-y>")<cr>
nnoremap <silent> <A-e> <esc>:call ScrollOtherWindow("\<lt>C-e>")<cr>
nnoremap <silent> <A-J> <esc>:call ScrollOtherWindow("\<lt>C-d>")<cr>
nnoremap <silent> <A-K> <esc>:call ScrollOtherWindow("\<lt>C-u>")<cr>
"}}}

" terminal "{{{
function! TermInit()
    silent setl winfixheight
    setl nonumber
    setl norelativenumber
    startinsert
    call LoadMotionMap()
endfunction

autocmd! WinEnter term://* call TermInit()
autocmd! BufWinLeave term://* wincmd p
"}}}

 " vim:fdm=marker
