return {
    "neovim/nvim-lspconfig",
    ft = { "lua", "python", "sh" },
    config = function()
        local servers = { "lua_ls", "pyright", "bashls" }
        for _, lsp in ipairs(servers) do
            vim.lsp.enable(lsp)
        end
    end,
}
