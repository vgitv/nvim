return {
    "ggandor/leap.nvim",
    opts = {},
    event = "VeryLazy",
    config = function()
        vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
        -- Dont override S in visual mode from vim-surround
        vim.keymap.set({ "n", "o" }, "S", "<Plug>(leap-backward)")
        vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
}
