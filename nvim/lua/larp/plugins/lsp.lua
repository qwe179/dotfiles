return {
    {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {
            bind = true,
            handle_opts = {
                border = 'rounded',
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'mason-org/mason.nvim',
        opts = {},
        cmds = {
            'Mason',
            'MasonInstall',
            'MasonLog',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonUpdate'
        },
        keys = {
            { '<leader>mm', '<cmd>Mason<cr>', desc = 'Mason', silent = true },
        },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'vimls',
                'lua_ls',
                'rust_analyzer',
                'clangd',
            },
        },
        dependencies = {
            { 'mason-org/mason.nvim', opts = {} },
            'neovim/nvim-lspconfig',
        },
    },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup({
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
            require('cmp').setup.buffer({
                sources = {
                    { name = 'crates' },
                },
            })
        end,
    },
    {
        -- Better folding
        'kevinhwang91/nvim-ufo',
        event = 'BufRead',
        dependencies = { 'kevinhwang91/promise-async' },
        init = function()
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        config = function()
            require('custom.nvim-ufo')
        end,
    },
    {
        'neovim/nvim-lspconfig',
    },
    {
        -- Stops inactive LSP servers to free RAM
        'zeioth/garbage-day.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        opts = {},
    },
    {
        -- IDE-like breadcrumb navigation
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end,
    },
    {
        'stevearc/aerial.nvim',
        -- just to test symbols.nvim
        enabled = false,
        event = 'BufRead',
        opts = {},
        -- Optional dependencies
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },

        config = function()
            require('custom.aerial')
        end,
    },
    {
        -- Overview panel, something like aerial
        'oskarrrrrrr/symbols.nvim',
        cmds = {
            'Symbols',
            'SymbolsOpen',
            'SymbolsClose',
        },
        keys = {
            { '<leader>ts', mode = 'n', desc = 'Toggle Symbols' },
        },
        config = function()
            require('custom.symbols')
        end,
    },
    {
        'saghen/blink.cmp',
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            'rafamadriz/friendly-snippets',
            'mikavilpas/blink-ripgrep.nvim',
            'giuxtaposition/blink-cmp-copilot',
            'moyiz/blink-emoji.nvim',
        },

        -- use a release tag to download pre-built binaries
        version = 'v1.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- On musl libc based systems you need to add this flag
        -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
        config = function()
            require('custom.blink')
        end,
    },
    {
        -- Shows refernce and definition info above functions
        'VidocqH/lsp-lens.nvim',
        opts = {},
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
    },
    {
        'p00f/clangd_extensions.nvim',
        ft = { 'c', 'cpp' },
        opts = {},
    },
    {
        'pest-parser/pest.vim',
        ft = 'pest',
    },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        enabled = false,
        event = 'VeryLazy', -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
        end,
    },
    {
        'Civitasv/cmake-tools.nvim',
        opts = {},
    },
    {
        -- Formatter
        'stevearc/conform.nvim',
        config = function()
            require('custom.conform')
        end,
    },
}
