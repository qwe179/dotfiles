local smear = require('smear_cursor')

local opts = {
    cursor_color = '#efd4fc',
    stiffness = 0.8,
    trailing_stiffness = 0.2,
    trailing_exponent = 0.8,
    hide_target_hack = true,
    gamma = 0.8,
}


smear.setup(opts)
