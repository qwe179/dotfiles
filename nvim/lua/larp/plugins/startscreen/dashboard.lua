local arts = require('larp.plugins.startscreen.arts')
local random_art = larp.fn.tbl_choose_random(arts)[1]
local final_art = larp.fn.limit_text_art_size(random_art.art, 80, 20)
local header = vim.list_extend({ '', '' }, final_art)
header = vim.list_extend(header, { '', '' })

return {
    'nvimdev/dashboard-nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'ibhagwan/fzf-lua',
        'LintaoAmons/bookmarks.nvim',
        'stevearc/resession.nvim',
    },
    event = 'VimEnter',
    config = function()
        require('dashboard').setup({
            theme = 'doom',
            config = {
                hide = {
                    tabline = true,
                },
                header = header,
                center = {
                    {
                        icon = ' ',
                        desc = 'New File',
                        desc_hl = 'String',
                        key = 'e',
                        action = 'enew',
                    },
                    {
                        icon = '󰈞 ',
                        desc = 'Find File',
                        desc_hl = 'String',
                        key = 'f',
                        keymap = 'SPC f f',
                        action = 'FzfLua files',
                    },
                    {
                        icon = '󰈬 ',
                        desc = 'Find Word',
                        desc_hl = 'String',
                        key = 'G',
                        keymap = 'SPC g g',
                        action = 'FzfLua live_grep_native',
                    },
                    {
                        icon = '󰊄 ',
                        desc = 'Recently opened files',
                        desc_hl = 'String',
                        key = 'r',
                        keymap = 'SPC f r',
                        action = 'FzfLua oldfiles',
                    },
                    {
                        icon = ' ',
                        desc = 'Jump to bookmarks',
                        desc_hl = 'String',
                        key = 'm',
                        keymap = 'mo',
                        action = 'BookmarksGoto',
                    },
                    {
                        icon = ' ',
                        desc = 'Load session',
                        desc_hl = 'String',
                        key = 's',
                        keymap = 'SPC S l',
                        action = require('resession').load,
                    },
                    {
                        icon = ' ',
                        desc = 'Find Nvim Config',
                        desc_hl = 'String',
                        key = 'h',
                        keymap = 'SPC h f d',
                        action = 'FzfLua files cwd=' .. vim.fn.stdpath('config'),
                    },
                },
            },
            -- config
        })
    end,
}
