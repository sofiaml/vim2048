if exists("b:current_syntax")
    finish
endif

syntax match vim2048Boarders "\v\||-|_|\="
highlight link vim2048Boarders Keyword

let b:current_syntax = "vim2048"
