" Edit related configuration

" vim test"{{{
Plug 'https://github.com/janko-m/vim-test'

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

" vader "{{{
Plug 'https://github.com/junegunn/vader.vim', {'on': ['Vader', 'Vader!']}
"}}}

" vim:set fdm=marker:
