function! vim2048#draw#DrawBoard()
    normal! ggdG
    execute "normal! i  ________\n" .
                \ "|        |\n" .
                \ "|        |\n" .
                \ "|        |\n" .
                \ "|        |\n" .
                \ "  --------"
endfunction
