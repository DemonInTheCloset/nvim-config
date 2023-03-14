return {
	{
		'hood/popui.nvim',
		lazy = false,
		dependencies = { 'RishabhRD/popfix' },
		config = function()
			vim.ui.select = require 'popui.ui-overrider'
			vim.ui.input = require 'popui.input-overrider'
		end,
	},

	{
		'numToStr/FTerm.nvim',
		name = 'FTerm',
		keys = function()
			local ok, fterm = pcall(require, 'FTerm')
			if ok then
				---Ephemeral Terminal
				---@param opts table Table containing teminal configuration
				---@return function # Function that opens the terminal
				local function oneshot(opts)
					return function() fterm.scratch(opts) end
				end
				-- Keymaps
				return {
					{ '<leader>tt', fterm.toggle, desc = '[T]erminal [T]oggle' },
					{ '<leader>to', fterm.open, desc = '[T]erminal [O]pen' },
					{ '<leader>tc', fterm.close, desc = '[T]erminal [C]lose' },
					{ '<leader>te', fterm.exit, desc = '[T]erminal [E]xit' },
					{ '<leader>tg', oneshot { cmd = 'lazygit' }, desc = '[T]erminal lazy[G]it' },
				}
			end
		end,
		opts = {},
	},
}
