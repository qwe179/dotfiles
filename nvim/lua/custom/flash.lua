local set = vim.keymap.set

local flash = require('flash')
flash.setup({})

set({ 'n', 'x', 'o' }, 's', flash.jump, { desc = 'Flash', noremap = true, silent = true })
set({ 'n', 'x', 'o' }, 'SS', flash.treesitter, { desc = 'Flash Treesitter', noremap = true, silent = true })
set({ 'n', 'x', 'o' }, 'Sh', function()
    flash.jump({
        action = function(match, state)
            vim.api.nvim_win_call(match.win, function()
                vim.api.nvim_win_set_cursor(match.win, match.pos)
                vim.lsp.buf.hover()
                -- vim.diagnostic.open_float()
            end)
            state:restore()
        end,
    })
end, { desc = 'Flash Hover', noremap = true, silent = true })
set('o', 'r', flash.remote, { desc = 'Remote Flash', noremap = true, silent = true })
set({ 'o', 'x' }, 'R', flash.treesitter_search, { desc = 'Treesitter Search', noremap = true, silent = true })
set({ 'c' }, '<c-s>', flash.toggle, { desc = 'Toggle Flash Search', noremap = true, silent = true })
