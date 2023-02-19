return {

	{
		"hrsh7th/cmp-nvim-lsp",
		name = "cmp_nvim_lsp",
	},

	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",

	{
		"hrsh7th/nvim-cmp",
		name = "cmp",
		dependencies = {
			"cmp_nvim_lsp",
			"cmp-buffer",
			"cmp-path",
			"cmp-cmdline",
			"cmp_luasnip",
			"lspkind",
		},
		opts = function()
			local cmp = require("cmp")
			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
            -- cmp settings
			return {
				snippet = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "crates" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({ with_text = false, maxwidth = 50 }),
				},
			}
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		name = "luasnip",
		opts = function()
			local luasnip = require("luasnip")
			-- Keymaps
			vim.keymap.set({ "i", "s" }, "<C-n>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, { silent = true, desc = "Expand/Jump to [N]ext" })
			vim.keymap.set({ "i", "s" }, "<C-p>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, { silent = true, desc = "Jump to [P]revious" })
			vim.keymap.set("i", "<C-u>", require("luasnip.extras.select_choice"), { desc = "Select Choice" })
			return { update_events = "TextChanged,TextChangedI" }
		end,
		config = function(_, opts)
			require("luasnip").config.setup(opts)
		end,
	},

	{ "saadparwaiz1/cmp_luasnip", dependencies = { "luasnip" } },
}
