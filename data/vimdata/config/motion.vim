Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'rhysd/clever-f.vim'
" Plug 'https://github.com/vim-scripts/camelcasemotion.git'

" Easymotion"{{{
let g:EasyMotion_leader_key = '<Space>'
" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade  Comment
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
nmap <Space>, <Plug>(easymotion-next)
nmap <silent> <Space>2 <Plug>(easymotion-s2)
vmap <silent> <Space>2 <Plug>(easymotion-s2)
nmap <Space>; <Plug>(easymotion-prev)
nmap <Space>r <Plug>(easymotion-repeat)
map <Space>l <Plug>(easymotion-lineanywhere)
nmap <Space>S <Plug>(easymotion-overwin-w)
" omap t <Plug>(easymotion-t)
" vmap t <Plug>(easymotion-t)
" omap <Space> <Plug>(easymotion-s)
" vmap <Space> <Plug>(easymotion-s)
"}}}

" camelcasemotion"{{{
" map <silent> ,bb <Plug>CamelCaseMotion_b
"}}}

" vim:set fdm=marker:
