" This is an attempt at making a class which contains tiles etc
"
let s:vim2048Game = {}
let g:vim2048Game = s:vim2048Game

" need functions to do the following:
" - add tile DONE
" - delete tile (might as well overwrite with '')
" - show existing tiles
" - check if square is empty
" - need a way to store existing tiles


function! s:vim2048Game.All()
    echo "working!"
endfunction

"FUNCITON: s:vim2048Game.SetTile(value, r, c)
"Sets the tile in row r and column c to input value
"Input value must be between 1 and 4 characters or things get messed up
function! s:vim2048Game.SetTile(value, r, c)
    let s:rplus = a:r + 1
    let s:cminus = a:c - 1
    let s:padded_val = repeat(' ', 4 - len(a:value)) . a:value
    execute 'normal! ' . s:rplus . 'gg0l' . 4*s:cminus . 'l4x'
                \ . 'i' . s:padded_val . "\<esc>"
    execute 'normal! G'
endfunction

"FUNCTION: s:vim2048Game.MoveLeft()
"Shifts the board left. Needs to check in each row if any tiles are combined,
"and if so does this.

