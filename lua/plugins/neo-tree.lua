return {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    -- only load this plugin when the Neotree command is fired
    cmd = "Neotree",
    keys = {
        { "<Leader>t", ":Neotree toggle<CR>", desc = "NeoTree toggle", silent = true },
        { "<Leader>b", ":Neotree toggle show buffers right<CR>", desc = "NeoTree toggle show buffers", silent = true },
    },
    opts = {
        close_if_last_window = true,
        filesystem = {
            window = {
                mappings = {
                    ["\\"] = "close_window",
                },
            },
        },
    },
}
