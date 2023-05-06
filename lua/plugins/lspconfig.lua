---Setup LSP after attaching
---@param client any The LSP client
---@param bufnr any The neovim buffer
local function on_attach(client, bufnr)
	local merge_tables = require('config/util').merge_tables
	-- Common keymap options
	local opts = { noremap = true, buffer = bufnr }
	-- Configure Omnifunc
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	-- Keymaps
	-- LSP actions
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, merge_tables({ desc = 'Hover Documentation' }, opts))
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, merge_tables({ desc = '[R]ename' }, opts))
	vim.keymap.set(
		{ 'n', 'v' },
		'<leader>fa',
		vim.lsp.buf.code_action,
		merge_tables({ desc = '[F]ind Code [A]ctions' }, opts)
	)
	-- Add formatting keymap if supported
	if client.supports_method 'textDocument/formatting' then
		vim.keymap.set(
			'n',
			'<leader>w',
			function() vim.lsp.buf.format { async = true } end,
			merge_tables({ desc = 'Format Buffer' }, opts)
		)
	else
		vim.keymap.set(
			'n',
			'<leader>w',
			function() print 'Formating not supported for this language' end,
			merge_tables({ desc = '[Not Supported for filetype] Format Buffer' }, opts)
		)
	end
	-- LSP goto ...
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, merge_tables({ desc = '[G]o to [D]efinition' }, opts))
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, merge_tables({ desc = '[G]o to [T]ype Definition' }, opts))
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, merge_tables({ desc = '[G]o to [I]mplementation' }, opts))
end

return {
	{
		'neovim/nvim-lspconfig',
		name = 'lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'cmp',
			'mason',
			'mason-lspconfig',
		},
		config = function()
			local runtime_path = vim.split(package.path, ';')
			table.insert(runtime_path, 'lua/?.lua')
			table.insert(runtime_path, 'lua/?/init.lua')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require 'lspconfig'
			lspconfig['jsonls'].setup { on_attach = on_attach, capabilities = capabilities }
			lspconfig['ruff_lsp'].setup { on_attach = on_attach, capabilities = capabilities }
			lspconfig['serve_d'].setup { on_attach = on_attach, capabilities = capabilities }
			lspconfig['taplo'].setup { on_attach = on_attach, capabilities = capabilities }
			lspconfig['typst_lsp'].setup { on_attach = on_attach, capabilities = capabilities }
			lspconfig['lua_ls'].setup {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT', path = runtime_path },
						diagnostics = { globals = { 'vim', 'awesome', 'screen', 'client', 'root' } },
						workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}
			lspconfig['vimls'].setup { on_attach = on_attach, capabilities = capabilities }
		end,
	},

	{
		'saecki/crates.nvim',
		event = { 'BufRead Cargo.toml' },
		dependencies = { 'nvim-lua/plenary.nvim' },
		name = 'crates',
		config = true,
	},

	{
		'simrat39/rust-tools.nvim',
		ft = 'rust',
		name = 'rust-tools',
		dependencies = { 'cmp_nvim_lsp' },
		opts = function()
			return {
				server = {
					on_attach = on_attach,
					capabilities = require('cmp_nvim_lsp').default_capabilities(),
					settings = { ['rust-analyzer'] = { checkOnSave = { command = 'clippy' } } },
				},
			}
		end,
	},

	{
		'p00f/clangd_extensions.nvim',
		ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
		name = 'clangd_extensions',
		dependencies = { 'cmp_nvim_lsp' },
		opts = function()
			return {
				server = {
					on_attach = on_attach,
					capabilities = require('cmp_nvim_lsp').default_capabilities(),
				},
			}
		end,
	},

	{
		'kaarmu/typst.vim',
		ft = 'typst',
	},
}
