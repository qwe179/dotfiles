return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        event = 'BufRead',
        config = function()
            require('nvim-treesitter.configs').setup({
                textobjects = {
                    select = {
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['am'] = '@function.outer',
                            ['im'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                            -- You can also use captures from other query groups like `locals.scm`
                            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                            ['aL'] = { query = '@loop.outer', desc = 'Select outer part of a loop region' },
                            ['iL'] = { query = '@loop.inner', desc = 'Select inner part of a loop region' },
                        },

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        enable = true,
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = { query = '@class.outer', desc = 'Next class start' },
                            --
                            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
                            [']l'] = '@loop.*',
                            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                            --
                            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                        -- Below will go to either the start or the end, whichever is closer.
                        -- Use if you want more granular movements
                        -- Make it even more gradual by adding multiple queries and regex.
                        goto_next = {
                            [']f'] = '@conditional.outer',
                        },
                        goto_previous = {
                            ['[f'] = '@conditional.outer',
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = 'rounded',
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ['<leader>df'] = '@function.outer',
                            ['<leader>dF'] = '@class.outer',
                        },
                    },
                },
                sync_install = false,
                auto_install = true,
                ensure_installed = { 'markdown', 'markdown_inline', 'html', 'c', 'cpp', 'lua', 'luadoc' },
                highlight = {
                    enable = true,
                },
            })

            -- local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
            --
            -- -- Repeat movement with ; and ,
            -- -- ensure ; goes forward and , goes backward regardless of the last direction
            -- vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
            -- vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

            -- vim way: ; goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
            -- vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
            -- vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

            -- local gs = require('gitsigns')
            -- -- make sure forward function comes first
            -- local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
            -- -- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.
            --
            -- vim.keymap.set({ 'n', 'x', 'o' }, ']h', next_hunk_repeat)
            -- vim.keymap.set({ 'n', 'x', 'o' }, '[h', prev_hunk_repeat)
        end,
    },
    -- {
    --     'nvim-treesitter/nvim-treesitter-context',
    --     config = function()
    --         require('treesitter-context').setup({
    --             enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --             max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --             min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --             line_numbers = true,
    --             multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --             trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --             mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    --             -- Separator between context and content. Should be a single character string, like '-'.
    --             -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --             separator = nil,
    --             zindex = 20, -- The Z-index of the context window
    --             on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    --         })
    --         larp.fn.map('n', '[c', function()
    --             require('treesitter-context').go_to_context(vim.v.count1)
    --         end, { silent = true })
    --     end,
    -- },
}
