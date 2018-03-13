if exists('b:loaded_crontab_vim')
    finish
endif
let b:loaded_crontab_vim = 1

nmap <buffer> <silent> ,rr :call system('crontab ' .expand('%'))<cr>:call ShowMsg("Load crontab done!")<cr>
