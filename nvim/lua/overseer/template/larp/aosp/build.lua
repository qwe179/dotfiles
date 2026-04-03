return {
    name = 'Build AOSP',
    desc = 'Build AOSP',
    builder = function(params)
        cmd = 'source build/envsetup.sh && lunch ' .. params.lunch .. ' && make -j' .. params.jobs .. ' ' .. params.targets
    end,
    params = {
        lunch = {
            name = 'Lunch',
            desc = 'Lunch',
            type = 'string',
            default = 'aosp_rpi5-ap1a-userdebug',
        },
        jobs = {
            name = 'Jobs',
            desc = 'Jobs',
            type = 'number',
            default = 4,
        },
        targets = {
            name = 'Target',
            desc = 'Target',
            type = 'list',
            subtype = {
                type = 'string',
            },
            delimeter = ' ',
            default = 'bootimage',
        },
    },
}
