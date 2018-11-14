function! vim2048#start#loadClassFiles()
    runtime lib/vim2048/game.vim
endfunction


function! vim2048#start#NewGame()
    echom "Starting a new game of 2048..."
    if bufwinnr("__vim2048_window__") == -1
        vsplit __vim2048_window__
        call vim2048#start#loadClassFiles()
        setlocal filetype=vim2048
        setlocal buftype=nofile
        call g:vim2048Game.DrawBoard()
    endif
endfunction

function! vim2048#start#Quit()
    if bufwinnr("__vim2048_window__") != -1
        call g:vim2048Game.Quit()
    endif
endfunction

