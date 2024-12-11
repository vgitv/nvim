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

-- at start, there is no window with the main terminal
vim.g.main_terminal_window_id = nil


-- TODO let's see if we could update the global vars more efficiently using autocommands on TermOpen, TermClose events
function TerminalToggle()
    -- We need to check two things here to know if the main terminal exists:
    -- 1. at start the terminal buffer name variable is nil, so that's a condition to create main terminal
    -- 2. if the main terminal was once created then exited with <C-d> then the terminal buffer name variable is not
    --    nil, nevertheless the main terminal does not exists anymore, so we need to check if there is still a buffer
    --    with that name or not (hence the call to bufnr function)
    if not vim.g.main_terminal_buffer_name or vim.fn.bufnr(vim.g.main_terminal_buffer_name) == -1 then
        print('Create new main terminal')
        -- In this if, the main terminal buffer does not exists
        -- create the main terminal buffer
        vim.cmd([[belowright 20split]])
        vim.cmd.terminal()
        -- shade terminal background and hid it from :ls command
        vim.opt_local.winhighlight = 'Normal:LuaTerminalNormal'
        vim.opt.buflisted = false
        -- update global vars
        vim.g.main_terminal_buffer_name = vim.fn.bufname()
        vim.g.main_terminal_window_id = vim.fn.win_getid()
        vim.cmd.startinsert()
    else
        -- In this else, the main terminal buffer already exists
        -- If the main terminal was closed last time using :q and not the
        -- toggle function, the global var containing the main terminal
        -- window id is not up to date and thus cannot be trusted
        -- completely. That's why we use this win_findbuf function.
        local terminal_windows_tab = vim.fn.win_findbuf(vim.fn.bufnr(vim.g.main_terminal_buffer_name))
        if terminal_windows_tab[1] then
            -- In this if, the main terminal buffer is open in a window at least.
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
            -- terminal window is now closed, so update the global var
            vim.g.main_terminal_window_id = nil
        else
            -- terminal buffer is not open in any window, so open it
            vim.cmd('belowright 20split ' .. vim.g.main_terminal_buffer_name)
            -- each time the terminal is open in a window, it has a new window id
            vim.g.main_terminal_window_id = vim.fn.win_getid()
            if vim.fn.mode() == 'n' then
                vim.cmd.startinsert()
            end
        end
    end
end
