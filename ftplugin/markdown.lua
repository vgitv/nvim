-- Buffer local keymaps

-- Insert link
vim.keymap.set("v", "<C-k>", "<Esc>`<i[<Esc>`>la]()<Esc>h", { desc = "Insert markdown link", buffer = true })

-- insert tabular
vim.keymap.set("i", "<LocalLeader>t", function()
    vim.cmd "normal i| <++> | <++> |"
    vim.cmd "normal o"
    vim.cmd "normal i|------|------|"
    vim.cmd "normal o"
    vim.cmd "normal i| <++> | <++> |"
    vim.cmd "normal 2k0"
end, { desc = "Insert markdown tabular", buffer = true })

-- open link in brower
vim.keymap.set("n", "<LocalLeader>b", OpenLinkBrowser, { desc = "Open URL in browser", buffer = true })

-- Toggle concealment
vim.keymap.set("n", "<LocalLeader>\\", function()
    if vim.o.conceallevel == 3 then
        vim.opt_local.conceallevel = 0
        vim.opt_local.concealcursor = ""
    else
        vim.opt_local.conceallevel = 3
        -- Hide even if the cursor hovers the url
        vim.opt_local.concealcursor = "nc"
    end
end, { desc = "Toggle markdown concealment", buffer = true })

-- Check / uncheck checkboxes with X
vim.keymap.set("n", "X", function()
    local current_line = vim.api.nvim_get_current_line()
    if string.match(current_line, "- %[ %]") then
        vim.api.nvim_set_current_line((current_line:gsub("- %[ %]", "- %[x%]")))
    elseif string.match(current_line, "- %[x%]") then
        vim.api.nvim_set_current_line((current_line:gsub("- %[x%]", "- %[ %]")))
    end
end, { desc = "Toggle check mark", buffer = true })

local continue_bullet = function()
    vim.cmd "normal $"
    vim.cmd "startinsert"
    local current_line = vim.api.nvim_get_current_line()

    if string.match(current_line, "^- %[.%] $") or string.match(current_line, "^* $") then
        vim.api.nvim_set_current_line ""
        vim.api.nvim_put({ "", "" }, "c", true, true)
    elseif string.match(current_line, "^- %[.%] .") then
        vim.api.nvim_put({ "", "- [ ] " }, "c", true, true)
    elseif string.match(current_line, "^%* .") then
        vim.api.nvim_put({ "", "* " }, "c", true, true)
    else
        vim.api.nvim_put({ "", "" }, "c", true, true)
    end
end

vim.keymap.set("i", "<CR>", continue_bullet, { desc = "TODO", buffer = true })
vim.keymap.set("n", "o", continue_bullet, { desc = "TODO", buffer = true })
