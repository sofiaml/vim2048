" This is an attempt at making a class which contains tiles etc
let s:vim2048Game = {}
let g:vim2048Game = s:vim2048Game

" Initialize empty gameboard
let s:vim2048Game.board = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
let s:vim2048Game.playing = 0
let s:vim2048Game.score = 0

"FUNCTION: s:vim2048Game.NewGame()
"Initializes an empty game board and sets score to 0
function! s:vim2048Game.NewGame()
    if input("Would you like to start a new game? (Y/n)") != "n"
        let s:vim2048Game.board = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
        let s:vim2048Game.playing = 1
        let s:vim2048Game.score = 0
        call s:vim2048Game.DrawBoard()
    endif
endfunction

"FUNCITON: s:vim2048Game.SetTile(value, r, c)
"Sets the tile in row r and column c to input value
function! s:vim2048Game.SetTile(value, r, c)
    let s:vim2048Game.board[r][c] = value
endfunction

"FUNCTION: s:vim2048Game.MoveLeft()
"Shifts the board left. Needs to check in each row if any tiles are combined,
"and if so does this.
function! s:vim2048Game.MoveLeft()
    if !s:vim2048Game.playing
        call s:vim2048Game.NewGame()
        return
    endif
    let s:newboard = []
    for s:row in s:vim2048Game.board
        call add(s:newboard, s:ProcessRow(s:row))
    endfor
    let s:vim2048Game.board = s:newboard
    call s:vim2048Game.DrawBoard()
    "Finish by adding another tile
    call s:vim2048Game.RandomTile()
endfunction


"FUNCTION: s:vim2048Game.MoveRight()
"Shifts the board right. Needs to check in each row if any tiles are combined,
"and if so does this.
function! s:vim2048Game.MoveRight()
    if !s:vim2048Game.playing
        call s:vim2048Game.NewGame()
        return
    endif
    let s:newboard = []
    for s:row in s:vim2048Game.board
        call add(s:newboard, reverse(s:ProcessRow(reverse(s:row))))
    endfor
    let s:vim2048Game.board = s:newboard
    "Finish by adding another tile
    call s:vim2048Game.RandomTile()
endfunction

"FUNCTION: s:vim2048Game.MoveUp()
"Shifts the board up. Needs to check in each row if any tiles are combined,
"and if so does this.
function! s:vim2048Game.MoveUp()
    if !s:vim2048Game.playing
        call s:vim2048Game.NewGame()
        return
    endif
    let s:newboard = []
    for s:row in s:Transpose(s:vim2048Game.board)
        call add(s:newboard, s:ProcessRow(s:row))
    endfor
    let s:vim2048Game.board = s:Transpose(s:newboard)
    echo "done?"
    "Finish by adding another tile
    call s:vim2048Game.RandomTile()
endfunction

"FUNCTION: s:vim2048Game.MoveDown()
"Shifts the board down. Needs to check in each row if any tiles are combined,
"and if so does this.
function! s:vim2048Game.MoveDown()
    if !s:vim2048Game.playing
        call s:vim2048Game.NewGame()
        return
    endif
    let s:newboard = []
    for s:row in s:Transpose(s:vim2048Game.board)
        call add(s:newboard, reverse(s:ProcessRow(reverse(s:row))))
    endfor
    let s:vim2048Game.board = s:Transpose(s:newboard)
    "Finish by adding another tile
    call s:vim2048Game.RandomTile()
endfunction

"FUNCTION: s:vim2048Game.DrawBoard()
"Redraws the interior of the board
function! s:vim2048Game.DrawBoard()
    normal! ggdG
    execute "normal! i.----------------.\<esc>"
    for row in s:vim2048Game.board
        execute "normal! 0o|\<esc>"
        for entry in row
            if entry != 0
                let s:padded_val = repeat(' ', 4 - len(entry)) . entry
                execute "normal! a" . s:padded_val . "\<esc>l"
            else
                execute "normal! a    \<esc>l"
            endif
        endfor
        silent execute "normal! A|\<esc>"
    endfor
    execute "normal! o.----------------.\<esc>"
    execute "normal! 0o" . "Score: " . s:vim2048Game.score . "\<esc>"
endfunction

"FUNCTION: s:vim2048Game.RandomTile()
"Places either a 2 or a 4 in an empty square
function! s:vim2048Game.RandomTile()
    if !s:vim2048Game.playing
        call s:vim2048Game.NewGame()
        return
    endif

    "Find all the empty tiles
    let s:empty = 0
    for s:row in s:vim2048Game.board
        for s:entry in s:row
            if s:entry == 0
                let s:empty = s:empty + 1
            endif
        endfor
    endfor
    if s:empty == 0
        echo "You loose! no empty tiles"
        let s:vim2048Game.playing = 0
        return
    endif

    "Generate value
    if system('echo $RANDOM') < 3277 "This happens ~10% of the time
        let s:value = 4
    else
        let s:value = 2
    endif

    "Place new tile in random empty spot
    let s:rand = (system('echo $RANDOM') % s:empty) + 1
    for s:row in range(4)
        for s:col in range(4)
            if s:vim2048Game.board[s:row][s:col] == 0
                let s:rand = s:rand - 1
                if s:rand == 0
                    let s:vim2048Game.board[s:row][s:col] = s:value
                    call s:vim2048Game.DrawBoard()
                    return
                endif
            endif
        endfor
    endfor
endfunction

"FUNCTION: s:vim2048Game.Quit()
"Quits the game.
function! s:vim2048Game.Quit()
    "TODO cleanup stuff
    silent execute "normal! :q!\<cr>"
endfunction

function! s:ProcessRow(row)
        "Pick out nonzero values
        let s:nonzero = []
        for s:value in a:row
            if s:value != 0
                call add(s:nonzero, s:value)
            endif
        endfor

        "Check if any tiles need to be combined
        let s:newrow = []
        let s:l = len(s:nonzero)
        let s:i = 0
        while s:i < len(s:nonzero) - 1
            if s:nonzero[s:i] == s:nonzero[s:i + 1]
                call add(s:newrow, s:nonzero[s:i]*2)
                let s:vim2048Game.score += s:nonzero[s:i]*2
                let s:i = s:i + 2
            else
                call add(s:newrow, s:nonzero[s:i])
                let s:i = s:i + 1
            endif
        endwhile
        if s:l > 0
            call add(s:newrow, s:nonzero[-1])
        endif
        let s:newrow = (s:newrow + [0,0,0,0])[0:3]
        return s:newrow
endfunction

"Transposes a 4x4 board
function! s:Transpose(board)
    let s:transpose = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
    for s:i in range(4)
        for s:j in range(4)
            let s:transpose[s:i][s:j] = a:board[s:j][s:i]
        endfor
    endfor
    return s:transpose
endfunction

