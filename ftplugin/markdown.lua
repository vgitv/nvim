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

Renumber = function()
    local numbers = "^%s*%d+%. "
    local lnum = vim.fn.getcharpos(".")[2]
    local lines = vim.api.nvim_buf_get_lines(0, lnum, -1, false)
    local current_line = vim.api.nvim_get_current_line()
    local match = string.match(current_line, numbers)
    local start_from = string.match(match, "%d+")
    local new_lines = {}
    for i, line in ipairs(lines) do
        match = string.match(line, numbers)
        if match then
            match = match:gsub("%d+", start_from + i)
            line = line:gsub(numbers, match)
            table.insert(new_lines, line)
        else
            break
        end
    end
    if #new_lines > 0 then
        vim.api.nvim_buf_set_lines(0, lnum, lnum + #new_lines, false, new_lines)
    end
end

local insert_bullet = function(ref_line_num)
    local ref_line = vim.api.nvim_buf_get_lines(0, ref_line_num - 1, ref_line_num, false)[1]
    local match = match_one_of(ref_line, bullets)

    if match then
        if ref_line == match then
            -- current bullet item is empty, delete it
            vim.api.nvim_buf_set_lines(0, ref_line_num - 1, ref_line_num, false, { "" })
        else
            -- automatically insert new bullet
            num = string.match(match, "%d+")
            if num then
                num = num + 1
                match = match:gsub("%d+", num)
                vim.api.nvim_put({ match }, "c", false, true)
                Renumber()
            else
                vim.api.nvim_put({ match }, "c", false, true)
            end
        end
    end
end

vim.keymap.set("i", "<CR>", function()
    local current_line_num = vim.fn.getcharpos(".")[2]
    vim.api.nvim_put({ "", "" }, "c", false, true)
    insert_bullet(current_line_num)
    vim.cmd "startinsert"
end, { desc = "TODO", buffer = true })

vim.keymap.set("n", "o", function()
    local current_line_num = vim.fn.getcharpos(".")[2]
    vim.cmd "normal! o"
    insert_bullet(current_line_num)
    vim.cmd "startinsert!"
end, { desc = "TODO", buffer = true })

vim.keymap.set("n", "O", function()
    local current_line_num = vim.fn.getcharpos(".")[2]
    vim.cmd "normal! O"
    insert_bullet(current_line_num + 1)
    vim.cmd "startinsert!"
end, { desc = "TODO", buffer = true })

vim.keymap.set("n", "dd", function()
    local to_delete_line = vim.api.nvim_get_current_line()
    -- FIXME multiple definition of numbers
    local numbers = "^%s*%d+%. "
    local to_delete_match = string.match(to_delete_line, numbers)
    vim.cmd "normal! dd"
    if to_delete_match then
        local current_line = vim.api.nvim_get_current_line()
        local match = string.match(current_line, numbers)
        if match then
            local num = string.match(match, "%d+")
            local new_bullet = match:gsub("%d+", num - 1)
            vim.api.nvim_set_current_line((current_line:gsub(numbers, new_bullet)))
            Renumber()
        end
    end
end, { desc = "TODO", buffer = true })
