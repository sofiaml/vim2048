function! vim2048#draw#DrawBoard()
    normal! ggdG
    execute "normal! i.===.===.===.\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ "|---|---|---|\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ "|---|---|---|\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ "|   |   |   |\n" .
                \ " === === ==="
endfunction
