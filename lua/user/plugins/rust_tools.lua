local capabilities = require("user/lspconfig").capabilities
local on_attach = require("user/lspconfig").on_attach

-- [[ rust-tools ]]
local rust_tools = require "rust-tools"
rust_tools.setup {
	-- Send these options to NeoVim
	server = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
	},
}
