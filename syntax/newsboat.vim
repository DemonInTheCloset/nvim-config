if exists("b:current_syntax")
    finish
endif

syntax match newsboatTag keepend /\v\S+/
syntax region newsboatStrTag keepend start=/\v"/ skip=/\v\\./ end=/\v"/
syntax match newsboatTitle keepend /\v\~\S+/
syntax region newsboatStrTitle keepend start=/\v"\~/ end=/\v"/
syntax match newsboatUrl /\v^\S+/
syntax match newsboatHeader /\v^"?───.*$/

highlight default link newsboatTag PreProc
highlight default link newsboatTitle Special
highlight default link newsboatStrTag PreProc
highlight default link newsboatStrTitle Special
highlight default link newsboatUrl Underlined
highlight default link newsboatHeader Function

let "b:current_syntax" = "newsboat"
