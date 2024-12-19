return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp'
    },
    ft = { 'lua', 'python', 'sh' },
    config = function()
        local cmp = require('cmp')
        cmp.setup {
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-o>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            },
            {
                { name = 'buffer' },
            })
        }

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- From now on you should have install the appropriate LSP configurations.
        -- See :help lspconfig-all to see the full list of lsp configurations.
        -- For instance install pyright for Python, lua_ls for lua etc.
        -- Exemple : sudo pacman -S pyright
        local lspconfig = require('lspconfig')
        lspconfig.pyright.setup {
            capabilities = capabilities
        }

        -- Reading :help lspconfig-all, in the lua_ls section, it says:
        -- "If you primarily use `lua-language-server` for Neovim, and want to provide completions,
        -- analysis, and location handling for plugins on runtime path, you can use the following
        -- settings."
        -- Without this configuration, you get lot of warning due to the fact that scope like vim.g
        -- or vim.opt are unknown to lua_ls. Besides, you get way better syntax highlighting with
        -- this configuration.
        lspconfig.lua_ls.setup{
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        }

        lspconfig.bashls.setup{}
    end
}
