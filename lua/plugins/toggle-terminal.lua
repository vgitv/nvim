return {
    'vgitv/toggle-terminal.nvim',
    branch = 'feature/init',
    cmd = 'Toggleterminal',
    keys = {
        { '<Leader>k', ':Toggleterminal<CR>', desc = 'Toggle main terminal window' },
    },
    opts = {
        bg_color = '#16161d',  -- main terminal background color
        number = false,  -- no number in main terminal window
        relativenumber = false,  -- no relative number in main terminal window
        startinsert = true,  -- start insert mode at term opening
        relative_height = 0.35,  -- relative height of the terminal window (beetween 0 and 1)
    },
}
