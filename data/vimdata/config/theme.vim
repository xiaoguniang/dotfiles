" cursor line settings
" set colorcolumn=81
hi ColorColumn ctermbg=black guibg=lightgrey
" hi Normal ctermbg=NONE
" set noshowcmd
" set cursorbind " two window in same line and columon
set cursorline " [oc cul Highlight current line with hl-CursorLine
" set cursorcolumn " [ou cuc Hightlight current columon with hl-CursorColumn

" color theme
set t_Co=256
" set display+=truncate
set display+=lastline
" set display+=uhex " show unprintable char as <xx>

" Theme "{{{
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/bling/vim-airline.git', {'as': 'airline'}
Plug 'https://github.com/jszakmeister/vim-togglecursor'
Plug 'https://github.com/itchyny/vim-cursorword'
Plug 'https://github.com/machakann/vim-highlightedyank'
"}}}

" vim airline "{{{
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" let g:airline_powerline_fonts = 1

" let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_exclude_preview = 0
let g:airline#extensions#nrrwrgn#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#ctrlspace#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
" let g:airline#extensions#whitespace#show_message = 0
" let g:airline_detect_iminsert = 1
" let g:airline_section_z = '%3p%% %#__accent_bold#%{g:airline_symbols.linenr}%#__accent_bold#%2{bufnr("")}%#__restore__#%#__restore__#:%3v' 
nmap <silent> ,af :AirlineRefresh<cr>
"}}}
