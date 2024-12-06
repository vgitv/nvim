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
set scrolloff=2                  " minimal number of screen lines to keep above and below the cursor
set sidescrolloff=6              " minimal number of screen columns to keep to the left / right of the cursor
set foldcolumn=auto              " when and how to draw the foldcolumn

" 3 to have only one status line at the bottom of the screen (and not a status
" line for each window). This option will be potentially overriden by the
" 'globalstatus' option of the plugin lualine.nvim
set laststatus=3

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}


" Mappings {{{
let mapleader = " "
let localleader = "\\"

" build - based on an external script, see https://github.com/vgitv/zenscript/blob/master/bin/xbuild
nnoremap <F4> :!xbuild %<CR>
" reindent all file
nnoremap <F6> mzgg=G`zzz
" add ; at the end of the current line
nnoremap <F7> mzA;<ESC>`z
" did you forget the ; in the previous line ?
inoremap <F7> <ESC>kA;<ESC>j==A
" gnuplot
nnoremap <F9> :!gnuplot -p "%"<CR>
" remove carriage return
nnoremap <F12> mz:%s/\r//g<CR>`z


" next/previous buffer
nnoremap <CR> :bnext<CR>
nnoremap <BS> :bprevious<CR>


" resize window with arrow keys
nnoremap + :resize +1<CR>
nnoremap - :resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Left> :vertical resize -1<CR>


" Next replace
inoremap <c-b> <Esc>/<++><CR>"_c4l

" switch case of all word
inoremap <C-_> <ESC>mzbviw~`za
nnoremap <C-_> mzviw~`z

" insert blank line without entering insert mode
nnoremap <C-N> o<Esc>


" switch window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" search / replace
" replace in all file (in normal mode, S is same as cc so it can be used)
nnoremap S :%s/


" visual inside word
nnoremap <Leader><space> viw

" enclose current word
nnoremap <Leader>" mzviw<Esc>a"<Esc>bi"<Esc>`zl
nnoremap <Leader>' mzviw<Esc>a'<Esc>bi'<Esc>`zl
nnoremap <Leader>( mzviw<Esc>a)<Esc>bi(<Esc>`zl
nnoremap <Leader>[ mzviw<Esc>a]<Esc>bi[<Esc>`zl
nnoremap <Leader>{ mzviw<Esc>a}<Esc>bi{<Esc>`zl
nnoremap <Leader>_ mzviw<Esc>a_<Esc>bi_<Esc>`zl
nnoremap <Leader>* mzviw<Esc>a*<Esc>bi*<Esc>`zl
nnoremap <Leader>` mzviw<Esc>a`<Esc>bi`<Esc>`zl

" enclose visual selection
vnoremap <Leader>" <Esc>`<i"<Esc>`>la"<Esc>
vnoremap <Leader>' <Esc>`<i'<Esc>`>la'<Esc>
vnoremap <Leader>( <Esc>`<i(<Esc>`>la)<Esc>
vnoremap <Leader>[ <Esc>`<i[<Esc>`>la]<Esc>
vnoremap <Leader>{ <Esc>`<i{<Esc>`>la}<Esc>
vnoremap <Leader>_ <Esc>`<i_<Esc>`>la_<Esc>
vnoremap <Leader>* <Esc>`<i*<Esc>`>la*<Esc>
vnoremap <Leader>` <Esc>`<i`<Esc>`>la`<Esc>

" switch to last opened buffer
nnoremap <Leader>b :buffer #<CR>


" select all file
nnoremap <Leader>a ggVG

" Delete buffer
nnoremap <Leader>d :bnext<CR>:bdelete #<CR>

" edit init file
nnoremap <Leader>e :edit $MYVIMRC<CR>

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
nnoremap <Leader>l :source $MYVIMRC<CR>

" read command but insert next to the cursor instead of in a new line
function ReadNextToCursor()
    let l:command = input('Command: ')
    let l:command_output = system(l:command)
    " remove trailing newline
    let l:command_output = substitute(l:command_output, '\n$', '', '')
    execute "normal! i" . l:command_output
endfunction
nnoremap <Leader>r :call ReadNextToCursor()<CR>

" toggle hlsearch
nnoremap <Leader>s :set hlsearch!<CR>:set hlsearch?<CR>

" nvim-tree.lua
nnoremap <Leader>t :NvimTreeToggle<CR>

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


" Terminal mode {{{
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


" Plugins setup - SHOULD BE LAST {{{
" Follow vim-plug installation instructions here: https://github.com/junegunn/vim-plug
call plug#begin()

" List your plugins here
Plug 'nvim-tree/nvim-web-devicons'  " icons used by nvim-tree plugin
Plug 'nvim-tree/nvim-tree.lua'  " file tree
Plug 'rebelot/kanagawa.nvim'  " colorscheme
Plug 'lukas-reineke/indent-blankline.nvim'  " indentation guides
Plug 'hashivim/vim-terraform'  " terraform syntax
Plug 'nvim-lualine/lualine.nvim'  " statusline
Plug 'tpope/vim-commentary'  " comment lines

" autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip', {'tag' : '*'}

call plug#end()

" Colorscheme should be the first plugin to be loaded because it can define
" colors for some highlights groups that will be used by another plugin. For
" instance IblIndent for indent-blankline plugin.
lua require("kanagawa-setup")
lua require("lualine-setup")
lua require("nvim-web-devicons-setup")
lua require("nvim-tree-setup")
lua require("indent-blankline-setup")
lua require("nvim-cmp-setup")
" }}}
