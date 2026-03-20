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
    lua = function()
        local filepath = vim.api.nvim_buf_get_name(0)
        return { "stylua", "-s", filepath }
    end,
    python = function()
        local filepath = vim.api.nvim_buf_get_name(0)
        return { "python", "-m", "black", "--line-length=120", filepath }
    end,
    json = function()
        local filepath = vim.api.nvim_buf_get_name(0)
        local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { scope = "local", buf = 0 })
        return { "python", "-m", "json.tool", "--indent", shiftwidth, filepath, filepath }
    end,
    terraform = function()
        local filepath = vim.api.nvim_buf_get_name(0)
        return { "terraform", "fmt", filepath }
    end,
}

-- Format current file
function FormatCurrentFile()
    local get_command = format_commands[vim.bo.filetype] or nil
    if not get_command then
        print "Formatting command not implemented yet for this filetype"
        return
    end

    print "Formatting..."
    local command = get_command()
    local result = vim.system(command, { text = true }):wait()

    if result.code == 0 then
        vim.cmd "edit"
        print "Formatting done!"
    else
        print("ERROR - something went wrong:\n" .. result.stderr)
    end
end

-- Autocommit
function Autocommit()
    print "Autocommit..."
    local result = vim.system({ "autocommit" }, { text = true }):wait()

    if result.code == 0 then
        print(result.stdout)
    else
        print("ERROR - something went wrong:\n" .. result.stdout .. "\n" .. result.stderr)
    end
end
