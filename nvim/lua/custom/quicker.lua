local quicker = require('quicker')
quicker.setup()
vim.keymap.set('n', '<leader>tq', function()
    quicker.toggle()
end, {
    desc = 'Toggle quickfix',
})
vim.keymap.set('n', '<leader>tl', function()
    quicker.toggle({ loclist = true })
end, {
    desc = 'Toggle loclist',
})
quicker.setup({
    keys = {
        {
            '>',
            function()
                quicker.expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = 'Expand quickfix context',
        },
        {
            '<',
            function()
                quicker.collapse()
            end,
            desc = 'Collapse quickfix context',
        },
    },
})
