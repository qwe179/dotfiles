vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_attach', {}),
    desc = 'Attach LSP',
    pattern = '*',
    callback = function()
        larp.fn.map('', 'gh', function()
            vim.diagnostic.open_float({
                source = true,
                format = function(diagnostic)
                    return string.format('%s [%s]', diagnostic.message, diagnostic.source)
                end,
                border = 'rounded',
                severity_sort = true,
                focus_id = 'diagnostic',
            })
        end, { desc = 'Get diagnostics' })

        -- larp.fn.map('', '<leader>cr', function()
        --     vim.lsp.buf.rename()
        -- end)
        larp.fn.map('', 'gd', function()
            vim.lsp.buf.definition()
        end, { desc = 'Go to Definition'})
        larp.fn.map('', 'gD', function()
            vim.lsp.buf.type_definition()
        end, { desc = 'Go to Type Definition'})

        larp.fn.map('', '<leader>ca', function()
            vim.lsp.buf.code_action()
        end)
        larp.fn.map('', '<leader>cf', function()
            vim.lsp.buf.format({ async = true })
        end)

        -- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('keymap_read', {}),
    desc = 'Recognize *.keymap files as C files',
    pattern = '*.keymap',
    callback = function()
        vim.cmd([[set filetype=c]])
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('MarkdownRead', {}),
    desc = 'Add useful keymaps for markdown files',
    pattern = { '*.markdown', '*.md', '*.txt' },
    callback = function()
        local marks = {
            { symbol = '**', key = 'b', name = 'Bold' },
            { symbol = '_', key = 'i', name = 'Italics' },
            { symbol = '~~', key = 't', name = 'Strikethrough' },
            { symbol = '`', key = 'c', name = 'Inline Code' },
            { symbol = '$', key = 'm', name = 'Math' },
        }

        for _, m in ipairs(marks) do
            larp.fn.map('x', '<C-' .. m.key .. '>', function()
                larp.fn.toggle_marker(m.symbol)
            end, { desc = 'Toggle ' .. m.name })
        end

        ------------------

        -- Enable spell check for English
        --
        vim.o.spell = true
        vim.o.spelllang = 'en_us'
        vim.notify('Spell check enabled for English')
    end,
})
