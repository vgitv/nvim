vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Generate tags file",
    group = vim.api.nvim_create_augroup("help_ftplugin_group", { clear = true }),
    pattern = "help",
    callback = function()
        vim.cmd("helptags " .. vim.fn.expand "%:p:h")
    end,
})
