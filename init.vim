"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|


" Vim options
lua require("config.options")

" User functions
lua require("config.utils")

" Keymap
lua require("config.mappings")

" Autocommands
lua require("config.autocommands")


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
