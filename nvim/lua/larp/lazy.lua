-- Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'larp.plugins' },
        -- require('larp.plugins.startscreen.dashboard'),
    },
    rocks = {
        luarocks = { python3 = 'python3' },
    },
})

larp.fn.map('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'Open Lazy Menu' })
