-- disable netrw for nvim-tree.lua plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-web-devicons').setup {
  default = true -- Enable default icons for files
}

require("nvim-tree").setup()
require("ibl").setup()
