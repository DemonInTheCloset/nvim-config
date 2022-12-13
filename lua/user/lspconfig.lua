local prequire = require("user/util").prequire

-- [[ LSP config constants ]] --
local capabilities = vim.lsp.protocol.make_client_capabilities()

local function on_attach(client, bufnr)
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

	-- Add formatting keymap if supported
	if client.supports_method "textDocument/formatting" then
		vim.keymap.set("n", "<leader>w", function()
			vim.lsp.buf.format { async = true }
		end, { noremap = true, buffer = bufnr })
	else
		vim.keymap.set("n", "<leader>w", function()
			print "Formating not supported for this language"
		end, { noremap = true, buffer = bufnr })
	end

	-- LSP goto ...
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { noremap = true, buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, buffer = bufnr })
end

local cmp_lsp = prequire "cmp_nvim_lsp"
if cmp_lsp ~= nil then
	capabilities = cmp_lsp.default_capabilities() or capabilities
end

return {
	on_attach = on_attach,
	capabilities = capabilities,
}
