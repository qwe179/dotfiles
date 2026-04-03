return {
    {
        'ibhagwan/fzf-lua',
        enabled = false,
        event = 'VeryLazy',
        dependencies = {
            'echasnovski/mini.icons',
            { 'junegunn/fzf', build = './install --bin' },
        },
        config = function()
            require('custom.fzf-lua')
        end,
    },
    {
        'ggandor/leap.nvim',
        event = 'BufRead',
        keys = {
            { 's', '<Plug>(leap)', mode = { 'n', 'x' } },
            { 'S', '<Plug>(leap-from-window)', mode = { 'n', 'x' } },
            { 's', '<Plug>(leap-forward)', mode = 'o' },
            { 'S', '<Plug>(leap-backward)', mode = 'o' },
        },
        dependencies = {
            'ggandor/flit.nvim',
            'tpope/vim-repeat',
        },
        config = function()
            require('custom.leap')
        end,
    },
    {
        'ggandor/flit.nvim',
        event = 'BufRead',
        config = function()
            require('custom.flit')
        end,
    },
    {
        'mikavilpas/yazi.nvim',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                '<leader>ty',
                mode = { 'n', 'v' },
                '<cmd>Yazi<cr>',
                desc = 'Open yazi at the current file',
            },
            -- {
            --     -- Open in the current working directory
            --     '<leader>cw',
            --     '<cmd>Yazi cwd<cr>',
            --     desc = "Open the file manager in nvim's working directory",
            -- },
            -- {
            --     '<c-up>',
            --     '<cmd>Yazi toggle<cr>',
            --     desc = 'Resume the last yazi session',
            -- },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = '<f1>',
            },
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            require('custom.harpoon')
        end
    },
}
