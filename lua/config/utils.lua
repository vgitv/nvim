function EditNvimInitFile()
    -- Open nvim init file in a new tab and open Neotree inside the nvim
    -- configuration folder.
    vim.cmd.tabedit(vim.env.MYVIMRC)
    vim.cmd.Neotree(vim.fn.stdpath "config")
    vim.cmd.wincmd "l"
end

local lint_commands = {
    sh = '!shellcheck -x "%"',
    python = '!flake8 --max-line-length=120 "%"',
    yaml = '!yamllint "%"',
}

-- Use a linter to check current file
function LintCurrentFile()
    vim.cmd(lint_commands[vim.bo.filetype] or 'echom "Lint command not implement yet"')
end

local format_commands = {
    python = '!black --line-length=120 "%"',
    json = "%!jq .",
    lua = '!stylua -s "%"',
    terraform = '!terraform fmt "%"',
}

-- Format current file
function FormatCurrentFile()
    vim.cmd(format_commands[vim.bo.filetype] or 'echom "Format command not implement yet"')
end
