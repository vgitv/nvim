-- show matching brackets.
vim.opt.showmatch = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- mouse in all modes - middle-click paste with mouse
vim.opt.mouse = "a"

-- highlight search results
vim.opt.hlsearch = true

-- number of columns occupied by a tab character
vim.opt.tabstop = 4

-- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.softtabstop = 4

-- width for autoindents
vim.opt.shiftwidth = 4

-- converts tabs to white space
vim.opt.expandtab = true

-- indent a new line the same amount as the line just typed
vim.opt.autoindent = true

-- add line numbers
vim.opt.number = true

-- get bash-like tab completions
vim.opt.wildmode = { "longest:full", "full" }

-- 0 => dont break long line automatically
vim.opt.textwidth = 0

-- set a 120 column border for good coding style
vim.opt.colorcolumn = { 120 }

-- dont wrap long lines
vim.opt.wrap = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

-- round indent to multiple of shiftwidth
vim.opt.shiftround = true

-- uses gui :highlight attributes instead of cterm attributes
vim.opt.termguicolors = true

-- highlight cursor line
vim.opt.cursorline = true

-- dark background
vim.opt.background = "dark"

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- when and how to draw the foldcolumn
vim.opt.foldcolumn = "auto"

-- displaying the diagnostics in the line number column will prevent the text to shift distractingly
vim.opt.signcolumn = "number"

-- 3 to have only one status line at the bottom of the screen (and not a status
-- line for each window). This option will be potentially overriden by the
-- 'globalstatus' option of the plugin lualine.nvim
vim.opt.laststatus = 3

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions, shows partial off-screen results in a preview window
vim.opt.inccommand = "split"

vim.g.have_nerd_font = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
