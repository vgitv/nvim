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

local bullets = { "^%s*%- %[.%] ", "^%s*%* ", "^%s*%- ", "^%s*%d+%. " }

---Does the string match one of the given patterns
---@param str string
---@param patterns table
---@return string first match
local match_one_of = function(str, patterns)
    for _, pattern in ipairs(patterns) do
        local match = string.match(str, pattern)
        if match then
            return match
        end
    end
    return nil
end

---Insert a new line and put cursor at the end of it
---@param lnum integer line number, zero-based
---@param content string content to insert
local insert_line = function(lnum, content)
    -- Be carefull, indexing is zero based ...
    vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { content })
    -- ... and here it starts at 1
    vim.fn.setcharpos(".", { 0, lnum + 1, string.len(content), 0 })
end

local continue_bullet = function()
    local current_line = vim.api.nvim_get_current_line()
    local match = match_one_of(current_line, bullets)
    local lnum = vim.fn.getcharpos(".")[2]

    if match then
        if current_line == match then
            -- current bullet item is empty, delete it
            vim.api.nvim_set_current_line ""
            insert_line(lnum, "")
        else
            -- automatically insert new bullet
            num = string.match(match, "%d")
            if num then
                match = (num + 1) .. ". "
            end
            insert_line(lnum, match)
        end
    else
        -- insert empty line
        insert_line(lnum, "")
    end
    vim.cmd "startinsert!"
end

vim.keymap.set("i", "<CR>", continue_bullet, { desc = "TODO", buffer = true })
vim.keymap.set("n", "o", continue_bullet, { desc = "TODO", buffer = true })
