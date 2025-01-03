return {
    'vgitv/toggle-terminal.nvim',
    branch = 'feature/init',
    cmd = 'Toggleterminal',
    keys = {
        { '<Leader>k', ':Toggleterminal<CR>', desc = 'Toggle terminal (default height)', silent = true },
        { '<Leader>f', ':Toggleterminal 0.8<CR>', desc = 'Toggle terminal (80% height)', silent = true },
    },
    opts = {
        bg_color = '#16161d',  -- main terminal background color
        startinsert = true,  -- start insert mode at term opening
        relative_height = 0.35,  -- relative height of the terminal window (beetween 0 and 1)
        local_options = {
            number = false,  -- no number in main terminal window
            relativenumber = false,  -- no relative number in main terminal window
            cursorline = false,  -- cursor line in main terminal window
            colorcolumn = '',  -- color column
        }
    },
}
