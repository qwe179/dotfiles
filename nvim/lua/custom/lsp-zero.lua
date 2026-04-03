local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local blink = require('blink.cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format({ details = true })
cmp_format.format = require('lspkind').cmp_format({
    mode = 'symbol_text',
    maxwidth = 50,
    ellipsis_char = '...',
    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
        return vim_item
    end,
})

require('luasnip.loaders.from_vscode').lazy_load({
    paths = {
        vim.fn.stdpath('config') .. '/snippets',
    },
})

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
        exclude = {
            '<F1>',
            '<F2>',
            '<F3>',
            '<F4>',
        },
    })
    if client.server_capabilities.document_formatting then
        -- larp.fn.map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<cr>', { buffer = bufnr })
    end
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end)

local cap = require('cmp_nvim_lsp').default_capabilities()
cap.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
lsp_zero.extend_lspconfig({
    capabilities = cap,
})

local configs = require('lspconfig.configs')
if not configs.bpls then
    configs.bpls = {
        default_config = {
            cmd = { '/Users/ray/github/bpls/target/debug/bpls' },
            filetypes = { 'bp' },
            root_dir = function(fname)
                return require('lspconfig.util').root_pattern('.git')(fname) or vim.fn.getcwd()
            end,
            settings = {},
        },
    }
end
require('lspconfig').bpls.setup({})

lsp_zero.configure('bpls', {
    force_setup = true,
})
lsp_zero.setup({})

require('mason').setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
})

require('mason-lspconfig').setup({
    ensure_installed = {
        'vimls',
        'ts_ls',
        'bashls',
        'clangd',
        'marksman',
        'graphql',
    },
    automatic_installation = true,
    handlers = {
        function(server_name)
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require('lspconfig')[server_name].setup({
                capabilities = capabilities,
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })
        end,
        -- lua_ls = function()
        --     require('lspconfig').lua_ls.setup({
        --         on_init = function(client)
        --             lsp_zero.nvim_lua_settings(client, {})
        --         end,
        --     })
        -- end,
        rust_analyzer = lsp_zero.noop,
    },
})

local mason_registry = require('mason-registry')
-- local codelldb = mason_registry.get_package('codelldb')
-- local extension_path = codelldb:get_install_path() .. '/extension/'
-- local codelldb_path = extension_path .. 'adapter/codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.' .. (vim.fn.has('win32') == 1 and 'dll' or vim.fn.has('mac') == 1 and 'dylib' or 'so')
local cfg = require('rustaceanvim.config')
vim.g.rustaceanvim = {
    server = {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        default_settings = {
            ['rust-analyzer'] = {
                cmd = { '~/.cargo/bin/rust-analyzer' },
                cargo = {
                    allFeatures = true,
                },
                diagnostics = {
                    enable = true,
                    experimental = {
                        enable = true,
                    },
                },
            },
        },
    },
    -- dap = {
    --     adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    -- },
}
