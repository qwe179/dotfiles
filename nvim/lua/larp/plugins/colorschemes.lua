return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            flavour = 'mocha', -- latte, frappe, macchiato, mocha
            show_end_of_buffer = true,
            dim_inactive = {
                enabled = true,
                shade = 'dark',
                percentage = 0.1,
            },
            -- transparent_background = true,
            -- styles = {
            --     sidebars = 'transparent',
            --     floats = 'transparent',
            -- },
            default_integrations = true,
            integrations = {
                blink_cmp = true,
                colorful_winsep = {
                    enabled = true,
                    color = 'red',
                },
                diffview = true,
                dropbar = {
                    enabled = true,
                    color_mode = true,
                },
                fzf = true,
                cmp = true,
                gitsigns = true,
                grug_far = true,
                indent_blankline = {
                    enabled = true,
                    scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = false,
                },
                leap = true,
                markdown = true,
                mason = true,
                nvimtree = true,
                neogit = true,
                noice = true,
                treesitter = true,
                overseer = true,
                rainbow_delimiters = true,
                render_markdown = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
                },
                lsp_trouble = true,
                which_key = true,
                notify = true,
                mini = {
                    enabled = true,
                    indentscope_color = '',
                },
                dashboard = true,
            },
        },
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            -- transparent = true,
            dim_inactive = true,
            lualine_bold = true,
        },
    },
    {
        -- For transparent background
        'xiyaowong/transparent.nvim',
        -- Modify this to enable/disable transparent background
        enabled = true,
        config = function()
            require('custom.transparent')
        end,
    },

    -- {
    --     'navarasu/onedark.nvim',
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require('onedark').setup({
    --             style = 'darker',
    --         })
    --         -- Enable theme
    --         require('onedark').load()
    --     end,
    -- },
    --
    -- {
    --     'mawkler/onedark.nvim',
    --     priority = 1000,
    --     opts = {
    --         style = 'darker',
    --     },
    --     config = function()
    --         require('onedark').setup({})
    --     end,
    -- },
    -- {
    --     'projekt0n/github-nvim-theme',
    --     enabled = false,
    --     name = 'github-theme',
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require('github-theme').setup({
    --             -- ...
    --         })
    --     end,
    -- },
}
