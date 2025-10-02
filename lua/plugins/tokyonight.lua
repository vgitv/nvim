return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        on_highlights = function(hl, c)
            -- more contrast than c.black
            black = "#14151d"

            hl.CursorLine = {
                bg = black,
            }

            hl.WinSeparator = {
                fg = black,
                bold = true,
            }

            hl.ColorColumn = {
                bg = black,
            }
        end,
    },
    init = function()
        -- Note: on_highlights function is not apply when using config arg
        vim.cmd.colorscheme "tokyonight"
    end,
}
