function! vim2048#draw#DrawBoard()
    normal! ggdG
    execute "normal! i.________________.\n" .
                \ "|                |\n" .
                \ "|                |\n" .
                \ "|                |\n" .
                \ "|                |\n" .
                \ ".----------------."
endfunction
