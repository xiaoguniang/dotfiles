Plug 'https://github.com/kana/vim-textobj-user' " needs by other text plugin
" Plug 'https://github.com/rhysd/vim-textobj-continuous-line'
Plug 'https://github.com/kana/vim-textobj-function'
" Plug 'https://github.com/haya14busa/vim-textobj-function-syntax'
Plug 'https://github.com/machakann/vim-textobj-delimited'
Plug 'https://github.com/coderifous/textobj-word-column.vim'
" Plug 'https://github.com/kana/vim-textobj-entire'
Plug 'https://github.com/glts/vim-textobj-comment'
Plug 'https://github.com/whatyouhide/vim-textobj-xmlattr'
Plug 'https://github.com/mattn/vim-textobj-url'
Plug 'https://github.com/sgur/vim-textobj-parameter'
Plug 'https://github.com/thinca/vim-textobj-between'
Plug 'https://github.com/kana/vim-textobj-indent'
" Plug 'https://github.com/saaguero/vim-textobj-pastedtext'
Plug 'https://github.com/bps/vim-textobj-python', {'for': 'python'}
Plug 'https://github.com/christoomey/vim-system-copy'
" Plug 'https://github.com/kana/vim-textobj-line'
" Plug 'https://github.com/kana/vim-operator-user'
" Plug 'https://github.com/machakann/vim-operator-insert'
" Plug 'https://github.com/kana/vim-textobj-fold'
" Plug 'https://github.com/vimtaku/vim-textobj-keyvalue'

" Plug 'https://github.com/libclang-vim/libclang-vim' ", {'do': 'make', 'for': ['cpp', 'c']}
" Plug 'https://github.com/libclang-vim/vim-textobj-clang'
" let g:textobj_clang_more_mappings = 1

" textobj pastedtext
" let g:pastedtext_select_key = 'ip'

nmap <silent> cpl ^cp$

" textobj python
let g:textobj_python_no_default_key_mappings = 1

" nmap ;i  <Plug>(operator-insert-i)
" xmap ;i  <Plug>(operator-insert-i)
" nmap ;a  <Plug>(operator-insert-a)
" xmap ;a  <Plug>(operator-insert-a)

 " vim:fdm=marker
