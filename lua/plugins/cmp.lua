return {
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',

	{ 'saadparwaiz1/cmp_luasnip', dependencies = { 'luasnip' } },

	{ 'hrsh7th/cmp-nvim-lsp', name = 'cmp_nvim_lsp' },

	{ 'onsails/lspkind.nvim', name = 'lspkind' },

	{
		'hrsh7th/nvim-cmp',
		lazy = false,
		name = 'cmp',
		dependencies = { 'cmp_nvim_lsp', 'cmp-buffer', 'cmp-path', 'cmp-cmdline', 'cmp_luasnip', 'lspkind' },
		opts = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			local has_words_before = function()
				-- unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
			end
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
					['<C-n>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-p>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<C-u>'] = cmp.mapping(function(fallback)
						if luasnip.choice_active() then
							luasnip.next_choice()
						else
							fallback()
						end
					end),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
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
