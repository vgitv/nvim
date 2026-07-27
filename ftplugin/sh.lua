-- HACK: filetype is not deduced from shebang, sor force bash for all .sh files
local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)

for _, line in ipairs(first_line) do
    if line:find("^#!/.*/bash.*") then
        vim.cmd "setlocal filetype=bash"
        print "Bash filetype detected from shebang (see ~/.config/nvim/ftplugin/sh.lua)"
    end
end
