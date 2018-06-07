" System Move "{{{
noremap <silent> <Up> <C-y>
noremap <silent> <Down> <C-e>
"}}}

" cmdline setting "{{{
cnoremap <C-A> <Home>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <M-d> <S-Right><C-w>
" select last paste content
nnoremap <expr> ,gp '`[' . strpart(getregtype(), 0, 1) . '`]'
"}}}

" Insert Mode rsi "{{{
inoremap <M-f> <S-Right>
inoremap <M-b> <S-Left>
inoremap <C-e> <End>
"}}}
" QuickMotion"{{{
let g:motionKeyMaps = {
            \ 'u': '<C-u>',
            \ 'd': '<C-d>',
            \ '<Up>': '<C-y>',
            \ '<Down>': '<C-e>',
            \ 'p': '<C-b>',
            \ '<Left>': 'zh',
            \ '<Right>': 'zl',
            \ 'q': ':q<CR>',
            \}

let s:motionMapOpt = ' <nowait> <silent> <buffer> '
let s:checkMapMode = 'n'

function! LoadMotionMap()
    for [k, v] in items(g:motionKeyMaps)
        execute(s:checkMapMode . 'noremap' . s:motionMapOpt . k . ' ' . v)
    endfor
endfunction

function! UnloadMotionMap()
    for [k, v] in items(g:motionKeyMaps)
        execute(s:checkMapMode . 'unmap <buffer> ' . k)
    endfor
endfunction

nmap <silent> ,qm :call LoadMotionMap()<cr>:call util#ShowMsg("Enable Motion Keybingds")<CR>
nmap <silent> ,qM :call UnloadMotionMap()<cr>:call util#ShowMsg("Disable Motion Keybingds")<CR>

autocmd FileType help,man call LoadMotionMap()
"}}}

" mouse scroll "{{{
" map <ScrollWheelLeft> zh
"}}}

" Window Management"{{{

let g:winMoveKeyMap = {
			\ '<A-j>': 'j',
			\ '<A-k>': 'k',
			\ '<A-h>': 'h',
			\ '<A-l>': 'l',
			\ '<A-;>': 'p',
			\ }

function! LoadWinMoveMap()
	for [k, v] in items(g:winMoveKeyMap)
		execute(printf("inoremap <silent> %s <ESC>:call util#RestoreWindowSize()<cr><C-w>%s", k, v))
		execute(printf("nnoremap <silent> %s :call util#RestoreWindowSize()<cr><C-w>%s", k, v))
		if has('nvim')
			execute(printf("tnoremap <silent> %s \<C-\><C-n>:call util#RestoreWindowSize()<cr><C-w>%s", k, v))
		endif
	endfor
endfunction
call LoadWinMoveMap()

nmap <silent> [wq :copen<cr>
nmap <silent> ]wq :cclose<cr>
nmap <silent> [wl :lopen<cr>
nmap <silent> ]wl :lclose<cr>

map <silent> <A-\> :call util#WindowMaxToggle()<cr>
map <silent> <A-w> <ESC><C-w>w:call util#WindowMaxToggle()<cr>

nmap ,cd :lcd %:p:h<CR>
nmap <silent> ,cw :cd $ORIG_PWD<cr>
nmap ,rc :tabnew ~/.vimrc<cr>

nmap ,co :Capture 

function! QuickfixItemJump(direction, mode, count)
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif
  let i = 0
  while i < a:count
    let i += 1
    " saving current position
    let line = line('.')
    let col  = col('.')
    let pos = search('^[^|]\+', 'W'.a:direction)
    " if there are no more matches, return to last position
    if pos == 0
      call cursor(line, col)
      return
    endif
  endwhile
endfunction

function! BufferNowaitMap()
    " setl nowrap
    call LoadMotionMap()
    nnoremap <silent> <buffer> [[ :<C-U>call QuickfixItemJump('b', 'n', v:count1)<CR>
    nnoremap <silent> <buffer> ]] :<C-U>call QuickfixItemJump('' , 'n', v:count1)<CR>

    nnoremap <silent> <buffer> <C-t> <C-W><Enter><C-W>T
    nnoremap <silent> <buffer> <C-s> <C-W><Enter>
    nnoremap <silent> <buffer> <C-v> <C-W><Enter><C-W>H

    nmap <nowait> <buffer> <silent> q :q<cr>
    nmap <nowait> <buffer> <silent> x :call util#WindowMaxToggle()<cr>
    setl wrap
endfunction

" cmdline window :h cmdline

" au CmdwinEnter [:>] iunmap <Tab>
" au CmdwinEnter [:>] nunmap <Tab>
autocmd! CmdwinEnter [:/?>] call BufferNowaitMap()
" autocmd! QuickFixCmdPost lopen call BufferNowaitMap()
" autocmd! QuickFixCmdPre lopen call BufferNowaitMap()
autocmd! BufReadPost quickfix call BufferNowaitMap()
autocmd! BufReadPost location call BufferNowaitMap()
"}}}

" Clipboard Management"{{{
let g:clipboard_reg = '+'
if has("mac")
    let g:clipboard_reg = '*'
endif

function! PasteFromClipboard()
    if has("mac")
        let @* = substitute(@*, '\r', '' ,'g')
    endif
endfunction

if empty($SSH_CLIENT)
    nmap <expr> <silent> ,ya ':%yank ' . g:clipboard_reg . '<CR>'
    nmap <silent> ,yc :let @+ = printf("```\n%s\n```", @+)<CR>
    nmap <silent> cp" :let @+ = @"<CR>
    nmap <silent> cp/ :let @+ = @/<CR>
    vmap <expr> <silent> ,y '"' .g:clipboard_reg. 'y'
    nmap <expr> <silent> ]v ':call PasteFromClipboard()<cr>"' .g:clipboard_reg. 'p'
    nmap <expr> <silent> [v ':call PasteFromClipboard()<cr>"' .g:clipboard_reg. 'P'
    nmap <expr> <silent> cpp ':let @" = expand("%:p")<cr>:let @' .g:clipboard_reg. ' = @"<cr>:call util#ShowMsg("File Path Copied!")<cr>'
else
    nmap <silent> ,ya :%yank<cr>:Clip<cr>
    nmap <silent> ,yy yy:Clip<cr>
    vmap <silent> ,y y:Clip<cr>
endif
"}}}

nmap Y y$

" Motion Setttings"{{{
" nmap [[ ?{<CR>w99[{
" nmap ][ /}<CR>b99]}
" nmap ]] j0[[%/{<CR>
" nmap [] k$][%?}<CR>

nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

nmap <silent> [[ m':call search('{', 'b')<CR>:keepjumps normal w99[{<CR>
nmap <silent> ][ m':call search('}')<CR>b99]}
nmap <silent> ]] j0[[%m':call search('{')<CR>
nmap <silent> [] k$][%m':call search('}')<CR>

nnoremap ,, ,
xnoremap ,, ,
onoremap ,, ,

vnoremap < <gv
vnoremap > >gv
"}}}

" Search Settings "{{{
vmap <silent> ,/ "vy:let @/=@v<cr>:set hls<cr>:SearchIndex<cr>
nmap <silent> ,/ :let @/=expand("<cword>")<cr>:set hls<cr>:SearchIndex<cr>
vmap <silent> ,? "vy:let @/="\\<<c-r>v\\>"<cr>:set hls<cr>:SearchIndex<cr>
nmap <silent> ,? :let @/="\\<" . expand('<cword>') . "\\>"<cr>:set hls<cr>:SearchIndex<cr>
nmap <silent> ,l/ /<Up><cr>
"}}}

" tab page manipulate"{{{
function! CloseTab(cmdFlg)
    let closeCmd = 'tabclose' . a:cmdFlg

    if tabpagenr() != tabpagenr('$')
        let closeCmd .= '|tabprev'
    endif

    execute(closeCmd)
endfunction

" Switch to last-active tab
if !exists('g:Lasttab')
	let g:Lasttab = 1
	let g:Lasttab_backup = 1
endif
autocmd! TabLeave * let g:Lasttab_backup = g:Lasttab | let g:Lasttab = tabpagenr()

if v:version >= 800 || has('nvim')
	autocmd! TabClosed * let g:Lasttab = g:Lasttab_backup
endif

map <silent> <A-'> :exe "tabn " . g:Lasttab<cr>
imap <silent> <A-'> <ESC>:exe "tabn " . g:Lasttab<cr>

nmap <Space>gc :call CloseTab('')<cr>
nmap <Space>gC :call CloseTab('!')<cr>
"}}}

" utility map"{{{
nmap <silent> ,cf :CheckPath<cr>

nmap <silent> ,pd :call util#TimestampToDate(expand("<cword>"))<cr>
"}}}

" decode encode "{{{
nmap <silent> ]6 :set opfunc=util#DecodeBase64Str<cr>g@
vmap <silent> ]6 :<c-u>call util#DecodeBase64Str(visualmode(), 1)<cr>

nmap <silent> ,dh :set opfunc=util#DecodeHex2Str<cr>g@
vmap <silent> ,dh :<c-u>call util#DecodeHex2Str(visualmode(), 1)<cr>
"}}}

" fold "{{{
command! -nargs=1 -bar RepeatFunc call fold#CallRepeat(<f-args>)
nmap <silent> ,zj :<c-u>RepeatFunc fold#NavigateFolds(1, 1)<cr>  
nmap <silent> ,zk :<c-u>RepeatFunc fold#NavigateFolds(0, 1)<cr>
"}}}

" vim:set fdm=marker:
