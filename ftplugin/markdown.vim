setlocal wrap              " wrap long lines
setlocal linebreak         " wrap on a word rather than on the last char display in window
setlocal textwidth=79      " break long line automatically
setlocal colorcolumn=+1    " column border

inoreabbrev <buffer> _sql ```sql<CR>```<Esc>kA
inoreabbrev <buffer> _sh ```bash<CR>```<Esc>kA
inoreabbrev <buffer> _txt ```txt<CR>```<Esc>kA
inoreabbrev <buffer> _ ```<CR>```<Esc>kA

" image
inoremap <buffer> <LocalLeader>g ![](<++>)<Esc>6hi

" link
inoremap <buffer> <LocalLeader>l [](<++>)<Esc>6hi

" bold
inoremap <buffer> <LocalLeader>b ****<++><Esc>5hi

" italic
inoremap <buffer> <LocalLeader>i __<++><Esc>4hi

" inline code
inoremap <buffer> <LocalLeader>c ``<++><Esc>4hi

" tabular
inoremap <buffer> <LocalLeader>t \|<Space><++><Space>\|<Space><++><Space>\|<CR>\|------\|------\|<CR>\|<Space><++><Space>\|<Space><++><Space>\|<Esc>2k0i

" check list
nnoremap <buffer> <LocalLeader>o o- [ ]<Space>
nnoremap <buffer> <LocalLeader>x mz_3lrx`z
nnoremap <buffer> <LocalLeader><Space> mz_3lr<Space>`z
