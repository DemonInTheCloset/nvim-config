local function on_attach(client, bufnr)
	-- Omnifunc
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Keymaps
	-- LSP actions
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, { noremap = true, buffer = bufnr })
	vim.keymap.set("v", "<leader>fa", vim.lsp.buf.range_code_action, { noremap = true, buffer = bufnr })

	-- Add formatting keymap if supported
	if client.supports_method("textDocument/formatting") then
		vim.keymap.set("n", "<leader>w", function()
			vim.lsp.buf.format({ async = true })
		end, { noremap = true, buffer = bufnr })
	else
		vim.keymap.set("n", "<leader>w", function()
			print("Formating not supported for this language")
		end, { noremap = true, buffer = bufnr })
	end

	-- LSP goto ...
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, buffer = bufnr })
end

return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		name = "null-ls",
		dependencies = { "mason" },
		opts = function()
			local null_ls = require("null-ls")

			return {
				sources = {
					null_ls.builtins.diagnostics.ruff,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.statix,
					null_ls.builtins.diagnostics.zsh,

					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.just,
					null_ls.builtins.formatting.nginx_beautifier,
					null_ls.builtins.formatting.nixpkgs_fmt,
					null_ls.builtins.formatting.ruff,
					null_ls.builtins.formatting.rustfmt,
					null_ls.builtins.formatting.shellharden,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.formatting.trim_whitespace,
					null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.zigfmt,

					null_ls.builtins.hover.printenv,
				},
			}
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"cmp",
			"mason",
			"mason-lspconfig",
		},
		config = function()
			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig["jsonls"].setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig["ruff_lsp"].setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig["serve_d"].setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT", path = runtime_path },
						diagnostics = { globals = { "vim", "awesome", "screen", "client", "root" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
			lspconfig["vimls"].setup({ on_attach = on_attach, capabilities = capabilities })
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		dependencies = {
			"mason",
		},
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer" },
			automatic_installation = true,
		},
	},

	{
		"williamboman/mason.nvim",
		name = "mason",
		cmd = "Mason",
	},

	{
		"onsails/lspkind.nvim",
		name = "lspkind",
	},

	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { "nvim-lua/plenary.nvim" },
		name = "crates",
	},

	{
		"simrat39/rust-tools.nvim",
		name = "rust-tools",
		dependencies = { "cmp_nvim_lsp" },
		opts = function()
			return {
				server = {
					on_attach = on_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
				},
			}
		end,
	},

	{
		"p00f/clangd_extensions.nvim",
		name = "clangd_extensions",
		dependencies = { "cmp_nvim_lsp" },
		opts = function()
			return {
				server = {
					on_attach = on_attach,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				},
			}
		end,
	},
}
