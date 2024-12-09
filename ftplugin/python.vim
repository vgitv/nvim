" flake8
nnoremap <buffer> <F3> <esc>:!flake8 --max-line-length=120 "%"<cr>

" black
nnoremap <buffer> <LocalLeader>b <esc>:write<cr>:!black --line-length=120 "%"<cr>

augroup nvimtree_related
    autocmd!
    " open nvimtree at startup
    autocmd VimEnter * Neotree toggle
    " move cursor to editor windows after opening neo-tree
    autocmd UIEnter * set nonumber | wincmd l
augroup END
