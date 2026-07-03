return {
    -- FIXME: do not merge local path to plugin
    -- "vgitv/one-term.nvim",
    dir = "~/Modèles/one-term.nvim",
    cmd = "Oneterm",
    branch = "main",
    keys = {
        { "<Leader>k", ":Oneterm toggle_window<CR>", desc = "Toggle terminal (default height)", silent = true },
        { "<Leader>K", ":Oneterm toggle_window 0.8<CR>", desc = "Toggle terminal (80% height)", silent = true },
        { "<Leader><space>", ":Oneterm toggle_fullscreen<CR>", desc = "Toggle terminal height", silent = true },
        { "<Leader>x", ":Oneterm send_current_line<CR>", desc = "Send current line to terminal", silent = true },
        {
            "<Leader>x",
            ":Oneterm send_visual_lines<CR>",
            mode = "v",
            desc = "Send visual lines to the terminal",
            silent = true,
        },
        {
            "<Leader>X",
            ":normal vip<CR>:Oneterm send_visual_lines<CR>",
            desc = "Send paragraph to the terminal",
            silent = true,
        },
        { "<Leader>j", ":Oneterm jump<CR>", desc = "Jump to error line using stacktrace", silent = true },
        { "<Leader>l", ":Oneterm clear<CR>", desc = "Clear terminal", silent = true },
        { "<Leader>c", ":Oneterm kill<CR>", desc = "Kill terminal current running command", silent = true },
        { "<Leader>p", ":Oneterm run_previous<CR>", desc = "Run previous command", silent = true },
        { "<Leader>d", ":Oneterm exit<CR>", desc = "Exit terminal", silent = true },
        { "<up>", ":Oneterm resize +2<CR>", desc = "Increase terminal height", silent = true },
        { "<down>", ":Oneterm resize -2<CR>", desc = "Decrease terminal height", silent = true },
        { "<F5>", ":Oneterm launch<CR>", desc = "Launch from default configuration", silent = true },
        { "<Leader>n", ":Oneterm next_layout<CR>", desc = "[Oneterm] next layout", silent = true },
    },
    opts = {
        bg_color_factor = 0.75, -- main terminal background color
        startinsert = true, -- start insert mode at term opening
        local_options = {
            number = false, -- no number in main terminal window
            relativenumber = false, -- no relative number in main terminal window
            cursorline = false, -- cursor line in main terminal window
            colorcolumn = "", -- color column
        },
        enabled_layouts = {
            "vertical",
            "horizontal",
            "floating",
        },
        vertical = {
            relative_height = 0.35,
        },
    },
}
