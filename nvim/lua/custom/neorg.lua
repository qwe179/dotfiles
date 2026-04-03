local my_workspaces = {
    default = '~/notes/norgs',
    personal = '~/notes/norgs/personal',
    work = '~/notes/norgs/work',
}
require('neorg').setup({
    -- Tell Neorg what modules to load
    load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.autocommands'] = {},
        ['core.dirman'] = {
            config = {
                workspaces = my_workspaces,
                index = 'index.norg',
            },
        },
        ['core.concealer'] = {},
        ['core.completion'] = {
            config = {
                name = '[Neorg]',
                engine = 'nvim-cmp',
            },
        }, -- Load all the default modules
        ['core.integrations.nvim-cmp'] = {},
        ['core.integrations.treesitter'] = {},
        ['core.integrations.telescope'] = {
            config = {
                insert_file_link = {
                    show_title_preview = true,
                },
            },
        },
        ['core.presenter'] = {
            config = {
                zen_mode = 'zen-mode',
            },
        },
        ['core.export'] = {
            config = {
                path = '~/norgs/exports',
                export_dir = '<export-dir>/<language>-export',
            },
        },
        ['core.export.markdown'] = {},
        ['core.fs'] = {},
        ['core.neorgcmd'] = {},
        ['core.ui'] = {},
        ['core.neorgcmd.commands.return'] = {},
        ['core.tempus'] = {},
        ['core.syntax'] = {},
        ['core.ui.calendar'] = {},
        ['core.summary'] = {
            config = {
                strategy = 'default',
            },
        },
        ['core.highlights'] = {},
        ['core.clipboard'] = {},
        ['core.queries.native'] = {},
        ['core.todo-introspector'] = {},
        ['core.storage'] = {
            config = {
                vim.fn.stdpath('data') .. '/neorg.mpack',
            },
        },
        ['core.text-objects'] = {},
    },
})
larp.fn.map('n', '<leader>no', '<cmd>Neorg<CR>', { noremap = true, silent = true })
larp.fn.map('n', '<leader>nw', function()
    vim.ui.select(vim.tbl_keys(my_workspaces), { prompt = 'Workspace: ' }, function(input)
        vim.cmd('Neorg workspace ' .. input)
    end)
end, { noremap = true, silent = true })

larp.fn.map('n', '<leader>nfh', '<Plug>(neorg.telescope.search_headings)', { desc = 'Find Norg Headings' })
larp.fn.map('n', '<leader>nff', '<Plug>(neorg.telescope.find_norg_files)', { desc = 'Find Norg Files' })
larp.fn.map('n', '<leader>nfb', '<Plug>(neorg.telescope.backlinks.file_backlinks)', { desc = 'Find Backlinks' })
larp.fn.map('n', '<leader>nfB', '<Plug>(neorg.telescope.backlinks.header_backlinks)', { desc = 'Find Header Backlinks' })
larp.fn.map('n', '<localleader>niL', '<Plug>(neorg.telescope.insert_file_link)', { desc = 'Insert File Link' })
larp.fn.map('n', '<localleader>nil', '<Plug>(neorg.telescope.insert_link)', { desc = 'Insert Link' })
larp.fn.map({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>', { noremap = true, silent = true })
larp.fn.map({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object', noremap = true, silent = true })

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'norg',
    callback = function()
        vim.o.conceallevel = 3
        larp.fn.map('n', '<up>', '<Plug>(neorg.text-objects.item-up)', { desc = 'Move item up' })
        larp.fn.map('n', '<down>', '<Plug>(neorg.text-objects.item-down)', { desc = 'Move item down' })
        larp.fn.map({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)', { desc = 'Select heading' })
        larp.fn.map({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)', { desc = 'Select heading' })
        larp.fn.map({ 'n', 'x' }, '<localleader>T', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', { desc = 'Cycle through Task Modes' })
        larp.fn.map({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>')
        larp.fn.map({ 'i', 'x', 'n' }, '<S-CR>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        larp.fn.map({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        larp.fn.map({ 'i', 'x', 'n' }, '<C-S-a>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        larp.fn.map('', '<localleader>Tc', '<cmd>Neorg toggle-concealer<cr>', { desc = 'Toggle Concealer' })
    end,
})
