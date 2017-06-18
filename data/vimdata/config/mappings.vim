" System Move "{{{
noremap <silent> <Up> <C-y>
noremap <silent> <Down> <C-e>
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
            \ '<Left>': '<C-b>',
            \ '<Right>': '<C-f>',
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

nmap <silent> ,qm :call LoadMotionMap()<cr>:call ShowMsg("Enable Motion Keybingds")<CR>
nmap <silent> ,qM :call UnloadMotionMap()<cr>:call ShowMsg("Disable Motion Keybingds")<CR>

autocmd! FileType help,man call LoadMotionMap()
"}}}

" Window Management"{{{
nmap <silent> [wq :copen<cr>
nmap <silent> ]wq :cclose<cr>
nmap <silent> [wl :lopen<cr>
nmap <silent> ]wl :lclose<cr>

map <silent> <A-\> :call WindowMaxToggle()<cr>
map <silent> <A-w> <ESC><C-w>w:call WindowMaxToggle()<cr>

nmap ,c/ :History:<cr>
nmap ,s/ :History/<cr>
nmap ,m/ /<<<<<<<<cr>
nmap ,cd :lcd %:p:h<CR>
nmap <silent> ,cw :cd $ORIG_PWD<cr>
nmap ,rc :tabnew ~/.vimrc<cr>

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
    nmap <nowait> <buffer> <silent> x :call WindowMaxToggle()<cr>
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
    vmap <expr> <silent> ,y '"' .g:clipboard_reg. 'y'
    nmap <expr> <silent> ]v ':call PasteFromClipboard()<cr>"' .g:clipboard_reg. 'p'
    nmap <expr> <silent> [v ':call PasteFromClipboard()<cr>"' .g:clipboard_reg. 'P'
    nmap <expr> <silent> ,yp ':let @" = expand("%:p")<cr>:let @' .g:clipboard_reg. ' = @"<cr>:call ShowMsg("File Path Copied!")<cr>'
else
    nmap <silent> ,ya :%yank<cr>:Clip<cr>
    nmap <silent> ,yy yy:Clip<cr>
    vmap <silent> ,y y:Clip<cr>
endif
"}}}

call yankstack#setup()
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
let g:Lasttab = 1
nmap <silent> ,gl :exe "tabn " . g:Lasttab<cr>
autocmd! TabLeave * let g:Lasttab = tabpagenr()

nmap <Space>gc :call CloseTab('')<cr>
nmap <Space>gC :call CloseTab('!')<cr>
"}}}

" utility map"{{{
nmap <silent> ,cf :CheckPath<cr>

function! TimestampToDate(...)
    let timestamp = expand("<cword>")
    if a:0 > 0
        let timestamp = a:1
    endif

    let origin_TZ = $TZ
    let $TZ = "UTC"
    call ShowMsg(strftime("%Y-%m-%d %T %z", timestamp[0:9]))
    let $TZ = origin_TZ
endfunction
command! -nargs=? PDate call TimestampToDate(<f-args>)

nmap <silent> ,pd :call TimestampToDate(expand("<cword>"))<cr>
"}}}

" vim:set fdm=marker: