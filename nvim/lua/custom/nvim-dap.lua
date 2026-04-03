local dap = require('dap')
local dapui = require('dapui')
require('nvim-dap-virtual-text').setup()
dapui.setup({})
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

dap.adapters.gdb = {
    type = 'executable',
    command = '/usr/bin/gdb',
    name = 'gdb',
}
dap.adapters.lldb = {
    type = 'executable',
    command = 'lldb-dap',
    name = 'lldb',
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        args = function()
            return vim.fn.input('Arguments: ', '', 'file')
        end,
        runInTerminal = false,
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

larp.fn.map('n', '<leader>cdb', dap.toggle_breakpoint, { desc = 'Toggle breakpoint', desc_prefix = 'DAP' })
larp.fn.map('n', '<leader>cdr', dap.run, { desc = 'Run', desc_prefix = '[DAP] ' })
larp.fn.map('n', '<leader>cdc', dap.continue, { desc = 'Continue', desc_prefix = '[DAP] ' })
larp.fn.map('n', '<F3>', dap.step_over, { desc = 'Step Over', desc_prefix = '[DAP] ' })
larp.fn.map('n', '<F4>', dap.step_into, { desc = 'Step Into', desc_prefix = '[DAP] ' })
