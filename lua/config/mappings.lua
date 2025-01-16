-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move left!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move right!"<CR>')

-- Run an external script to build current file.
vim.keymap.set("n", "<F4>", function()
    vim.cmd "!xbuild %"
end, { desc = "Build current file using external script" })

-- Set a mark, indent whole file and go back to the mark
vim.keymap.set("n", "<F6>", "mzgg=G`zzz", { desc = "Indent all file" })

-- Remove all carriage return from file
vim.keymap.set("n", "<F12>", "mz:%s/\r//g<CR>`z", { desc = "Indent all file" })

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Next replace
vim.keymap.set("i", "<C-b>", '<Esc>/<++><CR>"_c4l', { desc = "Replace next <++>" })

-- switch case of all word
vim.keymap.set("i", "<C-_>", "<ESC>mzbviw~`za", { desc = "Switch case of all word" })
vim.keymap.set("n", "<C-_>", "mzviw~`z", { desc = "Switch case of all word" })

-- insert blank line without entering insert mode
vim.keymap.set("n", "<C-n>", "o<Esc>", { desc = "Insert empty line above" })

-- select all file
vim.keymap.set("n", "<Leader>a", "ggVG", { desc = "Select all file" })

-- edit $VIMRC
vim.keymap.set("n", "<Leader>e", function()
    EditNvimInitFile()
end, { desc = "[E]dit $VIMRC in a new tab" })

-- toggle wrap
vim.keymap.set("n", "<Leader>z", ":set wrap!<CR>", { desc = "Toggle line wrap" })

-- Escape in terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Git conflicts
vim.keymap.set("n", "<Leader>gg", "/<<<<<<< HEAD<CR>", { desc = "[G]it [G]o to next conflict" })
vim.keymap.set("n", "<Leader>go", '"_dd/=======<CR>V/>>>>>>><CR>"_d', { desc = "Accept [G]it [O]urs" })
vim.keymap.set("n", "<Leader>gt", 'V/=======<CR>"_d/>>>>>>><CR>"_dd', { desc = "Accept [G]it [T]eirs" })

vim.keymap.set("n", "<Leader>h", ":syntax sync fromstart<CR>", { desc = "Fix syntax problems" })

-- Toggle highlight search
vim.keymap.set("n", "<Leader>ss", ":set hlsearch!<CR>:set hlsearch?<CR>", { desc = "Toggle hlsearch" })

-- Insert a pair of {}
vim.keymap.set("i", "<C-j>", "{<CR>}<Esc>O", { desc = "Insert a pair of {}" })

-- operator mappings
vim.keymap.set("o", "in(", ":<C-U>normal! f(vi(<CR>", { desc = "[I]n [N]ext parenthesis" })
-- inside previous (last) (
-- Not using ip because it would shadow paragraph movement
vim.keymap.set("o", "il(", ":<C-U>normal! F)vi(<CR>", { desc = "[I]n [L]ast parenthesis" })
vim.keymap.set("o", "in@", ":<c-u>normal! f@viW<cr>", { desc = "[I]n [N]ext email address" })

-- Lint and format
vim.keymap.set("n", "<F3>", function()
    LintCurrentFile()
end, { desc = "Lint current file" })
vim.keymap.set("n", "<LocalLeader>f", function()
    FormatCurrentFile()
end, { desc = "Format current file" })
