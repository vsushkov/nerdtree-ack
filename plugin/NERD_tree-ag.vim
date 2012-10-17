" ============================================================================
" File:        NERD_tree-ag.vim
" Description: Adds searching capabilities to NERD_Tree
" Maintainer:  Valentin Sushkov <me@vsushkov.com>
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
"
" ============================================================================


" don't load multiple times
if exists("g:loaded_nerdtree_ag_ack")
    finish
endif

let g:loaded_nerdtree_ag_ack = 1

" add the new menu item via NERD_Tree's API
call NERDTreeAddMenuItem({
    \ 'text': '(s)earch directory',
    \ 'shortcut': 's',
    \ 'callback': 'NERDTreeAgAck' })

function! NERDTreeAgAck()
    " get the current dir from NERDTree
    let path = g:NERDTreeDirNode.GetSelected().path
    if path.isSymLink
        let cd = path.symLinkDest
    else
        let cd = path.str()
    endif

    " get the pattern
    let pattern = input("Enter the pattern: ")
    if pattern == ''
        echo 'Maybe another time...'
        return
    endif

    " display first result in the last window
    wincmd w

    exec "Ack ".pattern." ".cd
endfunction
