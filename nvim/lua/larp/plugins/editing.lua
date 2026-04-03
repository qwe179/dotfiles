return {
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>Ss',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
            },
        },
        opts = {},
    },
    {
        'smjonas/live-command.nvim',
        -- live-command supports semantic versioning via Git tags
        -- tag = "2.*",
        config = function()
            require('live-command').setup({
                commands = {
                    Norm = { cmd = 'norm' },
                },
            })
        end,
    },
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>fs',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
                desc = ' rip substitute',
            },
        },
    },
    {
        'chrisgrieser/nvim-scissors',
        dependencies = { 'nvim-telescope/telescope.nvim', 'garymjr/nvim-snippets' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        keys = {
            {
                '<leader>se',
                function()
                    require('scissors').editSnippet()
                end,
                mode = { 'n' },
                desc = ' edit snippet',
            },
            {
                '<leader>sa',
                function()
                    require('scissors').addNewSnippet()
                end,
                mode = { 'n', 'x' },
                desc = ' add new snippet',
            },
        },
    },

    {
        -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
        'chrisgrieser/nvim-spider',
        event = 'BufRead',
        config = function()
            require('custom.nvim-spider')
        end,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
    },
    {
        'ibhagwan/smartyank.nvim',
        opts = {
            highlight = {
                enabled = true,
                higroup = 'IncSearch',
                timeout = 200,
            },
            osc52 = {
                enabled = true,
                ssh_only = true,
                silent = false,
            },
            clipboard = {
                enabled = false,
            },
        },
    },
}
