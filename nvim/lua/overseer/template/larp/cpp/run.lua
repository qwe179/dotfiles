return {
    name = 'C++ Run',
    desc = 'Run C++',
    builder = function(params)
        return {
            cmd = params.program,
        }
    end,
    params = function()
        local current_path = vim.fn.expand('%:p:h')
        return {
            program = {
                name = 'Program',
                desc = 'Program to run',
                type = 'string',
                default = current_path .. '/main',
            },
        }
    end,
}
