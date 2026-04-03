local opts = {
    keymap = {
        preset = 'default',
        ['<C-q>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'show', 'hide' },
    },
    completion = {
        menu = {
            auto_show = true,
            border = 'rounded',
            draw = {
                columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
                components = {
                    kind_icon = {
                        ellipsis = false,
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        -- Optionally, you may also use the highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                    item_idx = {
                        text = function(ctx)
                            return tostring(ctx.idx)
                        end,
                        highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
                    },
                },
                treesitter = {
                    'lsp',
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            window = { border = 'rounded' },
        },
    },
    sources = {
        -- rm ripgrep
        default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'codeium' },
        providers = {
            ripgrep = {
                module = 'blink-ripgrep',
                name = 'Ripgrep',
                -- the options below are optional, some default values are shown
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                opts = {
                    -- For many options, see `rg --help` for an exact description of
                    -- the values that ripgrep expects.

                    -- the minimum length of the current word to start searching
                    -- (if the word is shorter than this, the search will not start)
                    prefix_min_len = 3,

                    -- The number of lines to show around each match in the preview window
                    context_size = 5,

                    -- The maximum file size that ripgrep should include in its search.
                    -- Useful when your project contains large files that might cause
                    -- performance issues.
                    -- Examples: "1024" (bytes by default), "200K", "1M", "1G"
                    max_filesize = '1M',
                },
            },
            codeium = {
                name = 'Codeium',
                enabled = function()
                    local path = vim.api.nvim_buf_get_name(0)

                    if string.find(path, "oil://", 1, true) == 1 then
                        return false
                    end

                    return true
                end,
                module = 'codeium.blink',
                async = true,
            },
            emoji = {
                module = 'blink-emoji',
                name = 'Emoji',
                score_offset = -1, -- Tune by preference
                opts = { insert = true }, -- Insert emoji (default) or complete its name
            },
        },
    },
    -- snippets = {
    --     preset = 'luasnip',
    -- },
    signature = {
        enabled = true,
        window = { border = 'rounded' },
    },
    cmdline = {
        enabled = true,
        completion = {
            menu = {
                auto_show = function()
                    return vim.fn.getcmdtype() == ':'
                end,
            },
        },
    },
}

require('blink.cmp').setup(opts)
