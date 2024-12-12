-- Insert link
vim.keymap.set('v', '<C-k>', '<Esc>`<i[<Esc>`>la]()<Esc>', { desc = 'Insert markdown link' })

-- insert tabular
vim.keymap.set(
    'i',
    '<LocalLeader>t',
    function ()
        vim.cmd('normal i| <++> | <++> |')
        vim.cmd('normal o')
        vim.cmd('normal i|------|------|')
        vim.cmd('normal o')
        vim.cmd('normal i| <++> | <++> |')
        vim.cmd('normal 2k0')
    end,
    { desc = 'Insert markdown tabular' }
)
