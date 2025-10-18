-- read this: https://cmp.saghen.dev/installation.html#merging-lsp-capabilities
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "rafamadriz/friendly-snippets",
        {
            "saghen/blink.cmp",

            -- optional: provides snippets for the snippet source
            dependencies = {},

            -- use a release tag to download pre-built binaries
            version = "1.*",
            -- opts_extend = { "sources.default" },
        },
    },
    ft = { "lua", "python", "sh" },
    config = function()
        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local servers = { "lua_ls", "pyright", "bashls" }
        for _, lsp in ipairs(servers) do
            vim.lsp.enable(lsp)
            -- TODO verify that this is doing something: which capabilities are we adding?
            vim.lsp.config(lsp, { capabilities = capabilities })
            -- FIXME Why vim.lsp.buf.format() fails on python but succeed on lua?
        end
    end,
}
