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
set scrolloff=2
set sidescrolloff=6
set foldcolumn=auto

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" }}}


" Mappings {{{
let mapleader = " "
let localleader = "\\"

" use tab instead of escape, it's nearer
inoremap <tab> <esc>
inoremap <esc> <nop>
vnoremap <tab> <esc>
vnoremap <esc> <nop>
" for rare cases you need tab, use this key instead
inoremap <c-space> <tab>


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
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>
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
nnoremap <Leader># :buffer #<CR>


" select all file
nnoremap <Leader>a ggVG

" choose a buffer
nnoremap <Leader>b :ls<CR>:buffer<Space>

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

" line down
nnoremap <Leader>j ddp==

" line up
nnoremap <Leader>k ddkP==

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

" find word
nnoremap <Leader>w mzviwy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>
vnoremap <Leader>w mzy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>

" toggle wrap
nnoremap <Leader>z :set wrap!<CR>

" paste in visual mode without overwriting global register
" gv<Esc> at the end in order to replace cursor at the end of pasted text
vnoremap p pgvygv<Esc>

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
" }}}


" Netrw {{{
nnoremap - :Explore<cr>

function ToggleNetrw()
    if &filetype ==# "netrw"
        let l:command = "normal! :buffer " . g:last_buffer_number . "\r"
        execute l:command
    else
        let g:last_buffer_number = bufnr('%')
        Explore
    endif
endfunction

nnoremap <Leader>t :call ToggleNetrw()<cr>

function NetrwMappings()
    " make netrw more ranger-like
    " cant use nnoremap here

    " go up a dir
    nmap <buffer> h -

    " enter directory / open file
    nmap <buffer> l <cr>
endfunction

augroup netrw_autocmd
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END
" }}}


" Terminal mode {{{
tnoremap <esc> <C-\><C-n>

augroup term_specific
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
" }}}


" Packages and colorscheme {{{
let g:loaded_indent_blankline = 0


function IndentGuide()
    if !g:loaded_indent_blankline
        packadd indent-blankline.nvim
        let g:loaded_indent_blankline = 1
    endif
    lua require("ibl").setup()
endfunction


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
    highlight CursorLineNr guibg=#000000

    highlight User1 guibg=#ebdbb2 guifg=#504945
    highlight User2 guibg=#ebdbb2 guifg=#504945 gui=reverse
endfunction


function SetKanagawaColorscheme()
    colorscheme kanagawa

    " STATUS LINE
    " using execute seems the only way to use variables inside a highlight
    " command
    let l:status_line_bg = '#363646'
    let l:status_line_fg = '#d8d7ba'
    execute 'highlight StatusLine guibg=' . l:status_line_bg . ' guifg=' . l:status_line_fg
    " User{N} highlights are defined for the statusline purpose. When the
    " guibg and guifg colors match exactly the StatusLine highlight group
    " colors, they will change for the window loosing focus. That's why if one
    " must want to reverse colors for example, one must use the 'reverse'
    " attribute, and not switch guibg and guifg values.
    execute 'highlight User1 guibg=' . l:status_line_bg . ' guifg=' . l:status_line_fg . ' gui=reverse'
    execute 'highlight User2 guibg=' . l:status_line_bg . ' guifg=' . l:status_line_fg
    execute 'highlight StatusLineNc guibg=' . l:status_line_bg . ' guifg=#75746b'

    " CURSOR LINE
    highlight CursorLine guibg=#16161d
    highlight ColorColumn guibg=#16161d

    " more visible errors
    highlight Error gui=bold,reverse

    " more visible function for bash scripts
    highlight Function gui=bold

    " highlight self keyword for Python
    autocmd FileType python highlight link SelfKeyword Keyword | syntax match SelfKeyword /\<self\>/

    " highlight AssignEquals guifg=#ffa066
    " syntax match AssignEquals /\w\+\s*=\s*\w\+/
endfunction


" Colorscheme
call SetKanagawaColorscheme()
" }}}


" Status line {{{
let g:status_sep = "\u2022"

function TotBuf()
    return len(getbufinfo({'buflisted': 1}))
endfunction


function SetGitInfo()
    " systemlist(...)[0] instead of system(...) to avoid \n at the end of the command return
    let b:is_git = systemlist(['git', '-C', expand('%:h'), 'rev-parse', '--is-inside-work-tree'])[0]
    if b:is_git == 'true' && &filetype != 'gitcommit'
        let l:git_repo_path = systemlist(['git', '-C', expand('%:h'), 'rev-parse', '--show-toplevel'])[0]
        let l:git_repo = split(l:git_repo_path, '/')[-1]
        let l:git_branch = systemlist(['git', '-C', expand('%:h'), 'branch', '--show-current'])[0]
        let b:git_info = "  \ue0a0 " . l:git_repo . " \U279C " . l:git_branch . " "
        let b:git_sep = "\ue0b0"
    else
        let b:git_info = '  nvim '
        let b:git_sep = "\ue0b0"
    endif
endfunction


function MyStatusLine()
    let line = '%1*%{get(b:, "git_info", "")}%*%2*%{get(b:, "git_sep", "")}%*'
    " modified flag & path to file
    let line = line . ' %M%<%f '
    " branch
    " empty default value is needed for opening directory

    " all the way through, up to the right side
    let line = line . '%='
    " buffer number / total buffers & modified flag
    let line = line . ' %n/%{TotBuf()} ' . g:status_sep
    " file type
    let line = line . ' c.%v '
    if &fileencoding != ''
        let line = line . g:status_sep . ' %{&fileencoding} '
    endif
    if &filetype != ''
        let line = line . g:status_sep . ' %Y '
    endif

    return line
endfunction


augroup pre_statusline
    autocmd!
    " BufReadPre will use fewer ressources than BufEnter, but if another
    " branch is checked out while editing a file, we need to do :e<cr> to
    " refresh status line (re-entering the buffer will not be sufficient)
    autocmd VimEnter,BufNewFile,BufReadPre * call SetGitInfo()
augroup END


set statusline=%!MyStatusLine()
" always display status line
set laststatus=2
" }}}


" Override - local config - should be last if called {{{
function LoadLocalVimConfig()
    let l:local_vim_config = findfile(".local.vim", ".;")

    if filereadable(l:local_vim_config)
        execute "source " . l:local_vim_config
        echom "Local vim configuration detected: " . l:local_vim_config
    endif
endfunction
" }}}
