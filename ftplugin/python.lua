-- auto formating file
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Format Python file with Black",
    buffer = 0,
    command = "silent !python -m black %",
})
