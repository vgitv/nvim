local init_group = vim.api.nvim_create_augroup('init_group', { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
        desc = 'Highlight when yanking (copying) text',
        group = init_group,
        callback = function()
            vim.highlight.on_yank {higroup='Visual', timeout=500}
        end,
    }
)


--  _                       _       _            
-- | |_ ___ _ __ ___  _ __ | | __ _| |_ ___  ___ 
-- | __/ _ \ '_ ` _ \| '_ \| |/ _` | __/ _ \/ __|
-- | ||  __/ | | | | | |_) | | (_| | ||  __/\__ \
--  \__\___|_| |_| |_| .__/|_|\__,_|\__\___||___/
--                   |_|   

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'CPP template',
        group = init_group,
        pattern = {'*.cpp'},
        command = [[1read ~/.config/nvim/templates/skeleton.cpp | 1delete]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'HTML template',
        group = init_group,
        pattern = '*.html',
        command = [[1read ~/.config/nvim/templates/skeleton.html | 1delete]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'Bash template',
        group = init_group,
        pattern = '*.sh',
        command = [[0read ~/.config/nvim/templates/skeleton.sh | norm G]]
    }
)

vim.api.nvim_create_autocmd(
    'BufNewFile',
    {
        desc = 'Python template',
        group = init_group,
        pattern = { 'main.py', '__main__.py' },
        command = [[1read ~/.config/nvim/templates/skeleton.py | 1delete]]
    }
)


--   __ _ _      _                         
--  / _(_) | ___| |_ _   _ _ __   ___  ___ 
-- | |_| | |/ _ \ __| | | | '_ \ / _ \/ __|
-- |  _| | |  __/ |_| |_| | |_) |  __/\__ \
-- |_| |_|_|\___|\__|\__, | .__/ \___||___/
--                   |___/|_|

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set groff filetype for *.groff files',
        group = init_group,
        pattern = '*.groff',
        command = 'setlocal filetype=groff',
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set yaml filetype for .yamllint file',
        group = init_group,
        pattern = '.yamllint',
        command = 'setlocal filetype=yaml',
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set yaml filetype for .ansible-lint file',
        group = init_group,
        pattern = '.ansible-lint',
        command = 'setlocal filetype=yaml',
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set toml filetype for poetry.lock file',
        group = init_group,
        pattern = 'poetry.lock',
        command = 'setlocal filetype=toml',
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set json filetype for *.schema files',
        group = init_group,
        pattern = '*.schema',
        command = 'setlocal filetype=json',
    }
)

vim.api.nvim_create_autocmd(
    {
        'BufNewFile',
        'BufRead',
    },
    {
        desc = 'Set dircolors filetype for dir_colors and .dir_colors files',
        group = init_group,
        pattern = {'dir_colors', '.dir_colors'},
        command = 'setlocal filetype=dircolors',
    }
)


--  _            _                                       _             
-- | |_ _____  _| |_   _ __  _ __ ___   ___ ___  ___ ___(_)_ __   __ _ 
-- | __/ _ \ \/ / __| | '_ \| '__/ _ \ / __/ _ \/ __/ __| | '_ \ / _` |
-- | ||  __/>  <| |_  | |_) | | | (_) | (_|  __/\__ \__ \ | | | | (_| |
--  \__\___/_/\_\\__| | .__/|_|  \___/ \___\___||___/___/_|_| |_|\__, |
--                    |_|                                        |___/ 

-- For word processing filetypes (like mardown, LaTeX, ...) a smaller
-- textwidth is convenient. Besides, lines will break automatically.
-- Why not use ftplugin for this? Because we want to do the same actions
-- for multiple filetypes.
vim.api.nvim_create_autocmd(
    'filetype',
    {
        desc = 'Small textwidth for word processing filetypes',
        group = init_group,
        pattern = {'markdown', 'plaintex'},
        callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
            vim.opt_local.textwidth = 79
            vim.opt_local.colorcolumn = '+1'
        end
    }
)


--      _       _           __ _ _           
--   __| | __ _| |_ __ _   / _(_) | ___  ___ 
--  / _` |/ _` | __/ _` | | |_| | |/ _ \/ __|
-- | (_| | (_| | || (_| | |  _| | |  __/\__ \
--  \__,_|\__,_|\__\__,_| |_| |_|_|\___||___/

vim.api.nvim_create_autocmd(
    'filetype',
    {
        desc = 'Small indent for structured data filetypes',
        group = init_group,
        pattern = {'yaml', 'html', 'json', 'xml'},
        callback = function()
            vim.opt_local.tabstop = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.shiftwidth = 2
        end
    }
)

vim.api.nvim_create_autocmd(
    'filetype',
    {
        desc = 'No colorcolumn for data filetypes',
        group = init_group,
        pattern = {'csv', 'json', 'xml'},
        callback = function()
            vim.opt_local.colorcolumn = ''
        end
    }
)


--            _          
--  _ __ ___ (_)___  ___ 
-- | '_ ` _ \| / __|/ __|
-- | | | | | | \__ \ (__ 
-- |_| |_| |_|_|___/\___|

vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        desc = 'Terminal specific options',
        group = init_group,
        callback = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.cursorline = false
        end
    }
)
