Plug 'https://github.com/kassio/neoterm'
" Plug 'https://github.com/jalvesaq/vimcmdline'
" Plug 'https://github.com/brettanomyces/nvim-editcommand'

" neoterm "{{{
let g:neoterm_size = '12'
let g:neoterm_fixedsize = 1
let g:neoterm_autoinsert = 1
" let g:neoterm_split_on_tnew = 1
let g:neoterm_open_in_all_tabs = 1
" let g:neoterm_focus_when_tests_fail = 1
let g:neoterm_keep_term_open = 1
let g:neoterm_autoscroll = 1
nmap <silent> ,to :Topen<cr>
nmap <silent> ,t1 :Topen1<cr>
nmap <silent> ,t2 :Topen2<cr>
nmap <silent> ,t3 :Topen3<cr>
nmap <silent> ,t4 :Topen4<cr>
nmap <silent> ,t5 :Topen5<cr>
nmap <silent> ,t6 :Topen6<cr>
nmap <silent> ,t7 :Topen7<cr>
nmap <silent> ,t8 :Topen8<cr>
nmap <silent> ,t9 :Topen9<cr>
" nmap <silent> ,tt :Ttoggle<cr>
nmap <buffer> ,rl :TREPLSendLine<cr>
nmap <buffer> ,rs :TREPLSendSelection<cr>
nmap <buffer> ,rf :TREPLSendFile<cr>
"}}}

" neovim "{{{
if exists('&inccommand')
	set inccommand=split
endif

" if has('nvim')
  " let $VISUAL = 'nvr -cc split --remote-wait'
" endif

tnoremap <Esc> <C-\><C-n>
tnoremap <A-q> <C-\><C-n><c-w>c<c-w>p
tnoremap <silent> <S-A-q> <c-\><c-n>:bd!<cr>:sleep 80m<cr>:Ttoggle<cr>
tnoremap <silent> <S-A-p> <c-\><c-n>:execute(printf(":T cd %s", getcwd()))<cr>

tnoremap <A-o> <c-\><c-n>:Unite -no-start-insert buffer:t<cr>
tnoremap <silent> <A-\> <c-\><c-n>:call WindowMaxToggle()<cr>i
" tnoremap <A-o> <c-\><c-n>:CtrlSpace a/term/<cr>

tnoremap <silent> <A-[> <c-\><c-n>:Tprevious<cr>
tnoremap <silent> <A-]> <c-\><c-n>:Tnext<cr>

tnoremap <silent> <S-A-n> <c-\><c-n><c-w>c:bo Tnew<cr>

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
nnoremap <silent> <S-A-J> <esc>:call ScrollOtherWindow("\<lt>C-d>")<cr>
nnoremap <silent> <S-A-K> <esc>:call ScrollOtherWindow("\<lt>C-u>")<cr>
"}}}

" terminal "{{{
function! TermInit()
    call LoadMotionMap()
	setlocal winfixheight winfixwidth

    setl nonumber
    setl norelativenumber
	normal G
	" startinsert
endfunction



autocmd! TermOpen * call TermInit()
" autocmd! BufDelete term://* if &ft != 'fzf' | wincmd p | endif
autocmd! BufEnter term://* startinsert
autocmd! BufLeave term://* stopinsert
" autocmd! WinLeave term://* wincmd p
" autocmd! BufWinLeave term://* wincmd p
"}}}

 " vim:fdm=marker
