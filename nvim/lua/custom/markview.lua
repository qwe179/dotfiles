local mkv = require('markview')
local presets = require('markview.presets')

local opts = {
    preview = {
        icon_provider = 'mini',
    },
    markdown = {
        enable = true,
        headings = presets.headings.arrowed,
        horizontal_rules = presets.horizontal_rules.arrowed,
        tables = presets.tables.rounded,
    },
    block = {
        enable = true,
    },
    inline = {
        enable = true,
    },
    html = {
        enable = true,
    },
    latex = {
        enable = true,
    },
    yaml = {
        enable = true,
    },
}

mkv.setup(opts)
