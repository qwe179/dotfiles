local org_path = '~/notes/orgs'
require('orgmode').setup({
    org_agenda_files = org_path .. '/**/*',
    org_default_notes_file = org_path .. 'refile.org',
    org_fold_enable = false,
    org_startup_folded = 'showeverything',
})
larp.fn.map('n', '<leader>oo', ':e ' .. org_path .. '<cr>', { desc = 'Open Orgmode' })
larp.fn.map('n', '<leader>of', ':FzfLua files cwd=' .. org_path .. '<cr>', { desc = 'Find Org Files' })
larp.fn.map('n', '<leader>oj', function()
    local today = os.date('*t')
    local journal = org_path .. '/journal/' .. today.year .. '/' .. today.month .. '/' .. today.day .. '.org'
    if vim.fn.filereadable(vim.fn.expand(journal)) == 0 then
        vim.cmd('silent !mkdir -p ' .. org_path .. '/journal/' .. today.year .. '/' .. today.month)
        vim.cmd('silent !touch ' .. journal)
    end
    vim.cmd('e ' .. journal)
end, { desc = 'Open Org Journal' })
-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
-- add ~org~ to ignore_install
-- require('nvim-treesitter.configs').setup({
--   ensure_installed = 'all',
--   ignore_install = { 'org' },
-- })
require('org-roam').setup({
    directory = '~/org_roam_files',
    -- optional
    org_files = {
        '~/notes/orgs',
    },
})
