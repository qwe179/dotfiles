local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = {}, -- Delete buffers without disrupting window layout.
    indent = { enabled = true },
    input = {}, -- Better `vim.ui.input`.
    dashboard = {
        enabled = true,
        preset = {
            header = [[
██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║
██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║
██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
    },
    notifier = { enabled = true },
    toggle = {},
    quickfile = { enabled = true },
    git = {}, -- Git utilities.
    gitbrowse = {}, -- Open the repo of the active file in the browser.
    statuscolumn = { enabled = true },
    scope = {}, -- Scope detection based on treesitter or indent.
    words = { enabled = true },
    picker = { enabled = true },
    lazygit = {},
}

local snacks = require('snacks')
local notifier = snacks.notifier
snacks.setup(opts)

larp.fn.map('n', '<leader>H', function() Snacks.dashboard.open() end, { desc = 'Home Dashboard' })
larp.fn.map('n', '<leader>Nff', notifier.show_history, { desc = 'Show History', desc_prefix = 'Notifier' })
larp.fn.map('n', '<leader>Gro', snacks.gitbrowse.open, { desc = 'Open in Browser', desc_prefix = 'Git' })

-- Picker
local picker = require('snacks.picker')

-- Find
larp.fn.map('n', '<leader>pp', function()
    picker.pick()
end, { desc = 'Snacks Picker' })
larp.fn.map('n', '<leader>ff', function()
    picker.files()
end, { desc = 'Find Files' })
larp.fn.map('n', '<leader>fc', function()
    picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find Config Files' })
larp.fn.map('n', '<leader>fh', function()
    picker.help()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>:', function() end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fn', function()
    picker.notifications()
end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fC', function()
    picker.commands()
end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fa', function()
    picker.autocmds()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>fk', function()
    picker.keymaps()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>fF', function()
    picker.smart()
end, { desc = 'Find Files (Smart)' })
larp.fn.map('n', '<leader>fl', function()
    picker.lazy()
end, { desc = 'Find Lazy Specs' })

larp.fn.map('n', '<leader>fr', function()
    picker.recent()
end, { desc = 'Find Lazy Specs' })

larp.fn.map('n', '<leader>fs', function()
    picker.lsp_symbols()
end, { desc = 'Find Symbols' })

larp.fn.map('n', '<leader>fS', function()
    picker.lsp_workspace_symbols()
end, { desc = 'Find Workspace Symbols' })

larp.fn.map('n', '<leader>fm', function()
    picker.man()
end, { desc = 'Find Man Pages' })

larp.fn.map('n', '<leader>ft', function()
    picker.colorschemes()
end, { desc = 'Find Colorschemes' })

larp.fn.map('n', '<leader>f.', function()
    picker.resume()
end, { desc = 'Find Resume' })

larp.fn.map('n', '<leader>fd', function()
    picker.diagnostics()
end, { desc = 'Find Diagnostics' })

larp.fn.map('n', '<leader>fb', function()
    picker.buffers()
end, { desc = 'Find Buffers' })

larp.fn.map('n', '<leader>fg', function()
    picker.git_files()
end, { desc = 'Find Git Files' })

larp.fn.map('n', '<leader>gb', function()
    picker.git_branches()
end, { desc = 'Find Git Branches' })

larp.fn.map('n', '<leader>gl', function()
    picker.git_log()
end, { desc = 'Find Git Logs' })

larp.fn.map('n', '<leader>gL', function()
    picker.git_log_line()
end, { desc = 'Find Git Log Line' })

larp.fn.map('n', '<leader>gs', function()
    picker.git_status()
end, { desc = 'Find Git Log Line' })

larp.fn.map('n', '<leader>gd', function()
    picker.git_diff()
end, { desc = 'Find Git Diff' })

larp.fn.map('n', '<leader>gg', function()
    picker.pick('grep')
end, { desc = 'Grep' })

larp.fn.map({ 'n', 'x' }, '<leader>gw', function()
    picker.grep_word({
        -- live = true,
        args = { '--hidden', '--follow', '--glob', '!*/.git/*', '--no-ignore' },
    })
end, { desc = 'Grep Word' })

larp.fn.map({ 'n', 'x' }, '<leader>fw', function()
    picker.files({
        search = vim.fn.expand('<cWORD>'),
        live = true,
    })
end, { desc = 'Grep Word' })

larp.fn.map('n', '<leader>gc', function()
    picker.grep({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Grep Config' })

-- Lazygit
larp.fn.map('n', '<leader>Gl', function()
    snacks.lazygit()
end, { desc = 'Lazygit' })

-- Notifier

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ('[%3d%%] %s%s'):format(
                        value.kind == 'end' and 100 or value.percentage or 100,
                        value.title or '',
                        value.message and (' **%s**'):format(value.message) or ''
                    ),
                    done = value.kind == 'end',
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

local notifier = snacks.notifier
larp.fn.map('n', '<leader>nh', function()
    notifier.show_history()
end, { desc = 'Notification History' })

larp.fn.map('n', '<leader>nd', function()
    notifier.hide()
end, { desc = 'Notification Dismiss' })

-- Bufdelete
larp.fn.map('n', '<leader>bd', function()
    snacks.bufdelete.other()
end, { desc = 'Notification Dismiss' })

-- toggle
snacks.toggle.line_number():map('<leader>tl')
snacks.toggle.diagnostics():map('<leader>td')
snacks.toggle.inlay_hints():map('<leader>tci')
snacks.toggle.indent():map('<leader>ti')
snacks.toggle.treesitter():map('<leader>tt')
