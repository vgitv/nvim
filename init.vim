"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|

" (za to unfold)


" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    " Set marker fold method only for vim filetype, because it is unlikely
    " that vimscripts will be open with another editor than vim.
    autocmd FileType vim setlocal foldmethod=marker | setlocal foldlevelstart=0 | setlocal foldcolumn=auto
augroup END
" }}}

" Functions to rewrite in lua/config/utils.lua {{{
" May be used by mammings.lua

" this background color is consistent with kanagawa colorscheme
highlight TerminalNormal guibg=#16161d

" at start, there is no main terminal buffer
let g:main_terminal_buffer_name = 'none'
" at start, there is no window with the main terminal
let g:main_terminal_window_id = 0

function TerminalToggle()
    if g:main_terminal_buffer_name == 'none'
        " create the main terminal buffer
        belowright 20split
        terminal
        " shade terminal background and hid it from :ls command
        setlocal winhighlight=Normal:TerminalNormal
        setlocal nobuflisted
        " update global vars
        let g:main_terminal_buffer_name = bufname()
        let g:main_terminal_window_id = win_getid()
        startinsert
    else
        " main terminal buffer already exists
        if !empty(win_findbuf(bufnr(g:main_terminal_buffer_name)))
            " buffer__terminal__ is open in a window
            " If the main terminal was closed last time using :q and not the
            " toggle function, the global var containing the main terminal
            " window id is not up to date and thus cannot be trusted
            " completely. That's why we use this win_findbuf function.
            let l:current_winid = win_getid()
            " go to window with the terminal and quit it
            call win_gotoid(g:main_terminal_window_id)
            quit
            " go back to previous window
            call win_gotoid(l:current_winid)
            " terminal window is now closed, so update the global var
            let g:main_terminal_window_id = 0
        else
            " buffer __terminal__ is not open in any window, so open it
            execute 'belowright 20split ' . g:main_terminal_buffer_name
            setlocal nobuflisted
            " each time the terminal is open in a window, it has a new window id
            let g:main_terminal_window_id = win_getid()
            if mode() == 'n'
                startinsert
            endif
        endif
    endif
endfunction

tnoremap <esc> <C-\><C-n>

" }}}

" Vim options
lua require("config.options")

" User functions
lua require("config.utils")

" Keymap
lua require("config.mappings")

" Autocommands
lua require("config.autocommands")


" Mappings {{{

" next git conflict (git go)
nnoremap <Leader>gg /<<<<<<< HEAD<CR>
" git accept ours (git ours)
nnoremap <Leader>go "_dd/=======<CR>V/>>>>>>><CR>"_d
" git accept theirs (git theirs)
nnoremap <Leader>gt V/=======<CR>"_d/>>>>>>><CR>"_dd

" syntax from start in case of wrong colors
nnoremap <Leader>h :syntax sync fromstart<CR>

" toggle terminal
nnoremap <Leader>k :call TerminalToggle()<CR>

" load MYVIMRC
" nnoremap <Leader>l :source $MYVIMRC<CR>

" toggle hlsearch
nnoremap <Leader>s :set hlsearch!<CR>:set hlsearch?<CR>

" nvim-tree.lua
nnoremap <Leader>t :Neotree toggle<CR>

" find word
nnoremap <Leader>w mzviwy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>
vnoremap <Leader>w mzy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>

" toggle wrap
nnoremap <Leader>z :set wrap!<CR>

" make file executable
nnoremap <Leader>x :!chmod u+x %<CR>

" insert {} set
inoremap <C-j> {<CR>}<esc>O


" inside next (
onoremap in( :<C-U>normal! f(vi(<CR>
" inside previous (last) (
" Not using ip because it would shadow paragraph movement
onoremap il( :<C-U>normal! F)vi(<CR>

" in next email adress
onoremap in@ :<c-u>normal! f@viW<cr>
" }}}


" Autocommands {{{
augroup templates
    " Read template when opening a new file.
    autocmd!
    autocmd BufNewFile *.cpp  1read ~/.config/nvim/templates/skeleton.cpp | 1delete
    autocmd BufNewFile *.sh   0read ~/.config/nvim/templates/skeleton.sh | norm G
    autocmd BufNewFile *.html 1read ~/.config/nvim/templates/skeleton.html | 1delete
    autocmd BufNewFile *.py   1read ~/.config/nvim/templates/skeleton.py | 1delete
    autocmd BufNewFile *.md   0read ~/.config/nvim/templates/skeleton.md | norm G
augroup END

augroup set_specific_filetypes
    " Force filetypes detection.
    autocmd!
    autocmd BufNewFile,BufRead *.groff setlocal filetype=groff
    autocmd BufNewFile,BufRead *.schema setlocal filetype=json
    autocmd BufNewFile,BufRead .yamllint setlocal filetype=yaml
    autocmd BufNewFile,BufRead .ansible-lint setlocal filetype=yaml
    autocmd BufNewFile,BufRead poetry.lock setlocal filetype=toml
    autocmd BufNewFile,BufRead dir_colors,.dir_colors setlocal filetype=dircolors
augroup END

" Join actions for all word processing filetypes
augroup word_processing_specific
    " For word processing filetypes (like mardown, LaTeX, ...) a smaller
    " textwidth is convenient. Besides, lines will break automatically.
    autocmd!
    autocmd Filetype markdown,plaintex setlocal wrap
    autocmd Filetype markdown,plaintex setlocal linebreak
    autocmd Filetype markdown,plaintex setlocal textwidth=79
    autocmd Filetype markdown,plaintex setlocal colorcolumn=+1
augroup END

augroup small_shiftwidth
    " Certain filetypes are highly indented. For those, a 2 column indentation
    " is enough.
    autocmd!
    autocmd Filetype yaml,html,json,xml setlocal tabstop=2
    autocmd Filetype yaml,html,json,xml setlocal softtabstop=2
    autocmd Filetype yaml,html,json,xml setlocal shiftwidth=2
augroup END

augroup data_filetypes
    " For data files, colorcolumn is not relevant.
    autocmd!
    autocmd Filetype csv,json,xml setlocal colorcolumn=
augroup END

augroup term_specific
    " FIXME needed only for toggle terminal without plugin
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber nocursorline
augroup END

augroup python_specific
    autocmd!
    " Highlight 'self' keyword in Python. This cannot be in the ftplugin
    " directory because it needs to be executed before setting the
    " colorscheme.
    autocmd Filetype python highlight link PythonSelfKeyword Keyword | syntax match PythonSelfKeyword /\<self\>/
augroup END
" }}}




" Lazy plugins
lua require("config.lazy-setup")
