require('larp.larp-nvim')
require('larp.config')
require('larp.third-party')
require('larp.lazy')
-- lazy loads this
-- require('larp.plugins')

vim.cmd.colorscheme('catppuccin')

-- Small LSP setup
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
