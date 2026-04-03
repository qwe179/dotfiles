local copilot = require('copilot')

local options = {
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = "<C-A>",
        },
    },
}

copilot.setup(options)

