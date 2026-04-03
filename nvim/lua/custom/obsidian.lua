local obsidian = require('obsidian')

local workspace_candidates = {
    {
        name = 'default',
        path = '~/obsidian-vault',
    },
    {
        name = 'fallback',
        path = '~/.dotfiles/obsidian-vault',
    },
}

local opts = {
    workspaces = {},
    templates = {
        folder = 'Templates',
    },
    daily_notes = {
        folder = 'journal',
    },
    completion = {
        nvim_cmp = true,
        min_char = 2,
    },
    follow_url_func = function(url)
        vim.fn.jobstart('xdg-open ' .. url)
    end,

    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
            action = function()
                return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
            action = function()
                return require('obsidian').util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
            action = function()
                return require('obsidian').util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },
    -- picker = {
    --     name = 'fzf-lua',
    --     mappings = {
    --         new = '<C-x>',
    --         insert_link = '<C-l>',
    --     },
    -- },

    ui = {
        enable = true,
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        checkboxes = {
            [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
            ['x'] = { char = '', hl_group = 'ObsidianDone' },
            ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
            ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
            ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        },
    },
}

for _, candidate in ipairs(workspace_candidates) do
    if vim.fn.isdirectory(vim.fn.expand(candidate.path)) == 1 then
        opts.workspaces[#opts.workspaces + 1] = candidate
    end
end

obsidian.setup(opts)

vim.o.conceallevel = 2

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'markdown', 'markdown_inline' },
    highlight = {
        enable = true,
    },
})

larp.fn.map('n', '<leader>Ofw', function()
    vim.ui.select(larp.fn.tbl_get_by_key(opts.workspaces, 'name'), {
        prompt = 'Choose your obsidian vault',
    }, function(_, idx)
        vim.cmd('edit ' .. opts.workspaces[idx]['path'])
    end)
end, { desc = 'Search Obsidian Workspace' })
larp.fn.map('n', '<leader>Op', function()
    -- pull from git
    local output = vim.fn.system('cd ' .. opts.workspaces[1].path .. '&& git pull')
    vim.print(output)
end, { desc = 'Obsidian Pull' })
larp.fn.map('n', '<leader>Os', function()
    -- current date and time
    local now = os.date('%Y-%m-%d %H:%M:%S')

    -- commit and push to git
    local output = vim.fn.system('cd ' .. opts.workspaces[1].path .. '&& git pull && git add . && git commit -m "Update ' .. now .. '" && git push')
    vim.print(output)
end, { desc = 'Commit and Push Obsidian Vault' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    desc = 'Enter Obsidian Vault',
    pattern = '~/notes/obsidian/*',
    callback = function()
        vim.o.conceallevel = 2
    end,
})
