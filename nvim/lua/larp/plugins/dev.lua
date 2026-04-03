return {
    {
        -- Better terminal support with persistent history
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            open_mapping = [[<c-t>]],
        },
    },
    {
        'stevearc/overseer.nvim',
        cmds = {
            'Overseer',
            'OverseerRun',
            'OverseerRunCmd',
            'OverseerToggle',
            'OverseerBuild',
            'OverseerTaskAction',
            'OverseerClose',
            'OverseerClearCache',
            'OverseerDeleteBundle',
            'OverseerLoadBundle',
            'OverseerInfo',
        },
        keys = {
            '<leader>cor',
            mode = 'n',
            '<leader>coR',
            mode = 'n',
            '<leader>coa',
            mode = 'n',
            '<leader>cob',
            mode = 'n',
            '<leader>cot',
            mode = 'n',
        },
        dependencies = {
            'akinsho/toggleterm.nvim',
            -- 'rmagatti/auto-session',
        },
        config = function()
            require('custom.overseer')
        end,
    },
    {
        'mfussenegger/nvim-dap',
        cmd = {
            'DapNew',
            'DapEval',
            'DapContinue',
            'DapDisconnect',
            'DapStepInto',
            'DapStepOut',
            'DapShowLog',
        },
        event = 'BufRead',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
            },
            {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
            },
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('custom.nvim-dap')
        end,
    },
    {
        -- 1. Highlights TODO, FIXME, etc. in your code
        -- 2. Provides a list of all the highlights in your project
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('custom.todo-comments')
        end,
    },
}
