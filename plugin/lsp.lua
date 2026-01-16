-- LSP Configuration for Neovim 0.10.x (using nvim-lspconfig)
local lspconfig = require('lspconfig')

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text  = true,
    severity_sort = true,
    float         = {
        style  = 'minimal',
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
    },
    signs         = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN]  = '▲',
            [vim.diagnostic.severity.HINT]  = '⚑',
            [vim.diagnostic.severity.INFO]  = '»',
        },
    },
})

-- Add borders to floating windows
local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts            = opts or {}
    opts.border     = opts.border or 'rounded'
    opts.max_width  = opts.max_width or 80
    opts.max_height = opts.max_height or 24
    opts.wrap       = opts.wrap ~= false
    return orig(contents, syntax, opts, ...)
end

-- Shared capabilities with nvim-cmp
local caps = require("cmp_nvim_lsp").default_capabilities()

-- Keymaps and autoformat on LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        local buf = args.buf
        local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'gi', vim.lsp.buf.implementation)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gr', vim.lsp.buf.references)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', 'gl', vim.diagnostic.open_float)
        map('n', '<F2>', vim.lsp.buf.rename)
        map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
        map('n', '<F4>', vim.lsp.buf.code_action)

        -- Auto-format on save (excluding some filetypes)
        local excluded_filetypes = { php = true, c = true, cpp = true }
        if client.supports_method('textDocument/formatting')
            and not excluded_filetypes[vim.bo[buf].filetype]
        then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp.format.' .. buf, { clear = true }),
                buffer = buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})

-- Lua
lspconfig.lua_ls.setup({
    capabilities = caps,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = { enable = false },
        },
    },
})

-- CSS / SCSS / LESS
lspconfig.cssls.setup({
    capabilities = caps,
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
})

-- PHP (Intelephense)
lspconfig.intelephense.setup({
    capabilities = caps,
    settings = {
        intelephense = {
            files = {
                maxSize = 5000000,
            },
        },
    },
})

-- TypeScript / JavaScript
lspconfig.ts_ls.setup({
    capabilities = caps,
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
})

-- Zig
lspconfig.zls.setup({
    capabilities = caps,
    settings = {
        zls = {
            enable_build_on_save = true,
            build_on_save_step = "install",
            warn_style = false,
            enable_snippets = true,
        }
    }
})

-- Nix
lspconfig.nil_ls.setup({
    capabilities = caps,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "alejandra" }
            }
        }
    }
})

-- Rust
lspconfig.rust_analyzer.setup({
    capabilities = caps,
    settings = {
        ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            formatting = {
                command = { "rustfmt" }
            },
        },
    },
})

-- C / C++ (clangd)
lspconfig.clangd.setup({
    capabilities = caps,
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never',
        '--completion-style=detailed',
        '--query-driver=/nix/store/*-gcc-*/bin/gcc*,/nix/store/*-clang-*/bin/clang*,/run/current-system/sw/bin/cc*',
    },
    init_options = {
        fallbackFlags = { '-std=c23' },
    },
})

-- JSON
lspconfig.jsonls.setup({
    capabilities = caps,
})

-- Haskell
lspconfig.hls.setup({
    capabilities = caps,
    settings = {
        haskell = {
            formattingProvider = 'fourmolu',
            plugin = {
                semanticTokens = { globalOn = false }
            },
        },
    },
})

-- Filetype overrides
vim.filetype.add({
    extension = {
        h = 'c',
    },
})
