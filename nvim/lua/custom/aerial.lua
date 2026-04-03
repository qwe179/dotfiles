require('aerial').setup({
    -- optionally use on_attach to set keymaps when aerial has attached to a buffer
    on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end,
    autojump = true,
})
-- You probably also want to set a keymap to toggle aerial
larp.fn.map('', '<leader>to', '<cmd>AerialToggle<cr>', { desc = 'Toggle Aerial Overview' })
