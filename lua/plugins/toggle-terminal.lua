return {
    'vgitv/toggle-terminal.nvim',
    branch = 'feature/init',
    cmd = 'Terminal',
    keys = {
        { '<Leader>k', ':Terminal toggle_window<CR>', desc = 'Toggle terminal (default height)', silent = true },
        { '<Leader>K', ':Terminal toggle_window 0.8<CR>', desc = 'Toggle terminal (80% height)', silent = true },
        { '<Leader><space>', ':Terminal toggle_fullheight<CR>', desc = 'Toggle terminal height', silent = true },
        { '<Leader>x', ':Terminal send_current_line<CR>', desc = 'Send current line to terminal', silent = true },
        { '<Leader>x', ':Terminal send_visual_lines<CR>', mode = 'v', desc = 'Send visual lines to terminal', silent = true },
        { '<Leader>j', ':Terminal jump<CR>', desc = 'Jump to error line using stacktrace', silent = true },
        { '<Leader>l', ':Terminal clear<CR>', desc = 'Clear terminal', silent = true },
        { '<Leader>c', ':Terminal kill<CR>', desc = 'Kill terminal current running command', silent = true },
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
