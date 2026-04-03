vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- # Windows
larp.fn.map('', '<leader>wd', '<C-w>c', { desc = 'Close Window', noremap = true, silent = true })
larp.fn.map('', '<leader>wo', '<C-w>o', { desc = 'Maximize Window', noremap = true, silent = true })

-- Navigate Windows
larp.fn.map('', '<leader>wh', '<C-w>h', { desc = 'Move to Left Window', noremap = true, silent = true })
larp.fn.map('', '<leader>wj', '<C-w>j', { desc = 'Move to Bottom Window', noremap = true, silent = true })
larp.fn.map('', '<leader>wl', '<C-w>l', { desc = 'Move to Right Window', noremap = true, silent = true })
larp.fn.map('', '<leader>wk', '<C-w>k', { desc = 'Move to Top Window', noremap = true, silent = true })

-- Move Windows
larp.fn.map('', '<leader>wH', '<C-w>H', { desc = 'Send Window to Left', noremap = true, silent = true })
larp.fn.map('', '<leader>wJ', '<C-w>J', { desc = 'Send Window to Bottom', noremap = true, silent = true })
larp.fn.map('', '<leader>wL', '<C-w>L', { desc = 'Send Window to Right', noremap = true, silent = true })
larp.fn.map('', '<leader>wK', '<C-w>K', { desc = 'Send Window to Top', noremap = true, silent = true })

-- Split Windows
larp.fn.map('', '<leader>sh', '<C-w>v', { desc = 'Split Window to the Left', noremap = true, silent = true })
larp.fn.map('', '<leader>sj', '<C-w>s<C-w>j', { desc = 'Split Window to the Bottom', noremap = true, silent = true })
larp.fn.map('', '<leader>sk', '<C-w>s', { desc = 'Split Window to the Top', noremap = true, silent = true })
larp.fn.map('', '<leader>sl', '<C-w>v<C-w>l', { desc = 'Split Window to the Right', noremap = true, silent = true })
larp.fn.map('', '<leader>wx', '<C-w>x', { desc = 'Swap Window to Next', noremap = true, silent = true })

-- Resize Windows
larp.fn.map('', '<leader>w+', '<C-w>+', { desc = 'Increase Window Height', noremap = true, silent = true })
larp.fn.map('', '<leader>w-', '<C-w>-', { desc = 'Decrease Window Height', noremap = true, silent = true })
larp.fn.map('', '<leader>w>', '<C-w>>', { desc = 'Increase Window Width', noremap = true, silent = true })
larp.fn.map('', '<leader>w<', '<C-w><', { desc = 'Decrease Window Width', noremap = true, silent = true })
larp.fn.map('', '<leader>w=', '<C-w>=', { desc = 'Equal Window Size', noremap = true, silent = true })

-- # Buffers
-- Close Buffer
larp.fn.map('n', '<leader>bd', ':bd<CR>', { desc = 'Close Buffer', noremap = true, silent = true })

-- # Tabs
larp.fn.map('n', '<leader>Tc', ':tabnew<CR>', { desc = 'New Tab', noremap = true, silent = true })
larp.fn.map('n', '<leader>Td', ':tabclose<CR>', { desc = 'Close Tab', noremap = true, silent = true })
larp.fn.map('n', '<leader>Tn', ':tabnext<CR>', { desc = 'Go to Next Tab', noremap = true, silent = true })
larp.fn.map('n', '<leader>Tp', ':tabprevious<CR>', { desc = 'Go to Previous Tab', noremap = true, silent = true })

