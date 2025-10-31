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
    python = 'python -m black --line-length=120 "%"',
    json = 'python -m json.tool --indent __shiftwidth__ "%" "%"',
    lua = 'stylua -s "%"',
    terraform = 'terraform fmt "%"',
}

-- Format current file
function FormatCurrentFile()
    local command = format_commands[vim.bo.filetype] or nil
    if not command then
        print "Formatting command not implemented yet for this filetype"
        return
    end

    local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "local", buf = 0 })
    command = command:gsub("__shiftwidth__", shiftwidth)
    print "Formatting..."
    vim.cmd("silent !" .. command)
    print "Formatting done!"
end
