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

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = prequire "cmp_nvim_lsp"
capabilities = cmp_lsp.update_capabilities(capabilities)

local lspconfig = prequire "lspconfig"

lspconfig["clangd"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["hls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["jsonls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["pyright"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
lspconfig["sumneko_lua"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim", "awesome", "screen", "client", "root" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
lspconfig["vimls"].setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
