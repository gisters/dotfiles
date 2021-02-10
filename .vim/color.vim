" colorscheme
try
    colorscheme lucario
    hi CursorLineNr ctermfg=NONE ctermbg=236 cterm=bold guifg=NONE guibg=#405160 gui=NONE
    hi SpecialKey   ctermfg=NONE ctermbg=NONE cterm=NONE guifg=#61bbc8 guibg=NONE gui=NONE
    hi Comment      ctermfg=44 ctermbg=NONE cterm=italic guifg=#5c98cd guibg=NONE gui=italic
    hi clear SignColumn
catch
    colorscheme default
endtry
