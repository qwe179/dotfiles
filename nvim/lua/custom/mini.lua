-- mini.align is a module that aligns text in visual mode
require('mini.align').setup({})
require('mini.keymap').setup({})
require('mini.pairs').setup({})

-- mini.ai is a module that provides more text objects, especially for ones that start with `a(round)`, and `i(nside)`
-- Check out the documentation for more information (https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md)
require('mini.ai').setup({})
require('mini.surround').setup({
    respect_selection_type = true,
    mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    },
})
require('mini.move').setup({
    mappings = {
        -- In Visual Mode
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',

        -- In Normal Mode
        line_left = '<M-s-h>',
        line_right = '<M-s-l>',
        line_down = '<M-s-j>',
        line_up = '<M-s-k>',
    },
})
require('mini.sessions').setup({
    autoread = true,
    autowrite = true,
    verbose = {
        read = true,
        write = true,
        delete = true,
    },
})
require('mini.splitjoin').setup({})
require('mini.comment').setup({})
local files = require('mini.files')
larp.fn.map('n', '<leader>tm', function()
    files.open()
end)

larp.fn.map('n', '<leader>mf', function()
    files.open()
end)
