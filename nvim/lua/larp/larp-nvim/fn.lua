local M = {}

---My special Module :)
M = M or {}

---Returns a table of randomly chosen elements from a given table
---@generic T
---@param tbl T[] Table to choose elements from
---@param num? integer Number of elements to choose
---@return T[]
function M.tbl_choose_random(tbl, num)
    tbl = tbl or {}
    num = num or 1

    if vim.tbl_isempty(tbl) then
        return {}
    end
    if num < 1 then
        num = 1
    end

    math.randomseed(os.time())
    local chosen_elems = {}
    for _ = 1, num, 1 do
        local keys = vim.tbl_keys(tbl)
        local key_idx = math.random(#keys)
        local key = keys[key_idx]
        table.insert(chosen_elems, tbl[key])
        table.remove(keys, key_idx)
    end
    return chosen_elems
end

---@class merge_dict.opts
---@field overlay? merge_dict.opts.overlay
---@field format? fun(key: any, value: any): any function to format values in `overlay` table.
---
---@class merge_dict.opts.overlay
---@field enable? boolean Whether to overlay.
---@field exclude? table Array of specific keys to prevent corresponding values from getting overlaid.
---
---Merge two tables, one overlaying the other.
---@param base table Base table to be overlaid.
---@param top table Overlay table to be overlaid with onto {base}.
---@param opts? merge_dict.opts Options
---@return table
function M.merge_dict(base, top, opts)
    opts = opts or {}
    setmetatable(opts, {
        ---@type merge_dict.opts
        __index = {
            overlay = {
                enable = true,
                exclude = {},
            },
            format = function(_, v)
                return v
            end,
        },
    })

    for k, v in pairs(top) do
        if (opts.overlay == false and opts[k] ~= nil) or opts.overlay == true then
            base[k] = opts.format(v)
        end
    end
    return base
end

---@class map.Params
---@field mode string Mode in which the keymap is applied.
---@field lhs string Key sequence to be mapped.
---@field rhs string|function Key sequence or function to be simulated.
---@field opts? map.Opts

---@class map.Opts : vim.keymap.set.Opts
---@field desc_prefix? string String prefix to add to description.

---Set keymaps. Same with [vim.keymap.set()](lua://vim.api.nvim_set_keymap), but with some tweaks.
---@param mode string|table Mode in which the keymap is applied.
---@param lhs string Key sequence to be mapped.
---@param rhs string|function Key sequence or function to be simulated.
---@param opts? map.Opts Options to change behavior of the keymap function.
---@see multimap
---@return nil
function M.map(mode, lhs, rhs, opts)
    opts = opts or {}
    setmetatable(opts, {
        __index = {
            silent = true,
            remap = false,
            desc_prefix = '[larp] ',
        },
    })

    opts.desc = opts.desc ~= nil and opts.desc_prefix .. opts.desc or opts.desc
    opts.desc_prefix = nil
    vim.keymap.set(mode, lhs, rhs, opts)
end

---Set Keymaps at once using [map](lua://map) function.
---@param keymaps map.Params[] List of keymaps.
---@see map
---@return nil
function M.multimap(keymaps)
    for _, keymap in ipairs(keymaps) do
        M.map(table.unpack(keymap))
    end
end

---Returns {true_val} if {cond} is true, otherwise {false_val}.
---@generic T
---@param cond boolean|fun(...):boolean
---@param true_val T
---@param false_val T
---@return T
function M.if_get_or(cond, true_val, false_val)
    if type(cond) == 'function' then
        cond = cond()
    end
    if cond then
        return true_val
    else
        return false_val
    end
end

---Append a table to anthoter
---@generic T
---@param t1 table<T>
---@param t2 table<T>
---@return table<T>
function M.tbl_append(t1, t2)
    for _, val in ipairs(t2) do
        table.insert(t1, val)
    end
    return t1
end

---Get values of a table by the key.
---Returns a table of values
---@param tbls table[]
---@param key string|integer
---@param formatter? fun(value):any
---@return table
function M.tbl_get_by_key(tbls, key, formatter)
    formatter = formatter or function(v)
        return v
    end
    local values = {}

    for _, tbl in ipairs(tbls) do
        for k, v in pairs(tbl) do
            if k == key then
                table.insert(values, formatter(v))
            end
        end
    end
    return values
end

---Returns selection range
---@return table
function M.get_selection_range()
    local pos1 = vim.list_slice(vim.fn.getpos('v'), 2, 3)
    local pos2 = vim.list_slice(vim.fn.getpos('.'), 2, 3)
    local start_tbl, end_tbl
    if pos1[1] < pos2[1] or (pos1[1] == pos2[1] and pos1[2] <= pos2[2]) then
        start_tbl = pos1
        end_tbl = pos2
    else
        start_tbl = pos2
        end_tbl = pos1
    end
    if vim.fn.mode() == 'V' then
        start_tbl[2] = 1
    end
    local tbl = M.tbl_append(start_tbl, end_tbl)

    return tbl
end

---Get currently selected text.
---@return string[] lines
function M.get_selection_text()
    local srow, scol = unpack(vim.fn.getpos('v'), 2, 3)
    local erow, ecol = unpack(vim.fn.getpos('.'), 2, 3)

    -- visual line mode
    if vim.fn.mode() == 'V' then
        if srow > erow then
            return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
        else
            return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
        end
    end

    -- regular visual mode
    if vim.fn.mode() == 'v' then
        if srow < erow or (srow == erow and scol <= ecol) then
            return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
        else
            return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
        end
    end

    -- visual block mode
    if vim.fn.mode() == '\22' then
        local lines = {}
        if srow > erow then
            srow, erow = erow, srow
        end
        if scol > ecol then
            scol, ecol = ecol, scol
        end
        for i = srow, erow do
            table.insert(lines, vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1])
        end
        return lines
    end
    return { '' }
end

---Function to toggle markers around a selection (supports multi-line)
---@param sym string
function M.toggle_marker(sym)
    -- Get the current mode
    local mode = vim.api.nvim_get_mode().mode

    -- Check if we're in any visual mode
    if not (mode:sub(1, 1) == 'v' or mode:sub(1, 1) == 'V' or mode:sub(1, 1) == '\22') then
        print('toggle_marker: Not in visual mode')
        return
    end

    -- Get the visual selection range
    local start_row, start_col, end_row, end_col = unpack(M.get_selection_range())

    -- Check if the entire selection is wrapped with the marker
    local first_char = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1 + #sym, {})[1]
    local last_char = vim.api.nvim_buf_get_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, {})[1]

    local need_remove = first_char == last_char and first_char == sym

    if need_remove then
        -- Remove markers
        -- Remove the starting marker
        vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col + #sym - 1, { '' })

        -- Adjust end positions since we've modified the buffer
        if start_row == end_row then
            end_col = end_col - #sym
        else
            -- Multi-line: only adjust end_col for the last line
            end_col = end_col
        end

        -- Remove the ending marker
        vim.api.nvim_buf_set_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, { '' })
        end_col = end_col - #sym
    else
        -- Add markers
        -- Add the starting marker
        vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1, { sym })

        -- Adjust end positions since we've modified the buffer
        if start_row == end_row then
            end_col = end_col + #sym
        else
            -- Multi-line: only adjust end_col for the last line
            end_col = end_col
        end

        -- Add the ending marker
        vim.api.nvim_buf_set_text(0, end_row - 1, end_col, end_row - 1, end_col, { sym })
        end_col = end_col + 1
    end

    -- Reselect the modified text
    local compensate = need_remove and 0 or (#sym - 1)
    vim.api.nvim_win_set_cursor(0, { start_row, start_col - 1 })
    vim.cmd('normal! ')
    vim.cmd('normal! ' .. mode)
    vim.api.nvim_win_set_cursor(0, { end_row, end_col - 1 + compensate })
end

---Returns a sequence of numbers
---* `fun(end_num)`: Returns a sequence of numbers from 1 to {end_num}
---* `fun(start_num, end_num)`: Returns a sequence of numbers from {start_num} and {end_num}
---* `fun(start_num, end_num, increment)`: Returns a sequence of numbers from {start_num} and {end_num} with an increment of {increment}
---@overload fun(end_num: number): number[]
---@overload fun(start_num: number, end_num: number): number[] Returns a sequence of numbers from {start_num} and {end_num}
---@overload fun(start_num: number, end_num: number, increment: number): number[] Returns a sequence of numbers from {start_num} and {end_num} with an increment of {increment}
function M.create_sequence(...)
    local args = { ... }
    local arg_cnt = select('#', ...)

    ---Returns a number sequence between {start} and {end} with an increment of {increment}
    ---@param start_num number
    ---@param end_num number
    ---@param increment? number
    ---@return number[]
    local function sequence_(start_num, end_num, increment)
        start_num = start_num or 1
        end_num = end_num or 1
        increment = increment or 1
        if start_num > end_num then
            local msg = string.format("`start_num`(%d) can't be greater than `end_num`(%d)", start_num, end_num)
            error(msg, 3)
        end
        local seq = {}
        for i = start_num, end_num, increment do
            table.insert(seq, i)
        end
        return seq
    end

    if arg_cnt == 1 then
        return sequence_(1, args[1])
    elseif arg_cnt == 2 then
        return sequence_(args[1], args[2])
    elseif arg_cnt == 3 then
        return sequence_(args[1], args[2], args[3])
    else
        error('Invalid number of arguments to create_sequence', 3)
    end
end

---Checks if {val} is in {tbl}
---@generic T
---@param val T
---@param tbl table<T>
---@param from_keys? boolean Whether to compare with keys over values. The default value is `false`
---@return boolean
function M.is_in(val, tbl, from_keys)
    val = val or nil
    tbl = tbl or {}
    from_keys = from_keys or false

    if vim.tbl_isempty(tbl) or val == nil then
        return false
    end

    local targets = M.if_get_or(from_keys, vim.tbl_keys(tbl), vim.values(tbl))
    for target in targets do
        if val == target then
            return true
        end
    end
    return false
end

--- Calculates the number of UTF-8 characters in a string.
---@param str string
---@return integer
function M.utf8_len(str)
    local _, count = string.gsub(str, '[^\128-\193]', '')
    return count
end

--- Extracts a substring based on UTF-8 character indices.
---@param str string
---@param start_char integer
---@param end_char integer
---@return string
function M.utf8_sub(str, start_char, end_char)
    start_char = start_char or 1
    end_char = end_char or M.utf8_len(str)

    if start_char < 1 then
        start_char = 1
    end
    if end_char > M.utf8_len(str) then
        end_char = M.utf8_len(str)
    end
    if start_char > end_char then
        return ''
    end

    local byte_pos = 1
    local current_char = 1
    local start_byte, end_byte = nil, nil

    while byte_pos <= #str do
        if current_char == start_char then
            start_byte = byte_pos
        end
        if current_char == end_char then
            -- Determine the byte length of the current character
            local c = string.byte(str, byte_pos)
            local char_len
            if c >= 240 then
                char_len = 4
            elseif c >= 224 then
                char_len = 3
            elseif c >= 192 then
                char_len = 2
            else
                char_len = 1
            end
            end_byte = byte_pos + char_len - 1
            break
        end

        local c = string.byte(str, byte_pos)
        if c >= 240 then
            byte_pos = byte_pos + 4
        elseif c >= 224 then
            byte_pos = byte_pos + 3
        elseif c >= 192 then
            byte_pos = byte_pos + 2
        else
            byte_pos = byte_pos + 1
        end
        current_char = current_char + 1
    end

    -- Handle the last character if end_char exceeds the string length
    if end_byte == nil and current_char == end_char then
        end_byte = byte_pos
    end

    if start_byte and end_byte then
        return string.sub(str, start_byte, end_byte)
    elseif start_byte then
        return string.sub(str, start_byte)
    else
        return ''
    end
end

--- Limits the size of ASCII art by trimming the number of lines and the width of each line.
--- Preserves the central part of each line to maintain visual integrity.
---@param art_lines string[]
---@param max_width integer
---@param max_height integer
---@return string[]
function M.limit_text_art_size(art_lines, max_width, max_height)
    -- Validate input parameters
    assert(type(art_lines) == 'table', 'art_lines must be a table of strings')
    assert(type(max_width) == 'number' and max_width > 0, 'max_width must be a positive number')
    assert(type(max_height) == 'number' and max_height > 0, 'max_height must be a positive number')

    -- Create a shallow copy of art_lines to avoid mutating the original table
    -- local new_lines = {}
    -- for _, line in ipairs(art_lines) do
    --     table.insert(new_lines, line)
    -- end
    local new_lines = vim.fn.copy(art_lines)

    local current_height = #new_lines

    -- Trim height if necessary
    if current_height > max_height then
        local excess_rows = current_height - max_height
        local half_excess = math.floor(excess_rows / 2)
        local start_trim = half_excess
        local end_trim = excess_rows - half_excess

        local start_idx = start_trim + 1
        local end_idx = current_height - end_trim

        new_lines = vim.list_slice(new_lines, start_idx, end_idx)
    end

    -- Trim width for each line if necessary
    for i, line in ipairs(new_lines) do
        -- Calculate the number of UTF-8 characters
        local line_length = M.utf8_len(line)
        if line_length > max_width then
            local excess_cols = line_length - max_width
            local half_excess = math.floor(excess_cols / 2)
            local start_col = half_excess + 1
            local end_col = start_col + max_width - 1

            new_lines[i] = M.utf8_sub(line, start_col, end_col)
        end
    end

    return new_lines
end

return M
