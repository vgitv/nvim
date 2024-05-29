if exists("g:loaded_statusln")
    finish
endif
let g:loaded_statusln = 1


let g:status_sep = "\u2022"

highlight User1 gui=reverse


function TotBuf()
    return len(getbufinfo({'buflisted': 1}))
endfunction


function SetGitInfo()
    " systemlist(...)[0] instead of system(...) to avoid \n at the end of the command return
    let b:is_git = systemlist(['git', '-C', expand('%:h'), 'rev-parse', '--is-inside-work-tree'])[0]
    if b:is_git == 'true'
        let l:git_repo_path = systemlist(['git', '-C', expand('%:h'), 'rev-parse', '--show-toplevel'])[0]
        let l:git_repo = split(l:git_repo_path, '/')[-1]
        let l:git_branch = systemlist(['git', '-C', expand('%:h'), 'branch', '--show-current'])[0]
        let b:git_info = "  \ue0a0 " . l:git_repo . " \U279C " . l:git_branch . " "
    else
        let b:git_info = ''
    endif
endfunction


function MyStatusLine()
    let line = '%1*%{get(b:, "git_info", "")}%*'
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
    autocmd BufNewFile,BufReadPre * call SetGitInfo()
augroup END


set statusline=%!MyStatusLine()
" always display status line
set laststatus=2
