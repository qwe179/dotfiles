local opts = {
    render = 'compact',
    stages = 'slide',
    timeout = 5000,
    background_colour = '#000000',
    icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
    },
}

local notify = require('notify')
notify.setup(opts)

larp.fn.map('n', '<leader>fn', '<cmd>Telescope notify<cr>', { desc = 'Find Notify History' })
