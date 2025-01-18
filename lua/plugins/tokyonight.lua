return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        on_highlights = function(hl, c)
            hl.CursorLine = {
                bg = c.black,
            }
        end,
    },
    init = function()
        -- Note: on_highlights function is not apply when using config arg
        vim.cmd.colorscheme "tokyonight"
    end,
}
