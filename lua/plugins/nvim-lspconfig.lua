return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/nvim-cmp',
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    ft = { 'lua', 'python', 'sh' },
    config = function()
        -- See :help ins-completion for the defaults
        local cmp = require('cmp')
        cmp.setup {
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
            }
        }

        -- Set up lspconfig.
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- From now on you should have install the appropriate LSP configurations.
        -- See :help lspconfig-all to see the full list of lsp configurations.
        -- For instance install pyright for Python, lua_ls for lua etc.
        -- Exemple : sudo pacman -S pyright
        local lspconfig = require('lspconfig')
        local servers = { 'pyright', 'lua_ls', 'bashls' }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities }
        end
    end
}
