return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufWinEnter',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'stevearc/overseer.nvim',
        },
        config = function()
            require('custom.lualine')
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('custom.noice')
        end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        -- Loading screen on the bottom right
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {
            -- options
        },
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    },
    {
        -- Peek buffer while typing :<linenumber>
        'nacro90/numb.nvim',
        config = true,
    },
    {
        'petertriho/nvim-scrollbar',
        event = 'BufRead',
    },
    {
        'stevearc/oil.nvim',
        lazy = false,
        tag = 'stable',
        dependencies = {
            'echasnovski/mini.icons',
        },
        opts = {
            default_file_explorer = true,
            delete_to_trash = true,
            use_default_keymaps = false,
            keymaps = {
                ['g?'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['-'] = 'actions.parent',
                -- If you want to automatically change the directory when selecting a file
                -- ['<CR>'] = function()
                --     require('oil').select(nil, function(err)
                --         if not err then
                --             local curdir = require('oil').get_current_dir()
                --             if curdir then
                --                 vim.cmd.lcd(curdir)
                --             end
                --         end
                --     end)
                -- end,
                -- ['-'] = function()
                --     require('oil.actions').parent.callback()
                --     vim.cmd.lcd(require('oil').get_current_dir())
                -- end,
                ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
                ["<C-g>"] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
                -- ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<F5>'] = 'actions.refresh',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                -- ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
                ['gs'] = 'actions.change_sort',
                ['gx'] = 'actions.open_external',
                ['g.'] = 'actions.toggle_hidden',
                ['g\\'] = 'actions.toggle_trash',
            },
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
                sort = {
                    { 'type', 'desc' },
                    { 'name', 'asc' },
                },
            },
            -- sort_by = function(a, b)
            --     if a.type == 'directory' and b.type ~= 'directory' then
            --         return true
            --     elseif a.type ~= 'directory' and b.type == 'directory' then
            --         return false
            --     else
            --         local function get_extension(file)
            --             return file.name:match('^.+(%..+)$') or ''
            --         end
            --
            --         local ext_a = get_extension(a.name):lower()
            --         local ext_b = get_extension(b.name):lower()
            --
            --         if ext_a == ext_b then
            --             return a.name:lower() < b.name:lower()
            --         else
            --             return ext_a < ext_b
            --         end
            --     end
            -- end,
            columns = {
                'icon',
                'mtime',
                'size',
                'permissions',
            },
            win_options = {
                wrap = true,
                winbar = "%{v:lua.require('oil').get_current_dir()}",
            },
        },
        keys = {
            {
                '-',
                function()
                    if vim.bo.buftype == '' then
                        require('oil').open()
                    end
                end,
                mode = 'n',
                desc = 'Open parent directory',
            },
        },
    },
    {
        'folke/trouble.nvim',
        branch = 'main', -- IMPORTANT!
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
    },
    {
        'RRethy/vim-illuminate',
        enabled = false,
        event = 'BufRead',
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            require('custom.which-key')
        end,
    },
    {
        -- Colorful window separator
        'nvim-zh/colorful-winsep.nvim',
        config = true,
        event = { 'WinLeave' },
    },
    {
        -- Changes the color of the line number depending on the current mode.
        'mawkler/modicator.nvim',
        event = 'VeryLazy',
        init = function()
            -- These are required for Modicator to work
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
    {
        'nvzone/showkeys',
        cmd = 'ShowkeysToggle',
        opts = {
            maxkeys = 5,
            winopts = {
                focusable = true,
            },
            show_count = true,
            position = 'top-right',
        },
    },
    {
        -- Neovide-like cursor
        'sphamba/smear-cursor.nvim',
        enabled = false,
        event = 'BufWinEnter',
        config = function()
            require('custom.smear-cursor')
        end,
    },
    {
        -- Tabs
        'akinsho/bufferline.nvim',
        event = 'BufWinEnter',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {},
        keys = {
            { 'L', '<cmd>BufferLineCycleNext<cr>', mode = 'n', desc = 'Next Buffer' },
            { 'H', '<cmd>BufferLineCyclePrev<cr>', mode = 'n', desc = 'Previous Buffer' },
            { '<leader>>', '<cmd>BufferLineMoveNext<cr>', mode = 'n', desc = 'Move Buffer to the Right' },
            { '<leader><', '<cmd>BufferLineMovePrev<cr>', mode = 'n', desc = 'Move Buffer to the Left' },
            { '<leader>bc', '<cmd>BufferLinePickClose<cr>', mode = 'n', desc = 'Close buffer' },
            { '<leader>bp', '<cmd>BufferLinePick<cr>', mode = 'n', desc = 'Pick Buffer' },
            { '<leader>br', '<cmd>BufferLineTabRename<cr>', mode = 'n', desc = 'Rename Tab' },
        },
    },
    {
        'jake-stewart/auto-cmdheight.nvim',
        lazy = false,
        opts = {
            -- max cmdheight before displaying hit enter prompt.
            max_lines = 5,

            -- number of seconds until the cmdheight can restore.
            duration = 2,

            -- whether key press is required to restore cmdheight.
            remove_on_key = true,

            -- always clear the cmdline after duration and key press.
            -- by default it will only happen when cmdheight changed.
            clear_always = false,
        },
    },
    {
        'mcauley-penney/visual-whitespace.nvim',
        config = true,
        event = 'ModeChanged *:[vV\22]', -- optionally, lazy load on entering visual mode
        opts = {},
    },
    {
        'rachartier/tiny-code-action.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'ibhagwan/fzf-lua' },
        },
        event = 'LspAttach',
        opts = {},
        keys = {
            {
                '<leader>ca',
                function()
                    require('tiny-code-action').code_action()
                end,
                mode = 'n',
                desc = 'Code Action',
                noremap = true,
                silent = true,
            },
        }
    },
}
