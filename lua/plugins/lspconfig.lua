-- See https://cmp.saghen.dev
return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = false } },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}


-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/nvim-cmp",
--         {
--             "folke/lazydev.nvim",
--             ft = "lua",
--             opts = {
--                 library = {
--                     -- See the configuration section for more details
--                     -- Load luvit types when the `vim.uv` word is found
--                     { path = "${3rd}/luv/library", words = { "vim%.uv" } },
--                 },
--             },
--         },
--     },
--     ft = { "lua", "python", "sh", "toml" },
--     config = function()
--         -- See :help ins-completion for the defaults
--         local cmp = require "cmp"
--         cmp.setup {
--             mapping = cmp.mapping.preset.insert {
--                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                 ["<C-Space>"] = cmp.mapping.complete(),
--                 ["<C-e>"] = cmp.mapping.abort(),
--                 -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--                 ["<C-y>"] = cmp.mapping.confirm { select = true },
--             },
--             sources = cmp.config.sources {
--                 { name = "nvim_lsp" },
--                 { name = "buffer" },
--             },
--         }
--
--         -- From now on you should have install the appropriate LSP configurations.
--         -- See :help lspconfig-all to see the full list of lsp configurations.
--         -- For instance install pyright for Python, lua_ls for lua etc.
--         -- Exemple : sudo pacman -S pyright
--         local servers = { "pyright", "lua_ls", "bashls", "taplo" }
--         local capabilities = require("cmp_nvim_lsp").default_capabilities()
--         for _, lsp in ipairs(servers) do
--             require"lspconfig"[lsp].setup { capabilities = capabilities }
--         end
--
--         -- FIXME should be natively included in later versions of neovim (already in the nightly realase)
--         vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename variable" })
--         vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code action" })
--         vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "Go to references" })
--         vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { desc = "Go to implementation" })
--         vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { desc = "Document symbol" })
--         vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Signature help" })
--
--         -- Go to the source code of an underlying function
--         -- Use different mecanics but result is similar to <C-]> See :help ctrl-]
--         -- vim.lsp.buf.definition uses LSP functionnality whereas ctrl-] uses tags
--         vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
--     end,
-- }
