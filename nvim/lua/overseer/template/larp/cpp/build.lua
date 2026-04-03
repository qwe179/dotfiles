return {
    name = 'C++ Build',
    builder = function(params)
        return {
            cmd = { 'g++' },
            args = { unpack(params.args), '-o', params.output, unpack(params.input) },
            name = 'g++',
        }
    end,
    desc = 'Build C++',
    params = {
        output = {
            name = 'Output File',
            desc = 'The output file',
            default = 'main',
        },
        input = {
            type = 'list',
            subtype = {
                type = 'string',
            },
            delimiter = ',',
            name = 'Input File',
            desc = 'The file to compile',
            default = 'main.cpp',
        },
        args = {
            type = 'list',
            subtype = {
                type = 'string',
            },
            delimiter = ',',
            name = 'Arguments',
            desc = 'Arguments to pass to the compiler',
            default = '-Wall,-Wextra,-Wpedantic',
        },
    },
}
