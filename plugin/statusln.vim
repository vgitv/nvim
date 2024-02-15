if exists("g:loaded_statusln")
    finish
endif
let g:loaded_statusln = 1


let g:status_sep = "\u2022"


function TotBuf()
    return len(getbufinfo({'buflisted': 1}))
endfunction


function SetGitBranch()
    " systemlist(...)[0] instead of system(...) to avoid \n at the end of the command return
    let b:is_git = systemlist(['git', '-C', expand('%:h'), 'rev-parse', '--is-inside-work-tree'])[0]
    if b:is_git == 'true'
        let b:git_branch = "\U279C " . systemlist(['git', '-C', expand('%:h'), 'branch', '--show-current'])[0]
    else
        let b:git_branch = ''
    endif
endfunction


function MyStatusLine()
    " buffer number / total buffers & modified flag
    let line = ' %n/%{TotBuf()} ' . g:status_sep
    " modified flag & path to file
    let line = line . ' %M%<%f '
    " branch
    " empty default value is needed for opening directory
    let line = line . '%{get(b:, "git_branch", "")}'

    " all the way through, up to the right side
    let line = line . '%='
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


highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=reverse guifg=#458588 guibg=#000000
highlight StatusLineNC cterm=reverse ctermfg=237 ctermbg=246 gui=reverse guifg=#7c6f63 guibg=#000000


augroup pre_statusline
    autocmd!
    " BufReadPre will use fewer ressources than BufEnter, but if another
    " branch is checked out while editing a file, we need to do :e<cr> to
    " refresh status line (re-entering the buffer will not be sufficient)
    autocmd BufNewFile,BufReadPre * call SetGitBranch()
augroup END


set statusline=%!MyStatusLine()
" always display status line
set laststatus=2
