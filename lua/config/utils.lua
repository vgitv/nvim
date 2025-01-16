function EditNvimInitFile()
    -- Open nvim init file in a new tab and open Neotree inside the nvim
    -- configuration folder.
    vim.cmd.tabedit(vim.env.MYVIMRC)
    vim.cmd.Neotree(vim.fn.stdpath "config")
    vim.cmd.wincmd "l"
end

LintCommands = {
    sh = '!shellcheck -x "%"',
    python = '!flake8 --max-line-length=120 "%"',
    yaml = '!yamllint "%"',
}

-- Use a linter to check current file
function LintCurrentFile()
    vim.cmd(LintCommands[vim.bo.filetype] or 'echom "Lint command not implement yet"')
end

FormatCommands = {
    python = '!black --line-length=120 "%"',
    json = "%!jq .",
    lua = '!stylua "%"',
}

-- Format current file
function FormatCurrentFile()
    vim.cmd(FormatCommands[vim.bo.filetype] or 'echom "Format command not implement yet"')
end
