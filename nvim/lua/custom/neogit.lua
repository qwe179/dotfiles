require('neogit').setup({})
larp.fn.map('n', '<leader>Go', '<cmd>Neogit<cr>', { desc = 'Open Neogit' })
larp.fn.map('n', '<leader>Gd', '<cmd>Neogit diff <cr>', { desc = 'Open Neogit Diff' })
