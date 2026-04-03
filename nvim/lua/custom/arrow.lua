local arrow = require('arrow')

local opts = {
    show_icons = true,
    leader_key = 'M', -- Recommended to be a single key
    buffer_leader_key = 'm', -- Per Buffer Mappings
}

arrow.setup(opts)

-- vim.keymap.set("n", "H", require("arrow.persist").previous)
-- vim.keymap.set("n", "L", require("arrow.persist").next)
vim.keymap.set("n", "<C-s>", require("arrow.persist").toggle)
