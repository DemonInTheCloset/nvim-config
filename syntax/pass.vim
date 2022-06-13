if exists("b:current_syntax")
    finish
endif

syntax match passUrl /\v\S+$/ contains=passUrlGlob
syntax match passUrlGlob /\v(\*)|(\|)|(\()|(\))/

syntax match passText /\v\S+/
syntax match passNote /\v^\S+:/
syntax match passUrlDecl /\v^URL:.*$/ contains=passUrl
syntax match passPassword /\v%^.*$/

highlight default link passNote Special
highlight default link passText Ignore
highlight default link passUrl Underlined
highlight default link passUrlGlob Operator
highlight default link passUrlDecl Function
highlight default link passPassword Keyword

let "b:current_syntax"="pass"
