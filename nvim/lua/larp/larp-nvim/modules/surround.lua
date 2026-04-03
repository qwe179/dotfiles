local M = {}

function M.custom_surround_operator()
    -- Prompt for prefix
    vim.ui.input({ prompt = 'Enter prefix: ' }, function(prefix)
        if prefix == nil then
            print('No prefix provided.')
            return
        end

        -- Prompt for suffix
        vim.ui.input({ prompt = 'Enter suffix: ' }, function(suffix)
            if suffix == nil then
                print('No suffix provided.')
                return
            end

            -- Get the visual selection range
            local start_pos = vim.fn.getpos("'<")
            local end_pos = vim.fn.getpos("'>")

            local line_start, col_start = start_pos[2], start_pos[3]
            local line_end, col_end = end_pos[2], end_pos[3]

            -- Fetch the lines in the selection
            local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

            if #lines == 0 then
                print('No text selected.')
                return
            end

            -- Apply the surrounding characters
            lines[1] = prefix .. lines[1]
            lines[#lines] = lines[#lines] .. suffix

            -- Replace the selected text with the surrounded text
            vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, lines)

            print('Surrounded text with: ' .. prefix .. ' and ' .. suffix)
        end)
    end)
end

-- Function to set the operator
function M.set_custom_surround_operator()
    vim.o.operatorfunc = "v:lua.require'custom_surround'.custom_surround_operator"
    return 'g@'
end

---@class surround.opts
---@field use_default_mappings? boolean

--- Setup the custom surround operator
---@param opts? surround.opts
function M.setup(opts)
    opts = opts or {}
    setmetatable(opts, { __index = { use_default_mappings = true } })
    if opts.use_default_mappings then
        -- Map the operator to a key combination
        -- For example, <leader>s
        vim.api.nvim_set_keymap(
            'n',
            '<leader>s',
            "v:lua.require'custom_surround'.set_custom_surround_operator()",
            { noremap = true, silent = true, expr = true }
        )
    end
end

return M
