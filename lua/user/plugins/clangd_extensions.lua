local capabilities = require("user/lspconfig").capabilities
local on_attach = require("user/lspconfig").on_attach

local clangd_extensions = require "clangd_extensions"
if clangd_extensions ~= nil then
	clangd_extensions.setup {
		-- Send these options to NeoVim
		server = { on_attach = on_attach, capabilities = capabilities },
	}
end

