if executable('elm-format')
    let &l:equalprg = "elm-format --stdin"
    echo "is executable"
endif

fun! TrimTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'ruby\|javascript\|perl'
        return
    endif
    %s/\s\+$//e
endfun
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let w = winsaveview()
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    call winrestview(w)
endfunction

if !empty(&l:equalprg)
    autocmd BufWritePre <buffer> call Preserve("normal gg=G")
    "autocmd BufWritePre * call TrimTrailingWhitespace()
endif
echo "HEllo"
