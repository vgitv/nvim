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
vim.keymap.set("n", "<LocalLeader>b", OpenLinkBrowser, { desc = "Open URL in browser" })

-- This is for concealing mardown URL
-- The text: "[text](url)" will render like this: "text"
-- Conceallevel is require, it will hide url link.
vim.opt_local.conceallevel = 2
-- Hide even if the cursor hovers the url
vim.opt_local.concealcursor = "nc"
