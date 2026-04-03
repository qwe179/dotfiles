local telescope = require('telescope')
local actions = require('telescope.actions')

local opts = {
    defaults = {
        path_display = { 'truncate ' }, -- Example configuration
        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
        },
    },
    extensions = {
        undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
                preview_height = 0.8,
            }
        },
    },
}

telescope.setup(opts)
