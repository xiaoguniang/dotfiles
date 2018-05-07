if exists('b:loaded_vba_vim')
    finish
endif
let b:loaded_vba_vim = 1

command! -nargs=0 ExtractVimball call execute(printf("%s %s/%s", "UseVimball", expand("$BUNDLE"), expand("%:t:r")))
