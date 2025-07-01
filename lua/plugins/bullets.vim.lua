return {
    "bullets-vim/bullets.vim",
    enabled = false,
    -- only load this plugin for markdown filetype
    ft = "markdown",
    keys = {
        { "<LocalLeader>\\", ":ToggleCheckbox<CR>", desc = "Toggle check box" },
    },
}
