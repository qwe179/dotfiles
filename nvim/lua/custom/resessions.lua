local resession = require('resession')
resession.setup({
    autosave = {
        enabled = true,
        interval = 60,
        notify = true,
    },
})
larp.fn.map('n', '<leader><leader>ss', resession.save)
larp.fn.map('n', '<leader><leader>sl', resession.load)
larp.fn.map('n', '<leader><leader>sd', resession.delete)
vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = function()
        -- Always save a special session named "last"
        resession.save('last')
    end,
})
