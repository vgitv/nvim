-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
            vim.highlight.on_yank {higroup='Visual', timeout=500}
        end,
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'CPP template',
        group = vim.api.nvim_create_augroup('cpp_template', { clear = true }),
        pattern = {'*.cpp'},
        command = [[1read ~/.config/nvim/templates/skeleton.cpp | 1delete]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'HTML template',
        group = vim.api.nvim_create_augroup('html_template', { clear = true }),
        pattern = '*.html',
        command = [[1read ~/.config/nvim/templates/skeleton.html | 1delete]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'Bash template',
        group = vim.api.nvim_create_augroup('sh_template', { clear = true }),
        pattern = '*.sh',
        command = [[0read ~/.config/nvim/templates/skeleton.sh | norm G]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'Python template',
        group = vim.api.nvim_create_augroup('py_template', { clear = true }),
        pattern = '*.py',
        command = [[1read ~/.config/nvim/templates/skeleton.py | 1delete]]
    }
)
