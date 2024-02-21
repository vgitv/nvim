"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|
"

" za to unfold


" Vimscript file settings {{{
augroup filetype_vim
    autocmd!
    " Set marker fold method only for vim filetype, because it is unlikely
    " that vimscripts will be open with another editor than vim.
    autocmd FileType vim setlocal foldmethod=marker | setlocal foldlevelstart=0
augroup END
" }}}


" Option settings {{{
syntax on                        " syntax highlighting
filetype plugin indent on        " allows auto-indenting depending on file type

set nocompatible                 " disable compatibility to old-time vi
set showmatch                    " show matching brackets.
set ignorecase                   " case insensitive matching
set mouse=a                      " mouse in all modes - middle-click paste with mouse
set hlsearch                     " highlight search results
set tabstop=4                    " number of columns occupied by a tab character
set softtabstop=4                " see multiple spaces as tabstops so <BS> does the right thing
set expandtab                    " converts tabs to white space
set shiftwidth=4                 " width for autoindents
set autoindent                   " indent a new line the same amount as the line just typed
set number                       " add line numbers
set wildmode=longest:full,full   " get bash-like tab completions
set textwidth=0                  " 0 => dont break long line automatically
set colorcolumn=120              " set a 120 column border for good coding style
set nowrap                       " dont wrap long lines
set clipboard+=unnamedplus       " default clipboard is the system clipboard
set shiftround                   " round indent to multiple of shiftwidth
set termguicolors                " uses gui :highlight attributes instead of cterm attributes
set cursorline                   " highlight cursor line
set background=dark              " dark background
set scrolloff=2
set sidescrolloff=6

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}


" Autocommands {{{
augroup templates
    autocmd!
    autocmd BufNewFile *.cpp  0read ~/.config/nvim/templates/skeleton.cpp
    " insert template before the first line and go to the end of file
    autocmd BufNewFile *.sh   0read ~/.config/nvim/templates/skeleton.sh | norm G
    autocmd BufNewFile *.html 0read ~/.config/nvim/templates/skeleton.html
    " insert template after the first line and delete first blank line
    autocmd BufNewFile *.py   1read ~/.config/nvim/templates/skeleton.py | norm ggdd
    autocmd BufNewFile *.md   0read ~/.config/nvim/templates/skeleton.md
augroup END

augroup set_specific_filetypes
    autocmd!
    autocmd BufNewFile,BufRead *.groff set filetype=groff
augroup END

" Join actions for all word processing filetypes
augroup word_processing_specific
    autocmd!
    autocmd Filetype markdown,plaintex,text setlocal formatoptions+=a
    autocmd Filetype markdown,plaintex,text setlocal wrap
    autocmd Filetype markdown,plaintex,text setlocal linebreak
    autocmd Filetype markdown,plaintex,text setlocal textwidth=79
    autocmd Filetype markdown,plaintex,text setlocal colorcolumn=+1
augroup END
" }}}


" Packages {{{
function SetGruvboxColorscheme()
    let g:gruvbox_contrast_dark = "hard"
    let g:gruvbox_italic = 1
    let g:gruvbox_invert_selection = 0
    let g:gruvbox_italicize_strings = 1
    colorscheme gruvbox

    " Override some highlight groups.
    " Needs to be after loading the colorscheme!
    highlight ColorColumn ctermbg=232 guibg=#000000
    highlight CursorLine ctermbg=232 guibg=#000000
    " highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=reverse guifg=#458588 guibg=#000000
    " highlight StatusLineNC cterm=reverse ctermfg=237 ctermbg=246 gui=reverse guifg=#7c6f63 guibg=#000000
endfunction

function SetTokyonightMoonColorscheme()
    colorscheme tokyonight-moon

    " Override some highlight groups.
    " Needs to be after loading the colorscheme!
    highlight LineNr guifg=#545b7c
    highlight CursorLineNr guifg=#9ca2c1
    highlight CursorLine guibg=#1b1d2b
    highlight StatusLine guibg=#525886 guifg=#bbc2fe
    highlight StatusLineNc guibg=#43486e guifg=#727abd
    " highlight groups 'Identifier' and 'Statement' are the same by default.
    " Override Identifier to make a difference.
    highlight Identifier guifg=#ff79c6
endfunction

function SetTokyonightNightColorscheme()
    colorscheme tokyonight-night

    " Override some highlight groups.
    " Needs to be after loading the colorscheme!
    highlight CursorLine guibg=#15161e
    " highlight groups 'Identifier' and 'Statement' are the same by default.
    " Override Identifier to make a difference.
    highlight Identifier guifg=#ff79c6
endfunction

function SetDoomoneColorscheme()
    " Add color to cursor
    let g:doom_one_cursor_coloring = 1
    " Set :terminal colors
    let g:doom_one_terminal_colors = 1
    " Enable italic comments
    let g:doom_one_italic_comments = 1
    " Enable TS support
    let g:doom_one_enable_treesitter = 1
    " Color whole diagnostic text or only underline
    let g:doom_one_diagnostics_text_color = 1
    colorscheme doom-one
endfunction

" Colorscheme
call SetTokyonightMoonColorscheme()

let g:loaded_indent_blankline = 0
function IndentGuide()
    if !g:loaded_indent_blankline
        packadd indent-blankline.nvim
        let g:loaded_indent_blankline = 1
    endif
    lua require("ibl").setup()
endfunction
" }}}


echom 'Welcome to nvim'
