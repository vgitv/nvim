vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Generate tags file",
    buffer = 0,
    callback = function()
        vim.cmd("helptags " .. vim.fn.expand "%:p:h")
    end,
})

-- Usually help will be displayed in a split window, so it's convenient not to
-- have any scrolloff because it's no use seeing context around the help section
-- we jump to
vim.opt_local.scrolloff = 0
