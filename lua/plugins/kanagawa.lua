return {
    -- the colorscheme should be available when starting Neovim
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,  -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,  -- make sure to load this before all the other start plugins
    opts = {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = { bold = true},  -- more visible function for bash scripts
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,  -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,  -- define vim.g.terminal_color_{0,17}
        colors = {  -- add/modify theme and palette colors
            palette = {},
            theme = {
                wave = {
                    ui = {
                        bg_gutter = "none",  -- Remove the background of LineNr, {Sign,Fold}Column and friends
                        bg_p1 = "#16161d",  -- colorcolumn
                        bg_p2 = "#16161d",  -- cursorline color
                    },
                },
                lotus = {},
                dragon = {},
                all = {}
            },
        },
        overrides = function(colors)  -- add/modify highlights
            local theme = colors.theme
            local makeDiagnosticColor = function(color)
                local c = require("kanagawa.lib.color")
                return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
            end

            return {
                IblIndent = { fg = "#2a2a37"},  -- Indent char for indent-blankline plugin
                DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
                DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
                DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
                DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
            }
        end,
        theme = "wave",  -- Load "wave" theme when 'background' option is not set
        background = {  -- map the value of 'background' option to a theme
            dark = "wave",   -- try "dragon" !
            light = "lotus"
        },
    },
    init = function()
        vim.cmd.colorscheme 'kanagawa'
    end
}
