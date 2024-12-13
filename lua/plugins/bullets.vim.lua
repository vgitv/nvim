return {
    'bullets-vim/bullets.vim',
    -- only load this plugin for markdown filetype
    ft = 'markdown',
    keys = {
        { '<LocalLeader>x', ':ToggleCheckbox<CR>', desc = 'Toggle check box' },
    },
}
