function EditNvimInitFile()
    -- Open nvim init file in a new tab and open Neotree inside the nvim
    -- configuration folder.
    vim.cmd.tabedit(vim.env.MYVIMRC)
    vim.cmd.Neotree(vim.fn.stdpath('config'))
    vim.cmd.wincmd('l')
end


-- The main terminal background will be darker than the editor background
-- this backgroune dolor is consistent with kanagawa colorscheme
vim.cmd([[highlight LuaTerminalNormal guibg=#16161d]])

-- at start, there is no main terminal buffer
vim.g.main_terminal_buffer_name = nil

-- This will update the global var if the terminal is exited using <C-d>
vim.api.nvim_create_autocmd(
    'TermClose',
    {
        desc = 'Unset main terminal buffer name variable if main terminal is closed',
        group = vim.api.nvim_create_augroup('temp_terminal_group', { clear = true }),
        callback = function()
            if vim.g.main_terminal_buffer_name then
                if vim.fn.bufnr(vim.g.main_terminal_buffer_name) == -1 then
                    -- If the buffer doesn't exist, -1 is returned by bufnr function.
                    vim.g.main_terminal_buffer_name = nil
                end
            end
        end
    }
)


function TerminalToggle()
    if not vim.g.main_terminal_buffer_name then
        print('Create new main terminal')
        -- In this if, the main terminal buffer does not exists
        -- create the main terminal buffer
        vim.cmd([[belowright 20split]])
        vim.cmd.terminal()
        -- shade terminal background and hid it from :ls command
        vim.opt_local.winhighlight = 'Normal:LuaTerminalNormal'
        vim.bo.buflisted = false
        -- update global vars
        vim.g.main_terminal_buffer_name = vim.fn.bufname()
        vim.cmd.startinsert()
    else
        -- In this else, the main terminal buffer already exists.
        -- We need to find if it is already open in a window or not.
        local terminal_windows_tab = vim.fn.win_findbuf(vim.fn.bufnr(vim.g.main_terminal_buffer_name))
        if terminal_windows_tab[1] then
            -- In this if, the main terminal buffer is open in at least one window.
            -- Remember the current window id to go back later
            local current_winid = vim.fn.win_getid()
            -- Go to each window with the main terminal and quit it
            -- NOTE: there could be multiple windows opened displaying the main
            -- terminal, that's why we loop through this table.
            for _, window_id in pairs(terminal_windows_tab) do
                vim.fn.win_gotoid(window_id)
                vim.cmd.quit()
            end
            -- go back to previous window
            vim.fn.win_gotoid(current_winid)
        else
            -- terminal buffer is not open in any window, so open it
            vim.cmd('belowright 20split ' .. vim.g.main_terminal_buffer_name)
            -- we need to reset the buflisted option here but winhighlight is not required, not sure why
            vim.bo.buflisted = false
            -- each time the terminal is open in a window, it has a new window id
            if vim.fn.mode() == 'n' then
                vim.cmd.startinsert()
            end
        end
    end
end


-- Use a linter to check current file
function LintCurrentFile()
    if vim.bo.filetype == 'sh' then
        vim.cmd([[!shellcheck -x "%"]])
    elseif vim.bo.filetype == 'yaml' then
        vim.cmd([[!yamllint "%"]])
    elseif vim.bo.filetype == 'python' then
        vim.cmd([[!flake8 --max-line-length=120 "%"]])
    else
        print('Linting command not implemeted yet')
    end
end


-- Format current file
function FormatCurrentFile()
    if vim.bo.filetype == 'python' then
        vim.cmd([[!black --line-length=120 "%"]])
    elseif vim.bo.filetype == 'json' then
        vim.cmd([[%!jq .]])
    else
        print('Format command not implemeted yet')
    end
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
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local state = {
    main_terminal = {
        buf = -1,
        win = -1,
    }
}

local create_window_below = function(opts)
    opts = opts or {}
    local height = opts.height or math.floor(vim.o.lines * 0.35)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        split = 'below',
        win = 0,
        height = height,
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.main_terminal.win) then
        state.main_terminal = create_window_below { buf = state.main_terminal.buf }
        if vim.bo[state.main_terminal.buf].buftype ~= 'terminal' then
            vim.cmd.terminal()
            vim.bo.buflisted = false
            vim.opt_local.winhighlight = 'Normal:LuaTerminalNormal'
        end
    else
        vim.api.nvim_win_hide(state.main_terminal.win)
    end
end

vim.api.nvim_create_user_command('Floatwindow', create_floating_window, {})
vim.api.nvim_create_user_command('Toggleterminal', toggle_terminal, {})
