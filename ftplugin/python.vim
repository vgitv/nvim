" When using nvim-cmp (for python autocompletion features), always displaying
" the signcolumn preserve from shifting distractingly.
setlocal signcolumn=yes

" flake8
nnoremap <buffer> <F3> <esc>:!flake8 --max-line-length=120 "%"<cr>

" black
nnoremap <buffer> <LocalLeader>b <esc>:write<cr>:!black --line-length=120 "%"<cr>

augroup nvimtree_related
    " open nvimtree at startup
    autocmd VimEnter * NvimTreeToggle
    " move cursor to editor windows after opening nvim-tree
    autocmd UIEnter * wincmd l
augroup END
