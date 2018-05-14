Plug 'https://github.com/arecarn/vim-selection' " Required by crunch
Plug 'https://github.com/arecarn/vim-crunch'

Plug 'https://github.com/hiberabyss/AnsiEsc'
" Plug 'https://github.com/sk1418/HowMuch'

if ! has('mac')
    Plug 'https://github.com/wincent/vim-clipper'
    " let g:ClipperAuto = 0
endif
Plug 'https://github.com/zenbro/mirror.vim'

" Plug 'https://github.com/christoomey/vim-run-interactive'
Plug 'https://github.com/vim-scripts/a.vim.git'
Plug 'https://github.com/DataWraith/auto_mkdir'
Plug 'https://github.com/tpope/vim-unimpaired.git'
" file:linenum:col
Plug 'https://github.com/kopischke/vim-fetch'
" unix file manipulation
Plug 'https://github.com/tpope/vim-eunuch'
Plug 'https://github.com/djoshea/vim-autoread'
Plug 'https://github.com/sjl/vitality.vim'

" Plug 'https://github.com/roxma/vim-tmux-clipboard'

" Plug 'https://github.com/mattn/webapi-vim'
" Plug 'https://github.com/heavenshell/vim-slack'
" Plug 'https://github.com/mattn/gist-vim' ", {'depends': 'mattn/webapi-vim'}
" Plug 'https://github.com/yaasita/edit-slack.vim'

let g:yaasita_slack_token = expand("$SLACK_TOKEN")

" let g:slack_fileupload_token = expand("$SLACK_TOKEN")

" function! ColumnsMerge()
" 	let prefix = "("
" 	let suffix = ");"
" 	let delimiter = ",,"

" 	let result = []
" 	for l in getline(1, '$')
" 		for c in split(l, delimiter)
" 		endfor
" 	endfor
" endfunction

Plug 'https://github.com/hiberabyss/changesqlcase.vim', {'on': 'ChangeSqlCase'}

Plug 'https://github.com/hiberabyss/vimball'
command! -nargs=0 ExtractVimball call execute(printf("%s %s/%s", "UseVimball", expand("$BUNDLE"), split(expand("%:t:r"), '\.')[0]))

" Plug 'https://github.com/hiberabyss/VimErrFind'

" Plug 'https://github.com/hiberabyss/ZoomWin'
" let g:vimball_home = expand("$BUNDLE")
