local prequire = require("user.util").prequire

-- [[ LSP config ]] --
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local function on_attach(_, bufnr)
	-- Omnifunc
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Keymaps
	-- LSP actions
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "<leader>fa", vim.lsp.buf.code_action, { noremap = true, buffer = bufnr })
	vim.keymap.set(
		"v",
		"<leader>fa",
		vim.lsp.buf.range_code_action,
		{ noremap = true, buffer = bufnr }
	)

	-- LSP goto ...
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, buffer = bufnr })
end

local cmp_lsp = prequire "cmp_nvim_lsp"
local capabilities = cmp_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = prequire "lspconfig"

lspconfig["hls"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["jsonls"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["pylsp"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["serve_d"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["sumneko_lua"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = runtime_path },
			diagnostics = { globals = { "vim", "awesome", "screen", "client", "root" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
		},
	},
}
lspconfig["texlab"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["vimls"].setup { on_attach = on_attach, capabilities = capabilities }

-- [[ Language Specific Plugins ]]

-- [[ rust-tools ]]
local rust_tools = prequire "rust-tools"
rust_tools.setup {
	-- Send these options to NeoVim
	server = { on_attach = on_attach, capabilities = capabilities },
}

local clangd_extensions = prequire "clangd_extensions"
clangd_extensions.setup {
	-- Send these options to NeoVim
	server = { on_attach = on_attach, capabilities = capabilities },
}

-- [[ null_ls ]] --
local null_ls = prequire "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.latexindent,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.dfmt,
		null_ls.builtins.formatting.reorder_python_imports.with {
			extra_args = { "--application-directories=.:src" },
		},
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.taplo,

		null_ls.builtins.diagnostics.checkmake,
		null_ls.builtins.diagnostics.chktex,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.trail_space,
		-- null_ls.builtins.diagnostics.vulture,
		null_ls.builtins.diagnostics.zsh,

		null_ls.builtins.code_actions.shellcheck,
	},
	-- Format Keybinding
	on_attach = function(client, bufnr)
		if client.supports_method "textDocument/formatting" then
			vim.keymap.set(
				"n",
				"<leader>w",
				vim.lsp.buf.formatting_seq_sync,
				{ noremap = true, buffer = bufnr }
			)
		end
	end,
}

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
