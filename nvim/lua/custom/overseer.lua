local overseer = require('overseer')
overseer.setup({
    templates = {
        'builtin',
        'larp.cpp',
    },
    strategy = 'toggleterm',
})

-- Convert the cwd to a simple file name
local function get_cwd_as_name()
    local dir = vim.fn.getcwd(0)
    return dir:gsub('[^A-Za-z0-9]', '_')
end
-- require('auto-session').setup({
--     auto_restore = false,
--     pre_save_cmds = {
--         function()
--             overseer.save_task_bundle(
--                 get_cwd_as_name(),
--                 -- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
--                 -- pass in the results if you want to save specific tasks.
--                 nil,
--                 { on_conflict = 'overwrite' } -- Overwrite existing bundle, if any
--             )
--         end,
--     },
--     -- Optionally get rid of all previous tasks when restoring a session
--     pre_restore_cmds = {
--         function()
--             for _, task in ipairs(overseer.list_tasks({})) do
--                 task:dispose(true)
--             end
--         end,
--     },
--     post_restore_cmds = {
--         function()
--             overseer.load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
--         end,
--     },
-- })

larp.fn.map('n', '<leader>cot', ':OverseerToggle<CR>', { desc = 'Toggle Overseer', noremap = true, silent = true })
larp.fn.map('n', '<leader>cor', ':OverseerRun<CR>', { desc = 'Overseer Run', noremap = true, silent = true })
larp.fn.map('n', '<leader>coR', ':OverseerRunCmd<CR>', { desc = 'Overseer Run Cmd', noremap = true, silent = true })
larp.fn.map('n', '<leader>cob', ':OverseerBuild<CR>', { desc = 'Overseer Build', noremap = true, silent = true })
larp.fn.map('n', '<leader>coa', ':OverseerTaskAction<CR>', { desc = 'Overseer Task Actions', noremap = true, silent = true })
