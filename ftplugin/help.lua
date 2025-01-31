vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Generate tags file",
    buffer = 0,
    callback = function()
        vim.cmd("helptags " .. vim.fn.expand "%:p:h")
    end,
})
