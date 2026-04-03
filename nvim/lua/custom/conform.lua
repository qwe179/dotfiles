local conform = require('conform')
conform.setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        cmake = { 'cmake_format' },
        nix = { 'nixpkgs_fmt', 'nixfmt' },
        python = { 'ruff', 'autopep8', 'autoflake', 'black' },
        markdown = { 'prettier', 'markdownfmt', 'markdownlint', 'markdownlint-cli2' },
        xml = { 'xmlformat' },
        yaml = { 'yamllint', 'prettier' },
        text = { 'autocorrect' },
        ['*'] = { 'autocorrect', 'codespell' },
        ['_'] = { 'trim_whitespace' },
        cs = { 'csharpier', 'clang_format' },
        ts = { 'prettier', 'eslint_d' },
        js = { 'prettier', 'eslint_d' },
        svelte = { 'prettier', 'eslint_d' },
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
    -- format_after_save = {
    --     lsp_format = 'fallback',
    --     timeout_ms = 500,
    -- },
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = '*',
    callback = function()
        larp.fn.map('n', '<leader>cf', function()
            conform.format({ lsp_fallback = true })
        end, { desc = 'Format Document' })
    end,
})
