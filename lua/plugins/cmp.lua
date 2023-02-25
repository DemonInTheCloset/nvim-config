return {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    { 'saadparwaiz1/cmp_luasnip', dependencies = { 'luasnip' } },

    { 'hrsh7th/cmp-nvim-lsp',     name = 'cmp_nvim_lsp' },

    { 'onsails/lspkind.nvim',     name = 'lspkind' },

    {
        'hrsh7th/nvim-cmp',
        lazy = false,
        name = 'cmp',
        dependencies = { 'cmp_nvim_lsp', 'cmp-buffer', 'cmp-path', 'cmp-cmdline', 'cmp_luasnip', 'lspkind' },
        opts = function()
            local cmp = require 'cmp'
            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } },
            })
            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })
            -- cmp settings
            return {
                snippet = {
                    expand = function(args) require('luasnip').lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-b>'] = cmp.mapping.scroll_docs( -4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'crates' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                formatting = {
                    format = require('lspkind').cmp_format { mode = 'symbol', maxwidth = 50 },
                },
            }
        end,
    },
}