function EditNvimInitFile()
    -- Open nvim init file in a new tab and open Neotree inside the nvim
    -- configuration folder.
    vim.cmd.tabedit(vim.env.MYVIMRC)
    vim.cmd.Neotree(vim.fn.stdpath('config'))
    vim.cmd.wincmd('l')
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
    json = '%!jq .',
}


-- Format current file
function FormatCurrentFile()
    vim.cmd(FormatCommands[vim.bo.filetype] or 'echom "Format command not implement yet"')
end


local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer (no file, scratch buffer)
    local buf = vim.api.nvim_create_buf(false, true)

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "single",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end


-- The main terminal background will be darker than the editor background
-- this backgroune dolor is consistent with kanagawa colorscheme
vim.cmd.highlight 'MainTerminalNormal guibg=#16161d'


local state = {
    main_terminal = {
        buf = -1,
        win = -1,
    }
}


local create_window_below = function(opts)
    opts = opts or {}

    -- Calculate window height
    local height = opts.height or math.floor(vim.o.lines * 0.35)

    -- Get or create new buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- Define window configuration
    local win_config = {
        split = 'below',
        win = 0,
        height = height,
    }

    -- Open window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end


local toggle_main_terminal = function()
    if not vim.api.nvim_win_is_valid(state.main_terminal.win) then
        state.main_terminal = create_window_below { buf = state.main_terminal.buf }
        if vim.bo[state.main_terminal.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
            vim.bo.buflisted = false
            vim.opt_local.winhighlight = 'Normal:MainTerminalNormal'
        end
        vim.cmd.startinsert()
    else
        vim.api.nvim_win_hide(state.main_terminal.win)
    end
end


vim.api.nvim_create_user_command('Floatwindow', create_floating_window, {})
vim.api.nvim_create_user_command('Togglemainterminal', toggle_main_terminal, {})
