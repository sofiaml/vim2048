function! vim2048#start#NewGame()
    echom "Starting a new game of 2048..."
    if bufwinnr("__vim2048_window__") == -1
        vsplit __vim2048_window__
    endif
    normal! ggdG
    setlocal filetype=vim2048
    setlocal buftype=nofile

    call vim2048#draw#DrawBoard()
endfunction
