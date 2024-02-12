" indent
set tabstop=2                    " number of columns occupied by a tab character
set softtabstop=2                " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                    " converts tabs to white space
set shiftwidth=2                 " width for autoindents

" yaml linter
nnoremap <buffer> <F3> <ESC>:!yamllint %<CR>
