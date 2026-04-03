larp.fn.map('', '<leader>Lta', function()
    local ret = larp.fn.get_selection_text()
    if #ret < 1 then
        return
    end
    local txt = ''
    for i, val in ipairs(ret) do
        if i == #ret then
            txt = txt .. val .. '\n'
            break
        end
        txt = txt .. val .. ', '
    end
    if txt ~= nil then
        print(txt)
    end
end, { desc = 'Print Selection', desc_prefix = '[TEST] ' })

larp.fn.map('', '<leader>Ltb', function()
    local lines = larp.fn.get_selection_text()
    -- wow ama amaa aaaaa
    local buff = table.concat(lines)
    buff = vim.trim(buff)
    local fc = string.sub(buff, 1, 1)
    local ec = string.sub(buff, #buff)
    vim.print({ fc, ec })
end, { desc = 'Print Selection Range', desc_prefix = '[TEST] ' })

larp.fn.map('', '<leader>Ltc', function()
    local range = larp.fn.get_selection_range()
    vim.print(range)
end, { desc = 'Print Selection Range', desc_prefix = '[TEST] ' })

larp.fn.map('', '<leader>Ldc', function()
    vim.print(vim.api.nvim_get_mode().mode)
end, { desc = 'Print Selection Range', desc_prefix = '[TEST] ' })
