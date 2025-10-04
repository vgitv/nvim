-- auto formating file
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Format terraform file",
    buffer = 0,
    command = "silent !stylua -s %",
})
