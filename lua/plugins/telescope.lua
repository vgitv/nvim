return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
        extensions = {
            fzf = {},
        },
    },
    config = function()
        require("telescope").load_extension "fzf"
    end,
    cmd = "Telescope",
    keys = {
        { "<Leader>sh", ":Telescope help_tags<CR>", desc = "[S]earch [H]elp", silent = true },
        { "<leader>sf", ":Telescope find_files<CR>", desc = "[S]earch [H]elp" },
        { "<leader>sb", ":Telescope git_branches<CR>", desc = "[S]earch git [B]ranches" },
        { "<leader>sr", ":Telescope lsp_references<CR>", desc = "[S]earch LSP [R]eferences" },
        {
            "<leader>sc",
            function()
                require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
            end,
            desc = "[S]earch neovim [C]onfig",
        },
    },
}
