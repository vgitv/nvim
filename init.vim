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
set wrap                         " wrap long lines
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

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead *.groff set filetype=groff
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
    highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=reverse guifg=#458588 guibg=#000000
    highlight StatusLineNC cterm=reverse ctermfg=237 ctermbg=246 gui=reverse guifg=#7c6f63 guibg=#000000
endfunction

" Colorscheme
call SetGruvboxColorscheme()

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
augroup nerdtree_group
    autocmd!
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END

" remove help message in nerdtree
let NERDTreeMinimalUI=1
" }}}


echom 'Welcome to nvim'
