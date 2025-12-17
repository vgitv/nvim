return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = false,
        keywords = {
            NOTE = {
                alt = { "INFO", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10" },
            },
        },
        highlight = {
            multiline = false,
            multiline_context = 1,
        },
    },
}
