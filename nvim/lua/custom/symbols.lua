local opts = {
    sidebar = {
        hide_cursor = false,
        auto_peek = true,
        show_guide_lines = true,
    },
}
local r = require('symbols.recipes')
require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, opts)
vim.keymap.set('n', ',s', '<cmd> Symbols<CR>')
vim.keymap.set('n', ',S', '<cmd> SymbolsClose<CR>')
vim.keymap.set('n', 'ts', '<cmd> SymbolsToggle<CR>')
