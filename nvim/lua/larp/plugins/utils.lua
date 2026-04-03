return {
    {
        -- Sudo write/read
        'lambdalisue/vim-suda',
        keys = {
            { '<leader><leader>Sw', '<cmd>SudaWrite<cr>', mode = 'n', desc = 'Sudo Write' },
            { '<leader><leader>Sr', '<cmd>SudaRead<cr>', mode = 'n', desc = 'Sudo Read' },
        },
        cmd = { 'SudaWrite', 'SudaRead' },
        config = function()
            vim.g.suda_smart_edit = 1
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        config = function()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' can be specified
            })
        end,
    },

    {
        -- Preview the definition of the word under the cursor
        'rmagatti/goto-preview',
        event = 'BufRead',
        opts = {
            default_mappings = true,
        },
    },
    {
        -- AutoSession takes advantage of Neovim's existing session management capabilities
        -- to provide seamless automatic session management.
        'rmagatti/auto-session',
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Downloads', '/' },
            -- log_level = 'debug',
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        config = function()
            require('custom.quicker')
        end,
    },
    {
        'NMAC427/guess-indent.nvim',
        opts = {},
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        dependencies = {
            {
                'junegunn/fzf',
                run = function()
                    vim.fn['fzf#install']()
                end,
            },
            { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
        },
    },
    {
        'meznaric/key-analyzer.nvim',
        cmd = { 'KeyAnalyzer' },
        opts = {},
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('custom.snacks')
        end,
    },
    {
        'atiladefreitas/dooing',
        keys = {
            { '<leader>td', mode = 'n' },
        },
        cmd = 'Dooing',
        config = function()
            require('dooing').setup({
                -- your custom config here (optional)
            })
        end,
    },
    {
        'RaafatTurki/hex.nvim',
        event = 'BufRead',
        opts = {},
        cmd = { 'HexDump', 'HexToggle', 'HexAssemble' }
    },
    {
        -- Easily identify abandoned Neovim plugins
        'ZWindL/orphans.nvim',
        opts = {},
    },
    {
        'rachartier/tiny-code-action.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'ibhagwan/fzf-lua' },
        },
        event = 'LspAttach',
        keys = {
            {
                '<leader>cA',
                function()
                    require('tiny-code-action').code_action()
                end,
                mode = { 'n', 'v' },
                desc = 'Code Action',
            },
        },
        opts = {},
    },
    {
        -- Color picker utils
        'uga-rosa/ccc.nvim',
        cmd = {
            'CccConvert',
            'CccPick',
            'CccHighlighterDisable',
            'CccHighlighterEnable',
            'CccHighlighterToggle',
        },
        config = function()
            require('custom.ccc')
        end,
    },
    {
        -- Awesome Neovim plugin list
        'alex-popov-tech/store.nvim',
        dependencies = {
            'OXY2DEV/markview.nvim', -- optional, for pretty readme preview / help window
        },
        cmd = 'Store',
        keys = {
            { '<leader>ps', '<cmd>Store<cr>', desc = 'Open Plugin Store' },
        },
        opts = {
            -- optional configuration here
        },
    },
}
