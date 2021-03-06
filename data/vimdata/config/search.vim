Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/dyng/ctrlsf.vim'
Plug 'https://github.com/google/vim-searchindex'
Plug 'https://github.com/mhinz/vim-grepper'
Plug 'https://github.com/sk1418/QFGrep'
" Plug 'https://github.com/dkprice/vim-easygrep'
" Plug 'https://github.com/salsifis/vim-qfmanip'

" ctrlSF"{{{
let g:ctrlsf_default_root = 'cwd'
let g:ctrlsf_position = 'bottom'

nmap     <Leader>ff <Plug>CtrlSFPrompt
vmap     <Leader>fF <Plug>CtrlSFVwordPath
vmap     <Leader>ff <Plug>CtrlSFVwordExec
nmap     <Leader>fN <Plug>CtrlSFCwordPath
nmap     <Leader>fn <Plug>CtrlSFCwordPath<cr>
nmap     <Leader>fp <Plug>CtrlSFPwordPath
nnoremap <Leader>fo :CtrlSFOpen<CR>
nnoremap <Leader>ft :CtrlSFToggle<CR>
inoremap <Leader>ft <Esc>:CtrlSFToggle<CR>
"}}}

" vim grepper "{{{
nmap ,s  <plug>(GrepperOperator)
xmap ,s  <plug>(GrepperOperator)
nmap <silent> <Leader>vv :<c-u>Grepper -cword<cr>
let g:grepper = {}
let g:grepper.highlight = 1
let g:grepper.prompt = 0
"}}}

" Ack "{{{
" cnoreabbrev Ack Ack!
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nmap ,ag :Ack! -Q 
"}}}

" EasyGrep "{{{
set grepprg=ag\ --nocolor\ --nogroup\ --vimgrep
" set grepprg=rg\ -u\ --vimgrep\ $*
" set grepformat=%f:%l:%c:%m

let g:EasyGrepOptionPrefix = ',v'
let g:EasyGrepInvertWholeWord = 1
let g:EasyGrepRecursive = 1
let g:EasyGrepMode = 0 " 0 all files  2 current extension
let g:EasyGrepOpenWindowOnMatch = 1
let g:EasyGrepReplaceAllPerFile = 1
let g:EasyGrepSearchCurrentBufferOnly = 1
" use external grep, better performance than vimgrep, \voc
let g:EasyGrepCommand = 1
" let g:EasyGrepWindow = 0
let g:EasyGrepFilesToExclude = "*.swp,tags"
let g:EasyGrepDefaultUserPattern = "%"
let g:EasyGrepWindowPosition = 'botright'
let g:EasyGrepJumpToMatch = 0
let g:EasyGrepIgnoreCase = 0
let g:EasyGrepHidden = 0
"}}}

function! BatchSearch(filepaths, ...)
    execute(printf("Ack! '%s' %s", join(a:000, '.*'), join(a:filepaths)))
endfunction

" Config File Search {{{
command! -nargs=+ Sconfig call BatchSearch([expand("$VIMCONFIG"), expand("$HOME/.vimrc")], <f-args>)
command! -nargs=+ Swiki call BatchSearch([expand("$HOME/vimwiki")], <f-args>)
nmap \sw :Swiki 
"}}}

" vim:fdm=marker
