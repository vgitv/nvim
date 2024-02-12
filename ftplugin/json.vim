set autoread  " Force reload file after it changes

" Use custom external script for this
nnoremap <buffer> <LocalLeader>f <Esc>:!formatjson % <CR>
