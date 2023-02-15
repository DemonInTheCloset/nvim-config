local capabilities = require("user/lspconfig").capabilities
local on_attach = require("user/lspconfig").on_attach

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require "lspconfig"
lspconfig["hls"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["jsonls"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["ruff_lsp"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["serve_d"].setup { on_attach = on_attach, capabilities = capabilities }
lspconfig["lua_ls"].setup {
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
