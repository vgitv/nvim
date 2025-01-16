return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
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
    ft = { "lua", "python", "sh" },
    config = function()
        -- See :help ins-completion for the defaults
        local cmp = require "cmp"
        cmp.setup {
            mapping = cmp.mapping.preset.insert {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-y>"] = cmp.mapping.confirm { select = true },
            },
            sources = cmp.config.sources {
                { name = "nvim_lsp" },
                { name = "buffer" },
            },
        }

        -- From now on you should have install the appropriate LSP configurations.
        -- See :help lspconfig-all to see the full list of lsp configurations.
        -- For instance install pyright for Python, lua_ls for lua etc.
        -- Exemple : sudo pacman -S pyright
        local lspconfig = require "lspconfig"
        local servers = { "pyright", "lua_ls", "bashls" }
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { capabilities = capabilities }
        end

        -- FIXME should be natively included in later versions of neovim (already in the nightly realase)
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename variable" })
        vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code action" })
        vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "Go to references" })
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "Document symbol" })
        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Signature help" })

        -- Go to the source code of an underlying function
        -- Use different mecanics but result is similar to <C-]> See :help ctrl-]
        -- vim.lsp.buf.definition uses LSP functionnality whereas ctrl-] uses tags
        vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
    end,
}