-- General
larp.fn.map('n', '<leader>qq', ':confirm qa<cr>', { desc = 'Exit NeoVim', noremap = true, silent = true })
larp.fn.map('n', '<leader>QQ', ':qa!<cr>', { desc = 'Exit NeoVim without saving', noremap = true, silent = true })
larp.fn.map('n', '<leader>oc', ':e ' .. vim.fn.stdpath('config') .. '<CR>', { desc = 'Open Neovim Config', silent = true })
larp.fn.map('n', '<leader>ww', ':w<cr>', { desc = 'Write to Buffer', noremap = true, silent = true })
larp.fn.map('n', '<leader>wa', ':wa<cr>', { desc = 'Write All', noremap = true, silent = true })
larp.fn.map('n', '<leader>wq', ':wq<cr>', { desc = 'Write and Quit', noremap = true, silent = true })
larp.fn.map('n', '<leader>wQ', ':wqa<cr>', { desc = 'Write All and Quit', noremap = true, silent = true })
larp.fn.map('n', '<leader>so', function()
    vim.print('Sourced ' .. vim.fn.expand('%:p'))
    vim.cmd('source ' .. vim.fn.expand('%:p'))
end, { desc = 'Source Current Buffer', silent = true })
larp.fn.map('n', '<C-p>', ':bprevious<cr>', { desc = 'Navigate to Previous Buffer', noremap = true, silent = true })
larp.fn.map('n', '<C-n>', ':bnext<cr>', { desc = 'Navigate to Next Buffer', noremap = true, silent = true })
larp.fn.map('', '<leader>bo', function()
    local current_buffer = vim.fn.bufnr('%')
    local path = vim.fn.expand('%:p:h')
    -- if the buffer name starts with oil://
    if vim.fn.bufname(current_buffer):match('^oil://') then
        -- remove the oil:// prefix
        path = path:sub(7)
    end
    vim.cmd('cd ' .. path)
    vim.print('Changed directory to ' .. path)
end, { desc = 'Change Directory to Current Buffer', silent = true })
larp.fn.map('n', 'j', function()
    if vim.v.count > 1 then
        vim.cmd('normal! ' .. vim.v.count .. 'j')
    else
        vim.cmd('normal! gj')
    end
end, { desc = 'Navigate One Line Down' })
larp.fn.map('n', 'k', function()
    if vim.v.count > 1 then
        vim.cmd('normal! ' .. vim.v.count .. 'k')
    else
        vim.cmd('normal! gk')
    end
end, { desc = 'Navigate One Line Up' })

-- # Terminal
larp.fn.map('n', '<leader>oth', function()
    vim.cmd('vsplit | wincmd h | term')
end, { desc = 'Open Terminal to the Left', remap = true })
larp.fn.map('n', '<leader>otj', function()
    vim.cmd('split | wincmd j | term')
end, { desc = 'Open Terminal to the Bottom', remap = true })
larp.fn.map('n', '<leader>otk', function()
    vim.cmd('split | term')
end, { desc = 'Open Terminal to the Top', remap = true })
larp.fn.map('n', '<leader>otl', function()
    vim.cmd('vsplit| wincmd l | term')
end, { desc = 'Open Terminal to the Right', remap = true })
larp.fn.map('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- # Edit
larp.fn.map({ 'i', 'x' }, 'zx', '<Esc>')
larp.fn.map('i', '<C-C>', function()
    vim.cmd('stopinsert')
end) -- Use <C-C> to act as <ESC>
larp.fn.map('', '<leader>y', '"+y', { desc = 'Yank to Clipboard' })
larp.fn.map('', '<leader><leader>p', '"+p', { desc = 'Paste from Clipboard' })
larp.fn.map('', '<leader>p', function()
    -- Get current cursor position: {row, col} (col is 0-based)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_col = cursor[2] + 1 -- Convert to 1-based index

    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    local last_col = #line -- Lua's # operator gives the string length

    if current_col == last_col then
        -- Cursor is on the last column; perform a normal paste
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('P', true, false, true), 'n', true)
    else
        -- Cursor is not on the last column; replace character under cursor without affecting registers
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_xP', true, false, true), 'n', true)
    end
end, { desc = 'Paste (Without Cutting)' })
larp.fn.map('', '<leader>cR', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = 'Rename All Occurrences' })
larp.fn.map('v', '<', '<gv')
larp.fn.map('v', '>', '>gv')
-- larp.fn.map('n', '<Tab>', 'za', { desc = 'Toggle Fold' })

-- # Misc.

larp.fn.map('n', '<leader>Co', function()
    local xdg_config_home = os.getenv('XDG_CONFIG_HOME')
    if xdg_config_home == nil then
        xdg_config_home = vim.fn.expand('$HOME') .. '/.config'
    end
    vim.cmd('e ' .. xdg_config_home)
end, { desc = 'Change Directory to XDG_CONFIG_HOME' })
